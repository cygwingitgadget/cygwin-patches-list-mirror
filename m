Return-Path: <SRS0=aQVm=BR=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id C401B4B9DB40
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 13:57:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C401B4B9DB40
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C401B4B9DB40
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773755834; cv=none;
	b=NdldP4wY5NZyNV0sC+FVO2lNWY6+GGwSDnVnP8KKwg+he5qKIGAN3nNzXzoa695BsbZHlfdFyciCvYLFwht8gIYOhw3XgUe/FNsY+WjbuqI5UEqRy2UeUJnjHAcmUnBuc6h8VmcYR2SPmMGbP9QZFIF/6ntq5OhdLzWQIneAPL8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773755834; c=relaxed/simple;
	bh=+ia8/3rK7iBWlG6ITPEFPXBlkdy7vNZRHVy1WhtM75Q=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=etxPEh2qrjKcfEYBnlaNhXB+NmAhe860EWtcXYwdxNUiRzJRhEWr1tjj0pg53M3qr8mphktUKcA9XsDLvWKrL91aVfdeJ3q3dc5RooXiqsGWTJdZh4ATBQt6uHQe6YyBaNNzJqtLg4G0DWz0u5gN/FgElKwVmSKBbOWhFNeX8rQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C401B4B9DB40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=k5vqGcVI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773755827; x=1774360627;
	i=johannes.schindelin@gmx.de;
	bh=6kb/+pNPtxS9my3Oj2IUc553Q3iKwvj+nYoRZPBOJ8g=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k5vqGcVI8T+WV8GGlJ7pm+2UkPZUWaQwD2DBBDTaKp5+/svyV1krxBe16fn3NxSo
	 cKzJzcpa9mwn8+3lIwh4IjX+nVJvEQial+ehqKzu55cprrw/2k5ElvKsRWOGmpdK6
	 jASBDQeOMy5VUx1jY0IcF9yhrwu46ZuE5zwWOLO5pupigFxpntG2l7O4yO4WuC+P5
	 dvpVJ0ci1ZdHB7/PI5FaOFuo6bh5gfuw7Ob/YEcWJcxtEN6mrRuX51AjKQpdbM4y0
	 MURyazvlvE/PS2NK7Wh9iwCy62t2hvPiJNVL90Pp5XQk0VIlsElugmTRPjP65dVcg
	 ap8wL6DswBfMZBMr9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1vISmh0vBQ-00fsRS; Tue, 17
 Mar 2026 14:57:07 +0100
Date: Tue, 17 Mar 2026 14:57:05 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
In-Reply-To: <20260317212208.cb8ac446f8da721cd82d3e51@nifty.ne.jp>
Message-ID: <d6fd357c-c1eb-487c-df77-81614354d5ed@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com> <20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp> <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de> <20260310175652.a7c404ae59c02560956cfb59@nifty.ne.jp>
 <20260317212208.cb8ac446f8da721cd82d3e51@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lpG8RUegBAoQz1hD7qNcrmowU2w4m16C/ibyBlacpF42o1TL3xa
 TCp1HJCnjIzze4ypvw3+IqlnEoCRr/weE1Z7AQHeKMJ2v/WGMIIg+emXW1l4F2zaXvsrk7h
 675J8Rk4FbwnKGJeMgs3KlL/rQivoWgD8S1I7bMcc0WOdi5E4/E6H/aKOZ34yqyjjkiwJPr
 U3KI+7EDSLyJOjFB+EkRQ==
UI-OutboundReport: notjunk:1;M01:P0:muuZmc54Cho=;KbWA/dfw87ZhDit6pIKT1aFOGKZ
 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
 gmrvGmuDAH4
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 17 Mar 2026, Takashi Yano wrote:

