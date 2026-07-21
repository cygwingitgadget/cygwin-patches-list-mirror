Return-Path: <SRS0=V3+P=FP=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 7820B4BA2E05
	for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2026 23:18:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7820B4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7820B4BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784675899; cv=none;
	b=Bkuu4jny++lEinN3hvUoTQCOb0qviICbu1iraLd2kShlnaclw9RHyulJELprsX3+5XG/qNXL9jGMPhshJBfaoLQ60HNnz0oCsmFa6js/uz8OQD0TuVxxf7UzfLimPlG6qzgZVC2sBqIiWHHQeOORkkPf/iLhDNE8JuXzpfg+0Vg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784675899; c=relaxed/simple;
	bh=8vL3KhILp1lRMBHBQPh1jXR7RPnGNH5OdIt8aZhErag=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WRY3x0r7x6YZ7lPhSp1k4kkeWF4EfxH6/OXevxhIZyz334a/FbogT2AMILY1YEoGDJ69UVDxmneC7GB7DI0b32E5FvTHJ6YPNPgPNy28NTOmx2DX0z254BWmZTGsUDtiU3vigTIP6HzZJLaxOy6E1RXkqxTFhfcbmp4dUJKR1cc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dTFAqAQk
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7820B4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dTFAqAQk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784675897; x=1785280697;
	i=johannes.schindelin@gmx.de;
	bh=ixM5k3AVdBHGHA95nTP6cKi29VDButFf8gWtg4XFies=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dTFAqAQkwiVL+MrcCxkKWEWLEuesl/0pk1XV0hDn/rAoPH1tGDXntDRTLcl8IKdp
	 ABLGnr5Up49jINvNibYh7Y0mZBaQ0Hs0QBOVDisiCOT8g76GFGF7zgiuoj1IsuBMi
	 7J0hsTXfatukMzZOB4/n+4XZbfqwQ41Z7GJ+wi2GxG+Thte7WmK0E4T1+/2nu6KW9
	 fscs1TSD2RxqyUYl4mA6B8glYBNCnsBPe5BuAiPSzB8lhTqUpRQZhX8s+Cdr1FDat
	 tiFE55fqPCGR04ud99/izPT4xt+O1rpP+sqAhGPDiQApc6X5vBp7qsA29PsrmrQIw
	 mLbhwOIghp1mN0X+XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1wO1ZZ0fNY-00NE9f; Wed, 22
 Jul 2026 01:18:17 +0200
Date: Wed, 22 Jul 2026 01:18:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: keep interactive console input for native
 programs via Cygwin
In-Reply-To: <20260721044125.b0564ce6a797404b79a0f0a8@nifty.ne.jp>
Message-ID: <44947be6-f15d-8e6b-2b8a-295f54bc6b1e@gmx.de>
References: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com> <20260721044125.b0564ce6a797404b79a0f0a8@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:xtO6qlG/9acZ/VFerWN5zzT+O1cYgaOEtE2SvbArh8Inl/d8RqL
 Olu3QMLdUyHT8wu9Q9XETZjpJBd+BYV6iSmjvR3yI/X+xtQfSpjIVLjOkZ7ACImg4hhXLOz
 f7BVZzm3FnsqPFyCIQXbrKtq3H/DgVs30HgLrt3F2gfnjw2bZz7pAT8EAFAxQaw8L7XtfST
 HHhBUjmNBgziJ7ljDR9Bw==
UI-OutboundReport: notjunk:1;M01:P0:CgQAvyvi9uA=;gp4f4sI3ZQqe8DLQZlIFP/CeR+5
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 21 Jul 2026, Takashi Yano wrote:

> On Mon, 20 Jul 2026 09:43:18 +0000
> "Johannes Schindelin  wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Currently, when a native Windows program starts a Cygwin program while=
 a
