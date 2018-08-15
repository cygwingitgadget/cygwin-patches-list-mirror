Return-Path: <cygwin-patches-return-9178-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 129516 invoked by alias); 15 Aug 2018 15:04:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 129396 invoked by uid 89); 15 Aug 2018 15:04:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: lb1-smtp-cloud9.xs4all.net
Received: from lb1-smtp-cloud9.xs4all.net (HELO lb1-smtp-cloud9.xs4all.net) (194.109.24.22) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 15:04:32 +0000
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:205])	by smtp-cloud9.xs4all.net with ESMTPA	id pxLafmX0YEJtcpxLafVHbT; Wed, 15 Aug 2018 17:04:30 +0200
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136]) by webmail.xs4all.nl with HTTP (HTTP/1.1 POST); Wed, 15 Aug 2018 17:04:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Aug 2018 15:04:00 -0000
From: Houder <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
In-Reply-To: <20180815145946.GK3747@calimero.vinschen.de>
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl> <20180815145449.GJ3747@calimero.vinschen.de> <20180815145946.GK3747@calimero.vinschen.de>
Message-ID: <447916fc54f9cb8318021dccb6313967@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00073.txt.bz2

On 2018-08-15 16:59, Corinna Vinschen wrote:
> On Aug 15 16:54, Corinna Vinschen wrote:
>> On Aug 15 12:59, J.H. van de Water wrote:
>> > By excluding the denormal-operand exception from FE_ALL_EXCEPT, it will not
>> > be possible anymore to UNmask this exception by means of the API defined by
>> > /usr/include/fenv.h
>> >
>> > Note: terminology has changed since IEEE Std 854-1987; denormalized numbers
>> > are called subnormal numbers nowadays.
>> >
>> > This modification has basically been motivated by the fact that it is also
>> > not possible on Linux to manipulate the denormal-operand exception by means
>> > of the interface as defined by /usr/include/fenv.h. This has been the state
>> > of affairs on Linux since 2001 (Andreas Jaeger).
>> >
>> > The exceptions required by the standard (IEEE Std 754), in case they can be
>> > supported by the implementation, are:
>> > FE_INEXACT, FE_UNDERFLOW, FE_OVERFLOW, FE_DIVBYZERO and FE_INVALID.
>> >
>> > Although it is allowed to define additional exceptions, there is no reason
>> > to support the "denormal-operand exception" in this case (fenv.h), because
>> > the subnormal numbers can be handled almost as fast the normalized numbers
>> > by the hardware of the x86/x86_64 architecture. Said differently, a reason
>> > to trap on the input of subnormal numbers does not exist. At least that is
>> > what William Kahan and others at Intel asserted around 2000.
>> > (that is William Kahan of the K-C-S draft, the precursor to the standard)
>> >
>> > This commit modifies winsup/cygwin/include/fenv.h as follows:
>> >  - redefines FE_ALL_EXCEPT from 0x3f to 0x3d
>> >  - removes the definition for FE_DENORMAL
>> >  - introduces __FE_DENORM (0x2) (enum in Linux also uses __FE_DENORM)
>> >  - introduces FE_ALL_EXCEPT_X86 (0x3f), i.e. ALL x86/x86_64 FP exceptions
>> 
>> Shouldn't FE_ALL_EXCEPT_X86 be defined locally in fenv.cc only?
>> I don't see that Linux exports that definition.
> 
> Never mind, I just realize it's underscored so it's internal anyway.

Not withstanding, you were correct in your last message!

Henri
