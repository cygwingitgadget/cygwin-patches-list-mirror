Return-Path: <cygwin-patches-return-5243-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2536 invoked by alias); 18 Dec 2004 14:10:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2470 invoked from network); 18 Dec 2004 14:10:42 -0000
Received: from unknown (HELO ptb-relay01.plus.net) (212.159.14.212)
  by sourceware.org with SMTP; 18 Dec 2004 14:10:42 -0000
Received: from [81.174.168.250] (helo=avocado)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1CffI8-000OC4-9d
	for cygwin-patches@cygwin.com; Sat, 18 Dec 2004 14:10:40 +0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Add self to /proc (to support procps 3.2.4)
Date: Sat, 18 Dec 2004 14:10:00 -0000
Message-ID: <081101c4e50b$5c822310$0207a8c0@avocado>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0812_01C4E50B.5C822310"
X-SW-Source: 2004-q4/txt/msg00244.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0812_01C4E50B.5C822310
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 255

2004-12-18  Chris January  <chris@atomice.net>

	* fhandler_proc.cc (proc_listing): Add entry for "self".
	(proc_fhandlers): Add entry for "self".
	* fhandler_process.cc (fhandler_process::fstate): Handle "self".
	(fhandler_process::open): Handle "self".

------=_NextPart_000_0812_01C4E50B.5C822310
Content-Type: application/octet-stream;
	name="proc_self.ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc_self.ChangeLog"
Content-length: 256

2004-12-18  Chris January  <chris@atomice.net>

	* fhandler_proc.cc (proc_listing): Add entry for "self".
	(proc_fhandlers): Add entry for "self".
	* fhandler_process.cc (fhandler_process::fstate): Handle "self".
	(fhandler_process::open): Handle "self".


------=_NextPart_000_0812_01C4E50B.5C822310
Content-Type: application/octet-stream;
	name="proc_self.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="proc_self.patch"
Content-length: 1866

Index: fhandler_proc.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v=0A=
retrieving revision 1.47=0A=
diff -u -r1.47 fhandler_proc.cc=0A=
--- fhandler_proc.cc	12 Sep 2004 03:47:56 -0000	1.47=0A=
+++ fhandler_proc.cc	18 Dec 2004 14:08:25 -0000=0A=
@@ -54,6 +54,7 @@=0A=
   "uptime",=0A=
   "cpuinfo",=0A=
   "partitions",=0A=
+  "self",=0A=
   NULL=0A=
 };=0A=
=20=0A=
@@ -73,6 +74,7 @@=0A=
   FH_PROC,=0A=
   FH_PROC,=0A=
   FH_PROC,=0A=
+  FH_PROCESS,=0A=
 };=0A=
=20=0A=
 /* name of the /proc filesystem */=0A=
Index: fhandler_process.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/fhandler_process.cc,v=0A=
retrieving revision 1.44=0A=
diff -u -r1.44 fhandler_process.cc=0A=
--- fhandler_process.cc	3 Sep 2004 01:53:11 -0000	1.44=0A=
+++ fhandler_process.cc	18 Dec 2004 14:08:26 -0000=0A=
@@ -107,7 +107,10 @@=0A=
   int file_type =3D exists ();=0A=
   (void) fhandler_base::fstat (buf);=0A=
   path +=3D proc_len + 1;=0A=
-  pid =3D atoi (path);=0A=
+  if (path_prefix_p ("self", path, 4))=0A=
+    pid =3D getpid ();=0A=
+  else=0A=
+    pid =3D atoi (path);=0A=
   pinfo p (pid);=0A=
   if (!p)=0A=
     {=0A=
@@ -167,7 +170,10 @@=0A=
=20=0A=
   const char *path;=0A=
   path =3D get_name () + proc_len + 1;=0A=
-  pid =3D atoi (path);=0A=
+  if (path_prefix_p ("self", path, 4))=0A=
+    pid =3D getpid ();=0A=
+  else=0A=
+    pid =3D atoi (path);=0A=
   while (*path !=3D 0 && !isdirsep (*path))=0A=
     path++;=0A=
=20=0A=

------=_NextPart_000_0812_01C4E50B.5C822310--
