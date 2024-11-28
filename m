Return-Path: <SRS0=Se+v=SX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 040303858D20
	for <cygwin-patches@cygwin.com>; Thu, 28 Nov 2024 11:26:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 040303858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 040303858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732793187; cv=none;
	b=Rek4XzdB+8omziTEICEJqGlLX/gkmgnPdY2A9Iwib86fwxXcsgCguWLM53tKomel+krjscXlf56E/3OXlIdxv7HbkBPxEqU6AuXIIPW7HuX83PS7F6mzUmxkqc0ZxMs/5XiT0isXpF4qMKXt5VkqbdMDbBwCcnFdjMykwVnZG6A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732793187; c=relaxed/simple;
	bh=KBllkq6cKBXjYGH/asWW/tbVzgvUX0qRglpPAvzD3Cg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vOalisqncGsWF56YGY9slLB/94jfbMp7o481EX3QC9RCX0qH1SeNyv5LAAw5UtGA71WvCq9yfe4MWs60MRbyt+2xdgeJ9E6TgmFtuNpiR2Wvo15Gms9/fYy5WVS+O+4Vu9P5qDIWKCKMhB4AKojRPgPrtXkAdetNLvw8hqfY1F8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 040303858D20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bRr5raVf
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20241128112625256.VGPE.90249.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 28 Nov 2024 20:26:25 +0900
Date: Thu, 28 Nov 2024 20:26:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 8/8] Cygwin: signal: Fix another deadlock between main
 and sig thread
Message-Id: <20241128202624.fc0f87ed78e7bedd13db1dcd@nifty.ne.jp>
In-Reply-To: <Z0dQvJ-kenF_8q7I@calimero.vinschen.de>
References: <20241127112308.6958-1-takashi.yano@nifty.ne.jp>
	<Z0dQvJ-kenF_8q7I@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732793185;
 bh=rLlCzTt9hIGUQZ1QK+9meBF1dc/1VquoL64QlG05osA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bRr5raVfuz+nqIp0kTvsGscPM8NdwM+H+qf4g18Nu9nZGF9/ARbLAOu7NyXT2MzBsyIMazIW
 kaRGmCSYDOC0UcXoQ9HE0X15RGulXT+7QRDmvtaWCfe8gaIhaxcy6wP2qIoURDtvTDkziOi/2S
 XTIWgKpnM0lDebsBtwd1UtSoBz77iF3HHC4o5ze85j8eCE9avgi5QLLasWjVTHGKgJhfKYPEAt
 EVHb58YkADpVaQnrTFtn3Hpp3IXc88c949mgRyapW9PzP8lDXsp+nxK3tV9slVSK0BipzcqZ1d
 RC6G/g3nEHGU+kvtNQEN+phTT9oRtoDAeXDk3yf11JlbQWag==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 27 Nov 2024 18:02:52 +0100
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:

> On Nov 27 20:22, Takashi Yano wrote:
> > In _cygtls::handle_SIGCONT(), the sig thread waits for the main thread
> > processing the signal without unlocking tls area. This causes a deadlock
> > if the main thread tries to acquire a lock for the tls area meanwhile.
> > With this patch, unlock tls before calling yield() in handle_SIGCONT().
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > Fixes: 26158dc3e9c2("* exceptions.cc (sigpacket::process): Lock _cygtls area of thread before accessing it.")
> > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by:
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/exceptions.cc           | 10 +++++++---
> >  winsup/cygwin/local_includes/cygtls.h |  4 +++-
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> LGTM.

Thanks! Pushed to main branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
