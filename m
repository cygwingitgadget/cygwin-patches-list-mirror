Return-Path: <cygwin-patches-return-7435-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2899 invoked by alias); 20 Jul 2011 01:54:58 -0000
Received: (qmail 2835 invoked by uid 22791); 20 Jul 2011 01:54:54 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_QT,TW_RQ,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 Jul 2011 01:54:35 +0000
Received: by yib12 with SMTP id 12so2438496yib.2        for <cygwin-patches@cygwin.com>; Tue, 19 Jul 2011 18:54:34 -0700 (PDT)
Received: by 10.236.175.7 with SMTP id y7mr129416yhl.213.1311126873098;        Tue, 19 Jul 2011 18:54:33 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id z28sm1598852yhn.49.2011.07.19.18.54.31        (version=SSLv3 cipher=OTHER);        Tue, 19 Jul 2011 18:54:32 -0700 (PDT)
Subject: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Wed, 20 Jul 2011 01:54:00 -0000
Content-Type: multipart/mixed; boundary="=-85wYl/tnquQ9Cj0meG96"
Message-ID: <1311126880.7796.9.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00011.txt.bz2


--=-85wYl/tnquQ9Cj0meG96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 621

This patchset implements the POSIX clock_nanosleep(2) function:

http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html
http://www.kernel.org/doc/man-pages/online/pages/man2/clock_nanosleep.2.html

In summary, clock_nanosleep(2) replaces nanosleep(2) as the primary
sleeping function, with all others rewritten in terms of the former.  It
also restores maximum precision to hires_ms::resolution(), saving the
<5000 100ns check for the one place where resolution is rounded off.

Patches for newlib, winsup/cygwin, and winsup/doc attached.  I would
appreciate a careful look at this one.


Yaakov


--=-85wYl/tnquQ9Cj0meG96
Content-Disposition: attachment; filename="newlib-clock_nanosleep.patch"
Content-Type: text/x-patch; name="newlib-clock_nanosleep.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 600

Index: libc/include/time.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/time.h,v
retrieving revision 1.19
diff -u -r1.19 time.h
--- libc/include/time.h	16 Oct 2008 21:53:58 -0000	1.19
+++ libc/include/time.h	15 May 2011 19:22:48 -0000
@@ -168,6 +168,9 @@
 
 /* High Resolution Sleep, P1003.1b-1993, p. 269 */
 
+int _EXFUN(clock_nanosleep,
+  (clockid_t clock_id, int flags, const struct timespec *rqtp,
+   struct timespec *rmtp));
 int _EXFUN(nanosleep, (const struct timespec  *rqtp, struct timespec *rmtp));
 
 #ifdef __cplusplus

--=-85wYl/tnquQ9Cj0meG96
Content-Disposition: attachment; filename="winsup-cygwin-clock_nanosleep.patch"
Content-Type: text/x-patch; name="winsup-cygwin-clock_nanosleep.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 11583

2011-07-19  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (clock_nanosleep): Export.
	* hires.h (hires_ns::msecs): New function.
	(ntod): Declare.
	* posix.sgml (std-notimpl): Move clock_nanosleep from here...
	(std-susv4): ... to here.
	(std-notes): Note limitations of clock_nanosleep.
	* signal.cc (now_msecs): New static function.
	(clock_nanosleep): Renamed from nanosleep with additional arguments.
	Add support for CLOCK_MONOTONIC and TIMER_ABSTIME.
	(nanosleep): Rewrite in terms of clock_nanosleep.
	(sleep): Ditto.
	(usleep): Ditto.
	* thread.cc: Mark clock_nanosleep in list of cancellation points.
	* times.cc (hires_ms::resolution): Provide best possible resolution.
	(clock_getres): Adjust accordingly.
	(clock_setres): Ditto.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.244
diff -u -p -r1.244 cygwin.din
--- cygwin.din	19 May 2011 07:23:28 -0000	1.244
+++ cygwin.din	19 Jul 2011 01:28:56 -0000
@@ -223,6 +223,7 @@ _clock = clock SIGFE
 clock_getcpuclockid SIGFE
 clock_getres SIGFE
 clock_gettime SIGFE
+clock_nanosleep SIGFE
 clock_setres SIGFE
 clock_settime SIGFE
 clog NOSIGFE
