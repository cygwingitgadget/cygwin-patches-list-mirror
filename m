Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id D8A373892440
 for <cygwin-patches@cygwin.com>; Fri,  5 Mar 2021 15:12:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D8A373892440
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCbR7-1lQkiF2Ajb-009hIU for <cygwin-patches@cygwin.com>; Fri, 05 Mar 2021
 16:12:12 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1B0F3A8060B; Fri,  5 Mar 2021 16:12:12 +0100 (CET)
Date: Fri, 5 Mar 2021 16:12:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix a race issue in startup of pseudo
 console.
Message-ID: <YEJKTGlp2lC/jy0H@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210304085634.1659-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304085634.1659-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:1r42RVnA9NZZum4XhmPAwWFwsLDub9MPaD2LJsYMnHgZuYqfH3D
 XsPQ3XUB1RKdY+pAmSyo+4BW4xjc0XHgo/72GHVqZmE5vcIpXVtKHte0FUHnBQ1o3OueBxY
 TMfL34zuI2VdTQ5M1eMXxixDDuB9oln2j+ftmUIQdo2Q4uWMESbo0JaovscarRdJ925MyGb
 ThryzUSfUTLfUiQFa7Y5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dT/5v9z8Y7E=:dzrrtEvuANfU+KSyTmBrN9
 oWeItFv5FiRkHlfMCj8mbm5SxgRTvibXFyCYOaAUzOlzhZzGqf+DQul/F/toaXpM2jxjGDflt
 9QRjRBY9CAYsRQnR8UAsmgTIkASQGNqhK9g8JdZ6XJNkoGF56wH2j+61aYk+H/kxAxfG5TJGF
 aOeUWXf/UVr2Km6659diAnPsyBdTnyM+XHUH4eu/OJFAIuHGbH8Nfv2TQdxmlVFd0NRwKhOCD
 KT75hxB0r66ge+5enhX07Yaf+Zn+JCrTMYFDTe9A+MXWN/cpAx3YjMO00eBd8l4sjkGJ3ukE8
 JfML7st0zd9QFOH08oaTSH4Gr8vY5ZmNrR9bg1QAmP501eNoUat0bsj8spxGBihwM/6HWEVh4
 4EvP9NkgxzU8OzodLCiVuljNJOW4+O+iEo5iZEx6s2uEVvSmetYfAOsI0xIjPn+jvttTd6KKS
 nqyEZAcjKg==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 05 Mar 2021 15:12:15 -0000

On Mar  4 17:56, Takashi Yano via Cygwin-patches wrote:
> - If two non-cygwin apps are started simultaneously and this is the
>   first execution of non-cygwin apps in the pty, these occasionally
>   hang up. The cause is the race issue between term_has_pcon_cap(),
>   reset_switch_to_pcon() and setup_pseudoconsole(). This patch fixes
>   the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna
