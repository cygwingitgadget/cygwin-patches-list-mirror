Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 17FA73858D26; Mon, 24 Nov 2025 12:05:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17FA73858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1763985930;
	bh=OwYAY69DalpZLjvsCU0luc8d0EpD1lb1zT79kpMyd0c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NJnOm4HC9Vhs8rWx7h+uH2qEc1iu5aFQn9sa2N6VE1R+wJspN39XcPZea5SEPXmQZ
	 u9dlSMl08ByagIDTiDQuaWJUCjTjCt1RdvANXOabtiz8W1X51kxF7S9m8XRrlD3ICS
	 P8XnBc2k1HBa8EGysmP+rckodEgCkt1KZQNR4Pzk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2E653A80A5E; Mon, 24 Nov 2025 13:05:27 +0100 (CET)
Date: Mon, 24 Nov 2025 13:05:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Message-ID: <aSRKB6KpYHIViSD_@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Nov 24 12:30, Takashi Yano wrote:
> Previously, variable i_all_lf was a member of inode_t even though
> it is used only temporarily as commented in flock.cc.
> This easily leads to bugs like those that occurred in flock.cc,
> such as:
> 
>   lf_setlock()            lf_clearlock()
> 
>        |                       .
>    i_all_lf = tp.w_get()       .
>        |                       .
>        +---------------------->+
>                                |
>                            i_all_lf = tp.wget()
>                                |
>                            do something
>                                |
>                            (release i_all_lf implicitly)
>                                |
>        +<----------------------+
>        |
>    accessing i_all_lf (may destroy tmp_pathbuf area)
>        |
> 
> With this patch, to fix and prevent the bugs, move i_all_lf from a
> member of inode_t to a local (auto) variable in each function that
> uses it.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
> Fixes: a998dd705576 ("* flock.cc: Implement all advisory file locking here.")

Thanks for tracking this down, this is great.

However, this problem hasn't been introduced by a998dd705576, but rather
by ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too
many locks") last year.

The reason is that, up to this point, lf_clearlock() did not have to
access inode_t::i_all_lf at all.  Rather, initialization and destruction
were contained within lf_setlock() and lf_getlock(). But lf_clearlock()
isn't called from fhandler_base::lock() alone.

Now (i.e. after ae181b0ff122) that lf_clearlock() requires the buffer as
well, all basic lock functions called from fhandler_base::lock() require
the buffer.

So I wonder...

Wouldn't this simple patch just moving the tmp_pathbuf up into
fhandler_base::lock() fix the problem just as well, plus avoiding
multiple w_get() calls?

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e03caba27a8e..3f43c4fe352f 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -945,6 +945,7 @@ fhandler_base::lock (int a_op, struct flock *fl)
 {
   off_t start, end, oadd;
   int error = 0;
+  tmp_pathbuf tp;
 
   short a_flags = fl->l_type & (F_OFD | F_POSIX | F_FLOCK);
   short type = fl->l_type & (F_RDLCK | F_WRLCK | F_UNLCK);
@@ -1149,6 +1150,8 @@ restart:	/* Entry point after a restartable signal came in. */
       return -1;
     }
 
+  node->i_all_lf = (lockf_t *) tp.w_get ();
+
   switch (a_op)
     {
     case F_SETLK:
@@ -1218,7 +1221,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   lockf_t **head = lock->lf_head;
   lockf_t **prev, *overlap;
   int ovcase, priority, old_prio, needtolink;
-  tmp_pathbuf tp;
 
   /*
    * Set the priority
@@ -1230,7 +1232,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
    * Scan lock list for this file looking for locks that would block us.
    */
   /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
   while ((block = lf_getblock(lock, node)))
     {
       HANDLE obj = block->lf_obj;
@@ -1543,8 +1544,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
     return 0;
 
   inode_t *node = lf->lf_inode;
-  tmp_pathbuf tp;
-  node->i_all_lf = (lockf_t *) tp.w_get ();
   node->get_all_locks_list (); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   bool first_loop = true;
@@ -1631,10 +1630,8 @@ static int
 lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
 {
   lockf_t *block;
-  tmp_pathbuf tp;
 
   /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void * ) tp.w_get ();
   if ((block = lf_getblock (lock, node)))
     {
       if (block->lf_obj)
