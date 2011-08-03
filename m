Return-Path: <cygwin-patches-return-7470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4164 invoked by alias); 3 Aug 2011 09:28:26 -0000
Received: (qmail 4098 invoked by uid 22791); 3 Aug 2011 09:28:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 03 Aug 2011 09:27:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DC9A22C059E; Wed,  3 Aug 2011 11:27:43 +0200 (CEST)
Date: Wed, 03 Aug 2011 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110803092743.GA1791@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110721103735.GJ15150@calimero.vinschen.de> <1311274281.6192.3.camel@YAAKOV04> <20110731082430.GA23564@calimero.vinschen.de> <1312258171.3500.6.camel@YAAKOV04> <20110802154240.GB5647@calimero.vinschen.de> <1312352413.2316.16.camel@YAAKOV04> <20110803074512.GA22913@calimero.vinschen.de> <1312363184.6228.3.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1312363184.6228.3.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00046.txt.bz2

On Aug  3 04:19, Yaakov (Cygwin/X) wrote:
> On Wed, 2011-08-03 at 09:45 +0200, Corinna Vinschen wrote:
> > On Aug  3 01:20, Yaakov (Cygwin/X) wrote:
> > > On Tue, 2011-08-02 at 17:42 +0200, Corinna Vinschen wrote:
> > > > Does that mean the return value from NtQueryTimer is unreliable?
> > > > In what way is it wrong?  
> > > 
> > > I'm not sure.  When I run an STC (attached), it works as expected.  In
> > > cancelable_wait(), however, it returns the negative system uptime.  Is
> > > Cygwin doing something to make this occur?
> > 
> > That sounds weird.  How should Cygwin influence what an independent OS
> > function returns?  And you sure it's the system uptime?  Wow.
> 
> Never mind, I figured it out.  The difference is the timeout to
> WaitFor*Object*(); my STC doesn't allow the timer to finish, but
> cancelable_wait() does with the INFINITE timeout.  If there is time
> remaining, as in the STC, then TIMER_BASIC_INFORMATION.TimeRemaining
> contains just that (as a positive).  If the timer has signalled, then
> instead of zero, it appears to provide when it was signalled (system
> uptime, as a negative).

This is cool.  Does it match the tickcount as returned by
hires_ms::timeGetTime_ns()?  If so, it sounds like the return value from
NtQueryTimer *after* the NtCancelTimer call would be usable and probably
more reliable than calling NtQueryTimer first, then NtCancelTimer.

What do you think?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
