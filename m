Return-Path: <cygwin-patches-return-7466-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10327 invoked by alias); 2 Aug 2011 15:43:27 -0000
Received: (qmail 10202 invoked by uid 22791); 2 Aug 2011 15:43:03 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 02 Aug 2011 15:42:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EB2662CB0C2; Tue,  2 Aug 2011 17:42:40 +0200 (CEST)
Date: Tue, 02 Aug 2011 15:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110802154240.GB5647@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110721103735.GJ15150@calimero.vinschen.de> <1311274281.6192.3.camel@YAAKOV04> <20110731082430.GA23564@calimero.vinschen.de> <1312258171.3500.6.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1312258171.3500.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00042.txt.bz2

On Aug  1 23:09, Yaakov (Cygwin/X) wrote:
> On Sun, 2011-07-31 at 10:24 +0200, Corinna Vinschen wrote:
> > anything new from the clock_nanosleep frontier?
> 
> Sorry, I've been having elusive problems with CVS HEAD that have been
> making it hard to test my patch.
> 
> Here's what I have so far, FWIW.  So far I've found two problems with
> it: the remaining time returned is incorrect, based on testing of
> nanosleep(),

Does that mean the return value from NtQueryTimer is unreliable?  In
what way is it wrong?  Does nanosleep wait too long or not long enough?
If NtQueryTimer is unusable, maybe we should just skip the idea to return
the remaining time from cancelabel_wait and simply use the return
value from hires_ms::timeGetTime_ns() to return the remaining time
from {clock_}nanosleep, kind of like

  LONGLONG remaining = hires_ms::timeGetTime_ns ();
  cancelable_wait();
  LONGLONG remaining = hires_ms::timeGetTime_ns () - start;
  rem->tv_sec = remaining / NSPERSEC;
  rem->tv_nsec = remaining - (rem->tv_sec * NSPERSEC);

> and the pthread_spin chunk doesn't look right (previously
> the timeout would repeat in the while loop, but that won't happen the
> way the waitable timer is set up).

It doesn't look wrong to me, but then again, I didn't test it...
> 
> I'll try to get back to this as soon as I am able to test this properly.
> In the meantime, is there anything obvious I'm missing?

Nothing I can think of.  This looks good.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
