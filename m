Return-Path: <cygwin-patches-return-6471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23125 invoked by alias); 4 Apr 2009 03:36:03 -0000
Received: (qmail 22795 invoked by uid 22791); 4 Apr 2009 03:36:02 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 03:35:55 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 374E713C022 	for <cygwin-patches@cygwin.com>; Fri,  3 Apr 2009 23:35:45 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 29B7B331501; Fri,  3 Apr 2009 23:35:45 -0400 (EDT)
Date: Sat, 04 Apr 2009 03:36:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090404033545.GA3386@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49D6B8D7.4020907@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00013.txt.bz2

On Sat, Apr 04, 2009 at 02:33:11AM +0100, Dave Korn wrote:
>
>    Hi team,
>
>  Upstream GCC just gained the ability to know all about the stdint.h types
>and limits internally.  If you're interested in the background, see
>
>    http://gcc.gnu.org/ml/gcc/2009-04/msg00000.html
>
>and thread for further reading.
>
>  I've submitted the necessary info for the cygwin GCC backend, and now the
>associated testcases show up a few bugs in our stdint.h declarations.
>Basically:-
>
>- uint32_t is "unsigned int", but UINT32_MAX is an unsigned long int constant
>(denoted by the 'UL' suffix).
>- int_least32_t is "long", where INT_LEAST32_MIN and INT_LEAST32_MAX are plain
>(unsuffixed) int constants.
>- int_fast16_t and int_fast32_t are both "long", where INT_FAST16/32_MIN/MAX
>are all plain (unsuffixed) ints.
>- intptr_t is "long" but INTPTR_MIN and INTPTR_MAX lack the "L" suffix and so
>are just ints.
>- size_t is "unsigned int" but the SIZE_MAX constant is unsigned long.
>
>  This is bad because if the value of one of these MIN or MAX limits is not of
>the correct integer type matching the integer type it is used in conjunction
>with, there will be an implicit cast operation anytime you assign the
>wrongly-typed value to a variable of the type for which it is supposed to be
>the limit.
>
>  The attached patch fixes all these by adjusting only the suffix letters.  OK
>for head?
>
>winsup/cygwin/ChangeLog
>
>	* include/stdint.h (UINT32_MAX, INT_LEAST32_MIN, INT_LEAST32_MAX,
>	INT_FAST16_MIN, INT_FAST32_MIN, INT_FAST16_MAX, INT_FAST32_MAX,
>	INTPTR_MIN, INTPTR_MAX, SIZE_MAX):  Fix integer constant suffixes.

Many of the changes introduce divergence from Linux.  Why is that?

cgf
