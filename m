Return-Path: <cygwin-patches-return-7134-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27488 invoked by alias); 18 Nov 2010 11:06:38 -0000
Received: (qmail 27465 invoked by uid 22791); 18 Nov 2010 11:06:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 18 Nov 2010 11:06:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8369F6D4272; Thu, 18 Nov 2010 12:06:23 +0100 (CET)
Date: Tue, 07 Dec 2010 20:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CJK ambiguous width for non-Unicode charsets
Message-ID: <20101118110623.GA26213@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <AANLkTik5ugUtdbrk351sA2aXaAk4gv+e66ydrjaRAVPG@mail.gmail.com> <20101116175820.GF32170@calimero.vinschen.de> <AANLkTimoHk_5Sx7goHFHUsqH3whG=d7Wsav6ig3pn+u=@mail.gmail.com> <AANLkTikA9p3x_xfQP8fDssKztVOOj70HQwjAM+7i+VpP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AANLkTikA9p3x_xfQP8fDssKztVOOj70HQwjAM+7i+VpP@mail.gmail.com>
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
X-SW-Source: 2010-q4/txt/msg00013.txt.bz2

On Nov 17 21:46, Andy Koppe wrote:
> Documentation change to go with the newlib patch at
> http://www.cygwin.com/ml/newlib/2010/msg00604.html:
> 
> 	* setup2.sgml (setup-locale-ov): Document CJK ambiguous width change
> 	for non-Unicode charsets.
> 	* new-features.sgml (ov-new1.7.8): Mention CJK ambiguous width change.
> 
> (Btw, "Drop support for Windows NT4 prior to Service Pack 4" appears
> twice in new-features.sgml).

Thanks, applied, including to remove one of the NT4 paragraphs.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
