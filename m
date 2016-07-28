Return-Path: <cygwin-patches-return-8606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129886 invoked by alias); 28 Jul 2016 11:44:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127672 invoked by uid 89); 28 Jul 2016 11:44:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=UD:lock, CALLBACK, sends, injected
X-HELO: rgout0302.bt.lon5.cpcloud.co.uk
Received: from rgout0302.bt.lon5.cpcloud.co.uk (HELO rgout0302.bt.lon5.cpcloud.co.uk) (65.20.0.208) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Jul 2016 11:44:50 +0000
X-OWM-Source-IP: 86.179.112.245 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2016.7.28.103916:17:7.944,ip=86.179.112.245,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __URI_NO_WWW, __CP_URI_IN_BODY, __SUBJ_ALPHA_NEGATE, __URI_IN_BODY, BODY_SIZE_5000_5999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, MULTIPLE_RCPTS_RND, RDNS_SUSP, IN_REP_TO, REFERENCES, BODY_SIZE_7000_LESS, MSG_THREAD, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.179.112.245) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5799EA7C0000E246; Thu, 28 Jul 2016 12:44:46 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Send thread names to debugger
Date: Thu, 28 Jul 2016 11:44:00 -0000
Message-Id: <20160728114341.1728-3-jon.turney@dronecode.org.uk>
In-Reply-To: <20160728114341.1728-1-jon.turney@dronecode.org.uk>
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00014.txt.bz2

GDB with the patch from [1] can report and use these names.

Add utility function SetThreadName(), which sends a thread name to the
debugger.

Wire this up to set the default thread name for main thread and newly
created pthreads.

Wire this up in pthread_setname_np() for user thread names.

Wire this up in cygthread::create() for helper thread names.  Also wire it
up for helper threads which are created directly with CreateThread.

TODO: Make SetThreadName() available to libgmon.a so the profiling thread
created by that can be named as well.

Note that there can still be anonymous threads, created by the kernel or
injected DLLs.

[1] https://sourceware.org/ml/gdb-patches/2016-07/msg00307.html

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/cygthread.cc  |  2 ++
 winsup/cygwin/dcrt0.cc      |  1 +
 winsup/cygwin/exceptions.cc |  2 +-
 winsup/cygwin/miscfuncs.cc  | 28 ++++++++++++++++++++++++++++
 winsup/cygwin/miscfuncs.h   |  2 ++
 winsup/cygwin/net.cc        |  2 ++
 winsup/cygwin/profil.c      |  2 ++
 winsup/cygwin/thread.cc     |  5 +++++
 8 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/cygthread.cc b/winsup/cygwin/cygthread.cc
index b9d706b..2f7f2a1 100644
--- a/winsup/cygwin/cygthread.cc
+++ b/winsup/cygwin/cygthread.cc
@@ -213,6 +213,8 @@ cygthread::create ()
 			    this, 0, &id);
       if (!htobe)
 	api_fatal ("CreateThread failed for %s - %p<%y>, %E", __name, h, id);
+      else
+	SetThreadName(GetThreadId(htobe), __name);
       thread_printf ("created name '%s', thread %p, id %y", __name, h, id);
 #ifdef DEBUGGING
       terminated = false;
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 2328411..de581c1 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -964,6 +964,7 @@ dll_crt0_1 (void *)
       if (cp > __progname && ascii_strcasematch (cp, ".exe"))
 	*cp = '\0';
     }
+  SetThreadName(GetCurrentThreadId(), program_invocation_short_name);
 
   (void) xdr_set_vprintf (&cygxdr_vwarnx);
   cygwin_finished_initializing = true;
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index d65f56e..1d028a7 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1288,7 +1288,7 @@ DWORD WINAPI
 dumpstack_overflow_wrapper (PVOID arg)
 {
   cygwin_exception *exc = (cygwin_exception *) arg;
-
+  SetThreadName(GetCurrentThreadId(), "dumpstack_overflow");
   exc->dumpstack ();
   return 0;
 }
diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index d0e4bf7..353633b 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -1110,3 +1110,31 @@ wmemcpy:								\n\
 	.seh_endproc							\n\
 ");
 #endif
+
+//
+// Signal the thread name to any attached debugger
+//
+// (See "How to: Set a Thread Name in Native Code"
+// https://msdn.microsoft.com/en-us/library/xcb2z8hs.aspx)
+//
+
+#define MS_VC_EXCEPTION 0x406D1388
+
+void
+SetThreadName(DWORD dwThreadID, const char* threadName)
+{
+  if (!IsDebuggerPresent ())
+    return;
+
+  ULONG_PTR info[] =
+    {
+      0x1000,                /* type, must be 0x1000 */
+      (ULONG_PTR)threadName, /* pointer to threadname */
+      dwThreadID,            /* thread ID (+ flags on x86_64) */
+#ifdef __X86__
+      0,                     /* flags, must be zero */
+#endif
+    };
+
+  RaiseException (MS_VC_EXCEPTION, 0, sizeof(info)/sizeof(ULONG_PTR), (ULONG_PTR *) &info);
+}
diff --git a/winsup/cygwin/miscfuncs.h b/winsup/cygwin/miscfuncs.h
index a885dcf..5390dd1 100644
--- a/winsup/cygwin/miscfuncs.h
+++ b/winsup/cygwin/miscfuncs.h
@@ -85,4 +85,6 @@ extern "C" HANDLE WINAPI CygwinCreateThread (LPTHREAD_START_ROUTINE thread_func,
 					     DWORD creation_flags,
 					     LPDWORD thread_id);
 
+void SetThreadName(DWORD dwThreadID, const char* threadName);
+
 #endif /*_MISCFUNCS_H*/
diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 52b3d98..94ae604 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -1776,6 +1776,8 @@ call_gaa (LPVOID param)
   gaa_wa *p = (gaa_wa *) param;
   PIP_ADAPTER_ADDRESSES pa0 = NULL;
 
+  SetThreadName(GetCurrentThreadId(), "call_gaa");
+
   if (!p->pa_ret)
     return GetAdaptersAddresses (p->family, GAA_FLAG_INCLUDE_PREFIX
 					    | GAA_FLAG_INCLUDE_ALL_INTERFACES,
diff --git a/winsup/cygwin/profil.c b/winsup/cygwin/profil.c
index be59b49..4b2e873 100644
--- a/winsup/cygwin/profil.c
+++ b/winsup/cygwin/profil.c
@@ -91,6 +91,8 @@ static void CALLBACK
 profthr_func (LPVOID arg)
 {
   struct profinfo *p = (struct profinfo *) arg;
+  // XXX: can't use SetThreadName() here as it's part of the cygwin DLL
+  // SetThreadName(GetCurrentThreadId(), "prof");
 
   for (;;)
     {
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index e41e0c1..7f60db7 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1985,6 +1985,9 @@ pthread::thread_init_wrapper (void *arg)
   _my_tls.sigmask = thread->parent_sigmask;
   thread->set_tls_self_pointer ();
 
+  // Give thread default name
+  SetThreadName(GetCurrentThreadId(), program_invocation_short_name);
+
   thread->mutex.lock ();
 
   // if thread is detached force cleanup on exit
@@ -2622,6 +2625,8 @@ pthread_setname_np (pthread_t thread, const char *name)
   oldname = thread->attr.name;
   thread->attr.name = cp;
 
+  SetThreadName(GetThreadId(thread->win32_obj_id), thread->attr.name);
+
   if (oldname)
     free(oldname);
 
-- 
2.8.3
