Return-Path: <cygwin-patches-return-7049-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6113 invoked by alias); 2 Aug 2010 20:49:22 -0000
Received: (qmail 6084 invoked by uid 22791); 2 Aug 2010 20:49:19 -0000
X-SWARE-Spam-Status: No, hits=-49.9 required=5.0	tests=AWL,BAYES_20,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f45.google.com (HELO mail-ww0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Aug 2010 20:49:11 +0000
Received: by wwf26 with SMTP id 26so3799105wwf.2        for <cygwin-patches@cygwin.com>; Mon, 02 Aug 2010 13:49:08 -0700 (PDT)
Received: by 10.227.7.96 with SMTP id c32mr5492737wbc.109.1280782148363;        Mon, 02 Aug 2010 13:49:08 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id p45sm3123939weq.45.2010.08.02.13.49.05        (version=SSLv3 cipher=RC4-MD5);        Mon, 02 Aug 2010 13:49:07 -0700 (PDT)
Subject: [PATCH] POSIX monotonic clock
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-Ve1Ev5dmqa554vno6dMe"
Date: Mon, 02 Aug 2010 20:49:00 -0000
Message-ID: <1280782148.6756.81.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00009.txt.bz2


--=-Ve1Ev5dmqa554vno6dMe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1021

Here is an attempt to implement POSIX.1-2004+ Monotonic Clock:

http://www.opengroup.org/onlinepubs/9699919799/functions/clock_getres.html

In summary, I took hires_us and changed the resolution to nanoseconds. I
dropped systime() because the only place hires_us was being used is in
strace.cc which ignored it, and WRT POSIX monotonic clocks the absolute
value of the clock is meaningless.  Since systime() has only 100ns
precision, using it would either force a loss in resolution or (if
multiplied by 100 to get ns) an early overflow.  I also switched from
ENOSYS to EINVAL, as POSIX.1-2004 and 2008 dropped references to the
former (as noted in Change History).

Patches for newlib, winsup/cygwin and winsup/doc attached.

I have also attached an STC for the new functionality.  FWIW, on my
machine, QueryPerformanceFrequency() returns just over 2.9 million,
resulting in a clock_getres(CLOCK_MONOTONIC) of 340ns.

I would appreciate a careful review of this patch, both from the Cygwin
API and POSIX POVs.


Yaakov


--=-Ve1Ev5dmqa554vno6dMe
Content-Disposition: attachment; filename="clock-test.c"
Content-Type: text/x-csrc; name="clock-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 776

/* compile with unpatched sys/features.h */
#define _POSIX_MONOTONIC_CLOCK 200112L
#include <time.h>
#include <stdio.h>
#include <unistd.h>

int
main(void)
{
	int n, ret;
	struct timespec *res;

	ret = clock_getres(CLOCK_MONOTONIC, res);
	if (ret < 0) {
		printf("ERROR: clock_getres(CLOCK_MONOTONIC) failed\n");
		return ret;
	}
	printf("%ld:%ld\n", res->tv_sec, res->tv_nsec);

	n = 0;
	while (n < 5)
	{
		sleep(1);
		ret = clock_gettime(CLOCK_MONOTONIC, res);
		if (ret < 0) {
			printf("ERROR: clock_gettime(CLOCK_MONOTONIC) failed\n");
			return ret;
		}
		printf("%ld:%09ld\n", res->tv_sec, res->tv_nsec);
		n++;
	}

	ret = clock_setres(CLOCK_MONOTONIC, res);
	if (ret != -1) {
		printf("ERROR: clock_setres(CLOCK_MONOTONIC) must fail\n");
		return -1;
	}

	return 0;
}

--=-Ve1Ev5dmqa554vno6dMe
Content-Disposition: attachment; filename="newlib-cygwin-monotonic-clock.patch"
Content-Type: text/x-patch; name="newlib-cygwin-monotonic-clock.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 838

2010-08-02  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* libc/include/sys/features.h: Define _POSIX_MONOTONIC_CLOCK for Cygwin.

Index: libc/include/sys/features.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/features.h,v
retrieving revision 1.21
diff -u -r1.21 features.h
--- libc/include/sys/features.h	17 Mar 2010 17:13:00 -0000	1.21
+++ libc/include/sys/features.h	2 Aug 2010 07:55:27 -0000
@@ -112,7 +112,7 @@
 #define _POSIX_MEMLOCK_RANGE			200112L
 #define _POSIX_MEMORY_PROTECTION		200112L
 #define _POSIX_MESSAGE_PASSING			200112L
-/* #define _POSIX_MONOTONIC_CLOCK		    -1 */
+#define _POSIX_MONOTONIC_CLOCK		    200112L
 #define _POSIX_NO_TRUNC				     1
 /* #define _POSIX_PRIORITIZED_IO		    -1 */
 #define _POSIX_PRIORITY_SCHEDULING		200112L

--=-Ve1Ev5dmqa554vno6dMe
Content-Disposition: attachment; filename="winsup-cygwin-monotonic-clock.patch"
Content-Type: text/x-patch; name="winsup-cygwin-monotonic-clock.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 7909

2010-08-02  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	Implement POSIX.1-2004 Monotonic Clock.
	* hires.h: Change hires_us to hires_ns, with nanosecond resolution.
	(hires_ns::primed_ft): Remove.
	(hires_ns::nsecs): New prototype.
	(hires_ns::usecs): Rewrite in terms of nsecs.
	(hires_ns::resolution): New prototype.
	* times.cc: Change hires_us to hires_ns.
	(ntod): Declare.
	(systime): Remove.
	(hires_ns::prime): Increase resolution to nanoseconds.
	(hires_ns::nsecs): Rename usecs to nsecs to reflect increased resolution.
	Remove justdelta argument. Use EINVAL instead of ENOSYS per POSIX.1-2004.
	(hires_ns::resolution): New function.
	(clock_gettime): Accept CLOCK_MONOTONIC.
	Use EINVAL instead of ENOSYS per POSIX.1-2004.
	(clock_getres): Ditto.
	(clock_setres): Use EINVAL instead of ENOSYS to conform with other
	implementations.
	* strace.cc (strace::microseconds): Adjust for hires_ns.
	* sysconf.cc (sca): Set _SC_MONOTONIC_CLOCK to _POSIX_MONOTONIC_CLOCK.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: hires.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hires.h,v
retrieving revision 1.15
diff -u -r1.15 hires.h
--- hires.h	26 May 2010 14:48:17 -0000	1.15
+++ hires.h	2 Aug 2010 18:30:03 -0000
@@ -29,14 +29,15 @@
   void reset() {inited = false;}
 };
 
