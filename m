Return-Path: <cygwin-patches-return-7369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1365 invoked by alias); 17 May 2011 09:11:04 -0000
Received: (qmail 1349 invoked by uid 22791); 17 May 2011 09:11:00 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-iw0-f171.google.com (HELO mail-iw0-f171.google.com) (209.85.214.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 17 May 2011 09:10:43 +0000
Received: by iwn8 with SMTP id 8so328003iwn.2        for <cygwin-patches@cygwin.com>; Tue, 17 May 2011 02:10:42 -0700 (PDT)
Received: by 10.42.168.4 with SMTP id u4mr140694icy.316.1305623442761;        Tue, 17 May 2011 02:10:42 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id vr5sm167789icb.0.2011.05.17.02.10.40        (version=SSLv3 cipher=OTHER);        Tue, 17 May 2011 02:10:41 -0700 (PDT)
Subject: Re: [PATCH] CPU-time clocks
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Tue, 17 May 2011 09:11:00 -0000
In-Reply-To: <20110517055858.GA9013@calimero.vinschen.de>
References: <1305484641.6124.31.camel@YAAKOV04>	 <20110515191123.GC21667@calimero.vinschen.de>	 <1305487887.6000.1.camel@YAAKOV04>	 <20110516104304.GA5248@calimero.vinschen.de>	 <1305587458.4248.3.camel@YAAKOV04>	 <20110517055858.GA9013@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-ADFcXU9nOmoI3a+mYgCO"
Message-ID: <1305623445.7016.1.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00135.txt.bz2


--=-ADFcXU9nOmoI3a+mYgCO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1118

On Tue, 2011-05-17 at 07:58 +0200, Corinna Vinschen wrote:
> Thank you.  You can apply it, but while I was looking into it,
> this occured to me:
> 
> This conversion arithmetic from FILETIME to long long happens a lot
> in times.cc, even though it's absolutely not necessary.
> 
> The FILETIME struct is actually a LARGE_INTEGER in which just the
> QuadPart member is missing, unfortunately.  What we can do is to
> replace the bit shifting stuff with a simple cast:
> 
>   x = ((PLARGE_INTEGER) &kernel_time)->QuadPart
>       + ((PLARGE_INTEGER) &user_time)->QuadPart;

The MSDN docs on FILETIME[1] state:

> Do not cast a pointer to a FILETIME structure to either a ULARGE_INTEGER*
> or __int64* value because it can cause alignment faults on 64-bit Windows.

As I am by no means an expert on Win32 programming, I take that at face
value.

> Alternatively we can define kernel_time etc as LARGE_INTEGER and cast in
> the call to GetProcessTimes or just call NtQueryInformationProcess.

I have chosen the latter.  Revised patch attached.


Yaakov


[1] http://msdn.microsoft.com/en-us/library/ms724284(VS.85).aspx


--=-ADFcXU9nOmoI3a+mYgCO
Content-Disposition: attachment; filename="cpuclockid.patch"
Content-Type: text/x-patch; name="cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 12696

2011-05-17  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (clock_getcpuclockid): Export.
	(pthread_getcpuclockid): Export.
	* hires.h (PID_TO_CLOCKID): New macro.
	(CLOCKID_TO_PID): New macro.
	(CLOCKID_IS_PROCESS): New macro.
	(THREADID_TO_CLOCKID): New macro.
	(CLOCKID_TO_THREADID): New macro.
	(CLOCKID_IS_THREAD): New macro.
	* ntdll.h (enum _THREAD_INFORMATION_CLASS): Add ThreadTimes.
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
	* include/pthread.h (pthread_getcpuclockid): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.241
diff -u -r1.241 cygwin.din
--- cygwin.din	15 May 2011 18:49:39 -0000	1.241
+++ cygwin.din	17 May 2011 08:57:52 -0000
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
Index: hires.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hires.h,v
retrieving revision 1.18
diff -u -r1.18 hires.h
--- hires.h	30 Mar 2011 21:54:09 -0000	1.18
+++ hires.h	17 May 2011 08:57:52 -0000
@@ -13,6 +13,14 @@
 
 #include <mmsystem.h>
 
+/* Conversions for per-process and per-thread clocks */
+#define PID_TO_CLOCKID(pid) (pid * 8 + CLOCK_PROCESS_CPUTIME_ID)
+#define CLOCKID_TO_PID(cid) ((cid - CLOCK_PROCESS_CPUTIME_ID) / 8)
+#define CLOCKID_IS_PROCESS(cid) ((cid % 8) == CLOCK_PROCESS_CPUTIME_ID)
+#define THREADID_TO_CLOCKID(tid) (tid * 8 + CLOCK_THREAD_CPUTIME_ID)
+#define CLOCKID_TO_THREADID(cid) ((cid - CLOCK_THREAD_CPUTIME_ID) / 8)
+#define CLOCKID_IS_THREAD(cid) ((cid % 8) == CLOCK_THREAD_CPUTIME_ID)
+
 /* Largest delay in ms for sleep and alarm calls.
    Allow actual delay to exceed requested delay by 10 s.
    Express as multiple of 1000 (i.e. seconds) + max resolution
Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.119
diff -u -r1.119 ntdll.h
--- ntdll.h	15 May 2011 18:49:39 -0000	1.119
+++ ntdll.h	17 May 2011 08:57:52 -0000
@@ -938,6 +938,7 @@
 typedef enum _THREAD_INFORMATION_CLASS
 {
   ThreadBasicInformation = 0,
+  ThreadTimes = 1,
   ThreadImpersonationToken = 5
 } THREAD_INFORMATION_CLASS, *PTHREAD_INFORMATION_CLASS;
 
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.63
diff -u -r1.63 posix.sgml
--- posix.sgml	15 May 2011 18:49:39 -0000	1.63
+++ posix.sgml	17 May 2011 08:57:52 -0000
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
+++ sysconf.cc	17 May 2011 08:57:52 -0000
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
+++ thread.cc	17 May 2011 08:57:53 -0000
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
+++ timer.cc	17 May 2011 08:57:53 -0000
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
+++ times.cc	17 May 2011 08:57:53 -0000
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
 
@@ -594,6 +596,63 @@
 extern "C" int
 clock_gettime (clockid_t clk_id, struct timespec *tp)
 {
+  if (CLOCKID_IS_PROCESS (clk_id))
+    {
+      pid_t pid = CLOCKID_TO_PID (clk_id);
+      HANDLE hProcess;
+      KERNEL_USER_TIMES kut;
+      ULONG sizeof_kut = sizeof (KERNEL_USER_TIMES);
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
+      NtQueryInformationProcess (hProcess, ProcessTimes, &kut, sizeof_kut, &sizeof_kut);
+
+      x = kut.KernelTime.QuadPart + kut.UserTime.QuadPart;
+      tp->tv_sec = x / (long long) NSPERSEC;
+      tp->tv_nsec = (x % (long long) NSPERSEC) * 100LL;
+
+      CloseHandle (hProcess);
+      return 0;
+    }
+
+  if (CLOCKID_IS_THREAD (clk_id))
+    {
+      long thr_id = CLOCKID_TO_THREADID (clk_id);
+      HANDLE hThread;
+      KERNEL_USER_TIMES kut;
+      ULONG sizeof_kut = sizeof (KERNEL_USER_TIMES);
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
+      NtQueryInformationThread (hThread, ThreadTimes, &kut, sizeof_kut, &sizeof_kut);
+
+      x = kut.KernelTime.QuadPart + kut.UserTime.QuadPart;
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
@@ -630,6 +689,16 @@
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
@@ -702,6 +771,16 @@
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
@@ -776,3 +855,12 @@
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
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.32
diff -u -r1.32 pthread.h
--- include/pthread.h	15 May 2011 18:49:40 -0000	1.32
+++ include/pthread.h	17 May 2011 08:57:53 -0000
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
+++ include/cygwin/version.h	17 May 2011 08:57:53 -0000
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

--=-ADFcXU9nOmoI3a+mYgCO--
