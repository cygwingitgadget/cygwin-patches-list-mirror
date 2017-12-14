Return-Path: <cygwin-patches-return-8967-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6680 invoked by alias); 14 Dec 2017 06:54:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6668 invoked by uid 89); 14 Dec 2017 06:54:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=para, sendto, UD:xml, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Dec 2017 06:54:51 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id vBE6snUH002766;	Wed, 13 Dec 2017 22:54:49 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdUrNa2O; Wed Dec 13 22:54:42 2017
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Implement sigtimedwait
Date: Thu, 14 Dec 2017 06:54:00 -0000
Message-Id: <20171214065430.4500-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00097.txt.bz2

Abstract out common code from sigwait/sigwaitinfo/sigtimedwait to implement the latter.
---
 winsup/cygwin/common.din               |  1 +
 winsup/cygwin/include/cygwin/version.h |  3 ++-
 winsup/cygwin/signal.cc                | 32 ++++++++++++++++++++++++++++++--
 winsup/cygwin/thread.cc                |  2 +-
 winsup/doc/posix.xml                   |  2 +-
 5 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 14b9c2c18..91f2915bf 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1326,6 +1326,7 @@ sigrelse SIGFE
 sigset SIGFE
 sigsetjmp NOSIGFE
 sigsuspend SIGFE
+sigtimedwait SIGFE
 sigwait SIGFE
 sigwaitinfo SIGFE
 sin NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 0fee73c1d..aa7c14ec3 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -492,12 +492,13 @@ details. */
   321: Export wmempcpy.
   322: [w]scanf %m modifier.
   323: scanf %l[ conversion.
+  324: Export sigtimedwait.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 323
+#define CYGWIN_VERSION_API_MINOR 324
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
index 69c5e2aad..0599d8a3e 100644
--- a/winsup/cygwin/signal.cc
+++ b/winsup/cygwin/signal.cc
@@ -575,6 +575,28 @@ siginterrupt (int sig, int flag)
   return res;
 }
 
+static int sigwait_common (const sigset_t *, siginfo_t *, PLARGE_INTEGER);
+
+extern "C" int
+sigtimedwait (const sigset_t *set, siginfo_t *info, const timespec *timeout)
+{
+  LARGE_INTEGER cwaittime;
+
+  if (timeout)
+    {
+      if (timeout->tv_sec < 0
+	    || timeout->tv_nsec < 0 || timeout->tv_nsec > 1000000000LL)
+	{
+	  set_errno (EINVAL);
+	  return -1;
+	}
+      cwaittime.QuadPart = (LONGLONG) timeout->tv_sec * NSPERSEC
+                          + ((LONGLONG) timeout->tv_nsec + 99LL) / 100LL;
+    }
+
+  return sigwait_common (set, info, timeout ? &cwaittime : cw_infinite);
+}
+
 extern "C" int
 sigwait (const sigset_t *set, int *sig_ptr)
 {
@@ -582,7 +604,7 @@ sigwait (const sigset_t *set, int *sig_ptr)
 
   do
     {
-      sig = sigwaitinfo (set, NULL);
+      sig = sigwait_common (set, NULL, cw_infinite);
     }
   while (sig == -1 && get_errno () == EINTR);
   if (sig > 0)
@@ -592,6 +614,12 @@ sigwait (const sigset_t *set, int *sig_ptr)
 
 extern "C" int
 sigwaitinfo (const sigset_t *set, siginfo_t *info)
+{
+  return sigwait_common (set, info, cw_infinite);
+}
+
+static int
+sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER cwaittime)
 {
   int res = -1;
 
@@ -602,7 +630,7 @@ sigwaitinfo (const sigset_t *set, siginfo_t *info)
       set_signal_mask (_my_tls.sigwait_mask, *set);
       sig_dispatch_pending (true);
 
-      switch (cygwait (NULL, cw_infinite, cw_sig_eintr | cw_cancel | cw_cancel_self))
+      switch (cygwait (NULL, cwaittime, cw_sig_eintr | cw_cancel | cw_cancel_self))
 	{
 	case WAIT_SIGNALED:
 	  if (!sigismember (set, _my_tls.infodata.si_signo))
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index b9b2c7aaa..f3c709a15 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -708,7 +708,7 @@ pthread::cancel ()
     * sendto ()
     * sigpause ()
     * sigsuspend ()
-    o sigtimedwait ()
+    * sigtimedwait ()
     * sigwait ()
     * sigwaitinfo ()
     * sleep ()
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index ab574300f..2664159e1 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -888,6 +888,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     sigset
     sigsetjmp
     sigsuspend
+    sigtimedwait
     sigwait
     sigwaitinfo
     sin
@@ -1582,7 +1583,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     pthread_mutex_consistent
     putmsg
     setnetent
-    sigtimedwait
     timer_getoverrun
     ulimit
     waitid
-- 
2.15.1
