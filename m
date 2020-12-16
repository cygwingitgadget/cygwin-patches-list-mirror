Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id A0A41386F80B
 for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020 09:39:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A0A41386F80B
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MysmQ-1jubRj0e94-00vv3g for <cygwin-patches@cygwin.com>; Wed, 16 Dec 2020
 10:39:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A120AA82BD8; Wed, 16 Dec 2020 10:39:52 +0100 (CET)
Date: Wed, 16 Dec 2020 10:39:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Check response for CSI6n more strictly.
Message-ID: <20201216093952.GF4560@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201216091016.1890-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201216091016.1890-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:xGU+xk3p/63Tef37XykIIzZHaerkOoZJuP0eFVV6/S603rvkIZy
 KjLacetMZy8/AoSMGKcLfbXxbJSBFpC33SW3AK1Iq1HI31vQja75yEwwm+IxTtwznVljhTH
 s2pKP4ie7mOyXcIh3mqo4whWtmqS+EVUSYQO1pUsAKl9GQR/5S3LuDtaoP9IVuOzvY+fE2T
 Iql5ErrzQqrgBFiAUYKGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IS6mmNm10SY=:fFYEezHrjMAv9FxekIU9Un
 5GVLCbaSknHpVFnP+Ctr39Ft0J63O6PG8dRoIUTwXX3YYk9mQpiln6A9eSiC/Nc66H82DSw3A
 h2hyFjz6BT6M9ZZhlTCS1gQWTVrul6IE59S6rC1zR48SRM9QRzmq9rC4mDY5jQS4nzoI2a3BC
 ap4CuKLyTkTe7ruGQ+h0KQIPVB7DZEtTR8d9NSexO+KOccvCk3hBkAsb/Bmxa4vPFTowPAC8Q
 Q/oE5G8jT9vd04mr7HS02k54Dvc8pFFYQ0acC3ehYClOmiabcrExmIpao7BL0zvqSLkB3YjTt
 s0RXMsL82SrbOYe7tFFHalJQ2F9JZGKrUX8YIZERKZQYPHZgZjGcULjDze3sOi4aJMF0UEp4n
 zteLNewuP0xzbWvd+OQxAQmVQhm0a0hciWkJk1swiRKL9iYTJLnpwWizSovb4neKu+aSup7N3
 ZudQysCgWw==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Wed, 16 Dec 2020 09:39:56 -0000

On Dec 16 18:10, Takashi Yano via Cygwin-patches wrote:
> - Previous code to read response for CSI6n allows invalid response
>   such as "CSI Pl; Pc H" other than correct response "CSI Pl; Pc R".
>   With this patch, the response is checked more strictly.
> ---
>  winsup/cygwin/fhandler_tty.cc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 5f38ca8d3..77d9d9b47 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2682,7 +2682,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
>  	  len -= n;
>  	  *p = '\0';
>  	  char *p1 = strrchr (buf, '\033');
> -	  if (p1 == NULL || sscanf (p1, "\033[%d;%dR", &y1, &x1) != 2)
> +	  char c;
> +	  if (p1 == NULL || sscanf (p1, "\033[%d;%d%c", &y1, &x1, &c) != 3
> +	      || c != 'R')
>  	    continue;
>  	  wait_cnt = 0;
>  	  break;
> @@ -2715,7 +2717,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
>        len -= n;
>        *p = '\0';
>        char *p2 = strrchr (buf, '\033');
> -      if (p2 == NULL || sscanf (p2, "\033[%d;%dR", &y2, &x2) != 2)
> +      char c;
> +      if (p2 == NULL || sscanf (p2, "\033[%d;%d%c", &y2, &x2, &c) != 3
> +	  || c != 'R')
>  	continue;
>        break;
>      }
> -- 
> 2.29.2

Pushed.


Thanks,
Corinna
