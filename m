Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 062134BA2E21; Fri,  9 Jan 2026 10:41:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 062134BA2E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1767955328;
	bh=xMJEDGdV0b78vgqUkcBlO7ADWBpK4KcGqh0XHw41ZdM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fkFQA6FkJyd4a02F9E6FQeK2GLeijzsgTGzBGorhxIc2qpQRs7KSxC6ShCsQhSzk3
	 usjQ3S/uRysKk3oWEdLOUTrs4l7Y1iIOONgpKVsUvEOi7SyrTsuzM/3ApQxSBsHWcS
	 YKjeVfFaM+xT9pSxzyo765XShcL7QaDB3vM2qVjM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 22878A80BCC; Fri, 09 Jan 2026 11:41:54 +0100 (CET)
Date: Fri, 9 Jan 2026 11:41:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH V2] Cygwin: Update _endian.h to handle unsupported arch
Message-ID: <aWDbcmwFkR690d8d@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <MA0P287MB308241F2F6A8AB26A6249FB49F85A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB30825913564D694F3CE48D479F82A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB30825913564D694F3CE48D479F82A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

On Jan  9 09:10, Thirumalai Nagalingam wrote:
> Hi Corinna,
> 
> > can you check your patch again?  It fails to apply for me against current main.
> 
> Please accept my apologies for the previous patch. I had generated it from a
> diff branch in my fork, which caused it not to apply cleanly. I've now
> regenerated the patch against the current main, and it should apply cleanly.
> 
> > Also, would you mind to add a Fixes: tag?
> 
> I've also added the appropriate Fixes tag & realized I forgot to include the
> Signed-off-by line in the previous version, that's been corrected now.
> 
> Thanks,
> Thiru
> 
> In-Lined patch:
> 
> diff --git a/winsup/cygwin/include/machine/_endian.h b/winsup/cygwin/include/machine/_endian.h
> index 622d7a2e9..48ff242b5 100644
> --- a/winsup/cygwin/include/machine/_endian.h
> +++ b/winsup/cygwin/include/machine/_endian.h
> @@ -28,8 +28,10 @@ __ntohl(__uint32_t _x)
>  {
>  #if defined(__x86_64__)
>         __asm__("bswap %0" : "=r" (_x) : "0" (_x));
> -#elif defined(__aarch64__)
> +#elif defined(__aarch64__) && __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>         __asm__("rev %w0, %w0" : "=r" (_x) : "0" (_x));
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
>         __asm__("uxth %w0, %w0\n\t"
>                 "rev16 %w0, %w0"
>                 : "+r" (_x));
> +#else
> +#error "unsupported architecture"
>  #endif
>         return _x;
>  }
> --

Pushed with a small change to the commit message (shortened SHA1)


Thanks,
Corinna
