Return-Path: <cygwin-patches-return-6739-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30790 invoked by alias); 7 Oct 2009 07:52:55 -0000
Received: (qmail 30770 invoked by uid 22791); 7 Oct 2009 07:52:53 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 07:52:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3588B6D5598; Wed,  7 Oct 2009 09:52:39 +0200 (CEST)
Date: Wed, 07 Oct 2009 07:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix tcgetpgrp output
Message-ID: <20091007075239.GB27186@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091006090853.GJ12789@calimero.vinschen.de> <20091006182424.GE18135@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091006182424.GE18135@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00070.txt.bz2

On Oct  6 14:24, Christopher Faylor wrote:
> On Tue, Oct 06, 2009 at 11:08:53AM +0200, Corinna Vinschen wrote:
> >Hi,
> >
> >
> >I'd like to have your opinion for this patch before I check it in, since
> >I'm not sure this is the right way to fix it.
> >
> >When I debugged the luit/tcsh problem yesterday, I found that the
> >tcgetpgrp function does not behave as advertised.
> >
> >Per POSIX, the tcgetpgrp function returns the pgrp ID only if the file
> >descriptor references the controlling tty of the process.  If the
> >process has no ctty, or if the descriptor references another tty not
> >being the controlling tty, the function is supposed to set errno to
> >ENOTTY and return -1.
> 
> Ouch.  I can't believe that behavior has lasted for so long.
> 
> The patch looks good to me.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
