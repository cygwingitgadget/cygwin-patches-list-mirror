Return-Path: <SRS0=6u+c=HL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id 870164B9DB59
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 15:17:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 870164B9DB59
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 870164B9DB59
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789831030; cv=none;
	b=ABG4jaT3VvIXFaBuH7vCpPDX863OGG0NPCpPrBvgks0QEFTZsdVQkdMgZk76PIVDlaPb68rB70W9rpwjMtzRgDiCSRNnGx4letD4PanPCrJX3EsJj5Yvt/I3+xqhzZF3g0IZBHRU91/Ux4ncO/ui0LJ5iNVbfkJbror4+8HqgnI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789831030; c=relaxed/simple;
	bh=SEmkWiBd3KWnUw7cEDF1YRYYg9V7xgScuP9I4PnVSIU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=XHxMW8KQA1Kcdr1Fyl2S3nlsvQwDal4NrCgfmTUHPQ8No2N7tUVDazl6UQDBWiOgzy1ocQGYdt0Wt+D3Qi1kJv1IWoST957O9e8wNef7qRbxUjs+vOUKY9a1eo9EzJgNkTNoPRB7vV2CEfIuNF6rrCgJKsUYYlNjRT18ix/VMYg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UDFayAA0
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 870164B9DB59
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UDFayAA0
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260919151707674.SMAL.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 20 Sep 2026 00:17:07 +0900
Date: Sun, 20 Sep 2026 00:17:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
Message-Id: <20260920001705.df30bbe38cb1097ccbfcfd01@nifty.ne.jp>
In-Reply-To: <20260919145711.6ce024cc19f0b99cae6e0deb@nifty.ne.jp>
References: <20260917054209.7682-1-takashi.yano@nifty.ne.jp>
	<f6e4cbb2-302e-910d-35f5-2a403d604322@gmx.de>
	<20260919145711.6ce024cc19f0b99cae6e0deb@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789831027;
 bh=ymw+3Q13vrIVI1GEBohCuWKXtMXYsE9lb3iOXvkRPbM=;
 h=Date:From:To:Subject:In-Reply-To;
 b=UDFayAA0gAeH9DG6iI2I65VtIeB6HgEHgIMRiEhQ3FWiFSQYo9+wksJPLNb7WYAv/OFfKtyf
 DuXsqp+bkccsZq2ggvAuW8YTSbNR00Kt+kwP1e2jw2QPmtRCK0ZHDlOO6AtwjeeR+wQZDjLPl1
 BiikvOrr/sNMa6c/PAATOkLFmRxz9LqAc1wQZmk9CnLNg/GgNKK+YOBreCH9BG46tq4d/1IyrZ
 WcTsnXJp+o5ANTePN9np5JPqyyE0uvVdmEsVWJhh9gvKRVJiAgEnH2g46xe0klRbV/hD5bgJSv
 4tVf2DGQ9pAcv0m+a8ZUXdX53/M+RAzbvbPAVutIjs1Kuu7g==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sat, 19 Sep 2026 14:57:11 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Fri, 18 Sep 2026 17:50:54 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Thu, 17 Sep 2026, Takashi Yano wrote:
> > 
> > > With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> > > thread runs only when it is supposed to"), the process which calls
> > > set_disable_master_thread() hangs if the con.owner already exited,
> > > because set_disable_master_thread() waits for cons_master_thread
> > > accepting the status change and reflecting the current status to
> > > master_thread_suspended. With this patch, set_disable_master_thread()
> > > is aborted if the owner process no longer exists to avoid this
> > > hang.
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
> > > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > > Reported-by: Jay Libove Alzina <libove@felines.org>
> > > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > ---
> > > v2: Treat the absence of the master thread the same as suspension.
> > > v3: Handle the crash of owner process.
> > 
> > Thank you!
> > 
> > There's one more concern I have: An owner query failure does not
> > necessarily mean the process exited, and observing exit is not a worker
> > acknowledgement.
> > 
> > I think we need to allow an owner-exit escape only on observed exit or
> > absence, with con.owner still matching the captured owner. We need to
> > leave the acknowledgement untouched and preserve -1 as normal retirement,
> > and log inconclusive query or wait failures once per newly observed
> > failing owner and keep waiting.
> > 
> > More concretely, I am worried about this scenario: An old owner's absence
> > can overwrite a replacement's acknowledgement. Non-owner cleanup A holds
> > `cons_mode_mutex` and requests resume, while acknowledgement remains true.
> > Process A captures a dead owner's PID or zero and selects the escape
> > branch before reacquiring `input_mutex`. Meanwhile, process B can claim
> > ownership in `open()` and start its worker before obtaining the mode
> > mutex, as v17 deliberately permits. Process B's worker sees the retained
> > false request and acknowledges resume. Process A then obtains the input
> > lock but rechecks neither owner nor acknowledgement before writing true.
> > The shared record now calls process B suspended despite its
> > acknowledgement. Later mode decisions use that record when selecting
> > `ENABLE_PROCESSED_INPUT`. Holding the mode mutex does not exclude the new
> > startup path, and taking the input lock does not validate the earlier
> > owner observation.
> 
> Sorry, I don't get your point. What do you mean by 'worker'? The
> caller of set_disable_master_thread()?
> 
> (1)
> I think it’s actually safer to mistakenly treat the owner as dead
> when it’s still alive than to make the opposite mistake. Therefore
> I use:
> `if (owner == 0 || owner == (DWORD) -1 || !process_alive (owner))`
> owner == 0: No master thread
> owner == -1: The master thread is about to exit.
> !process_alive (owner): Possibly, the owner process died.
> 
> (2)
> Setting con.master_thread_suspended = true is necessary when the
> master_thread is not respoiding, because Ctrl-C should work at
> least even when the master_thread is not alive and the process
> does not call process_input_message().
> If master_thread_suspended is not set, the set_input_mode()
> may clears ENABLE_PROCESSED_INPUT, so Ctrl-C does not work because
> of absence of the master thread.
> 
> Your code seems to be trying to track the liveness of the current
> master thread as accurately as possible, but I’m not sure that level
> of accuracy is really necessary.
> 
> If we mistakenly wait for an acknowledgement, it can cause a hang.
> But if we mistakenly don’t wait for an acknowledgement, what kind
> of risks do you think that would introduce?

On reconsideration, this isn’t the place where we should be steering
things toward ENABLE_PROCESSED_INPUT. And of course, it’s always
better to determine the state as accurately as possible.

Please take a look at the v4 patch I put together based on your ideas.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
