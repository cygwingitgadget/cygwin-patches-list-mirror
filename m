Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 9CC733857C68
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 15:32:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9CC733857C68
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIKs0-1lVRUj00c0-00EJSI for <cygwin-patches@cygwin.com>; Mon, 08 Mar 2021
 16:32:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7D2D0A8266C; Mon,  8 Mar 2021 16:32:16 +0100 (CET)
Date: Mon, 8 Mar 2021 16:32:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: pty: Transfer input for native app only if the
 stdin is pcon.
Message-ID: <YEZDgPyUTu18fFD5@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:2FRVZUUO3TrugWhACaVyzfi5WDp5GkTJWaB+XbPc6gKIKLKfOXT
 YSiZOkdVlkFmyPEjF65deRcHBZdYpOXKFotDqKSgQl/AMTLejjYDlm6M7iYD2asPbcFi/T1
 cRsnBFLTrM8ZJMRZ9pM1hpm6oQO/E+jwwJiiouOnXuKT9/k89JhCDtIB5/saXrG757LSAwV
 9gpqw3dVHBtJk1DrXb+Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TE+8tZaf/KM=:NzMYox75IdKaxps1jYKpyy
 fL+5ymvsWVJ1CWR1ki1sx18lJ2UQsT1hgBFuxpcF7p9alO5zFxQAdC80/FIGoUkUEHOMMMkow
 9SuzpZrqkuWPbWcheoHDL7VlgvAbAbdIxKGn7PSBMBhX4f39DooR1hstSHSwBjVZwKy/ZGTxd
 RM/HGdl9Db7o5Go/z4KxxkgB66q8uHQmwXCBGh8A15HUJzsRccGsWuLgZBUtWq5SsnsNpeu5M
 nMpeSX7ZIa8iYH6ItFewxAcTjFCmHQ1UNDgeq9Kv30okDnHJLLIr7Xjz/WK2shFv7lR+QO67S
 gimnONosMo15pCGzpzaYsYKiZKM0mpEBtJZ2cdKFlksPju1fql8L/5ZTW6m9QthPo3c2WFRYC
 QRUzcJw8zItl4DOwUS7eCkPGXhGmYwmXAX9fUe33jdCwgHpcA4qUX2xRTthJMjiLDDdlG/RQO
 ckE0PZC5wQ==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 08 Mar 2021 15:32:21 -0000

Hi Takashi,

On Mar  8 23:55, Takashi Yano via Cygwin-patches wrote:
> - Currently, transfer input is triggered even if the stdin of native
>   app is not a pseudo console. With this patch it is triggered only
>   if the stdin is a pseudo console.

do you have more patches in the loop?  I wonder if I should really start
the test release cycle for 3.2.0 or if I should wait a bit...?


Thanks,
Corinna
