Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 17A1C384D146; Tue, 17 Jun 2025 11:01:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17A1C384D146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750158095;
	bh=cYwZL3Vw7PIOnon9JrqScxvnvZkdJsPlWSI/ov1pOGo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=wCjIAcwjjBEQ5UE5UCkaeACO1tywDnNZy9CdIJoJw9+lndVMk3Ys9snGdg2ebF1w/
	 aCM+rh7UwgY91WbTUXTcF5LeuYSLDu9x0LxdmTS/RVZxgaU6NK/wJBgsebw+yPWydO
	 HRsVEBTwwH8tmdfnqJhKZlb7cpCw7CKDGTKn+BOE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C29CEA80961; Tue, 17 Jun 2025 13:01:32 +0200 (CEST)
Date: Tue, 17 Jun 2025 13:01:32 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: configure: allow configuring winsup for AArch64
Message-ID: <aFFLDAWNXM2O5D5P@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923C4B40A6602F4A39784CC9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923C4B40A6602F4A39784CC9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

This and the other patches you sent today are fine, thanks.
Additionally your gcc 15 compat patch should go into the
cygwin-3_6-branch as well, I will take care of that.

However, can you please resend your patches with a `Signed-off-by:'
added, just as for the Linux kernel?


Thanks,
Corinna


On Jun 12 12:34, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> This is a first patch from series that aspire to allow building and linking Cygwin for Windows on Arm64 assuming there is already a `aarch64-pc-cygwin` toolchain available.
> For validating it, the AArch64 Ubuntu cross-toolchain from https://github.com/Windows-on-ARM-Experiments/mingw-woarm64-build/releases and the https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/pull/31 job added to `cygwin.yml` GHA workflow can be used.
> 
> This patch only adds the necessary changes to `configure.ac` to pass the configuration step of the build.
> 
> Thank you for your feedback.
> 
> Radek
> 
> >From f5b653121eda766db76c058f54c6039868a3366d Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 11:44:23 +0200
> Subject: [PATCH] Cygwin: configure: allow configuring winsup for AArch64
> 
> ---
>  winsup/configure.ac | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/configure.ac b/winsup/configure.ac
> index 9b9b59dbc..18adf3d97 100644
> --- a/winsup/configure.ac
> +++ b/winsup/configure.ac
> @@ -69,12 +69,14 @@ DLL_ENTRY="dll_entry"
>  
>  case "$target_cpu" in
>     x86_64)	;;
> +   aarch64)	;;
>     *)		AC_MSG_ERROR([Invalid target processor "$target_cpu"]) ;;
>  esac
>  
>  AC_SUBST(DLL_ENTRY)
>  
>  AM_CONDITIONAL(TARGET_X86_64, [test $target_cpu = "x86_64"])
> +AM_CONDITIONAL(TARGET_AARCH64, [test $target_cpu = "aarch64"])
>  
>  AC_ARG_ENABLE(doc,
>  	      [AS_HELP_STRING([--disable-doc], [do not build documentation])],,
> -- 
> 2.49.0.vfs.0.3


