Return-Path: <cygwin-patches-return-2265-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27858 invoked by alias); 30 May 2002 01:09:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27824 invoked from network); 30 May 2002 01:09:03 -0000
X-WM-Posted-At: avacado.atomice.net; Thu, 30 May 02 02:12:15 +0100
Message-ID: <00cc01c20777$0957d910$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
References: <00af01c20775$ddf2a530$0100a8c0@advent02>
Subject: Re: Patch to add missing ANSI_STRING typedef to ntdef.h
Date: Wed, 29 May 2002 18:09:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C9_01C2077F.6AF61B70"
X-Priority: 3
X-MSMail-Priority: Normal
x-mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00248.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00C9_01C2077F.6AF61B70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 144

> This patch adds typedefs for ANSI_STRING, PANSI_STRING, OEM_STRING and
> POEM_STRING to ntdef.h
Apologies, I did not attach the patch... :-)


------=_NextPart_000_00C9_01C2077F.6AF61B70
Content-Type: application/octet-stream;
	name="ntdef.h.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ntdef.h.patch"
Content-length: 816

Index: ntdef.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/ntdef.h,v=0A=
retrieving revision 1.6=0A=
diff -u -3 -p -u -p -b -B -r1.6 ntdef.h=0A=
--- ntdef.h	9 Mar 2002 09:04:09 -0000	1.6=0A=
+++ ntdef.h	30 May 2002 01:07:52 -0000=0A=
@@ -37,6 +36,10 @@ typedef struct _STRING {=0A=
   PCHAR  Buffer;=0A=
 } STRING, *PSTRING;=0A=
 #endif=0A=
+typedef STRING ANSI_STRING;=0A=
+typedef PSTRING PANSI_STRING;=0A=
+typedef STRING OEM_STRING;=0A=
+typedef PSTRING POEM_STRING;=0A=
 typedef LARGE_INTEGER PHYSICAL_ADDRESS, *PPHYSICAL_ADDRESS;=0A=
 typedef enum _SECTION_INHERIT {=0A=
   ViewShare =3D 1,=0A=

------=_NextPart_000_00C9_01C2077F.6AF61B70--