Index: hires.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hires.h,v
retrieving revision 1.19
diff -u -p -r1.19 hires.h
--- hires.h	17 May 2011 17:08:09 -0000	1.19
+++ hires.h	19 Jul 2011 01:28:56 -0000
@@ -45,6 +45,7 @@ class hires_ns : public hires_base
  public:
   LONGLONG nsecs ();
   LONGLONG usecs () {return nsecs () / 1000LL;}
+  LONGLONG msecs () { return nsecs () / 1000000LL; }
   LONGLONG resolution();
 };
 
@@ -63,4 +64,5 @@ class hires_ms : public hires_base
 };
 
 extern hires_ms gtod;
+extern hires_ns ntod;
 #endif /*__HIRES_H__*/
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.68
diff -u -p -r1.68 posix.sgml
--- posix.sgml	25 May 2011 06:10:24 -0000	1.68
+++ posix.sgml	19 Jul 2011 01:28:56 -0000
@@ -92,6 +92,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     clock_getcpuclockid
     clock_getres
     clock_gettime
+    clock_nanosleep		(see chapter "Implementation Notes")
     clock_settime		(see chapter "Implementation Notes")
     clog
     clogf
@@ -1297,7 +1298,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     ceill
     cexpl
     cimagl
-    clock_nanosleep
     clogl
     conjl
     copysignl
@@ -1446,8 +1446,10 @@ by keeping track of the current root and
 related function calls.  A real chroot functionality is not supported by
 Windows however.</para>
 
-<para><function>clock_setres</function>, <function>clock_settime</function>,
-and <function>timer_create</function> only support CLOCK_REALTIME.</para>
+<para><function>clock_nanosleep</function> currently supports only
+CLOCK_REALTIME and CLOCK_MONOTONIC.  <function>clock_setres</function>,
+<function>clock_settime</function>, and <function>timer_create</function>
+currently support only CLOCK_REALTIME.</para>
 
 <para>BSD file locks created via <function>flock</function> are not
 propagated to the parent process and sibling processes.  The locks are
Index: signal.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.98
diff -u -p -r1.98 signal.cc
--- signal.cc	10 Jul 2011 00:01:33 -0000	1.98
+++ signal.cc	19 Jul 2011 01:28:56 -0000
@@ -80,62 +80,113 @@ signal (int sig, _sig_func_ptr func)
   return prev;
 }
 
+static long long
+now_msecs (clockid_t clk_id, bool abstime)
+{
+  long long res = 0LL;
+  switch (clk_id)
+    {
+    case CLOCK_REALTIME:
+      if (abstime)
+	res = gtod.msecs ();
+      else
+	res = gtod.dmsecs ();
+      break;
+    case CLOCK_MONOTONIC:
+      res = ntod.msecs ();
+      break;
+    }
+  return res;
+}
+
 extern "C" int
-nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
+clock_nanosleep (clockid_t clk_id, int flags, const struct timespec *rqtp, struct timespec *rmtp)
 {
+  const bool abstime = (flags & TIMER_ABSTIME) ? true : false;
   int res = 0;
   sig_dispatch_pending ();
   pthread_testcancel ();
 
-  if ((unsigned int) rqtp->tv_nsec > 999999999)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-  unsigned int sec = rqtp->tv_sec;
-  DWORD resolution = gtod.resolution ();
+  if (rqtp->tv_nsec > 999999999L || rqtp->tv_nsec < 0L)
+    return EINVAL;
+
+  /* disallowed by POSIX */
+  if (clk_id == CLOCK_THREAD_CPUTIME_ID)
+    return EINVAL;
+
+  if (CLOCKID_IS_PROCESS (clk_id) || CLOCKID_IS_THREAD (clk_id))
+    return ENOTSUP;
+
+  long long msec = (rqtp->tv_sec * 1000LL) + (rqtp->tv_nsec + 999999LL) / 1000000LL;
+  long long end_time;
+  DWORD resolution;
   bool done = false;
   DWORD req;
-  DWORD rem;
+  long long rem;
+
+  switch (clk_id)
+    {
+    case CLOCK_REALTIME:
+      resolution = gtod.resolution () / 10000L;
+      break;
+    case CLOCK_MONOTONIC:
+      resolution = ntod.resolution () / 1000000L;
+      break;
+    default:
+      return EINVAL;
+    }
+
+  /* The resolution can be as low as 5000 100ns intervals on recent OSes.
+     We have to make sure that the resolution in ms is never 0. */
+  if (!resolution)
+    resolution = 1L;
+
+  if (abstime)
+    {
+      end_time = msec;
+      msec -= now_msecs (clk_id, abstime);
+    }
+  else
+    end_time = now_msecs (clk_id, abstime) + msec;
+
+  if (msec < 0)
+    return 0;
 
   while (!done)
     {
       /* Divide user's input into transactions no larger than 49.7
 	 days at a time.  */
-      if (sec > HIRES_DELAY_MAX / 1000)
+      if (msec > HIRES_DELAY_MAX)
 	{
 	  req = ((HIRES_DELAY_MAX + resolution - 1)
 		 / resolution * resolution);
-	  sec -= HIRES_DELAY_MAX / 1000;
+	  msec -= HIRES_DELAY_MAX;
 	}
       else
 	{
-	  req = ((sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
-		  + resolution - 1) / resolution) * resolution;
-	  sec = 0;
+	  req = (((DWORD) msec + resolution - 1) / resolution) * resolution;
+	  msec = 0;
 	  done = true;
 	}
 
-      DWORD end_time = gtod.dmsecs () + req;
-      syscall_printf ("nanosleep (%ld)", req);
+      syscall_printf ("clock_nanosleep (%ld)", req);
 
       int rc = cancelable_wait (signal_arrived, req);
-      if ((rem = end_time - gtod.dmsecs ()) > HIRES_DELAY_MAX)
+      if ((rem = end_time - now_msecs (clk_id, abstime)) > HIRES_DELAY_MAX)
 	rem = 0;
       if (rc == WAIT_OBJECT_0)
 	{
 	  _my_tls.call_signal_handler ();
-	  set_errno (EINTR);
-	  res = -1;
+	  res = EINTR;
 	  break;
 	}
     }
 
-  if (rmtp)
+  if (rmtp && !abstime)
     {
-      rmtp->tv_sec = sec + rem / 1000;
-      rmtp->tv_nsec = (rem % 1000) * 1000000;
-      if (sec)
+      rmtp->tv_sec = (time_t) ((msec + rem) / 1000);
+      rmtp->tv_nsec = (long) ((rem % 1000L) * 1000000L);
+      if (msec)
 	{
 	  rmtp->tv_nsec += rqtp->tv_nsec;
 	  if (rmtp->tv_nsec >= 1000000000)
@@ -146,17 +197,30 @@ nanosleep (const struct timespec *rqtp, 
 	}
     }
 
-  syscall_printf ("%d = nanosleep (%ld, %ld)", res, req, rem);
+  syscall_printf ("%d = clock_nanosleep (%lu, %d, %ld, %ld)",
+                  res, clk_id, flags, req, rem);
   return res;
 }
 
+extern "C" int
+nanosleep (const struct timespec *rqtp, struct timespec *rmtp)
+{
+  int res = clock_nanosleep (CLOCK_REALTIME, 0, rqtp, rmtp);
+  if (res != 0)
+    {
+      set_errno (res);
+      return -1;
+    }
+  return 0;
+}
+
 extern "C" unsigned int
 sleep (unsigned int seconds)
 {
   struct timespec req, rem;
   req.tv_sec = seconds;
   req.tv_nsec = 0;
-  if (nanosleep (&req, &rem))
+  if (clock_nanosleep (CLOCK_REALTIME, 0, &req, &rem))
     return rem.tv_sec + (rem.tv_nsec > 0);
   return 0;
 }
@@ -167,8 +231,13 @@ usleep (useconds_t useconds)
   struct timespec req;
   req.tv_sec = useconds / 1000000;
   req.tv_nsec = (useconds % 1000000) * 1000;
-  int res = nanosleep (&req, NULL);
-  return res;
+  int res = clock_nanosleep (CLOCK_REALTIME, 0, &req, NULL);
+  if (res != 0)
+    {
+      set_errno (res);
+      return -1;
+    }
+  return 0;
 }
 
 extern "C" int
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.243
diff -u -p -r1.243 thread.cc
--- thread.cc	6 Jun 2011 05:02:13 -0000	1.243
+++ thread.cc	19 Jul 2011 01:28:57 -0000
@@ -577,7 +577,7 @@ pthread::cancel ()
 
     * accept ()
     o aio_suspend ()
-    o clock_nanosleep ()
+    * clock_nanosleep ()
     * close ()
     * connect ()
     * creat ()
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.110
diff -u -p -r1.110 times.cc
--- times.cc	6 Jun 2011 05:02:13 -0000	1.110
+++ times.cc	19 Jul 2011 01:28:57 -0000
@@ -737,7 +737,7 @@ hires_ms::resolution ()
 
       status = NtQueryTimerResolution (&coarsest, &finest, &actual);
       if (NT_SUCCESS (status))
