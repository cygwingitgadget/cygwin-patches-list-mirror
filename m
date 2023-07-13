Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 08B7F3858C62; Thu, 13 Jul 2023 18:16:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 08B7F3858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689272209;
	bh=a9BDNpugacLpM87UR1T2oQDJiWEgBkhn9ELCpa6OQfo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WFVJCQscqCpVsmZLysKymopfGZ9NhdHrKH5xvWFQJ4VhLV0MzuT55VsCnEKmOaN6c
	 VhIDNj8XVzQe4R5TVCuM7cKDuX3F/BNbZ1cPcogO0p+Yv3RMAAGoMXELLPeY4ZV+EH
	 kjJQuT1Fl8l1lkj1A/Rh+0dXQDTCWLHTBSrqBI0Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 23B0BA80B9C; Thu, 13 Jul 2023 20:16:47 +0200 (CEST)
Date: Thu, 13 Jul 2023 20:16:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713113904.1752-9-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 12:39, Jon Turney wrote:
> These tests async thread cancellation of a thread that doesn't have any
> cancellation points.
> 
> Unfortunately, since 450f557f the async cancellation silently fails when
> the thread is inside the kernel function Sleep(), so it just exits

I'm not sure how this patch should be the actual culprit.  It only
handles thread priorities, not thread cancellation.  Isn't this rather
2b165a453ea7b or some such?

> normally after 10 seconds. (See the commentary in pthread::cancel() in
> thread.cc, where it checks if the target thread is inside the kernel,
> and silently converts the cancellation into a deferred one)

Nevertheless, I think this is ok to do.  The description of pthread_cancel
contains this:

  Asynchronous cancelability means that the thread can be canceled at
  any time (usually immediately, but the system does not guarantee this).

And

  The above steps happen asynchronously with respect to the
  pthread_cancel() call; the return status of pthread_cancel() merely
  informs the caller whether the cancellation request was successfully
  queued.

So any assumption *when* the cancallation takes place is may be wrong.


Corinna
