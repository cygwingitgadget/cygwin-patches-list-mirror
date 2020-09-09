Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id A877E386F417
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 14:12:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A877E386F417
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N94FT-1kdiOQ1KB5-01652e for <cygwin-patches@cygwin.com>; Wed, 09 Sep 2020
 16:12:37 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 98F6FA80D14; Wed,  9 Sep 2020 16:12:36 +0200 (CEST)
Date: Wed, 9 Sep 2020 16:12:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: pty: Revise convert_mb_str() function.
Message-ID: <20200909141236.GY4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200909134043.1864-1-takashi.yano@nifty.ne.jp>
 <20200909134043.1864-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909134043.1864-2-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:2s9q6mbM+53gLKKovPvFPNVVPJPLy4bDeJICIcSHeZvUeAFjHHm
 xgET3o0GCc3k/AQdndsA+iaAnBAS+XZls16S6y1MI+nXcVzOhM+bosVL5GjAYDz3IZ3tpcf
 6WzKcWmDhzP004WvB+9f5hzspZlVPSj8qw0QwM/ncomOA4i0cgyo70cSAdRL1n/Jff6oPj3
 5N6XbBZwgBmQFGkVmtg4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V2tmaUY4ArE=:DXuJot0HuxOWxHy/KdBKXk
 /njR9vgnEvYFPU8XaTkx6KU5B9TbYoCDSuCFhsw9O0S93j7HTGHg4aipUz7JTc1Oajpkp/32/
 DVvMY2InhInvxE8WfcGpc2OB6h3jsW3jKZdcP/ofeRuZBYAz2TxxjHcSH0Z+1zrPtm14SYms6
 8YVHTg/cfiOV+XVA6NEj8kl6FharFOWBNLUyZg1c1pTFjJ+WyfEjqvJBS9qwO5vzZRagTkDtu
 aU2BG8l/KYjnSV7oJ43fMLAku9j3+/7U45dMQoBMJ6br0gzJLzk7CTBbnY0UY0k2lh+M0WykQ
 kpeHj1eCbkyxYjO48zrSHrAmyv/gY1MJSjOuYON6x2PBHXOmbh1OGADFUB0sTCgRm+E7SvkVM
 n5giMAy907/jXYz+Tf015CusS1KQ3t8NW3KvJPLmWFkabGkxvptmvKTVEkhPUimIA8zKeSa6A
 MO2rNWGc425/aX7SJZSXMH1Gilux8RUEsTDNduR6YteO65iSyUzaEpLHj5lr8qIb3fNN2Fug8
 3lT0ZMdib0G9cKHedILQP0V0mJoukYtaZHGs9Pax57Sx9d3HoTW1cf9ss+qWBN8SlfWpC7MYe
 MedpUbV2OiRGbsUlk0rojmvQtIeaz+hOnFwWkFUh15edOSc/0YwUTm4fAAE71ExB4sLrka/Gy
 OL1NGVgPEDz7BIr9y095kG2mOz2FRLaMTRCxZo8toQQ6teBkTktXQ9auyphFPizNWv6QhbVlE
 yuf06AsOHafDSBPOKRYcaUXedHKM1B1Zy7rPjV7a6YLm1PSIdNzTRbajD0qRzu2IaeNtVHK63
 Hr97gKmeRGToerxaFwGm0htpMKdSayNkHKHBspmBsXv5XNgqXZn6y4O+3NmrvHLnwY9zILF9W
 C7z6rNqxqbWcVg2KIZEw==
X-Spam-Status: No, score=-105.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Wed, 09 Sep 2020 14:12:40 -0000

On Sep  9 22:40, Takashi Yano via Cygwin-patches wrote:
> - Use tmp_pathbuf instead of HeapAlloc()/HeapFree().
> - Remove mb_str_free() function.
> - Consider the case where the multibyte string stops in the middle
>   of a multibyte char.
> ---
>  winsup/cygwin/fhandler_tty.cc | 118 ++++++++++++++++++++++------------
>  1 file changed, 77 insertions(+), 41 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 6de591d9b..c4b7fc61d 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -26,6 +26,7 @@ details. */
>  #include <asm/socket.h>
>  #include "cygwait.h"
>  #include "registry.h"
> +#include "tls_pbuf.h"
>  
>  #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
>  #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
> @@ -116,40 +117,72 @@ CreateProcessW_Hooked
>    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
>  }
>  
> -static char *
> -convert_mb_str (UINT cp_to, size_t *len_to,
> -		UINT cp_from, const char *ptr_from, size_t len_from)
> +static void
> +convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> +		UINT cp_from, const char *ptr_from, size_t len_from,
> +		mbstate_t *stat)

