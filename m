Return-Path: <SRS0=Gg12=GA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id D41FC4BA9016
	for <cygwin-patches@cygwin.com>; Fri,  7 Aug 2026 05:44:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D41FC4BA9016
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D41FC4BA9016
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786081485; cv=none;
	b=HtPRCxxIs66BliTVHLszqhdO8RbQPQmrP5q/X/HO1O+Uf2FkOfTWtpUxvzWQiFNEipVdZGROcMP18xrrQf4u2FiFRNmj+1R4EqZGinuPM1wPUQpprzrKQK+h8unUHw5Tiwk2TvPARvVP21LpSEi0cZbOG1qAbZgIzK/Ktn0APGY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786081485; c=relaxed/simple;
	bh=0FNIzI/VrUd29nd315/jP+awXHM5j34s4xUki2QOa+c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=epcNpgfzfJC7mC4lbqh9/aeqIFla7a19Zvla5e5c2diim8c0SDMM3lh74B/WGq20jjKKxlO0yZpUZJlJyFmLgg03awTevoAkLmsOnr+2O7HoAubTC11cToVNAtsZLxHmLHd00QYBcfdaDBykwnf4Jjq7BgYmSIoHbMqu92jqJPg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UBD/gooN
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D41FC4BA9016
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UBD/gooN
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260807054441945.UAVI.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 7 Aug 2026 14:44:41 +0900
Date: Fri, 7 Aug 2026 14:44:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: keep interactive console input for native
 programs via Cygwin
Message-Id: <20260807144440.a1bc79ad5fede93073ef7bae@nifty.ne.jp>
In-Reply-To: <44947be6-f15d-8e6b-2b8a-295f54bc6b1e@gmx.de>
References: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com>
	<20260721044125.b0564ce6a797404b79a0f0a8@nifty.ne.jp>
	<44947be6-f15d-8e6b-2b8a-295f54bc6b1e@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1786081482;
 bh=C7g1vjQU7E+IssjXQ4n1YL76K+jRmoJuWdTTElXzBn8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=UBD/gooNpZMCz1uWWBfthhyrm63wgclq/sAE+YahnSl8nN4mau47OatKieqIKGfh9vKzwWoq
 LWuJDJuQbTXyv45+1WnfTMEiMrVnjTSyyZVhU4o4sOBwEL/ljchTnHyERr14Tkb/vno9XwlxtE
 oQDwmVAyFU1wd6fSw7OGp7RGN+wQszVcOWqDkIAMtn8f6lu/RGPcNpYYR3l8hS3u40+N+/jQ6W
 fhmemJMQAwaqDYKcTB4Oe99UeTqqcD4zN/sv3amiWYZIouLiGNyQI5kp6ZTcLHvJq/8LDHb+zA
 6mOZXuxO+75+6PE1zKMp0he/cCB2pNv2EldroxrHF+ZOF+tA==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Wed, 22 Jul 2026 01:18:16 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 21 Jul 2026, Takashi Yano wrote:
