Return-Path: <cygwin-patches-return-6988-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4647 invoked by alias); 26 Feb 2010 10:04:26 -0000
Received: (qmail 4627 invoked by uid 22791); 26 Feb 2010 10:04:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 26 Feb 2010 10:04:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 605CA6D42F5; Fri, 26 Feb 2010 11:04:17 +0100 (CET)
Date: Fri, 26 Feb 2010 10:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
Message-ID: <20100226100417.GY5683@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B875901.6010906@users.sourceforge.net>  <20100226052655.GA22741@ednor.casa.cgf.cx>  <4B87616D.7050602@users.sourceforge.net>  <4B876413.8040800@users.sourceforge.net>  <20100226092035.GB8489@calimero.vinschen.de>  <4B8796E6.5010202@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B8796E6.5010202@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00104.txt.bz2

On Feb 26 03:39, Yaakov S wrote:
> On 2010-02-26 03:20, Corinna Vinschen wrote:
> >On Feb 26 00:02, Yaakov S wrote:
> >>Corresponding patch for doc/new-features.sgml attached.
> >Please apply.
> 
> Committed.
> 
> >>And how should I handle the kill(1) section of utils/utils.sgml?
> >
> >-v?
> 
> 1) Replace SIGLOST with SIGPWR, since only the latter will show up
> by 'kill -l'?
> 
> 2) Add SIGPWR to SIGLOST since they have different strings, but what
> about SIGIO or SIGCLD which are also synonyms but not listed?
> 
> 3) Add SIGPWR as a parenthetical note to SIGLOST?

Replace SIGLOST with SIGPWR, add SIGLOST as parenthetical note to SIGPWR,
add SIGIO an SIGCLD.

No, really, whatever you think is best.  Documentation is hell and
there can never be enough anyway.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
