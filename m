Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 856F73851A9C; Wed, 18 Jun 2025 14:28:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 856F73851A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750256899;
	bh=ASHGY56xrS3gG0T3NCyQwK8oRi5Mf0ek4oYPRbRy5m0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UMGb0OJNnuW9CFI9uKERXE604dfF1KASetceLIwTRYBS/bU13RASp0LcA4KeJ8856
	 C7oNagxaMSHEf7l1Nq/tf+4cGT9R5cEQRKxiLiNiPlFLCIACWRDFouN276foVMXa8M
	 CnNGmTHeGQMtv5JV1RwwabCXRxsc0DqziKvNHMtg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 312A4A80D4E; Wed, 18 Jun 2025 16:28:14 +0200 (CEST)
Date: Wed, 18 Jun 2025 16:28:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: configure: allow configuring
 winsup for AArch64
Message-ID: <aFLM_gRWFwKNDiAn@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923C4B40A6602F4A39784CC9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFFLDAWNXM2O5D5P@calimero.vinschen.de>
 <DB9PR83MB0923C93F18F0A940A66A21269272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB0923C93F18F0A940A66A21269272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 18 12:11, Radek Barton via Cygwin-patches wrote:
> Hello
> 
> Sending the second version with Signed-off-by header.
> 
> Radek
> 
> ---
> >From 96f305fb51e02ac4430640457b4c3e2f0c0dee10 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 11:44:23 +0200
> Subject: [PATCH v2] Cygwin: configure: allow configuring winsup for
>  AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
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
> 2.49.0.vfs.0.4

Pushed.

Thanks,
Corinna
