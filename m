Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 284084BB58B1; Wed, 11 Mar 2026 14:45:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 284084BB58B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773240348;
	bh=e9JTop0CdtDh6MlRS87YD9KrwnFgzHoB8T5w0srGTh0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gLsweFkIDVwd6vzS5aDjQ6Etkh6dHb5e9Uh7c0BzOHzrBEKSXFkNieqh/U+gCOIL7
	 gBzHGFNOUCACAf/442YG5u9gip3FDZ7FidovgrbsqU6xnmIpfCb7J1svx+p2Z8nh4O
	 YixsLf9rrBI+L6waT2lzbPtXTNc4tuOMYTUrjM9s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2F322A80859; Wed, 11 Mar 2026 15:45:46 +0100 (CET)
Date: Wed, 11 Mar 2026 15:45:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Igor Podgainoi <Igor.Podgainoi@arm.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
Subject: Re: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind
 phase on AArch64
Message-ID: <abGAGofEMp7sikvK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Igor Podgainoi <Igor.Podgainoi@arm.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
	nd <nd@arm.com>
References: <cover.1771414249.git.igor.podgainoi@arm.com>
 <c4f8c7507e38602ef2935a8dbafe7409a63377ad.1771414249.git.igor.podgainoi@arm.com>
 <aZWrI3WPFRqj7P_j@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZWrI3WPFRqj7P_j@arm.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Igor,

On Feb 18 12:05, Igor Podgainoi wrote:
> From 3b5dff19e13504c5c4d0e5867830a99ac29c0c7d Mon Sep 17 00:00:00 2001
> From: Igor Podgainoi <igor.podgainoi@arm.com>
> Date: Fri, 5 Dec 2025 16:45:52 +0100
> Subject: [PATCH v2 1/1] Cygwin: SEH: Fix crash and handle second unwind phase
>  on AArch64
> 
> This patch adds the definition of the TRY_HANDLER_DATA macro for
> the AArch64 architecture, as well as makes modifications to the
> exception handler responsible for the __try/__except blocks.

This patch is puzzeling me.  We don't have a TRY_HANDLER_DATA macro
for x86_64, and what you're adding below looks like the __try macro.

> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -346,7 +346,14 @@ public:
>  
>  #if defined (__aarch64__)
>  #define EXCEPTION_MYFAULT_REF "_ZN9exception7myfaultEP17_EXCEPTION_RECORDPvP8_CONTEXTP25_DISPATCHER_CONTEXT_ARM64"
> -#define TRY_HANDLER_DATA (void) &&__l_try;
> +#define TRY_HANDLER_DATA \
> +  __asm__ goto ("\n" \
> +  "  .seh_handler " EXCEPTION_MYFAULT_REF ", @except						\n" \
> +  "  .seh_handlerdata						\n" \
> +  "  .long 1							\n" \
> +  "  .rva %l[__l_try],%l[__l_endtry],%l[__l_except],%l[__l_except]	\n" \
> +  "  .text							\n" \
> +  : : : : __l_try, __l_endtry, __l_except)
>  #else
>  #define EXCEPTION_MYFAULT_REF "_ZN9exception7myfaultEP17_EXCEPTION_RECORDPvP8_CONTEXTP19_DISPATCHER_CONTEXT"
>  #define TRY_HANDLER_DATA \

These definitions don't exist for x86_64. 


Thanks,
Corinna
