Return-Path: <cygwin-patches-return-2223-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19619 invoked by alias); 26 May 2002 21:50:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19592 invoked from network); 26 May 2002 21:50:15 -0000
Message-ID: <FE045D4D9F7AED4CBFF1B3B813C85337676293@mail.sandvine.com>
From: Don Bowman <don@sandvine.com>
To: "'cygwin-patches@cygwin.com '" <cygwin-patches@cygwin.com>, 
	"'cygwin@cygwin.com'" <cygwin@cygwin.com>
Subject: [PATCH] improve performance of stat() operations (e.g. ls -lR)
Date: Sun, 26 May 2002 14:50:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C204FF.50974E20"
X-SW-Source: 2002-q2/txt/msg00207.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C204FF.50974E20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 378


The attached patch adds a new CYGWIN environment variable, statquery. This
causes stat() to use set_query_open(TRUE) all the time, which
dramatically improves the performance on e.g. ls -lR operations or
configure.
For example, an ls -lR of the 'ntop' distribution goes from 34seconds
to 2seconds on my computer on a local filesystem. The actual change
is extremely trivial.



------_=_NextPart_000_01C204FF.50974E20
Content-Type: application/octet-stream;
	name="statquery.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="statquery.diff"
Content-length: 2167

--- src/winsup/cygwin/environ.cc	2002-05-24 22:22:50.000000000 -0400=0A=
+++ src-new/winsup/cygwin/environ.cc	2002-05-26 16:23:31.000000000 -0400=0A=
@@ -36,6 +36,7 @@ extern BOOL allow_winsymlinks;=0A=
 extern BOOL strip_title_path;=0A=
 extern int pcheck_case;=0A=
 extern int subauth_id;=0A=
+extern BOOL stat_open_noread;=0A=
 BOOL reset_com =3D FALSE;=0A=
 static BOOL envcache =3D TRUE;=0A=
=20=0A=
@@ -525,6 +526,7 @@ static struct parse_thing=0A=
   {"title", {&display_title}, justset, NULL, {{FALSE}, {TRUE}}},=0A=
   {"tty", {NULL}, set_process_state, NULL, {{0}, {PID_USETTY}}},=0A=
   {"winsymlinks", {&allow_winsymlinks}, justset, NULL, {{FALSE}, {TRUE}}},=
=0A=
+  {"statquery", {&stat_open_noread}, justset, NULL, {{FALSE},{TRUE}}},=0A=
   {NULL, {0}, justset, 0, {{0}, {0}}}=0A=
 };=0A=
=20=0A=
--- src/winsup/cygwin/fhandler_disk_file.cc	2002-05-24 01:44:10.000000000 -=
0400=0A=
+++ src-new/winsup/cygwin/fhandler_disk_file.cc	2002-05-26 16:05:46.0000000=
00 -0400=0A=
@@ -31,6 +31,8 @@ details. */=0A=
 #define _COMPILING_NEWLIB=0A=
 #include <dirent.h>=0A=
=20=0A=
+BOOL stat_open_noread;=0A=
+=0A=
 static int=0A=
 num_entries (const char *win32_name)=0A=
 {=0A=
@@ -72,7 +74,7 @@ fhandler_disk_file::fstat (struct __stat=0A=
   if (!pc)=0A=
     return fstat_helper (buf);=0A=
=20=0A=
-  if ((oret =3D open (pc, open_flags, 0)))=0A=
+  if (!stat_open_noread && (oret =3D open (pc, open_flags, 0)))=0A=
     /* ok */;=0A=
   else=0A=
     {=0A=
--- src/winsup/cygwin/ChangeLog	2002-05-24 22:22:50.000000000 -0400=0A=
+++ src-new/winsup/cygwin/ChangeLog	2002-05-26 17:29:11.000000000 -0400=0A=
@@ -1,3 +1,12 @@=0A=
+2002-05-26  Don Bowman  <don@sandvine.com>=0A=
+=0A=
+	* Add new CYGWIN option, 'statquery', which causes the=0A=
+	stat() call to use the set_query_open(TRUE) all the time.=0A=
+	This significantly improves performance on e.g. ls -lR=20=0A=
+	operation. It would appear the CreateFile() on windows=0A=
+	reads a good chunk of the file when called for reading,=0A=
+	which isn't needed by stat().=0A=
+=0A=
 2002-05-24  Christopher Faylor  <cgf@redhat.com>=0A=
=20=0A=
 	Remove unneeded sync.h, where appropriate, throughout.=0A=

------_=_NextPart_000_01C204FF.50974E20--
