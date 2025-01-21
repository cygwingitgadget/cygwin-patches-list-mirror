Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CBC9C3858CD1; Tue, 21 Jan 2025 16:28:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CBC9C3858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737476882;
	bh=q8PjMxkA6Dh1/5fYvH0ZgrsfuzeKU/9b2dGpGcl48wM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dSAUe+ynIjTjeZ9q0Wqkf1U/gRGA9+JFVJb5aWCNR5qEdomh4JEQshPL6p8SDLyny
	 EEYvLo3fNJ7WlwyUiK+jJuciQi/wOf3AJUoyUQDBayzBADWI+InpQotGo+ETD0NcR/
	 lDInjYuGvD/XPsWrJWoG8wNafJrHAxPEllcsVrzw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1C028A80D44; Tue, 21 Jan 2025 17:28:01 +0100 (CET)
Date: Tue, 21 Jan 2025 17:28:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 3/3] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z4_LEQ4cFHKAHwF4@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp>
 <20250121031544.1716992-4-takashi.yano@nifty.ne.jp>
 <Z4-k5oypdJ2gDavi@calimero.vinschen.de>
 <20250121232553.4e28ee07909111736d088731@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121232553.4e28ee07909111736d088731@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 21 23:25, Takashi Yano wrote:
> On Tue, 21 Jan 2025 14:45:10 +0100
> Corinna Vinschen wrote:
> > This bugs me a bit.  While your solution nicely wraps the entire
> > timer problem into cygwait(), the downside is that each invocation
> > of cygwait() creates its own timer. Theoretically, given this is in a
> > loop with up to 100 iterations, you have up to 100 additional timer
> > create/destroy sequences.
> > 
> > So the question is, do you think this matters at all in this scenario,
> > given we're in a 10 ms wait state anyway?
> > 
> > If you think that's not an issue, feel free to apply the patch with
> > just the one-liner above.
> 
> Thansk for reviewing.
> cygwait (NULL, 10, cw_mask) is just waiting for resolving pipe full.
> Therefore, I think the overhead of creating and destroying a timer
> every 10 msec in the wait loop is small enough to be negligible.
> That is, the CPU load will be almost the same if we avoid it.
> 
> BTW, I'm happy if you could review also:
> [PATCH v2] Cygwin: signal: Avoid frequent TLS lock/unlock for SIGCONT processing

Will do tomorrow.  I'm a bit low on spare time ATM, sorry.


Corinna
