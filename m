Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 50EDF3858CD1; Fri, 14 Jul 2023 18:57:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 50EDF3858CD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689361026;
	bh=8JL8aZBTyEc51YZ8SbbaszA/f3i+6k14N4ttsBja778=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=vARm44h5VEn0muDkFxDxcua6j7aZls1RdVXCMsf6PaPg8/PMyhL1YCxDWYNjzhlym
	 5jWEu/lyGRkY/G0SfJ8BkMpjTzlAAlNA3J4HMInWi8xbjLQSE4TaRPQKjjOl21FGMF
	 DvB5EGlpD1+1wKAhInP74DV0M4W7xug7l3xb/rTs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CF065A80B9B; Fri, 14 Jul 2023 20:57:03 +0200 (CEST)
Date: Fri, 14 Jul 2023 20:57:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 14 14:04, Jon Turney wrote:
> On 13/07/2023 19:53, Corinna Vinschen wrote:
> > > > Nevertheless, I think this is ok to do.  The description of pthread_cancel
> > > > contains this:
> > > > 
> > > >    Asynchronous cancelability means that the thread can be canceled at
> > > >    any time (usually immediately, but the system does not guarantee this).
> > > > 
> > > > And
> > > > 
> > > >    The above steps happen asynchronously with respect to the
> > > >    pthread_cancel() call; the return status of pthread_cancel() merely
> > > >    informs the caller whether the cancellation request was successfully
> > > >    queued.
> > > > 
> > > > So any assumption *when* the cancallation takes place is may be wrong.
> 
> Yeah.
> 
> I think the flakiness is when we happen to try to async cancel while in the
> Windows kernel, which implicitly converts to a deferred cancellation, but
> there are no cancellation points in the the thread, so it arrives at
> pthread_exit() and returns a exit code other than PTHREAD_CANCELED.

In pthread_join(), right?

> I did consider making the test non-flaky by adding a final call to
> pthread_testcancel(), to notice any failed async cancellation which has been
> converted to a deferred one.
> 
> But then that is just the same as the deferred cancellation tests, and
> confirms the cancellation happens, but not that it's async, which is part of
> the point of the test.

What if Cygwin checks for a deferred cancellation in pthread::exit,
too?  It needs to do this by its own, not calling pthread::testcancel,
otherwise we're in an infinite loop.  Since cancel is basically like
exit, just with a PTHREAD_CANCELED return value, the only additional
action would be to set retval to PTHREAD_CANCELED explicitely.


Corinna
