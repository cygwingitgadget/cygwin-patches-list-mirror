Return-Path: <cygwin-patches-return-6501-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22375 invoked by alias); 11 Apr 2009 08:07:52 -0000
Received: (qmail 22364 invoked by uid 22791); 11 Apr 2009 08:07:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Apr 2009 08:07:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 479106D5598; Sat, 11 Apr 2009 10:07:36 +0200 (CEST)
Date: Sat, 11 Apr 2009 08:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090411080736.GA25426@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49E013DC.4030509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E013DC.4030509@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00043.txt.bz2

On Apr 11 04:51, Dave Korn wrote:
> Corinna Vinschen wrote:
> 
> > Good point, I guess.  So, if we all agree on that, I'd suggest to
> > change Dave's patch to the one below.
> 
>   Two hunks went astray in the adjustment, the fixes for INTPTR_Mxx and
> SIZE_MAX still apply because we didn't change their types.
> 
>   Also, Joseph just introduced a new testcase in GCC SVN, and it shows up a
> problem with our definition of WINT_MAX.

What problem exactly?  UINT_MAX not defined?

> 	* include/stdint.h (INTPTR_MIN, INTPTR_MAX):  Add 'L' suffix.
> 	(WINT_MAX):  Add 'U' suffix.

Applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
