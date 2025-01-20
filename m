Return-Path: <SRS0=0Yjd=UM=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 9DAA73858433
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 06:00:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9DAA73858433
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9DAA73858433
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737352819; cv=none;
	b=vAh4tDsbK3G75H7tLrbwbrX6D1noqI7F1tNS1jtGoMEejcac30KzF2S5k12cmSq14khhzuX6hlzSm44DWqrd5TlV72gfVA0UGggh5GwLuTJPwVpXS8VJELp2vW1c9HikahvZsTuWgiQL6TxaoYEhQDKPp2iIXKMtyn3pDxEW/2I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737352819; c=relaxed/simple;
	bh=0MhO6M9HTXYD4BRHT/1bpXD6igmnvfJ2KkPbpsoef/E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mEgRXzgt4bxVAgsfE4Kkznd06Y/iGhtHvJowlKIsR6+dW/qk9tDIMghtBoRr/PikXGAalwSXwWySXOjdMMfk6jEaiFoTY2vfOnQpS0b0LCDuDhk2iQELKlT5JoyxmiL5oKVL5i2xcu1PnCYOUpgVpv7qq+QQikCTRXvUWDO+4+Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9DAA73858433
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 50K66NQt067144;
	Sun, 19 Jan 2025 22:06:23 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdMf7rKx; Sun Jan 19 22:06:19 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2] Cygwin: Add fd validation where needed in mq_* functions
Date: Sun, 19 Jan 2025 21:59:34 -0800
Message-ID: <20250120060009.345-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013235.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013235.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Validate the fd returned by cygheap_getfd operating on given mqd.
A release note is provided for 3.5.6.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 46f3b0ce85a9 (Cygwin: POSIX msg queues: move all mq_* functionality into fhandler_mqueue)

---
 winsup/cygwin/posix_ipc.cc  | 81 ++++++++++++++++++++++---------------
 winsup/cygwin/release/3.5.6 |  3 ++
 2 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/winsup/cygwin/posix_ipc.cc b/winsup/cygwin/posix_ipc.cc
index 34fd2ba34..2650c35ac 100644
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
 
@@ -309,14 +324,14 @@ mq_close (mqd_t mqd)
   __try
     {
       cygheap_fdget fd ((int) mqd, true);
-      if (!fd->is_mqueue ())
-	{
-	  set_errno (EBADF);
-	  __leave;
-	}
-
-      if (mq_notify (mqd, NULL))	/* unregister calling process */
-	__leave;
+      if (fd < 0 || !fd->is_mqueue ())
+        {
+          set_errno (EBADF);
+          __leave;
+        }
+
+      if (mq_notify (mqd, NULL))        /* unregister calling process */
+        __leave;
 
       fd->isclosed (true);
       fd->close ();
diff --git a/winsup/cygwin/release/3.5.6 b/winsup/cygwin/release/3.5.6
index 0fff0de40..4ccf94e38 100644
--- a/winsup/cygwin/release/3.5.6
+++ b/winsup/cygwin/release/3.5.6
@@ -10,3 +10,6 @@ Fixes:
 
 - Fix zsh hang at startup.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256954.html
+
+- Add fd validation where needed in mq_* functions.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257090.html
-- 
2.45.1

