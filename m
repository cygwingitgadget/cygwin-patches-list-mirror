Return-Path: <SRS0=KLEv=SH=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4895F3858D35
	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2024 06:38:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4895F3858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4895F3858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731393536; cv=none;
	b=mdflXp0rCNIGwXv/arU71dz/hWkKh3RYMlGjW+5dd7NmxKybfYHHTyQnvIpfGKtdHnFTEwS8r2mFs6Ayi/P55IXmPkm21C5/AXQTmc2DcH30UO+Owf/D/eVw4bSzC61PItDuP+C73CU47IerfgWE/vaJWJQGjl9YaLPr7IHNjnA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731393536; c=relaxed/simple;
	bh=DApo1shFXR+Z15wzCV0OZ+Tdy7Sg/QJ7+ReswvgTvnM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qXb76zj1cbErGzZuOqucsc+Bb79aX7R7fnHeE41VM3k0FLkG2xIvX3UNjDhkDtj2NdJnts29KIvgykRiQbZZ8LJVDhqzCvh2Bhf7ACkk8c2xkerGHwqS/4bQNzV3TI2bGP7jTCWRF/Vlnr+KVSr2CbDXQb1I+wd3ifsLl4MpGhs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4AC6fum9007201;
	Mon, 11 Nov 2024 22:41:56 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdkYaiZD; Mon Nov 11 22:41:50 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v4] Cygwin: Change pthread_sigqueue() to accept thread id
Date: Mon, 11 Nov 2024 22:38:29 -0800
Message-ID: <20241112063844.1990-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change the first parameter of pthread_sigqueue() to be a thread id rather
than a thread pointer. The change is to match the Linux implementation of
this function.

The user-visible function prototype is changed in include/pthread.h.
The pthread_sigqueue() function is modified to work with a passed-in thread
id rather than an indirect thread pointer as before.  (It used to be
"pthread_t *thread", i.e., class pthread **.)  The release note for Cygwin
3.5.5 is updated.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 50350cafb375 ("* cygwin.din (pthread_sigqueue): Export.")

---
 winsup/cygwin/include/pthread.h | 2 +-
 winsup/cygwin/release/3.5.5     | 3 +++
 winsup/cygwin/thread.cc         | 8 ++++----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 66d367d62..a0ec32526 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -244,7 +244,7 @@ int pthread_getattr_np (pthread_t, pthread_attr_t *);
 int pthread_getname_np (pthread_t, char *, size_t) __attribute__((__nonnull__(2)));
 int pthread_setaffinity_np (pthread_t, size_t, const cpu_set_t *);
 int pthread_setname_np (pthread_t, const char *) __attribute__((__nonnull__(2)));
-int pthread_sigqueue (pthread_t *, int, const union sigval);
+int pthread_sigqueue (pthread_t, int, const union sigval);
 int pthread_timedjoin_np (pthread_t, void **, const struct timespec *);
 int pthread_tryjoin_np (pthread_t, void **);
 #endif
diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index cbaa17274..4def7ba08 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -24,3 +24,6 @@ Fixes:
 - Make console inherit hand over of pseudo console ownership from
   parent pty.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-February/255388.html
+
+- Fix type of pthread_sigqueue() first parameter to match Linux.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 0c6f57032..9ee96504b 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -3301,13 +3301,13 @@ pthread_sigmask (int operation, const sigset_t *set, sigset_t *old_set)
 }
 
 int
-pthread_sigqueue (pthread_t *thread, int sig, const union sigval value)
+pthread_sigqueue (pthread_t thread, int sig, const union sigval value)
 {
   siginfo_t si = {0};
 
-  if (!pthread::is_good_object (thread))
+  if (!pthread::is_good_object (&thread))
     return EINVAL;
-  if (!(*thread)->valid)
+  if (!thread->valid)
     return ESRCH;
 
   si.si_signo = sig;
@@ -3315,7 +3315,7 @@ pthread_sigqueue (pthread_t *thread, int sig, const union sigval value)
   si.si_value = value;
   si.si_pid = myself->pid;
   si.si_uid = myself->uid;
-  return (int) sig_send (NULL, si, (*thread)->cygtls);
+  return (int) sig_send (NULL, si, thread->cygtls);
 }
 
 /* Cancelability */
-- 
2.45.1

