Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 694823858D29; Mon,  4 Nov 2024 10:31:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 694823858D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730716319;
	bh=Hjp/Bf2Rs9HOnvWYkRVyt1YiPjTtw9FSmUG+dB1tQYc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=TRDK1pZsn2BFjcAd4FCf6A4ek3yD3r0xPYnmRxm0E78yTEYXFTefNeRsvNee9sR1+
	 JiJ26TO/NTQWI6mdmiy0yu1NAJmB6cCsPt1/+zk6kF6REv1zVkrrLw/0dEvbJeqMRb
	 awuqpsmZqFcYiHOnQRtq0JyB83yNZa5GnoWRR1vM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CC5EFA80C4D; Mon,  4 Nov 2024 11:31:56 +0100 (CET)
Date: Mon, 4 Nov 2024 11:31:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <ZyiinKXESiXU4AvU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  3 12:15, Christian Franke wrote:
> Mark Geisert wrote:
> > On 10/22/2024 7:45 AM, Corinna Vinschen wrote:
> > > - create a new function like pthread_sigqueue_with_correct_prototype
> > > (heh)
> > > 
> > > - Add this function to cygwin.din as exported symbol
> > > 
> > > - Add a matching entry to NEW_FUNCTIONS in Makefile.am, e.g.,
> > > 
> > >      pthread_sigqueue=pthread_sigqueue_with_correct_prototype,
> > > 
> > > - Implement either pthread_sigqueue_with_correct_prototype calling
> > >    pthread_sigqueue or vice versa, whatever makese more sense.
> > 
> > I appreciate your redirecting me towards an acceptable solution. I've
> > re-implemented the fix as you've indicated but there's one thing I
> > cannot figure out. (BTW I implemented a new pthread_sigqueue_portable()
> > calling existing pthread_sigqueue().)
> > 
> > In cygwin/include/pthread.h, should both function names appear or just
> > pthread_sigqueue? If the latter, which version of prototype? It seems
> > problematic: We want the include file to have the new, portable,
> > prototype for pthread_sigqueue() don't we? Doesn't that require that the
> > original pthread_sigqueue() be renamed to something else and have it
> > call the new pthread_sigqueue()? Maybe that changes one or more of the
> > steps you wrote above?
> 
> If backward compatibility with existing binaries using pthread_sigqueue() is
> desired, I would suggest:
> - Keep functionality and export symbol of the existing pthread_sigqueue().
> - Use a different export symbol for the new function.
> - By default, map the pthread_sigqueue() call to the new symbol.

That's pretty much what I said above, I just tried to explain how
to do that in Cygwin.

> - Invent a #define that allows to use the old function.

We don't need this.  We only want backward compat to keep existing
executables running.  So we need The old and wrong pthread_sigqueue only
as exported symbol.  On recompiling the affected project, the bug
hopefully shows up and can be easily fixed.


Corinna
