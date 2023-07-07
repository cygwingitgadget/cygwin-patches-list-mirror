Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 07E2338515F4; Fri,  7 Jul 2023 09:44:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 07E2338515F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688723050;
	bh=gIrqCdywGGtYsSq9pbBH7ZbFGqRVsG+84Jwk6YQxZFQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QeIntWXjRL4WBHKh8O3N0zHSDzxPwfXt5bIMvgHzunLD6+s0h1SA08G5458sceQot
	 rwerClQGPSbI9TEMTiQJNE2z4zriBRY6lNvu1e76TmHxX31pEa/qfvqoKP4rMiirj0
	 1FUg4VAx8Vk7mn+izp/eBXpTjiI2E6CboFnehmIc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4E5E2A80BDA; Fri,  7 Jul 2023 11:44:08 +0200 (CEST)
Date: Fri, 7 Jul 2023 11:44:08 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
Message-ID: <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230707074121.7880-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Jul  7 00:41, Mark Geisert wrote:
> The current version of <sys/cpuset.h> cannot be compiled by Clang due to
> the use of __builtin* functions.  Their presence here was a dubious
> optimization anyway, so their usage has been converted to standard
> library functions.  A popcnt (population count of 1 bits in a word)
> function is provided here because there isn't one in the standard library
> or elsewhere in the Cygwin DLL.

And clang really doesn't provide it?  That's unfortunate.

Do you really think it's not worth to use it if it's available?

You could workaround it like this:

> +/* Modern CPUs have popcnt* instructions but the need here is not worth
> + * worrying about builtins or inline assembler for different compilers. */ 
> +static inline int
> +__maskpopcnt (__cpu_mask mask)
> +{
#if (__GNUC__ >= 4)
     return __builtin_popcountl (mask);
#else
> +  int res = 0;
> +  unsigned long ulmask = (unsigned long) mask;
> +
> +  while (ulmask != 0)
> +    {
> +      if (ulmask & 1)
> +        ++res;
> +      ulmask >>= 1;
> +    }
> +  return res;
#endif
> +}
> +

But, if you think that's not worth it, I'll push your patch as is.


Thanks,
Corinna
