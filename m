Return-Path: <cygwin-patches-return-7363-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31852 invoked by alias); 15 May 2011 18:37:42 -0000
Received: (qmail 31839 invoked by uid 22791); 15 May 2011 18:37:39 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_LR,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 15 May 2011 18:37:21 +0000
Received: by ywa6 with SMTP id 6so1736840ywa.2        for <cygwin-patches@cygwin.com>; Sun, 15 May 2011 11:37:21 -0700 (PDT)
Received: by 10.236.201.232 with SMTP id b68mr3257920yho.358.1305484639135;        Sun, 15 May 2011 11:37:19 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id j15sm3331947ank.5.2011.05.15.11.37.17        (version=SSLv3 cipher=OTHER);        Sun, 15 May 2011 11:37:18 -0700 (PDT)
Subject: [PATCH] CPU-time clocks
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Sun, 15 May 2011 18:37:00 -0000
Content-Type: multipart/mixed; boundary="=-WsPxR3RBridggBsarc9p"
Message-ID: <1305484641.6124.31.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00129.txt.bz2


--=-WsPxR3RBridggBsarc9p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2162

The attached patches implement POSIX CPU-time clock support:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_getcpuclockid.html
http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_getcpuclockid.html
http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_gettime.html
http://www.kernel.org/doc/man-pages/online/pages/man3/clock_getcpuclockid.3.html
http://www.kernel.org/doc/man-pages/online/pages/man3/pthread_getcpuclockid.3.html
http://www.kernel.org/doc/man-pages/online/pages/man3/clock_gettime.3.html

There are several things I need to note:

1) Unfortunately newlib's variable naming doesn't currently comply with
POSIX.  Fixing this will affect RTEMS, so this will need to be worked
out on the newlib list.

2) On Linux, clockid_t is a signed int, and glibc uses negative clock
IDs for processes and threads (e.g. clock_getcpuclockid returns -6 -
pid*8 for the given pid).  However, newlib's clockid_t is a unsigned
long, so I've chosen a slightly-different numbering scheme which makes
the code a bit cleaner.  While the scheme is arbitrary and could be
changed at any time, that should only be necessary if several more fixed
clock IDs are required in the future (a (clockid_t)10 would be mistaken
for a CPU-time clock for PID 1); right now POSIX defines only four fixed
clock IDs.

3) timer_create(2) needs to be reworked to support clocks other than
CLOCK_REALTIME.  For now, I'm falling back to the ENOTSUP case allowed
by POSIX, but this should be reexamined after reworking timer_create.

4) As noted in the comments, POSIX says that the permissions required to
set any particular clock are implementation-defined.  On Linux, CPU-time
clocks are not settable (IOW no process has such permissions); I have
done the same here.

5) The clock_getres(3) code is based on my findings on my system (156001
100ns on W7 x64); I'd appreciate some confirmation for other systems.

6) On Linux, clock_getres(3) does not appear to verify if a (potential)
CPU-time clock actually exists.

Patches for newlib, winsup/cygwin, and winsup/doc, along with test
programs for the new and affected functions, attached.


Yaakov


--=-WsPxR3RBridggBsarc9p
Content-Disposition: attachment; filename="newlib-cpuclockid.patch"
Content-Type: text/x-patch; name="newlib-cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2118

2011-05-12  Yaakov Selkowitz  <yselkowitz@...>

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
+++ libc/include/time.h	8 May 2011 23:56:27 -0000
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
retrieving revision 1.24
diff -u -r1.24 features.h
--- libc/include/sys/features.h	2 May 2011 16:05:06 -0000	1.24
+++ libc/include/sys/features.h	8 May 2011 23:56:27 -0000
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
 /* #define _POSIX_THREAD_ATTR_STACKADDR		    -1 */
 #define _POSIX_THREAD_ATTR_STACKSIZE		200112L