-class hires_us : public hires_base
+class hires_ns : public hires_base
 {
-  LARGE_INTEGER primed_ft;
   LARGE_INTEGER primed_pc;
   double freq;
   void prime ();
  public:
-  LONGLONG usecs (bool justdelta);
+  LONGLONG nsecs ();
+  LONGLONG usecs () {return nsecs () / 1000LL;}
+  LONGLONG resolution();
 };
 
 class hires_ms : public hires_base
Index: strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strace.cc,v
retrieving revision 1.68
diff -u -r1.68 strace.cc
--- strace.cc	18 May 2010 14:30:51 -0000	1.68
+++ strace.cc	2 Aug 2010 18:30:03 -0000
@@ -74,8 +74,8 @@
 int
 strace::microseconds ()
 {
-  static hires_us now;
-  return (int) now.usecs (true);
+  static hires_ns now;
+  return (int) now.usecs ();
 }
 
 static int __stdcall
Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.53
diff -u -r1.53 sysconf.cc
--- sysconf.cc	12 Nov 2009 14:40:47 -0000	1.53
+++ sysconf.cc	2 Aug 2010 20:03:13 -0000
@@ -165,7 +165,7 @@
   {cons, {c:IOV_MAX}},			/*  66, _SC_IOV_MAX */
   {cons, {c:_POSIX_IPV6}},		/*  67, _SC_IPV6 */
   {cons, {c:LINE_MAX}},			/*  68, _SC_LINE_MAX */
-  {cons, {c:-1L}},			/*  69, _SC_MONOTONIC_CLOCK */
+  {cons, {c:_POSIX_MONOTONIC_CLOCK}},	/*  69, _SC_MONOTONIC_CLOCK */
   {cons, {c:_POSIX_RAW_SOCKETS}},	/*  70, _SC_RAW_SOCKETS */
   {cons, {c:_POSIX_READER_WRITER_LOCKS}},	/*  71, _SC_READER_WRITER_LOCKS */
   {cons, {c:_POSIX_REGEXP}},		/*  72, _SC_REGEXP */
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.102
diff -u -r1.102 times.cc
--- times.cc	12 Jun 2010 16:34:26 -0000	1.102
+++ times.cc	2 Aug 2010 18:30:03 -0000
@@ -36,6 +36,8 @@
    to handle that case.  */
 hires_ms gtod __attribute__((section (".cygwin_dll_common"), shared));
 
+hires_ns NO_COPY ntod;
+
 static inline LONGLONG
 systime_ns ()
 {
@@ -48,12 +50,6 @@
   return x.QuadPart;
 }
 
-static inline LONGLONG
-systime ()
-{
-  return systime_ns () / 10;
-}
-
 /* Cygwin internal */
 static unsigned long long __stdcall
 __to_clock_t (FILETIME *src, int flag)
@@ -623,7 +619,7 @@
 
 #define stupid_printf if (cygwin_finished_initializing) debug_printf
 void
-hires_us::prime ()
+hires_ns::prime ()
 {
   LARGE_INTEGER ifreq;
   if (!QueryPerformanceFrequency (&ifreq))
@@ -642,34 +638,32 @@
       return;
     }
 
-  primed_ft.QuadPart = systime ();
-  freq = (double) ((double) 1000000. / (double) ifreq.QuadPart);
+  freq = (double) ((double) 1000000000. / (double) ifreq.QuadPart);
   inited = true;
   SetThreadPriority (GetCurrentThread (), priority);
 }
 
 LONGLONG
