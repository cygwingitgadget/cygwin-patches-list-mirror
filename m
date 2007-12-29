Return-Path: <cygwin-patches-return-6221-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9536 invoked by alias); 29 Dec 2007 18:36:52 -0000
Received: (qmail 9526 invoked by uid 22791); 29 Dec 2007 18:36:52 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (194.72.81.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Dec 2007 18:36:46 +0000
Received: from rainbow ([192.168.8.46]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.3959); 	 Sat, 29 Dec 2007 18:36:43 +0000
From: "Dave Korn" <dave.korn@artimi.com>
To: "Cygwin patches" <cygwin-patches@cygwin.com>
Subject: BLODA update for bmnet.dll detect
Date: Sat, 29 Dec 2007 18:36:00 -0000
Message-ID: <075301c84a49$c2b3cb10$2e08a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; 	boundary="----=_NextPart_000_0754_01C84A49.C2B3CB10"
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
X-SW-Source: 2007-q4/txt/msg00073.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0754_01C84A49.C2B3CB10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 452



  Here's an update that adds BLODA detection for the ByteMobile laptop
optimisation client that Corinna discovered causing problems.


winsup/utils/ChangeLog

2007-12-29  Dave Korn  <dave.korn@artimi.com>

	* bloda.cc (enum bad_app):  Add BYTEMOBILE.
	(dodgy_app_detects[]):  Add FILENAME entry to detect bmnet.dll.
	(big_list_of_dodgy_apps[]):  Add description for BYTEMOBILE.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....

------=_NextPart_000_0754_01C84A49.C2B3CB10
Content-Type: application/octet-stream;
	name="bloda-update.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bloda-update.patch"
Content-length: 2304

Index: winsup/utils/bloda.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/utils/bloda.cc,v=0A=
retrieving revision 1.2=0A=
diff -p -u -r1.2 bloda.cc=0A=
--- winsup/utils/bloda.cc	21 Dec 2007 03:32:46 -0000	1.2=0A=
+++ winsup/utils/bloda.cc	29 Dec 2007 18:29:25 -0000=0A=
@@ -41,13 +41,19 @@=0A=
     LanDesk=0A=
     Windows Defender=20=0A=
     Embassy Trust Suite fingerprint reader software containing wxvault.dll=
=0A=
+    ByteMobile laptop optimization client=0A=
+=0A=
+  A live version is now being maintained in the Cygwin FAQ, at=0A=
+    http://cygwin.com/faq/faq.using.html#faq.using.bloda=0A=
+=0A=
 */=0A=
=20=0A=
 enum bad_app=0A=
 {=0A=
   SONIC,    NORTON,  MACAFFEE,    SYMANTEC,=0A=
   LOGITECH, KERIO,   AGNITUM,     ZONEALARM,=0A=
-  IOLO,     LANDESK, WINDEFENDER, EMBASSYTS=0A=
+  IOLO,     LANDESK, WINDEFENDER, EMBASSYTS,=0A=
+  BYTEMOBILE=0A=
 };=0A=
=20=0A=
 struct bad_app_info=0A=
@@ -78,6 +84,7 @@ static const struct bad_app_det dodgy_ap=0A=
   { HKLMKEY,     "SYSTEM\\CurrentControlSet\\Services\\lvprcsrv",         =
       LOGITECH   },=0A=
   { PROCESSNAME, "LVPrcSrv.exe",                                          =
       LOGITECH   },=0A=
   { FILENAME,    "%programfiles%\\common files\\logitech\\lvmvfm\\LVPrcSrv=
.exe", LOGITECH   },=0A=
+  { FILENAME,    "%windir%\\System32\\bmnet.dll",                         =
       BYTEMOBILE },=0A=
 };=20=0A=
=20=0A=
 static const size_t num_of_detects =3D sizeof (dodgy_app_detects) / sizeof=
 (dodgy_app_detects[0]);=0A=
@@ -96,6 +103,7 @@ static struct bad_app_info big_list_of_d=0A=
   { LANDESK,     "Landesk"                                                =
                },=0A=
   { WINDEFENDER, "Windows Defender"                                       =
                },=0A=
   { EMBASSYTS,   "Embassy Trust Suite fingerprint reader software containi=
ng wxvault.dll" },=0A=
+  { BYTEMOBILE,  "ByteMobile laptop optimization client"                  =
                },=0A=
 };=0A=
=20=0A=
 static const size_t num_of_dodgy_apps =3D sizeof (big_list_of_dodgy_apps) =
/ sizeof (big_list_of_dodgy_apps[0]);=0A=

------=_NextPart_000_0754_01C84A49.C2B3CB10--
