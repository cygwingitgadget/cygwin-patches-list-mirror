Return-Path: <cygwin-patches-return-2048-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28417 invoked by alias); 10 Apr 2002 17:57:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28403 invoked from network); 10 Apr 2002 17:57:06 -0000
Message-ID: <018801c1e0b8$fc496fc0$d900a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]setup.exe: delete called for NULL pointer
Date: Wed, 10 Apr 2002 10:57:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0144_01C1E079.579742C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00032.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0144_01C1E079.579742C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 660

I don't know if this delete call is a problem, but every other place I found
delete called in the setup.exe source, the variable was either confirmed not
NULL or the variable was certain to not be NULL.  In this case, the variable
either must be NULL or the buffer is too small.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.html
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

ChangeLog:

2002-04-10  Michael A Chase <mchase@ix.netcom.com>

    * rfc1738.cc (rfc1738_do_escape): Don't delete buf if it is 0.

------=_NextPart_000_0144_01C1E079.579742C0
Content-Type: application/octet-stream;
	name="cinstall-mac-020410-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cinstall-mac-020410-1.patch"
Content-length: 392

--- rfc1738.cc-0	Mon Feb 18 11:19:24 2002=0A=
+++ rfc1738.cc	Wed Apr 10 10:06:35 2002=0A=
@@ -88,7 +88,8 @@ rfc1738_do_escape (const char *url, int=20=0A=
=20=0A=
   if (buf =3D=3D NULL || strlen (url) * 3 > bufsize)=0A=
     {=0A=
-      delete[] buf;=0A=
+      if (buf)=0A=
+	delete[] buf;=0A=
       bufsize =3D strlen (url) * 3 + 1;=0A=
       buf =3D new char [bufsize];=0A=
     }=0A=

------=_NextPart_000_0144_01C1E079.579742C0--