> 
> > On Mon, 20 Jul 2026 09:43:18 +0000
> > "Johannes Schindelin  wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > 
> > > Currently, when a native Windows program starts a Cygwin program while a
> > > pseudo console is active, and the Cygwin program then starts another
> > > native Windows program, the final program can lose access to console
> > > input. It then behaves as though its standard input were redirected
> > > instead of remaining interactive.
> > > 
> > > For example, a native `git.exe` may invoke shell aliases (i.e. execute a
> > > shell command) that would in turn call interactive Git commands who
> > > would no longer work because their standard input appeared to be
> > > redirected. This can be demonstrated as follows:
> > > 
> > >   git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
> > >     Write-Output ([Console]::IsInputRedirected)
> > >     try {
> > >       [void][Console]::KeyAvailable
> > >       exit 0
> > >     } catch {
> > >       exit 1
> > >     }
> > >   "' console-probe
> > > 
> > > Running this command with a Win32 version of `git.exe` currently prints
> > > `True` and exits with exit code 1. In the latest official release, where
> > > this bug is not present, it prints `False` and results in exit code 0.
> > > 
> > > The reason is to be fonud in the archetype code. Reminder: For each
> > > pseudo terminal (pty), the archetype is the shared pty fhandler that
> > > owns the underlying native handles and supplies them to every
> > > per-file-descriptor fhandler for that pty.
> > > 
> > > `open_with_arch()` calls `open()`, copies the first pty fhandler's state
> > > into the archetype, and then calls `open_setup()`. At that stage, pcon
> > > handle adoption already took place in `open_setup()`. This was not
> > > anticipated by 60a88896dc (Cygwin: pty: do not leak nat handles when
> > > adopting the pcon's in open_setup(), 2026-06-25), which tried to fix a
> > > leak by closing the superseded native handles as they were replaced in
> > > `open_setup()`.  Because `open_with_arch()` had already copied those
> > > handle values into the archetype, closing them invalidated the
> > > archetype's copies.
> > > 
> > > The archetype therefore retained stale values for those closed handles,
> > > which later pty fd fhandlers would inherit. If Windows reuses one of
> > > those values for a newly duplicated pcon handle, closing the stale value
> > > closes the new handle instead. The nested native program then receives
> > > unusable console input.
> > > 
> > > Preserve usable console input by moving the unchanged transactional pcon
> > > handle adoption to `open()`, before the archetype snapshot. The archetype
> > > then receives valid pcon handles, all pty fd fhandlers inherit live
> > > handles, and the superseded raw pipe handles are closed exactly once.
> > > 
> > > This commit is best viewed with `--color-moved`.
> > > 
> > > Fixes: 60a88896dce0 ("Cygwin: pty: do not leak nat handles when
> > >  adopting the pcon's in open_setup()")
> > > Assisted-by: GPT-5.6 Sol
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > How can I reproduce the issue in cygwin?
> > I tried:
> > $ git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
> >     Write-Output ([Console]::IsInputRedirected)
> >     try {
> >       [void][Console]::KeyAvailable
> >       exit 0
> >     } catch {
> >       exit 1
> >     }
> >   "' console-probe
> > False
> > $ '/cygdrive/c/Program Files/Git/mingw64/bin/git.exe' -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
> >     Write-Output ([Console]::IsInputRedirected)
> >     try {
> >       [void][Console]::KeyAvailable
> >       exit 0
> >     } catch {
> >       exit 1
> >     }
> >   "' console-probe
> > False
> > $ '/cygdrive/c/Program Files/Git/bin/git.exe'  -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
> >     Write-Output ([Console]::IsInputRedirected)
> >     try {
> >       [void][Console]::KeyAvailable
> >       exit 0
> >     } catch {
> >       exit 1
> >     }
> >   "' console-probe
> > False
> > $
> > 
> > All look successfull on master branch...
> 
> I'm sorry, I should have clarified several things:
> 
> - First of all, this reproducer has to be run in MinTTY.
> 
> - Second, it does _not_ actually reproduce the bug with the Cygwin runtime
>   built from cygwin/master. It only reproduces in Git for Windows' flavor
>   of the MSYS2 runtime because of the backports of:
> 
>   - 6eed1ef748 (Cygwin: pty: detect pcon-backed pty for non-Cygwin-spawned
>     children, 2026-04-30)
> 
>   - b34394d456 (Cygwin: pty: Fixup pty state after a cygwin app exits,
>     2026-06-13)
> 
>   - 60a88896dc (Cygwin: pty: do not leak nat handles when adopting the
>     pcon's in open_setup(), 2026-06-25)
> 
>   The combination of these three commits is the trifecta that surfaces
>   that bug, and the same issue _does_ reproduce when cherry-picking those
>   backports on top of `cygwin-3_6-branch`. For your convenience, I have
>   pushed that branch to
>   https://github.com/dscho/msys2-runtime/commits/minimal-backports-for-nat-leakfix-bug
> 
> - The reproducer not only requires the use of Git for Windows' `git.exe`
>   (as an easy way to run a Win32 program that calls a non-Win32 Bash that
>   in turn calls a Win32 program again, I should probably have come up with
>   a command-line that uses powershell.exe instead of git.exe). In
>   addition, `git.exe`'s _strong_ preference for _its own_ `sh.exe` needs
>   to be side-stepped by defining `MSYSTEM=MINGW64` (which stops that
>   PATH-editing logic of `git.exe`):
> 
>   MSYSTEM=MINGW64 PATH=/cygdrive/c/Program\ Files/Git/mingw64/bin:/usr/bin:$PATH git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "Write-Output ([Console]::IsInputRedirected); try { [void][Console]::KeyAvailable; exit 0} catch {exit 1}"' console-probe

Thanks. I was able to reproduce the issue. Belatedly, I’ll review your patch.
Please give me a little more time.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
