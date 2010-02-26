Return-Path: <cygwin-patches-return-6984-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15307 invoked by alias); 26 Feb 2010 09:20:27 -0000
Received: (qmail 15289 invoked by uid 22791); 26 Feb 2010 09:20:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 26 Feb 2010 09:20:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 6FCC36D42F5; Fri, 26 Feb 2010 10:20:19 +0100 (CET)
Date: Fri, 26 Feb 2010 09:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
Message-ID: <20100226092019.GA8489@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B875901.6010906@users.sourceforge.net>  <20100226052655.GA22741@ednor.casa.cgf.cx>  <4B87616D.7050602@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B87616D.7050602@users.sourceforge.net>
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
X-SW-Source: 2010-q1/txt/msg00100.txt.bz2

On Feb 25 23:51, Yaakov S wrote:
> On 2010-02-25 23:26, Christopher Faylor wrote:
> >On Thu, Feb 25, 2010 at 11:15:45PM -0600, Yaakov (Cygwin/X) wrote:
> >>2010-02-25  Yaakov Selkowitz<yselkowitz@users.sourceforge.net>
> >>
> >>	* include/cygwin/signal.h: Define SIGPWR as synonym for SIGLOST.
> >>	* strsig.cc: Ditto.
> >>	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR.
> >
> >Looks good.  Please check in.
> >
> >cgf
> 
> Thanks, committed.  Corresponding patch for doc/new-features.sgml attached.

Please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
