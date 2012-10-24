Return-Path: <cygwin-patches-return-7758-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5085 invoked by alias); 24 Oct 2012 15:07:53 -0000
Received: (qmail 5068 invoked by uid 22791); 24 Oct 2012 15:07:51 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,KHOP_RCVD_UNTRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_NO,RP_MATCHES_RCVD,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from bureau61.ns.utoronto.ca (HELO bureau61.ns.utoronto.ca) (128.100.132.151)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 24 Oct 2012 15:07:41 +0000
Received: from [192.168.0.100] (75-119-246-22.dsl.teksavvy.com [75.119.246.22])	(authenticated bits=0)	by bureau61.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id q9OF7cSX007691	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Wed, 24 Oct 2012 11:07:39 -0400
Message-ID: <50880443.2020701@cs.utoronto.ca>
Date: Wed, 24 Oct 2012 15:07:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch cygwin]: Replace inline-assembler in string.h by C implementation
References: <CAEwic4ZiqULxgATmLT02tvyGM+c=0AOdtvGePggJrWh4dUqEYw@mail.gmail.com>
In-Reply-To: <CAEwic4ZiqULxgATmLT02tvyGM+c=0AOdtvGePggJrWh4dUqEYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00035.txt.bz2

On 24/10/2012 5:16 AM, Kai Tietz wrote:
> Hello,
>
> this patch replaces the inline-assember used in string.h by C implementation.
> There are three reasons why I want to suggest this.  First, the C-code might
> be optimized further by fixed (constant) arguments.  Secondly, it is
> architecture
> independent and so we just need to maintain on code-path.  And as
> third point, by
> inspecting generated assembly code produced by compiler out of C code
> vs. inline-assembler
> it shows that compiler produces better code.  It handles
> jump-threading better, and also
> improves average executed instructions.
Devil's advocate: better-looking code isn't always faster code.

However, I'm surprised that code was inline asm in the first place -- no 
special instructions or unusual control flow -- and would not be at all 
surprised if the compiler does a better job.

Also, the portability issue is relevant now that cygwin is starting the 
move toward 64-bit support.

$0.02
Ryan
