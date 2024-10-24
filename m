Return-Path: <SRS0=lOez=RU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 8DCB33858CD9
	for <cygwin-patches@cygwin.com>; Thu, 24 Oct 2024 08:59:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8DCB33858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8DCB33858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729760382; cv=none;
	b=RE2wEHHsJOxHkIBGd5m/hL5S+kZ5/HKn2Rh+je58Hjxpq9Q9XlF61K+/wV+ypOAjhTdmQBOt5oqht0wkOFbxFLoO0REREUV7fmpdSdQU+sl9qQUWXrUdgsgqNkTea3T1+b4U3DhZbPDCO0uWTBlub7h7oOomCAiE2Ex7mUbDMOE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729760382; c=relaxed/simple;
	bh=yoquI5X5r8JR0JDnnjjs+++mAYQwLGCy7kQDb9jdkYg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rDKnCKI2e1NoijqsDaOCVthU9yHHrDKUsnIkPqfS9ueilcwQhZuksRblPgn9NkMKDOcDqFA8ee+V5wqbNskojjhqnGzi/C6zESrqp+Pg8d7eT0PzZgQM/UfPMkbLGxbqmCNqa+5B9ubOLSZVQ1UhQ0stdQKV5SQn4ISsaMQxMZE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20241024085937799.UUNE.69727.localhost.localdomain@nifty.com>;
          Thu, 24 Oct 2024 17:59:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2] Cygwin: lockf: Make lockf() return ENOLCK when too many locks
Date: Thu, 24 Oct 2024 17:59:10 +0900
Message-ID: <20241024085921.7156-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729760377;
 bh=utORgJ1Q8cLmFN31UFN5aPzU5jTV7FYBVzGrZ1IjVMU=;
 h=From:To:Cc:Subject:Date;
 b=DXTSjB6PhBr0pOyf8/XPL32a61/CC1dwD/2FyYld1Vw4TJqa0ddCivBXgQmO7ggctZ5L15n6
 yYLrj+ZudE2gsBqhomycsrzccE+Dz/0uM9M1wubU+vhuuzkzvbfcyw7dRhSTHVAeeA6mrLVNNK
 vPHEeRjgRdO+8wkgdqtVAeXide5OtxtEVyKKGkiC7EyaoNlXOjGlI8+DTcYZB1PHCEkuW06Io8
 KrwaoWa13WMZYuZpaEtq6c7n+uZJlukBmPuM0DXpWQ5lJCpjLgyPM5PWN8g/4rGjOkyduT6kEI
 1ftin9gVEWJfWX264hlxWBKkP5hSsUCdxvkS1hY3c8Vc1h2Q==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, lockf() printed a warning message when the number of locks
per file exceeds the limit (MAX_LOCKF_CNT). This patch makes lockf()
return ENOLCK in that case rather than printing the warning message.

Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
Fixes: 31390e4ca643 ("(inode_t::get_all_locks_list): Use pre-allocated buffer in i_all_lf instead of allocating every lock.  Return pointer to start of linked list of locks.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 68 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 5550b3a5b..b05005dab 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -297,6 +297,7 @@ class inode_t
     HANDLE		 i_dir;
     HANDLE		 i_mtx;
     uint32_t		 i_cnt;    /* # of threads referencing this instance. */
+    uint32_t		 i_lock_cnt; /* # of locks for this file */
 
   public:
     inode_t (dev_t dev, ino_t ino);
@@ -321,6 +322,8 @@ class inode_t
     void unlock_and_remove_if_unused ();
 
     lockf_t *get_all_locks_list ();
+    uint32_t get_lock_count () /* needs get_all_locks_list() */
+    { return i_lock_cnt; }
 
     bool del_my_locks (long long id, HANDLE fhdl);
 };
@@ -503,7 +506,8 @@ inode_t::get (dev_t dev, ino_t ino, bool create_if_missing, bool lock)
 }
 
 inode_t::inode_t (dev_t dev, ino_t ino)
-: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L)
+: i_lockf (NULL), i_all_lf (NULL), i_dev (dev), i_ino (ino), i_cnt (0L),
+  i_lock_cnt (0)
 {
   HANDLE parent_dir;
   WCHAR name[48];
@@ -610,17 +614,13 @@ inode_t::get_all_locks_list ()
 	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
 	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
 	    continue;
-	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
-	    {
-	      system_printf ("Warning, can't handle more than %d locks per file.",
-			     MAX_LOCKF_CNT);
-	      break;
-	    }
+	  assert (lock - i_all_lf < MAX_LOCKF_CNT);
 	  if (lock > i_all_lf)
 	    lock[-1].lf_next = lock;
 	  new (lock++) lockf_t (newlock);
 	}
     }
