Return-Path: <cygwin-patches-return-1785-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15294 invoked by alias); 25 Jan 2002 10:43:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15254 invoked from network); 25 Jan 2002 10:43:17 -0000
Message-ID: <02b901c1a58d$11e86820$a100a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <003f01c1a542$742968e0$a100a8c0@mchasecompaq><20020125015129.GA16592@redhat.com> <015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq><1011948812.18172.17.camel@lifelesswks> <021701c1a584$f9371f90$a100a8c0@mchasecompaq> <1011953063.18172.21.camel@lifelesswks> <026301c1a589$84e33570$a100a8c0@mchasecompaq>
Subject: Re: [PATCH]Package extention recognition (revision 2)
Date: Fri, 25 Jan 2002 02:43:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_02B6_01C1A54A.005E0850"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00142.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_02B6_01C1A54A.005E0850
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-length: 549

I think this covers all your concerns.  If not, I'll fix it in the morning.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-01-25  Michael A Chase <mchase@ix.netcom.com>

    * filemanip.cc (find_tar_ext): Clean up tests for .tar.gz and .tar.
    * fromcwd.cc (do_fromcwd): Expand FIXME comment in source file check.
    * install.cc (install_one_source): Add space between words in log()
call.


------=_NextPart_000_02B6_01C1A54A.005E0850
Content-Type: application/octet-stream;
	name="install.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="install.cc-patch"
Content-length: 455

--- install.cc-0	Thu Jan 24 17:22:12 2002=0A=
+++ install.cc	Thu Jan 24 17:22:41 2002=0A=
@@ -184,7 +184,7 @@ install_one_source (packagemeta & pkgm,=20=0A=
   char msg[64];=0A=
   strcpy (msg, "Installing");=0A=
   Progress.SetText1 (msg);=0A=
-  log (0, "%s%s", msg, source.Cached ());=0A=
+  log (0, "%s %s", msg, source.Cached ());=0A=
   io_stream *tmp =3D io_stream::open (source.Cached (), "rb");=0A=
   archive *thefile =3D 0;=0A=
   if (tmp)=0A=

------=_NextPart_000_02B6_01C1A54A.005E0850
Content-Type: application/octet-stream;
	name="filemanip.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="filemanip.cc-patch"
Content-length: 981

--- filemanip.cc-0	Thu Jan 24 16:43:57 2002=0A=
+++ filemanip.cc	Fri Jan 25 02:26:39 2002=0A=
@@ -66,13 +66,14 @@ find_tar_ext (const char *path)=0A=
 {=0A=
   char *end =3D strchr (path, '\0');=0A=
   /* check in longest first order */=0A=
-  char *ext =3D strstr (path, ".tar.bz2");=0A=
-  if (ext)=0A=
-    return (end - ext) =3D=3D 8 ? ext - path : 0;=0A=
-  if ((ext =3D strstr (path, ".tar.gz")));=0A=
-  return (end - ext) =3D=3D 7 ? ext - path : 0;=0A=
-  if ((ext =3D strstr (path, ".tar")));=0A=
-  return (end - ext) =3D=3D 4 ? ext - path : 0;=0A=
+  char *ext;=0A=
+  if ((ext =3D strstr (path, ".tar.bz2")) && (end - ext) =3D=3D 8)=0A=
+    return ext - path;=0A=
+  if ((ext =3D strstr (path, ".tar.gz")) && (end - ext) =3D=3D 7)=0A=
+    return ext - path;=0A=
+  if ((ext =3D strstr (path, ".tar")) && (end - ext) =3D=3D 4)=0A=
+    return ext - path;=0A=
+  return 0;=0A=
 }=0A=
=20=0A=
 /* Parse a filename into package, version, and extension components. */=0A=

------=_NextPart_000_02B6_01C1A54A.005E0850
Content-Type: application/octet-stream;
	name="fromcwd.cc-patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fromcwd.cc-patch"
Content-length: 379

--- fromcwd.cc-0	Fri Jan 25 02:32:04 2002=0A=
+++ fromcwd.cc	Fri Jan 25 02:28:59 2002=0A=
@@ -164,7 +164,7 @@ do_fromcwd (HINSTANCE h, HWND owner)=0A=
   find (".", found_file);=0A=
=20=0A=
 #if 0=0A=
-  // Reinstate this FIXME:=0A=
+  // Reinstate this FIXME: Replace obsolete structures first=0A=
   // Now see about source tarballs=0A=
   int i, t;=0A=
   packagemeta *p;=0A=

------=_NextPart_000_02B6_01C1A54A.005E0850--

