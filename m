Return-Path: <cygwin-patches-return-7471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30259 invoked by alias); 3 Aug 2011 09:35:39 -0000
Received: (qmail 30141 invoked by uid 22791); 3 Aug 2011 09:35:38 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gw0-f43.google.com (HELO mail-gw0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Aug 2011 09:35:24 +0000
Received: by gwm11 with SMTP id 11so434076gwm.2        for <cygwin-patches@cygwin.com>; Wed, 03 Aug 2011 02:35:23 -0700 (PDT)
Received: by 10.42.154.193 with SMTP id r1mr1260608icw.55.1312364123193;        Wed, 03 Aug 2011 02:35:23 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id hq1sm936851icc.14.2011.08.03.02.35.21        (version=SSLv3 cipher=OTHER);        Wed, 03 Aug 2011 02:35:22 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 03 Aug 2011 09:35:00 -0000
In-Reply-To: <20110803092743.GA1791@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110721103735.GJ15150@calimero.vinschen.de>	 <1311274281.6192.3.camel@YAAKOV04>	 <20110731082430.GA23564@calimero.vinschen.de>	 <1312258171.3500.6.camel@YAAKOV04>	 <20110802154240.GB5647@calimero.vinschen.de>	 <1312352413.2316.16.camel@YAAKOV04>	 <20110803074512.GA22913@calimero.vinschen.de>	 <1312363184.6228.3.camel@YAAKOV04>	 <20110803092743.GA1791@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1312364136.6228.8.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00047.txt.bz2

On Wed, 2011-08-03 at 11:27 +0200, Corinna Vinschen wrote:
> On Aug  3 04:19, Yaakov (Cygwin/X) wrote:
> > Never mind, I figured it out.  The difference is the timeout to
> > WaitFor*Object*(); my STC doesn't allow the timer to finish, but
> > cancelable_wait() does with the INFINITE timeout.  If there is time
> > remaining, as in the STC, then TIMER_BASIC_INFORMATION.TimeRemaining
> > contains just that (as a positive).  If the timer has signalled, then
> > instead of zero, it appears to provide when it was signalled (system
> > uptime, as a negative).
> 
> This is cool.  Does it match the tickcount as returned by
> hires_ms::timeGetTime_ns()?  If so, it sounds like the return value from
> NtQueryTimer *after* the NtCancelTimer call would be usable and probably
> more reliable than calling NtQueryTimer first, then NtCancelTimer.
> 
> What do you think?

The only thing that uses the remaining time is nanosleep(), which uses a
relative timeout.  Same thing will go for clock_nanosleep(): per POSIX,
rmtp is only returned if TIMER_ABSTIME is not set.  If we only care
about relative remainders, then calling NtQueryTimer first is the
simplest way to go, as in my patch.


Yaakov

