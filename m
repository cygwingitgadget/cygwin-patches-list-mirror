Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E63E63858429; Wed, 12 Mar 2025 15:37:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E63E63858429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741793872;
	bh=rZF9ayrRnXXqtHfSlPceV8uaNCn1VvqwpABdlPh0/zk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ybgHSlYXTsJwZVc8Tj8UKxwyW858l8nn//uVGxy0lqmh82jxN3IWroAO/kv//hQDB
	 cGMNU2qO7lB3SPwzBO/5VxZE4PVnqc2h+0F4M0F2u5ZqfnTmOiabpy8Z7Pn2nKKA+P
	 OZ6n0/nMvlCzTvhEF44G/w+cFLlRmEz/DaIkIfGs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 91267A8066D; Wed, 12 Mar 2025 16:37:41 +0100 (CET)
Date: Wed, 12 Mar 2025 16:37:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/6] Cygwin: signal: Redesign signal queue handling
Message-ID: <Z9GqRY2Z4wjsxi3F@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
 <20250312032748.233077-2-takashi.yano@nifty.ne.jp>
 <Z9Fs_Dyagj26Jszv@calimero.vinschen.de>
 <20250313000837.26b0c5a4ba4185647544dc4e@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313000837.26b0c5a4ba4185647544dc4e@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 13 00:08, Takashi Yano wrote:
> On Wed, 12 Mar 2025 12:16:12 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Mar 12 12:27, Takashi Yano wrote:
> > > The previous implementation of the signal queue behaves as:
> > > 1) Signals in the queue are processed in a disordered manner.
> > > 2) If the same signal is already in the queue, new signal is discarded.
> > > 
> > > Strictly speaking, these behaviours do not violate POSIX. However,
> > > these could be a cause of unexpected behaviour in some software. In
> > > Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
> > > behave like that.
> > > This patch prevents SIGKILL, SIGSTOP, SIGCONT, and SIGRT* from that
> > > issue. Moreover, if SA_SIGINFO is set in sa_flags, the signal is
> > > treated almost as the same.
> > > 
> > > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> > > Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> > > Reported by: Christian Franke <Christian.Franke@t-online.de>
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Christian Franke <Christian.Franke@t-online.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/sigproc.cc | 128 ++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 106 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > > index 8739f18f5..ab3acfd24 100644
> > > --- a/winsup/cygwin/sigproc.cc
> > > +++ b/winsup/cygwin/sigproc.cc
> > > @@ -21,6 +21,7 @@ details. */
> > >  #include "cygtls.h"
> > >  #include "ntdll.h"
> > >  #include "exception.h"
> > > +#include <assert.h>
> > >  
> > >  /*
> > >   * Convenience defines
> > > @@ -28,6 +29,10 @@ details. */
> > >  #define WSSC		  60000	// Wait for signal completion
> > >  #define WPSP		  40000	// Wait for proc_subproc mutex
> > >  
> > > +#define PIPE_DEPTH _NSIG /* Historically, the pipe size is _NSIG packet */
> > > +#define SIGQ_ROOM 4
> > > +#define SIGQ_DEPTH (PIPE_DEPTH + SIGQ_ROOM)
> > 
> > I'm missing a comment here.  Why adding SIGQ_ROOM?
> 
> First, I thought signal queue length must be larger than pipe size
> to send __SIGFLUSHFAST safely. However, on second thought, it is
> not enough for some cases while it is not necessary for other cases.
> [PATCH v3 4/6] Cygwin: signal: Do not send __SIGFLUSHFAST if the pipe/queue is full
> ensure the safety for sending __SIGFLUSHFAST.
> 
> > Other than that, LGTM.
> 
> Thanks for reviewing.
> I would be happy if you could review also [PATCH v3 2/6]-[PATCH v3 6/6].

I did, sorry.  They all LGTM, too.  I'm a bit put off by having to add
two events and one mutex to accomplish a safe __SIGFLUSHFAST (rather
hoping a single semaphore would do the trick), but I see how you use the
objects and it makes sense to me.

> > In terms of the queue size, I wonder if we really have to restrict the
> > queue to a small number of queued signals, 69 right now.  The pipe used
> > for communication will take 64K, one allocation granularity slot, anyway.
> > Linux, for instance, queues more than 60K signals.
> > 
> > So, wouldn't it make sense to raise the queu depth to some higher
> > value and the pipe size so that it it's <= 64K?
> > 
> > While looking into your patch, it occured to me that we have a
> > long-standing bug: We never changed __SIGQUEUE_MAX/SIGQUEUE_MAX in
> > include/cygwin/limits.h when we started to support 64 signals (we only
> > did that for 64 bit Cygwin).
> > 
> > We can't change that for existing binaries actually referring the
> > SIGQUEUE_MAX macro, but we should change this, so that
> > sysconf( _SC_SIGQUEUE_MAX) returns the right value, isn't it?
> 
> I don't understand what you are concious of. If we change the value
> of SIGQUEUE_MAX, what happens in terms of the binary compatibility?

I don't think we get a problem in terms of binary compat.  Old apps
get a too small value, but I'm not really sure this is a problem at
all.  I was just stumbling over this and found that this should have
been changed to 64 (or 65) already ages ago.


Corinna
