Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 834123887F68
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 10:24:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 834123887F68
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBDSg-1oGpqG0cIw-00CgXG for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022
 12:24:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2FE62A807E3; Thu, 14 Jul 2022 12:24:25 +0200 (CEST)
Date: Thu, 14 Jul 2022 12:24:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH rebase] Add support for Compact OS compression for Cygwin
Message-ID: <Ys/u2QmY8E1s0hZd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e281c355-1ea1-eefa-12d8-17f7538edb60@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e281c355-1ea1-eefa-12d8-17f7538edb60@t-online.de>
X-Provags-ID: V03:K1:yA0bNXMK52BQXgT5eWEJ1XnPBfCViDFpDgjjUDNHDj39Frd+ljP
 S5PTjKsYqNL+4GZ8N0ljOuRX5osOipacsoU45Ybubcp1AgwMQ7yQOgQ+ccEwau2h8CXzxfW
 wAt6qoDf+tdqlA+mJzDPk//AT4X0w2zAXy/v1aTssLoytYmEnhHS2DUwnYQ9mgXLG0MCuSz
 mw90szOv4SEt5Ln5RmkNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sVTpxB0Iv4Y=:GuhVO6+SPs23h5gH8uFPPY
 GgSBQkqgQ/tjXTtOSz3hIcMtMywFrr/Rs4AeVKRoz8h3F8aAM7Srf21W98yrqQouF4kaQzM3t
 PRmrKpSCNXP94L9Eh6J7iHYMFFm2Ey2olXromYs45htT0jBtkXqxq5vVt6cWXUjNdpDmccWsf
 FNGOLaGi4Dfi731F2KuKMbtR+4sQGw/CDUSulAjWbetDnh2a9+3rsQt3f1Gd+JD3bkHOvCXdS
 do1CZHj42QuJm/t70K6hgkKnm8nUxBj0ec1ErdhqyeuacmIsUkw48PSAWj/KMQW/VWd31h+u8
 NFSjrYgQ6dFJEqrZ2+LYV+TNu/5JAFu66zDcOQeQFA1+3/ZQ8nQG5fzw2sWDByRMGN2lANFyj
 JOP8zBROdd55VyH9QLUfeCMmV0UexPMxUyucvy0LgE02WlKXnzyWmf5eepkEx3+YirKaIcrJz
 XPZKlMePxsIJaQJy5LeYfpqJCRZqmcF3GmOG9fMWAKKCDn7I8Bl1Davt1Y2qZugS837bHJIcK
 161fo77dc6DGoxSLj9Hf30kxOQu3h+hhwlRgi6UocWxu1K86cHyK/f3njdLrTe/ivNcmLA7eL
 Ep0JkvwxAVNLOi0rdFz529ay69XskAyNvwo7HDyZ/YXBhwa0kxBqSjppbEDdZ+BZEBsQBAjgg
 FvVqnpCO5yvg25tZBAhz2Dex6uA/oNvacaKyH3O1PGbyzbaXQTOAZgUjD1D1Ate3Z/1WRSVZd
 GP1t6nNwkswsbBIVjFdUTC0SJ65CBwIDOgWn2IIHvF5tt7FQU7Pv+hMkx3M=
X-Spam-Status: No, score=-101.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 14 Jul 2022 10:24:29 -0000

On Jul 14 12:02, Christian Franke wrote:
> [Sorry if this is the wrong list]

Yes, in theorie, but no worries.  However...

> This finally completes '--compact-os' support of Cygwin setup.
> https://sourceware.org/pipermail/cygwin-apps/2021-May/041225.html
> 
> -- 
> Regards
> Christian
> 

> From 807ae9fbaef18491f3aa1e94e66dd21eb6748c3e Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Thu, 14 Jul 2022 11:59:50 +0200
> Subject: [PATCH] Add support for Compact OS compression for Cygwin
> 
> Preserve compression of manually rebased files.
> Align compression with Cygwin DLL if database is used.
> Only check for writability if file needs rebasing to keep
> compression of unchanged files.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  rebase.c | 199 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 155 insertions(+), 44 deletions(-)
> 
> diff --git a/rebase.c b/rebase.c
> index a403c85..06828bb 100644
> --- a/rebase.c
> +++ b/rebase.c
> @@ -39,6 +39,10 @@
>  #include <errno.h>
>  #include "imagehelper.h"
>  #include "rebase-db.h"
> +#if defined(__CYGWIN__)
> +#include <io.h>
> +#include <versionhelpers.h>
> +#endif
>  
>  BOOL save_image_info ();
>  BOOL load_image_info ();
> @@ -48,6 +52,10 @@ void print_image_info ();
>  BOOL rebase (const char *pathname, ULONG64 *new_image_base, BOOL down_flag);
>  void parse_args (int argc, char *argv[]);
>  unsigned long long string_to_ulonglong (const char *string);
> +#if defined(__CYGWIN__)
> +static int compactos_get_algorithm (const char *pathname);
> +static int compactos_compress_file (const char *pathname, int algorithm);
> +#endif
>  void usage ();
>  void help ();
>  BOOL is_rebaseable (const char *pathname);
> @@ -259,9 +267,19 @@ main (int argc, char *argv[])
>        ULONG64 new_image_base = image_base;
>        for (i = 0; i < img_info_size; ++i)
>  	{
> +#if defined(__CYGWIN__)

Given compactos stuff is a OS thingy and not actually a Cygwin feature,
why do we need an ifdef CYGWIN?

> +	  int compactos_algorithm
> +	      = compactos_get_algorithm (img_info_list[i].name);
> +#endif
>  	  status = rebase (img_info_list[i].name, &new_image_base, down_flag);
>  	  if (!status)
>  	    return 2;
> +#if defined(__CYGWIN__)
> +	  /* Reapply previous compression. */
> +	  if (compactos_algorithm >= 0)
> +	    compactos_compress_file (img_info_list[i].name,
> +				     compactos_algorithm);
> +#endif
>  	}
>      }
>    else
> @@ -269,6 +287,9 @@ main (int argc, char *argv[])
>        /* Rebase with database support. */
>        BOOL header;
>  
> +#if defined(__CYGWIN__)
> +      int compactos_algorithm = compactos_get_algorithm ("/bin/cygwin1.dll");
> +#endif
>        if (merge_image_info () < 0)
>  	return 2;
>        status = TRUE;
> @@ -279,6 +300,14 @@ main (int argc, char *argv[])
>  	    status = rebase (img_info_list[i].name, &new_image_base, FALSE);
>  	    if (status)
>  	      img_info_list[i].flag.needs_rebasing = 0;
> +#if defined(__CYGWIN__)
> +	    /* If Cygwin DLL is compressed, assume setup was used with option
> +	       --compact-os.  Align compression with Cygwin DLL. */
> +	    if (compactos_algorithm >= 0
> +		&& compactos_compress_file (img_info_list[i].name,
> +					    compactos_algorithm) < 0)
> +	      compactos_algorithm = -1;
> +#endif

This ifdef still makes sense, of course and on first glance, the
remainder of the patch LGTM.


Thanks,
Corinna
