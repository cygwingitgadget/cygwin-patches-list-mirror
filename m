Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1D3E4385E825; Thu,  3 Jul 2025 15:22:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D3E4385E825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751556139;
	bh=G+54J/vpquBRs59btBVNHA0lBeE5MOllnu/vFDRDdrQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rp/UsdX9PtdSdjlMtDoWkm1gfPf/7qBOWcsvxGfpo6gERHkYp+q02UPIfVbVhJQCg
	 EjBtlbpdd+mQJDZbgsaxvdUnqz4hv4kZpkzy662EBF4Dtzcx9dsUk+SpYogCVj9QkR
	 TluL2A/6xM1kqqydhFr1iG876Ivu5fcxj7L/Ds8w=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0F648A80CC8; Thu, 03 Jul 2025 17:22:17 +0200 (CEST)
Date: Thu, 3 Jul 2025 17:22:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: gentls_offsets: port to support AArch64
Message-ID: <aGagKdyoX2z3xB02@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923C787C8B326444EC5E2969243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923C787C8B326444EC5E2969243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  3 14:39, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> This patch ports `winsup/cygwin/scripts/gentls_offsets` script to AArch64 where `.word` instead of `.long` is used.
> 
> ---
> >From b53e7dfcc0f31bdc5d8ad1fcff14753e0bd3399c Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Fri, 6 Jun 2025 11:21:11 +0200
> Subject: [PATCH] Cygwin: gentls_offsets: port to support AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/scripts/gentls_offsets | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/scripts/gentls_offsets b/winsup/cygwin/scripts/gentls_offsets
> index 040b5de6b..c375a6106 100755
> --- a/winsup/cygwin/scripts/gentls_offsets
> +++ b/winsup/cygwin/scripts/gentls_offsets
> @@ -62,7 +62,7 @@ start_offset=$(gawk '\
>    /^__CYGTLS__/ {
>      varname = gensub (/__CYGTLS__(\w+):/, "\\1", "g");
>    }
> -  /\s*\.long\s+/ {
> +  /\s*\.(word|long)\s+/ {
>      if (length (varname) > 0) {
>        if (varname == "start_offset") {
>  	print $2;
> @@ -85,7 +85,7 @@ gawk -v start_offset="$start_offset" '\
>        varname = "";
>      }
>    }
> -  /\s*\.long\s+/ {
> +  /\s*\.(word|long)\s+/ {
>      if (length (varname) > 0) {
>        if (varname == "start_offset") {
>  	printf (".equ _cygtls.%s, -%u\n", varname, start_offset);
> -- 
> 2.49.0.vfs.0.4
> 

Pushed.

Thanks,
Corinna
