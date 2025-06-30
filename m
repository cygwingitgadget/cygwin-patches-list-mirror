Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B30E4385213A; Mon, 30 Jun 2025 10:27:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B30E4385213A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751279252;
	bh=dYpkfd6CiN5Fi3bHMfrLMBy+BPk98SfHOcLiJNZ+stA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=i2Md/94plXXdzUsSbJUdHd/Ulj0ojC8bXAnnjdBqG+KI2OG6LXeKwVny8DQDuzDrn
	 zN3Znvx/XaGD7LshVQQ0mnfnQghm5azE9TNCiTizUEFiwzfbgED3USEt+WexT6PLx3
	 cVDjcDT+Fnhd6MXznLdTm4blX0TU49IHQij/ud0I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5541AA80B7A; Mon, 30 Jun 2025 12:27:30 +0200 (CEST)
Date: Mon, 30 Jun 2025 12:27:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] wcrtomb: fix CESU-8 value of leftover lone high surrogate
Message-ID: <aGJmkh_2yM4Y416a@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6bdab1bf-192e-d1b0-22dc-c678e94e35d9@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bdab1bf-192e-d1b0-22dc-c678e94e35d9@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Jun 29 19:13, Christian Franke wrote:
> Fixes the CESU-8 value, but not the missing encoding if the high surrogate
> is at the very end of the string.

Are you going to provide a patch for that issue?
> 
> -- 
> Regards,
> Christian
> 

> From 96f23496f249558949923e60270b9568956912bf Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Sun, 29 Jun 2025 19:03:36 +0200
> Subject: [PATCH] wcrtomb: fix CESU-8 value of leftover lone high surrogate
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258378.html
> Fixes: 6ff28fc3b121 ("Allow CESU-8 surrogate value encoding")
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  newlib/libc/stdlib/wctomb_r.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/newlib/libc/stdlib/wctomb_r.c b/newlib/libc/stdlib/wctomb_r.c
> index 5ea1e13e4..ec6adfa49 100644
> --- a/newlib/libc/stdlib/wctomb_r.c
> +++ b/newlib/libc/stdlib/wctomb_r.c
> @@ -62,8 +62,8 @@ __utf8_wctomb (struct _reent *r,
>  	 of the surrogate and proceed to convert the given character.  Note
>  	 to return extra 3 bytes. */
>        wchar_t tmp;
> -      tmp = (state->__value.__wchb[0] << 16 | state->__value.__wchb[1] << 8)
> -	    - (0x10000 >> 10 | 0xd80d);

What a weird typo.  I wonder how I fat-fingered that 'd' into the code
/*facepalm*/

> +      tmp = (((state->__value.__wchb[0] << 16 | state->__value.__wchb[1] << 8)
> +	    - 0x10000) >> 10) | 0xd800;
>        *s++ = 0xe0 | ((tmp & 0xf000) >> 12);
>        *s++ = 0x80 | ((tmp &  0xfc0) >> 6);
>        *s++ = 0x80 |  (tmp &   0x3f);
> -- 
> 2.45.1
> 

LGTM, please push.

Thanks,
Corinna