> On Tue, 10 Mar 2026 17:56:52 +0900
> Takashi Yano wrote:
> >=20
> > On Fri, 6 Mar 2026 08:46:40 +0100 (CET)
> > Johannes Schindelin wrote:
> > >=20
> > > Hi Takashi,
> > >=20
> > > On Tue, 3 Mar 2026, Takashi Yano wrote:
> > >=20
> > > > On Mon, 02 Mar 2026 14:24:36 +0000
> > > > "Johannes Schindelin wrote:
> > > > > A Git for Windows user reported that typing in a Bash session wh=
ile a native
> > > > > Windows program is running (or has just exited) can produce scra=
mbled input
> > > > > -- e.g. typing "git log" yields "igt olg":
> > > > > https://github.com/git-for-windows/git/issues/5632
> > > > >=20
> > > > > [...]
> > > >=20
> > > > Is the issue reproducible in pcon_activated case?
> > > > Or disable_pcon case?
> > > >=20
> > > > If you can reproduce the issue in cygwin, could you kindly please
> > > > let me know how to reproduce it?
> > >=20
> > > It is admittedly difficult to reproduce. It took me a good 4 days to=
 get
> > > to a reliable reproducer. And I failed to do this in manual mode, I =
had to
> > > employ the help of AutoHotKey to do it. The result can be seen here:
> > > https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-or=
der/ui-tests/keystroke-order.ahk
> > >=20
> > > Unfortunately, it is not quite stand-alone, it requires `powershell.=
exe`
> > > in the `PATH`, and
> > > https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-or=
der/ui-tests/ui-test-library.ahk
> > > and
> > > https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-or=
der/ui-tests/cpu-stress.ps1
> > > in the same directory. I just verified that it reproduces even with =
vanilla
> > > Cygwin, using the latest AutoHotKey version from
> > > https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.21. I ens=
ured
> > > that Cygwin's `bin` directory is first in the `PATH` and then ran, f=
rom a
> > > PowerShell session:
> > >=20
> > >   & "<path-to>\AutoHotkey64.exe" /force keystroke-order.ahk "$PWD\lo=
g.txt"
> > >=20
> > > What this test does: It runs a small PowerShell script designed to a=
dd a
> > > bit of CPU load and then spawns a Cygwin process (`sleep 1`). While =
these
> > > are running, it then types _very_ rapidly four characters, then two
> > > backspaces, then repeats that quite a few times ("ABXY" then deletin=
g
> > > "XY", then "CDXY", deleting "XY", etc). The number of characters was
> > > chosen high enough that this reproducer basically reproduces the iss=
ue on
> > > the first try. The "log.txt" file contains a detailed log including =
the
> > > verdict. In my latest test, for example, it shows:
> > >=20
> > >   Iteration 1 of 20
> > >   MISMATCH in iteration 1!
> > >   Expected: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123=
456789
> > >   Got:      ABCDEFGHIJKLMNOPQRXSTUVWXYZabcdefghijklmnopqrstuvwxyz012=
3456789
> > >=20
> > > You will spot the "X" between "R" and "S", meaning that the backspac=
e was
> > > not able to remove the "X" because it was routed to the wrong pipe, =
or
> > > after the "X" was already consumed.
> >=20
> > Thanks for the reproducer. I finally could reproduce the issue!
> > Please let me take a look.
>=20
> I finally have a patch series that fixes all the issue triggered by
> this reproducer.

Seeing as you did not reuse any part of my patches, not even the carefully
crafted commit messages, I wonder why you find them so horrible that you
don't even review them, let alone consider using them.

> I'll submit the patch series to cygwin-patches mailing list.
> Could you please test?

Yes, I tested. There is already a problem in the `cmd.exe` test I
introduced in response to your feedback. What it does is to launch
`cmd.exe`, wait a few milliseconds, and then start typing `echo
<long-string>`.

As you can see from the output here, that does not work. The first two
characters never make it to `cmd.exe`, and besides, `cmd.exe` is then
stuck:

=2D- snip --
$ cmd.exe
eMicrosoft Windows [Version 10.0.26200.7984]c
(c) Microsoft Corporation. All rights reserved.

D:\git-sdk-64\usr\src\MSYS2-packages\msys2-runtime\src\wip\ui-tests\msys2>=
ho ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
=2D- snap --

In my investigations (supported by Claude Opus, because I still have a
hard time with the current shape of the code and its lack of documenting
ideas clearly), I stumbled across something that I _think_ is the actual
cause of the many problems: When a native program is started, there is
this time window during which the console owner is the current process (in
my case, Bash), _not_ the native process (because it does not exist yet or
the parent process does not yet know its process ID). When any kind of
transfer happens during that time (and it does!), we're heading straight
into trouble. I get the impression that we need to address this, to close
that time window, not by narrowing it further, but by eliminating it
entirely: while a native process is starting up that will become the
console's owner, no transfer should happen.

