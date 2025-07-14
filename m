Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 725173858D37; Mon, 14 Jul 2025 11:50:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 725173858D37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752493814;
	bh=kmqmCYevnsCL+oVC3ais9TUrpvuykzj9bqDQ3feydfk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ozP9NzGJuYieBMyWncu5KkZUxiRKaBpHJoIV+liQ0SWtADpOgclEDk06+3iTffacI
	 mrkA0v2qNJh+wuVWStkGBb50cg7IzyaJ92UJrG8jQocPvi93RJLGFD7TVBzsUfu6PV
	 yijNrtl0PS0cg63EiuQWxc02l0C08absXzjo618o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D2E43A806FF; Mon, 14 Jul 2025 13:50:12 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:50:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: profiler: port to AArch64
Message-ID: <aHTu9LOZ3TgR-jf1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB09231ED3693E994CA770C8609242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923FC4AD2C1668B124A71B69248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923FC4AD2C1668B124A71B69248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 10 10:24, Radek Barton via Cygwin-patches wrote:
> >From bfa5d3c1afe40431b28dd2496c38ba84f91ec0e5 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Tue, 10 Jun 2025 17:11:20 +0200
> Subject: [PATCH v2] Cygwin: profiler: port to AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch allows to build winsup/utils/profiler.cc for AArch64 by handling
> target architecture condition in find_text_section function implementation.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/utils/profiler.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc
> index b5ce16cf2..4fe900b7f 100644
> --- a/winsup/utils/profiler.cc
> +++ b/winsup/utils/profiler.cc
> @@ -503,8 +503,10 @@ find_text_section (LPVOID base, HANDLE h)
>  
>    read_child ((void *) &machine, sizeof (machine),
>                &inth->FileHeader.Machine, h);
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>    if (machine != IMAGE_FILE_MACHINE_AMD64)
> +#elif defined(__aarch64__)
> +  if (machine != IMAGE_FILE_MACHINE_ARM64)
>  #else
>  #error unimplemented for this target
>  #endif
> -- 
> 2.50.1.vfs.0.0
> 

Pushed.


Thanks,
Corinna
