Return-Path: <cygwin-patches-return-4418-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 387 invoked by alias); 17 Nov 2003 22:20:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 361 invoked from network); 17 Nov 2003 22:20:03 -0000
Message-ID: <71A0F7B0F1F4F94F85F3D64C4BD0CCFE03C214FA@bmkc1svmail01.am.mfg>
From: "Parker, Ron" <rdparker@butlermfg.com>
To: Robert Collins <rbcollins@cygwin.com>
Cc: Arch Users <gnu-arch-users@gnu.org>, cygwin-patches@cygwin.com
Subject: RE: Additional Cygwin long file path patch
Date: Mon, 17 Nov 2003 22:20:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3AD58.BA50A340"
X-SW-Source: 2003-q4/txt/msg00137.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3AD58.BA50A340
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 356

> From: Parker, Ron [mailto:rdparker@butlermfg.com]

> > From: Robert Collins [mailto:rbcollins@cygwin.com]
> 
> > 1a) Update CYG_MAX_PATH to (say) 270. Check for issues with the change
> > occuring, and rectify.

I actually bumped CYG_MAX_PATH to 520, double its previous value.  It seems
to be work for me and allows tla to actually create deep paths.



------_=_NextPart_000_01C3AD58.BA50A340
Content-Type: application/octet-stream;
	name="rbc02-cyg-max-path-520.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rbc02-cyg-max-path-520.diff"
Content-length: 651

--- ../../../cygwin-cvs/winsup/cygwin/winsup.h	2003-11-17 11:20:40.28353120=
0 -0600=0A=
+++ winsup.h	2003-11-17 14:39:15.146262400 -0600=0A=
@@ -66,11 +66,11 @@=0A=
=20=20=20=20=0A=
    Windows ANSI calls are limited to MAX_PATH in length. Cygwin calls that=
=0A=
    thunk through to Windows Wide calls are limited to 32K. We define=0A=
-   CYG_MAX_PATH as a convenient, not to short, not too long 'happy medium'=
.=0A=
+   CYG_MAX_PATH as a convenient, not too short, not too long 'happy medium=
'.=0A=
=20=20=20=20=0A=
    */=0A=
=20=0A=
-#define CYG_MAX_PATH (MAX_PATH)=0A=
+#define CYG_MAX_PATH (520)=0A=
=20=0A=
 #ifdef __cplusplus=0A=
=20=0A=

------_=_NextPart_000_01C3AD58.BA50A340--
