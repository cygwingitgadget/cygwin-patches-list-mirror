Return-Path: <cygwin-patches-return-7365-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18470 invoked by alias); 15 May 2011 19:31:47 -0000
Received: (qmail 18459 invoked by uid 22791); 15 May 2011 19:31:45 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 15 May 2011 19:31:26 +0000
Received: by yie16 with SMTP id 16so1612331yie.2        for <cygwin-patches@cygwin.com>; Sun, 15 May 2011 12:31:25 -0700 (PDT)
Received: by 10.91.160.2 with SMTP id m2mr2881558ago.26.1305487885177;        Sun, 15 May 2011 12:31:25 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id q8sm3362462ann.19.2011.05.15.12.31.23        (version=SSLv3 cipher=OTHER);        Sun, 15 May 2011 12:31:24 -0700 (PDT)
Subject: Re: [PATCH] CPU-time clocks
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 15 May 2011 19:31:00 -0000
In-Reply-To: <20110515191123.GC21667@calimero.vinschen.de>
References: <1305484641.6124.31.camel@YAAKOV04>	 <20110515191123.GC21667@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-+3v+kk+o0jFX6qahqR2U"
Message-ID: <1305487887.6000.1.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00131.txt.bz2


--=-+3v+kk+o0jFX6qahqR2U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 312

On Sun, 2011-05-15 at 21:11 +0200, Corinna Vinschen wrote:
> I just applied a patch to implement pthread_attr_setstack etc.

Yes, I just saw that, thank you.

> This affects your patch in that it won't apply cleanly anymore.
> Would you mind to regenerate your patches relative to CVS HEAD?

Attached.


Yaakov


--=-+3v+kk+o0jFX6qahqR2U
Content-Disposition: attachment; filename="cpuclockid.patch"
Content-Type: text/x-patch; name="cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 12440

2011-05-15  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (clock_getcpuclockid): Export.
	(pthread_getcpuclockid): Export.
	* posix.sgml (std-notimpl): Add clock_getcpuclockid and
	pthread_getcpuclockid from here...
	(std-susv4): ... to here.
	(std-notes): Remove limitations of clock_getres and clock_gettime.
	Note limitation of timer_create to CLOCK_REALTIME.
	* sysconf.cc (sca): Set _SC_CPUTIME to _POSIX_CPUTIME, and
	_SC_THREAD_CPUTIME to _POSIX_THREAD_CPUTIME.
	* thread.cc (pthread_getcpuclockid): New function.
	* timer.cc (timer_create): Set errno to ENOTSUP for CPU-time clocks.
	* times.cc (clock_gettime): Handle CLOCK_PROCESS_CPUTIME_ID and
	CLOCK_THREAD_CPUTIME_ID.
	(clock_getres): Ditto.
	(clock_settime): Set errno to EPERM for CPU-time clocks.
	(clock_getcpuclockid): New function.
	* winsup.h (PID_TO_CLOCKID): New macro.
	(CLOCKID_TO_PID): New macro.
	(CLOCKID_IS_PROCESS): New macro.
	(THREADID_TO_CLOCKID): New macro.
	(CLOCKID_TO_THREADID): New macro.
	(CLOCKID_IS_THREAD): New macro.
	* include/pthread.h (pthread_getcpuclockid): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.241
diff -u -r1.241 cygwin.din
--- cygwin.din	15 May 2011 18:49:39 -0000	1.241
+++ cygwin.din	15 May 2011 19:24:11 -0000
@@ -217,6 +217,7 @@
 _clearerr = clearerr SIGFE
 clock SIGFE
 _clock = clock SIGFE
+clock_getcpuclockid SIGFE
 clock_getres SIGFE
 clock_gettime SIGFE
 clock_setres SIGFE
@@ -1212,6 +1213,7 @@
 pthread_exit SIGFE
 pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
+pthread_getcpuclockid SIGFE
 pthread_getschedparam SIGFE
 pthread_getsequence_np SIGFE
 pthread_getspecific SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.63
diff -u -r1.63 posix.sgml
--- posix.sgml	15 May 2011 18:49:39 -0000	1.63
+++ posix.sgml	15 May 2011 19:24:11 -0000
@@ -90,8 +90,9 @@
     cimagf
     clearerr
     clock
