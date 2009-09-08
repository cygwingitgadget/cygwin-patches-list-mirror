Return-Path: <cygwin-patches-return-6616-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21554 invoked by alias); 8 Sep 2009 19:17:35 -0000
Received: (qmail 19867 invoked by uid 22791); 8 Sep 2009 19:17:17 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 08 Sep 2009 19:17:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A4C286D55B9; Tue,  8 Sep 2009 21:16:57 +0200 (CEST)
Date: Tue, 08 Sep 2009 19:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
Message-ID: <20090908191657.GA17515@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090903T175736-252@post.gmane.org> <4AA01449.6060707@byu.net> <20090903191856.GB3998@ednor.casa.cgf.cx> <20090903210438.GA25677@calimero.vinschen.de> <20090907200539.GA4489@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090907200539.GA4489@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00070.txt.bz2

On Sep  7 16:05, Christopher Faylor wrote:
> On Thu, Sep 03, 2009 at 11:04:38PM +0200, Corinna Vinschen wrote:
> >Thanks for the patches Eric, but, here's a problem.  We still have no
> >copyright assignment in place from you.  The fcntl patch is barely
> >trivial, but the faccessat patch certainly isn't anymore.  Would it
> >be a big problem for you to send the filled out copyright assignemnt form
> >from http://cygwin.com/assign.txt to Red Hat ASAP?  With any luck it
> >will have arrived and will be signed before I'm back from vacation.
> 
> I don't understand why this isn't considered trivial but a basically
> equivalent change to fix other errnos is:
> 
> http://cygwin.com/ml/cygwin/2009-09/msg00178.html

It's 2 vs. 30 lines of changes.  That's hardly equivalent.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
