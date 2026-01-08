Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B198E4BA2E22; Thu,  8 Jan 2026 12:04:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B198E4BA2E22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767873843;
	bh=ngTRchkc3SqM4FzX0GtNWT3yTUKe3xi9d4wwfEfTvdI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=TlB5SrJOTWO0MpNMH9rlvp0FRZjBlAhsXcXajx1uLtLvtPH1bHPNy4mWGRgfkbF45
	 bVa4HelPGoPtfpwQoBU2jsqZBR4jusLHAhgU1yt7SOo8FV9gDXOJCNrjSIp7tPltKs
	 m0gNK+40xeDC6riDJ2ISKYBoq0uEf9nZiIp333Tc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C4C1BA80CFE; Thu, 08 Jan 2026 13:04:01 +0100 (CET)
Date: Thu, 8 Jan 2026 13:04:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Update _endian.h to handle unsupported arch
Message-ID: <aV-dMa74ppST628N@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <MA0P287MB308241F2F6A8AB26A6249FB49F85A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB308241F2F6A8AB26A6249FB49F85A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

can you check your patch again?  It fails to apply for me against
current main.  Hunk #1 seems to have a whitespace problem only, but hunk
#2 is suddenly missing the uxth opcode.

Also, would you mind to add a Fixes: tag?


Thanks,
Corinna


On Jan  8 08:30, Thirumalai Nagalingam wrote:
> Hi,
> 
> This patch Update _endian.h so that it explicitly throws an error when encountering
> an unsupported architecture instead of returning the unmodified x.
> Also tighten the arch detection logic by adding an explicit LE check.
> 
> Thanks & regards
> Thirumalai Nagalingam
> 
> In-lined patch:
> 
> diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/include/machine/_endian.h
> index 681ae4abe..e591f375d 100644
> --- a/winsup/cygwin/include/machine/_endian.h
> +++ b/winsup/cygwin/include/machine/_endian.h
> @@ -28,8 +28,10 @@ __ntohl(__uint32_t _x)
>  {
>  #if defined(__x86_64__)
>         __asm__("bswap %0" : "=r" (_x) : "0" (_x));
> -#elif defined(__aarch64__)
> +#elif defined(__aarch64__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>      __asm__("rev %w0, %w0" : "=r" (_x) : "0" (_x));
> +#else
> +#error "unsupported architecture"
>  #endif
>         return _x;
>  }
> @@ -41,10 +43,12 @@ __ntohs(__uint16_t _x)
>         __asm__("xchgb %b0,%h0"         /* swap bytes           */
>                 : "=Q" (_x)
>                 :  "0" (_x));
> -#elif defined(__aarch64__)
> +#elif defined(__aarch64__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>      __asm__("\n\
>                         rev16 %0, %0 \n\
>                 " : "=r" (_x) : "0" (_x));
> +#else
> +#error "unsupported architecture"
>  #endif
>         return _x;
>  }


