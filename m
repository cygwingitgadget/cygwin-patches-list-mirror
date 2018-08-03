Return-Path: <cygwin-patches-return-9162-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113971 invoked by alias); 3 Aug 2018 12:00:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113905 invoked by uid 89); 3 Aug 2018 12:00:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1885
X-HELO: lb1-smtp-cloud7.xs4all.net
Received: from lb1-smtp-cloud7.xs4all.net (HELO lb1-smtp-cloud7.xs4all.net) (194.109.24.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 12:00:02 +0000
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:216])	by smtp-cloud7.xs4all.net with ESMTPA	id lYkSf7Jie6brUlYkSfCvDh; Fri, 03 Aug 2018 14:00:00 +0200
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136]) by webmail.xs4all.nl with HTTP (HTTP/1.1 POST); Fri, 03 Aug 2018 14:00:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Aug 2018 12:00:00 -0000
From: Houder <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
In-Reply-To: <20180803103917.GC6347@calimero.vinschen.de>
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl> <20180803073647.GA6347@calimero.vinschen.de> <213765cb4acd51f933201d759e2752a7@xs4all.nl> <20180803103917.GC6347@calimero.vinschen.de>
Message-ID: <9d3b0bda096f6b7dbf5d7dd07eeb05e6@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00057.txt.bz2

On 2018-08-03 12:39, Corinna Vinschen wrote:
> On Aug  3 11:27, Houder wrote:
>> On 2018-08-03 09:36, Corinna Vinschen wrote:
[snip]

>> > In terms of x86_64, do we have to change the fenv stuff completely
>> > to use only SSE opcodes?  Does that make sense at all?
>> 
>> Ho! I have to disappoint you here! I am not an expert at all.
> 
> Thanks all the same for your detailed description.  A quick search in
> glibc shows that x86_64 FP exceptions in fact work somewhat different 
> in
> that it additionally reads and writes from the SSE control register,
> e.g. sysdeps/x86_64/fpu/fesetenv.c:
> 
>     __asm__ ("fnstenv %0\n"
>            "stmxcsr %1" : "=m" (*&temp), "=m" (*&temp.__mxcsr));
>     [...]
>       __asm__ ("fldenv %0\n"
>            "ldmxcsr %1" : : "m" (temp), "m" (temp.__mxcsr));

? ... uhm, this also happens in Korn's implementation (Cygwin). Only
Dave Korn verifies if SSE is present (does the machine have SSE?).

Both implementations both manage SSE and x87 FPU simultaneously.

For instance fetestexcept(), i.e. show me the status flags, return

     status flag in SSE | status flag in x87 FPU
(bit-wise "OR" of both "status registers")

Both Korn and Jaeger try to hide that there are in fact two devices
that do "floating-point".

Can gcc generate code for both devices at the same time? Possibly!

Did it in case of my _tiny_ STC? ("double d = 1.0; long l = d + 0.4")

No (as far as I tell).

On Linux and Cygwin 64-bits, the SSE was used. On WoW the x87 FPU was
used.

As far as I tell, it is neither the machine nor "fenv" that devices
to switch from x87 FPU to SSE ...

Why gcc prefers x87 FPU in case of WoW, I cannot tell (Yes, I a bit
outspoken here; though that is my hypothesis).

Regards,
Henri

> If you're still interested in this stuff, feel free to create more
> patches :)
> 
> 
> Thanks,
> Corinna
