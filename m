Return-Path: <cygwin-patches-return-4166-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8971 invoked by alias); 5 Sep 2003 01:42:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8955 invoked from network); 5 Sep 2003 01:42:55 -0000
Message-Id: <3.0.5.32.20030904214114.00814b30@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 05 Sep 2003 01:42:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: nanosleep patch 2
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1062740474==_"
X-SW-Source: 2003-q3/txt/msg00182.txt.bz2

--=====================_1062740474==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 292

And here is part 2, ChangeLog is self explanatory.

2003-09-04  Pierre Humblet <pierre.humblet@ieee.org>

	* signal.cc (nanosleep): Improve test for valid values.
	Round delay up to resolution. Fix test for negative remainder. 
	Use timeGetTime through gtod.
	(sleep): Round up return value.

--=====================_1062740474==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sleep2.diff"
Content-length: 1980

Index: signal.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/signal.cc,v
retrieving revision 1.47
diff -u -p -r1.47 signal.cc
--- signal.cc	1 Sep 2003 02:05:32 -0000	1.47
+++ signal.cc	5 Sep 2003 01:15:46 -0000
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

--=====================_1062740474==_--