> > pseudo console is active, and the Cygwin program then starts another
> > native Windows program, the final program can lose access to console
> > input. It then behaves as though its standard input were redirected
> > instead of remaining interactive.
> >=20
> > For example, a native `git.exe` may invoke shell aliases (i.e. execute=
 a
> > shell command) that would in turn call interactive Git commands who
> > would no longer work because their standard input appeared to be
> > redirected. This can be demonstrated as follows:
> >=20
> >   git -c 'alias.console-probe=3D!powershell.exe -NoLogo -NoProfile -Co=
mmand "
> >     Write-Output ([Console]::IsInputRedirected)
> >     try {
> >       [void][Console]::KeyAvailable
> >       exit 0
> >     } catch {
> >       exit 1
> >     }
> >   "' console-probe
> >=20
> > Running this command with a Win32 version of `git.exe` currently print=
s
> > `True` and exits with exit code 1. In the latest official release, whe=
re
> > this bug is not present, it prints `False` and results in exit code 0.
> >=20
> > The reason is to be fonud in the archetype code. Reminder: For each
> > pseudo terminal (pty), the archetype is the shared pty fhandler that
> > owns the underlying native handles and supplies them to every
> > per-file-descriptor fhandler for that pty.
> >=20
> > `open_with_arch()` calls `open()`, copies the first pty fhandler's sta=
te
> > into the archetype, and then calls `open_setup()`. At that stage, pcon
> > handle adoption already took place in `open_setup()`. This was not
> > anticipated by 60a88896dc (Cygwin: pty: do not leak nat handles when
> > adopting the pcon's in open_setup(), 2026-06-25), which tried to fix a
> > leak by closing the superseded native handles as they were replaced in
> > `open_setup()`.  Because `open_with_arch()` had already copied those
> > handle values into the archetype, closing them invalidated the
> > archetype's copies.
> >=20
> > The archetype therefore retained stale values for those closed handles=
,
> > which later pty fd fhandlers would inherit. If Windows reuses one of
> > those values for a newly duplicated pcon handle, closing the stale val=
ue
> > closes the new handle instead. The nested native program then receives
> > unusable console input.
> >=20
> > Preserve usable console input by moving the unchanged transactional pc=
on
> > handle adoption to `open()`, before the archetype snapshot. The archet=
ype
> > then receives valid pcon handles, all pty fd fhandlers inherit live
> > handles, and the superseded raw pipe handles are closed exactly once.
> >=20
> > This commit is best viewed with `--color-moved`.
> >=20
> > Fixes: 60a88896dce0 ("Cygwin: pty: do not leak nat handles when
> >  adopting the pcon's in open_setup()")
> > Assisted-by: GPT-5.6 Sol
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> How can I reproduce the issue in cygwin?
> I tried:
> $ git -c 'alias.console-probe=3D!powershell.exe -NoLogo -NoProfile -Comm=
and "
>     Write-Output ([Console]::IsInputRedirected)
>     try {
>       [void][Console]::KeyAvailable
>       exit 0
>     } catch {
>       exit 1
>     }
>   "' console-probe
> False
> $ '/cygdrive/c/Program Files/Git/mingw64/bin/git.exe' -c 'alias.console-=
probe=3D!powershell.exe -NoLogo -NoProfile -Command "
>     Write-Output ([Console]::IsInputRedirected)
>     try {
>       [void][Console]::KeyAvailable
>       exit 0
>     } catch {
>       exit 1
>     }
>   "' console-probe
> False
> $ '/cygdrive/c/Program Files/Git/bin/git.exe'  -c 'alias.console-probe=
=3D!powershell.exe -NoLogo -NoProfile -Command "
>     Write-Output ([Console]::IsInputRedirected)
>     try {
>       [void][Console]::KeyAvailable
>       exit 0
>     } catch {
>       exit 1
>     }
>   "' console-probe
> False
> $
>=20
> All look successfull on master branch...

I'm sorry, I should have clarified several things:

- First of all, this reproducer has to be run in MinTTY.

- Second, it does _not_ actually reproduce the bug with the Cygwin runtime
  built from cygwin/master. It only reproduces in Git for Windows' flavor
  of the MSYS2 runtime because of the backports of:

  - 6eed1ef748 (Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned
    children, 2026-04-30)

  - b34394d456 (Cygwin: pty: Fixup pty state after a cygwin app exits,
    2026-06-13)

  - 60a88896dc (Cygwin: pty: do not leak nat handles when adopting the
    pcon's in open_setup(), 2026-06-25)

  The combination of these three commits is the trifecta that surfaces
  that bug, and the same issue _does_ reproduce when cherry-picking those
  backports on top of `cygwin-3_6-branch`. For your convenience, I have
  pushed that branch to
  https://github.com/dscho/msys2-runtime/commits/minimal-backports-for-nat=
-leakfix-bug

- The reproducer not only requires the use of Git for Windows' `git.exe`
  (as an easy way to run a Win32 program that calls a non-Win32 Bash that
  in turn calls a Win32 program again, I should probably have come up with
  a command-line that uses powershell.exe instead of git.exe). In
  addition, `git.exe`'s _strong_ preference for _its own_ `sh.exe` needs
  to be side-stepped by defining `MSYSTEM=3DMINGW64` (which stops that
  PATH-editing logic of `git.exe`):

  MSYSTEM=3DMINGW64 PATH=3D/cygdrive/c/Program\ Files/Git/mingw64/bin:/usr=
/bin:$PATH git -c 'alias.console-probe=3D!powershell.exe -NoLogo -NoProfil=
e -Command "Write-Output ([Console]::IsInputRedirected); try { [void][Cons=
ole]::KeyAvailable; exit 0} catch {exit 1}"' console-probe

However, as I mentioned, this does not reproduce the bug on
`cygwin/master`. The reason is that bbd3710fc8 (Cygwin: console: Set
console mode only if std{in,out,err} is console, 2025-07-03) _hides_ the
part of the bug that the reproducer exercises. But it does not _fix_ the
bug, it's just harder to trigger.

The fix I proposed is still necessary: In `open_with_arch()` the order is:
`open()` -> archetype snapshot (`copy_from`) -> `open_setup()`. For a
pcon-activated pty, `open()` installs the cyg master-side duplicates into
the two nat slots; the archetype then snapshots those slots; then
`open_setup()` (as written by `60a88896dc`) closes those two handles and
installs the pcon duplicates in their place. So the shared, long-lived
archetype is left owning two handle values that were just closed.

The next descriptor opened for the same pty takes `copy_from(archetype)`,
inherits those two closed values, and its own `open_setup()` calls
`CloseHandle` on them again: a close of an already-closed, hence
possibly-reused, handle. Worse, in that same `open_setup()` the fresh pcon
duplications are allocated while those values are free, so one can be
handed back the very value that's about to be closed. That's a "close a
stale value, kill a live handle" failure, and nothing in master's
structure prevents it.

Ciao,
Johannes
