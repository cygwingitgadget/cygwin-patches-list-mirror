Return-Path: <cygwin-patches-return-2547-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4946 invoked by alias); 30 Jun 2002 12:57:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4932 invoked from network); 30 Jun 2002 12:57:26 -0000
X-WM-Posted-At: avacado.atomice.net; Sun, 30 Jun 02 14:00:57 +0100
Message-ID: <00c501c22036$2cfd0f20$0100a8c0@advent02>
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: Fw: dup tty error.
Date: Sun, 30 Jun 2002 06:10:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C2_01C2203E.8E93B060"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00530.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00C2_01C2203E.8E93B060
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-length: 886

originally posted to the wrong list

> Normally i would expect to see this error, say, 1 in 2 times I click the
> Cygwin icon. But yesterday I clicked it about 30 times and I keep getting
> the same error.
> Error follows:
>       3 [main] bash 776 fhandler_base::dup: dup(/dev/tty) failed, handle
B,
> Win32 error 87
> readline: warning: rl_prep_terminal: cannot get terminal settingsâ]0;~
> â[32mchris@ADVENT02 â[33m~â[0m
> See this thread for more details:
> http://sources.redhat.com/ml/cygwin/2002-05/msg01415.html
>
> Attached is a patch which fixes the bug, by giving the console window
title
> more time (up to 1 second) to change. FindWindow is called in a loop, so
for
> the normal execution path there is no extra overhead.
>
> Chris
>
> ---
> 2002-06-30  Christopher January <chris@atomice.net>
>
>  * tty.cc (tty_list::allocate_tty): retry FindWindow if it fails.


------=_NextPart_000_00C2_01C2203E.8E93B060
Content-Type: text/plain;
	name="Changelog.tty.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Changelog.tty.txt"
Content-length: 119

2002-06-30  Christopher January <chris@atomice.net>

	* tty.cc (tty_list::allocate_tty): retry FindWindow if it fails.

------=_NextPart_000_00C2_01C2203E.8E93B060
Content-Type: application/octet-stream;
	name="tty.cc.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="tty.cc.patch"
Content-length: 963

Index: tty.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v=0A=
retrieving revision 1.35=0A=
diff -u -3 -p -u -p -r1.35 tty.cc=0A=
--- tty.cc	5 Jun 2002 04:01:43 -0000	1.35=0A=
+++ tty.cc	30 Jun 2002 12:42:04 -0000=0A=
@@ -216,8 +216,11 @@ tty_list::allocate_tty (int with_console=0A=
=20=0A=
       __small_sprintf (buf, "cygwin.find.console.%d", myself->pid);=0A=
       SetConsoleTitle (buf);=0A=
-      Sleep (40);=0A=
-      console =3D FindWindow (NULL, buf);=0A=
+      for (int times =3D 0; times < 25 && console =3D=3D NULL; times++)=0A=
+	    {=0A=
+		  Sleep (40);=0A=
+          console =3D FindWindow (NULL, buf);=0A=
+	    }=0A=
       SetConsoleTitle (oldtitle);=0A=
       Sleep (40);=0A=
       ReleaseMutex (title_mutex);=0A=
=0A=

------=_NextPart_000_00C2_01C2203E.8E93B060--
