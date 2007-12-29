Return-Path: <cygwin-patches-return-6212-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6400 invoked by alias); 29 Dec 2007 11:27:00 -0000
Received: (qmail 6390 invoked by uid 22791); 29 Dec 2007 11:26:59 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 11:26:48 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Sat, 29 Dec 2007 11:26:45 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
References: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM> <20071221234102.GA23118@trixie.casa.cgf.cx>
Subject: RE: Export fast *rint* functions
Date: Sat, 29 Dec 2007 11:27:00 -0000
Message-ID: <071a01c84a0d$b1b79d50$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_071B_01C84A0D.B1B79D50"
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20071221234102.GA23118@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00064.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_071B_01C84A0D.B1B79D50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 819


  One quick Christmas break later.... hope everyone's had a nice week...


On 21 December 2007 23:41, Christopher Faylor wrote:

> Unless I don't know something about these functions, I don't think there
> is any reason to add a foo and a _foo.  We haven't been doing that in
> cygwin.din for years.

  Righto, I didn't know that; I just copied the existing pattern.  Revised patch
attached.

2007-12-29  Dave Korn  <dave.korn@artimi.com>

	* cygwin.din (_f_llrint, _f_llrintf, _f_llrintl, _f_lrint, _f_lrintf,
	_f_lrintl, _f_rint, _f_rintf, _f_rintl):  Export fast *rint* functions.
	(lrint, lrintf, rint, rintf):  Redirect exports to alias _f_ versions.
	(llrint, llrintf, llrintl, lrintl, rintl):  Add exports aliasing _f_*
	versions likewise.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_071B_01C84A0D.B1B79D50
Content-Type: application/octet-stream;
	name="llrint-patch-part2-revised.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="llrint-patch-part2-revised.diff"
Content-length: 2260

Index: winsup/cygwin/cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.181=0A=
diff -p -u -r1.181 cygwin.din=0A=
--- winsup/cygwin/cygwin.din	19 Dec 2007 17:38:18 -0000	1.181=0A=
+++ winsup/cygwin/cygwin.din	27 Dec 2007 20:45:03 -0000=0A=
@@ -377,6 +377,9 @@ _f_ldexp NOSIGFE=0A=
 __f_ldexp =3D _f_ldexp NOSIGFE=0A=
 _f_ldexpf NOSIGFE=0A=
 __f_ldexpf =3D _f_ldexpf NOSIGFE=0A=
+_f_llrint NOSIGFE=0A=
+_f_llrintf NOSIGFE=0A=
+_f_llrintl NOSIGFE=0A=
 _f_log NOSIGFE=0A=
 __f_log =3D _f_log NOSIGFE=0A=
 _f_log10 NOSIGFE=0A=
@@ -385,10 +388,16 @@ _f_log10f NOSIGFE=0A=
 __f_log10f =3D _f_log10f NOSIGFE=0A=
 _f_logf NOSIGFE=0A=
 __f_logf =3D _f_logf NOSIGFE=0A=
+_f_lrint NOSIGFE=0A=
+_f_lrintf NOSIGFE=0A=
+_f_lrintl NOSIGFE=0A=
 _f_pow NOSIGFE=0A=
 __f_pow =3D _f_pow NOSIGFE=0A=
 _f_powf NOSIGFE=0A=
 __f_powf =3D _f_powf NOSIGFE=0A=
+_f_rint NOSIGFE=0A=
+_f_rintf NOSIGFE=0A=
+_f_rintl NOSIGFE=0A=
 _f_tan NOSIGFE=0A=
 __f_tan =3D _f_tan NOSIGFE=0A=
 _f_tanf NOSIGFE=0A=
@@ -845,6 +854,9 @@ _link =3D link SIGFE=0A=
 listen =3D cygwin_listen SIGFE=0A=
 llabs NOSIGFE=0A=
 lldiv NOSIGFE=0A=
+llrint =3D _f_llrint NOSIGFE=0A=
+llrintf =3D _f_llrintf NOSIGFE=0A=
+llrintl =3D _f_llrintl NOSIGFE=0A=
 localeconv NOSIGFE=0A=
 _localeconv =3D localeconv NOSIGFE=0A=
 localtime SIGFE=0A=
@@ -875,8 +887,9 @@ longjmp NOSIGFE=0A=
 _longjmp =3D longjmp NOSIGFE=0A=
 lrand48 NOSIGFE=0A=
 _lrand48 =3D lrand48 NOSIGFE=0A=
-lrint NOSIGFE=0A=
-lrintf NOSIGFE=0A=
+lrint =3D _f_lrint NOSIGFE=0A=
+lrintf =3D _f_lrintf NOSIGFE=0A=
+lrintl =3D _f_lrintl NOSIGFE=0A=
 lround NOSIGFE=0A=
 lroundf NOSIGFE=0A=
 lsearch NOSIGFE=0A=
@@ -1199,10 +1212,9 @@ _rewinddir =3D rewinddir SIGFE=0A=
 rexec =3D cygwin_rexec SIGFE=0A=
 rindex NOSIGFE=0A=
 _rindex =3D rindex NOSIGFE=0A=
-rint NOSIGFE=0A=
-_rint =3D rint NOSIGFE=0A=
-rintf NOSIGFE=0A=
-_rintf =3D rintf NOSIGFE=0A=
+rint =3D _f_rint NOSIGFE=0A=
+rintf =3D _f_rintf NOSIGFE=0A=
+rintl =3D _f_rintl NOSIGFE=0A=
 rmdir SIGFE=0A=
 _rmdir =3D rmdir SIGFE=0A=
 round NOSIGFE=0A=

------=_NextPart_000_071B_01C84A0D.B1B79D50--
