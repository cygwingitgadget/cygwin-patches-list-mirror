Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9C9C6385F014; Tue, 24 Jun 2025 15:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9C9C6385F014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750780696;
	bh=hvHK7aEW2jojRxAQeOykT8hjldyskpEaMExpxPoDZeE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SQ8y0VABZvi4s/Ck6OREQUgIMhrH3i9GyGCy1rxijp82nXRuqSwxWmI4kqIgGuydB
	 dHtR9PzhoSAjw4k8vi+f8WsJEc4RbgvaJrSmHxsJqhnDjDL/XH0PuNZQNIPUV5EibL
	 zzmrN/3Ny8ZrPYUplICgpwB+Ib6k5+6q1jFLkCkQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 77F68A80CF9; Tue, 24 Jun 2025 17:58:14 +0200 (CEST)
Date: Tue, 24 Jun 2025 17:58:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: fix syntax error in cpu_relax.h for AArch64
Message-ID: <aFrLFtoyJf-XOA-X@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB092353FBE863EBE1067ED0BD9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB092353FBE863EBE1067ED0BD9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 24 11:02, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Please, take my apology that I failed to properly validate https://sourceware.org/pipermail/cygwin-patches/2025q2/013826.html
> 
> Radek
> 
> ---
> >From 565b1ee84e2882f7229cadaf11e4884349617040 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Sat, 21 Jun 2025 22:47:58 +0200
> Subject: [PATCH] Cygwin: fix syntax error in cpu_relax.h for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/testsuite/winsup.api/pthread/cpu_relax.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/testsuite/winsup.api/pthread/cpu_relax.h b/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> index 71cec0b2b..c31ef8c05 100644
> --- a/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> +++ b/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> @@ -4,8 +4,8 @@
>  #if defined(__x86_64__) || defined(__i386__)  // Check for x86 architectures
>     #define CPU_RELAX() __asm__ volatile ("pause" :::)
>  #elif defined(__aarch64__) || defined(__arm__)  // Check for ARM architectures
> -   #define CPU_RELAX() __asm__ volatile ("dmb ishst \
> -                                          yield" :::)
> +   #define CPU_RELAX() __asm__ volatile ("dmb ishst\n" \
> +                                         "yield" :::)
>  #else
>     #error unimplemented for this target
>  #endif
> -- 
> 2.49.0.vfs.0.4

Pushed.

Thanks,
Corinna
