Return-Path: <cygwin-patches-return-2645-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14087 invoked by alias); 14 Jul 2002 12:05:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14073 invoked from network); 14 Jul 2002 12:05:23 -0000
Message-ID: <002a01c22b2f$07f9bda0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Protect handle issue-ettes
Date: Sun, 14 Jul 2002 05:05:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0027_01C22B37.689D4C50"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00093.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0027_01C22B37.689D4C50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 3912

Chris,

I've attached one patch to the protect handle mechanism: a
forgotten "hl = hl->next" after find_handle() in setclexec().
This cured a seg. fault I was getting in the cygwin_daemon branch
when running make.

I'm still not clear why the cygserver code disturbs this mechanism
so much: I wasn't getting the seg. fault on the HEAD version.
I've now added calls to ProtectHandle into the cygserver code, so
this doesn't seem to be anything to do with their (previous)
omission.

Other than that, I'm still getting quite a bit of noise, all of
which (that I've bothered to trace through) is due to handles that
are non-inheritable (i.e. held in a NO_COPY variable and created
with, e.g., sec_none_nih).  AFAICT, these need to be removed from
the protected handle list on fork, not just on fork-exec.  I've
attached a sample of the "noise" to the end of this message.

Such handles include:

exceptions.cc:
    title_mutex

sigproc.cc:
    sigcatch_nonmain
    sigcatch_main
    sigcomplete_nonmain
    sigcomplete_main

I don't see any mechanism to do this in the code at present and
I've not the time to go into this any further just now, but I hope
that helps.

Cheers,

// Conrad

A batch of message from running "make install" in the cygwin
directory while cygserver is running:

  21549 [main] sh 1756 mark_closed: attempt to close protected
handle void memory_init():157(cygwin_mount_h<0x118>) winpid 1756
  29497 [main] sh 1756 mark_closed:  by int
fhandler_base::close():770(get_handle()<0x118>)
   3871 [sig] sed 348 add_handle: DWORD wait_sig(void *):1106 -
multiple attempts to add handle sigcatch_nosync<0x118>
   6304 [sig] sed 348 add_handle:  previously allocated by void
memory_init():157(cygwin_mount_h<0x118>) winpid 1756
  23716 [main] sh 1756 mark_closed: attempt to close protected
handle void memory_init():157(cygwin_mount_h<0x118>) winpid 1756
  29777 [main] sh 1756 mark_closed:  by int
fhandler_base::close():770(get_handle()<0x118>)
  75287 [main] sh 1460 add_handle: int spawn_guts(const char *,
const char *const *, const char *const *, int):720 - multiple
attempts to add handle childhProc<0x118>
  79522 [main] sh 1460 add_handle:  previously allocated by void
memory_init():157(cygwin_mount_h<0x118>) winpid 1756
  23001 [main] sh 1456 mark_closed: attempt to close protected
handle void memory_init():157(cygwin_mount_h<0x118>) winpid 1456
  32911 [main] sh 1456 mark_closed:  by int
fhandler_base::close():770(get_handle()<0x118>)
   4241 [sig] sed 348 add_handle: DWORD wait_sig(void *):1107 -
multiple attempts to add handle sigcatch_nonmain<0x118>
   7192 [sig] sed 348 add_handle:  previously allocated by void
memory_init():157(cygwin_mount_h<0x118>) winpid 1456
  20367 [main] sh 1728 mark_closed: attempt to close protected
handle void memory_init():157(cygwin_mount_h<0x118>) winpid 1728
  23246 [main] sh 1728 mark_closed:  by int
fhandler_base::close():770(get_handle()<0x118>)
  57709 [main] sh 1720 mark_closed: attempt to close protected
handle void memory_init():157(cygwin_mount_h<0x118>) winpid 1728
  62777 [main] sh 1720 mark_closed:  by int NTReadEA(const char *,
const char *, char *, int):129(hFileSource<0x118>)
   6540 [sig] sed 1720 add_handle: DWORD wait_sig(void *):1108 -
multiple attempts to add handle sigcatch_main<0x118>
  11660 [sig] sed 1720 add_handle:  previously allocated by void
memory_init():157(cygwin_mount_h<0x118>) winpid 1728
  20554 [main] sh 1464 mark_closed: attempt to close protected
handle void memory_init():157(cygwin_mount_h<0x118>) winpid 1464
  22505 [main] sh 1464 mark_closed:  by int
fhandler_base::close():770(get_handle()<0x118>)
  62649 [main] sh 1756 add_handle: int spawn_guts(const char *,
const char *const *, const char *const *, int):720 - multiple
attempts to add handle childhProc<0x118>
  72487 [main] sh 1756 add_handle:  previously allocated by void
memory_init():157(cygwin_mount_h<0x118>) winpid 1464


------=_NextPart_000_0027_01C22B37.689D4C50
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 108

2002-07-14  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* debug.cc (clexec): Add missing `hl = hl->next'.


------=_NextPart_000_0027_01C22B37.689D4C50
Content-Type: application/octet-stream;
	name="debug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="debug.patch"
Content-length: 636

Index: debug.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/debug.cc,v=0A=
retrieving revision 1.24.2.6=0A=
diff -u -r1.24.2.6 debug.cc=0A=
--- debug.cc	13 Jul 2002 20:39:24 -0000	1.24.2.6=0A=
+++ debug.cc	14 Jul 2002 11:20:53 -0000=0A=
@@ -229,6 +229,7 @@=0A=
   handle_list *hl =3D find_handle (oh);=0A=
   if (hl)=0A=
     {=0A=
+      hl =3D hl->next;=0A=
       hl->clexec =3D setit;=0A=
       hl->h =3D nh;=0A=
     }=0A=

------=_NextPart_000_0027_01C22B37.689D4C50--

