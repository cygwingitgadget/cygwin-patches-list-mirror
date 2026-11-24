Return-Path: <SRS0=UvTC=JN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id BC8E64417BC2
	for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2026 03:17:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BC8E64417BC2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BC8E64417BC2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795490270; cv=none;
	b=KBhCI6r9ca9x5chfUFqBHMtOLQRdAQ02yJI96ZhC5IbxFjEUH2CioTSObUDPiJjzdO9UdyajHfpFket63gAE1RcLAuT5BCdmSSO/57RjzU9SpKWS0GWLNadS5yuWOwjt1yJye4F/WddjWudxEcOOtP39swEQCBOm42uXYbjXfnY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795490270; c=relaxed/simple;
	bh=EJBBFByZzpF/ZiFRGckx7Ff4WG9dksqLFPWkflrg0B0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TCQ2XoiFxdFubjQzyUND5SndGqc9WpUHEPTZGFQTsqCXvo5ZsxTPG1r1+WjeZJYglrhTRFes2UYNHQImkZUEvl40llkGz8rWa0UyO34vKwMM0TUscL9mnJ72AZiPy5+P+TXp8jSei9Belz64rCLuqD2svA5gVnak/H82a62RHa8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bALFQ+eZ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BC8E64417BC2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bALFQ+eZ
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261124031746971.KLVF.44671.HP-Z230@nifty.com>;
          Tue, 24 Nov 2026 12:17:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] cygwin: pthread: Improve the performance of the destructor
Date: Tue, 24 Nov 2026 12:17:25 +0900
Message-ID: <20261124031736.1926-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1795490267;
 bh=vTZ8iSlUBCAOUF+vNywS6pxnzPlz/aORduz5mD4KvX0=;
 h=From:To:Cc:Subject:Date;
 b=bALFQ+eZVWOwTdL1Hr3p0ufUd0Ct6CK9JartpU26H93wfsU7SBL7rtafZ7llWJdM0S7E6AEP
 PmOowuRtL0/vRgJl42uj6/eNgTXxlx/2PLrTvLFStyoeolTuNJI+XFdv2LLLKgG+HS3vQlNdBI
 8N2e24Qyw7PLDxr/bFAMjhNMn3852RBVzpegV3kCkJr5uSwyPdBaasPspIqSSUEA6pLFqjm+jI
 cV4yhOjjoCghzf6mydwS4GrOs1a41xijfwUqOisrXYLwQLnDw48SRLkytd+3pE5g6OiZ2iyxwK
 Tgy0lgScNtNeluvdzEsIjsk+c43Ru3X3CTb7/mRPOX7JF3ow==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Deleting pthread-related objects, such as pthread_mutex, becomes very
slow when the number of the objects is large. Currently, these objects
are managed in a singly linked list, where deletion requires O(n) time.
As a result, deleting all objects takes O(n^2) time overall. Due to
this issue, freeing a decoder in libde265 can sometime take several
tens of seconds, because libde265 uses around 100,000 pthread_mutex
objects depending on the video being decoded.

This patch changes the list to a doubly linked, reducing the overall
deletion comlexity from O(n^2) to O(n).

Fixes: 5c83f260b87b ("(pthread_key_destructor_list::Remove): New function.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/local_includes/thread.h | 45 +++++++++++++++++----------
 winsup/cygwin/thread.cc               | 14 ++++++---
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/local_includes/thread.h b/winsup/cygwin/local_includes/thread.h
index cbbbc3f1e..caf54c4bc 100644
--- a/winsup/cygwin/local_includes/thread.h
+++ b/winsup/cygwin/local_includes/thread.h
@@ -117,7 +117,12 @@ List_insert (fast_mutex &mx, list_node *&head, list_node *node)
     return;
   mx.lock ();
   do
-    node->next = head;
+    {
+      node->next = head;
+      node->prev = NULL;
+      if (head)
+	head->prev = node;
+    }
   while (InterlockedCompareExchangePointer ((PVOID volatile *) &head,
 					    node, node->next) != node->next);
   mx.unlock ();
@@ -129,7 +134,12 @@ List_insert_nolock (list_node *&head, list_node *node)
   if (!node)
     return;
   do
-    node->next = head;
+    {
+      node->next = head;
+      node->prev = NULL;
+      if (head)
+	head->prev = node;
+    }
   while (InterlockedCompareExchangePointer ((PVOID volatile *) &head,
 					    node, node->next) != node->next);
 }
@@ -140,19 +150,13 @@ List_remove (fast_mutex &mx, list_node *&head, list_node *node)
   if (!node)
     return;
   mx.lock ();
-  if (head)
-    {
-      if (InterlockedCompareExchangePointer ((PVOID volatile *) &head,
-					     node->next, node) != node)
-	{
-	  list_node *cur = head;
-
-	  while (cur->next && node != cur->next)
-	    cur = cur->next;
-	  if (node == cur->next)
-	    cur->next = cur->next->next;
-	}
-    }
+  if (node->prev)
+    node->prev->next = node->next;
+  else
+    InterlockedCompareExchangePointer ((PVOID volatile *) &head,
+				       node->next, node);
+  if (node->next)
+    node->next->prev = node->prev;
   mx.unlock ();
 }
 
