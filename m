Return-Path: <cygwin-patches-return-1566-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31076 invoked by alias); 7 Dec 2001 21:48:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30850 invoked from network); 7 Dec 2001 21:48:51 -0000
Message-ID: <096e01c17eac$8230b770$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: W32API: new common control struct from XP
Date: Fri, 02 Nov 2001 12:56:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_096B_01C17F08.B52EBE90"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 06 Dec 2001 23:19:50.0156 (UTC) FILETIME=[80AFBCC0:01C17EAC]
X-SW-Source: 2001-q4/txt/msg00098.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_096B_01C17F08.B52EBE90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 172

Changelog:

2001-12-06  Robret Collins  rbtcollins@hotmail.com

    * include/commctrl.h: New typedefs for HDLAYOUT and LPHDLAYOUT based
on MSDN documentation
    for XP.


------=_NextPart_000_096B_01C17F08.B52EBE90
Content-Type: application/octet-stream;
	name="newcommctrl.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="newcommctrl.patch"
Content-length: 776

Index: include/commctrl.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/commctrl.h,v=0A=
retrieving revision 1.8=0A=
diff -u -p -r1.8 commctrl.h=0A=
--- commctrl.h	2001/09/19 23:56:12	1.8=0A=
+++ commctrl.h	2001/12/06 23:18:47=0A=
@@ -1244,6 +1244,10 @@ typedef struct _HD_LAYOUT {=0A=
 	RECT *prc;=0A=
 	WINDOWPOS *pwpos;=0A=
 } HD_LAYOUT;=0A=
+typedef struct _HD_LAYOUT_XP {=0A=
+      RECT FAR*      prc;=20=20=0A=
+      WINDOWPOS FAR* pwpos;=20=0A=
+} HDLAYOUT, FAR *LPHDLAYOUT;=20=0A=
 typedef struct _HD_HITTESTINFO {=0A=
 	POINT pt;=0A=
 	UINT flags;=0A=

------=_NextPart_000_096B_01C17F08.B52EBE90--
