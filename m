Return-Path: <cygwin-patches-return-2765-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19463 invoked by alias); 3 Aug 2002 22:48:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19449 invoked from network); 3 Aug 2002 22:48:04 -0000
Message-ID: <031301c23b40$15cb35a0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: WFSO & WFSO
Date: Sat, 03 Aug 2002 15:48:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0310_01C23B48.774945D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00213.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0310_01C23B48.774945D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 355

In "sigproc.cc", there are two functions WFSO and WFMO that wrap
the two WaitFor... functions with a sigframe.

In "debug.h" there are the following two defines:

#define WaitForSingleObject WFSO
#define WaitForMultipleObject WFMO

Assuming that the second of these is a typo for
"WaitForMultipleObjects" (note plural), I've attached a patch.

// Conrad


------=_NextPart_000_0310_01C23B48.774945D0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 108

2002-08-03  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* debug.h (WaitForMultipleObjects): Correct typo.


------=_NextPart_000_0310_01C23B48.774945D0
Content-Type: text/plain;
	name="WFMO.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="WFMO.patch.txt"
Content-length: 577

Index: debug.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/debug.h,v
retrieving revision 1.19
diff -u -r1.19 debug.h
--- debug.h	1 Aug 2002 16:20:31 -0000	1.19
+++ debug.h	3 Aug 2002 22:41:53 -0000
@@ -23,7 +23,7 @@
 }
=20
 #define WaitForSingleObject WFSO
-#define WaitForMultipleObject WFMO
+#define WaitForMultipleObjects WFMO
=20
 #if !defined(_DEBUG_H_)
 #define _DEBUG_H_

------=_NextPart_000_0310_01C23B48.774945D0--

