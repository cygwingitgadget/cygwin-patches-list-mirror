Return-Path: <SRS0=4N44=6B=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 44A603858408
	for <cygwin-patches@cygwin.com>; Tue, 25 Nov 2025 02:29:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 44A603858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 44A603858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1764037768; cv=none;
	b=BwOSdtQsTYXDonbh/MTFEYGQje+wKlFOEG5b0fuxwqRUaIzG98jx6EjUgLC5BW24GngJciTvc+nmRRdefYIao/pnfF7GIFXtOkAho8wNG0a58lzVXnxyc4sWyV/M8124BjkhUvMT/KB7PTNrI+EE54k3uUj9qNGdLjRNWFtvO7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1764037768; c=relaxed/simple;
	bh=HI2tSm3QGn9bGWncZ6GKNA794PdpYFia/yutm3FX3dk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=uLJJ64mI4otU8lb1XfIxVPC8xsMXj7J4yz612NCILg1fcny/tgdt/RIRCmkcZ/cDk9COc9hCG0xgehhA2YfFqVibQig/PhxUF1p3ixDj1wLDdqB8KASasYzksHtUSt8AzLzxp4071qpWJcGv31OonF+8GQI05jyjuJLHOBNootM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 44A603858408
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Zk6F9dVd
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251125022922781.FJEN.17135.HP-Z230@nifty.com>;
          Tue, 25 Nov 2025 11:29:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Nahor <nahor.j+cygwin@gmail.com>,
	Corinna Vinshen <corinna@vinschen.de>
Subject: [PATCH v3] Cygwin: flock: Do not access tmp_pathbuf already released
Date: Tue, 25 Nov 2025 11:28:11 +0900
Message-ID: <20251125022915.781-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1764037762;
 bh=E4uAUJCA0LaihSk/wyIdOdR3Zi3n4tWq2de6MxQquC4=;
 h=From:To:Cc:Subject:Date;
 b=Zk6F9dVdBR1bStWuVTSc4jY2LS+NKP2TqajXo7wUNybdUXvJYjHVxmTvUXd6KcooP+J36HIC
 ifdCRxw2tfji0oVTe5Eanfkjn0pjs0GqukOVpaWqcV+wSbbvMf2yp6vk7MqFgbNc4OQ8vghMzn
 CgBBKx/kLYvLQ5Yx82tyGVzmbFa+s3EmxtJTECdLsugssOgGerdpB3nhFxZErsdCvwuUm8EJU3
 KSox98P42DX4SSBxjeA/z6HXRlo3MeGnAYUSx/gZGt6x0wO8+o4NtQ/fgn5MNY/GaQBbS4c9RV
 wEo/QAQOaTckGdb9wwuY3md/9a05tk9ZBcaVXQ7TY0VZ70tQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
       |                       .
   accessing i_all_lf (may destroy tmp_pathbuf area)
       |                       .

The similar problem also happens in multi-thread case.

With this patch, to fix and prevent the bugs, make i_all_lf non-
temporary and allocate/free in constructor/destructor of inode_t.
To prevent inter-thread-access-conflicts in i_all_lf list,
inode_t::get_all_locks_list() is guarded by inode_t::LOCK().
In addition, move get_all_locks_list() call in lf_clearlock() to
fhandler_base::lock() to avoid calling the function twice.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
Reported-by: Nahor <nahor.j+cygwin@gmail.com>
Co-authored-by: Corinna Vinshen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e03caba27..9e0101965 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -264,7 +264,6 @@ class lockf_t
     /* Used to store own lock list in the cygheap. */
     void *operator new (size_t size)
     { return cmalloc (HEAP_FHANDLER, sizeof (lockf_t)); }
-    /* Never call on node->i_all_lf! */
     void operator delete (void *p)
     { cfree (p); }
 
@@ -285,7 +284,7 @@ class inode_t
   public:
     LIST_ENTRY (inode_t) i_next;
     lockf_t		*i_lockf;  /* List of locks of this process. */
-    lockf_t		*i_all_lf; /* Temp list of all locks for this file. */
+    lockf_t		*i_all_lf; /* List of all locks for this file. */
 
     dev_t		 i_dev;    /* Device ID */
     ino_t		 i_ino;    /* inode number */
@@ -327,6 +326,7 @@ class inode_t
 
 inode_t::~inode_t ()
 {
+  free (i_all_lf);
   lockf_t *lock, *n_lock;
   for (lock = i_lockf; lock && (n_lock = lock->lf_next, 1); lock = n_lock)
     delete lock;
@@ -502,6 +502,14 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
   return node;
 }
 
+/* Enumerate all lock event objects for this file and create a lockf_t
+   list in the i_all_lf.  This list is searched in lf_getblock for locks
+   which potentially block our lock request. */
+
+/* Number of lockf_t structs which fit in the i_all_lf buffer. */
+#define MAX_LOCKF_CNT	((intptr_t)((NT_MAX_PATH * sizeof (WCHAR)) \
+				    / sizeof (lockf_t)))
+
 inode_t::inode_t (dev_t dev, ino_t ino)
 : i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
   i_lock_cnt (0)
@@ -529,16 +537,11 @@ inode_t::inode_t (dev_t dev, ino_t ino)
   status = NtCreateMutant (&i_mtx, CYG_MUTANT_ACCESS, &attr, FALSE);
   if (!NT_SUCCESS (status))
     api_fatal ("NtCreateMutant(inode): %y", status);
+  i_all_lf = (lockf_t *) malloc (MAX_LOCKF_CNT * sizeof (lockf_t));
+  if (!i_all_lf)
+    api_fatal ("Allocating lock list memory failed.");
 }
 
-/* Enumerate all lock event objects for this file and create a lockf_t
-   list in the i_all_lf member.  This list is searched in lf_getblock
-   for locks which potentially block our lock request. */
-
-/* Number of lockf_t structs which fit in the temporary buffer. */
-#define MAX_LOCKF_CNT	((intptr_t)((NT_MAX_PATH * sizeof (WCHAR)) \
-				    / sizeof (lockf_t)))
-
 bool
 lockf_t::from_obj_name (inode_t *node, lockf_t **head, const wchar_t *name)
 {
@@ -1157,6 +1160,11 @@ restart:	/* Entry point after a restartable signal came in. */
       break;
 
     case F_UNLCK:
+      /* lf_createlock() is called from here as well as from lf_setlock().
+	 lf_setlock() already calls get_all_locks_list(), so we don't call it
+	 from lf_clearlock() but rather here to avoid calling the (potentially
+	 timeconsuming) function twice in called through lf_setlock(). */
+      node->get_all_locks_list ();
       error = lf_clearlock (lock, &clean, get_handle ());
       lock->lf_next = clean;
       clean = lock;
@@ -1218,7 +1226,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   lockf_t **head = lock->lf_head;
   lockf_t **prev, *overlap;
   int ovcase, priority, old_prio, needtolink;
-  tmp_pathbuf tp;
 
   /*
    * Set the priority
@@ -1229,8 +1236,6 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
   /*
    * Scan lock list for this file looking for locks that would block us.
    */
-  /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
   while ((block = lf_getblock(lock, node)))
     {
       HANDLE obj = block->lf_obj;
@@ -1282,6 +1287,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  lock->lf_type = F_WRLCK;
 	}
 
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
2.51.0

