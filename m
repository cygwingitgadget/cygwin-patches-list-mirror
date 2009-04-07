Return-Path: <cygwin-patches-return-6491-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14492 invoked by alias); 7 Apr 2009 14:47:29 -0000
Received: (qmail 14153 invoked by uid 22791); 7 Apr 2009 14:47:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 14:47:11 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id AA2BA13C022 	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2009 10:47:00 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 7176C60E37B; Tue,  7 Apr 2009 10:47:00 -0400 (EDT)
Date: Tue, 07 Apr 2009 14:47:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090407144659.GA22338@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49D70B05.6020509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D70B05.6020509@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00033.txt.bz2

On Sat, Apr 04, 2009 at 08:23:49AM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>
>  Ah, I could address a bit more to these two questions as well:
>
>> Isn't a long 32 bits?  What would be the ABI breakage in changing that
>> one typedef rather than lots of #defines?  
>
>  Yes, a long is 32 bits, but while that makes for binary ABI
>(calling-convention) compatibility it isn't the same thing in the C and C++
>types system.  Therefore the underlying types are an inextricably woven part
>of the overall C-language ABI as well as their physical bit sizes.  Changing
>them certainly has the potential to change the ABI, particularly in C++, but I
>think it also might potentially render some of the compiler's aliasing
>assumptions invalid when linking code using the new definitions against
>objects or libraries using the old.
>
>Changing the limits #defines, OTOH, is absolutely guaranteed ABI
>neutral.  They really are "just constants" at runtime, and constants
>don't get mangled or alias anything.  So I reckon it's a safer way to
>proceed and I don't yet see any potential 64-bit problems down the line
>if we leave everything as it currently stands.
>
>Can you see anything I've overlooked in this analysis?

I don't entirely understand when people think it's ok to make sweeping
changes for 1.7 and when they think we need to be conservative.

I think it is very regrettable that Cygwin doesn't have the same int
types as linux and it would be interesting to see how much would be
broken by changing these types.

cgf
