Return-Path: <SRS0=81Ig=VW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 02A1C3858D26
	for <cygwin-patches@cygwin.com>; Mon,  3 Mar 2025 12:24:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 02A1C3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 02A1C3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741004697; cv=none;
	b=WWe8DiwYQVo/nWpw3sf2anjn8BR8B6dm9z9TF/CDrt5MDpKLMjQXzxO/sUgVSyjURqCa3Ba5NgVDPYidfh7AOnUIMT1w3qc8dowXBc5Y+HTYt0y8jFt7MO7bKyozMUwltYvqADQ8EIgrVictTm2prh4s7FvBXRP3mDkEVn4crpA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741004697; c=relaxed/simple;
	bh=zjBnCOcXCHHCVBC0bHEPYFSPN7C7Ic3a6Fu5fC1YQKI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=NRuuSKkdb0vRdR1zCpPS+pyUwIaRCPfULbLC872rfshN3jpdDPOBybui9aUtYWMQ2u3oxcV1H9ZhJ90AJJmATj4Ir03PzQeg+BwpLjKfcDqYuMB7uPYWzrFLMof2HEgSXKZRffe/PVMb31ghm85B16Xn9yCiXXnp3mGQAeNnfYs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 02A1C3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SZcH81zS
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20250303122453889.LKT.74565.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 3 Mar 2025 21:24:53 +0900
Date: Mon, 3 Mar 2025 21:24:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: signal: Fix a race issue on modifying
 _pinfo::process_state
Message-Id: <20250303212453.511e306b7e0cf9ce04fad69c@nifty.ne.jp>
In-Reply-To: <Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
References: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
	<20250228233406.950-3-takashi.yano@nifty.ne.jp>
	<Z8V7onhvf9I8Hcuc@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741004693;
 bh=hBMSAsI3K6yo2jfMro5GKujOpeHo93qxpr09LCQarV0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=SZcH81zSxwwZPTe4ibhcv4dQUilj5qOJXWr1AVN//4PTVltKF7tbNzWq7WTzBkeh/BveFHGz
 p5tBwh91f4Hj/f311BdHz2v2MTTRIqL1Oi21Uu62Y1PDIG1ikQGvr2JFHuWx/cg+HcI0VWJM/q
 bt1oWXIrEnBmFWcL23yNkXFzNZndS6XgYPc7Prr+9AcQDFBXm/8bpyDRUl8ET2oFpWENRELjhR
 oqmzufSnioUSxBq44zAew9zdETpBu+jTg25tV8rdozxcfZTu3VWJzHe3xxAegnHHSjQWWKAKfV
 8eWwShTELacKWq0Qi9cgsltXjN1FgXiIGjd/sfAmBrXUMJVw==
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 3 Mar 2025 10:51:30 +0100
Corinna Vinschen wrote:
> On Mar  1 08:33, Takashi Yano wrote:
> > The PID_STOPPED flag in _ponfo::process_state is sometimes accidentally
> > cleared due to a race condition when modifying it with the "|=" or "&="
> > operators. This patch uses InterlockedOr/And() instead to avoid the
> > race condition.
> 
> Is this really sufficent?  I'm asking because of...
> 
> > @@ -678,8 +678,9 @@ dofork (void **proc, bool *with_forkables)
> >  
> >    if (ischild)
> >      {
> > -      myself->process_state |= PID_ACTIVE;
> > -      myself->process_state &= ~(PID_INITIALIZING | PID_EXITED | PID_REAPED);
> > +      InterlockedOr ((LONG *) &myself->process_state, PID_ACTIVE);
> > +      InterlockedAnd ((LONG *) &myself->process_state,
> > +		      ~(PID_INITIALIZING | PID_EXITED | PID_REAPED));
> >      }
> >    else if (res < 0)
> >      {
> 
> ...places like these.  Every single Interlocked call is safe in itself,
> but what if somebody else changes something between the two interlocked
> calls?  Maybe this should be done with InterlockedCompareExchange.

Thanks for reviewing.

How can we guard that situation by using InterlockedCompareExchange()?
Could you please give me some more instruction?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
