Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id AF2164B9DB4D; Thu, 12 Feb 2026 20:36:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AF2164B9DB4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770928587;
	bh=xDg3Vy8PwLwEd16DdPmdqDxUu0a9mEyFpeg5LEhQEag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WlcrE8KffCMIbTyLdy7F/B0lchaFShgSGOkow0r+9sKYGZ1wQgeYSiCx0ecD8JYvv
	 NnrIRjdNatBzoA72LP/t3ykKSRf0fV8WPyrC/79Si5FKQw8NWs4wZzgRcGzjksscnd
	 JJqKWABClWhDnN2YbMkjcN3cxrIol9nD4lPeeIws=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0D950A808B1; Thu, 12 Feb 2026 21:36:25 +0100 (CET)
Date: Thu, 12 Feb 2026 21:36:25 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Message-ID: <aY45yWYgGCvq5fhg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB30827D0112702D609C0D688A9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB30827D0112702D609C0D688A9F64A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

in terms of all three patches you sent on Feb 8, I wonder if this is
the right thing to do.  I know you just want to get it built, but 
doesn't this open up a can of worms?  How easy will it be to miss
one of these places where the compiler warning doesn't occur anymore.

Wouldn't it be better to wait until you can fill these places with
actual code, even if it's a bit harder in the interim?


Thanks,
Corinna


On Feb  8 19:30, Thirumalai Nagalingam wrote:
> Hi,
> 
> This patch adds minimal AArch64 stubs to winsup/cygwin/local_includes/cpuid.h
> to allow the header to compile for the Cygwin AArch64 target.
> 
> 
>   *
> Conditional handling for aarch64 is added alongside the existing x86_64 code.
>   *
> The cpuid() helper returns zeroed values, and can_set_flag()
> is stubbed out for AArch64.
>   *
> No functional CPU feature detection is implemented.
>   *
> The change is intended solely to unblock the AArch64 build and will require
> proper architecture-specific implementations in a follow-up patch.
> 
> Thanks & regards
> Thirumalai Nagalingam
> 
> In-lined patch:
> 
> diff --git a/winsup/cygwin/local_includes/cpuid.h b/winsup/cygwin/local_includes/cpuid.h
> index 6dbb1bddf..238c88777 100644
> --- a/winsup/cygwin/local_includes/cpuid.h
> +++ b/winsup/cygwin/local_includes/cpuid.h
> @@ -13,17 +13,23 @@ static inline void __attribute ((always_inline))
>  cpuid (uint32_t *a, uint32_t *b, uint32_t *c, uint32_t *d, uint32_t ain,
>         uint32_t cin = 0)
>  {
> +#if defined(__x86_64__)
>    asm volatile ("cpuid"
>                 : "=a" (*a), "=b" (*b), "=c" (*c), "=d" (*d)
>                 : "a" (ain), "c" (cin));
> +#elif defined(__aarch64__)
> +  // TODO
> +  *a = *b = *c = *d = 0;
> +#endif
>  }
> 
> -#ifdef __x86_64__
> +#if defined(__x86_64__) || defined(__aarch64__)
>  static inline bool __attribute ((always_inline))
>  can_set_flag (uint32_t long flag)
>  {
>    uint32_t long r1, r2;
> 
> +#if defined(__x86_64__)
>    asm volatile ("pushfq\n"
>                 "popq %0\n"
>                 "movq %0, %1\n"
> @@ -37,6 +43,9 @@ can_set_flag (uint32_t long flag)
>                 : "=&r" (r1), "=&r" (r2)
>                 : "ir" (flag)
>    );
> +#elif defined(__aarch64__)
> +  // TODO
> +#endif
>    return ((r1 ^ r2) & flag) != 0;
>  }
>  #else
> --
> 


