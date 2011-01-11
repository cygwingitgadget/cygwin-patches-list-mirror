Return-Path: <cygwin-patches-return-7148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1050 invoked by alias); 11 Jan 2011 08:11:06 -0000
Received: (qmail 995 invoked by uid 22791); 11 Jan 2011 08:10:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 11 Jan 2011 08:10:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6AFD12CA090; Tue, 11 Jan 2011 09:10:43 +0100 (CET)
Date: Tue, 11 Jan 2011 08:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
Message-ID: <20110111081043.GB8899@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de> <20110110175244.GC10806@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110110175244.GC10806@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q1/txt/msg00003.txt.bz2

On Jan 10 12:52, Christopher Faylor wrote:
> On Mon, Jan 10, 2011 at 01:51:02PM +0100, Corinna Vinschen wrote:
> >On Jan  5 19:50, Jon TURNEY wrote:
> >> 
> >> Currently, for cygcheck -s implies -d.  This seems rather unhelpful.
> >> 
> >> I'm afraid I've lost the thread which inspired this, but in it the reporter
> >> provided cygcheck -svr output as requested, but this did not help diagnose
> >> what ultimately turned out to be the problem, that a DLL was actually an older
> >> version (presumably due to replace-in-use problems)
> >> 
> >> Attached a patch to modify cygcheck so -s no longer implies -d (although -d
> >> can still be used).
> >> 
> >
> >> 
> >> 2011-01-05  Jon TURNEY
> >> 
> >> 	* cygcheck.cc (main): don't imply -d from -s option to cygcheck
> >
> >Looks good to me.  Applied.
> 
> Sorry that I didn't reply to this.  I wasn't 100% convinced that this
> was a good idea since some of the packages show up as having problems
> when they are ok.  I was wondering if that would end up generating more
> (understandably) confused mailing list traffic but I guess, in the end,
> it probably is better to check the validity of the packages for the
> prescribed error reporting technique.

I wasn't quite sure either, but while running cygcheck with Jon's patch
it started to make more sense.  We can also change the docs to ask for
`cygcheck -svrd' output, but I guess we should just wait and see.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