+  i_lock_cnt = lock - i_all_lf;
   /* If no lock has been found, return NULL. */
   if (lock == i_all_lf)
     return NULL;
@@ -1346,6 +1346,14 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
    *
    * Handle any locks that overlap.
    */
+  node->get_all_locks_list (); /* Update lock count */
+  uint32_t lock_cnt = node->get_lock_count ();
+  /* lf_clearlock() sometimes increases the number of locks. Without
+     this room, the unlocking will never succeed in some situation. */
+  const uint32_t room_for_clearlock = 2;
+  const int incr[] = {1, 1, 2, 2, 3, 2};
+  int decr = 0;
+
   prev = head;
   block = *head;
   needtolink = 1;
@@ -1353,7 +1361,13 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
     {
       ovcase = lf_findoverlap (block, lock, SELF, &prev, &overlap);
       if (ovcase)
-	block = overlap->lf_next;
+	{
+	  block = overlap->lf_next;
+	  HANDLE ov_obj = overlap->lf_obj;
+	  decr = (ov_obj && get_obj_handle_count (ov_obj) == 1) ? 1 : 0;
+	}
+      if (needtolink)
+	lock_cnt += incr[ovcase] - decr;
       /*
        * Six cases:
        *  0) no overlap
@@ -1368,6 +1382,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	case 0: /* no overlap */
 	  if (needtolink)
 	    {
+	      if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+		return ENOLCK;
 	      *prev = lock;
 	      lock->lf_next = overlap;
 	      lock->create_lock_obj ();
@@ -1380,6 +1396,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	   * able to acquire it.
 	   * Cygwin: Always wake lock.
 	   */
+	  if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+	    return ENOLCK;
 	  lf_wakelock (overlap, fhdl);
 	  overlap->lf_type = lock->lf_type;
 	  overlap->create_lock_obj ();
@@ -1397,6 +1415,11 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	      *clean = lock;
 	      break;
 	    }
+	  if (overlap->lf_start < lock->lf_start
+	      && overlap->lf_end > lock->lf_end)
+	    lock_cnt++;
+	  if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+	    return ENOLCK;
 	  if (overlap->lf_start == lock->lf_start)
 	    {
 	      *prev = lock;
@@ -1413,6 +1436,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  break;
 
 	case 3: /* lock contains overlap */
+	  if (needtolink && lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+	    return ENOLCK;
 	  /*
 	   * If downgrading lock, others may be able to
 	   * acquire it, otherwise take the list.
@@ -1440,6 +1465,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  /*
 	   * Add lock after overlap on the list.
 	   */
+	  if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+	    return ENOLCK;
 	  lock->lf_next = overlap->lf_next;
 	  overlap->lf_next = lock;
 	  overlap->lf_end = lock->lf_start - 1;
@@ -1456,6 +1483,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	   */
 	  if (needtolink)
 	    {
+	      if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
+		return ENOLCK;
 	      *prev = lock;
 	      lock->lf_next = overlap;
 	      lock->create_lock_obj ();
@@ -1483,12 +1512,33 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
   lockf_t *lf = *head;
   lockf_t *overlap, **prev;
   int ovcase;
+  inode_t *node = lf->lf_inode;
+  tmp_pathbuf tp;
+  node->i_all_lf = (lockf_t *) tp.w_get ();
+  node->get_all_locks_list (); /* Update lock count */
+  uint32_t lock_cnt = node->get_lock_count ();
+  bool first_loop = true;
 
   if (lf == NOLOCKF)
     return 0;
   prev = head;
   while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
     {
+      /* Check if # of locks will be increased. */
+      HANDLE ov_obj = overlap->lf_obj;
+      if (first_loop)
+	{
+	  const int incr[] = {0, 0, 1, 1, 2, 1};
+	  int decr = (ov_obj && get_obj_handle_count (ov_obj) == 1) ? 1 : 0;
+	  lock_cnt += incr[ovcase] - decr;
+	  if (ovcase == 2
+	      && overlap->lf_start < unlock->lf_start
+	      && overlap->lf_end > unlock->lf_end)
+	    lock_cnt++;
+	  if (lock_cnt > MAX_LOCKF_CNT)
+	    return ENOLCK;
+	}
+
       /*
        * Wakeup the list of locks to be retried.
        */
@@ -1521,6 +1571,7 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
 	  lf = overlap->lf_next;
 	  overlap->lf_next = *clean;
 	  *clean = overlap;
+	  first_loop = false;
 	  continue;
 
 	case 4: /* overlap starts before lock */
@@ -1528,6 +1579,7 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
 	    prev = &overlap->lf_next;
 	    lf = overlap->lf_next;
 	    overlap->create_lock_obj ();
+	    first_loop = false;
 	    continue;
 
 	case 5: /* overlap ends after lock */
-- 
2.45.1

