Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C8A313857BAF; Wed, 25 Jun 2025 11:46:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C8A313857BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851969;
	bh=yWOhzMADfAeuLoh93kTbOEMh1Lk3sXLspg+eWrhcaPw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=IgqLNGX5yz1U8BO/thxJUx474jNh+nLf0mojZvcATfmyizI9T5yPI7JgTwvAk/gSO
	 k8uKEtm6PpBCJeMqPhHTdzueJFsCcTeq3/okhYGwGGpU2//11dHgyFTArlvS6qxQQU
	 uUtbw5cXQ4p3o17pxLjGq46wMtBQ8w0IEHh0fRKs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A8DD9A80E29; Wed, 25 Jun 2025 13:46:07 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:46:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define ___CTOR_LIST__ and ___DTOR_LIST__ for
 AArch64
Message-ID: <aFvhf2M0Ea2kTIme@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB09231C714B9D3D3166E455DE9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09231C714B9D3D3166E455DE9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 24 19:47, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> This change defines  `___CTOR_LIST__`  and `___DTOR_LIST__` for AArch64 in the same way as for x86_x64 as AArch64 uses `pei-aarch64-little` and x86_x64 uses `pei-x86-64` COFF formats, which both are defined at https://github.com/Windows-on-ARM-Experiments/binutils-woarm64/blob/woarm64/ld/scripttempl/pep.sc#L159 resp. https://github.com/Windows-on-ARM-Experiments/binutils-woarm64/blob/woarm64/ld/emultempl/pep.em.
> 
> Radek
> 
> ---
> >From 1dc5dbeb5e8b9f2783ceddc7dcf227bc7b922e08 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Fri, 6 Jun 2025 14:12:28 +0200
> Subject: [PATCH] Cygwin: define ___CTOR_LIST__  and ___DTOR_LIST__ for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/cygwin.sc.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Pushed.


Thanks,
Corinna
