Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8A28338582AB; Tue, 25 Nov 2025 14:49:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8A28338582AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764082166;
	bh=7pC5IYEG7D+VUOh8PAupSgoewLwTY7kGVcrvkLImbeg=;
	h=From:To:Subject:Date:From;
	b=vmJ3VMCnNQspubAhWPf0KyNkdHK00TloLdTQzteArwnVYkLVXGjyDDq9q2SECcHEr
	 YEoPbIZnQXx9fPBau4FZWWbPCWk3OMS3hYGM76sGLR7FXVcutYaY57naH0vrYBlM2R
	 8TXiLoJJV3f5igFt4q0zeDiwI4lJFzHudIxIcqbQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C7031A80556; Tue, 25 Nov 2025 15:49:24 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4] Cygwin: flock: allocate i_all_lf as static array
Date: Tue, 25 Nov 2025 15:49:24 +0100
Message-ID: <20251125144924.2050628-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Takashi Yano <takashi.yano@nifty.ne.jp>

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
       |                       .
   accessing i_all_lf (may destroy tmp_pathbuf area)
       |                       .

The similar problem also happens in multi-thread case.

Fix and prevent the bugs by converting i_all_lf to a pointer pointing
to a static array in the inode_t class.  Given inodes are allocated on
the cygheap, reduce MAX_LOCKF_CNT by one so an inode_t fits into a 64K
chunk.

Avoid accessing the all locks list outside of locking and move
get_all_locks_list() call in lf_clearlock() to fhandler_base::lock()
to avoid calling the function twice.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many
locks")
Reported-by: Nahor <nahor.j+cygwin@gmail.com>
Co-authored-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/flock.cc | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e03caba27a8e..742e0e8543f8 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -264,7 +264,6 @@ class lockf_t
     /* Used to store own lock list in the cygheap. */
     void *operator new (size_t size)
     { return cmalloc (HEAP_FHANDLER, sizeof (lockf_t)); }
-    /* Never call on node->i_all_lf! */
     void operator delete (void *p)
     { cfree (p); }
 
@@ -277,6 +276,10 @@ class lockf_t
     void del_lock_obj (HANDLE fhdl, bool signal = false);
 };
 
+/* Number of lockf_t structs which fit in the temporary buffer. */
+#define MAX_LOCKF_CNT	((intptr_t)((NT_MAX_PATH * sizeof (WCHAR)) \
+				    / sizeof (lockf_t)) - 1)
+
 /* Per inode_t class */
 class inode_t
 {
@@ -285,7 +288,9 @@ class inode_t
   public:
     LIST_ENTRY (inode_t) i_next;
     lockf_t		*i_lockf;  /* List of locks of this process. */
-    lockf_t		*i_all_lf; /* Temp list of all locks for this file. */
+				   /* list of all locks for this file. */
+    lockf_t		*i_all_lf;
+    lockf_t		 i_all[MAX_LOCKF_CNT];
 
     dev_t		 i_dev;    /* Device ID */
     ino_t		 i_ino;    /* inode number */
@@ -503,7 +508,7 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
 }
 
 inode_t::inode_t (dev_t dev, ino_t ino)
-: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
+: i_lockf (NULL), i_all_lf (i_all), i_dev (dev), i_ino (ino), i_cnt (0L),
   i_lock_cnt (0)
 {
   HANDLE parent_dir;
@@ -535,10 +540,6 @@ inode_t::inode_t (dev_t dev, ino_t ino)
    list in the i_all_lf member.  This list is searched in lf_getblock
    for locks which potentially block our lock request. */
 
-/* Number of lockf_t structs which fit in the temporary buffer. */
-#define MAX_LOCKF_CNT	((intptr_t)((NT_MAX_PATH * sizeof (WCHAR)) \
-				    / sizeof (lockf_t)))
-
 bool
 lockf_t::from_obj_name (inode_t *node, lockf_t **head, const wchar_t *name)
 {
@@ -1157,6 +1158,11 @@ restart:	/* Entry point after a restartable signal came in. */
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
@@ -1218,7 +1224,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   lockf_t **head = lock->lf_head;
   lockf_t **prev, *overlap;
   int ovcase, priority, old_prio, needtolink;
-  tmp_pathbuf tp;
 
   /*
    * Set the priority
@@ -1229,8 +1234,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   /*
    * Scan lock list for this file looking for locks that would block us.
    */
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
   while ((block = lf_getblock(lock, node)))
     {
       HANDLE obj = block->lf_obj;
@@ -1282,6 +1285,10 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  lock->lf_type = F_WRLCK;
 	}
 
+      /* Copy Windows PID to local var so we don't access the all locks
+	 list outside of locking. */
+      DWORD lf_wid = block->lf_wid;
+
       /*
        * Add our lock to the blocked list and sleep until we're free.
        * Remember who blocked us (for deadlock detection).
@@ -1298,7 +1305,7 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
       HANDLE proc = NULL;
       if (lock->lf_flags & F_POSIX)
 	{
-	  proc = OpenProcess (SYNCHRONIZE, FALSE, block->lf_wid);
+	  proc = OpenProcess (SYNCHRONIZE, FALSE, lf_wid);
 	  if (!proc)
 	    timeout = 0L;
 	  else
@@ -1543,9 +1550,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
     return 0;
 
   inode_t *node = lf->lf_inode;
-  tmp_pathbuf tp;
-  node->i_all_lf = (lockf_t *) tp.w_get ();
-  node->get_all_locks_list (); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   bool first_loop = true;
 
@@ -1631,10 +1635,7 @@ static int
 lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
 {
   lockf_t *block;
-  tmp_pathbuf tp;
 
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void * ) tp.w_get ();
   if ((block = lf_getblock (lock, node)))
     {
       if (block->lf_obj)
-- 
2.51.1

