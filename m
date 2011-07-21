Return-Path: <cygwin-patches-return-7450-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29906 invoked by alias); 21 Jul 2011 19:09:49 -0000
Received: (qmail 29839 invoked by uid 22791); 21 Jul 2011 19:09:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 19:09:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 94B1B2CAEA5; Thu, 21 Jul 2011 21:09:10 +0200 (CEST)
Date: Thu, 21 Jul 2011 19:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
Message-ID: <20110721190910.GU15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110720075654.GA3667@calimero.vinschen.de> <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04> <20110720141125.GA15232@calimero.vinschen.de> <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04> <20110721092105.GG15150@calimero.vinschen.de> <20110721093554.GH15150@calimero.vinschen.de> <1311274765.6192.10.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311274765.6192.10.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00026.txt.bz2

On Jul 21 13:59, Yaakov (Cygwin/X) wrote:
> On Thu, 2011-07-21 at 11:35 +0200, Corinna Vinschen wrote:
> > On Jul 21 11:21, Corinna Vinschen wrote:
> > > No, you're not at all off-base.  Personally I'd prefer to use the native
> > > NT timer functions, but that's not important.
> 
> No problem, that's something I keep forgetting about.
> 
> > > What I'm missing is a way to specify relative vs. absolute timeouts in
> > > your above sketch.  I guess we need a flag argument as well.
> 
> Working on this last night, I decided to make the timeout a LONGLONG of
> 100ns units instead, positive for absolute and negative for relative.

Good idea.  The value can be immediately used in NtSetTimer and it
can be used for testing.

> > Btw., if you call NtQueryTimer right before NtCancelTimer, then you get
> > the remaining time for free to return to clock_nanosleep.  It would
> > be nice if NtQueryTimer would return the remaining time after calling
> > NtCancelTimer, but my experiments show that some weird value gets
> > returned.  See my attached testcase.  Build with -lntdll.
> 
> Thanks, that was the piece I was missing last night.

Just ignore the bug in the while expression, please...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
