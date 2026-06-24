Return-Path: <SRS0=3SWy=EU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 690B14BA2E3E
	for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 12:33:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 690B14BA2E3E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 690B14BA2E3E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782304429; cv=none;
	b=JnL6M1xggqzTfkAXtFvVgoDQ/M3zzPtTkGeWziMqEhfM0dRrEYlislFE3X2cv9STIEYu8ejQiQPkcibOMWPrRQPXb0glm8ZDPoiGlhFLGy3SmsXaxoFDRXtjcYMrvXAVjrHSPldTjTTKy8vm4Md6zr8wel1fxOLMDaOzeorq9f0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782304429; c=relaxed/simple;
	bh=/wn3k4TsYn3FHZO9FxOT9QQcMlHUbcpSS1ZDQlvV/IY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=URxG1uPHPmAEa82crqhZ1Dzs+gA7QIfZ8hM7F7qG+bHXy34HTc9nM413Z1CM6vUnK17xs7XeRiSIFQzzvAgpw2jLiry1Knvv4Zyl6LbVMWwhKx5cWE0SFx7oxDDsmdaVw9rYVMS2gPX75FMgdB8Su/19dGPDeM7/M6iGC3nzAag=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=X1mBoIK5
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 690B14BA2E3E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=X1mBoIK5
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260624123346445.FJOQ.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 24 Jun 2026 21:33:46 +0900
Date: Wed, 24 Jun 2026 21:33:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: console: Fix typeahead input for bash
Message-Id: <20260624213343.95cdc8372fe3f039e02ba3e7@nifty.ne.jp>
In-Reply-To: <bfbe7db3-dfb9-4a3e-a0bc-fe48c7235337@maxrnd.com>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-4-takashi.yano@nifty.ne.jp>
	<bfbe7db3-dfb9-4a3e-a0bc-fe48c7235337@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782304426;
 bh=lmjvwzUBUkcY8NOqStvW1pAInHP6m2Yxu6tsqw4H7q4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=X1mBoIK5TYgp4CLRpWz8usr4xUw3sY1GqmciTZefMX2HaQBPNFB/lZ13W+3XpzBebuXeLQbD
 C39yEsj4qD4zPGFuJZGylbxy9Ruk06wJs15849oAg886l5n0Sbn7+rwFyR9gmHaMLk+sbJcizS
 FluDIwLIDDNuUkKqBeOzSnYzuWi1qTuai0Rjby63tcqOKKwOvJGC/z95BX1yZ66WXy6Lua99b7
 9nVqnr1xRD9fKbrjHCiXp1G9FW+aOmtRRkRiatzLBKbLuHXWfBYqQssqPcXaGNRPxw+73SiAm0
 R25J0rfFZnl+XiHFtcn/+5ZvS05af5JznruPOs/mUgOEa2Og==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thansk for reviewing this patch seriese. Pushed.

On Wed, 24 Jun 2026 01:05:16 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> This patch LGTM.  OK to push.
> 
> ..mark
> 
> On 6/10/2026 9:35 AM, Takashi Yano wrote:
> > Currently, following misbehaviour occurs in bash.
> >    1) Run "sleep 10".
> >    2) Type "cmd<enter>ps<enter>" while "sleep is running".
> >    3) After "sleep" ends, "ps" does not run in "cmd".
> >    4) exit from "cmd". Then, "ps" is executed.
> > This is because process_input_message() handles all the events in
> > the console input buffer, and stores key input into readahead buffer.
> > However, since the readahead buffer is unique to process, "cmd"
> > cannot read it. Since "ps<enter>" is stored in bash's readahead
> > buffer, it is executed by bash after "cmd" exits. With this patch,
> > process_input_message() handles only the requested amount of events
> > by read().
> > 
> > Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >   winsup/cygwin/fhandler/console.cc       | 15 ++++++++++++---
> >   winsup/cygwin/local_includes/fhandler.h |  2 +-
> >   winsup/cygwin/select.cc                 |  2 +-
> >   3 files changed, 14 insertions(+), 5 deletions(-)
> [...]


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
