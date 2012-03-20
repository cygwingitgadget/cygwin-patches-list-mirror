Return-Path: <cygwin-patches-return-7624-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18473 invoked by alias); 20 Mar 2012 18:03:59 -0000
Received: (qmail 18207 invoked by uid 22791); 20 Mar 2012 18:03:26 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 20 Mar 2012 18:03:12 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9E3B32C006E; Tue, 20 Mar 2012 19:03:09 +0100 (CET)
Date: Tue, 20 Mar 2012 18:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix possible infinite loop in hires_ms::timeGetTime_ns()
Message-ID: <20120320180309.GF18032@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F68C2DA.8050909@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F68C2DA.8050909@t-online.de>
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
X-SW-Source: 2012-q1/txt/msg00047.txt.bz2

On Mar 20 18:48, Christian Franke wrote:
> ntdll.h:SharedUserData misses a volatile qualifier. This (at least)
> may result in an infinite loop in hires_ms::timeGetTime_ns().
> Fortunately this could only happen if LowPart wraps around during
> the function call.
> 
> Generated code:
> 
> $ objdump -d -C times.o
> ...
> 1160 <hires_ms::timeGetTime_ns()>:
> 1160: 55                 push   %ebp
> 1161: 8b 15 0c 00 fe 7f  mov    0x7ffe000c,%edx
> 1167: 3b 15 10 00 fe 7f  cmp    0x7ffe0010,%edx
> 116d: 89 e5              mov    %esp,%ebp
> 116f: a1 08 00 fe 7f     mov    0x7ffe0008,%eax
> 1174: 75 02              jne    1178 <hires_ms::timeGetTime_ns()+0x18>
> 1176: 5d                 pop    %ebp
> 1177: c3                 ret
> 1178: eb fe              jmp    1178 <hires_ms::timeGetTime_ns()+0x18>
> ...
> 
> 
> This function results in the same code:
> 
> LONGLONG hires_ms::timeGetTime_ns ()
> {
>   LARGE_INTEGER t;
>   t.HighPart = SharedUserData.InterruptTime.High1Time;
>   t.LowPart = SharedUserData.InterruptTime.LowPart;
>   if (t.HighPart == SharedUserData.InterruptTime.High2Time)
>     return t.QuadPart;
> 
>   for (;;)
>     ;
> }

Wow, thanks a lot for figuring this out and the patch.  This could
explain some spurious hangs.  Patch applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
