Return-Path: <cygwin-patches-return-4162-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16995 invoked by alias); 4 Sep 2003 03:28:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16986 invoked from network); 4 Sep 2003 03:28:51 -0000
Message-Id: <3.0.5.32.20030903232651.00814100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 04 Sep 2003 03:28:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] nanosleep()  
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1062660411==_"
X-SW-Source: 2003-q3/txt/msg00178.txt.bz2

--=====================_1062660411==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 992

This patch to nanosleep, sleep and usleep 
a) makes them Posix conformant: the system clock (gettimeofday) must 
   advance by at least d during Xsleep(d) 
  (e.g. exim relies on this to create unique ids).
b) improves the resolution of the result by using the multimedia 
   timer. 
c) calls timeBeginPeriod in forked processes.

A follow up patch will improve setitimer. 

Pierre

2003-09-03  Pierre Humblet <pierre.humblet@ieee.org>

	* hires.h (_DELAY_MAX): Define.
	(hires_ms::minperiod): Declare static.
	(hires_ms::resolution): New.
	(hires_ms::dmsecs): New.
	(hires_ms::~hires_ms): Delete.
 	(gtod): Declare. 
	* time.c (hires_ms::prime): Always calculate minperiod and 
	set it to 1 in case of failure.
	(hires_ms::resolution): Define.
	(hires_ms::~hires_ms): Delete.
	(hires_ms::usecs): Check minperiod to prime.
	(gtod) Define.
	* signal.cc (nanosleep): Round delay up to resolution.
	Fix test for negative remainder. Use timeGetTime through gtod.
	(sleep): Round up return value.

--=====================_1062660411==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sleep.diff"
Content-length: 5894

Index: hires.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/hires.h,v
retrieving revision 1.4
diff -u -p -r1.4 hires.h
--- hires.h	30 Sep 2002 02:51:21 -0000	1.4
+++ hires.h	4 Sep 2003 03:08:03 -0000
@@ -33,14 +33,30 @@ class hires_us : hires_base
   LONGLONG usecs (bool justdelta);
 };

+/* Largest delay in ms for sleep and alarm calls.
+   Allow actual delay to exceed requested delay by 10 s.
+   Express as multiple of 1000 (i.e. seconds) + max resolution
+   The tv_sec argument in timeval structures cannot exceed _DELAY_MAX / 10=
00 -1,
+   so that adding fractional part and rounding won't exceed _DELAY_MAX */
+#define _DELAY_MAX (((UINT_MAX - 10000) / 1000) * 1000) + 10
+
 class hires_ms : hires_base
 {
   DWORD initime_ms;
   LARGE_INTEGER initime_us;
-  UINT minperiod;
+  static UINT minperiod;
   void prime ();
  public:
   LONGLONG usecs (bool justdelta);
-  ~hires_ms ();
+  UINT dmsecs () { return timeGetTime (); }
+  UINT resolution ()
+    {
+      if (!minperiod)
+	prime ();
+      return minperiod;
+    }
 };
+
+extern hires_ms gtod;
+
 #endif /*__HIRES_H__*/
Index: times.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.46
diff -u -p -r1.46 times.cc
--- times.cc	17 Jul 2003 05:27:03 -0000	1.46
+++ times.cc	4 Sep 2003 03:08:20 -0000
@@ -146,7 +146,6 @@ totimeval (struct timeval *dst, FILETIME
 extern "C" int
 gettimeofday (struct timeval *tv, struct timezone *tz)
 {
-  static hires_ms gtod;
   static bool tzflag;
   LONGLONG now =3D gtod.usecs (false);
   if (now =3D=3D (LONGLONG) -1)
@@ -620,37 +619,44 @@ hires_us::usecs (bool justdelta)
   return justdelta ? now.QuadPart : primed_ft.QuadPart + now.QuadPart;
 }

+hires_ms gtod;
+UINT NO_COPY hires_ms::minperiod;
+
 void
 hires_ms::prime ()
 {
   TIMECAPS tc;
   FILETIME f;
-  int priority =3D GetThreadPriority (GetCurrentThread ());
-  SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_TIME_CRITICAL);

-  if (timeGetDevCaps (&tc, sizeof (tc)) !=3D TIMERR_NOERROR)
-    minperiod =3D 0;
-  else
+  if (!minperiod)
+    if (timeGetDevCaps (&tc, sizeof (tc)) !=3D TIMERR_NOERROR)
+      minperiod =3D 1;
+    else
+      {
+	minperiod =3D min (max (tc.wPeriodMin, 1), tc.wPeriodMax);
+	timeBeginPeriod (minperiod);
+      }
+
+  if (!inited)
     {
-      minperiod =3D min (max (tc.wPeriodMin, 1), tc.wPeriodMax);
-      timeBeginPeriod (minperiod);
+      int priority =3D GetThreadPriority (GetCurrentThread ());
+      SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_TIME_CRITICA=
L);
+      initime_ms =3D timeGetTime ();
+      GetSystemTimeAsFileTime (&f);
+      SetThreadPriority (GetCurrentThread (), priority);
+
+      inited =3D 1;
+      initime_us.HighPart =3D f.dwHighDateTime;
+      initime_us.LowPart =3D f.dwLowDateTime;
+      initime_us.QuadPart -=3D FACTOR;
+      initime_us.QuadPart /=3D 10;
     }
