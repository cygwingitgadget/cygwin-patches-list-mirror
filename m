Return-Path: <cygwin-patches-return-6478-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22862 invoked by alias); 4 Apr 2009 09:47:47 -0000
Received: (qmail 22844 invoked by uid 22791); 4 Apr 2009 09:47:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 09:47:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 47F056D554C; Sat,  4 Apr 2009 11:47:31 +0200 (CEST)
Date: Sat, 04 Apr 2009 09:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090404094731.GA7383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49D70B05.6020509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D70B05.6020509@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00020.txt.bz2

On Apr  4 08:23, Dave Korn wrote:
> Christopher Faylor wrote:
> 
>   Ah, I could address a bit more to these two questions as well:
> 
> > Isn't a long 32 bits?  What would be the ABI breakage in changing that
> > one typedef rather than lots of #defines?  
> 
>   Yes, a long is 32 bits, but while that makes for binary ABI
> (calling-convention) compatibility it isn't the same thing in the C and C++
> types system.  Therefore the underlying types are an inextricably woven part
> of the overall C-language ABI as well as their physical bit sizes.  Changing
> them certainly has the potential to change the ABI, particularly in C++, but I
> think it also might potentially render some of the compiler's aliasing
> assumptions invalid when linking code using the new definitions against
> objects or libraries using the old.
> 
>   Changing the limits #defines, OTOH, is absolutely guaranteed ABI neutral.
> They really are "just constants" at runtime, and constants don't get mangled
> or alias anything.  So I reckon it's a safer way to proceed and I don't yet
> see any potential 64-bit problems down the line if we leave everything as it
> currently stands.
> 
>   Can you see anything I've overlooked in this analysis?

Sounds right to me.  Given thr LLP64-ness of Win64, it should be no
problem to stick to the types.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