-	minperiod = (DWORD) actual / 10000L;
+	minperiod = (DWORD) actual;
       else
 	{
 	  /* Try to empirically determine current timer resolution */
@@ -757,13 +757,9 @@ hires_ms::resolution ()
 	      period += now - then;
 	    }
 	  SetThreadPriority (GetCurrentThread (), priority);
-	  period /= 40000L;
+	  period /= 4L;
 	  minperiod = (DWORD) period;
 	}
-      /* The resolution can be as low as 5000 100ns intervals on recent OSes.
-	 We have to make sure that the resolution in ms is never 0. */
-      if (!minperiod)
-	minperiod = 1L;
     }
   return minperiod;
 }
@@ -786,8 +782,8 @@ clock_getres (clockid_t clk_id, struct t
       case CLOCK_REALTIME:
 	{
 	  DWORD period = gtod.resolution ();
-	  tp->tv_sec = period / 1000;
-	  tp->tv_nsec = (period % 1000) * 1000000;
+	  tp->tv_sec = period / NSPERSEC;
+	  tp->tv_nsec = (period % NSPERSEC) * 100;
 	  break;
 	}
 
@@ -838,7 +834,7 @@ clock_setres (clockid_t clk_id, struct t
     }
 
   if (period_set
-      && NT_SUCCESS (NtSetTimerResolution (minperiod * 10000L, FALSE, &actual)))
+      && NT_SUCCESS (NtSetTimerResolution (minperiod, FALSE, &actual)))
     period_set = false;
 
   status = NtSetTimerResolution (period, TRUE, &actual);
@@ -847,11 +843,7 @@ clock_setres (clockid_t clk_id, struct t
       __seterrno_from_nt_status (status);
       return -1;
     }
-  minperiod = actual / 10000L;
-  /* The resolution can be as low as 5000 100ns intervals on recent OSes.
-     We have to make sure that the resolution in ms is never 0. */
-  if (!minperiod)
-    minperiod = 1L;
+  minperiod = actual;
   period_set = true;
   return 0;
 }
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.349
diff -u -p -r1.349 version.h
--- include/cygwin/version.h	19 May 2011 07:23:29 -0000	1.349
+++ include/cygwin/version.h	19 Jul 2011 01:28:57 -0000
@@ -417,12 +417,13 @@ details. */
       247: Export error, error_at_line, error_message_count, error_one_per_line,
 	   error_print_progname.
       248: Export __fpurge.
+      249: Export clock_nanosleep.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 248
+#define CYGWIN_VERSION_API_MINOR 249
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-85wYl/tnquQ9Cj0meG96
Content-Disposition: attachment; filename="winsup-doc-clock_nanosleep.patch"
Content-Type: text/x-patch; name="winsup-doc-clock_nanosleep.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1400

2011-07-19  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document clock_nanosleep(2).

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.87
diff -u -p -r1.87 new-features.sgml
--- new-features.sgml	20 Jul 2011 01:19:53 -0000	1.87
+++ new-features.sgml	20 Jul 2011 01:27:23 -0000
@@ -41,9 +41,11 @@ pthread_attr_setstackaddr, pthread_attr_
 </para></listitem>
 
 <listitem><para>
-clock_gettime(3) and clock_getres(3) accept per-process and per-thread CPU-time
-clocks, including CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
-New APIs: clock_getcpuclockid, pthread_getcpuclockid.
+clock_gettime(2) and clock_getres(2) accept per-process and per-thread
+CPU-time clocks, including CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
+New POSIX clock APIs: clock_nanosleep (supports CLOCK_REALTIME and
+CLOCK_MONOTONIC), clock_settime (supports CLOCK_REALTIME),
+clock_getcpuclockid, pthread_getcpuclockid.
 </para></listitem>
 
 <listitem><para>
@@ -73,7 +75,7 @@ as well as the version of GCC used when 
 </para></listitem>
 
 <listitem><para>
-Other new API: clock_settime, __fpurge, ppoll, psiginfo, psignal, sys_siglist,
+Other new API: __fpurge, ppoll, psiginfo, psignal, sys_siglist,
 pthread_setschedprio, sysinfo.
 </para></listitem>
 

--=-85wYl/tnquQ9Cj0meG96--
