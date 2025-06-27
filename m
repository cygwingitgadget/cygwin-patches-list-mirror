Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D17983858408; Fri, 27 Jun 2025 12:26:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D17983858408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751027198;
	bh=OxNmA7Wwk2Mxu0cjwce0jNAI8pKyiHvEBIpKimr4XLE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fM1cc/peo/DgWYTLxDFRddtSXxE6INo97c7xNJ/24QmiYjGMlAQlQOYoRryQ2toz9
	 aOO4Y/brEQFM2EoG1QdaheYbZ74Sx+WquiNru1LIC6EQiSd+owaTiT8lf/huXY1rsY
	 PP5M+qO2RhO2IoaNw9BuqpC0aVxprPmMiQr8n4QQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B9C01A806FF; Fri, 27 Jun 2025 14:26:36 +0200 (CEST)
Date: Fri, 27 Jun 2025 14:26:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: include sys/stat.h for chmod in
 posix_spawn/errors.c
Message-ID: <aF6N_KjYX_dL5pg6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <dd7c309e-69a6-b15b-ecaa-8c2faea74f58@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd7c309e-69a6-b15b-ecaa-8c2faea74f58@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 13:27, Jeremy Drake via Cygwin-patches wrote:
> This is required on Linux.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/testsuite/winsup.api/posix_spawn/errors.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> index 2fc3217bc0..3fbc2cbf99 100644
> --- a/winsup/testsuite/winsup.api/posix_spawn/errors.c
> +++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> @@ -3,6 +3,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <sys/stat.h>
>  #include <unistd.h>
> 
>  static char tmppath[] = "pspawn.XXXXXX";
> -- 
> 2.49.0.windows.1

Obvious

Thanks,
Corinna
