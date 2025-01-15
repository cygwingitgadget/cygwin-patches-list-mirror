Return-Path: <SRS0=iXc4=UH=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 572F3385DDD3
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 10:50:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 572F3385DDD3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 572F3385DDD3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736938222; cv=none;
	b=LuEVn6PVI6QdO+5WfOX8wASIrMCQvpIE93ExJ573tCvAaZLiO+pAFi23yRNZkuApbd0RbbA7/UNpLkwb3MNRZTNZdWL81zTwETQ8sd3+RmNUN/csil5+hn8wsa4MLlfZ7uHIiBGBjzcUNLjgdlSIKiYkzAT1/m/XZOyEhLwaycw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736938222; c=relaxed/simple;
	bh=CrNHDVCpKISAUW/LxqCk5x6SucyEvcEgjPBq62j27E0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dSxDbit1LBIywwGFfmX3z3SIyxTBTyttHYShO53teib/rg50x/O+fucW1/6/p0Y9FTTTzX7ZJi1P1YTVg7nD7WaBEdzh9HLiLdM46UMpTYeFx358YDOXTXmtlvTRaBTaRA7VfEhs2EZBm/+7X+hdPeyOhFExd1dVzH4KzkTsDlo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 572F3385DDD3
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 50FAuVtb006478;
	Wed, 15 Jan 2025 02:56:31 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdD0Y7yu; Wed Jan 15 02:56:29 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: add fd validation to mq_* functions
Date: Wed, 15 Jan 2025 02:49:54 -0800
Message-ID: <20250115105006.471-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Validate the fd returned by cygheap_getfd operating on given mqd.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 46f3b0ce85a9 (Cygwin: POSIX msg queues: move all mq_* functionality into fhandler_mqueue)

---
 winsup/cygwin/posix_ipc.cc | 88 +++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/winsup/cygwin/posix_ipc.cc b/winsup/cygwin/posix_ipc.cc
index 34fd2ba34..3ce1ecda6 100644
--- a/winsup/cygwin/posix_ipc.cc
+++ b/winsup/cygwin/posix_ipc.cc
@@ -225,11 +225,14 @@ mq_getattr (mqd_t mqd, struct mq_attr *mqstat)
   int ret = -1;
 
   cygheap_fdget fd ((int) mqd, true);
-  fhandler_mqueue *fh = fd->is_mqueue ();
-  if (!fh)
-    set_errno (EBADF);
-  else
-    ret = fh->mq_getattr (mqstat);
+  if (fd >= 0)
+    {
+      fhandler_mqueue *fh = fd->is_mqueue ();
+      if (!fh)
+        set_errno (EBADF);
+      else
+        ret = fh->mq_getattr (mqstat);
+    }
   return ret;
 }
 
@@ -239,11 +242,14 @@ mq_setattr (mqd_t mqd, const struct mq_attr *mqstat, struct mq_attr *omqstat)
   int ret = -1;
 
   cygheap_fdget fd ((int) mqd, true);
-  fhandler_mqueue *fh = fd->is_mqueue ();
-  if (!fh)
-    set_errno (EBADF);
-  else
-    ret = fh->mq_setattr (mqstat, omqstat);
+  if (fd >= 0)
+    {
+      fhandler_mqueue *fh = fd->is_mqueue ();
+      if (!fh)
+        set_errno (EBADF);
+      else
+        ret = fh->mq_setattr (mqstat, omqstat);
+    }
   return ret;
 }
 
@@ -253,11 +259,14 @@ mq_notify (mqd_t mqd, const struct sigevent *notification)
   int ret = -1;
 
   cygheap_fdget fd ((int) mqd, true);
-  fhandler_mqueue *fh = fd->is_mqueue ();
-  if (!fh)
-    set_errno (EBADF);
-  else
-    ret = fh->mq_notify (notification);
+  if (fd >= 0)
+    {
+      fhandler_mqueue *fh = fd->is_mqueue ();
+      if (!fh)
+        set_errno (EBADF);
+      else
+        ret = fh->mq_notify (notification);
+    }
   return ret;
 }
 
@@ -268,11 +277,14 @@ mq_timedsend (mqd_t mqd, const char *ptr, size_t len, unsigned int prio,
   int ret = -1;
 
   cygheap_fdget fd ((int) mqd, true);
-  fhandler_mqueue *fh = fd->is_mqueue ();
-  if (!fh)
-    set_errno (EBADF);
-  else
-    ret = fh->mq_timedsend (ptr, len, prio, abstime);
+  if (fd >= 0)
+    {
+      fhandler_mqueue *fh = fd->is_mqueue ();
+      if (!fh)
+        set_errno (EBADF);
+      else
+        ret = fh->mq_timedsend (ptr, len, prio, abstime);
+    }
   return ret;
 }
 
@@ -289,11 +301,14 @@ mq_timedreceive (mqd_t mqd, char *ptr, size_t maxlen, unsigned int *priop,
   int ret = -1;
 
   cygheap_fdget fd ((int) mqd, true);
-  fhandler_mqueue *fh = fd->is_mqueue ();
-  if (!fh)
-    set_errno (EBADF);
-  else
-    ret = fh->mq_timedrecv (ptr, maxlen, priop, abstime);
+  if (fd >= 0)
+    {
+      fhandler_mqueue *fh = fd->is_mqueue ();
+      if (!fh)
+        set_errno (EBADF);
+      else
+        ret = fh->mq_timedrecv (ptr, maxlen, priop, abstime);
+    }
   return ret;
 }
 
@@ -309,18 +324,21 @@ mq_close (mqd_t mqd)
   __try
     {
       cygheap_fdget fd ((int) mqd, true);
-      if (!fd->is_mqueue ())
-	{
-	  set_errno (EBADF);
-	  __leave;
-	}
+      if (fd >= 0)
+        {
+          if (!fd->is_mqueue ())
+	    {
+	      set_errno (EBADF);
+	      __leave;
+	    }
 
-      if (mq_notify (mqd, NULL))	/* unregister calling process */
-	__leave;
+          if (mq_notify (mqd, NULL))	/* unregister calling process */
+	    __leave;
 
-      fd->isclosed (true);
-      fd->close ();
-      fd.release ();
+          fd->isclosed (true);
+          fd->close ();
+          fd.release ();
+        }
       return 0;
     }
   __except (EBADF) {}
-- 
2.45.1

