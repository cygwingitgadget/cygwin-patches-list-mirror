Return-Path: <cygwin-patches-return-1665-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1282 invoked by alias); 8 Jan 2002 05:27:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1246 invoked from network); 8 Jan 2002 05:27:21 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "Cygwin-Patches" <cygwin-patches@sources.redhat.com>
Subject: [PATCH] Setup.exe page navigation when using local dir install
Date: Mon, 07 Jan 2002 21:27:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKMEHICIAA.g.r.vansickle@worldnet.att.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01C197D2.DDE233C0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-SW-Source: 2002-q1/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C197D2.DDE233C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 90

This should make moving around a little easier.

-- 
Gary R. Van Sickle
Brewer.  Patriot. 
------=_NextPart_000_0010_01C197D2.DDE233C0
Content-Type: application/octet-stream;
	name="setup.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="setup.diff"
Content-length: 1703

? res.aps=0A=
Index: fromcwd.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/fromcwd.cc,v=0A=
retrieving revision 2.17=0A=
diff -p -u -r2.17 fromcwd.cc=0A=
--- fromcwd.cc	2001/12/23 12:13:28	2.17=0A=
+++ fromcwd.cc	2002/01/08 05:21:16=0A=
@@ -124,13 +124,13 @@ do_fromcwd (HINSTANCE h, HWND owner)=0A=
   found_ini =3D false;=0A=
   find (".", check_ini);=0A=
   if (found_ini)=0A=
-  {=0A=
-      // No INI found, we'll have to download one.=0A=
-	  next_dialog =3D IDD_S_LOAD_INI;=0A=
+    {=0A=
+      // Found INI, load it.=0A=
+      next_dialog =3D IDD_S_LOAD_INI;=0A=
       return;=0A=
-  }=0A=
+    }=0A=
=20=0A=
-  next_dialog =3D IDD_CHOOSE;=0A=
+  next_dialog =3D IDD_CHOOSER;=0A=
=20=0A=
   find (".", found_file);=0A=
=20=0A=
Index: ini.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cinstall/ini.cc,v=0A=
retrieving revision 2.16=0A=
diff -p -u -r2.16 ini.cc=0A=
--- ini.cc	2001/12/23 12:13:29	2.16=0A=
+++ ini.cc	2002/01/08 05:21:16=0A=
@@ -63,7 +63,7 @@ static int local_ini;=0A=
 static void=0A=
 find_routine (char *path, unsigned int fsize)=0A=
 {=0A=
-  if (!strstr (path, "/setup.ini") )=0A=
+  if (!strstr (path, "setup.ini") )=0A=
     return;=0A=
   io_stream *ini_file =3D io_stream::open (concat ("file://", local_dir,"/=
", path, 0), "rb");=0A=
   if (!ini_file)=0A=

------=_NextPart_000_0010_01C197D2.DDE233C0
Content-Type: application/octet-stream;
	name="ChangeLog.setup.grvs"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.setup.grvs"
Content-length: 270

2002-01-07  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>=0A=
=0A=
	* fromcwd.cc: Run indent.=0A=
	(do_fromcwd): Reverse sense of comment.  Set next_dialog=0A=
	to IDD_CHOOSER instead of IDD_CHOOSE.=0A=
	* ini.cc (find_routine): Remove "/" from "/setup.ini".=0A=

------=_NextPart_000_0010_01C197D2.DDE233C0--
