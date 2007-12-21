Return-Path: <cygwin-patches-return-6206-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31946 invoked by alias); 21 Dec 2007 18:46:14 -0000
Received: (qmail 31929 invoked by uid 22791); 21 Dec 2007 18:46:12 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 21 Dec 2007 18:46:08 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Fri, 21 Dec 2007 18:46:06 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: Export fast *rint* functions
Date: Fri, 21 Dec 2007 18:46:00 -0000
Message-ID: <050e01c84401$be876720$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_050F_01C84401.BE876720"
X-Mailer: Microsoft Office Outlook 11
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00058.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_050F_01C84401.BE876720
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 1409


    Hi gang,
 
  This patch exports all the new _f_*rint* functions from newlib, adds aliases for
the non-_f_* names, and redirects the exports for the existing functions
(rint/rintf/lrint/lrintf) away from the current slow soft float implementation and
toward the _f_ versions.  The slow soft float implementation is still linked
internally in the dll against some functions such as nearbyint(), pow(), powf(), and
a few others.

  As far as I can see, there's no reason not to get rid of the old slow soft-float
implementations altogether, and that will be the subject of a follow-on patch to
newlib, but it'll have to wait for Jeff to get back from holiday now.

  Oh, and Happy Christmas! to the MPlayer and ffmpeg teams :)

winsup/cygwin/ChangeLog

2007-12-21  Dave Korn  <dave.korn@artimi.com>

	* cygwin.din (_f_lrint, __f_lrint, _f_lrintf, __f_lrintf, _f_lrintl,
	__f_lrintl, _f_llrint, __f_llrint, _f_llrintf, __f_llrintf,
	_f_llrintl, __f_llrintl, _f_rint, __f_rint, _f_rintf, __f_rintf,
	_f_rintl, __f_rintl):  Export fast *rint* functions.
	(lrint, lrintf, rint, _rint, rintf, _rintf):  Redirect exports to
	alias _f_ versions.
	(_lrint, _lrintf):  Added for consistency at the same time.
	(lrintl, _lrintl, llrint, _llrint, llrintf, _llrintf, llrintl,
	_llrintl, rintl, _rintl):  Add exports aliasing _f_ versions likewise.

    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_050F_01C84401.BE876720
Content-Type: application/octet-stream;
	name="llrint-patch-part2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="llrint-patch-part2.diff"
Content-length: 2704

Index: winsup/cygwin/cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.181=0A=
diff -p -u -r1.181 cygwin.din=0A=
--- winsup/cygwin/cygwin.din	19 Dec 2007 17:38:18 -0000	1.181=0A=
+++ winsup/cygwin/cygwin.din	21 Dec 2007 18:25:52 -0000=0A=
@@ -377,6 +377,12 @@ _f_ldexp NOSIGFE=0A=
 __f_ldexp =3D _f_ldexp NOSIGFE=0A=
 _f_ldexpf NOSIGFE=0A=
 __f_ldexpf =3D _f_ldexpf NOSIGFE=0A=
+_f_lrint NOSIGFE=0A=
+__f_lrint =3D _f_lrint NOSIGFE=0A=
+_f_lrintf NOSIGFE=0A=
+__f_lrintf =3D _f_lrintf NOSIGFE=0A=
+_f_lrintl NOSIGFE=0A=
+__f_lrintl =3D _f_lrintl NOSIGFE=0A=
 _f_log NOSIGFE=0A=
 __f_log =3D _f_log NOSIGFE=0A=
 _f_log10 NOSIGFE=0A=
@@ -385,10 +391,22 @@ _f_log10f NOSIGFE=0A=
 __f_log10f =3D _f_log10f NOSIGFE=0A=
 _f_logf NOSIGFE=0A=
 __f_logf =3D _f_logf NOSIGFE=0A=
+_f_llrint NOSIGFE=0A=
+__f_llrint =3D _f_llrint NOSIGFE=0A=
+_f_llrintf NOSIGFE=0A=
+__f_llrintf =3D _f_llrintf NOSIGFE=0A=
+_f_llrintl NOSIGFE=0A=
+__f_llrintl =3D _f_llrintl NOSIGFE=0A=
 _f_pow NOSIGFE=0A=
 __f_pow =3D _f_pow NOSIGFE=0A=
 _f_powf NOSIGFE=0A=
 __f_powf =3D _f_powf NOSIGFE=0A=
+_f_rint NOSIGFE=0A=
+__f_rint =3D _f_rint NOSIGFE=0A=
+_f_rintf NOSIGFE=0A=
+__f_rintf =3D _f_rintf NOSIGFE=0A=
+_f_rintl NOSIGFE=0A=
+__f_rintl =3D _f_rintl NOSIGFE=0A=
 _f_tan NOSIGFE=0A=
 __f_tan =3D _f_tan NOSIGFE=0A=
 _f_tanf NOSIGFE=0A=
@@ -875,8 +893,18 @@ longjmp NOSIGFE=0A=
 _longjmp =3D longjmp NOSIGFE=0A=
 lrand48 NOSIGFE=0A=
 _lrand48 =3D lrand48 NOSIGFE=0A=
-lrint NOSIGFE=0A=
-lrintf NOSIGFE=0A=
+lrint =3D _f_lrint NOSIGFE=0A=
+_lrint =3D _f_lrint NOSIGFE=0A=
+lrintf =3D _f_lrintf NOSIGFE=0A=
+_lrintf =3D _f_lrintf NOSIGFE=0A=
+lrintl =3D _f_lrintl NOSIGFE=0A=
+_lrintl =3D _f_lrintl NOSIGFE=0A=
+llrint =3D _f_llrint NOSIGFE=0A=
+_llrint =3D _f_llrint NOSIGFE=0A=
+llrintf =3D _f_llrintf NOSIGFE=0A=
+_llrintf =3D _f_llrintf NOSIGFE=0A=
+llrintl =3D _f_llrintl NOSIGFE=0A=
+_llrintl =3D _f_llrintl NOSIGFE=0A=
 lround NOSIGFE=0A=
 lroundf NOSIGFE=0A=
 lsearch NOSIGFE=0A=
@@ -1199,10 +1227,12 @@ _rewinddir =3D rewinddir SIGFE=0A=
 rexec =3D cygwin_rexec SIGFE=0A=
 rindex NOSIGFE=0A=
 _rindex =3D rindex NOSIGFE=0A=
-rint NOSIGFE=0A=
-_rint =3D rint NOSIGFE=0A=
-rintf NOSIGFE=0A=
-_rintf =3D rintf NOSIGFE=0A=
+rint =3D _f_rint NOSIGFE=0A=
+_rint =3D _f_rint NOSIGFE=0A=
+rintf =3D _f_rintf NOSIGFE=0A=
+_rintf =3D _f_rintf NOSIGFE=0A=
+rintl =3D _f_rintl NOSIGFE=0A=
+_rintl =3D _f_rintl NOSIGFE=0A=
 rmdir SIGFE=0A=
 _rmdir =3D rmdir SIGFE=0A=
 round NOSIGFE=0A=

------=_NextPart_000_050F_01C84401.BE876720--
