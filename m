Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 22C563858C54; Mon, 14 Jul 2025 11:50:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 22C563858C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752493836;
	bh=6p1xqcPnRyAnhQCc+avLDfCdIGYkaAIcqGwTpH1cmVI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fcCO99rR+9YaRosgiqqwOkFTNdrbhvBMQRP635KZ/IJbbqYT1XUc7SGI8aZvEQXNp
	 dUfgaTdhOYQ8uEYdkY3GFQnhewswxvRbW0xqUdY7IR8qAstV+xXRoR8Rs5yxTg0Hxo
	 ge+xireDGAU+VckY40IfZ056Zu3qR8AtoamN1qtk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 77EA0A806FF; Mon, 14 Jul 2025 13:50:34 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:50:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: dumper: port to AArch64
Message-ID: <aHTvClq7GTtkxGWV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923715C769A4815ECC3D81A9242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923B2E497E8B66E7F20A5D49248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923B2E497E8B66E7F20A5D49248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 10 10:30, Radek Barton via Cygwin-patches wrote:
> >From 5df85fa4e3a92d96fedc9ede03523b320e9be3db Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Wed, 11 Jun 2025 23:07:21 +0200
> Subject: [PATCH v2] Cygwin: dumper: port to AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch allows to build winsup/utils/dumper.cc for AArch64 by handling target
> architecture condition in dumper::init_core_dump.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/utils/dumper.cc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
> index 994f9b683..b3151e66d 100644
> --- a/winsup/utils/dumper.cc
> +++ b/winsup/utils/dumper.cc
> @@ -700,8 +700,10 @@ dumper::init_core_dump ()
>  {
>    bfd_init ();
>  
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>    const char *target = "elf64-x86-64";
> +#elif defined(__aarch64__)
> +  const char *target = "elf64-aarch64";
>  #else
>  #error unimplemented for this target
>  #endif
> -- 
> 2.50.1.vfs.0.0
> 

Pushed.


Thanks,
Corinna
