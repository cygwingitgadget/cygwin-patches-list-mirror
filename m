Return-Path: <cygwin-patches-return-2489-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19703 invoked by alias); 22 Jun 2002 15:12:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19689 invoked from network); 22 Jun 2002 15:12:46 -0000
Message-ID: <04a101c219ff$81bedf80$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Earnie Boyd" <earnie_boyd@yahoo.com>
Cc: <cygwin-patches@cygwin.com>
References: <20020622150321.13099.qmail@web20708.mail.yahoo.com>
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
Date: Sat, 22 Jun 2002 09:54:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_049E_01C21A07.E32F3410"
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00472.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_049E_01C21A07.E32F3410
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 191

Earnie,

Thanks for the reply about the WINVER setting. I've attached a new
version of the patch with a guard of _WIN32_WINNT >= 0x0500, as you
suggested.

I hope this is better.

// Conrad


------=_NextPart_000_049E_01C21A07.E32F3410
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 129

2002-06-21  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/winbase.h: Add file open flag
	FILE_FLAG_FIRST_PIPE_INSTANCE.

------=_NextPart_000_049E_01C21A07.E32F3410
Content-Type: application/octet-stream;
	name="w32api.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="w32api.patch"
Content-length: 838

Index: include/winbase.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winbase.h,v=0A=
retrieving revision 1.21=0A=
diff -u -r1.21 winbase.h=0A=
--- include/winbase.h	19 Jun 2002 01:15:44 -0000	1.21=0A=
+++ include/winbase.h	22 Jun 2002 15:09:15 -0000=0A=
@@ -183,6 +183,9 @@=0A=
 #define FILE_FLAG_POSIX_SEMANTICS	16777216=0A=
 #define FILE_FLAG_OPEN_REPARSE_POINT	2097152=0A=
 #define FILE_FLAG_OPEN_NO_RECALL	1048576=0A=
+#if (_WIN32_WINNT >=3D 0x0500) /* Needs win2k sp2 or XP or later */=0A=
+#define FILE_FLAG_FIRST_PIPE_INSTANCE	524288=0A=
+#endif=0A=
 #define CLRDTR 6=0A=
 #define CLRRTS 4=0A=
 #define SETDTR 5=0A=

------=_NextPart_000_049E_01C21A07.E32F3410--

