Return-Path: <cygwin-patches-return-2486-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6945 invoked by alias); 22 Jun 2002 14:22:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6928 invoked from network); 22 Jun 2002 14:22:09 -0000
Message-ID: <040201c219f8$6f3233a0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: S_IFSOCK setting
Date: Sat, 22 Jun 2002 07:22:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_03FF_01C21A00.D0B043D0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00469.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_03FF_01C21A00.D0B043D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1459

I noticed, while grotting around in various /dev/ stuff, that fstat(2)
on sockets and pipes gives a file type of S_IFCHR, which doesn't seem
quite right. Sockets should get S_IFSOCK and pipes should get, well,
something. A quick investigation by reading sources (i.e. no warranty)
for various Un*ces reveals the following device type settings for
anonymous pipes (i.e. the result of calling pipe(2)):

*) Both Linux and FreeBSD set S_IFIFO.
*) V7 set IFREG.
*) In sys V.4, pipes are streams AFAIK but I'm not sure what mode to
expect for those: S_IFSOCK?
*) 4.* BSD set S_IFSOCK (since pipes are implemented as sockets).

The current Open Group specification doesn't seem to specify what file
types should be returned for which objects . . . !? [BTW I'm using
issue 6, which is available at
http://www.opengroup.org/onlinepubs/007904975/ --- I don't know of any
better source for Posix spec's on the web --- are there any?]

So, in the patch I've gone for Linux compatibility, i.e. all pipes get
S_IFIFO despite that file type being defined as being just for named
pipes. Sigh. I'm also unclear whether fhandlers ever get created with
a device type of FH_PIPE (except for explicit opens of /dev/pipe).
Just to be sure, I gave this the same i_mode as previously but with
S_IFIFO.

This patch also makes the output of `ls -l /dev/tcp' a bit strange,
but I think this is a relatively unimportant detail, what with a
pending /dev vfs.

Anyhow, enjoy?

// Conrad


------=_NextPart_000_03FF_01C21A00.D0B043D0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 183

2002-06-22  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.cc (fhandler_base::fstat): Set S_IFIFO for pipes.
	* fhandler_socket.cc (fhandler_socket.cc::fstat): Set S_IFSOCK.

------=_NextPart_000_03FF_01C21A00.D0B043D0
Content-Type: application/octet-stream;
	name="i_mode.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="i_mode.patch"
Content-length: 2281

Index: fhandler.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v=0A=
retrieving revision 1.129=0A=
diff -u -r1.129 fhandler.cc=0A=
--- fhandler.cc	20 Jun 2002 00:36:40 -0000	1.129=0A=
+++ fhandler.cc	22 Jun 2002 14:14:58 -0000=0A=
@@ -829,18 +829,23 @@=0A=
 {=0A=
   switch (get_device ())=0A=
     {=0A=
+    case FH_PIPE:=0A=
+      buf->st_mode =3D S_IFIFO | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH=
;=0A=
+      break;=0A=
     case FH_PIPEW:=0A=
-      buf->st_mode =3D STD_WBITS | S_IWGRP | S_IWOTH;=0A=
+      buf->st_mode =3D S_IFIFO | STD_WBITS | S_IWGRP | S_IWOTH;=0A=
       break;=0A=
     case FH_PIPER:=0A=
-      buf->st_mode =3D STD_RBITS;=0A=
+      buf->st_mode =3D S_IFIFO | STD_RBITS;=0A=
+      break;=0A=
+    case FH_FLOPPY:=0A=
+      buf->st_mode =3D S_IFBLK | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH=
;=0A=
       break;=0A=
     default:=0A=
-      buf->st_mode =3D STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH;=0A=
+      buf->st_mode =3D S_IFCHR | STD_RBITS | STD_WBITS | S_IWGRP | S_IWOTH=
;=0A=
       break;=0A=
     }=0A=
=20=0A=
-  buf->st_mode |=3D get_device () =3D=3D FH_FLOPPY ? S_IFBLK : S_IFCHR;=0A=
   buf->st_nlink =3D 1;=0A=
   buf->st_blksize =3D S_BLKSIZE;=0A=
   time_as_timestruc_t (&buf->st_ctim);=0A=
Index: fhandler_socket.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_socket.cc,v=0A=
retrieving revision 1.47=0A=
diff -u -r1.47 fhandler_socket.cc=0A=
--- fhandler_socket.cc	10 Jun 2002 11:07:44 -0000	1.47=0A=
+++ fhandler_socket.cc	22 Jun 2002 14:14:58 -0000=0A=
@@ -248,7 +248,11 @@=0A=
 {=0A=
   int res =3D fhandler_base::fstat (buf, pc);=0A=
   if (!res)=0A=
-    buf->st_ino =3D (ino_t) get_handle ();=0A=
+    {=0A=
+      buf->st_mode &=3D ~_IFMT;=0A=
+      buf->st_mode |=3D _IFSOCK;=0A=
+      buf->st_ino =3D (ino_t) get_handle ();=0A=
+    }=0A=
   return res;=0A=
 }=0A=
=20=0A=

------=_NextPart_000_03FF_01C21A00.D0B043D0--

