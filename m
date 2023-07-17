Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EC7D13858D28; Mon, 17 Jul 2023 14:21:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC7D13858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689603719;
	bh=3Q04xXb3LSWvZ9+eB+EsjugXl3g5Y/5vWu+GV1BHfv4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QF3mwJd56s+2BsQCQUI/GO5vKBTjQiyAEMnv7z1812ZenHnqbKespYlgfrgqvug4o
	 XGnfTT820zcsg4Zz37g7SgE6cgfnEWgAUwWB40oDrLklf/z59KcPLvwBO9K+Ft3gCB
	 fBA280JHzQdf2hNROpX89f1V754GldqVN2whzpQA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C9C92A80BB0; Mon, 17 Jul 2023 16:21:57 +0200 (CEST)
Date: Mon, 17 Jul 2023 16:21:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Message-ID: <ZLVOhclITbZyDOhF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-9-jon.turney@dronecode.org.uk>
 <ZLA/j6L/tPcqHiG7@calimero.vinschen.de>
 <ZLBEajmAonZGmsqx@calimero.vinschen.de>
 <ZLBIJTlbCtRvYlU9@calimero.vinschen.de>
 <5aa21952-a13d-f304-8b63-18ee4885c308@dronecode.org.uk>
 <ZLGaf8/nWphfbRI9@calimero.vinschen.de>
 <ZLUgZE5ECv+HaAGI@calimero.vinschen.de>
 <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b132e96c-8767-e5b9-1152-c92cd5ad200e@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 17 12:51, Jon Turney wrote:
> On 17/07/2023 12:05, Corinna Vinschen wrote:
> > On Jul 14 20:57, Corinna Vinschen wrote:
> > > What if Cygwin checks for a deferred cancellation in pthread::exit,
> > > too?  It needs to do this by its own, not calling pthread::testcancel,
> > > otherwise we're in an infinite loop.  Since cancel is basically like
> > > exit, just with a PTHREAD_CANCELED return value, the only additional
> > > action would be to set retval to PTHREAD_CANCELED explicitely.
> > 
> > Kind of like this:
> > 
> > diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> > index f614e01c42f6..fceb9bda1806 100644
> > --- a/winsup/cygwin/thread.cc
> > +++ b/winsup/cygwin/thread.cc
> > @@ -546,6 +546,13 @@ pthread::exit (void *value_ptr)
> >     class pthread *thread = this;
> >     _cygtls *tls = cygtls;	/* Save cygtls before deleting this. */
> > +  /* Deferred cancellation still pending? */
> > +  if (canceled)
> > +    {
> > +      WaitForSingleObject (cancel_event, INFINITE);
> > +      value_ptr = PTHREAD_CANCELED;
> > +    }
> > +
> >     // run cleanup handlers
> >     pop_all_cleanup_handlers ();
> > What do you think?
> 
> I mean, by your own interpretation of the standard, this isn't required,
> because we're allowed to take arbitrarily long to deliver the async
> cancellation, and in this case, we took so long that the thread exited
> before it happened, too bad...

True enough!

> It doesn't seem a bad addition,

On second thought...

One thing bugging me is this:

Looking into pthread::cancel we have this order of things:

    // cancel deferred
    mutex.unlock ();
    canceled = true;
    SetEvent (cancel_event);
    return 0; 

The canceled var is set before the SetEvent call.
What if the thread is terminated after canceled is set to true but
before SetEvent is called?

pthread::testcancel claims:

  We check for the canceled flag first. [...]
  Only if the thread is marked as canceled, we wait for cancel_event
  being really set, on the off-chance that pthread_cancel gets
  interrupted before calling SetEvent.

Neat idea to speed up the code, but doesn't that mean we have a
potential deadlock, especially given that pthread::testcancel calls WFSO
with an INFINITE timeout?

And if so, how do we fix this?  Theoretically, the most simple
solution might be to call SetEvent before setting the canceled
variable, but in fact we would have to make setting canceld
and cancel_event an atomic operation.

Another idea is never to wait for an INFINITE time.  Logically, if
canceled is set and cancel_event isn't, the thread just hasn't been
canceled yet.

Any better idea?

> but this turns pthread_exit() into a
> deferred cancellation point as well, so it should be added to the list of
> "an implementation may also mark other functions not specified in the
> standard as cancellation points" in our documentation^W the huge comment in
> threads.cc.

Yes, indeed.


Thanks,
Corinna
