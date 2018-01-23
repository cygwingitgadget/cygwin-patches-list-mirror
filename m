Return-Path: <cygwin-patches-return-9018-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33309 invoked by alias); 23 Jan 2018 05:21:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33292 invoked by uid 89); 23 Jan 2018 05:21:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jan 2018 05:21:33 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w0N5LWJp058934;	Mon, 22 Jan 2018 21:21:32 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdr4LO9Z; Mon Jan 22 21:21:25 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Define internal function mythreadname()
Date: Tue, 23 Jan 2018 05:21:00 -0000
Message-Id: <20180123052112.6568-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00026.txt.bz2

 This new function returns the name of the calling thread; works for both
 cygthreads and pthreads. All calls to cygthread::name(/*void*/) replaced by
 calls to mythreadname(/*void*/).

---
 winsup/cygwin/exceptions.cc   |  4 ++--
 winsup/cygwin/fhandler_tty.cc |  2 +-
 winsup/cygwin/strace.cc       |  2 +-
 winsup/cygwin/thread.cc       | 17 +++++++++++++++++
 winsup/cygwin/thread.h        |  3 +++
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 47782e45b..f659540cb 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -200,7 +200,7 @@ cygwin_exception::dump_exception ()
   small_printf ("r14=%016X r15=%016X\r\n", ctx->R14, ctx->R15);
   small_printf ("rbp=%016X rsp=%016X\r\n", ctx->Rbp, ctx->Rsp);
   small_printf ("program=%W, pid %u, thread %s\r\n",
-		myself->progname, myself->pid, cygthread::name ());
+		myself->progname, myself->pid, mythreadname ());
 #else
   if (exception_name)
     small_printf ("Exception: %s at eip=%08x\r\n", exception_name, ctx->Eip);
@@ -210,7 +210,7 @@ cygwin_exception::dump_exception ()
 		ctx->Eax, ctx->Ebx, ctx->Ecx, ctx->Edx, ctx->Esi, ctx->Edi);
   small_printf ("ebp=%08x esp=%08x program=%W, pid %u, thread %s\r\n",
 		ctx->Ebp, ctx->Esp, myself->progname, myself->pid,
-		cygthread::name ());
+		mythreadname ());
 #endif
   small_printf ("cs=%04x ds=%04x es=%04x fs=%04x gs=%04x ss=%04x\r\n",
 		ctx->SegCs, ctx->SegDs, ctx->SegEs, ctx->SegFs,
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1505b8c2b..0b8185d90 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -106,7 +106,7 @@ fhandler_pty_common::__acquire_output_mutex (const char *fn, int ln,
 #else
       ostack[osi].fn = fn;
       ostack[osi].ln = ln;
-      ostack[osi].tname = cygthread::name ();
+      ostack[osi].tname = mythreadname ();
       termios_printf ("acquired for %s:%d, osi %d", fn, ln, osi);
       osi++;
 #endif
diff --git a/winsup/cygwin/strace.cc b/winsup/cygwin/strace.cc
index 1e7ab047d..b95b436aa 100644
--- a/winsup/cygwin/strace.cc
+++ b/winsup/cygwin/strace.cc
@@ -138,7 +138,7 @@ strace::vsprntf (char *buf, const char *func, const char *infmt, va_list ap)
   char fmt[80];
   static NO_COPY bool nonewline = false;
   DWORD err = GetLastError ();
-  const char *tn = cygthread::name ();
+  const char *tn = mythreadname ();
 
   int microsec = microseconds ();
   lmicrosec = microsec;
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index f3c709a15..71e17a77f 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -2682,6 +2682,23 @@ pthread_setname_np (pthread_t thread, const char *name)
   return 0;
 }
 
+/* Returns running thread's name; works for both cygthreads and pthreads */
+extern "C" const char *
+mythreadname (void)
+{
+  const char *result = cygthread::name ();
+
+  if (strstr (result, "unknown "))
+    {
+      static char tname[THRNAMELEN];
+
+      tname[0] = '\0';
+      if (0 == pthread_getname_np (pthread_self (), tname, sizeof (tname)))
+        result = tname;
+    }
+
+  return result;
+}
 #undef THRNAMELEN
 
 /* provided for source level compatability.
diff --git a/winsup/cygwin/thread.h b/winsup/cygwin/thread.h
index 12a9ef26d..60277c601 100644
--- a/winsup/cygwin/thread.h
+++ b/winsup/cygwin/thread.h
@@ -17,6 +17,9 @@ details. */
 /* resource.cc */
 extern size_t get_rlimit_stack (void);
 
+/* thread.cc */
+extern "C" const char *mythreadname (void);
+
 #include <pthread.h>
 #include <limits.h>
 #include "security.h"
-- 
2.15.1
