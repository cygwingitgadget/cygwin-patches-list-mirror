Return-Path: <cygwin-patches-return-2286-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20192 invoked by alias); 2 Jun 2002 11:02:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20144 invoked from network); 2 Jun 2002 11:02:09 -0000
X-WM-Posted-At: avacado.atomice.net; Sun, 2 Jun 02 12:05:23 +0100
Message-ID: <000a01c20a25$6440a0e0$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: bug fix for empty files in /proc/<n>
Date: Sun, 02 Jun 2002 04:02:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0007_01C20A2D.C5DBD600"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00269.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C20A2D.C5DBD600
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 811

This patch fixes the empty files bug that cropped up a little while back. I
don't plan on doing any more patches except bug fixes until 1.3.11 is
released because I don't have the time.

Regards
Chris

2002-02-26  Christopher January <chris@atomice.net>

    * fhandler_process.cc (fhandler_process::open): Set fileid.

Index: fhandler_process.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v
retrieving revision 1.11
diff -u -p -b -B -r1.11 fhandler_process.cc
--- fhandler_process.cc 2 Jun 2002 06:07:00 -0000 1.11
+++ fhandler_process.cc 2 Jun 2002 10:58:41 -0000
@@ -226,6 +226,7 @@ fhandler_process::open (path_conv *pc, i
       goto out;
     }

+  fileid = process_file_no;
   fill_filebuf (p);

   if (flags & O_APPEND)


------=_NextPart_000_0007_01C20A2D.C5DBD600
Content-Type: application/octet-stream;
	name="proc.patch.5"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc.patch.5"
Content-length: 696

Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.11=0A=
diff -u -p -b -B -r1.11 fhandler_process.cc=0A=
--- fhandler_process.cc	2 Jun 2002 06:07:00 -0000	1.11=0A=
+++ fhandler_process.cc	2 Jun 2002 10:58:41 -0000=0A=
@@ -226,6 +226,7 @@ fhandler_process::open (path_conv *pc, i=0A=
       goto out;=0A=
     }=0A=
=20=0A=
+  fileid =3D process_file_no;=0A=
   fill_filebuf (p);=0A=
=20=0A=
   if (flags & O_APPEND)=0A=

------=_NextPart_000_0007_01C20A2D.C5DBD600--