-
-  initime_ms =3D timeGetTime ();
-  GetSystemTimeAsFileTime (&f);
-  SetThreadPriority (GetCurrentThread (), priority);
-
-  inited =3D 1;
-  initime_us.HighPart =3D f.dwHighDateTime;
-  initime_us.LowPart =3D f.dwLowDateTime;
-  initime_us.QuadPart -=3D FACTOR;
-  initime_us.QuadPart /=3D 10;
 }

 LONGLONG
 hires_ms::usecs (bool justdelta)
 {
-  if (!inited)
+  if (!minperiod) /* NO_COPY variable */
     prime ();
   DWORD now =3D timeGetTime ();
   // FIXME: Not sure how this will handle the 49.71 day wrap around
@@ -658,7 +664,3 @@ hires_ms::usecs (bool justdelta)
   return res;
 }

-hires_ms::~hires_ms ()
-{
-  timeEndPeriod (minperiod);
-}
Index: signal.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.47
diff -u -p -r1.47 signal.cc
--- signal.cc	1 Sep 2003 02:05:32 -0000	1.47
+++ signal.cc	4 Sep 2003 03:08:34 -0000
@@ -17,6 +17,7 @@ details. */
 #include <sys/cygwin.h>
 #include "sigproc.h"
 #include "pinfo.h"
+#include "hires.h"

 int sigcatchers;	/* FIXME: Not thread safe. */

@@ -73,20 +74,22 @@ nanosleep (const struct timespec *rqtp,
   sigframe thisframe (mainthread);
   pthread_testcancel ();

-  if (rqtp->tv_sec < 0 || rqtp->tv_nsec < 0 || rqtp->tv_nsec > 999999999)
+  if ((unsigned int) rqtp->tv_sec > (_DELAY_MAX / 1000 - 1)
+      || (unsigned int) rqtp->tv_nsec > 999999999)
     {
       set_errno (EINVAL);
       return -1;
     }
-
-  DWORD req =3D rqtp->tv_sec * 1000 + (rqtp->tv_nsec + 500000) / 1000000;
-  DWORD start_time =3D GetTickCount ();
-  DWORD end_time =3D start_time + req;
+  DWORD resolution =3D gtod.resolution ();
+  DWORD req =3D ((rqtp->tv_sec * 1000 + (rqtp->tv_nsec + 999999) / 1000000
+		+ resolution - 1) / resolution ) * resolution;
+  DWORD end_time =3D gtod.dmsecs () + req;
   syscall_printf ("nanosleep (%ld)", req);

   int rc =3D pthread::cancelable_wait (signal_arrived, req);
-  DWORD now =3D GetTickCount ();
-  DWORD rem =3D (rc =3D=3D WAIT_TIMEOUT || now >=3D end_time) ? 0 : end_ti=
me - now;
+  DWORD rem;
+  if ((rem =3D end_time - gtod.dmsecs ()) > _DELAY_MAX)
+    rem =3D 0;
   if (rc =3D=3D WAIT_OBJECT_0)
     {
       (void) thisframe.call_signal_handler ();
@@ -111,7 +114,7 @@ sleep (unsigned int seconds)
   req.tv_sec =3D seconds;
   req.tv_nsec =3D 0;
   nanosleep (&req, &rem);
-  return rem.tv_sec + (rem.tv_nsec + 500000000) / 1000000000;
+  return rem.tv_sec + (rem.tv_nsec > 0);
 }

 extern "C" unsigned int

--=====================_1062660411==_--
