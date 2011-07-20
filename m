Return-Path: <cygwin-patches-return-7439-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28721 invoked by alias); 20 Jul 2011 14:12:08 -0000
Received: (qmail 28588 invoked by uid 22791); 20 Jul 2011 14:11:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 20 Jul 2011 14:11:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2B55E2CAE5D; Wed, 20 Jul 2011 16:11:25 +0200 (CEST)
Date: Wed, 20 Jul 2011 14:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110720141125.GA15232@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110720075654.GA3667@calimero.vinschen.de> <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311155453.7796.70.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00015.txt.bz2

On Jul 20 04:50, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-07-20 at 04:16 -0500, Yaakov (Cygwin/X) wrote:
> > On Wed, 2011-07-20 at 09:56 +0200, Corinna Vinschen wrote:
> > > This doesn't look right.  In contrast to nanosleep, clock_nanosleep
> > > is not subsumed under the _POSIX_TIMERS option.  In fact it's the only
> > > function under the _POSIX_CLOCK_SELECTION option.
> > 
> > I did some searching, and there are actually two more:
> > 
> > http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_condattr_getclock.html

As long as it's not implemented, I don't see a problem.

> > 
> > The behaviour of the following functions are also affected by this
> > option:
> > 
> > http://pubs.opengroup.org/onlinepubs/009695399/functions/clock_getres.html
> > http://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_cond_wait.html
> > 
> > (It should be noted that the Clock Selection option was merged into the
> > Base with POSIX.1-2008.)
> > 
> > How should we proceed now?
> 
> Actually, no need to panic, I took a closer look at this, and it's not
> all that hard at all, so I'll go ahead and implement
> pthread_condattr_[gs]etclock() as well.  Just give me a day or two to
> get it done.  In the meantime, I'll proceed with the revised newlib
> patch.

Thanks.

The only problem I see is the fact that a call to clock_settime
influences calls to clock_nanosleep with absolute timeouts(*).

The problem is that we convert absolute timeouts to relative timeouts
and then use the timeout facility of the WFMO function to handle the
timeout for us.  IMO this is neither very reliable, nor is it elegant.

So, here's the question.  Shouldn't we better use waitable timers
to implement this sort of stuff?  Waitable timers are pretty easy to
use, they support relative and absolute timeouts with an accuracy of 100
ns in the API and a real accuracy which only depends on the underlying
HW, and they are especially not subject to the 49.7 days overflow
problem.


Corinna


(*) Does it also influence pthread_cond_timedwait?  This information seems
    to be missing in SUSv4.

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
