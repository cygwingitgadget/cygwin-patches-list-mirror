Return-Path: <cygwin-patches-return-2497-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11609 invoked by alias); 23 Jun 2002 17:40:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11570 invoked from network); 23 Jun 2002 17:40:21 -0000
Message-ID: <07c601c21add$428ebae0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: lib/_cygwin_S_IEXEC.cc and extern "C" scope
Date: Sun, 23 Jun 2002 19:09:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_07C3_01C21AE5.A3CF9B00"
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00480.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_07C3_01C21AE5.A3CF9B00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 156

Another nit: "lib/_cygwin_S_IEXEC.cc" #include's "winsup.h" et al
inside an extern "C" declaration. Presumably it would be better done
outside.

// Conrad


------=_NextPart_000_07C3_01C21AE5.A3CF9B00
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 119

2002-06-23  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* lib/_cygwin_S_IEXEC.cc: Move #include's outside extern "C".

------=_NextPart_000_07C3_01C21AE5.A3CF9B00
Content-Type: application/octet-stream;
	name="extern-c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="extern-c.patch"
Content-length: 862

Index: lib/_cygwin_S_IEXEC.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/lib/_cygwin_S_IEXEC.cc,v=0A=
retrieving revision 1.3=0A=
diff -u -r1.3 _cygwin_S_IEXEC.cc=0A=
--- lib/_cygwin_S_IEXEC.cc	8 May 2001 15:16:49 -0000	1.3=0A=
+++ lib/_cygwin_S_IEXEC.cc	23 Jun 2002 17:38:05 -0000=0A=
@@ -8,11 +8,11 @@=0A=
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for=0A=
 details. */=0A=
=20=0A=
-extern "C" {=0A=
 #include "winsup.h"=0A=
 #include <sys/stat.h>=0A=
 #include <sys/unistd.h>=0A=
=20=0A=
+extern "C" {=0A=
 unsigned _cygwin_S_IEXEC =3D S_IEXEC;=0A=
 unsigned _cygwin_S_IXUSR =3D S_IXUSR;=0A=
 unsigned _cygwin_S_IXGRP =3D S_IXGRP;=0A=

------=_NextPart_000_07C3_01C21AE5.A3CF9B00--

