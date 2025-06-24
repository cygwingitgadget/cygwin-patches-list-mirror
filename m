Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F307D3857723; Tue, 24 Jun 2025 08:30:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F307D3857723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750753845;
	bh=JduVf1uKOZY2/eUpXmAsGrXhaWVT6BjKZpptqEz17eM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=i/kzd3GiVPMeRuq0Z1x2ZSKqC5EXRwf0d9V2bds+GF4JTWRsfY01XF0gn9x7Ik1is
	 Dsx6sDjAy/EUIXTSZgA4Hvqrg5mmvinbg6bs/nYxkh8Ct/2KxR5hFjjNHDrqwc287G
	 4Z33j3ICBNibSMgzvVz4hDn24fcCKv8JA03FPaVc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id CA08BA80CF9; Tue, 24 Jun 2025 10:30:43 +0200 (CEST)
Date: Tue, 24 Jun 2025 10:30:43 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add release note about `..` symlinks
Message-ID: <aFpiMx5Iy_K15k3J@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <bcca7e8ef4ffea3405629285d3c79d9acaaeae0e.1750752451.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcca7e8ef4ffea3405629285d3c79d9acaaeae0e.1750752451.git.johannes.schindelin@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Jun 24 10:08, Johannes Schindelin wrote:
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-dotdot-native_symlink-relnote-v1
> Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-dotdot-native_symlink-relnote-v1
> 
> 	Here you go, sorry for missing that.
> 
>  winsup/cygwin/release/3.6.4 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/winsup/cygwin/release/3.6.4 b/winsup/cygwin/release/3.6.4
> index 8eb693c40c..c80a29ea4f 100644
> --- a/winsup/cygwin/release/3.6.4
> +++ b/winsup/cygwin/release/3.6.4
> @@ -6,3 +6,6 @@ Fixes:
>  
>  - Make pthread initializer macros compatible with C++ constinit.
>    Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258305.html
> +
> +- Fix creating native symlinks to `..` (it used to target `../../<dir>`
> +  instead).
> 
> base-commit: 5979f22b9094a22d07cc2382e129f3f858008c88
> -- 
> 2.50.0.windows.1

Pushed.

Thanks,
Corinna