Heh, it's funny to use mbstate_t together with Windows functions :)
However, the var name `stat' makes me itch.  It looks too close to
struct stat and function stat.  What about "mbp" or something along
these lines?

>  {
> -  char *buf;
>    size_t nlen;
> +  tmp_pathbuf tp;
>    if (cp_to != cp_from)
>      {
> -      size_t wlen =
> -	MultiByteToWideChar (cp_from, 0, ptr_from, len_from, NULL, 0);
> -      wchar_t *wbuf = (wchar_t *)
> -	HeapAlloc (GetProcessHeap (), 0, wlen * sizeof (wchar_t));
> -      wlen =
> -	MultiByteToWideChar (cp_from, 0, ptr_from, len_from, wbuf, wlen);
> -      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen, NULL, 0, NULL, NULL);
> -      buf = (char *) HeapAlloc (GetProcessHeap (), 0, nlen);
> -      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen, buf, nlen, NULL, NULL);
> -      HeapFree (GetProcessHeap (), 0, wbuf);
> +      wchar_t *wbuf = tp.w_get ();
> +      int wlen = 0;
> +      if (cp_from == 65000) /* UTF-7 */

CP_UTF7?

> +	/* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> +	   Therefore, just convert string without checking */
> +	wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> +				    wbuf, NT_MAX_PATH);
> +      else
> +	{
> +	  char *tmpbuf = tp.c_get ();
> +	  memcpy (tmpbuf, stat->__value.__wchb, stat->__count);
> +	  if (stat->__count + len_from > NT_MAX_PATH)
> +	    len_from = NT_MAX_PATH - stat->__count;
> +	  memcpy (tmpbuf + stat->__count, ptr_from, len_from);
> +	  int total_len = stat->__count + len_from;
> +	  stat->__count = 0;
> +	  int mblen = 0;
> +	  for (const char *p = tmpbuf; p < tmpbuf + total_len; p += mblen)
> +	    /* Max bytes in multibyte char is 4. */
> +	    for (mblen = 1; mblen <= 4; mblen ++)
> +	      {
> +		/* Try conversion */
> +		int l = MultiByteToWideChar (cp_from, MB_ERR_INVALID_CHARS,
> +					     p, mblen,
> +					     wbuf + wlen, NT_MAX_PATH - wlen);
> +		if (l)
> +		  { /* Conversion Success */
> +		    wlen += l;
> +		    break;
> +		  }
> +		else if (mblen == 4)
> +		  { /* Conversion Fail */
> +		    l = MultiByteToWideChar (cp_from, 0, p, 1,
> +					     wbuf + wlen, NT_MAX_PATH - wlen);
> +		    wlen += l;
> +		    mblen = 1;
> +		    break;
> +		  }
> +		else if (p + mblen == tmpbuf + total_len)
> +		  { /* Multibyte char incomplete */
> +		    memcpy (stat->__value.__wchb, p, mblen);
> +		    stat->__count = mblen;
> +		    break;
> +		  }
> +		/* Retry conversion with extended length */
> +	      }
> +	}
> +      nlen = WideCharToMultiByte (cp_to, 0, wbuf, wlen,
> +				  ptr_to, *len_to, NULL, NULL);
>      }
>    else
>      {
>        /* Just copy */
> -      buf = (char *) HeapAlloc (GetProcessHeap (), 0, len_from);
> -      memcpy (buf, ptr_from, len_from);
> -      nlen = len_from;
> +      nlen = min (*len_to, len_from);
> +      memcpy (ptr_to, ptr_from, nlen);

if the *caller* checks for cp_to != cp_from, this memcpy could go
away and the caller could just use the already existing buffer.

Other than that, LGTM.


Thanks,
Corinna
