Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C79AB3858D1E; Mon, 21 Jul 2025 09:49:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C79AB3858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753091380;
	bh=QGAf7uiAdM/OxTEdbXHjwS3XxBbC5AS2el7eYXmfFro=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RXPErj0KJHeJgj/vSYg7GN3lIC/3YO34+uEK6cd1HY5ersZvTymE2TbvggEfA/NH9
	 YWWTl4rgwuHzVbTuO4PHX3V0Jk08rgjPyg47Jz4+GQYkK/L6yNTRrgUC9UFtX5GfSC
	 MhdFtXl4zdOFxkrZkt2kpApHOV1ZtIE6Xa9a6Nm0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1F4FAA80CE5; Mon, 21 Jul 2025 11:49:39 +0200 (CEST)
Date: Mon, 21 Jul 2025 11:49:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: Radek Barton <radek.barton@microsoft.com>, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
Message-ID: <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>,
	Radek Barton <radek.barton@microsoft.com>,
	cygwin-patches@cygwin.com
References: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Jeremy?

On Jul 21 07:56, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending a patch with AArch64 +/-4GB relocations in mkimport as promised at https://sourceware.org/pipermail/cygwin-patches/2025q3/014155.html
> 
> Radek
> 
> ---
> >From 3ec4e2136942ade5856310ee1f4d9d89359c3c79 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Sat, 19 Jul 2025 19:17:12 +0200
> Subject: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB relocations
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Based on https://sourceware.org/pipermail/cygwin-patches/2025q3/014154.html
> suggestion, this patch implements +/-4GB relocations for AArch64 in the mkimport
> script by using adrp and ldr instructions. This change required update
> in winsup\cygwin\mm\malloc_wrapper.cc where those instructions are
> decoded to get target import address.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/mm/malloc_wrapper.cc | 23 ++++++++++++++---------
>  winsup/cygwin/scripts/mkimport     |  4 ++--
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/malloc_wrapper.cc
> index 863d3089c..5ca4da587 100644
> --- a/winsup/cygwin/mm/malloc_wrapper.cc
> +++ b/winsup/cygwin/mm/malloc_wrapper.cc
> @@ -51,16 +51,21 @@ import_address (void *imp)
>    __try
>      {
>  #if defined(__aarch64__)
> -      // If opcode is an adr instruction.
> -      uint32_t opcode = *(uint32_t *) imp;
> -      if ((opcode & 0x9f000000) == 0x10000000)
> +      // If opcode1 is an adrp and opcode2 is ldr instruction:
> +      //   - https://www.scs.stanford.edu/~zyedidia/arm64/adrp.html
> +      //   - https://www.scs.stanford.edu/~zyedidia/arm64/ldr_imm_gen.html
> +      uint32_t opcode1 = *((uint32_t *) imp);
> +      uint32_t opcode2 = *(((uint32_t *) imp) + 1);
> +      if (((opcode1 & 0x9f000000) == 0x90000000) && ((opcode2 & 0xbfc00000) == 0xb9400000))
>  	{
> -	  uint32_t immhi = (opcode >> 5) & 0x7ffff;
> -	  uint32_t immlo = (opcode >> 29) & 0x3;
> -	  int64_t sign_extend = (0l - (immhi >> 18)) << 21;
> -	  int64_t imm = sign_extend | (immhi << 2) | immlo;
> -	  uintptr_t jmpto = *(uintptr_t *) ((uint8_t *) imp + imm);
> -	  return (void *) jmpto;
> +	  uint32_t immhi = (opcode1 >> 5) & 0x7ffff;
> +	  uint32_t immlo = (opcode1 >> 29) & 0x3;
> +	  uint32_t imm12 = ((opcode2 >> 10) & 0xfff) * 8; // 64 bit scale
> +	  int64_t sign_extend = (0l - ((int64_t) immhi >> 32)) << 33; // sign extend from 33 to 64 bits
> +	  int64_t imm = sign_extend | (((immhi << 2) | immlo) << 12);
> +	  int64_t base = (int64_t) imp & ~0xfff;
> +	  uintptr_t* jmpto = (uintptr_t *) (base + imm + imm12);
> +	  return (void *) *jmpto;
>  	}
>  #else
>        if (*((uint16_t *) imp) == 0x25ff)
> diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mkimport
> index 0c1bcafbf..80594296a 100755
> --- a/winsup/cygwin/scripts/mkimport
> +++ b/winsup/cygwin/scripts/mkimport
> @@ -73,8 +73,8 @@ EOF
>  	.extern	$imp_sym
>  	.global	$glob_sym
>  $glob_sym:
> -	adr x16, $imp_sym
> -	ldr x16, [x16]
> +	adrp x16, $imp_sym
> +	ldr x16, [x16, #:lo12:$imp_sym]
>  	br x16
>  EOF
>  	} else {
> -- 
> 2.50.1.vfs.0.0
> 


