Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 8325A3850414
 for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020 08:59:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8325A3850414
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAfQe-1kW54m0FWi-00B00J for <cygwin-patches@cygwin.com>; Mon, 23 Nov 2020
 09:59:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 822E3A80A56; Mon, 23 Nov 2020 09:58:59 +0100 (CET)
Date: Mon, 23 Nov 2020 09:58:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Discard "OSC Ps; ? BEL/ST" in pseudo
 console output.
Message-ID: <20201123085859.GN303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201123052815.761-1-takashi.yano@nifty.ne.jp>
 <20201123052815.761-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123052815.761-3-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:EUb9bPWGoyVz5y1QbBC95PcEGAYATddgyMoFfW708k+5dvW21dg
 LTzjbMYQVwq1VbafuW2WK7gVKD3E4jjPcqtRhToDMKmugnUhOEO4f0OnwhljYb0rGFHuNHS
 8R6cowvpUUR+FQY8sRal2yzCqGGBfGBVBGoYXS7gJ4ORXAtZnUzI80gE151HFQ8v+jSZzLr
 2Y6fj2JuSohRMA5kRkZ7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kV0MXoYkQx4=:PAJ2r/r7BN7PjUDjm02+No
 UWItALOvxg5EtuF5xNAraX5wmKUSN37sVdoPKZaCrEzX+aWM9DMjhsijEX7qb9N3jIDYk7cSs
 0WgqAvG0qblvu0qtdhEHp7LscF8LERrMFygLlHJskjJn0twVwNnj0nKTeCIOyux18xvkwavKm
 nDoVdZF+S2Xr8BD0rkfnW7QgWbZY9OC9WLt2q6OwdMtfcw/jkuXyNFXD17v1zYNEkCoZEqldb
 0t/FrP1pkiBz6o11EDHx2F2THpM0rxQq+xniU0FSLBehLhPmpMw0RP+igUb+kM1ZuHhle2fXt
 uJv1fgFRQgL7Bd1Qsie6t0PWdqVUlIygtkJZgARD9qFbyPWpTX7KfE0LzyKF+qSF9wLx1xGGV
 cB+ApMx+K2ZZHcSHtgdkzETR8UQHD6Db47kw9y1cU7qdzoeIuZITZNd1Nxjw1Ee9cGyUKl1i+
 z02/trFAeA==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 23 Nov 2020 08:59:02 -0000

Hi Takashi,

just a small style nit:

On Nov 23 14:28, Takashi Yano via Cygwin-patches wrote:
> - If vim is executed in WSL in mintty, some garbage string caused
>   by "OSC Ps;? BEL/ST" will be shown in some situations. This patch
>   fixes the issue by removing "OSC Ps;? BEL/ST" from pseudo console
>   output.
> ---
>  winsup/cygwin/fhandler_tty.cc | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 911945675..38285c7f4 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2069,6 +2069,36 @@ fhandler_pty_master::pty_master_fwd_thread ()
>  	    else
>  	      state = 0;
>  
> +	  /* Remove OSC Ps ; ? BEL/ST */
> +	  for (DWORD i=0; i<rlen; i++)
                     ^^^  ^^^^^^
                     spaces

Thanks,
Corinna
