Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 97F473858D28; Mon, 17 Jul 2023 14:04:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 97F473858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689602645;
	bh=oDYVY5PMFrOjr09PhfJAO+cf30ty7dSFhC0yBGeOK8c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KB0tcD5HWwFaAHj0BiiJdD3uvfYNeMx4mDIvPhBAXy3syPpMuleMyUKVe0YwTnN9w
	 b5Vxk5AwuT96Lg68uqkYrI6z6qvGWfVXZRpUJrBovfo7YIAV0Tdluip4dPZeNeCLmh
	 ABiZ79gtcOMVWhnlPb0P27dQslT40aPNKrsSlUsU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B196DA80BB0; Mon, 17 Jul 2023 16:04:03 +0200 (CEST)
Date: Mon, 17 Jul 2023 16:04:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLVKU26aNI5oKpQF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <8a504ebe-9ce0-867a-f1a3-f38411129019@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a504ebe-9ce0-867a-f1a3-f38411129019@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 17 12:51, Jon Turney wrote:
> On 14/07/2023 14:04, Jon Turney wrote:
> > On 13/07/2023 19:53, Corinna Vinschen wrote:
> > > > > > normally after 10 seconds. (See the commentary in pthread::cancel() in
> > > > > > thread.cc, where it checks if the target thread is inside the kernel,
> > > > > > and silently converts the cancellation into a deferred one)
> > > > > 
> > > > > Nevertheless, I think this is ok to do.  The description of
> > > > > pthread_cancel
> > > > > contains this:
> > > > > 
> > > > >    Asynchronous cancelability means that the thread can be canceled at
> > > > >    any time (usually immediately, but the system does not
> > > > > guarantee this).
> > > > > 
> > > > > And
> > > > > 
> > > > >    The above steps happen asynchronously with respect to the
> > > > >    pthread_cancel() call; the return status of pthread_cancel() merely
> > > > >    informs the caller whether the cancellation request was successfully
> > > > >    queued.
> > > > > 
> > > > > So any assumption *when* the cancallation takes place is may be wrong.
> > 
> > Yeah.
> > 
> > I think the flakiness is when we happen to try to async cancel while in
> > the Windows kernel, which implicitly converts to a deferred
> > cancellation, but there are no cancellation points in the the thread, so
> > it arrives at pthread_exit() and returns a exit code other than
> > PTHREAD_CANCELED.
> > 
> > I did consider making the test non-flaky by adding a final call to
> > pthread_testcancel(), to notice any failed async cancellation which has
> > been converted to a deferred one.
> > 
> > But then that is just the same as the deferred cancellation tests, and
> > confirms the cancellation happens, but not that it's async, which is
> > part of the point of the test.
> > 
> > I guess this could also check that not all of the threads ran for all 10
> > seconds, which would indicate that at least some of them were cancelled
> > asynchronously.
> 
> I wrote this, attached, which does indeed make this test more reliable.
> 
> You point is well made that this is making assumptions about how quickly
> async cancellation works that are not required by the standard
> 
> (It would be a valid, if strange implementation, if async cancellation
> always took 10 seconds to take effect, which this test assumes isn't the
> case)
> 
> Perhaps there is a better way to write a test that async cancellation works
> in the absence of cancellation points, but it eludes me...

Same here, so just go ahead.

Thanks,
Corinna

