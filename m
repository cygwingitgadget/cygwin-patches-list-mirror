Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 253CC3858416; Wed, 25 Jun 2025 07:48:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 253CC3858416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750837682;
	bh=NxVFqIKdYRf6FF9+vupKc/3xhDoTAVbQe0XJJroHqA4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BZtJDqAoNryCDxtli7s3UjSMTP6Sc+nJO1sFjODoZKM1Ckk1ZjE2A7E2xS/2gq2PR
	 dyFW8eMTrjefXMCG2jRQc9Aue6hjdEoU6pkZ8+nWl1u+JrJm/xWpa9khNUiKsJ82Vo
	 zkhcGeXBZZ88wwGADX0M/pL+938XEhUJXpNjUEtY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id ED602A80B69; Wed, 25 Jun 2025 09:47:59 +0200 (CEST)
Date: Wed, 25 Jun 2025 09:47:59 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Message-ID: <aFupr2xZJQY28zEQ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

On Jun 24 19:49, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> This change defines `OUTPUT_FORMAT` and `SEARCH_DIR` in `winsup/cygwin/cygwin.sc.in` file for AArch64.
> 
> Radek
> 
> ---
> >From 420a2c9bd13c338c037e583b663ccdabf4c02cd4 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Fri, 6 Jun 2025 14:13:16 +0200
> Subject: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/cygwin.sc.in | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 5007a3694..3322810cc 100644
> --- a/winsup/cygwin/cygwin.sc.in
> +++ b/winsup/cygwin/cygwin.sc.in
> @@ -1,6 +1,9 @@
>  #ifdef __x86_64__
>  OUTPUT_FORMAT(pei-x86-64)
>  SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> +#elif __aarch64__
> +OUTPUT_FORMAT(pei-aarch64-little)
> +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");

Given that /usr/lib/w32api is arch independent, maybe we should
take out that SEARCH_DIR from the arch dependent code, i.e.

if x86_64
SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");
elif aarch
SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");
else
error
endif
SEARCH_DIR("=/usr/lib/w32api");

What do you think?

Thanks,
Corinna
