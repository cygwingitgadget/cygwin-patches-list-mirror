Return-Path: <cygwin-patches-return-4165-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8517 invoked by alias); 5 Sep 2003 01:42:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8499 invoked from network); 5 Sep 2003 01:42:01 -0000
Message-Id: <3.0.5.32.20030904214017.0081d6d0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 05 Sep 2003 01:42:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: nanosleep patch 1
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1062740417==_"
X-SW-Source: 2003-q3/txt/msg00181.txt.bz2

--=====================_1062740417==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 984

This is part 1 of the patch I sent yesterday.
See previous mails for background  info.
Here are some more details:

hires_ms::minperiod    Make NO_COPY for per process initialization.
hires_ms::resolution   For use in sleep and alarm
hires_ms::dmsecs       Ditto
_DELAY_MAX             Ditto
hires_ms::~hires_ms    Delete, rely on Windows end of process cleanup.
                       Note that previous version could call timeEndPeriod
                       even when timeBeginPeriod had not been called.

Pierre

2003-09-04  Pierre Humblet <pierre.humblet@ieee.org>

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
	(gtod) Define as global.


--=====================_1062740417==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sleep1.diff"
Content-length: 3914

Index: hires.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/hires.h,v
retrieving revision 1.4
diff -u -p -r1.4 hires.h
--- hires.h	30 Sep 2002 02:51:21 -0000	1.4
+++ hires.h	5 Sep 2003 01:15:00 -0000
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
+++ times.cc	5 Sep 2003 01:15:01 -0000
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

--=====================_1062740417==_--
