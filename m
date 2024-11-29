Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 967433858D26; Fri, 29 Nov 2024 12:09:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 967433858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732882145;
	bh=isqSasKoZYrknRLrQJU38D4/G0PNZgULCmYSUDW6ibo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=CKDO9XsKg/E0s8wSJVWGDMez2dlkBfxgMnmi1ONmXsNKaAG1REMEKOgHPvxq/aSOW
	 fPvSqIHxyjSda4i5fbWC4cm957/6T5blPJlRBe5utiWkYiNZFlVhW5qRwXYS0L2ssl
	 9U3TKN8ZOPd/CWgWgzi+Lr8Ng2VolghxAxmhyj1A=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8C636A80984; Fri, 29 Nov 2024 13:09:03 +0100 (CET)
Date: Fri, 29 Nov 2024 13:09:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 6/7] Cygwin: cygtls: Prompt system to switch tasks
 explicitly in lock()
Message-ID: <Z0mu33xdy9BYP_xg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
 <20241126085521.49604-7-takashi.yano@nifty.ne.jp>
 <Z0dQH6Ur71VzX_7q@calimero.vinschen.de>
 <20241129210306.a98b246a7da58d52b3a4a06c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129210306.a98b246a7da58d52b3a4a06c@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 21:03, Takashi Yano wrote:
> On Wed, 27 Nov 2024 18:00:15 +0100
> Corinna Vinschen wrote:
> > On Nov 26 17:55, Takashi Yano wrote:
> > > This patch calls Sleep() in lock() in order to increase the chance
> > > of being unlocked in other threads. The lock(), unlock() and locked()
> > > are moved from sigfe.s to cygtls.h so that allows inline expansion.
> > 
> > When doing the locking in C++, we should really make stacklock volatile.
> > That affects especially the unlock and locked methods, where you'll
> > never know how gcc optimizes away.
> 
> OK. I have added volatile to stacklock. Please see v3 patch.
> 
> > spinning should be volatile as well, but it's up to you if you already
> > add that, or if we only do this when we add the SIGKILL patches.
> 
> The variable spinning does not concern directly for this patch,
> so could you please include that in your longjmp patch?

Sure, no worries.


Corinna
