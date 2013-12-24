Return-Path: <cygwin-patches-return-7924-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21904 invoked by alias); 24 Dec 2013 23:02:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21892 invoked by uid 89); 24 Dec 2013 23:02:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mout.perfora.net
Received: from mout.perfora.net (HELO mout.perfora.net) (74.208.4.195) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Tue, 24 Dec 2013 23:02:15 +0000
Received: from JamesJPC (host-68-169-174-134.VABOLT1.epbfi.com [68.169.174.134])	by mrelay.perfora.net (node=mrus3) with ESMTP (Nemesis)	id 0MMCAv-1VqMrG38Cj-0088JM; Tue, 24 Dec 2013 18:02:12 -0500
From: "James Johnston" <JamesJ@motionview3d.com>
To: <cygwin-patches@cygwin.com>
Subject: Patch to optionally disable overlapped pipes
Date: Tue, 24 Dec 2013 23:02:00 -0000
Message-ID: <037b01cf00fc$11014c10$3303e430$@motionview3d.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;	boundary="----=_NextPart_000_037C_01CF00FC.1101C140"
X-IsSubscribed: yes
X-SW-Source: 2013-q4/txt/msg00020.txt.bz2

This is a multipart message in MIME format.

------=_NextPart_000_037C_01CF00FC.1101C140
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 2297

Hi,

As I have recently mentioned on the main Cygwin mailing list, Cygwin by
default creates FILE_FLAG_OVERLAPPED named pipes for the standard file
handles (stdin/stdout/stderr).  These overlapped pipes require all programs
using ReadFile/WriteFile to use overlapped I/O when using the pipes.  Since
standard runtimes in Win32 programs don't normally use overlapped I/O on the
standard file handles, most Win32 programs will exhibit undefined behavior
when called by Cygwin.  In my case, it has resulted in a problem with
calling .NET Framework 4.0 programs from Cygwin (which, coincidentally,
NETFX 4.0 also probably has a bug resulting in undefined behavior that
definitely clashes with overlapped pipes).

The attached patch creates a new "pipe_nooverlap" flag in the CYGWIN
environment variable (similar to the existing pipe_byte flag).  By default,
the flag would not be set and Cygwin will continue to make overlapped pipes
by default, because I did not know if this will result in any breakages
elsewhere in some Cygwin packages.

If the new "pipe_nooverlap" flag is set, then Cygwin won't make overlapped
pipes by default (i.e. pipes made by the pipe or pipe2 functions).  For me,
this got NETFX 4.0 programs working again.  I've been using it all day today
with no ill effects noted.  It seems safe to use.  But I made it a flag
because I am not 100% certain that some package won't break, and it isn't
needed if you are only running Cygwin programs (which presumably use
Cygwin1.dll which presumably is using overlapped I/O everywhere).

If the maintainers feel that a CYGWIN flag isn't necessary and it is safe to
always remove FILE_FLAG_OVERLAPPED, then I can submit a patch that doesn't
have the "pipe_nooverlap" flag - i.e. just assumes the flag is always set.

Thank you for the consideration of this patch.  Here are the change log
entries:

2013-12-24  James Johnston  <JamesJ@motionview3d.com>

	* environ.cc (struct parse_thing): Add "pipe_nooverlap" option.
	* globals.cc (pipe_nooverlap): Declare.
	* pipe.cc (fhandler_pipe::create): Honor pipe_nooverlap to create
non-
	overlapped pipes if set.


==== Documentation changelog entry ====

2013-12-24  James Johnston  <JamesJ@motionview3d.com>

	* cygwinenv.xml: Add pipe_nooverlap description.

Best regards,

James Johnston


------=_NextPart_000_037C_01CF00FC.1101C140
Content-Type: application/octet-stream;
	name="pipepatch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pipepatch"
Content-length: 3745

