Return-Path: <SRS0=waNz=BG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 59F754BA2E16
	for <cygwin-patches@cygwin.com>; Fri,  6 Mar 2026 00:10:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 59F754BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 59F754BA2E16
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772755848; cv=none;
	b=RyUOMQvBAHq5sqXvKB0IkzilBx3ssBImPZ0eADAPNfxKFX0TuK9Q0zrgJTorAqJDM6ohpI6QptE9XT+NltrxWasSYipEyp3oJ7CkidibE1a7aubGlVIA+qM9RCVQ8kgmi1qMyeSdNAzfwTpgVZFgmQqLg/cli4hQEqb1FCX4JIM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772755848; c=relaxed/simple;
	bh=EJr/r6YBYTP/4LqCNySpfc7bTdCPNzjVRIxyhwtOVZk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=PN4ruV1MwAbPAv3/Zc9cEFqrWKCcb0FthaDrPynTidVWwBQ91XUajPa7w/PMpsapAp5JQ7CDoPI4jDcJI3yhf5p5rqL0RVKDpuYS7TNq7Z1FjswWfq1HHbGFmDYp2oKB3v2SqTbko60T+5d9XVxk0V19bM+3CATJKDJ4fBlyCNY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 59F754BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TN0qHnnL
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260306001045390.CWOS.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Mar 2026 09:10:45 +0900
Date: Fri, 6 Mar 2026 09:10:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix input transferring from nat pipe to
 cyg pipe
Message-Id: <20260306091044.34904c14ea29500aecb29292@nifty.ne.jp>
In-Reply-To: <09e16a98-e580-8846-e69b-1566c0d6871e@gmx.de>
References: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
	<20260303134058.3517-2-takashi.yano@nifty.ne.jp>
	<09e16a98-e580-8846-e69b-1566c0d6871e@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772755845;
 bh=rZUg5yLE8IMbn36DtZ4rNPQf6OuixFj8XzsqcFWoswk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TN0qHnnLohA5mgrlLsgAwA7bL09RPYxlvBQza7VFVT6XHIrSxbcwgTjItkMHhveSg8VA0Hig
 YJ7mu0AVC1WIXY7JYIMHByeEUaJACnEjqj00qTKTf6Yy5gwqtdhCLNFb2iZnyzepUKFS81Wrhg
 D7TXarH5hw8QvtVwwOQP5dJ9Fe9HYDumh3w8e+8VZ5SAxOYPSIeDlICfl5kv4AQN1viS7jb+OD
 5FmIuHGLTtvEYqfxmchYp6z7eKYvKxr3Mo6GgmBxgeb4XWgHp1qRgPe6sOIYNZziBI0xo/jwnV
 KO6Z0bXT/ishswzJZKvFeTXbZXrHl3wbAL56RUBOEy+81Ncg==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for the review!

On Thu, 5 Mar 2026 11:12:50 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 3 Mar 2026, Takashi Yano wrote:
> 
> > In disable_pcon mode, input transferring from nat pipe to cyg pipe
> > does not work after the commit 04f386e9af99. This is because nat
>                                  ^^^^^^^^^^^^
> 
> When I imagine myself reading this in a couple of months, I foresee
> wishing for the commit OID to be amended by the usual information
> (`--format=reference` in Git parlance). In this instance: 04f386e9af
> (Cygwin: console: Inherit pcon hand over from parent pty, 2024-10-31).

OK. That makes sense.

> > pipe hand over is wrongly handled in get_winpid_to_hand_over().
> > This function should return the PID that should acquire ownership
> > of the nat pipe. However, when pseudo console is disabled, it
> > returns PID of cygwin process (such as cygwin shell) when no
> > other native (non-cygwin) app is not found.
> > 
> > The case that even cygwin app should take over the ownership
> > of nat pipe, is happen only in pcon_activated case. This patch
> > adds pcon_activated check to the condition where even a cygwin
> > app is allowable as a target to hand over.
> 
> While this looks technically correct, I suggest that the commit message
> should lead with the context and impact, illustrating the bug's symptoms.
> The reason? While I now understand what this patch is about, I would have
> liked the commit message to help me get there quicker.
> 
> Also, I was scratching my head a bit why there is only one changed
> condition in the diff when the function contains _three_ calls to
> `get_console_process_id()`. The explanation is that the other two calls
> filter out Cygwin processes (because those calls use `nat = true`). I
> guess it cannot hurt to keep trying to get potential other candidates
> connected to the console (even if I thought that `disable_pcon` meant that
> there simply is no console).
> 
> With that in mind, I iterated a bit on a commit message with the help of
> Claude Opus, and this is a draft I'd like to take as inspiration:
> 
>    Cygwin: pty: Fix nat pipe hand-over when pcon is disabled
> 
>    The nat pipe ownership hand-over mechanism relies on the console
>    process list ― the set of processes attached to a console, enumerable
>    via `GetConsoleProcessList()`. This list only exists when there is a
>    pseudo console. When pseudo console support is disabled, there is no
>    console associated with the PTY, so this list is meaningless.

Actually, in disable_pcon case, the process on the PTY is associated with
an invisible console.

>    04f386e9af (Cygwin: console: Inherit pcon hand over from parent pty,
>    2024-10-31) added a last-resort fallback in `get_winpid_to_hand_over()`
>    that hands nat pipe ownership to any process in the console process
>    list, including Cygwin processes. This fallback is needed when a
>    Cygwin process must take over management of an active pseudo console
>    after the original owner exits.
> 
>    When the pseudo console is disabled, this fallback incorrectly finds a
>    Cygwin process (such as the shell) and assigns it nat pipe ownership.
>    Since there is no pseudo console for that process to manage, ownership
>    never gets released, input stays stuck on the nat pipe, and keyboard
>    input to the shell breaks.
> 
>    Only the third (last-resort) call in the cascade needs guarding: the
>    first two calls filter for native (non-Cygwin) processes via the `nat`
>    parameter, and handing ownership to another native process is fine
>    regardless of pcon state. It is only the fallback to Cygwin processes
>    that is dangerous without an active pseudo console.
> 
>    Guard the fallback with a `pcon_activated` check, since handing nat
>    pipe ownership to a Cygwin process only makes sense when there is an
>    active pseudo console for it to manage.
> 
> It could probably use some clarification as to why the other two calls
> aren't disabled (I guess the explanation is along the lines that even in
> `disable_pcon` mode, there _could_ be an attached Console instance and we
> would want to find processes attached to that instance).
> 
> Thoughts?

I'll update the commit message and submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