-hires_us::usecs (bool justdelta)
+hires_ns::nsecs ()
 {
   if (!inited)
     prime ();
   if (inited < 0)
     {
-      set_errno (ENOSYS);
+      set_errno (EINVAL);
       return (long long) -1;
     }
 
   LARGE_INTEGER now;
   if (!QueryPerformanceCounter (&now))
     {
-      set_errno (ENOSYS);
+      set_errno (EINVAL);
       return -1;
     }
 
   // FIXME: Use round() here?
   now.QuadPart = (LONGLONG) (freq * (double) (now.QuadPart - primed_pc.QuadPart));
-  LONGLONG res = justdelta ? now.QuadPart : primed_ft.QuadPart + now.QuadPart;
-  return res;
+  return now.QuadPart;
 }
 
 void
@@ -706,23 +700,53 @@
 extern "C" int
 clock_gettime (clockid_t clk_id, struct timespec *tp)
 {
-  if (clk_id != CLOCK_REALTIME)
+  switch (clk_id)
     {
-      set_errno (ENOSYS);
-      return -1;
+      case CLOCK_REALTIME:
+        {
+          LONGLONG now = gtod.nsecs ();
+          if (now == (LONGLONG) -1)
+            return -1;
+          tp->tv_sec = now / NSPERSEC;
+          tp->tv_nsec = (now % NSPERSEC) * (1000000000 / NSPERSEC);
+          break;
+        }
+
+      case CLOCK_MONOTONIC:
+        {
+          LONGLONG now = ntod.nsecs ();
+          if (now == (LONGLONG) -1)
+            return -1;
+
+          tp->tv_sec = now / 1000000000;
+          tp->tv_nsec = (now % 1000000000);
+          break;
+        }
+
+      default:
+        set_errno (EINVAL);
+        return -1;
     }
 
-  LONGLONG now = gtod.nsecs ();
-  if (now == (LONGLONG) -1)
-    return -1;
-
-  tp->tv_sec = now / NSPERSEC;
-  tp->tv_nsec = (now % NSPERSEC) * (1000000000 / NSPERSEC);
   return 0;
 }
 
 static DWORD minperiod;	// FIXME: Maintain period after a fork.
 
+LONGLONG
+hires_ns::resolution()
+{
+  if (!inited)
+    prime ();
+  if (inited < 0)
+    {
+      set_errno (EINVAL);
+      return (long long) -1;
+    }
+
+  return (LONGLONG) freq;
+}
+
 UINT
 hires_ms::resolution ()
 {
@@ -753,17 +777,29 @@
 extern "C" int
 clock_getres (clockid_t clk_id, struct timespec *tp)
 {
-  if (clk_id != CLOCK_REALTIME)
+  switch (clk_id)
     {
-      set_errno (ENOSYS);
-      return -1;
+      case CLOCK_REALTIME:
+        {
+          DWORD period = gtod.resolution ();
+          tp->tv_sec = period / 1000;
+          tp->tv_nsec = (period % 1000) * 1000000;
+          break;
+        }
+
+      case CLOCK_MONOTONIC:
+        {
+          LONGLONG period = ntod.resolution ();
+          tp->tv_sec = period / 1000000000;
+          tp->tv_nsec = period % 1000000000;
+          break;
+        }
+
+      default:
+        set_errno (EINVAL);
+        return -1;
     }
 
-  DWORD period = gtod.resolution ();
-
-  tp->tv_sec = period / 1000;
-  tp->tv_nsec = (period % 1000) * 1000000;
-
   return 0;
 }
 
@@ -773,7 +809,7 @@
   static NO_COPY bool period_set;
   if (clk_id != CLOCK_REALTIME)
     {
-      set_errno (ENOSYS);
+      set_errno (EINVAL);
       return -1;
     }
 
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.319
diff -u -r1.319 version.h
--- include/cygwin/version.h	19 Jul 2010 18:22:40 -0000	1.319
+++ include/cygwin/version.h	2 Aug 2010 19:59:08 -0000
@@ -389,12 +389,13 @@
       227: Add pseudo_reloc_start, pseudo_reloc_end, image_base to per_process.
       228: CW_STRERROR added.
       229: Add mkostemp, mkostemps.
+      230: Add CLOCK_MONOTONIC.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 229
+#define CYGWIN_VERSION_API_MINOR 230
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-Ve1Ev5dmqa554vno6dMe
Content-Disposition: attachment; filename="winsup-doc-monotonic-clock.patch"
Content-Type: text/x-patch; name="winsup-doc-monotonic-clock.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 670

2010-08-02  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* new-features.sgml (ov-new1.7.6): Document POSIX monotonic clock.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.47
diff -u -r1.47 new-features.sgml
--- new-features.sgml	19 Jul 2010 18:25:41 -0000	1.47
+++ new-features.sgml	2 Aug 2010 20:34:24 -0000
@@ -34,6 +34,10 @@
 New interfaces mkostemp(3) and mkostemps(3) are added.
 </para></listitem>
 
+<listitem><para>
+clock_gettime(3) and clock_getres(3) accept CLOCK_MONOTONIC.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--=-Ve1Ev5dmqa554vno6dMe--
