Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A2A884BA2E06; Wed,  7 Jan 2026 11:17:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A2A884BA2E06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767784678;
	bh=yEcBbHbyQDGWpAubfCVtuQSDvYj07MKcFlWbwwSWtkA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nuHFGMVeYBEnRHNHORX4sldGOC9EP7hIWgfbTu5Cy+DgN9T/9MmXSY/aC8gjVsGZ9
	 sTSNmsZzifxvOsoBjypgUYKhUpPa+vNaSY365y/25hWUnqXNnSp4EUonLS9CFnNNwt
	 igXUiVFlbKdDqcWNZuHBpM7SptwLIslQLIDq6QSY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C2B45A80D4B; Wed, 07 Jan 2026 12:17:56 +0100 (CET)
Date: Wed, 7 Jan 2026 12:17:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: _endian.h: Add AArch64 implementations for
 `ntohl` and `ntohs`
Message-ID: <aV5A5ENx-xQdpgzR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	cygwin-patches@cygwin.com
References: <PN3P287MB30775977BEB79B12B2F3BCEE9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PN3P287MB30775977BEB79B12B2F3BCEE9F86A@PN3P287MB3077.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

On Jan  5 12:40, Thirumalai Nagalingam wrote:
> Hello Everyone,
> 
> This patch adds AArch64-specific inline asm implementations of __ntohl()
> and __ntohs() in `winsup/cygwin/include/machine/_endian.h`.
> 
> For AArch64 targets, the patch uses the REV and REV16 instructions
> to perform byte swapping, with explicit zero-extension for 16-bit
> values to ensure correct register semantics.
> 
> Comments and reviews are welcome.
> 
> Thanks & regards
> Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com<mailto:thirumalai.nagalingam@multicorewareinc.com>>
> 
> In-lined patch:
> 
> diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/include/machine/_endian.h
> index dbd4429b8..129cba66b 100644
> --- a/winsup/cygwin/include/machine/_endian.h
> +++ b/winsup/cygwin/include/machine/_endian.h
> @@ -26,16 +26,26 @@ _ELIDABLE_INLINE __uint16_t __ntohs(__uint16_t);
>  _ELIDABLE_INLINE __uint32_t
>  __ntohl(__uint32_t _x)
>  {
> +#if defined(__x86_64__)
>         __asm__("bswap %0" : "=r" (_x) : "0" (_x));
> +#elif defined(__aarch64__)
> +       __asm__("rev %w0, %w0" : "=r" (_x) : "0" (_x));
> +#endif
>         return _x;
>  }
> 
>  _ELIDABLE_INLINE __uint16_t
>  __ntohs(__uint16_t _x)
>  {
> +#if defined(__x86_64__)
>         __asm__("xchgb %b0,%h0"         /* swap bytes           */
>                 : "=Q" (_x)
>                 :  "0" (_x));
> +#elif defined(__aarch64__)
> +       __asm__("uxth %w0, %w0\n\t"
> +               "rev16 %w0, %w0"
> +               : "+r" (_x));
> +#endif
>         return _x;
>  }
 
This looks pretty obvious to me, pushed.


Thanks,
Corinna

