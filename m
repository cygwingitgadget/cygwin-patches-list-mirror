Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 99B603857C68
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 15:33:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 99B603857C68
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFspV-1lXN9m1e2h-00HNQ5 for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 16:33:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E4D36A8266C; Mon,  8 Mar 2021 16:33:16 +0100 (CET)
Date: Mon, 8 Mar 2021 16:33:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Transfer input for native app only if the
 stdin is pcon.
Message-ID: <YEZDvMKvh2Qtpkv/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:BENRYmSvZEvGNcSjwHSym3ycJByUu9yphss9SYUMXFBKW6JUyBE
 J4sWmo3dN0RM797y37tH5OIuolO/2hwZbuR/idJTFiWe854706W+vZP8LhZW4PxzSAMvnbs
 TvZSZCJTzGfTL9Hh7VmsKMU6Br4Jl1d1Rlc6kdD+7Ai1BbRTPS2QhQ+KUDAt+Wps4lV7OeL
 WDHsPS6rMsEREkZKqYSjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8CZxwskHoOQ=:e3Jo5rYmamRr654qpvd1iV
 GCtgi08jeAnbdr06E+vkDCq3yxTM/V9w6loLvFRUsxA5qjaa1MsZnnS2Ux3HWphfcXrv0J/nK
 W+6OrNAlA46nPfs3kr1yNgs+78E8tRgnXxgQMHTV/AzQL789qI+ACEaS9QZ2NRGOjCkfIN3k4
 q8PSgBvJX+BVgzQUZMU4qlioxXkl9SEoSbN3h7V1ZaH3r/x6Y6zcdQda5o/bW373VSuQNydG1
 hyRnuFXu0HVoV3mGmzqL5PFH24JFlDsutWUyGg9JxARy7xWCbzYNsuW36SOOzbxdKu6xte6Mn
 KZe9yHw8n8Hm2Hep1xzK1l6P+XaQSWxnnZuLrgfigwevvNZlKpB+zaYO7I7TH4Z28tl4y15gP
 xhNufA3NNGKSeCvHF49RcNEYHZLfayFnisP+vGLWcTeNzvYG4sdQ1XZPAwhnkjJd7SV9tlXvv
 eIWAN4Grog==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 08 Mar 2021 15:33:20 -0000

On Mar  8 23:55, Takashi Yano via Cygwin-patches wrote:
> - Currently, transfer input is triggered even if the stdin of native
>   app is not a pseudo console. With this patch it is triggered only
>   if the stdin is a pseudo console.
> ---
>  winsup/cygwin/fhandler_tty.cc | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Pushed.


Thanks,
Corinna

