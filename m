Return-Path: <cygwin-patches-return-6583-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28681 invoked by alias); 30 Jul 2009 15:50:06 -0000
Received: (qmail 28623 invoked by uid 22791); 30 Jul 2009 15:50:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 30 Jul 2009 15:49:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6B5506D5598; Thu, 30 Jul 2009 17:49:39 +0200 (CEST)
Date: Thu, 30 Jul 2009 15:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix order of dtors problem.
Message-ID: <20090730154939.GA6903@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A71A45A.10409@gmail.com> <20090730135150.GA31765@ednor.casa.cgf.cx> <20090730141107.GJ18621@calimero.vinschen.de> <4A71C0CE.9040503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A71C0CE.9040503@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00037.txt.bz2

On Jul 30 16:48, Dave Korn wrote:
> Corinna Vinschen wrote:
> > On Jul 30 09:51, Christopher Faylor wrote:
> >> On Thu, Jul 30, 2009 at 02:47:06PM +0100, Dave Korn wrote:
> >>>  This is the patch I'm currently testing (so far, uneventfully).  I thought I'd
> >>> send it here for posterity just in case I get squashed by a falling hippo or
> >>> anything over the weekend.
> >>>
> >>> winsup/cygwin/ChangeLog:
> >>>
> >>> 	* globals.cc (enum exit_states::ES_GLOBAL_DTORS): Delete.
> >>> 	* dcrt0.cc (__main): Schedule dll_global_dtors to run
> >>> 	atexit before global dtors.
> >>> 	(do_exit): Delete test for ES_GLOBAL_DTORS and call to
> >>> 	dll_global_dtors.
> >> FWIW, this looks fine.
> > 
> > I could simply check it in and create -53 from there...
> > 
> 
>   That sounds like a fairly reasonable way of getting it some wider beta testing
> than I can do on my own.  I think it's likely to all be OK, so how about we
> change the plan to checking it in now and *reverting* it if any problems show up
> by the other side of the weekend?

I've checked it in.  I'm going to create a -53 test release now.
I just need some time to create the announcement.  That's more
work than anything else :-P


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
