Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E58793858414; Thu, 21 Nov 2024 11:36:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E58793858414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732188979;
	bh=h3RmxuMvHi6cIVGpIsoejvTQTu0ChiOOkq7zBlk4Vvc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=faPvYhULj1v6BaGZRjXA9q4jxaMWcSH7TzscuAsihbRW/p80kbA/GvtiKkjcC9BOz
	 P27O4vLrg4MC1Ov4McDcmYcwHJ80bbwyc6QWGfaqXGXMFLQYiZxWcSu3veDRaiC40V
	 azDP+k6oyPH2nbpTgoI8oqi/zOk90cGvMUGIYrxs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D9B01A80BF4; Thu, 21 Nov 2024 12:36:17 +0100 (CET)
Date: Thu, 21 Nov 2024 12:36:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
Message-ID: <Zz8bMTNsFHqd31cm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241113060354.2185-1-mark@maxrnd.com>
 <ZzsxhLhL_h3xey5h@calimero.vinschen.de>
 <3a16a22f-3f16-4ebb-ac9b-a1ad3a71b1ec@maxrnd.com>
 <Zz7-pdtxYgOCr6p7@calimero.vinschen.de>
 <a9f666d5-aec0-4bd1-a69f-c13464397882@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9f666d5-aec0-4bd1-a69f-c13464397882@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 21 02:52, Mark Geisert wrote:
> On 11/21/2024 1:34 AM, Corinna Vinschen wrote:
> > On Nov 21 01:12, Mark Geisert wrote:
> > > Hi Corinna,
> > > 
> > > On 11/18/2024 4:22 AM, Corinna Vinschen wrote:
> > > > Hi Mark,
> > > > 
> > > > 
> > > > Jon, would you mind to take a look, please?
> > > 
> > > I appreciate the additional eyes, thanks.
> > > 
> > > > This looks good to me, just one question...
> > > > 
> > > > On Nov 12 22:03, Mark Geisert wrote:
> > > [...]
> > > > > +    /* Delay a short time so PdhCQD in caller will have data to collect */
> > > > > +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */
> > > > 
> > > > Is there a reason you specificially chose 16 msecs here?
> > > > 
> > > > I'm asking because the usual clock tick is roughly 15.x msecs.
> > > > Any Sleep() > 0 but < 16 results in a sleep of a single clock tick, i.e.,
> > > > 15 ms.  Occassionally 2 ticks, ~31 msecs, 1 to 5 out of 100 runs.
> > > > 
> > > > If you choose a value of 15 msecs, the probability of a Sleep() taking
> > > > two ticks is much higher and can be 1 out of 2 Sleep().
> > >                      ^^^^^^
> > >                      lower, I think
> > 
> > No, higher.  In a low load scenario
> > 
> > Sleep (1)  -->  < 5% will take two or more clock ticks
> > Sleep (15) -->  up to 50 % will take two or more clock ticks
> > Sleep (16) -->  100% will take two or more clock ticks
> 
> Ah, now I see what you mean.  So to maximize the probability it's only one
> tick, use "Sleep(1)".  Still that's not a guarantee it's one tick.
> Have I got that right?

Actually MSDN implies

  If dwMilliseconds is less than the resolution of the system clock, the
  thread may sleep for less than the specified length of time. If
  dwMilliseconds is greater than one tick but less than two, the wait
  can be anywhere between one and two ticks, and so on.

Fact is, I never saw a Sleep(1) taking less than one clock tick,
whatever the clock tick is.

But yeah, to be on the safe side, Sleep (15L) might be in order,
especially if this only occurs once per process.


Corinna
