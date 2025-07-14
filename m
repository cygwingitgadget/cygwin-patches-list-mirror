Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 627833858C42; Mon, 14 Jul 2025 13:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 627833858C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752499334;
	bh=N0+RnK3yj8Zzq+VsXHDk4J0PBNOGpQbiHQAESqo7GUI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dYwKwDtoRPhulep1yxb/8ShPBrnmggDUA7irBG9pqO85EXGR+jv9xl+qyaQyKQCFF
	 xsk3vjR1H6dVTvFl9oFIRQb4nGCWk7BzmGJkh8hkcxRF+pqzeoYFod3Y7SmnnTCDaA
	 23RCXLcs7gzqSOZEJROv7QvucwEsrWqStErnv24c=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5F184A80DC6; Mon, 14 Jul 2025 15:22:12 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:22:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Message-ID: <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 10 19:21, Radek Barton via Cygwin-patches wrote:
> From 8bfc01898261e341bbc8abb437e159b6b33a9312 Mon Sep 17 00:00:00 2001
> From: Evgeny Karpov <evgeny.karpov@microsoft.com>
> Date: Fri, 4 Jul 2025 20:20:37 +0200
> Subject: [PATCH] Cygwin: malloc_wrapper: port to AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Implements import_address function by decoding adr AArch64 instructions to get
> target address.
> 
> Signed-off-by: Evgeny Karpov <evgeny.karpov@microsoft.com>
> ---
>  winsup/cygwin/mm/malloc_wrapper.cc | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_wrapper.cc
> index de3cf7ddc..863d3089c 100644
> --- a/winsup/cygwin/mm/malloc_wrapper.cc
> +++ b/winsup/cygwin/mm/malloc_wrapper.cc
> @@ -50,6 +50,19 @@ import_address (void *imp)
>  {
>    __try
>      {
> +#if defined(__aarch64__)
> +      // If opcode is an adr instruction.
> +      uint32_t opcode = *(uint32_t *) imp;
> +      if ((opcode & 0x9f000000) == 0x10000000)
> +     {
> +       uint32_t immhi = (opcode >> 5) & 0x7ffff;
> +       uint32_t immlo = (opcode >> 29) & 0x3;
> +       int64_t sign_extend = (0l - (immhi >> 18)) << 21;
> +       int64_t imm = sign_extend | (immhi << 2) | immlo;
> +       uintptr_t jmpto = *(uintptr_t *) ((uint8_t *) imp + imm);
> +       return (void *) jmpto;
> +     }
> +#else
>        if (*((uint16_t *) imp) == 0x25ff)
>       {
>         const char *ptr = (const char *) imp;
> @@ -57,6 +70,7 @@ import_address (void *imp)
>                            (ptr + 6 + *(int32_t *)(ptr + 2));
>         return (void *) *jmpto;
>       }
> +#endif
>      }
>    __except (NO_ERROR) {}
>    __endtry
> --
> 2.50.1.vfs.0.0
> 

Pushed.


Thanks,
Corinna