-    clock_getres		(see chapter "Implementation Notes")
-    clock_gettime		(see chapter "Implementation Notes")
+    clock_getcpuclockid
+    clock_getres
+    clock_gettime
     clock_settime		(see chapter "Implementation Notes")
     clog
     clogf
@@ -564,6 +565,7 @@
     pthread_equal
     pthread_exit
     pthread_getconcurrency
+    pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
     pthread_join
@@ -836,7 +838,7 @@
     tgamma
     tgammaf
     time
-    timer_create
+    timer_create		(see chapter "Implementation Notes")
     timer_delete
     timer_gettime
     timer_settime
@@ -1292,7 +1294,6 @@
     ceill
     cexpl
     cimagl
-    clock_getcpuclockid
     clogl
     conjl
     copysignl
@@ -1386,7 +1387,6 @@
     pthread_barrier[...]
     pthread_condattr_getclock
     pthread_condattr_setclock
-    pthread_getcpuclockid
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
@@ -1441,9 +1441,8 @@
 related function calls.  A real chroot functionality is not supported by
 Windows however.</para>
 
-<para><function>clock_getres</function> and <function>clock_gettime</function>
-only support CLOCK_REALTIME and CLOCK_MONOTONIC for now.  <function>clock_setres</function>
-and <function>clock_settime</function> only support CLOCK_REALTIME.</para>
+<function>clock_setres</function>, <function>clock_settime</function>, and
+<function>timer_create</function> only support CLOCK_REALTIME.</para>
 
 <para>BSD file locks created via <function>flock</function> are not
 propagated to the parent process and sibling processes.  The locks are
Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.57
diff -u -r1.57 sysconf.cc
--- sysconf.cc	15 May 2011 18:49:39 -0000	1.57
+++ sysconf.cc	15 May 2011 19:24:12 -0000
@@ -160,7 +160,7 @@
   {cons, {c:BC_STRING_MAX}},		/*  60, _SC_BC_STRING_MAX */
   {cons, {c:-1L}},			/*  61, _SC_CLOCK_SELECTION */
   {nsup, {c:0}},			/*  62, _SC_COLL_WEIGHTS_MAX */
-  {cons, {c:-1L}},			/*  63, _SC_CPUTIME */
+  {cons, {c:_POSIX_CPUTIME}},		/*  63, _SC_CPUTIME */
   {cons, {c:EXPR_NEST_MAX}},		/*  64, _SC_EXPR_NEST_MAX */
   {cons, {c:HOST_NAME_MAX}},		/*  65, _SC_HOST_NAME_MAX */
   {cons, {c:IOV_MAX}},			/*  66, _SC_IOV_MAX */
@@ -177,7 +177,7 @@
   {cons, {c:-1L}},			/*  77, _SC_SPORADIC_SERVER */
   {nsup, {c:0}},			/*  78, _SC_SS_REPL_MAX */
   {cons, {c:SYMLOOP_MAX}},		/*  79, _SC_SYMLOOP_MAX */
-  {cons, {c:-1L}},			/*  80, _SC_THREAD_CPUTIME */
+  {cons, {c:_POSIX_THREAD_CPUTIME}},	/*  80, _SC_THREAD_CPUTIME */
   {cons, {c:-1L}},			/*  81, _SC_THREAD_SPORADIC_SERVER */
   {cons, {c:-1L}},			/*  82, _SC_TIMEOUTS */
   {cons, {c:-1L}},			/*  83, _SC_TRACE */
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.239
diff -u -r1.239 thread.cc
--- thread.cc	15 May 2011 18:49:40 -0000	1.239
+++ thread.cc	15 May 2011 19:24:12 -0000
@@ -2510,6 +2510,15 @@
   return MT_INTERFACE->concurrency;
 }
 
