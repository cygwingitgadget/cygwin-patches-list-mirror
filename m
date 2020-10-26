Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 9D552386F022
 for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2020 09:05:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9D552386F022
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrhLu-1k0xc41KpI-00nj5f for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2020
 10:05:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EF653A81020; Mon, 26 Oct 2020 10:05:19 +0100 (CET)
Date: Mon, 26 Oct 2020 10:05:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix race condition in initialization of
 pseudo console.
Message-ID: <20201026090519.GY5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201026082931.85-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026082931.85-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:Npydp1JYBeyoyDOo3vRoIAdb8SJCz5Ie00Oc/15HaNuOCg9uciC
 E6frBlm/bbxcIlU5yzczLc9RMbKWQN9klg9hZwidmUM8XI+pj2gGN64i4dzqw5rwlLVzCMU
 mCK6MCb7VKQgBortDrrI0PYTzNLzZYFXs/2+Q2zCSSEM5lKQJ1xaOVe+NZTMjeOfqn37mDX
 fsm3h6njxpoCOSsHY7I8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ISky8uoCqk=:Dt39+RoQChkIbz1vJJurj0
 RMBLXI2r90RbRiMFqg4DeXi7PHLr5jhC9K1M9ncyidUt+bFqBvkh9uQbMyXbhm/CM5yIVwPjE
 cEPcI/8iF4TN9ZeTAd3OqOqVGPZY/OGo9+esLA67rVvdixH0v0k5IOdF9TWepnqVqr3D1+8PK
 BUdvTFFi6A56X3UzlYQAQxkSIIuIRviMlToVpdd8rsK0S66dPNxqxfMAcgaYGBbPKAg7QOkjs
 T1R1gQS6guInN+X7BhthR+A9gp7i+bFqgtwKwDw8V/5zntQBdy9897YXXjzVLDhGqWR7M8tWp
 Jq1rblMZmNvGQXOXZuj/Zr4MHV1nEaRcI21Ja48rYC2/rYGG+drFJFclt1LMYrbOkgWzWss/y
 8FHoatUTEZZOxgYfC2A9Mh0njVyaRs1DQKDKFi7qOqnFDlH3+0Mu5thDfQ/15Bqt+Hy5O3/7g
 Fe4V6dXXhw==
X-Spam-Status: No, score=-100.7 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 26 Oct 2020 09:05:22 -0000

On Oct 26 17:29, Takashi Yano via Cygwin-patches wrote:
> - If output of non-cygwin process is piped to cygwin process, such
>   as less, the non-cygwin process sometimes fails to start and hangs.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 9 ---------
>  1 file changed, 9 deletions(-)

Pushed.


Thanks,
Corinna
