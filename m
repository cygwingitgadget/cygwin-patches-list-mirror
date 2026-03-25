Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 70DF84B9DB6E; Wed, 25 Mar 2026 18:59:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 70DF84B9DB6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774465186;
	bh=IcWvjZpi0B1yxtbfOvz68/PojF3q52YbZb2Z/E5AGMM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qyO3VzkgjTaQj3be2FJlVo7gayvxq2Hmq3pPK145MQHPuN3BQjXeoXjiwc8I1ZStD
	 IhAEvnXwIkdNGnRmA8i3MQS4Scr0ktPUG9Zscn2wKZ+nRuQ+3SVAkqV+1Q0fCY60w2
	 BLIhS3k/UyEXL96SoIsCLcrsSCkGsuzFc5xVBfzg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3C1E5A805DF; Wed, 25 Mar 2026 19:59:44 +0100 (CET)
Date: Wed, 25 Mar 2026 19:59:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: aarch64 SEH fixes and handler refactoring
Message-ID: <acQwoPFM-FeioOIA@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <MA0P287MB3082CAC457D335E3325522CD9F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082CAC457D335E3325522CD9F48A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

On Mar 24 12:42, Thirumalai Nagalingam wrote:
> In-lined patch:
> [...]
> diff --git a/winsup/cygwin/local_includes/exception.h b/winsup/cygwin/local_includes/exception.h
> index 19bb109de..b26f8ba17 100644
> --- a/winsup/cygwin/local_includes/exception.h
> +++ b/winsup/cygwin/local_includes/exception.h
> @@ -10,8 +10,19 @@ details. */
> 
>  #if defined (__aarch64__)
>  #define EXCEPTION_HANDLE_REF "_ZN9exception6handleEP17_EXCEPTION_RECORDPvP8_CONTEXTP25_DISPATCHER_CONTEXT_ARM64"
> - #else
> +#define EXCEPTION_HANDLER_DATA
> +#else
>  #define EXCEPTION_HANDLE_REF "_ZN9exception6handleEP17_EXCEPTION_RECORDPvP8_CONTEXTP19_DISPATCHER_CONTEXT"
> +#define EXCEPTION_HANDLER_DATA \
> +  asm volatile ("\n\
> +  1:                                                                   \n\
> +    .seh_handler "                                                       \
> +      EXCEPTION_HANDLE_REF ",                                            \
> +      @except                                                          \n\
> +    .seh_handlerdata                                                   \n\
> +    .long 1                                                            \n\
> +    .rva 1b, 2f, 2f, 2f                                                        \n\
> +    .seh_code                                                          \n")
>  #endif

This, I don't understand and looks wrong to me.

For aarch64, you're defining EXCEPTION_HANDLER_DATA as an empty macro.
EXCEPTION_HANDLE_REF is exclusively referenced from this macro, so given
it's empty, EXCEPTION_HANDLE_REF is entirely unused on aarch64.

Isn't there a non-empty definition for EXCEPTION_HANDLER_DATA on aarch64
missing from this patch?


Thanks,
Corinna
