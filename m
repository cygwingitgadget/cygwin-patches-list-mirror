Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D94C1385B520; Mon, 18 Nov 2024 12:22:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D94C1385B520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731932550;
	bh=Pv/TuKeN8WzUfE7jplJTv8sVJHRhOkKgt4O1qrxA/wU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cPfyopaHv4WeOu1h+e5mu3PES/CulFDPp29EcEm+MZsQI2J+oZdZNsaUqp30fpuek
	 VUcl2FCPFZH+XAHcbHJT0x5h4DgyO9WRfUlbQwUif/oS6YT0HTBp6s/i2ktkHo1fDh
	 Q282VoT4ky2PieBWQZIrxNI34jY7XfbV4SGBU1pA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AA521A80650; Mon, 18 Nov 2024 13:22:28 +0100 (CET)
Date: Mon, 18 Nov 2024 13:22:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>,
	Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com, Mark Liam Brown <brownmarkliam@gmail.com>
Subject: Re: [PATCH v2] Cygwin: Minor updates to load average calculations
Message-ID: <ZzsxhLhL_h3xey5h@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>,
	Jon Turney <jon.turney@dronecode.org.uk>, cygwin-patches@cygwin.com,
	Mark Liam Brown <brownmarkliam@gmail.com>
References: <20241113060354.2185-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113060354.2185-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,


Jon, would you mind to take a look, please?


This looks good to me, just one question...

On Nov 12 22:03, Mark Geisert wrote:
> Commentary wording adjusted to say ProcessorQueueLength counts threads,
> not processes.  Also mention (upcoming) new tool /bin/loadavg.  The
> release note for Cygwin 3.5.5 is updated.
> 
> In counting runnable threads, divide by NumberOfProcessors to model
> distributing the threads among all processors.  Otherwise one gets e.g.
> PQLs of 20 or more just running a few lively X applications.  These PQLs
> vary greatly between kernel stats updates every 16ms, so are very clearly
> short-term loads.  This change helps reduce jitter in load average
> calculations.
> 
> At end of load_init(), obtain and discard the first measure of the
> counters to deal with the first call always returning error, no data.
> Follow this with a short delay so the next measure actually has data to
> report.
> 
> At least one older version of Windows, i.e. Win10 Pro 21H1, has a different
> name/location for the '% Processor Time' counter and is missing the
> 'Processor Queue Length' counter entirely.  Code is changed to support
> both possible locations of the former and treat the latter as always
> reporting 0.0.
> 
> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: de7f13aa9ace (Cygwin: loadavg: improve debugging of load_init)
> 
> ---
>  winsup/cygwin/loadavg.cc    | 70 ++++++++++++++++++++++++++-----------
>  winsup/cygwin/release/3.5.5 |  3 ++
>  2 files changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
> index 127591a2e..37da077fb 100644
> --- a/winsup/cygwin/loadavg.cc
> +++ b/winsup/cygwin/loadavg.cc
> [...]
> +    /* Delay a short time so PdhCQD in caller will have data to collect */
> +    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */

Is there a reason you specificially chose 16 msecs here?

I'm asking because the usual clock tick is roughly 15.x msecs.
Any Sleep() > 0 but < 16 results in a sleep of a single clock tick, i.e.,
15 ms.  Occassionally 2 ticks, ~31 msecs, 1 to 5 out of 100 runs.

If you choose a value of 15 msecs, the probability of a Sleep() taking
two ticks is much higher and can be 1 out of 2 Sleep().

If you choose a value of 16 msecs, all Sleep() invocations will run
at least 2 clock ticks.


Thanks,
Corinna
