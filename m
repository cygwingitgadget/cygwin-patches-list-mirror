Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 6ACEA3858D28
 for <cygwin-patches@cygwin.com>; Wed,  3 Nov 2021 14:15:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6ACEA3858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjPYI-1mJPpS08V8-00kzU9 for <cygwin-patches@cygwin.com>; Wed, 03 Nov 2021
 15:15:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 30202A810A5; Wed,  3 Nov 2021 15:15:35 +0100 (CET)
Date: Wed, 3 Nov 2021 15:15:35 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Prevent the exec'ed bash from exiting
 by Ctrl-C.
Message-ID: <YYKZhxejpTLsdn67@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211103061442.774-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211103061442.774-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:VOOjTqNawX5cTvDMmJOXhrEI2bZgAHPgCmLEx4q1HfUl0HwmrE9
 41d5xkRrIHUsrejW2q244IjE0WI/KccczsNFPoK4wt/CQQw+5TE8dRTuw1ZydEzdqDIaiD+
 DxYIlxgOlBLmh1IGGi/22ACsK/0+vkAeqzk9TnCzZ2ay9OUIqM/EzIWwLNpCl983auxUE2v
 MTI4WKSyq0RUJKsj7k/WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGiP9tyEBSo=:nFasUdns9obBQNzN1RrwhY
 n4F1EcGDgmXZT/+WdTdvMpf742UTmPp4zdrZyiD1SxdsjnCh4iy3bgO4B/6LHBZYStO9JMMjj
 hvkYlPCjKhsoUTfwFPTjZvnQ7sfMN0o5erZnOdRFHcXWvdlLQ0PtqaJ6TDOGaH780PsTTySCh
 w9cXPQiB8viEZOV9UNFr+BWA62afYV7Sg8VYNbB6CHZWfynXKPnm0anWbEiQ2PGM7b3OXFkds
 CVLsko3YkxwdEMWr6dYiA77G7ccHDoSbp/acW9Sy8Yawp0KSz2PDtobZ822BweKSG44gUymbI
 iQ2JRPLp07HHa0XSfon3Qv0WUvKviD29KJhbFPwkxiL7dtqaDpMsjSv2+B9x7PpAvoOzoV9IJ
 kHX02JGPWr9qK4UlXsdELqrDi31d105FeEIjkdcFeVxGMaKICi0nf0vj6pkOc6vW8jqfq3KMM
 atgQVSi4Io6NXsrWEPsmwQ+J/NQXx1SmS/T68UIZ6gNs+rt09Hkb5GSRsdXklCybsOujEpCTl
 BQpoCTUrTKf89Ut5IUxkJHsNLrRkrFFrjVr2XJZl72uRL/ouoLU9RaZ7wQOGxb9wU43sZUmkt
 as4UUlBz67gmA8mPyD+SVjziuF0DSphwVAm4xdhqomcObmxTAeWb0PVJXSsh3TMuLapLAy+0t
 OQtoAkr7YWNn/gJikpBniBmkdcLjp6lvPCZ8x6P/2Vs9eTqCFikPraX1XwCWxdYKgsRgAMaYG
 ZPG0EyAKWXxXRD2y
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 03 Nov 2021 14:15:39 -0000

On Nov  3 15:14, Takashi Yano wrote:
> - Currently, bash occasionally exits by Ctrl-C with the following
>   scenario.
>     1) Start bash in the command prompt.
>     2) Run 'exec bash'.
>     3) Press Ctrl-C several times.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/sigproc.cc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 8e70a9329..97211edcf 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -594,6 +594,14 @@ sig_send (_pinfo *p, siginfo_t& si, _cygtls *tls)
>        p = myself;
>      }
>  
> +  /* If myself is the stub process, send signal to the child process
> +     rather than myself. The fact that myself->dwProcessId is not equal
> +     to the current process id indicates myself is the stub process. */
> +  if (its_me && myself->dwProcessId != GetCurrentProcessId ())
> +    {
> +      wait_for_completion = false;
> +      its_me = false;
> +    }
>  
>    if (its_me)
>      sendsig = my_sendsig;
> -- 
> 2.33.0

Pushed.


Thanks,
Corinna
