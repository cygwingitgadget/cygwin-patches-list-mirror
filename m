Return-Path: <cygwin-patches-return-7451-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32418 invoked by alias); 21 Jul 2011 19:15:59 -0000
Received: (qmail 32362 invoked by uid 22791); 21 Jul 2011 19:15:40 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 19:15:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4E13C2CAEE8; Thu, 21 Jul 2011 21:15:21 +0200 (CEST)
Date: Thu, 21 Jul 2011 19:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
Message-ID: <20110721191521.GW15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20110720075654.GA3667@calimero.vinschen.de> <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04> <20110720141125.GA15232@calimero.vinschen.de> <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04> <20110721092105.GG15150@calimero.vinschen.de> <20110721093554.GH15150@calimero.vinschen.de> <1311274765.6192.10.camel@YAAKOV04> <20110721190910.GU15150@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110721190910.GU15150@calimero.vinschen.de>
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
X-SW-Source: 2011-q3/txt/msg00027.txt.bz2

On Jul 21 21:09, Corinna Vinschen wrote:
> On Jul 21 13:59, Yaakov (Cygwin/X) wrote:
> > On Thu, 2011-07-21 at 11:35 +0200, Corinna Vinschen wrote:
> > > On Jul 21 11:21, Corinna Vinschen wrote:
> > > > No, you're not at all off-base.  Personally I'd prefer to use the native
> > > > NT timer functions, but that's not important.
> > 
> > No problem, that's something I keep forgetting about.
> > 
> > > > What I'm missing is a way to specify relative vs. absolute timeouts in
> > > > your above sketch.  I guess we need a flag argument as well.
> > 
> > Working on this last night, I decided to make the timeout a LONGLONG of
> > 100ns units instead, positive for absolute and negative for relative.
> 
> Good idea.  The value can be immediately used in NtSetTimer and it
> can be used for testing.

Erm... maybe PLARGE_INTEGER would be the right type for this?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
