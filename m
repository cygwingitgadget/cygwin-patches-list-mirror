Return-Path: <cygwin-patches-return-6919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1694 invoked by alias); 14 Jan 2010 18:52:25 -0000
Received: (qmail 1684 invoked by uid 22791); 14 Jan 2010 18:52:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 18:52:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A2F026D417D; Thu, 14 Jan 2010 19:52:10 +0100 (CET)
Date: Thu, 14 Jan 2010 18:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC, take 2
Message-ID: <20100114185210.GI14511@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100114163556.GF14511@calimero.vinschen.de>  <20100114165401.GG9964@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100114165401.GG9964@ednor.casa.cgf.cx>
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
X-SW-Source: 2010-q1/txt/msg00035.txt.bz2

On Jan 14 11:54, Christopher Faylor wrote:
> On Thu, Jan 14, 2010 at 05:35:56PM +0100, Corinna Vinschen wrote:
> >Hi,
> >
> >here's the next iteration of the patch.  It takes the comments to the
> >first iteration into account, adds the pipe2 call, and uses O_CLOEXEC in
> >the POSIX IPC foo_open calls.  I also ran all three testcases provided
> >by Eric as well as a handcrafted test for open, which I created from the
> >pipe2 testcase.  All tests ran successfully.
> >
> >I'd appreciate another review.
> 
> Ship it!

Done.


Thanks for the review,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
