Return-Path: <cygwin-patches-return-2731-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3667 invoked by alias); 26 Jul 2002 14:16:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3617 invoked from network); 26 Jul 2002 14:16:25 -0000
Message-ID: <015f01c234ae$fcf60290$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: fhandler::close patch
Date: Fri, 26 Jul 2002 07:16:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_015C_01C234B7.5E603CA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00179.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_015C_01C234B7.5E603CA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 376

I'm starting to sort out my sandbox.  Here's a patch for close(2)
to return the error code from fhandler::close rather than being
hardcoded to zero.  I've also patched fhandler_registry::close as
that was also discarding an error value.  Otherwise, all the other
fhandler::close() routines seem to be returning reasonable values
(on a brief read through).

Enjoy.

// Conrad


------=_NextPart_000_015C_01C234B7.5E603CA0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 222

2002-07-26  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler_registry.cc (fhandler_registry::close): Return any
	error result to the caller.
	* syscalls.cc (_close): Return result of fhandler::close to the
	caller.

------=_NextPart_000_015C_01C234B7.5E603CA0
Content-Type: application/octet-stream;
	name="close.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="close.patch"
Content-length: 1340

Index: fhandler_registry.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_registry.cc,v=0A=
retrieving revision 1.11=0A=
diff -u -r1.11 fhandler_registry.cc=0A=
--- fhandler_registry.cc	13 Jul 2002 20:00:25 -0000	1.11=0A=
+++ fhandler_registry.cc	26 Jul 2002 14:11:09 -0000=0A=
@@ -533,7 +533,7 @@=0A=
     }=0A=
   if (value_name)=0A=
     cfree (value_name);=0A=
-  return 0;=0A=
+  return res;=0A=
 }=0A=
=20=0A=
 bool=0A=
Index: syscalls.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v=0A=
retrieving revision 1.215=0A=
diff -u -r1.215 syscalls.cc=0A=
--- syscalls.cc	13 Jul 2002 20:00:26 -0000	1.215=0A=
+++ syscalls.cc	26 Jul 2002 14:11:09 -0000=0A=
@@ -578,9 +578,8 @@=0A=
     res =3D -1;=0A=
   else=0A=
     {=0A=
-      cfd->close ();=0A=
+      res =3D cfd->close ();=0A=
       cfd.release ();=0A=
-      res =3D 0;=0A=
     }=0A=
=20=0A=
   syscall_printf ("%d =3D close (%d)", res, fd);=0A=

------=_NextPart_000_015C_01C234B7.5E603CA0--