Index: cygwin/environ.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v=0A=
retrieving revision 1.209=0A=
diff -u -p -r1.209 environ.cc=0A=
--- cygwin/environ.cc	24 Nov 2013 12:13:33 -0000	1.209=0A=
+++ cygwin/environ.cc	24 Dec 2013 15:54:09 -0000=0A=
@@ -130,6 +130,7 @@ static struct parse_thing=0A=
   {"export", {&export_settings}, setbool, NULL, {{false}, {true}}},=0A=
   {"glob", {func: glob_init}, isfunc, NULL, {{0}, {s: "normal"}}},=0A=
   {"pipe_byte", {&pipe_byte}, setbool, NULL, {{false}, {true}}},=0A=
+  {"pipe_nooverlap", {&pipe_nooverlap}, setbool, NULL, {{false}, {true}}},=
=0A=
   {"proc_retry", {func: set_proc_retry}, isfunc, NULL, {{0}, {5}}},=0A=
   {"reset_com", {&reset_com}, setbool, NULL, {{false}, {true}}},=0A=
   {"wincmdln", {&wincmdln}, setbool, NULL, {{false}, {true}}},=0A=
Index: cygwin/globals.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/globals.cc,v=0A=
retrieving revision 1.55=0A=
diff -u -p -r1.55 globals.cc=0A=
--- cygwin/globals.cc	9 Dec 2013 20:32:24 -0000	1.55=0A=
+++ cygwin/globals.cc	24 Dec 2013 15:54:09 -0000=0A=
@@ -72,6 +72,7 @@ bool detect_bloda;=0A=
 bool dos_file_warning =3D true;=0A=
 bool ignore_case_with_glob;=0A=
 bool pipe_byte;=0A=
+bool pipe_nooverlap;=0A=
 bool reset_com;=0A=
 bool wincmdln;=0A=
 winsym_t allow_winsymlinks =3D WSYM_sysfile;=0A=
Index: cygwin/pipe.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v=0A=
retrieving revision 1.148=0A=
diff -u -p -r1.148 pipe.cc=0A=
--- cygwin/pipe.cc	1 May 2013 01:20:37 -0000	1.148=0A=
+++ cygwin/pipe.cc	24 Dec 2013 15:54:09 -0000=0A=
@@ -342,7 +342,8 @@ fhandler_pipe::create (fhandler_pipe *fh=0A=
   SECURITY_ATTRIBUTES *sa =3D sec_none_cloexec (mode);=0A=
   int res =3D -1;=0A=
=20=0A=
-  int ret =3D create (sa, &r, &w, psize, NULL, FILE_FLAG_OVERLAPPED);=0A=
+  int ret =3D create (sa, &r, &w, psize, NULL,=0A=
+		   pipe_nooverlap ? 0 : FILE_FLAG_OVERLAPPED);=0A=
   if (ret)=0A=
     __seterrno_from_win_error (ret);=0A=
   else if ((fhs[0] =3D (fhandler_pipe *) build_fh_dev (*piper_dev)) =3D=3D=
 NULL)=0A=
Index: doc/cygwinenv.xml=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/doc/cygwinenv.xml,v=0A=
retrieving revision 1.4=0A=
diff -u -p -r1.4 cygwinenv.xml=0A=
--- doc/cygwinenv.xml	26 Jul 2013 17:27:59 -0000	1.4=0A=
+++ doc/cygwinenv.xml	24 Dec 2013 15:54:09 -0000=0A=
@@ -68,6 +68,11 @@ message mode.</para>=0A=
 </listitem>=0A=
=20=0A=
 <listitem>=0A=
+<para><envar>(no)pipe_nooverlap</envar> - causes Cygwin to open pipes in n=
on-overlapped mode by default, rather=0A=
+than overlapped mode.  Useful for when running a Win32 program that doesn'=
t expect an overlapped pipe.</para>=0A=
+</listitem>=0A=
+=0A=
+<listitem>=0A=
 <para><envar>proc_retry:n</envar> - causes <function>fork()</function> and=
=0A=
 <function>exec*()</function> to retry n times when a child process fails=
=0A=
 due to certain windows-specific errors.  These errors usually occur when=
=0A=

------=_NextPart_000_037C_01CF00FC.1101C140--
