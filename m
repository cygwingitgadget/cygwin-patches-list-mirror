Return-Path: <cygwin-patches-return-2481-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27205 invoked by alias); 21 Jun 2002 11:54:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27167 invoked from network); 21 Jun 2002 11:54:51 -0000
Message-ID: <03bf01c2191a$af67ba50$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
Date: Fri, 21 Jun 2002 04:54:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03BC_01C21923.1066FD90"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00464.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_03BC_01C21923.1066FD90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 387

I've attached a patch to add the (new-ish) CreateNamedPipe flag
FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>.

// Conrad

[This seems to be the correct mailing list for w32api patches. Please
forward this on and/or give me a hint otherwise. Thanks.]

2002-06-21  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * include/winbase.h: Add file open flag
FILE_FLAG_FIRST_PIPE_INSTANCE.


------=_NextPart_000_03BC_01C21923.1066FD90
Content-Type: application/octet-stream;
	name="w32api.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="w32api.patch"
Content-length: 753

Index: include/winbase.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winbase.h,v=0A=
retrieving revision 1.21=0A=
diff -u -r1.21 winbase.h=0A=
--- include/winbase.h	19 Jun 2002 01:15:44 -0000	1.21=0A=
+++ include/winbase.h	21 Jun 2002 11:45:02 -0000=0A=
@@ -183,6 +183,7 @@=0A=
 #define FILE_FLAG_POSIX_SEMANTICS	16777216=0A=
 #define FILE_FLAG_OPEN_REPARSE_POINT	2097152=0A=
 #define FILE_FLAG_OPEN_NO_RECALL	1048576=0A=
+#define FILE_FLAG_FIRST_PIPE_INSTANCE	524288=0A=
 #define CLRDTR 6=0A=
 #define CLRRTS 4=0A=
 #define SETDTR 5=0A=

------=_NextPart_000_03BC_01C21923.1066FD90
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 129

2002-06-21  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* include/winbase.h: Add file open flag
	FILE_FLAG_FIRST_PIPE_INSTANCE.

------=_NextPart_000_03BC_01C21923.1066FD90--

