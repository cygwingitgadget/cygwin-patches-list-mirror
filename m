Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7C57B3852123; Thu,  3 Jul 2025 15:22:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C57B3852123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751556124;
	bh=swKpe5uxqTfCTy8KTkGYKDYBN1kUmnbAaSxDsTFqGrU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cbFN1sonuYWnF0lI4iJNgpnxt0yd1Xv4p9kssRZGIvJElRv63CRII0bMaMDvE+H95
	 rX+FJcluZJBqNfZhV6hL5PTrIk+jhBvldk/LoBhMSzgRTk5Xgse/Nklv3OLQ0eaYR4
	 PWrtKZ0/0TT1+vRc5RO9wLuCW3CilYZpcB0KHzoE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 793D8A80CC8; Thu, 03 Jul 2025 17:22:02 +0200 (CEST)
Date: Thu, 3 Jul 2025 17:22:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add fastcwd to AArch64 build
Message-ID: <aGagGvaF1C50nQ1Z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB09239DC5AA360EC8472C8F749243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09239DC5AA360EC8472C8F749243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  3 14:26, Radek Barton via Cygwin-patches wrote:
> Hello
> 
> This patch adds `aarch64/fastcwd.cc` implementations to AArch64 build fixing undefined reference to `find_fast_cwd_pointer_aarch64`.
> 
> Radek
> 
> ---
> >From ff438392ffbd0c91a918b383a3e9947f1eb18212 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Mon, 9 Jun 2025 13:07:01 +0200
> Subject: [PATCH] Cygwin: add fastcwd to AArch64 build
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/Makefile.am | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
> index 31747ac98..90a7332a8 100644
> --- a/winsup/cygwin/Makefile.am
> +++ b/winsup/cygwin/Makefile.am
> @@ -64,6 +64,11 @@ TARGET_FILES= \
>  	x86_64/wmempcpy.S
>  endif
>  
> +if TARGET_AARCH64
> +TARGET_FILES= \
> +	aarch64/fastcwd.cc
> +endif
> +
>  # These objects are included directly into the import library
>  LIB_FILES= \
>  	lib/_cygwin_crt0_common.cc \
> -- 
> 2.49.0.vfs.0.4
> 

Pushed.

Thanks,
Corinna