-/* #define _POSIX_THREAD_CPUTIME		    -1 */
+#define _POSIX_THREAD_CPUTIME			200112L
 /* #define _POSIX_THREAD_PRIO_INHERIT		    -1 */
 /* #define _POSIX_THREAD_PRIO_PROTECT		    -1 */
 #define _POSIX_THREAD_PRIORITY_SCHEDULING	200112L

--=-WsPxR3RBridggBsarc9p
Content-Disposition: attachment; filename="cpuclockid.patch"
Content-Type: text/x-patch; name="cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 12385

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
retrieving revision 1.240
diff -u -r1.240 cygwin.din
--- cygwin.din	9 May 2011 08:57:46 -0000	1.240
+++ cygwin.din	13 May 2011 04:02:33 -0000
@@ -217,6 +217,7 @@
 _clearerr = clearerr SIGFE
 clock SIGFE
 _clock = clock SIGFE
+clock_getcpuclockid SIGFE
 clock_getres SIGFE
 clock_gettime SIGFE
 clock_setres SIGFE
@@ -1208,6 +1209,7 @@
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
retrieving revision 1.62
diff -u -r1.62 posix.sgml
--- posix.sgml	9 May 2011 08:57:46 -0000	1.62
+++ posix.sgml	13 May 2011 04:02:33 -0000
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
@@ -561,6 +562,7 @@
     pthread_equal
     pthread_exit
     pthread_getconcurrency
+    pthread_getcpuclockid
     pthread_getschedparam
     pthread_getspecific
     pthread_join
@@ -833,7 +835,7 @@
     tgamma
     tgammaf
     time
-    timer_create
+    timer_create		(see chapter "Implementation Notes")
     timer_delete
     timer_gettime
     timer_settime
@@ -1288,7 +1290,6 @@
     ceill
     cexpl
     cimagl
-    clock_getcpuclockid
     clogl
     conjl
     copysignl
@@ -1385,7 +1386,6 @@
     pthread_barrier[...]
     pthread_condattr_getclock
     pthread_condattr_setclock
-    pthread_getcpuclockid
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
@@ -1440,9 +1440,8 @@
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
retrieving revision 1.56
diff -u -r1.56 sysconf.cc
--- sysconf.cc	6 May 2011 18:53:21 -0000	1.56
+++ sysconf.cc	13 May 2011 04:02:33 -0000
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
retrieving revision 1.238
diff -u -r1.238 thread.cc
--- thread.cc	4 May 2011 06:16:59 -0000	1.238
+++ thread.cc	13 May 2011 04:02:34 -0000
@@ -2461,6 +2461,15 @@
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
+++ timer.cc	15 May 2011 16:35:46 -0000
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
+++ times.cc	13 May 2011 04:02:34 -0000
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
+++ winsup.h	13 May 2011 04:02:34 -0000
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
retrieving revision 1.31
diff -u -r1.31 pthread.h
--- include/pthread.h	3 May 2011 01:13:37 -0000	1.31
+++ include/pthread.h	15 May 2011 09:51:38 -0000
@@ -139,6 +139,7 @@
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
retrieving revision 1.345
diff -u -r1.345 version.h
--- include/cygwin/version.h	9 May 2011 08:57:46 -0000	1.345
+++ include/cygwin/version.h	13 May 2011 04:02:34 -0000
@@ -410,12 +410,14 @@
       242: Export psiginfo, psignal, sys_siglist.
       243: Export sysinfo.
       244: Export clock_settime.
+      245: Add CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID.
+	   Export clock_getcpuclockid, pthread_getcpuclockid.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 244
+#define CYGWIN_VERSION_API_MINOR 245
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-WsPxR3RBridggBsarc9p
Content-Disposition: attachment; filename="cpuclockid-test2.c"
Content-Type: text/x-csrc; name="cpuclockid-test2.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1137

#pragma CCOD:script no
#pragma CCOD:options -lrt

#define _XOPEN_SOURCE 600
#ifdef __CYGWIN__
#define _POSIX_CPUTIME
#endif
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <dlfcn.h>

