Return-Path: <cygwin-patches-return-6581-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17653 invoked by alias); 30 Jul 2009 14:11:25 -0000
Received: (qmail 17638 invoked by uid 22791); 30 Jul 2009 14:11:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 30 Jul 2009 14:11:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 669886D5598; Thu, 30 Jul 2009 16:11:07 +0200 (CEST)
Date: Thu, 30 Jul 2009 14:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix order of dtors problem.
Message-ID: <20090730141107.GJ18621@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A71A45A.10409@gmail.com> <20090730135150.GA31765@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090730135150.GA31765@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q3/txt/msg00035.txt.bz2

On Jul 30 09:51, Christopher Faylor wrote:
> On Thu, Jul 30, 2009 at 02:47:06PM +0100, Dave Korn wrote:
> >
> >  This is the patch I'm currently testing (so far, uneventfully).  I thought I'd
> >send it here for posterity just in case I get squashed by a falling hippo or
> >anything over the weekend.
> >
> >winsup/cygwin/ChangeLog:
> >
> >	* globals.cc (enum exit_states::ES_GLOBAL_DTORS): Delete.
> >	* dcrt0.cc (__main): Schedule dll_global_dtors to run
> >	atexit before global dtors.
> >	(do_exit): Delete test for ES_GLOBAL_DTORS and call to
> >	dll_global_dtors.
> 
> FWIW, this looks fine.

I could simply check it in and create -53 from there...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