@@ -339,6 +343,7 @@ public:
   ~pthread_mutex ();
 
   class pthread_mutex *next;
+  class pthread_mutex *prev;
   static void fixup_after_fork ()
   {
     mutexes.fixup_after_fork ();
@@ -458,6 +463,7 @@ public:
 
   /* List support calls */
   class pthread *next;
+  class pthread *prev;
   static void fixup_after_fork ()
   {
     threads.fixup_after_fork ();
@@ -559,6 +565,7 @@ public:
   ~pthread_cond ();
 
   class pthread_cond * next;
+  class pthread_cond * prev;
   static void fixup_after_fork ()
   {
     conds.fixup_after_fork ();
@@ -632,9 +639,11 @@ public:
   struct RWLOCK_READER
   {
     struct RWLOCK_READER *next;
+    struct RWLOCK_READER *prev;
     pthread_t thread;
     uint32_t n;
-    RWLOCK_READER (): next (NULL), thread (pthread::self ()), n (0) {}
+    RWLOCK_READER ():
+      next (NULL), prev (NULL), thread (pthread::self ()), n (0) {}
   } *readers;
   fast_mutex readers_mx;
 
@@ -654,6 +663,7 @@ public:
   ~pthread_rwlock ();
 
   class pthread_rwlock * next;
+  class pthread_rwlock * prev;
   static void fixup_after_fork ()
   {
     rwlocks.fixup_after_fork ();
@@ -729,6 +739,7 @@ public:
   ~semaphore ();
 
   class semaphore * next;
+  class semaphore * prev;
   static void fixup_before_fork ()
   {
     semaphores.for_each (&semaphore::_fixup_before_fork);
@@ -760,8 +771,10 @@ private:
 class callback
 {
 public:
+  callback (): next (NULL), prev (NULL) {}
   void (*cb)(void);
   class callback * next;
+  class callback * prev;
 };
 
 struct MTinterface
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 4df13221e..1053b4273 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -413,7 +413,8 @@ List<pthread> pthread::threads;
 pthread::pthread ():verifyable_object (PTHREAD_MAGIC), win32_obj_id (0),
 		    valid (false), suspended (false), canceled (false),
 		    cancelstate (0), canceltype (0), cancel_event (0),
-		    joiner (NULL), next (NULL), cleanup_stack (NULL)
+		    joiner (NULL), next (NULL), prev (NULL),
+		    cleanup_stack (NULL)
 {
   if (this != pthread_null::get_null_pthread ())
     threads.insert (this);
@@ -1163,7 +1164,7 @@ pthread_cond::init_mutex ()
 pthread_cond::pthread_cond (pthread_condattr *attr) :
   verifyable_object (PTHREAD_COND_MAGIC),
   shared (0), clock_id (CLOCK_REALTIME), waiting (0), pending (0),
-  sem_wait (NULL), mtx_cond(NULL), next (NULL)
+  sem_wait (NULL), mtx_cond(NULL), next (NULL), prev (NULL)
 {
   pthread_mutex *verifyable_mutex_obj;
 
@@ -1379,7 +1380,7 @@ pthread_rwlock::pthread_rwlock (pthread_rwlockattr *attr) :
   verifyable_object (PTHREAD_RWLOCK_MAGIC),
   shared (0), waiting_readers (0), waiting_writers (0), writer (NULL),
   readers (NULL), readers_mx (), mtx (NULL), cond_readers (NULL), cond_writers (NULL),
-  next (NULL)
+  next (NULL), prev (NULL)
 {
   pthread_mutex *verifyable_mutex_obj = &mtx;
   pthread_cond *verifyable_cond_obj;
@@ -1789,6 +1790,7 @@ pthread_mutex::init_mutex ()
 
 pthread_mutex::pthread_mutex (pthread_mutexattr *attr) :
   verifyable_object (0),	/* set magic to zero initially */
+  next (NULL), prev (NULL),
   lock_counter (0),
   win32_obj_id (NULL), owner (_new_mutex),
 #ifdef DEBUGGING
@@ -2557,7 +2559,8 @@ semaphore::semaphore (int pshared, unsigned int value)
   startvalue (value),
   fd (-1),
   hash (0ULL),
-  sem (NULL)
+  sem (NULL),
+  next (NULL), prev (NULL)
 {
   SECURITY_ATTRIBUTES sa = (pshared != PTHREAD_PROCESS_PRIVATE)
 			   ? sec_all : sec_none_nih;
@@ -2577,7 +2580,8 @@ semaphore::semaphore (unsigned long long shash, LUID sluid, int sfd,
   fd (sfd),
   hash (shash),
   luid (sluid),
-  sem (ssem)
+  sem (ssem),
+  next (NULL), prev (NULL)
 {
   char name[MAX_PATH];
 
-- 
2.51.0

