Return-Path: <SRS0=bjVK=SC=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 578833858D20
	for <cygwin-patches@cygwin.com>; Thu,  7 Nov 2024 07:29:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 578833858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 578833858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730964607; cv=none;
	b=A1QYC7KilDyaUTStm1Z9mp3FDsUp+jsp+iXAp+BRYjJsZxKH/atDyvwC+VVrxGHWFKa5e2knIoD8Pr7vRAI3jkG6t8M0dhtIzLQX6dyKhfzOaBCkK4H4mQMDz8GsId3Hb7Ic5fSrv14zjWst0Q20rOMJvzOI3XLtQodYAzllIus=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730964607; c=relaxed/simple;
	bh=tZ02rI6v2P2mzPuuN7tG1MdYgPwn/RDF91p9ce5370g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XOfAWLeRXvQ2BVn9rksaXxhUMdoBDVlxIXSvM5pArdLyM+A0TVKQ9CqVR7aw3IIoKke4qRJOsU601AOf/v12V4M/2lcej/IjSe+CEyz1MtyEgL1w9qkfBQfgOQoW74J8CgNMfak+TFLHimdwgMDKc4OX7VGC8YPV0AflC+goqWE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4A77WxwQ055631;
	Wed, 6 Nov 2024 23:32:59 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdZtJFBQ; Wed Nov  6 23:32:55 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v3] Cygwin: Change pthread_sigqueue() to accept thread id
Date: Wed,  6 Nov 2024 23:29:18 -0800
Message-ID: <20241107072935.1630-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change the first parameter of pthread_sigqueue() to be a thread id rather
than a thread pointer. The change is to match the Linux implementation of
this function.

The user-visible function prototype is changed in include/pthread.h.
The pthread_sigqueue() function is modified to work with a passed-in thread
id rather than an indirect thread pointer as before.  (It was
"pthread_t *thread", i.e., class pthread **.)  The release note for Cygwin
3.5.5 is updated.  CYGWIN_VERSION_API_MINOR is bumped to 351.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 2041af1a535a (cygwin.din (pthread_sigqueue): Export.)

---
 winsup/cygwin/include/cygwin/version.h | 3 ++-
 winsup/cygwin/include/pthread.h        | 2 +-
 winsup/cygwin/release/3.5.5            | 3 +++
 winsup/cygwin/thread.cc                | 8 ++++----
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index fb821a681..c70d0ee15 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -485,12 +485,13 @@ details. */
   348: Add c8rtomb, mbrtoc.
   349: Add fallocate.
   350: Add close_range.
+  351: Change pthread_sigqueue first arg type.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 350
+#define CYGWIN_VERSION_API_MINOR 351
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
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
index 9cc51dc2e..2ca4572db 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -30,3 +30,6 @@ Fixes:
 
 - Fix a problem that signal handler destroys the FPU context.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256503.html
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

