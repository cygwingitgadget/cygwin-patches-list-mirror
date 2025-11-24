Return-Path: <SRS0=VJJm=6A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 0099F3858CB6
	for <cygwin-patches@cygwin.com>; Mon, 24 Nov 2025 13:56:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0099F3858CB6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0099F3858CB6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763992605; cv=none;
	b=goZwjrTiPxW/v0m5bTNfv+uYm5Y5GVOIOZzK7ola4KkECndkm10ZckBEd+XXTk8rIwaiAxphVPfXsDpyLlQJOmq8bJ2i/vD6X1vOVb+3NSJg/2b6b1gOMj31B1luhljWezb0aIDj942vCze42YuOMnR77OVL9HcMj1+dDwQdenM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763992605; c=relaxed/simple;
	bh=svayS8I25rB6Ay+s51QdILGcpP4/EsVzLGi8UjPQhoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Gdnyxn/1u39urcLqH9AwMVWwVWv1cSZ9q1sE/Tz9GaywuX8Ot6es7HVL6qGZ8daDiF0nEMfPlfu0fjniB8UeuNhMitlCCvwBGMariSyNzNjsbNutbh5oMa7Ai/6CjF9t4VqI52P5GFFTgmw1sBc8zUuw1vrtFkwbU987I5TSTYI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0099F3858CB6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FvCmlfE4
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20251124135642790.MDWO.61558.HP-Z230@nifty.com>;
          Mon, 24 Nov 2025 22:56:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Nahor <nahor.j+cygwin@gmail.com>,
	Corinna Vinshen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: flock: Do not access tmp_pathbuf already released
Date: Mon, 24 Nov 2025 22:56:23 +0900
Message-ID: <20251124135634.2264-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763992602;
 bh=rQxnjvOiE/0PTp1Lbj2FEK9XI7Ms2KTB5UVF/Ja1N4M=;
 h=From:To:Cc:Subject:Date;
 b=FvCmlfE40S3oBf+9G7w4E4rBG+zorI05fhrCjxbS7JaKh0LQQzyOhMyJ6qLZd+s7VsFpjM2L
 R94ijW+0j5Php2tDvmvCIKmAugIWNTtbeskpro1zra5dIZVo/dWubiRK7RZmR5gYP9QIhtssSL
 V4qbqXFV6BH+c4qK6MwWCmvNZUYSs9rMD6U6LALR0XC2YTwX8+zME1090cJnscEm5jOSOOO6I2
 K6Qlo1EN+GmZQcKLxIFfA+5Hz9sn+27v8qEwmPnc1ISABvZHAIsWJDa8rPadhnSDyZholU9llt
 Dq8lkkCAIMh04Axohn/P6C9qepUOOrc33vP9Ry7nsAn5n7CQ==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, variable i_all_lf was allocated and released in several
functions: lf_setlock(), lf_clearlock(), and lf_getlock(), and was
used only temporarily as noted in flock.cc. This pattern easily leads
to bugs like those that occurred in flock.cc, such as:

  lf_setlock()            lf_clearlock()

       |                       .
   i_all_lf = tp.w_get()       .
       |                       .
       +---------------------->+
                               |
                           i_all_lf = tp.wget()
                               |
                           do something
                               |
                           (release i_all_lf implicitly)
                               |
       +<----------------------+
       |
   accessing i_all_lf (may destroy tmp_pathbuf area)
       |

With this patch, to fix and prevent the bugs, move i_all_lf from
each function that uses it to fhaldler_base::lock(). Moreover, move
get_all_locks_list() call in lf_clearlock() to fhandler_base::lock()
to avoid calling the function twice. Furthermore, make i_all_lf local
variable rather than inode_t member to prevent reentrant(?) problem.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
Fixes: e181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
Reported-by: Nahor <nahor.j+cygwin@gmail.com>
Co-authored-by: Corinna Vinshen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 55 +++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e03caba27..7cb2bc219 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -264,7 +264,6 @@ class lockf_t
     /* Used to store own lock list in the cygheap. */
     void *operator new (size_t size)
     { return cmalloc (HEAP_FHANDLER, sizeof (lockf_t)); }
-    /* Never call on node->i_all_lf! */
     void operator delete (void *p)
     { cfree (p); }
 
@@ -285,7 +284,6 @@ class inode_t
   public:
     LIST_ENTRY (inode_t) i_next;
     lockf_t		*i_lockf;  /* List of locks of this process. */
-    lockf_t		*i_all_lf; /* Temp list of all locks for this file. */
 
     dev_t		 i_dev;    /* Device ID */
     ino_t		 i_ino;    /* inode number */
@@ -318,7 +316,7 @@ class inode_t
 
     void unlock_and_remove_if_unused ();
 
-    lockf_t *get_all_locks_list ();
+    lockf_t *get_all_locks_list (lockf_t *);
     uint32_t get_lock_count () /* needs get_all_locks_list() */
     { return i_lock_cnt; }
 
@@ -503,7 +501,7 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
 }
 
 inode_t::inode_t (dev_t dev, ino_t ino)
-: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
+: i_lockf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
   i_lock_cnt (0)
 {
   HANDLE parent_dir;
@@ -532,8 +530,8 @@ inode_t::inode_t (dev_t dev, ino_t ino)
 }
 
 /* Enumerate all lock event objects for this file and create a lockf_t
-   list in the i_all_lf member.  This list is searched in lf_getblock
-   for locks which potentially block our lock request. */
+   list in the i_all_lf.  This list is searched in lf_getblock for locks
+   which potentially block our lock request. */
 
 /* Number of lockf_t structs which fit in the temporary buffer. */
 #define MAX_LOCKF_CNT	((intptr_t)((NT_MAX_PATH * sizeof (WCHAR)) \
