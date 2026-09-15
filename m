Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id C49404BA2E3F
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 08:21:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C49404BA2E3F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C49404BA2E3F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789460461; cv=none;
	b=GMhVKt6PZdGAgntpbcXiQcdawPC1NddksWmVet3FwFSnbtYc0CZb3lqhXyyflBdzu6+BTJsB8jAMQ52t7zG2fPlMGH17t+ejg8c/eNbkIrWvWxVNU9FdzYDYsgkPZIjXDzS2qezvDEkRtr6dEaay88an0IaMh4vexQuAOswa9D0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789460461; c=relaxed/simple;
	bh=qEfR2trzlzC6fCDL+Zpy9gbnfqyqHAUE/hm+jbkXGVk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=k2KndIjQvSUzseGbLJ854nec4he3//lppUOBiROHV+iXXufeVKgyIAnTvDoWaMg3NivZmhFEJ3ZJ0WgtHubYqO7WOgBCoXmFgauKW0s8qNdeyKCm1/3UC4jmS/ujf3e6o/vXkKpGPDiXPUkIHySzqzgmGWf8LrheTkvHDcSUcNA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=omeDrZpv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C49404BA2E3F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=omeDrZpv
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260915082058749.FJJB.18412.HP-Z230@nifty.com>;
          Tue, 15 Sep 2026 17:20:58 +0900
Date: Tue, 15 Sep 2026 17:20:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Jay Libove Alzina <libove@felines.org>
Subject: Re: [PATCH v2] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
Message-Id: <20260915172059.eb9a5896ce54f777d2c5c234@nifty.ne.jp>
In-Reply-To: <5c21c922-d4db-a4b5-4a61-dc3cad3f0b76@gmx.de>
References: <20260912042757.1700-1-takashi.yano@nifty.ne.jp>
	<5c21c922-d4db-a4b5-4a61-dc3cad3f0b76@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789460458;
 bh=R1iZWq17BxRo9nWUO/WT+1cMYA33gVLNqyMxMw7jV9E=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=omeDrZpv+iW5cCgsxOlbDfh/OP+ESihhzHb1jmUBKXRGKHA/DOPSc5W0xt+6zJj+8NnGaghZ
 FAHYh+yAKiN7NzOnt14LnUG4J/pmpME70InHUiIDSbGt2k1P/MzlA9ZcmwcLzYYYJhslGO0s8r
 0vYuM+0kiBt0uT0KuN9ovW1xdDJ1Z8dIqubGZUbZId+OzU5/Av/KbMgd0xpcbEhJOPdXXbS27B
 ejj6/TvV+ASIr8tjMuauv0Hjdh61U/yBo+EE3hkM7Zz1DfAhT0oSv1nMT+svoYMfqHjuddy/sI
 qsPeK8I/+As+6tlJXn1Z6wAvKxsTZGedpauw+/HPaX9Qn5Mw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 13 Sep 2026 14:12:16 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 12 Sep 2026, Takashi Yano wrote:
> 
> > With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> > thread runs only when it is supposed to"), the process which calls
> > set_disable_master_thread() hangs if the con.owner already exited,
> > because set_disable_master_thread() waits for cons_master_thread
> > accepting the status change and reflecting the current status to
> > master_thread_suspended. With this patch, set_disable_master_thread()
> > is aborted if the owner process no longer exists to avoid this
> > hang.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
> > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > Reported-by: Jay Libove Alzina <libove@felines.org>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> > v2:
> >   Fix the race
> > 
> >  winsup/cygwin/fhandler/console.cc | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 5f78d0c62..4b1ba60ca 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -5009,11 +5009,24 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
> >  	return;
> >      }
> >    const _minor_t unit = cons->get_minor ();
> > +  if (con.owner == 0)
> > +    /* The process that runs cons_master_thread no longer exists. */
> > +    return;
> 
> This discards a request that a replacement worker must inherit.
> 
> A reachable retired state is `con.owner=0`, `disable_master_thread=false`,
> `master_thread_suspended=true`: the worker yielded to a reader, then its
> hosting process closed a console descriptor that was not its controlling
> terminal, without requesting suspension. A surviving foreground Cygwin
> process subsequently requests suspension before starting a native
> application, but the initial guard returns without recording the true
> request. A later Cygwin process with redirected stdin and console stdout
> can adopt that console and start a replacement worker without resetting
> the false request. It therefore runs and can consume flow-control
> characters intended for the native reader. V2's later normalization cannot
> help: the initial return bypasses it.
> 
> Before this patch, the true request was recorded, and the already-true
> acknowledgement let the call finish immediately. Thus this is a regression
> in a previously completing case, not simply a different outcome for an
> already-hanging case. The defect comes from v1's guard and remains in v2.
> 
> The basic idea is: a missing worker lets us stop waiting, but not discard
> the request its replacement needs. We need to preserve or normalize the
> shared request consistently under input-state synchronization on both
> no-owner exits, without removing the dead-owner escape.

OK. What about v2 patch instead?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
