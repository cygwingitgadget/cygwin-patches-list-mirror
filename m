Return-Path: <cygwin-patches-return-3996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14445 invoked by alias); 8 Jul 2003 18:09:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14433 invoked from network); 8 Jul 2003 18:09:11 -0000
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: start_time patch for fhandler_process.cc
Date: Tue, 08 Jul 2003 18:09:00 -0000
Message-ID: <ICEBIHGCEJIPLNMBNCMKGEIECIAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C34584.6ADF13F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-SW-Source: 2003-q3/txt/msg00012.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C34584.6ADF13F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 209

Try this Chris and see if it solves the start time problem.

Chris

2003-07-28  Chris January  <kseitz@chris@atomice.net>

	* fhandler_process.cc (format_process_stat): Changed the calculation for
start_time.

------=_NextPart_000_0000_01C34584.6ADF13F0
Content-Type: application/octet-stream;
	name="start_time.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="start_time.patch"
Content-length: 1609

Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.34=0A=
diff -u -p -r1.34 fhandler_process.cc=0A=
--- fhandler_process.cc	16 Jun 2003 03:24:10 -0000	1.34=0A=
+++ fhandler_process.cc	8 Jul 2003 18:05:17 -0000=0A=
@@ -462,6 +462,8 @@ format_process_stat (_pinfo *p, char *de=0A=
        fault_count =3D vmc.PageFaultCount;=0A=
        utime =3D put.UserTime.QuadPart * HZ / 10000000ULL;=0A=
        stime =3D put.KernelTime.QuadPart * HZ / 10000000ULL;=0A=
+       start_time =3D (put.CreateTime.QuadPart - stodi.BootTime.QuadPart) =
* HZ / 10000000ULL;=0A=
+#if 0=0A=
        if (stodi.CurrentTime.QuadPart > put.CreateTime.QuadPart)=0A=
 	 start_time =3D (spt.KernelTime.QuadPart + spt.UserTime.QuadPart -=0A=
 		       stodi.CurrentTime.QuadPart + put.CreateTime.QuadPart) * HZ / 1000=
0000ULL;=0A=
@@ -471,7 +473,8 @@ format_process_stat (_pinfo *p, char *de=0A=
 	  * Note: some older versions of procps are broken and can't cope=0A=
 	  * with process start times > time(NULL).=0A=
 	  */=0A=
-	 start_time =3D (spt.KernelTime.QuadPart + spt.UserTime.QuadPart) * HZ / =
10000000ULL;=0A=
+	 start_time =3D (spt.KernelTme.QuadPart + spt.UserTime.QuadPart) * HZ / 1=
0000000ULL;=0A=
+#endif=0A=
        priority =3D pbi.BasePriority;=0A=
        unsigned page_size =3D getpagesize ();=0A=
        vmsize =3D vmc.PagefileUsage;=0A=

------=_NextPart_000_0000_01C34584.6ADF13F0--
