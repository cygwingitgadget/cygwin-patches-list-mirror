Return-Path: <SRS0=l0P4=FO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id C55694BA2E09
	for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2026 19:41:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C55694BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C55694BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784576490; cv=none;
	b=FLnBh+f0eQJVOmUHDkJbH9dxnPcknPifMYRwmQuO7ACKj/Z+hpcxBvBH0k38iMFEk6TXmUP/eJ8+Msmy6EnoxBKX5ZDisGNftl1ZrYSk1NkZ+AE/zE7s0JTeIuotpL/uyb58mV5lwucoR/jvL7yeATdB4YOdJvDIx0ryBURffpU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784576490; c=relaxed/simple;
	bh=Sulajnzz/pXmO/m3EWGk3HN6FhzERsJZtaNOgKH6yh8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BZYvxWL5V4Z1pUMJSqx5KmGtqhicTXvLIxuL+GoA71hGnQgN6e+lbFJE3L9ArvxmkDsTNFu4AD2X3v6hnrQX2StDyQlXbQ7HzAq6ufcS/zgjlGIqxH8w+KwPhm+iL2xwWPxnon+wNRtsRcjWl3ChOjRD1FYo2KgXDKgZ1JVxTwA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=afbYsZgs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C55694BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=afbYsZgs
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260720194125985.HYLV.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2026 04:41:25 +0900
Date: Tue, 21 Jul 2026 04:41:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: keep interactive console input for native
 programs via Cygwin
Message-Id: <20260721044125.b0564ce6a797404b79a0f0a8@nifty.ne.jp>
In-Reply-To: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com>
References: <pull.8.cygwin.1784540598759.gitgitgadget@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784576486;
 bh=zGGz8CkS/0vC4090hTA0Hvx8hEdYBWOOODigFlJ/4TE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=afbYsZgsPr58WthHGxqp0qEhgbbpSosURrAy950rz+iEZTTthJyvEVUGpUZuO2dD03JoxAst
 MZP/2lgBsuJ4GEPAo+tzaWXp+fZx84BTrDN8dLC7cYFr5o/MZIP1BCyYozvgycJhBQcUPAp/si
 ICc0k5aOC1vhQuOJo9o6N//T2OJUYaIxImLTlm1KXeNLd0EhsahOOJxUgEUA5+xgTWm31Qc5p5
 ZylAY6nXP7SRRu9tvaV7PrlQqoZWGEzFC0YlNKX1lDex+g3q4UbZdtmVFGKkXPpuJ//jRIdmsh
 NBI65p+SJW4HqDHgcecWmw2Q1o7zeijIjZMEwOa5IyneFqrA==
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 20 Jul 2026 09:43:18 +0000
"Johannes Schindelin  wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Currently, when a native Windows program starts a Cygwin program while a
> pseudo console is active, and the Cygwin program then starts another
> native Windows program, the final program can lose access to console
> input. It then behaves as though its standard input were redirected
> instead of remaining interactive.
> 
> For example, a native `git.exe` may invoke shell aliases (i.e. execute a
> shell command) that would in turn call interactive Git commands who
> would no longer work because their standard input appeared to be
> redirected. This can be demonstrated as follows:
> 
>   git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
>     Write-Output ([Console]::IsInputRedirected)
>     try {
>       [void][Console]::KeyAvailable
>       exit 0
>     } catch {
>       exit 1
>     }
>   "' console-probe
> 
> Running this command with a Win32 version of `git.exe` currently prints
> `True` and exits with exit code 1. In the latest official release, where
> this bug is not present, it prints `False` and results in exit code 0.
> 
> The reason is to be fonud in the archetype code. Reminder: For each
> pseudo terminal (pty), the archetype is the shared pty fhandler that
> owns the underlying native handles and supplies them to every
> per-file-descriptor fhandler for that pty.
> 
> `open_with_arch()` calls `open()`, copies the first pty fhandler's state
> into the archetype, and then calls `open_setup()`. At that stage, pcon
> handle adoption already took place in `open_setup()`. This was not
> anticipated by 60a88896dc (Cygwin: pty: do not leak nat handles when
> adopting the pcon's in open_setup(), 2026-06-25), which tried to fix a
> leak by closing the superseded native handles as they were replaced in
> `open_setup()`.  Because `open_with_arch()` had already copied those
> handle values into the archetype, closing them invalidated the
> archetype's copies.
> 
> The archetype therefore retained stale values for those closed handles,
> which later pty fd fhandlers would inherit. If Windows reuses one of
> those values for a newly duplicated pcon handle, closing the stale value
> closes the new handle instead. The nested native program then receives
> unusable console input.
> 
> Preserve usable console input by moving the unchanged transactional pcon
> handle adoption to `open()`, before the archetype snapshot. The archetype
> then receives valid pcon handles, all pty fd fhandlers inherit live
> handles, and the superseded raw pipe handles are closed exactly once.
> 
> This commit is best viewed with `--color-moved`.
> 
> Fixes: 60a88896dce0 ("Cygwin: pty: do not leak nat handles when
>  adopting the pcon's in open_setup()")
> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

How can I reproduce the issue in cygwin?
I tried:
$ git -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
    Write-Output ([Console]::IsInputRedirected)
    try {
      [void][Console]::KeyAvailable
      exit 0
    } catch {
      exit 1
    }
  "' console-probe
False
$ '/cygdrive/c/Program Files/Git/mingw64/bin/git.exe' -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
    Write-Output ([Console]::IsInputRedirected)
    try {
      [void][Console]::KeyAvailable
      exit 0
    } catch {
      exit 1
    }
  "' console-probe
False
$ '/cygdrive/c/Program Files/Git/bin/git.exe'  -c 'alias.console-probe=!powershell.exe -NoLogo -NoProfile -Command "
    Write-Output ([Console]::IsInputRedirected)
    try {
      [void][Console]::KeyAvailable
      exit 0
    } catch {
      exit 1
    }
  "' console-probe
False
$

All look successfull on master branch...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
