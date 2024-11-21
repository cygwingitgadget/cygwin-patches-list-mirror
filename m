Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7A80F385802C; Thu, 21 Nov 2024 09:34:32 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B8A3BA80C30; Thu, 21 Nov 2024 10:34:29 +0100 (CET)
Date: Thu, 21 Nov 2024 10:34:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
Message-ID: <Zz7-pdtxYgOCr6p7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241113060354.2185-1-mark@maxrnd.com>
 <ZzsxhLhL_h3xey5h@calimero.vinschen.de>
 <3a16a22f-3f16-4ebb-ac9b-a1ad3a71b1ec@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a16a22f-3f16-4ebb-ac9b-a1ad3a71b1ec@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

On Nov 21 01:12, Mark Geisert wrote:
> Hi Corinna,
> 
> On 11/18/2024 4:22 AM, Corinna Vinschen wrote:
> > Hi Mark,
> > 
> > 
> > Jon, would you mind to take a look, please?
> 
> I appreciate the additional eyes, thanks.
> 
> > This looks good to me, just one question...
> > 
> > On Nov 12 22:03, Mark Geisert wrote:
> [...]
> > > +    /* Delay a short time so PdhCQD in caller will have data to collect */
> > > +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */
> > 
> > Is there a reason you specificially chose 16 msecs here?
> > 
> > I'm asking because the usual clock tick is roughly 15.x msecs.
> > Any Sleep() > 0 but < 16 results in a sleep of a single clock tick, i.e.,
> > 15 ms.  Occassionally 2 ticks, ~31 msecs, 1 to 5 out of 100 runs.
> > 
> > If you choose a value of 15 msecs, the probability of a Sleep() taking
> > two ticks is much higher and can be 1 out of 2 Sleep().
>                     ^^^^^^
>                     lower, I think

No, higher.  In a low load scenario

Sleep (1)  -->  < 5% will take two or more clock ticks
Sleep (15) -->  up to 50 % will take two or more clock ticks
Sleep (16) -->  100% will take two or more clock ticks


Corinna
