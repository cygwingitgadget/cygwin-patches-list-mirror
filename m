Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CB3223858C31; Mon, 24 Nov 2025 13:09:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB3223858C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763989746;
	bh=HC3tWBobtyZUG33bN4m6MF2URM3yzzCUoQFGiWu/pVw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Wq+7xu1wZcA6CTGlF4wrU9Ro+O7kE7kRGrnQhxU/E2XQ8xi8OPZSbmcNLVCJKGTrL
	 eGh9Khid8p4v8xwAg+O4FPehNzfbiwLG0lhXZtLyCpIZBnjDXI4CQVQQLovR96uotw
	 m3aXfeKeoD+bI0jgUuJAo6k+d5xrdGERcXeaQJx8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8F4C9A80A5E; Mon, 24 Nov 2025 14:09:03 +0100 (CET)
Date: Mon, 24 Nov 2025 14:09:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Message-ID: <aSRY7wyUJFby7XHZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
 <aSRKB6KpYHIViSD_@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSRKB6KpYHIViSD_@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 24 13:05, Corinna Vinschen wrote:
> So I wonder...
> 
> Wouldn't this simple patch just moving the tmp_pathbuf up into
> fhandler_base::lock() fix the problem just as well, plus avoiding
> multiple w_get() calls?

Version 2 of the patch.  Rather than calling get_all_locks_list()
from lf_setlock() *and* lf_clearlock(), call it right from
fhandler_base::lock() to avoid calling the function twice.
Also, move comment.

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e03caba27a8e..e486ad7f5ece 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -945,6 +945,7 @@ fhandler_base::lock (int a_op, struct flock *fl)
 {
   off_t start, end, oadd;
   int error = 0;
+  tmp_pathbuf tp;
 
   short a_flags = fl->l_type & (F_OFD | F_POSIX | F_FLOCK);
   short type = fl->l_type & (F_RDLCK | F_WRLCK | F_UNLCK);
@@ -1149,6 +1150,9 @@ restart:	/* Entry point after a restartable signal came in. */
       return -1;
     }
 
+  /* Create temporary space for the all locks list. */
+  node->i_all_lf = (lockf_t *) tp.w_get ();
+
   switch (a_op)
     {
     case F_SETLK:
@@ -1157,6 +1161,11 @@ restart:	/* Entry point after a restartable signal came in. */
       break;
 
     case F_UNLCK:
+      /* lf_clearlock() is called from here as well as from lf_setlock().
+	 lf_setlock() already calls get_all_locks_list(), so we don't call it
+	 from lf_clearlock() but rather here to avoid calling the (potentially
+	 timeconsuming) function twice if called through lf_setlock(). */
+      node->get_all_locks_list ();
       error = lf_clearlock (lock, &clean, get_handle ());
       lock->lf_next = clean;
       clean = lock;
@@ -1218,7 +1227,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   lockf_t **head = lock->lf_head;
   lockf_t **prev, *overlap;
   int ovcase, priority, old_prio, needtolink;
-  tmp_pathbuf tp;
 
   /*
    * Set the priority
@@ -1229,8 +1237,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   /*
    * Scan lock list for this file looking for locks that would block us.
    */
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
   while ((block = lf_getblock(lock, node)))
     {
       HANDLE obj = block->lf_obj;
@@ -1543,9 +1549,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
     return 0;
 
   inode_t *node = lf->lf_inode;
-  tmp_pathbuf tp;
-  node->i_all_lf = (lockf_t *) tp.w_get ();
-  node->get_all_locks_list (); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   bool first_loop = true;
 
@@ -1631,10 +1634,7 @@ static int
 lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
 {
   lockf_t *block;
-  tmp_pathbuf tp;
 
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void * ) tp.w_get ();
   if ((block = lf_getblock (lock, node)))
     {
       if (block->lf_obj)
