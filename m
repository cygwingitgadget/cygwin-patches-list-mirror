Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0B15A4B920D0; Mon,  9 Feb 2026 20:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0B15A4B920D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1770668585;
	bh=CHvRphUadZZ/cg8tXMLzYXwEV7me4Rlu54IuUiNnLpg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B/U3GNG2ZzzkDSezR6FzsELEURRPbxb3FQBukqJOZTajlygLdkDGDbnh5ihA4fKsM
	 luz4jDfTBlkwHXk8EOXBj5kh3w1qHpKxm8eWo/LK7pUVs3Uc+tBiT3IYTxuiBVnBHX
	 Z285nnM8PR0Gtf5QLooSVyK28H6EDl92N9YASFDU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1DBB4A807D8; Mon, 09 Feb 2026 21:23:03 +0100 (CET)
Date: Mon, 9 Feb 2026 21:23:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: gendef: export _alloca only on x86_64
Message-ID: <aYpCJ6Tybk0mGTLa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>,
	cygwin-patches@cygwin.com
References: <MA0P287MB3082B2BA4E9D476168C4DB919F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MA0P287MB3082B2BA4E9D476168C4DB919F65A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
List-Id: <cygwin-patches.cygwin.com>

Hi Thirumalai,

On Feb  9 20:00, Thirumalai Nagalingam wrote:
> Hi,
> 
> This patch restricts the export of the _alloca symbol to x86_64 and
> intentionally omits it on AArch64.
> 
> On AArch64, attempting to export it results in a link-time failure
> when building cygwin1.dll. Limiting the export to x86_64 avoids this
> error and reflects the architecture-specific availability of _alloca.
> 
> Thanks & regards
> Thirumalai Nagalingam
> 
> In-lined patch:
> 
> diff --git a/winsup/cygwin/x86_64/cygwin.din b/winsup/cygwin/x86_64/cygwin.din
> index 228894623..dfd50a4c3 100644
> --- a/winsup/cygwin/x86_64/cygwin.din
> +++ b/winsup/cygwin/x86_64/cygwin.din
> @@ -1,2 +1,4 @@
>  # x86_64-specific exports
>  # These symbols are only available on x86/x64 architectures
> +
> +_alloca = __alloca NOSIGFE
> --

Is that right?  I'm missing the patch hunk removing _alloca from the
common cygwin.din...


Thanks,
Corinna