+extern "C" int
+pthread_getcpuclockid (pthread_t thread, clockid_t *clk_id)
+{
+  if (!pthread::is_good_object (&thread))
+    return (ESRCH);
+  *clk_id = (clockid_t) THREADID_TO_CLOCKID (thread->getsequence_np ());
+  return 0;
+}
+
 /* keep this in sync with sched.cc */
 extern "C" int
 pthread_getschedparam (pthread_t thread, int *policy,
Index: timer.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/timer.cc,v
retrieving revision 1.26
diff -u -r1.26 timer.cc
--- timer.cc	1 Sep 2010 18:24:11 -0000	1.26
+++ timer.cc	15 May 2011 19:24:12 -0000
@@ -300,6 +300,13 @@
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
+
+  if (CLOCKID_IS_PROCESS (clock_id) || CLOCKID_IS_THREAD (clock_id))
+    {
+      set_errno (ENOTSUP);
+      return -1;
+    }
+
   if (clock_id != CLOCK_REALTIME)
     {
       set_errno (EINVAL);
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.108
diff -u -r1.108 times.cc
--- times.cc	9 May 2011 08:57:46 -0000	1.108
+++ times.cc	15 May 2011 19:24:12 -0000
@@ -15,6 +15,7 @@
 #include <sys/timeb.h>
 #include <utime.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -22,6 +23,7 @@
 #include "dtable.h"
 #include "cygheap.h"
 #include "pinfo.h"
+#include "thread.h"
 #include "cygtls.h"
 #include "ntdll.h"
 
@@ -594,6 +596,62 @@
 extern "C" int
 clock_gettime (clockid_t clk_id, struct timespec *tp)
 {
+  if (CLOCKID_IS_PROCESS (clk_id))
+    {
+      FILETIME creation_time, exit_time, kernel_time, user_time;
+      pid_t pid = CLOCKID_TO_PID (clk_id);
+      HANDLE hProcess;
+      long long x;
+
+      if (pid == 0)
+        pid = getpid ();
+
+      pinfo p (pid);
+      if (!p->exists ())
+        {
+          set_errno (EINVAL);
+          return -1;
+        }
+
+      hProcess = OpenProcess (PROCESS_QUERY_INFORMATION, 0, p->dwProcessId);
+      GetProcessTimes (hProcess, &creation_time, &exit_time, &kernel_time, &user_time);
+
+      x = ((long long) kernel_time.dwHighDateTime << 32) + ((unsigned) kernel_time.dwLowDateTime)
+          + ((long long) user_time.dwHighDateTime << 32) + ((unsigned) user_time.dwLowDateTime);
+      tp->tv_sec = x / (long long) NSPERSEC;
+      tp->tv_nsec = (x % (long long) NSPERSEC) * 100LL;
+
+      CloseHandle (hProcess);
+      return 0;
+    }
+
+  if (CLOCKID_IS_THREAD (clk_id))
+    {
+      FILETIME creation_time, exit_time, kernel_time, user_time;
+      long thr_id = CLOCKID_TO_THREADID (clk_id);
+      HANDLE hThread;
+      long long x;
+
+      if (thr_id == 0)
+        thr_id = pthread::self ()->getsequence_np ();
+
+      hThread = OpenThread (THREAD_QUERY_INFORMATION, 0, thr_id);
+      if (!hThread)
+        {
+          set_errno (EINVAL);
+          return -1;
+        }
+
+      GetThreadTimes (hThread, &creation_time, &exit_time, &kernel_time, &user_time);
+      x = ((long long) kernel_time.dwHighDateTime << 32) + ((unsigned) kernel_time.dwLowDateTime)
+          + ((long long) user_time.dwHighDateTime << 32) + ((unsigned) user_time.dwLowDateTime);
+      tp->tv_sec = x / (long long) NSPERSEC;
+      tp->tv_nsec = (x % (long long) NSPERSEC) * 100LL;
+
+      CloseHandle (hThread);
+      return 0;
+    }
+
   switch (clk_id)
     {
       case CLOCK_REALTIME:
@@ -630,6 +688,16 @@
 {
   struct timeval tv;
 
+  if (CLOCKID_IS_PROCESS (clk_id) || CLOCKID_IS_THREAD (clk_id))
+    /* According to POSIX, the privileges to set a particular clock
+     * are implementation-defined.  On Linux, CPU-time clocks are not
+     * settable; do the same here.
+     */
+    {
+      set_errno (EPERM);
+      return -1;
+    }
+
   if (clk_id != CLOCK_REALTIME)
     {
       set_errno (EINVAL);
@@ -702,6 +770,16 @@
 extern "C" int
 clock_getres (clockid_t clk_id, struct timespec *tp)
 {
+  if (CLOCKID_IS_PROCESS (clk_id) || CLOCKID_IS_THREAD (clk_id))
+    {
+      ULONG coarsest, finest, actual;
+
+      NtQueryTimerResolution (&coarsest, &finest, &actual);
+      tp->tv_sec = coarsest / NSPERSEC;
+      tp->tv_nsec = (coarsest % NSPERSEC) * 100;
+      return 0;
+    }
+
   switch (clk_id)
     {
       case CLOCK_REALTIME:
@@ -776,3 +854,12 @@
   period_set = true;
   return 0;
 }
+
+extern "C" int
+clock_getcpuclockid (pid_t pid, clockid_t *clk_id)
+{
+  if (pid != 0 && !pinfo (pid)->exists ())
+    return (ESRCH);
+  *clk_id = (clockid_t) PID_TO_CLOCKID (pid);
+  return 0;
+}
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.235
diff -u -r1.235 winsup.h
--- winsup.h	19 Apr 2011 10:02:06 -0000	1.235
+++ winsup.h	15 May 2011 19:24:12 -0000
@@ -220,6 +220,13 @@
 void *hook_or_detect_cygwin (const char *, const void *, WORD&) __attribute__ ((regparm (3)));
 
 /* Time related */
+#define PID_TO_CLOCKID(pid) (pid * 8 + CLOCK_PROCESS_CPUTIME_ID)
+#define CLOCKID_TO_PID(cid) ((cid - CLOCK_PROCESS_CPUTIME_ID) / 8)
+#define CLOCKID_IS_PROCESS(cid) ((cid % 8) == CLOCK_PROCESS_CPUTIME_ID)
+#define THREADID_TO_CLOCKID(tid) (tid * 8 + CLOCK_THREAD_CPUTIME_ID)
+#define CLOCKID_TO_THREADID(cid) ((cid - CLOCK_THREAD_CPUTIME_ID) / 8)
+#define CLOCKID_IS_THREAD(cid) ((cid % 8) == CLOCK_THREAD_CPUTIME_ID)
+
 void __stdcall totimeval (struct timeval *, FILETIME *, int, int);
 long __stdcall to_time_t (FILETIME *);
 void __stdcall to_timestruc_t (FILETIME *, timestruc_t *);
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.32
diff -u -r1.32 pthread.h
--- include/pthread.h	15 May 2011 18:49:40 -0000	1.32
+++ include/pthread.h	15 May 2011 19:24:12 -0000
@@ -141,6 +141,7 @@
 int pthread_detach (pthread_t);
 int pthread_equal (pthread_t, pthread_t);
 void pthread_exit (void *);
+int pthread_getcpuclockid (pthread_t, clockid_t *);
 int pthread_getschedparam (pthread_t, int *, struct sched_param *);
 void *pthread_getspecific (pthread_key_t);
 int pthread_join (pthread_t, void **);
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.346
diff -u -r1.346 version.h
--- include/cygwin/version.h	15 May 2011 18:49:40 -0000	1.346
+++ include/cygwin/version.h	15 May 2011 19:24:12 -0000
@@ -412,12 +412,14 @@
       244: Export clock_settime.
       245: Export pthread_attr_getguardsize, pthread_attr_setguardsize,
 	   pthread_attr_setstack, pthread_attr_setstackaddr.
+      246: Add CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID.
+	   Export clock_getcpuclockid, pthread_getcpuclockid.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 245
+#define CYGWIN_VERSION_API_MINOR 246
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-+3v+kk+o0jFX6qahqR2U
Content-Disposition: attachment; filename="doc-cpuclockid.patch"
Content-Type: text/x-patch; name="doc-cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1565

2011-05-15  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document CPU-time clock support.
	Move pthread stack management APIs to separate listitem.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.81
diff -u -r1.81 new-features.sgml
--- new-features.sgml	15 May 2011 18:51:49 -0000	1.81
+++ new-features.sgml	15 May 2011 19:26:48 -0000
@@ -19,6 +19,18 @@
 </para></listitem>
 
 <listitem><para>
+Pthread stack address management.  New APIs: pthread_attr_getstack,
+pthread_attr_getstackaddr, pthread_attr_getguardsize, pthread_attr_setstack,
+pthread_attr_setstackaddr, pthread_attr_setguardsize, pthread_getattr_np.
+</para></listitem>
+
+<listitem><para>
+clock_gettime(3) and clock_getres(3) accept per-process and per-thread CPU-time
+clocks, including CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
+New APIs: clock_getcpuclockid, pthread_getcpuclockid.
+</para></listitem>
+
+<listitem><para>
 /proc/loadavg now shows the number of currently running processes and the
 total number of processes.
 </para></listitem>
@@ -40,9 +52,7 @@
 
 <listitem><para>
 Other new API: clock_settime, ppoll, psiginfo, psignal, sys_siglist,
-pthread_attr_getstack, pthread_attr_getstackaddr, pthread_attr_getguardsize,
-pthread_attr_setstack, pthread_attr_setstackaddr, pthread_attr_setguardsize,
-pthread_getattr_np, pthread_setschedprio, sysinfo.
+pthread_setschedprio, sysinfo.
 </para></listitem>
 
 </itemizedlist>

--=-+3v+kk+o0jFX6qahqR2U
Content-Disposition: attachment; filename="newlib-cpuclockid.patch"
Content-Type: text/x-patch; name="newlib-cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2116

2011-05-15  Yaakov Selkowitz  <yselkowitz@...>

	* libc/include/time.h (CLOCK_PROCESS_CPUTIME_ID): Rename from
	CLOCK_PROCESS_CPUTIME.
	(CLOCK_THREAD_CPUTIME_ID): Rename from CLOCK_THREAD_CPUTIME.
	* libc/include/sys/features.h [__CYGWIN__] (_POSIX_CPUTIME): Define.
	(_POSIX_THREAD_CPUTIME): Define.

Index: libc/include/time.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/time.h,v
retrieving revision 1.19
diff -u -r1.19 time.h
--- libc/include/time.h	16 Oct 2008 21:53:58 -0000	1.19
+++ libc/include/time.h	15 May 2011 19:28:27 -0000
@@ -212,7 +212,7 @@
    the identifier of the CPU_time clock associated with the PROCESS
    making the function call.  */
 
-#define CLOCK_PROCESS_CPUTIME (clockid_t)2
+#define CLOCK_PROCESS_CPUTIME_ID (clockid_t)2
 
 #endif
 
@@ -222,7 +222,7 @@
     the identifier of the CPU_time clock associated with the THREAD
     making the function call.  */
 
-#define CLOCK_THREAD_CPUTIME (clockid_t)3
+#define CLOCK_THREAD_CPUTIME_ID (clockid_t)3
 
 #endif
 
Index: libc/include/sys/features.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/features.h,v
retrieving revision 1.25
diff -u -r1.25 features.h
--- libc/include/sys/features.h	15 May 2011 18:50:52 -0000	1.25
+++ libc/include/sys/features.h	15 May 2011 19:28:27 -0000
@@ -103,7 +103,7 @@
 /* #define _POSIX_BARRIERS			    -1 */
 #define _POSIX_CHOWN_RESTRICTED			     1
 /* #define _POSIX_CLOCK_SELECTION		    -1 */
-/* #define _POSIX_CPUTIME			    -1 */
+#define _POSIX_CPUTIME			    	200112L
 #define _POSIX_FSYNC				200112L
 #define _POSIX_IPV6				200112L
 #define _POSIX_JOB_CONTROL			     1
@@ -130,7 +130,7 @@
 #define _POSIX_SYNCHRONIZED_IO			200112L
 #define _POSIX_THREAD_ATTR_STACKADDR		200112L
 #define _POSIX_THREAD_ATTR_STACKSIZE		200112L
-/* #define _POSIX_THREAD_CPUTIME		    -1 */
+#define _POSIX_THREAD_CPUTIME			200112L
 /* #define _POSIX_THREAD_PRIO_INHERIT		    -1 */
 /* #define _POSIX_THREAD_PRIO_PROTECT		    -1 */
 #define _POSIX_THREAD_PRIORITY_SCHEDULING	200112L

--=-+3v+kk+o0jFX6qahqR2U--