int
main (int argc, char *argv[])
{
  clockid_t clockid;
  struct timespec tp;
  int i;

#ifdef __CYGWIN__
  int (*clock_getcpuclockid) (pid_t pid, clockid_t *clk_id);
  clock_getcpuclockid = dlsym (dlopen ("cygwin1.dll", 0), "clock_getcpuclockid");
#endif

  for (i = 1; i < argc; i++) {
    if (clock_getcpuclockid (atoi (argv[i]), &clockid) != 0) {
      perror ("clock_getcpuclockid");
      exit (EXIT_FAILURE);
    }

    if (clock_gettime (clockid, &tp) == -1) {
      perror ("clock_gettime");
      exit (EXIT_FAILURE);
    }

    printf ("CPU-time clock for PID %s is %ld.%09ld seconds\n",
            argv[i], (long) tp.tv_sec, (long) tp.tv_nsec);
  }

  if (clock_gettime (CLOCK_PROCESS_CPUTIME_ID, &tp) == -1) {
    perror ("clock_gettime");
    exit (EXIT_FAILURE);
  }

  printf ("CPU-time clock for this process is %ld.%09ld seconds\n",
          (long) tp.tv_sec, (long) tp.tv_nsec);

  return 0;
}

--=-WsPxR3RBridggBsarc9p
Content-Disposition: attachment; filename="getres-test.c"
Content-Type: text/x-csrc; name="getres-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1188

#pragma CCOD:script no
#pragma CCOD:options -lrt

#define _XOPEN_SOURCE 600
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifdef __CYGWIN__
#include <dlfcn.h>
#define CLOCK_PROCESS_CPUTIME_ID	(clockid_t)2
int (*clock_getcpuclockid) (pid_t, clockid_t *);
#endif

int
main (int argc, char **argv)
{
  clockid_t clk_id;
  struct timespec tp;
  pid_t pid;

#ifdef __CYGWIN__
  clock_getcpuclockid = dlopen (dlsym ("cygwin1.dll", 0), "clock_getcpuclockid");
#endif

  clock_getres (CLOCK_REALTIME, &tp);
  printf ("Realtime clock resolution is %ld.%09ld seconds\n",
          (long) tp.tv_sec, (long) tp.tv_nsec);

  clock_getres (CLOCK_MONOTONIC, &tp);
  printf ("Monotonic clock resolution is %ld.%09ld seconds\n",
          (long) tp.tv_sec, (long) tp.tv_nsec);

  clock_getres (CLOCK_PROCESS_CPUTIME_ID, &tp);
  printf ("CPU clock resolution for this process is %ld.%09ld seconds\n",
          (long) tp.tv_sec, (long) tp.tv_nsec);

  pid = argv[1] ? atoi (argv[1]) : -1;

  clock_getcpuclockid (pid, &clk_id);
  clock_getres (clk_id, &tp);
  printf ("CPU clock resolution for PID %d is %ld.%09ld seconds\n",
          pid, (long) tp.tv_sec, (long) tp.tv_nsec);

  return 0;
}

--=-WsPxR3RBridggBsarc9p
Content-Disposition: attachment; filename="doc-cpuclockid.patch"
Content-Type: text/x-patch; name="doc-cpuclockid.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 857

2011-05-15  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document CPU-time clock support.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.80
diff -u -r1.80 new-features.sgml
--- new-features.sgml	9 May 2011 08:58:59 -0000	1.80
+++ new-features.sgml	15 May 2011 17:54:55 -0000
@@ -19,6 +19,12 @@
 </para></listitem>
 
 <listitem><para>
+clock_gettime(3) and clock_getres(3) accept per-process and per-thread CPU-time
+clocks, including CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
+New APIs: clock_getcpuclockid, pthread_getcpuclockid.
+</para></listitem>
+
+<listitem><para>
 /proc/loadavg now shows the number of currently running processes and the
 total number of processes.
 </para></listitem>

--=-WsPxR3RBridggBsarc9p--
