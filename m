Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 771B93858C5F
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 15:08:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 771B93858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 771B93858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741792122; cv=none;
	b=vS7S4Gs6TfQpTzc8Sh4FEjRXq3uIQftU605gImatQsgo2PxvpTerOWdsmvxqtY5yg2gNwfT9ytUdJSGkkh7VhhGoqwJ+Pq7RfITMPLQvossuYWBOHF+1u5ymD5R+aulpEDuZbaxbBc4jmOUs7TYsYlb25mqrdHThkJc1tcTaXgM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741792122; c=relaxed/simple;
	bh=6VhlYRGvceqThRs3I/mlEk8fkr/th9ElmmmJFc9x73g=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=oaLbgkbcvgC8fUpTvvXFSUnki16hHXRlCS9iN89ek5gC6j7cB75xp7z+PqHr8wwLfNquRxPt0opCTrIEvWXaEOG4lr9RfDGn7XZ8UaS6quZofe95s9gtArgx1fLJJIgRTwRVTXW/kmwtZnLzaomADf2fijqIpeciz8Mr+Se7g/8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 771B93858C5F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=A2Y48gV8
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250312150839552.ZEIB.109987.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 13 Mar 2025 00:08:39 +0900
Date: Thu, 13 Mar 2025 00:08:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/6] Cygwin: signal: Redesign signal queue handling
Message-Id: <20250313000837.26b0c5a4ba4185647544dc4e@nifty.ne.jp>
In-Reply-To: <Z9Fs_Dyagj26Jszv@calimero.vinschen.de>
References: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
	<20250312032748.233077-2-takashi.yano@nifty.ne.jp>
	<Z9Fs_Dyagj26Jszv@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741792119;
 bh=Oldlvo4enRG6tIBJW9z4ZYnzqtrTki1BrRKN2HFzCHA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=A2Y48gV8rMGqgZ+b7ZySkNCSoW1ZU41+rntAXcDAXgSUQ1fos2SSIqfn0TrocZu+hkAwgcwm
 LUepSYZ8aekKfLUj9LUvmlZHox7lI5pUFZTIqepXjdXPf9Z4tp6Xe2LIogS0uP/cx7IIyTJQs+
 wdSjml0U8aQ7pEvbpVfC6FcZk6IG1FAbpp+vUhqFcEFeNv1/8IPXY4McBFrjeCvE3qqg94p4DT
 4xjkPjLO+ftItnux9d2V1QbJML87iceAZtIsg24NkPuxGbCguJHKQ0FKC8E98TnCK3cvZrEhCC
 ANBRs1YIZdZbnWqnK0gWh2ONdWp0fAsuz45BP5HdP7OhuEpA==
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 12 Mar 2025 12:16:12 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Mar 12 12:27, Takashi Yano wrote:
> > The previous implementation of the signal queue behaves as:
> > 1) Signals in the queue are processed in a disordered manner.
> > 2) If the same signal is already in the queue, new signal is discarded.
> > 
> > Strictly speaking, these behaviours do not violate POSIX. However,
> > these could be a cause of unexpected behaviour in some software. In
> > Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
> > behave like that.
> > This patch prevents SIGKILL, SIGSTOP, SIGCONT, and SIGRT* from that
> > issue. Moreover, if SA_SIGINFO is set in sa_flags, the signal is
> > treated almost as the same.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> > Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> > Reported by: Christian Franke <Christian.Franke@t-online.de>
> > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>, Christian Franke <Christian.Franke@t-online.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/sigproc.cc | 128 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 106 insertions(+), 22 deletions(-)
> > 
> > diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> > index 8739f18f5..ab3acfd24 100644
> > --- a/winsup/cygwin/sigproc.cc
> > +++ b/winsup/cygwin/sigproc.cc
> > @@ -21,6 +21,7 @@ details. */
> >  #include "cygtls.h"
> >  #include "ntdll.h"
> >  #include "exception.h"
> > +#include <assert.h>
> >  
> >  /*
> >   * Convenience defines
> > @@ -28,6 +29,10 @@ details. */
> >  #define WSSC		  60000	// Wait for signal completion
> >  #define WPSP		  40000	// Wait for proc_subproc mutex
> >  
> > +#define PIPE_DEPTH _NSIG /* Historically, the pipe size is _NSIG packet */
> > +#define SIGQ_ROOM 4
> > +#define SIGQ_DEPTH (PIPE_DEPTH + SIGQ_ROOM)
> 
> I'm missing a comment here.  Why adding SIGQ_ROOM?

First, I thought signal queue length must be larger than pipe size
to send __SIGFLUSHFAST safely. However, on second thought, it is
not enough for some cases while it is not necessary for other cases.
[PATCH v3 4/6] Cygwin: signal: Do not send __SIGFLUSHFAST if the pipe/queue is full
ensure the safety for sending __SIGFLUSHFAST.

> Other than that, LGTM.

Thanks for reviewing.
I would be happy if you could review also [PATCH v3 2/6]-[PATCH v3 6/6].

> In terms of the queue size, I wonder if we really have to restrict the
> queue to a small number of queued signals, 69 right now.  The pipe used
> for communication will take 64K, one allocation granularity slot, anyway.
> Linux, for instance, queues more than 60K signals.
> 
> So, wouldn't it make sense to raise the queu depth to some higher
> value and the pipe size so that it it's <= 64K?
> 
> While looking into your patch, it occured to me that we have a
> long-standing bug: We never changed __SIGQUEUE_MAX/SIGQUEUE_MAX in
> include/cygwin/limits.h when we started to support 64 signals (we only
> did that for 64 bit Cygwin).
> 
> We can't change that for existing binaries actually referring the
> SIGQUEUE_MAX macro, but we should change this, so that
> sysconf( _SC_SIGQUEUE_MAX) returns the right value, isn't it?

I don't understand what you are concious of. If we change the value
of SIGQUEUE_MAX, what happens in terms of the binary compatibility?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
