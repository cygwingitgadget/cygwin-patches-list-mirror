Return-Path: <cygwin-patches-return-2004-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21860 invoked by alias); 26 Mar 2002 11:41:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21790 invoked from network); 26 Mar 2002 11:40:43 -0000
content-class: urn:content-classes:message
Subject: RE: Re[2]: [PATCH] setup.exe: mkdir.cc. was: setup.exe crash
Date: Tue, 26 Mar 2002 03:48:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Message-ID: <FC169E059D1A0442A04C40F86D9BA76008ABB3@itdomain003.itdomain.net.au>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
X-MS-TNEF-Correlator: 
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Pavel Tsekov" <ptsekov@syntrex.com>
Cc: <cygwin-patches@cygwin.com>
X-SW-Source: 2002-q1/txt/msg00361.txt.bz2



> -----Original Message-----
> From: Pavel Tsekov [mailto:ptsekov@syntrex.com]=20
> Sent: Tuesday, March 26, 2002 10:28 PM
> To: Robert Collins
> Cc: cygwin-patches@cygwin.com
> Subject: Re[2]: [PATCH] setup.exe: mkdir.cc. was: setup.exe crash
>=20
>=20
> Hello Robert,
>=20
> Tuesday, March 26, 2002, 12:10:09 PM, you wrote:
>=20
> RC> Pavel,
> RC>         care to supply a changelog? Thanks for tracking this down=20
> RC> too.
>=20
> Of course! :) I didn't supply it the first time because I've=20
> sent the patch for review.
>=20
> Btw.  I haven't checked if the new return value is a problem=20
> for any of the mkdir_p () callers.

Oh, it may well be, so I was going to checkin a variant anyway:

1 is failure :}.

Index: mkdir.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cinstall/mkdir.cc,v
retrieving revision 2.3
diff -u -p -r2.3 mkdir.cc
--- mkdir.cc    2001/11/13 01:49:32     2.3
+++ mkdir.cc    2002/03/26 11:40:10
@@ -69,6 +69,10 @@ mkdir_p (int isadir, const char *in_path
   if (!slash)
     return 0;

+  // Trying to create a drive... It's time to give up.
+  if (((slash - path) =3D=3D 2) && (path[1] =3D=3D ':'))
+    return 1;
+
   saved_char =3D *slash;
   *slash =3D 0;
   if (mkdir_p (1, path))
@@ -76,6 +80,7 @@ mkdir_p (int isadir, const char *in_path
       *slash =3D saved_char;
       return 1;
     }
+
   *slash =3D saved_char;

   if (!isadir)
