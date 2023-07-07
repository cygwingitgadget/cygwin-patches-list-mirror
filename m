Return-Path: <SRS0=Cjba=CZ=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 64E723874B63
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 18:54:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 64E723874B63
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id HlzxqMmPZ6NwhHqbCqv3h5; Fri, 07 Jul 2023 18:54:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1688756074; bh=hBcGJ5AdNf1hO23E6epasqLW0TU5jDjhaOfI/UtY8cc=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=la2/LFT/Fa1NJVIwN5CGQ6rVgo2bkoYr9M3J2Upc38VcmpAadcGwkASrXj80KmEV2
	 3+vJkNeddfKx0F6NtOI1mKxR5QiRtOpB2wrpDvUMFUK9oL5Nz9+v5i3dPl1a7bvahw
	 dHeae5MwN15O0u+LNorwuWiPHHxvF1JwERcTQcTGthjYlbWrPqrDke/jGnYGzcmNrm
	 K4EVo/tD1gO6Og6ud92veyiXlfMbz7prz+QZt6PM7PvK68cVZMcN6OLAmAmZcPYlKl
	 I+l+IWiKurr9SokV9mpRMNO+g7M+6NvfuA9ebM46vY+5Cjc27/wFPu/Rxpr+XC3deM
	 q097wZfgn6Mag==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id HqbCqdj9UcyvuHqbCq8pbx; Fri, 07 Jul 2023 18:54:34 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64a85f6a
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=9YhT5fzQ58Mj5Kel8tAA:9 a=QEXdDO2ut3YA:10
Message-ID: <073cd700-c727-ee29-017e-df8d86a1db59@Shaw.ca>
Date: Fri, 7 Jul 2023 12:54:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h>
 compiler-agnostic
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20230707074121.7880-1-mark@maxrnd.com>
 <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZKfeaMftPy8HmXyy@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNI4pJypUZq+dLxmHDktsqAbUFZlCZbj2Mtm/3BgTkY7iYnzyF1qDCHeUo4GaBmmmtH/2t32MW9W5nlwsFY4A3vraoZebVYe5Kez89LSIcOZcrycXwXe
 GX/nbW5l3Jv3C9JXIU/PkPBGr7jF/l8PDSGUN5zPtdR8p9BKEyQDuEw1px7IzXkTznt2aU6SrFXOXxF8xFVPwLxERRat0JuF6XM=
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-07-07 03:44, Corinna Vinschen wrote:
> Hi Mark,
> 
> On Jul  7 00:41, Mark Geisert wrote:
>> The current version of <sys/cpuset.h> cannot be compiled by Clang due to
>> the use of __builtin* functions.  Their presence here was a dubious
>> optimization anyway, so their usage has been converted to standard
>> library functions.  A popcnt (population count of 1 bits in a word)
>> function is provided here because there isn't one in the standard library
>> or elsewhere in the Cygwin DLL.
> 
> And clang really doesn't provide it?  That's unfortunate.
> 
> Do you really think it's not worth to use it if it's available?
> 
> You could workaround it like this:
> 
>> +/* Modern CPUs have popcnt* instructions but the need here is not worth
>> + * worrying about builtins or inline assembler for different compilers. */
>> +static inline int
>> +__maskpopcnt (__cpu_mask mask)
>> +{
> #if (__GNUC__ >= 4)
>       return __builtin_popcountl (mask);
> #else
>> +  int res = 0;
>> +  unsigned long ulmask = (unsigned long) mask;
>> +
>> +  while (ulmask != 0)
>> +    {
>> +      if (ulmask & 1)
>> +        ++res;
>> +      ulmask >>= 1;
>> +    }
>> +  return res;
> #endif
>> +}
>> +
> 
> But, if you think that's not worth it, I'll push your patch as is.

In the cygwin list clang iostream discussion, I pointed out the clang 
configuration using gcc default paths and skipping the provided equivalent clang 
libraries including package libclang8 for clang intrinsics and builtins in:

	/usr/lib/clang/8.0.1/include/

which appear very similar to those provided by gcc-core in:

	/usr/lib/gcc/x86_64-pc-cygwin/11/include/

e.g.

$ l /usr/lib/{gcc/x86_64-pc-cygwin/11,clang/8.0.1}/include/*popcnt*
/usr/lib/clang/8.0.1/include/avx512vpopcntdqintrin.h
/usr/lib/clang/8.0.1/include/avx512vpopcntdqvlintrin.h
/usr/lib/clang/8.0.1/include/popcntintrin.h
/usr/lib/gcc/x86_64-pc-cygwin/11/include/avx512vpopcntdqintrin.h
/usr/lib/gcc/x86_64-pc-cygwin/11/include/avx512vpopcntdqvlintrin.h
/usr/lib/gcc/x86_64-pc-cygwin/11/include/popcntintrin.h

and from comparing features, the gcc test will work just fine with the clang 
compiler builtins or the clang intrinsics:

$ grep 'popc\(ou\)\?nt' 
/usr/lib/{gcc/x86_64-pc-cygwin/11,clang/8.0.1}/include/popcnt*
/usr/lib/gcc/x86_64-pc-cygwin/11/include/popcntintrin.h:#pragma GCC target("popcnt")
/usr/lib/gcc/x86_64-pc-cygwin/11/include/popcntintrin.h:_mm_popcnt_u32 (unsigned 
int __X)
/usr/lib/gcc/x86_64-pc-cygwin/11/include/popcntintrin.h:  return 
__builtin_popcount (__X);
/usr/lib/gcc/x86_64-pc-cygwin/11/include/popcntintrin.h:_mm_popcnt_u64 (unsigned 
long long __X)
/usr/lib/gcc/x86_64-pc-cygwin/11/include/popcntintrin.h:  return 
__builtin_popcountll (__X);
/usr/lib/clang/8.0.1/include/popcntintrin.h:/*===---- popcntintrin.h - POPCNT 
intrinsics -------------------------------===
/usr/lib/clang/8.0.1/include/popcntintrin.h:#define __DEFAULT_FN_ATTRS 
__attribute__((__always_inline__, __nodebug__, __target__("popcnt")))
/usr/lib/clang/8.0.1/include/popcntintrin.h:_mm_popcnt_u32(unsigned int __A)
/usr/lib/clang/8.0.1/include/popcntintrin.h:  return __builtin_popcount(__A);
/usr/lib/clang/8.0.1/include/popcntintrin.h:_popcnt32(int __A)
/usr/lib/clang/8.0.1/include/popcntintrin.h:  return __builtin_popcount(__A);
/usr/lib/clang/8.0.1/include/popcntintrin.h:_mm_popcnt_u64(unsigned long long __A)
/usr/lib/clang/8.0.1/include/popcntintrin.h:  return __builtin_popcountll(__A);
/usr/lib/clang/8.0.1/include/popcntintrin.h:_popcnt64(long long __A)
/usr/lib/clang/8.0.1/include/popcntintrin.h:  return __builtin_popcountll(__A);

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
