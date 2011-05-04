Return-Path: <cygwin-patches-return-7294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7164 invoked by alias); 4 May 2011 08:57:14 -0000
Received: (qmail 6740 invoked by uid 22791); 4 May 2011 08:56:39 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 04 May 2011 08:56:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E8C012C0578; Wed,  4 May 2011 10:56:21 +0200 (CEST)
Date: Wed, 04 May 2011 08:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: locale initialization issue
Message-ID: <20110504085621.GA1700@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BANLkTi=XnXKSa4B1j3C=Zi_fu6fw7pKSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BANLkTi=XnXKSa4B1j3C=Zi_fu6fw7pKSBA@mail.gmail.com>
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
X-SW-Source: 2011-q2/txt/msg00060.txt.bz2

On May  4 07:04, Andy Koppe wrote:
> Hi,
> 
> I stumbled across an issues with locale initialization when the "C"
> locale is specified in the environment.
> [...]
> The attached small patch addresses this by starting with the LC_CTYPE
> locale set to "C.UTF-8"  and lc_ctype_charset set accordingly too.
> This means that setting the "C" locale is recognised as a change and
> that the conversion function pointers are updated accordingly. It also
> has the happy side effect that the setlocale call from
> initial_setlocale() will be short-circuited if the default "C.UTF-8"
> locale has not been overridden in the environment.
> 
> Additionally, I think it's time to drop the "temporarily" #if 0'd code
> for making UTF-8 the charset for the "C" locale.
> 
> It's a newlib patch, but it's entirely Cygwin-specific, so it seemed
> more appropriate to send it here.
> 
> 	* libc/locale/locale.c [__CYGWIN__]
> 	(current_categories, lc_ctype_charset): Start with the LC_CTYPE locale
> 	set to "C.UTF-8", to match initial __wctomb and __mbtowc settings.
> 	(lc_message_charset, loadlocale): Settle on ASCII as the "C" charset.

Thanks, applied with a slightly different ChangeLog entry.

Please send newlib patches to the newlib list, not to cygwin-patches.
It's the better place for bookkeeping of newlib stuff, even if it
only affects Cygwin.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
