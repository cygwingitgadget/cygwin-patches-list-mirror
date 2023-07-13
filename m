Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7B7E13858CDB; Thu, 13 Jul 2023 18:37:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B7E13858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689273452;
	bh=Vm+fOWsiV6d/7wFY3GOZVRFadNZe1d3R/0MrRjjXLfQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=gZD7YY6E9GUf4PK6aoGtV/YjR2LVRT1baP4iIYUB3EbSZKap85OZ3Ji2bNVre3wVD
	 ht37pPo3D//6dYUWvWDEW6nkiXmKmZNCLsGzyNrCqQj6hU/S7SwhROaE5A6WLLsGAj
	 odcPVvsRfXauXWexTiTMR8LyuCToRJwoCEDPWGZQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BBE31A80B9C; Thu, 13 Jul 2023 20:37:30 +0200 (CEST)
Date: Thu, 13 Jul 2023 20:37:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLBEajmAonZGmsqx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 20:16, Corinna Vinschen wrote:
> On Jul 13 12:39, Jon Turney wrote:
> > These tests async thread cancellation of a thread that doesn't have any
> > cancellation points.
> > 
> > Unfortunately, since 450f557f the async cancellation silently fails when
> > the thread is inside the kernel function Sleep(), so it just exits
> 
> I'm not sure how this patch should be the actual culprit.  It only
> handles thread priorities, not thread cancellation.  Isn't this rather
> 2b165a453ea7b or some such?
> 
> > normally after 10 seconds. (See the commentary in pthread::cancel() in
> > thread.cc, where it checks if the target thread is inside the kernel,
> > and silently converts the cancellation into a deferred one)
> 
> Nevertheless, I think this is ok to do.  The description of pthread_cancel
> contains this:
> 
>   Asynchronous cancelability means that the thread can be canceled at
>   any time (usually immediately, but the system does not guarantee this).
> 
> And
> 
>   The above steps happen asynchronously with respect to the
>   pthread_cancel() call; the return status of pthread_cancel() merely
>   informs the caller whether the cancellation request was successfully
>   queued.
> 
> So any assumption *when* the cancallation takes place is may be wrong.

I wonder, though, if we can't come up with a better solution than just
waiting for the next cancellation point.

No solution comes to mind if the user code calls a Win32 function, but
maybe _sigbe could check if the thread's cancel_event is set?  It's all
in assembler, that complicates it a bit, but that would make it at least
working for POSIX functions which are no cancellation points.


Corinna
