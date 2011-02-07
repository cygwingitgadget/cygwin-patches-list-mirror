Return-Path: <cygwin-patches-return-7169-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14571 invoked by alias); 7 Feb 2011 16:22:53 -0000
Received: (qmail 14533 invoked by uid 22791); 7 Feb 2011 16:22:36 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 07 Feb 2011 16:22:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 283EB2CA2EC; Mon,  7 Feb 2011 17:22:28 +0100 (CET)
Date: Mon, 07 Feb 2011 16:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Crosscompiling configure fix
Message-ID: <20110207162228.GD24247@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7630E3AFCCB3F84AB86B9B1EBF730D536ACF9B01@SERVER.foleyremote.com> <20110207115857.GC24247@calimero.vinschen.de> <20110207152625.GD6611@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110207152625.GD6611@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q1/txt/msg00024.txt.bz2

On Feb  7 10:26, Christopher Faylor wrote:
> On Mon, Feb 07, 2011 at 12:58:57PM +0100, Corinna Vinschen wrote:
> >I'm just wondering why we need this stuff at all.  I mean, is there
> >really any good reason to do the AC_ALLOCA test, and why do we have
> >this AC_TRY_COMPILE test for __builtin_memset?  Both results are not
> >used anywhere, they are just written to config.h and then forgotten.
> >
> >So I take it, we could just drop this stuff.
> >
> >Chris?  What do you say?
> 
> I agree.  Nuke 'em.

Done.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
