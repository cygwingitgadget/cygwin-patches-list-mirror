Return-Path: <cygwin-patches-return-7453-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13396 invoked by alias); 22 Jul 2011 08:05:37 -0000
Received: (qmail 13344 invoked by uid 22791); 22 Jul 2011 08:05:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 22 Jul 2011 08:04:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5A8E22CAEE8; Fri, 22 Jul 2011 10:04:55 +0200 (CEST)
Date: Fri, 22 Jul 2011 08:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
Message-ID: <20110722080455.GB15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311155453.7796.70.camel@YAAKOV04> <20110720141125.GA15232@calimero.vinschen.de> <1311199441.6248.9.camel@YAAKOV04> <1311214958.7552.24.camel@YAAKOV04> <20110721092105.GG15150@calimero.vinschen.de> <20110721093554.GH15150@calimero.vinschen.de> <1311274765.6192.10.camel@YAAKOV04> <20110721190910.GU15150@calimero.vinschen.de> <20110721191521.GW15150@calimero.vinschen.de> <1311316444.6192.46.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311316444.6192.46.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00029.txt.bz2

On Jul 22 01:34, Yaakov (Cygwin/X) wrote:
> On Thu, 2011-07-21 at 21:15 +0200, Corinna Vinschen wrote:
> > On Jul 21 21:09, Corinna Vinschen wrote:
> > > On Jul 21 13:59, Yaakov (Cygwin/X) wrote:
> > > Good idea.  The value can be immediately used in NtSetTimer and it
> > > can be used for testing.
> > 
> > Erm... maybe PLARGE_INTEGER would be the right type for this?
> 
> You're right, that would also allow it to be used as an in/out variable
> to get the remaining time back in nanosleep().
> 
> I'm most of the way there now, but I've got a busy weekend ahead, so I
> probably won't be finished with this until at least Monday.

No worries.  This is worth waiting for :)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
