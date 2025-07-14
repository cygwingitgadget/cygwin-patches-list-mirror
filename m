Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EEA9E3858C42; Mon, 14 Jul 2025 13:21:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEA9E3858C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752499316;
	bh=pTaTrmz6jnzmrYBYllmGzWuzAL9m0j+I9JZzU0pGyYw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cKkZz2nztwnEXSG/sX6bdFzg6C1LRy6og4cClnomNJ0b3NsSrnmYOHkyuvzHawyC5
	 doU8FMX/ga6AOaPjhGRLZbsayBxA2jcw6rzU5uJuKboslxjdSu2kgW2aFqdC90wh7e
	 M7ZR2JWQgqV4+GkVedfVrfi0uu04hRKQRzbGnbdk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 41A0BA80864; Mon, 14 Jul 2025 15:21:55 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:21:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env
Message-ID: <aHUEcwTds8tZYiBx@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <GV4PR83MB0941FE057826A88BE430A9409248A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV4PR83MB0941FE057826A88BE430A9409248A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 10 13:09, Radek Barton via Cygwin-patches wrote:
> >From 95803dff2ba531db12342c61f238d7d2ee0c7d80 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 3 Jul 2025 12:00:52 +0200
> Subject: [PATCH] Cygwin: add dummy declaration of _fe_nomask_env
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> _fe_nomask_env is exported by cygwin.din but not used for AArch64 at all.
> 
> Signed-off-by: Radek Bartoň <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/fenv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/winsup/cygwin/fenv.c b/winsup/cygwin/fenv.c
> index 80f7cc52c..1558f76c2 100644
> --- a/winsup/cygwin/fenv.c
> +++ b/winsup/cygwin/fenv.c
> @@ -3,3 +3,13 @@
>     being called from mainCRTStartup in crt0.o. */
>  void _feinitialise (void)
>  {}
> +
> +#if defined(__aarch64__)
> +
> +#include <fenv.h>
> +#include <stddef.h>
> +
> +/* _fe_nomask_env is exported by cygwin.din but not used at all for AArch64. */
> +const fenv_t *_fe_nomask_env = NULL;
> +
> +#endif /* __aarch64__ */
> -- 
> 2.50.1.vfs.0.0
>      

Pushed.


Thanks,
Corinna
