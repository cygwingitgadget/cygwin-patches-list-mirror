Return-Path: <cygwin-patches-return-9173-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39716 invoked by alias); 15 Aug 2018 14:23:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39548 invoked by uid 89); 15 Aug 2018 14:23:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-24.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham version=3.3.2 spammy=H*u:Webmail, on, on!
X-HELO: lb2-smtp-cloud9.xs4all.net
Received: from lb2-smtp-cloud9.xs4all.net (HELO lb2-smtp-cloud9.xs4all.net) (194.109.24.26) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Aug 2018 14:22:57 +0000
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:205])	by smtp-cloud9.xs4all.net with ESMTPA	id pwhLfm8suEJtcpwhLfV9BY; Wed, 15 Aug 2018 16:22:55 +0200
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136]) by webmail.xs4all.nl with HTTP (HTTP/1.1 POST); Wed, 15 Aug 2018 16:22:55 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Aug 2018 14:23:00 -0000
From: Houder <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Keep the denormal-operand exception masked; modify FE_ALL_EXCEPT accordingly.
In-Reply-To: <20180815115216.GG3747@calimero.vinschen.de>
References: <1534330763-2755-1-git-send-email-houder@xs4all.nl> <20180815115216.GG3747@calimero.vinschen.de>
Message-ID: <b864099bfc8463f205b585ba89a6d507@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00068.txt.bz2

On 2018-08-15 13:52, Corinna Vinschen wrote:
> Hi J.H.,
> 
> thanks for the patch.  Only problem, this patch is non-trivial
> enough to require the BSD waiver per https://cygwin.com/contrib.html,
> see the "Before you get started" section.  I add you to the
> winsup/CONTRIBUTORS file then.  That ok with you?

My patch is non-trivial? (I will hide my surprise from this point on!)

Ok, I have read https://cygwin.com/contrib.html, that is, the "Before 
you get
started" section.

"To do this, just make a public statement that you provide your patches 
to the
  Cygwin sources under the 2-clause BSD license." ...

I hereby provide my patch under said 2-clause BSD license. Is this 
enough?

"You can do that with your first patch submission. After your first 
patch
  has been approved and applied, your name and email address will be 
added
  to the new winsup/CONTRIBUTORS file." ...

Sigh ... Go ahead. (yes, sigh. Usually, I attempt not to reveal my name, 
but
is ok this time).

Regards,
Henri

