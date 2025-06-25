Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A33FD3858D20; Wed, 25 Jun 2025 07:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A33FD3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750834983;
	bh=a3Twe+AOlxnsx6INUFk378RXF08sqHSf5mQ+Tt1ZCzY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MuUd2n1KXDa5uMJfyutJenBAtrFuzKLQ6Xu4mn34n6dzY8Dz2TP/KMAl4cUMXYUGw
	 /mmJwFK/1nq73KOibk+cNRRuSUcc9VC3Dg5916QcDwwZXQG3gnZSzde7760Oo7LO2V
	 VNU76p6TG3Yx9u3dxR/yCT8/5hjzBjrst/dOUVAs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2E6E5A80723; Wed, 25 Jun 2025 09:03:01 +0200 (CEST)
Date: Wed, 25 Jun 2025 09:03:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: stack base initialization for AArch64
Message-ID: <aFufJb2PZg1pQ5Ha@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
 <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
 <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFj-bZ28sTEOvVqj@calimero.vinschen.de>
 <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

On Jun 24 19:21, Radek Barton via Cygwin-patches wrote:
> Hello
> 
> Finally we've managed to rule out that the regressions were actually introduced by https://sourceware.org/pipermail/cygwin-patches/2025q2/013832.html, Thiru will send the fix soon.
> 
> Radek
> 
> ---
> >From c33f2e1b0037f9e5a3dbae4a0c82070db851cb33 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 13:15:22 +0200
> Subject: [PATCH v3] Cygwin: stack base initialization for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/dcrt0.cc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index f4c09befd..3dceae654 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -1030,14 +1030,20 @@ _dll_crt0 ()
>  	  PVOID stackaddr = create_new_main_thread_stack (allocationbase);
>  	  if (stackaddr)
>  	    {
> -#ifdef __x86_64__
>  	      /* Set stack pointer to new address.  Set frame pointer to
>  	         stack pointer and subtract 32 bytes for shadow space. */
> +#if defined(__x86_64__)

The comment in terms of the 32 byte shadow space is now in the wrong spot.
Splitting out this part would probably help the reader.

>  	      __asm__ ("\n\
>  		       movq %[ADDR], %%rsp \n\
>  		       movq  %%rsp, %%rbp  \n\
>  		       subq  $32,%%rsp     \n"
>  		       : : [ADDR] "r" (stackaddr));
> +#elif defined(__aarch64__)
> +	      __asm__ ("\n\
> +		       mov fp, %[ADDR] \n\
> +		       mov sp, fp      \n"
> +		       : : [ADDR] "r" (stackaddr)
> +		       : "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> -- 
> 2.49.0.vfs.0.4

Thanks,
Corinna
