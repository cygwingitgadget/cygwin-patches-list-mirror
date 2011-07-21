Return-Path: <cygwin-patches-return-7449-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28855 invoked by alias); 21 Jul 2011 19:04:14 -0000
Received: (qmail 28779 invoked by uid 22791); 21 Jul 2011 19:03:55 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 21 Jul 2011 19:03:36 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 007CC2CAEA5; Thu, 21 Jul 2011 21:03:33 +0200 (CEST)
Date: Thu, 21 Jul 2011 19:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110721190333.GT15150@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04> <20110721103735.GJ15150@calimero.vinschen.de> <1311274281.6192.3.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311274281.6192.3.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00025.txt.bz2

On Jul 21 13:51, Yaakov (Cygwin/X) wrote:
> On Thu, 2011-07-21 at 12:37 +0200, Corinna Vinschen wrote:
> > Something else occured to me, but I think we should do this in an extra
> > step, if at all.  IMO the family of sleep functions should be moved out
> > of signal.cc into times.cc.  It just seems to belong there.
> 
> I'm not sure what the gain would be.

Only a bit of code cleanup.  The other clock functions are in times.cc
as well.  But, never mind, just ignore these musings.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
