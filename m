Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id CA5E33870907
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:11:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CA5E33870907
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQeIA-1jsaFt239i-00NkrB for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 11:11:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1421EA80A4D; Mon,  7 Sep 2020 11:11:27 +0200 (CEST)
Date: Mon, 7 Sep 2020 11:11:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 2/3] regparm: make code highlight happy
Message-ID: <20200907091127.GH4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200905052711.13008-1-arthur2e5@aosc.io>
 <20200905052711.13008-2-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200905052711.13008-2-arthur2e5@aosc.io>
X-Provags-ID: V03:K1:5V/I+QAQ50Oemdct1cZvHTcG2GDeCSVZbAS8pFqv9DJP9wPnAbQ
 4Ek0Kqgrrok4m6ol2X5BwmG6MRst6uFeE2qWgLFA4/BlQaOaE+Oe1x+8U8EcJMSTrWfu/VE
 sJCURme0MbQTbmAhjGz7ylbIL6ouyVhKQFxycFlc4HLUayrs2KbSBFgoofCblsIV9quHLYg
 A1AkGJp4uoY1+GovHKz3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AAavMdm6nhY=:WW+kdGFjSvxQmN/43Dfjoi
 Pm7YnLrdGWXzKkeaBb+lrOhd+CuCA+2GJzpjM1PmasN+5Ikk4m1QRtcHib/IT/q37FKUSL1gy
 XDnN9+aPPdbDyzU67Ql9973k2wSaB6RSnvtSjHYIJwtwKJLFb4vp99T3fAbXZj52tAJBhst/3
 x/kC2Dx8IifvFO3o+1bZ5U2s8akY2jGN7KJXY+tK/41innYVvWA+F613R/sxHHpi9F2okIu2o
 +prYeo18cqjk0HDgtmsZM/ZTYdEtyI8vwIiiz9koXAmE/kz5egMkAAoY+wFVi2YTs/kr6fEyr
 diUJp51LNyHWSiSMkB1o/X4BlSrNcfCJ12MXaeHEvLkNbYr1xMbH4w4cjhIDei5APRxzrMdei
 cSvQOGbfdirzguMJeJhgsZ8Bf+wyn8wCxnWWDQvkN552xFhjGC4vzrv9AYgFFlhYpfHPWEGvz
 1ehXiBemV5y1Lg24qE0pF5WlJhFu0kPEw9ODgXwKNx1cFT5eMkG+Db2IGC/dOXG5Wr2Kgz2TJ
 AiLoermpYvVcH65cHqKSeXOsTUiPQ4fkvo3DYEHDw8kfLsWMI0wVdkXsfGxcwpugOCb/cB+ZV
 DI84argEXhLeaPFdikuI1kJ1bTt0bxFBx367sN/XHeee3STx8zhEr6ihujsmhL39mfwtZmdB3
 Os0bYVir7j/sWkI8h2KZ0lLPNk0LEJ+HN65yXscpDztudQGaP5hofoSvrjQKkoKZwUMeOD9n5
 Ac8Z7Hxx8SUPw28stkNoUStIp6Bt+XW0oojmeOH9YCkso/xZ3KNp+wc7ipS65gq17IARjpUgE
 fFB0woNEJEFKQXDZwIn44D7rdoc+TaobvztJit777NMrgxvufP0Yq+4r4msFkIEYqTjADt/SF
 32p2FPN50ozxH26NPooA==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 07 Sep 2020 09:11:30 -0000

On Sep  5 13:27, Mingye Wang wrote:
> Subject: [PATCH v4 2/3] regparm: make code highlight happy

-v, please?


Corinna

> ---
>  winsup/cygwin/regparm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/regparm.h b/winsup/cygwin/regparm.h
> index cce1bab4a..a14c501db 100644
> --- a/winsup/cygwin/regparm.h
> +++ b/winsup/cygwin/regparm.h
> @@ -8,7 +8,7 @@ details. */
>  
>  #pragma once
>  
> -#if defined (__x86_64__) || defined (__CYGMAGIC__)
> +#if defined (__x86_64__) || defined (__CYGMAGIC__) || !defined (__GNUC__)
>  # define __reg1
>  # define __reg2
>  # define __reg3
> -- 
> 2.20.1.windows.1
