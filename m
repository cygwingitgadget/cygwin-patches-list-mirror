Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 17B233858D32; Mon,  7 Jul 2025 12:56:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17B233858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751892999;
	bh=+k9zPKBpZF+9nKSUgOhlZ/WUdAVIwYmEgAvgeOppJsE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=v8Z+93HeCrgek74PmvN7ZlNzEAJcS78tSZndpsnMESn41btPjpg8EmVY5SDF3Ehfw
	 krOHCX7Ghmx2MbYCJLmdww6FskEZtWbdpOXprivzeGU0I26luvHR1S0ciR/MIwh4cW
	 yGPwXjhzgbP/MOEOTYkhEpc5/Fowvur8Ogzr8c70=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8ED20A80D01; Mon, 07 Jul 2025 14:56:36 +0200 (CEST)
Date: Mon, 7 Jul 2025 14:56:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v4] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for
 AArch64
Message-ID: <aGvEBMnjh02UCqNw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
 <aFwaB47HM8UDH9CK@calimero.vinschen.de>
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <DB9PR83MB0923B144F86ADC301E17B3399242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aGe1pC9zNUhWzARd@calimero.vinschen.de>
 <DB9PR83MB09231472E10A14139FF803A89242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB9PR83MB09231472E10A14139FF803A89242A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 14:18, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> Sending the version with `SEARCH_DIR("=/usr/lib/w32api")` only, with detailed commit message added. I've also removed semicolon for `SEARCH_DIR` as it's not needed and other directives do not use it.
> 
> Radek


Pushed.


Thanks,
Corinna


> 
> ---
> >From 44f33bdb2e564c9dd6207b951f3074a2b98b9bb3 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Fri, 6 Jun 2025 14:13:16 +0200
> Subject: [PATCH v4] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This patch defines binutils output binary format for AArch64 which is pei-aarch64-little.
> 
> Since =/usr/lib/w32api resolves to $SYSROOT/usr/lib/w32api and Fedora cross-build takes libraries from
> /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api, the SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); is
> redundant and can be removed.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/cygwin.sc.in | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 5007a3694..25739a198 100644
> --- a/winsup/cygwin/cygwin.sc.in
> +++ b/winsup/cygwin/cygwin.sc.in
> @@ -1,9 +1,11 @@
>  #ifdef __x86_64__
>  OUTPUT_FORMAT(pei-x86-64)
> -SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> +#elif __aarch64__
> +OUTPUT_FORMAT(pei-aarch64-little)
>  #else
>  #error unimplemented for this target
>  #endif
> +SEARCH_DIR("=/usr/lib/w32api")
>  #define __CONCAT1(a,b)	a##b
>  #define __CONCAT(a,b) __CONCAT1(a,b)
>  #define _SYM(x)	__CONCAT(__USER_LABEL_PREFIX__, x)
> -- 
> 2.49.0.vfs.0.4
> 


