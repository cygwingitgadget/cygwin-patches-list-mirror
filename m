Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 01D8F38515D2; Fri,  4 Jul 2025 08:50:52 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E3B25A80961; Fri, 04 Jul 2025 10:50:50 +0200 (CEST)
Date: Fri, 4 Jul 2025 10:50:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: define OUTPUT_FORMAT and SEARCH_DIR for AArch64
Message-ID: <aGeV6nKWU4LOlFtI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923BA573EA5101074C2F0B79278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFupr2xZJQY28zEQ@calimero.vinschen.de>
 <575e8838-b292-4f3c-9d47-76507703b747@dronecode.org.uk>
 <aFvgAEwrdLH-A5Ai@calimero.vinschen.de>
 <81096ca9-9542-4818-b363-f3856915050f@dronecode.org.uk>
 <aFwaB47HM8UDH9CK@calimero.vinschen.de>
 <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB9PR83MB09239C78F66E20045E2F4A269243A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

your patches basically look good, as far as the code is concerned.
However, all your patches are lacking helpful commit messages.

Please make sure that your commit message explains what you're doing and
why.  For instance, this patch here should actually describe a bit how
we reached this result and how the additional target-specific path is
unnecessary.  Even the build failures on Fedora are of interest, why
not?

In other patch mails you add a short explanation to the cover mail, while
this explanation should in fact be part of the commit message.

In terms of this patch here I'm a bit puzzled.  It's nice that the
"=/lib/w32api" is sufficent.  I tested this locally on my fedora ->
x86_64-pc-cygwin cross and it builds fine, too.

But why on earth is adding an unneeded dir to the search path
breaking the build, if the correct "=/lib/w32api" path is part of the
search path as well?  Why does this not break the x86_64 build, even
if that path neither exists for x86_64?


Thanks,
Corinna


On Jul  3 18:49, Radek Barton via Cygwin-patches wrote:
> Hello.
> 
> The following:
> 
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 5007a3694..e71e0189c 100644
> --- a/winsup/cygwin/cygwin.sc.in
> +++ b/winsup/cygwin/cygwin.sc.in
> @@ -1,6 +1,8 @@
> +SEARCH_DIR("=/lib/w32api");
>  #ifdef __x86_64__
>  OUTPUT_FORMAT(pei-x86-64)
> -SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> +#elif __aarch64__
> +OUTPUT_FORMAT(pei-aarch64-little)
>  #else
>  #error unimplemented for this target
>  #endif 
> 
> breaks Fedora build (https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/actions/runs/16051682177).
> 
> Also this:
> 
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 5007a3694..dda28692e 100644
> --- a/winsup/cygwin/cygwin.sc.in
> +++ b/winsup/cygwin/cygwin.sc.in
> @@ -1,9 +1,13 @@
>  #ifdef __x86_64__
>  OUTPUT_FORMAT(pei-x86-64)
> -SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api"); SEARCH_DIR("=/usr/lib/w32api");
> +SEARCH_DIR("/usr/x86_64-pc-cygwin/lib/w32api");
> +#elif __aarch64__
> +OUTPUT_FORMAT(pei-aarch64-little)
> +SEARCH_DIR("/usr/aarch64-pc-cygwin/lib/w32api");
>  #else
>  #error unimplemented for this target
>  #endif
> +SEARCH_DIR("=/lib/w32api");
>  #define __CONCAT1(a,b)	a##b
>  #define __CONCAT(a,b) __CONCAT1(a,b)
>  #define _SYM(x)	__CONCAT(__USER_LABEL_PREFIX__, x)     
> 
> breaks the Fedora build (https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/actions/runs/16051815462).
> 
> While this:
> 
> diff --git a/winsup/cygwin/cygwin.sc.in b/winsup/cygwin/cygwin.sc.in
> index 5007a3694..2a734a5b1 100644
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
> +SEARCH_DIR("=/usr/lib/w32api");
>  #define __CONCAT1(a,b)	a##b
>  #define __CONCAT(a,b) __CONCAT1(a,b)
>  #define _SYM(x)	__CONCAT(__USER_LABEL_PREFIX__, x)
> 
> seems to work (https://github.com/Windows-on-ARM-Experiments/newlib-cygwin/actions/runs/16057401863).


