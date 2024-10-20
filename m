Return-Path: <SRS0=md63=RQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 688053858C32
	for <cygwin-patches@cygwin.com>; Sun, 20 Oct 2024 09:27:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 688053858C32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 688053858C32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729416456; cv=none;
	b=SVz07dSquYkKWv0gAlR4itGD0v8YpwjduP/b574llU5rTIdb3IJ9TrMhVgKVPO6wiNKxgnzgInIsMkYhOEfQpGxYKJCegnM9V8lOpjlA3TAdDFfWYQo9Ud/7sFq8P95p+yzKjg2mn6TwlYACwHarcX7QOybCYvIRi6DYY2VMTW4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729416456; c=relaxed/simple;
	bh=BDh5389fioDi+LSoYVOSHv/Ek7xRRuxzXg4YMI24a2c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wfa2azTxrqEf3G2JzXCKg70/RR8Dxha34CBRn8A3+ypYEJv9Q4RmNAWDiERS6p4+3Tfqb3z+9XQl9BO1sfiJt/cwmgYv3Mv4JvCkXq7aGH5xegge0hOoBgseUx7ay8TQHV2iy0Ac/zeDV1LD7p6ReGhOVAa1bpY4OhzV/oqtwyE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241020092729528.WKSY.81160.localhost.localdomain@nifty.com>;
          Sun, 20 Oct 2024 18:27:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 2/2] Cygwin: lockf: Make lockf() return ENOLCK when too many locks
Date: Sun, 20 Oct 2024 18:26:37 +0900
Message-ID: <20241020092650.835-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
References: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729416449;
 bh=aN5PiMwCY2bfAa138+bmFHBi/eJQnYSNYZ8MA5lRRsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XFSj3kqmVKSrM+/IlnRbdKkSLYVAIXSSxI82CCXsAxm57KX2dRdttqu8nrSvt9hONYjf2gcH
 Ju03/955nQGRQftMjXqLKS0e0In5xJl5eY+KWFYAgjV8A0r9kOK2VR3o9VbMNjx0BXW0jnIte9
 77Vcvfc+A3Gg7+ooGqupek8t/XDB8flB0tkSzfTYYZySJQFOBlvDsLSlc7iWdjPIiIu4stFmGb
 HmHdMlS2i5gqE8ajQljY2CY0tsCnkT6uHMR4G6DAUJ5U/Omu4bVmswbCp2F6Gm6cl71CtH7Kdu
 YEMU1u/lyP5pHzABXUQwIi4Flrni/0WrE++p4r5969OP1bXA==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, lockf() printed a warning message when the number of locks
per file exceeds the limit (MAX_LOCKF_CNT). This patch makes lockf()
return ENOLCK in that case rather than printing the warning message.

Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
Fixes: 31390e4ca643 ("(inode_t::get_all_locks_list): Use pre-allocated buffer in i_all_lf instead of allocating every lock.  Return pointer to start of linked list of locks.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 46 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 5550b3a5b..3b8475c18 100644
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
@@ -610,17 +614,15 @@ inode_t::get_all_locks_list ()
 	  dbi->ObjectName.Buffer[LOCK_OBJ_NAME_LEN] = L'\0';
 	  if (!newlock.from_obj_name (this, &i_all_lf, dbi->ObjectName.Buffer))
 	    continue;
-	  if (lock - i_all_lf >= MAX_LOCKF_CNT)
-	    {
-	      system_printf ("Warning, can't handle more than %d locks per file.",
-			     MAX_LOCKF_CNT);
-	      break;
-	    }
+	  if (lock - i_all_lf > MAX_LOCKF_CNT)
+	    api_fatal ("Can't handle more than %d locks per file.",
+		       MAX_LOCKF_CNT);
 	  if (lock > i_all_lf)
 	    lock[-1].lf_next = lock;
 	  new (lock++) lockf_t (newlock);
 	}
     }
+  i_lock_cnt = lock - i_all_lf;
   /* If no lock has been found, return NULL. */
   if (lock == i_all_lf)
     return NULL;
@@ -1346,6 +1348,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
    *
    * Handle any locks that overlap.
    */
+  node->get_all_locks_list (); /* Update lock count */
+  const uint32_t lock_cnt = node->get_lock_count ();
   prev = head;
   block = *head;
   needtolink = 1;
@@ -1368,6 +1372,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	case 0: /* no overlap */
 	  if (needtolink)
 	    {
+	      if (lock_cnt + 1 > MAX_LOCKF_CNT)
+		return ENOLCK;
 	      *prev = lock;
 	      lock->lf_next = overlap;
 	      lock->create_lock_obj ();
@@ -1399,12 +1405,20 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	    }
 	  if (overlap->lf_start == lock->lf_start)
 	    {
+	      if (lock_cnt + 1 > MAX_LOCKF_CNT)
+		return ENOLCK;
 	      *prev = lock;
 	      lock->lf_next = overlap;
 	      overlap->lf_start = lock->lf_end + 1;
 	    }
 	  else
-	    lf_split (overlap, lock, clean);
+	    {
+	      if ((overlap->lf_end > lock->lf_end
+		   && lock_cnt + 2 > MAX_LOCKF_CNT)
+		  || lock_cnt + 1 > MAX_LOCKF_CNT)
+		return ENOLCK;
+	      lf_split (overlap, lock, clean);
+	    }
 	  lf_wakelock (overlap, fhdl);
 	  overlap->create_lock_obj ();
 	  lock->create_lock_obj ();
@@ -1440,6 +1454,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  /*
 	   * Add lock after overlap on the list.
 	   */
+	  if (lock_cnt + 1 > MAX_LOCKF_CNT)
+	    return ENOLCK;
 	  lock->lf_next = overlap->lf_next;
 	  overlap->lf_next = lock;
 	  overlap->lf_end = lock->lf_start - 1;
@@ -1456,6 +1472,8 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	   */
 	  if (needtolink)
 	    {
+	      if (lock_cnt + 1 > MAX_LOCKF_CNT)
+		return ENOLCK;
 	      *prev = lock;
 	      lock->lf_next = overlap;
 	      lock->create_lock_obj ();
@@ -1483,12 +1501,24 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
   lockf_t *lf = *head;
   lockf_t *overlap, **prev;
   int ovcase;
+  inode_t *node = lf->lf_inode;
 
   if (lf == NOLOCKF)
     return 0;
   prev = head;
   while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
     {
+      /* Check if # of locks will be increased. */
+      if (ovcase == 2 /* overlap contains lock */
+	  && overlap->lf_start < unlock->lf_start
+	  && overlap->lf_end > unlock->lf_end)
+	{
+	  tmp_pathbuf tp;
+	  node->i_all_lf = (lockf_t *) tp.w_get ();
+	  node->get_all_locks_list (); /* Update lock count */
+	  if (node->get_lock_count () + 1 > MAX_LOCKF_CNT)
+	    return ENOLCK;
+	}
       /*
        * Wakeup the list of locks to be retried.
        */
-- 
2.45.1