Now, I really would like to collaborate with you on that. But I have to
admit that I'm struggling a bit when you don't even comment on the
contents of the commit message or patch to help me improve them, or when
you just ignore those patches and instead write completely different ones.

Can we work on this together, please?

Ciao,
Johannes

For your viewing pleasure, the change for the AutoHotKey test:

=2D- snipsnap --
=46rom f24131d4971f4652c15f1ab53ac0180275bd3e0f Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 6 Mar 2026 13:20:49 +0100
Subject: [PATCH] squash! ui-tests: add a reproducer for the keystroke
 reordering bug

An early iteration of the "Fix out-of-order keystrokes" patch series had
a bug where it would prevent native processes from receiving _any_
keystrokes under certain circumstances. Let's also specifically verify
that this is _not_ the case, and prevent regressing on it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 ui-tests/keystroke-order.ahk | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/ui-tests/keystroke-order.ahk b/ui-tests/keystroke-order.ahk
index e6161a782c..81ee651b11 100644
=2D-- a/ui-tests/keystroke-order.ahk
+++ b/ui-tests/keystroke-order.ahk
@@ -39,6 +39,75 @@ if !InStr(capture, '$ ')
     ExitWithError 'Timed out waiting for bash prompt'
 Info 'Bash prompt appeared'
=20
+; =3D=3D=3D cmd.exe input verification =3D=3D=3D
+; Verify that input typed into cmd.exe (a native Win32 console app) is no=
t
+; silently lost. This catches the regression where removing the pcon_star=
t
+; post-loop block also removed the pty_input_state =3D to_nat transition,
+; causing keystrokes to go to the wrong pipe.
+Info '=3D=3D=3D cmd.exe input verification =3D=3D=3D'
+WinActivate(winId)
+SetKeyDelay 20, 20
+SendEvent('{Text}cmd.exe')
+SendEvent('{Enter}')
+; Type immediately without waiting for cmd.exe to fully start.
+Sleep 200
+SendEvent('{Text}echo ' testString)
+SendEvent('{Enter}')
+
+; Wait for the test string to appear in cmd.exe output.
+deadline :=3D A_TickCount + 10000
+cmdOk :=3D false
+while A_TickCount < deadline
+{
+    text :=3D CaptureBufferFromMintty(winId)
+    ; Look for the echoed string (cmd.exe prints the command AND its outp=
ut)
+    ; Count occurrences: the echo command line itself plus the output =3D=
 at least 2
+    count :=3D 0
+    searchPos :=3D 1
+    while searchPos :=3D InStr(text, testString, , searchPos)
+    {
+        count++
+        searchPos +=3D StrLen(testString)
+    }
+    if count >=3D 2
+    {
+        Info 'cmd.exe echoed the test string correctly'
+        cmdOk :=3D true
+        break
+    }
+    Sleep 500
+}
+if !cmdOk
+{
+    Info 'Captured text:'
+    Info text
+    ExitWithError 'cmd.exe did not echo the test string (input lost?)'
+}
+
+; Exit cmd.exe and verify we return to bash.
+WinActivate(winId)
+SetKeyDelay 20, 20
+SendEvent('{Text}exit')
+SendEvent('{Enter}')
+Sleep 1000
+
+text :=3D CaptureBufferFromMintty(winId)
+; After exiting cmd.exe we should see a bash prompt again.
+; Find the last "$ " -- it should come after the cmd.exe session.
+lastPrompt :=3D 0
+pos :=3D 1
+while pos :=3D InStr(text, '$ ', , pos)
+{
+    lastPrompt :=3D pos
+    pos +=3D 2
+}
+after :=3D (lastPrompt > 0) ? Trim(SubStr(text, lastPrompt + 2)) : ''
+if after !=3D ''
+{
+    Info 'WARNING: unexpected text after prompt: ' after
+}
+Info 'Back at bash prompt after cmd.exe'
+
 stressCmd :=3D 'powershell.exe -File ' StrReplace(A_ScriptDir, '\', '/') =
'/cpu-stress.ps1'
 Info 'Foreground command: ' stressCmd
=20
=2D-=20

