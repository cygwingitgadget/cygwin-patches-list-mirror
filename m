Return-Path: <cygwin-patches-return-7759-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4438 invoked by alias); 24 Oct 2012 15:42:41 -0000
Received: (qmail 4427 invoked by uid 22791); 24 Oct 2012 15:42:40 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 24 Oct 2012 15:42:32 +0000
Received: from pool-173-76-43-156.bstnma.fios.verizon.net ([173.76.43.156] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TR36F-000Is6-Qc	for cygwin-patches@cygwin.com; Wed, 24 Oct 2012 15:42:31 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3D07B13C0C7	for <cygwin-patches@cygwin.com>; Wed, 24 Oct 2012 11:42:31 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/tbNeiDtf6Lx3WCya7ZbZg
Date: Wed, 24 Oct 2012 15:42:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch cygwin]: Replace inline-assembler in string.h by C implementation
Message-ID: <20121024154231.GA4261@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZiqULxgATmLT02tvyGM+c=0AOdtvGePggJrWh4dUqEYw@mail.gmail.com> <50880443.2020701@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50880443.2020701@cs.utoronto.ca>
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
X-SW-Source: 2012-q4/txt/msg00036.txt.bz2

On Wed, Oct 24, 2012 at 11:07:47AM -0400, Ryan Johnson wrote:
>On 24/10/2012 5:16 AM, Kai Tietz wrote:
>> Hello,
>>
>> this patch replaces the inline-assember used in string.h by C implementation.
>> There are three reasons why I want to suggest this.  First, the C-code might
>> be optimized further by fixed (constant) arguments.  Secondly, it is
>> architecture
>> independent and so we just need to maintain on code-path.  And as
>> third point, by
>> inspecting generated assembly code produced by compiler out of C code
>> vs. inline-assembler
>> it shows that compiler produces better code.  It handles
>> jump-threading better, and also
>> improves average executed instructions.
>Devil's advocate: better-looking code isn't always faster code.
>
>However, I'm surprised that code was inline asm in the first place -- no 
>special instructions or unusual control flow -- and would not be at all 
>surprised if the compiler does a better job.
>
>Also, the portability issue is relevant now that cygwin is starting the 
>move toward 64-bit support.

Yes, that's exactly why Kai is proposing this.

I haven't looked at the code but I almost always have one response to
a "I want to rewrite a standard function" patches:

Have you looked at other implementations?  The current one was based
on a linux implementation.  A C version of these functions has likely
been written before, possibly even in newlib.  Were those considered?

cgf