@@ -580,7 +578,7 @@ lockf_t::from_obj_name (inode_t *node, lockf_t **head, const wchar_t *name)
 }
 
 lockf_t *
-inode_t::get_all_locks_list ()
+inode_t::get_all_locks_list (lockf_t *i_all_lf)
 {
   tmp_pathbuf tp;
   ULONG context;
@@ -931,9 +929,9 @@ static int maxlockdepth = MAXDEPTH;
 #define OTHERS  0x2
 static int      lf_clearlock (lockf_t *, lockf_t **, HANDLE);
 static int      lf_findoverlap (lockf_t *, lockf_t *, int, lockf_t ***, lockf_t **);
-static lockf_t *lf_getblock (lockf_t *, inode_t *node);
-static int      lf_getlock (lockf_t *, inode_t *, struct flock *);
-static int      lf_setlock (lockf_t *, inode_t *, lockf_t **, HANDLE);
+static lockf_t *lf_getblock (lockf_t *, inode_t *node, lockf_t *);
+static int      lf_getlock (lockf_t *, inode_t *, struct flock *, lockf_t *);
+static int      lf_setlock (lockf_t *, inode_t *, lockf_t **, HANDLE, lockf_t *);
 static void     lf_split (lockf_t *, lockf_t *, lockf_t **);
 static void     lf_wakelock (lockf_t *, HANDLE);
 
@@ -945,6 +943,7 @@ fhandler_base::lock (int a_op, struct flock *fl)
 {
   off_t start, end, oadd;
   int error = 0;
+  tmp_pathbuf tp;
 
   short a_flags = fl->l_type & (F_OFD | F_POSIX | F_FLOCK);
   short type = fl->l_type & (F_RDLCK | F_WRLCK | F_UNLCK);
@@ -1149,14 +1148,22 @@ restart:	/* Entry point after a restartable signal came in. */
       return -1;
     }
 
+  /* Create temporary space for the all locks list. */
+  lockf_t *i_all_lf = (lockf_t *) tp.w_get ();
+
   switch (a_op)
     {
     case F_SETLK:
     case F_OFD_SETLK:
-      error = lf_setlock (lock, node, &clean, get_handle ());
+      error = lf_setlock (lock, node, &clean, get_handle (), i_all_lf);
       break;
 
     case F_UNLCK:
+      /* lf_createlock() is called from here as well as from lf_setlock().
+	 lf_setlock() already calls get_all_locks_list(), so we don't call it
+	 from lf_clearlock() but rather here to avoid calling the (potentially
+	 timeconsuming) function twice in called through lf_setlock(). */
+      node->get_all_locks_list (i_all_lf);
       error = lf_clearlock (lock, &clean, get_handle ());
       lock->lf_next = clean;
       clean = lock;
@@ -1164,7 +1171,7 @@ restart:	/* Entry point after a restartable signal came in. */
 
     case F_GETLK:
     case F_OFD_GETLK:
-      error = lf_getlock (lock, node, fl);
+      error = lf_getlock (lock, node, fl, i_all_lf);
       lock->lf_next = clean;
       clean = lock;
       break;
@@ -1212,13 +1219,13 @@ restart:	/* Entry point after a restartable signal came in. */
  * Set a byte-range lock.
  */
 static int
-lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
+lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl,
+	    lockf_t *i_all_lf)
 {
   lockf_t *block;
   lockf_t **head = lock->lf_head;
   lockf_t **prev, *overlap;
   int ovcase, priority, old_prio, needtolink;
-  tmp_pathbuf tp;
 
   /*
    * Set the priority
@@ -1229,9 +1236,7 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   /*
    * Scan lock list for this file looking for locks that would block us.
    */
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
-  while ((block = lf_getblock(lock, node)))
+  while ((block = lf_getblock(lock, node, i_all_lf)))
     {
       HANDLE obj = block->lf_obj;
       block->lf_obj = NULL;
@@ -1365,7 +1370,7 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
    *
    * Handle any locks that overlap.
    */
-  node->get_all_locks_list (); /* Update lock count */
+  node->get_all_locks_list (i_all_lf); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   /* lf_clearlock() sometimes increases the number of locks. Without
      this room, the unlocking will never succeed in some situation. */
@@ -1543,9 +1548,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
     return 0;
 
   inode_t *node = lf->lf_inode;
-  tmp_pathbuf tp;
-  node->i_all_lf = (lockf_t *) tp.w_get ();
-  node->get_all_locks_list (); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   bool first_loop = true;
 
@@ -1628,14 +1630,11 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
  * and if so return its process identifier.
  */
 static int
-lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
+lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl, lockf_t *i_all_lf)
 {
   lockf_t *block;
-  tmp_pathbuf tp;
 
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void * ) tp.w_get ();
-  if ((block = lf_getblock (lock, node)))
+  if ((block = lf_getblock (lock, node, i_all_lf)))
     {
       if (block->lf_obj)
 	block->close_lock_obj ();
@@ -1661,10 +1660,10 @@ lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
  * return the first blocking lock.
  */
 static lockf_t *
-lf_getblock (lockf_t *lock, inode_t *node)
+lf_getblock (lockf_t *lock, inode_t *node, lockf_t *i_all_lf)
 {
   lockf_t **prev, *overlap;
-  lockf_t *lf = node->get_all_locks_list ();
+  lockf_t *lf = node->get_all_locks_list (i_all_lf);
   int ovcase;
 
   prev = lock->lf_head;
-- 
2.51.0

