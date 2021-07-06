Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 87168385E83D
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 14:00:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 87168385E83D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNc5b-1lqY6N0y9z-00P3Ar for <cygwin-patches@cygwin.com>; Tue, 06 Jul 2021
 16:00:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B72AAA80D68; Tue,  6 Jul 2021 16:00:55 +0200 (CEST)
Date: Tue, 6 Jul 2021 16:00:55 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix garbled input for non-ASCII chars.
Message-ID: <YORiF1RqkM4WGxwm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210623084216.777-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623084216.777-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:DqhuJbyDtLjGrvK/tIpEv9qLtgLWVjAsUD5l4iG9wn9Sj9+8daP
 +Re2FWD0xKWjeTPuDzCk+6UfOjTRoTEGfCPJShuBk6brGJ8+zya0sYUkSvxK/SS6z6t0ojx
 7SJtozhuYh76VyGmYXX/+19QzalZgBYD53yR5hWpUpnobvIxRpwdq70IljF3WUATESgDCDh
 u6JAzqJCPCzOJ0uOUJtqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O3DVa0n7ErQ=:QV4tdELfNvIPqpTtl8bxSG
 VXS/rrDiIYjxVfv2qqbUm2SRkaxbRkS5c26JC6dR5RYrYFTpSOT3IFHARaJ6lYHpPJkYwHO22
 lleE3Xxx9y0nHt8aFZhXRD38b568BF9x6x12MUWs8ekb0Lnn1jmrx8zCo5c3RP2o/1vXWpadk
 ITjzUyYzpLho8HvZe6Xzf3F+NBw9HrK75FWO3GLuU/EVTXk56giOBGPmnYFLF6HRLAGfXf3XR
 SK1DFRF1olSwexAYMocKipNfZXiWyk3SsY7LR9b1CxD4IlUyA64SheVbkv7z8cbsgv4uMJgHq
 sbiLL59KdV8j9biHz2AY1iZRv0fpKX/WWooVfzSWNCVAwU7y4WS+j8f/nHmPm1UNFWtmlhiva
 4j5Jnyje8J+OOWpJCbmXD5wGkcKXUM8GzqjiFvRutDotKGbmrGNBw2EYrwI9Jvy23q6ZSxgjo
 15Ho9nXrASFdB4oUzuxja2l/5IfaxTlA1ulURQdWBtJXEZwttsx83PRCaQ3MzxTbQUib/jfAm
 cjgHQygndqtaKl2rjbUbcxDX7EAg1OfvkeMEZsglG9GH+5LZGM2HGYpxducK3QxPRHseXe74g
 tTAbMwd8Rk+x020scRJgYiHbZv9Srf2dMqLb0HUicFLsiOTW3rcq6WcYDvvIFQNCIwQKaVOkF
 3JIAvsz7fbaz61QMS86Jc6q1SGgGSwUPXpSV++3by2/yUne0zBWZ/fxHKnf2wwUn9idfkLHsv
 6XWnKfinbFiaDJtm3ilHG/RCvOfnyzUDjpd9ZwOLnfYmStaGRtvFitf3ChcfRdu0Y0SVS8BDS
 8H7XBdbmoq7Q2iqMwUGUfMRlkSUodoLkQB2f559Oa3E6A8sWH4tNQLGRKYGSZiahd0NQr/D1X
 Ay0Rcj2cyl0qBME2qhzw==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 06 Jul 2021 14:00:59 -0000

On Jun 23 17:42, Takashi Yano wrote:
> - After the commit ff4440fc, non-ASCII input may sometimes be garbled.
>   This patch fixes the issue.
> 
>   Addresses: https://cygwin.com/pipermail/cygwin/2021-June/248775.html
> ---
>  winsup/cygwin/fhandler_console.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna
