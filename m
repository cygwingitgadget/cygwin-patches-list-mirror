Return-Path: <cygwin-patches-return-7176-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3723 invoked by alias); 10 Feb 2011 09:54:32 -0000
Received: (qmail 3700 invoked by uid 22791); 10 Feb 2011 09:54:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 10 Feb 2011 09:54:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EA2F82CA2C0; Thu, 10 Feb 2011 10:54:15 +0100 (CET)
Date: Thu, 10 Feb 2011 09:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pthread_yield
Message-ID: <20110210095415.GB2305@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1297316998.752.10.camel@YAAKOV04> <20110210060431.GA11820@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110210060431.GA11820@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q1/txt/msg00031.txt.bz2

On Feb 10 01:04, Christopher Faylor wrote:
> On Wed, Feb 09, 2011 at 11:49:58PM -0600, Yaakov (Cygwin/X) wrote:
> >pthread_yield(3) was part of the POSIX.1c drafts but never made it into
> >the final standard.  Nevertheless, it is provided by Linux[1],
> >FreeBSD[2], OpenBSD[3], AIX[4], and possibly other *NIXes.  
> >
> >"On Linux, this function is implemented as a call to sched_yield(2)."
> >Patch attached.
> 
> Please check in.

Two notes:

- We should use the API version bump to 236 for both new functions,
  __xpg_strerror_r as well as pthread_yield.

- Please add the new entry point to doc/new-features.sgml.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
