Return-Path: <SRS0=VJJm=6A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id C4DCE3858C54
	for <cygwin-patches@cygwin.com>; Mon, 24 Nov 2025 03:30:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C4DCE3858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C4DCE3858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763955060; cv=none;
	b=qrAWD+1FQZ50Yiym3gfIyIfZYXQrP0w4uXEENipZSx63/hCLPiorj/Kefe4mNVYTeLAeWyD892ePgMOR9IV9QDoXhVl7Vv6kOIp9xuKSuTrlnQwE60RoJa8RlFpeSbTA923flGaJToTp+CXRSDLVxwrgVPeZHl9w4TJxCwBfOzA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763955060; c=relaxed/simple;
	bh=lGlYw7QdR5mZnExRqOa5o9ib6uwEAiRKQ9edVxfffTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=FaL2U9siHHipSPSrHamlEjfUi9COQbR7SkJhptXuOv6xAJAVC0AUI7kdr6+9TNMGDr/byYlr+8mbZcKNncdwqNj7nT9udQXfcmGts8kp6wmjwHmCi5ZALuwkLYstrAPpWiQymoN7CqEtEnhojBhGvLMeQtyBZX910oVSDspORnE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C4DCE3858C54
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XoLaso0E
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20251124033057496.JRZ.19957.HP-Z230@nifty.com>;
          Mon, 24 Nov 2025 12:30:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Nahor <nahor.j+cygwin@gmail.com>
Subject: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Date: Mon, 24 Nov 2025 12:30:16 +0900
Message-ID: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763955057;
 bh=Ub2wW8Jiqj9Yj17jxGGuOrzFn2KtOtXPBZYIQ+LXHQg=;
 h=From:To:Cc:Subject:Date;
 b=XoLaso0EcqhC/mTRfitMOObKLB0tTIJZe9/o3ljC8OZBTq0r3Xa9ii8pm705bWwJy5qxJHsm
 JRIt0/gu/jhUZ8hM0fOhPSkbwYlxgRFwIbwfC1XRgA+op6wXWuBxOE6BsN5IBwhJ8uQCE/92gC
 J9G2mT4EGXhaKJak0UttpEiExUXa/W6NsFgr+30lTAnEfazPBMK4Ka0pmI3nsxXm+fAeqD6GuP
 IxktRjR10vFc/Y0XsOwhYwGjC9XItgTmoVDl41voYsGCL71ElHg+YZ1jI5BinPwTZdI/gCGCqZ
 vQC1SQiOKUnT1ZtcHevDSS1We7OQodc6FLqCmQR+t/vbLKxw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, variable i_all_lf was a member of inode_t even though
it is used only temporarily as commented in flock.cc.
This easily leads to bugs like those that occurred in flock.cc,
such as:

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

With this patch, to fix and prevent the bugs, move i_all_lf from a
member of inode_t to a local (auto) variable in each function that
uses it.

Addresses: https://cygwin.com/pipermail/cygwin/2025-October/258914.html
Fixes: a998dd705576 ("* flock.cc: Implement all advisory file locking here.")
Reported-by: Nahor <nahor.j+cygwin@gmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e03caba27..356a8f920 100644
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
@@ -580,7 +578,7 @@ lockf_t::from_obj_name (inode_t *node, lockf_t **head, const wchar_t *name)
 }
 
 lockf_t *
-inode_t::get_all_locks_list ()
+inode_t::get_all_locks_list (lockf_t *i_all_lf)
 {
   tmp_pathbuf tp;
   ULONG context;
@@ -931,7 +929,7 @@ static int maxlockdepth = MAXDEPTH;
 #define OTHERS  0x2
 static int      lf_clearlock (lockf_t *, lockf_t **, HANDLE);
 static int      lf_findoverlap (lockf_t *, lockf_t *, int, lockf_t ***, lockf_t **);
-static lockf_t *lf_getblock (lockf_t *, inode_t *node);
+static lockf_t *lf_getblock (lockf_t *, inode_t *node, lockf_t *);
 static int      lf_getlock (lockf_t *, inode_t *, struct flock *);
 static int      lf_setlock (lockf_t *, inode_t *, lockf_t **, HANDLE);
 static void     lf_split (lockf_t *, lockf_t *, lockf_t **);
@@ -1230,8 +1228,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
    * Scan lock list for this file looking for locks that would block us.
    */
   /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void *) tp.w_get ();
-  while ((block = lf_getblock(lock, node)))
+  lockf_t *i_all_lf = (lockf_t *) (void *) tp.w_get ();
+  while ((block = lf_getblock(lock, node, i_all_lf)))
     {
       HANDLE obj = block->lf_obj;
       block->lf_obj = NULL;
@@ -1365,7 +1363,7 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
    *
    * Handle any locks that overlap.
    */
-  node->get_all_locks_list (); /* Update lock count */
+  node->get_all_locks_list (i_all_lf); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   /* lf_clearlock() sometimes increases the number of locks. Without
      this room, the unlocking will never succeed in some situation. */
@@ -1544,8 +1542,8 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
 
   inode_t *node = lf->lf_inode;
   tmp_pathbuf tp;
-  node->i_all_lf = (lockf_t *) tp.w_get ();
-  node->get_all_locks_list (); /* Update lock count */
+  lockf_t *i_all_lf = (lockf_t *) tp.w_get ();
+  node->get_all_locks_list (i_all_lf); /* Update lock count */
   uint32_t lock_cnt = node->get_lock_count ();
   bool first_loop = true;
 
@@ -1634,8 +1632,8 @@ lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
   tmp_pathbuf tp;
 
   /* Create temporary space for the all locks list. */
-  node->i_all_lf = (lockf_t *) (void * ) tp.w_get ();
-  if ((block = lf_getblock (lock, node)))
+  lockf_t *i_all_lf = (lockf_t *) (void * ) tp.w_get ();
+  if ((block = lf_getblock (lock, node, i_all_lf)))
     {
       if (block->lf_obj)
 	block->close_lock_obj ();
@@ -1661,10 +1659,10 @@ lf_getlock (lockf_t *lock, inode_t *node, struct flock *fl)
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

