Return-Path: <cygwin-patches-return-7444-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4838 invoked by alias); 21 Jul 2011 09:21:47 -0000
Received: (qmail 4778 invoked by uid 22791); 21 Jul 2011 09:21:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 09:21:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AC1A12CAE8D; Thu, 21 Jul 2011 11:21:05 +0200 (CEST)
Date: Thu, 21 Jul 2011 09:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
Message-ID: <20110721092105.GG15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110720075654.GA3667@calimero.vinschen.de> <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04> <20110720141125.GA15232@calimero.vinschen.de> <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311214958.7552.24.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00020.txt.bz2

On Jul 20 21:22, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-07-20 at 17:03 -0500, Yaakov (Cygwin/X) wrote:
> > On Wed, 2011-07-20 at 16:11 +0200, Corinna Vinschen wrote:
> > > The only problem I see is the fact that a call to clock_settime
> > > influences calls to clock_nanosleep with absolute timeouts(*).
> 
> However, clock_settime() can set only CLOCK_REALTIME, not
> CLOCK_MONOTONIC, so...
> [...]
> ...therefore we could still handle CLOCK_MONOTONIC timedwait as a
> relative timeout.  So pthread_condattr_[gs]etclock should be correct
> even without this (although it would still gain accuracy), but that does
> leave a problem with clock_nanosleep(TIMER_ABSTIME).
> 
> Looking at the other uses of cancelable_wait(), would the following make
> sense:
> 
> * change the timeout argument to struct timespec *;
> * cancelable_wait (object, INFINITE) calls change to (object, NULL);
> * cancelable_wait (object, DWORD) calls change to (object, &timespec);
> * then in cancelable_wait:
> 
> HANDLE hTimer;
> HANDLE wait_objects[4];
> ....
> wait_objects[num++] = object;
> 
> if (timeout)
>   {
>     LARGE_INTEGER li;
>     li.QuadPart = (timeout->tv_sec * NSPERSEC) + (timeout->tv_nsec /
> 100); /* rounding? */
>     hTimer = CreateWaitableTimer (NULL, FALSE, NULL);
>     SetWaitableTimer (hTimer, &li, 0, NULL, NULL, FALSE); /* handle
> possible error?  what would cause one? */
>     wait_objects[num++] = hTimer;
>   }
> ...
> while (1)
>   {
>     res = WaitForMultipleObjects (num, wait_objects, FALSE, INFINITE);
> ....
> 
> Or am I completely off-base here?

No, you're not at all off-base.  Personally I'd prefer to use the native
NT timer functions, but that's not important.  What I'm missing is a way
to specify relative vs. absolute timeouts in your above sketch.  I guess
we need a flag argument as well.

Other than that, I think we should make sure to create the waitable
timer only once on a per-thread base.  Object creation and deletion is
usually a time consuming process.  So what we could do is to add a
HANDLE "cw_timer" to struct _local_storage in cygtls.h, which gets
inited to NULL in _cygtls::init_thread as well as in
_cygtls::fixup_after_fork.

Then cancelable_wait with a non-NULL timespec would check for the handle
being NULL and create a non-inheritable timer, if so.  All subsequent
calls only set (and cancel) the timer.

Does that sound reasonable?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
