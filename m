Return-Path: <cygwin-patches-return-8614-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91098 invoked by alias); 22 Aug 2016 18:09:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90953 invoked by uid 89); 22 Aug 2016 18:09:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=Hx-spam-relays-external:CriticalPath, H*RU:CriticalPath, HCc:D*uk, injected
X-HELO: rgout0306.bt.lon5.cpcloud.co.uk
Received: from rgout0306.bt.lon5.cpcloud.co.uk (HELO rgout0306.bt.lon5.cpcloud.co.uk) (65.20.0.212) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Aug 2016 18:09:32 +0000
X-OWM-Source-IP: 86.166.190.87 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2016.8.22.165416:17:7.944,ip=86.166.190.87,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, __URI_NO_MAILTO, __URI_NO_WWW, __CP_URI_IN_BODY, __SUBJ_ALPHA_NEGATE, __URI_IN_BODY, BODY_SIZE_5000_5999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, __FROM_DOMAIN_IN_RCPT, RDNS_SUSP, IN_REP_TO, REFERENCES, BODY_SIZE_7000_LESS, MSG_THREAD, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.166.190.87) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57BB330F0001F003; Mon, 22 Aug 2016 19:09:29 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Send thread names to debugger
Date: Mon, 22 Aug 2016 18:09:00 -0000
Message-Id: <20160822180848.351616-3-jon.turney@dronecode.org.uk>
In-Reply-To: <20160822180848.351616-1-jon.turney@dronecode.org.uk>
References: <20160822180848.351616-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00022.txt.bz2

GDB since commit 24cdb46e [1] can report and use these names.

Add utility function SetThreadName(), which sends a thread name to the
debugger.

Use that:
- to set the default thread name for main thread and newly created pthreads.
- in pthread_setname_np() for user thread names.
- for helper thread names in cygthread::create()
- for helper threads which are created directly with CreateThread.

Note that there can still be anonymous threads, created by system or
injected DLLs.

[1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=24cdb46e9f0a694b4fbc11085e094857f08c0419
---
 winsup/cygwin/cygthread.cc  |  2 ++
 winsup/cygwin/dcrt0.cc      |  1 +
 winsup/cygwin/exceptions.cc |  2 +-
 winsup/cygwin/miscfuncs.cc  | 26 ++++++++++++++++++++++++++
 winsup/cygwin/miscfuncs.h   |  2 ++
 winsup/cygwin/net.cc        |  1 +
 winsup/cygwin/thread.cc     |  5 +++++
 7 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/cygthread.cc b/winsup/cygwin/cygthread.cc
index b9d706b..4404e4a 100644
--- a/winsup/cygwin/cygthread.cc
+++ b/winsup/cygwin/cygthread.cc
@@ -213,6 +213,8 @@ cygthread::create ()
 			    this, 0, &id);
       if (!htobe)
 	api_fatal ("CreateThread failed for %s - %p<%y>, %E", __name, h, id);
+      else
+	SetThreadName (GetThreadId (htobe), __name);
       thread_printf ("created name '%s', thread %p, id %y", __name, h, id);
 #ifdef DEBUGGING
       terminated = false;
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 2328411..8ddee0c 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -964,6 +964,7 @@ dll_crt0_1 (void *)
       if (cp > __progname && ascii_strcasematch (cp, ".exe"))
 	*cp = '\0';
     }
+  SetThreadName (GetCurrentThreadId (), program_invocation_short_name);
 
   (void) xdr_set_vprintf (&cygxdr_vwarnx);
   cygwin_finished_initializing = true;
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index d65f56e..0f5a890 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1288,7 +1288,7 @@ DWORD WINAPI
 dumpstack_overflow_wrapper (PVOID arg)
 {
   cygwin_exception *exc = (cygwin_exception *) arg;
-
+  SetThreadName (GetCurrentThreadId (), "__dumpstack_overflow");
   exc->dumpstack ();
   return 0;
 }
diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index d0e4bf7..5a63b26 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -1110,3 +1110,29 @@ wmemcpy:								\n\
 	.seh_endproc							\n\
 ");
 #endif
+
+/* Signal the thread name to any attached debugger
+
+   (See "How to: Set a Thread Name in Native Code"
+   https://msdn.microsoft.com/en-us/library/xcb2z8hs.aspx) */
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
+      0x1000,                 /* type, must be 0x1000 */
+      (ULONG_PTR) threadName, /* pointer to threadname */
+      dwThreadID,             /* thread ID (+ flags on x86_64) */
+#ifdef __X86__
+      0,                      /* flags, must be zero */
+#endif
+    };
+
+  RaiseException (MS_VC_EXCEPTION, 0, sizeof (info)/sizeof (ULONG_PTR), (ULONG_PTR *) &info);
+}
diff --git a/winsup/cygwin/miscfuncs.h b/winsup/cygwin/miscfuncs.h
index a885dcf..5087299 100644
--- a/winsup/cygwin/miscfuncs.h
+++ b/winsup/cygwin/miscfuncs.h
@@ -85,4 +85,6 @@ extern "C" HANDLE WINAPI CygwinCreateThread (LPTHREAD_START_ROUTINE thread_func,
 					     DWORD creation_flags,
 					     LPDWORD thread_id);
 
+void SetThreadName (DWORD dwThreadID, const char* threadName);
+
 #endif /*_MISCFUNCS_H*/
diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index 52b3d98..e4805d3 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -1819,6 +1819,7 @@ get_adapters_addresses (PIP_ADAPTER_ADDRESSES *pa_ret, ULONG family)
 	 The OS allocates stacks bottom up, so chances are good that the new
 	 stack will be located in the lower address area. */
       HANDLE thr = CreateThread (NULL, 0, call_gaa, &param, 0, NULL);
+      SetThreadName (GetThreadId (thr), "__call_gaa");
       if (!thr)
 	{
 	  debug_printf ("CreateThread: %E");
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index fac801b..1205ce3 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1992,6 +1992,9 @@ pthread::thread_init_wrapper (void *arg)
   _my_tls.sigmask = thread->parent_sigmask;
   thread->set_tls_self_pointer ();
 
+  // Give thread default name
+  SetThreadName (GetCurrentThreadId (), program_invocation_short_name);
+
   thread->mutex.lock ();
 
   // if thread is detached force cleanup on exit
@@ -2630,6 +2633,8 @@ pthread_setname_np (pthread_t thread, const char *name)
   oldname = thread->attr.name;
   thread->attr.name = cp;
 
+  SetThreadName (GetThreadId (thread->win32_obj_id), thread->attr.name);
+
   if (oldname)
     free (oldname);
 
-- 
2.8.3
