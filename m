Return-Path: <cygwin-patches-return-2366-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1272 invoked by alias); 7 Jun 2002 21:05:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1235 invoked from network); 7 Jun 2002 21:05:36 -0000
Message-ID: <008801c20e67$4850f240$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Patch for epoch in hires_ms::usecs() value
Date: Fri, 07 Jun 2002 14:05:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0085_01C20E6F.A94ED5F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00349.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0085_01C20E6F.A94ED5F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 565

Currently the hires_ms::usecs() method returns microseconds from the winnt
epoch (i.e. 1 January, 1601). It is then used in gettimeofday() without
adjustment, but that is meant to give seconds and microseconds since the
"Unix" epoch (i.e. 1 January, 1970).

The attached patch changes hires_ms::usecs() to return microseconds since
the "Unix" epoch. I've changed it there since that's the easiest place to
patch it :-)
// Conrad

2002-06-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * times.cc (hires_ms::prime): Adjust epoch of initime_us from 1601
 to 1970.


------=_NextPart_000_0085_01C20E6F.A94ED5F0
Content-Type: application/octet-stream;
	name="times.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="times.patch"
Content-length: 699

Index: times.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v=0A=
retrieving revision 1.37=0A=
diff -u -r1.37 times.cc=0A=
--- times.cc	7 Jun 2002 03:44:33 -0000	1.37=0A=
+++ times.cc	7 Jun 2002 20:57:58 -0000=0A=
@@ -654,6 +654,7 @@=0A=
   SetThreadPriority (GetCurrentThread (), priority);=0A=
   initime_us.HighPart =3D f.dwHighDateTime;=0A=
   initime_us.LowPart =3D f.dwLowDateTime;=0A=
+  initime_us.QuadPart -=3D FACTOR;=0A=
   initime_us.QuadPart /=3D 10;=0A=
 }=0A=
=20=0A=

------=_NextPart_000_0085_01C20E6F.A94ED5F0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 134

2002-06-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* times.cc (hires_ms::prime): Adjust epoch of initime_us from 1601
	to 1970.

------=_NextPart_000_0085_01C20E6F.A94ED5F0--