> Thanks,
> Corinna
> 
> 
> On Aug 15 12:59, J.H. van de Water wrote:
>> By excluding the denormal-operand exception from FE_ALL_EXCEPT, it 
>> will not
>> be possible anymore to UNmask this exception by means of the API 
>> defined by
>> /usr/include/fenv.h
>> 
>> Note: terminology has changed since IEEE Std 854-1987; denormalized 
>> numbers
>> are called subnormal numbers nowadays.
>> 
>> This modification has basically been motivated by the fact that it is 
>> also
>> not possible on Linux to manipulate the denormal-operand exception by 
>> means
>> of the interface as defined by /usr/include/fenv.h. This has been the 
>> state
>> of affairs on Linux since 2001 (Andreas Jaeger).
>> 
>> The exceptions required by the standard (IEEE Std 754), in case they 
>> can be
>> supported by the implementation, are:
>> FE_INEXACT, FE_UNDERFLOW, FE_OVERFLOW, FE_DIVBYZERO and FE_INVALID.
>> 
>> Although it is allowed to define additional exceptions, there is no 
>> reason
>> to support the "denormal-operand exception" in this case (fenv.h), 
>> because
>> the subnormal numbers can be handled almost as fast the normalized 
>> numbers
>> by the hardware of the x86/x86_64 architecture. Said differently, a 
>> reason
>> to trap on the input of subnormal numbers does not exist. At least 
>> that is
>> what William Kahan and others at Intel asserted around 2000.
>> (that is William Kahan of the K-C-S draft, the precursor to the 
>> standard)
>> 
>> This commit modifies winsup/cygwin/include/fenv.h as follows:
>>  - redefines FE_ALL_EXCEPT from 0x3f to 0x3d
>>  - removes the definition for FE_DENORMAL
>>  - introduces __FE_DENORM (0x2) (enum in Linux also uses __FE_DENORM)
>>  - introduces FE_ALL_EXCEPT_X86 (0x3f), i.e. ALL x86/x86_64 FP 
>> exceptions
>> ---
>>  winsup/cygwin/fenv.cc        |  8 +++++---
>>  winsup/cygwin/include/fenv.h | 14 ++++++++------
>>  2 files changed, 13 insertions(+), 9 deletions(-)
>> 
>> diff --git a/winsup/cygwin/fenv.cc b/winsup/cygwin/fenv.cc
>> index 066704b..0067da0 100644
>> --- a/winsup/cygwin/fenv.cc
>> +++ b/winsup/cygwin/fenv.cc
>> @@ -417,7 +417,7 @@ fesetprec (int prec)
>>  void
>>  _feinitialise (void)
>>  {
>> -  unsigned int edx, eax, mxcsr;
>> +  unsigned int edx, eax;
>> 
>>    /* Check for presence of SSE: invoke CPUID #1, check EDX bit 25.  
>> */
>>    eax = 1;
>> @@ -431,11 +431,13 @@ _feinitialise (void)
>>    /* The default cw value, 0x37f, is rounding mode zero.  The MXCSR 
>> has
>>       no precision control, so the only thing to do is set the 
>> exception
>>       mask bits.  */
>> -  mxcsr = FE_ALL_EXCEPT << FE_SSE_EXCEPT_MASK_SHIFT;
>> +
>> +  /* initialize the MXCSR register: mask all exceptions */
>> +  unsigned int mxcsr = __FE_ALL_EXCEPT_X86 << 
>> FE_SSE_EXCEPT_MASK_SHIFT;
>>    if (use_sse)
>>      __asm__ volatile ("ldmxcsr %0" :: "m" (mxcsr));
>> 
>> -  /* Setup unmasked environment.  */
>> +  /* Setup unmasked environment, but leave __FE_DENORM masked.  */
>>    feenableexcept (FE_ALL_EXCEPT);
>>    fegetenv (&fe_nomask_env);
>> 
>> diff --git a/winsup/cygwin/include/fenv.h 
>> b/winsup/cygwin/include/fenv.h
>> index 7ec5d4d..5fdbe5a 100644
>> --- a/winsup/cygwin/include/fenv.h
>> +++ b/winsup/cygwin/include/fenv.h
>> @@ -87,16 +87,18 @@ typedef __uint32_t fexcept_t;
>>  #define FE_OVERFLOW	(1 << 3)
>>  #define FE_UNDERFLOW	(1 << 4)
>> 
>> -/*  This is not defined by Posix, but since x87 supports it we 
>> provide
>> -   a definition according to the same naming scheme used above.  */
>> -#define FE_DENORMAL	(1 << 1)
>> -
>>  /*  The <fenv.h> header shall define the following constant, which is
>>     simply the bitwise-inclusive OR of all floating-point exception
>>     constants defined above:  */
>> 
>> -#define FE_ALL_EXCEPT (FE_DIVBYZERO | FE_INEXACT | FE_INVALID \
>> -			| FE_OVERFLOW | FE_UNDERFLOW | FE_DENORMAL)
>> +/* in agreement w/ Linux the subnormal exception will always be 
>> masked */
>> +#define FE_ALL_EXCEPT \
>> +  (FE_INEXACT | FE_UNDERFLOW | FE_OVERFLOW | FE_DIVBYZERO | 
>> FE_INVALID)
>> +
>> +#define __FE_DENORM	(1 << 1)
>> +
>> +/* mask (= 0x3f) to disable all exceptions at initialization */
>> +#define __FE_ALL_EXCEPT_X86 (FE_ALL_EXCEPT | __FE_DENORM)
>> 
>>  /*  The <fenv.h> header shall define the following constants if and 
>> only
>>     if the implementation supports getting and setting the represented
>> --
>> 2.7.5
