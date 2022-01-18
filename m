Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id A90BB3857C46
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 11:05:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A90BB3857C46
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIbzB-1n4ZE71MOL-00EeRC for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022
 12:05:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 596A3A8096F; Tue, 18 Jan 2022 12:05:21 +0100 (CET)
Date: Tue, 18 Jan 2022 12:05:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fhandler_base: Fix double free caused when
 open() fails.
Message-ID: <Yeae8aAALPev8KvG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220117230507.387-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220117230507.387-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:o3+4d5uy67I5ThwMViukSVefrb1l10tNFZwkBuho5XWzZnPvJMc
 TEsYmYHFZ5YV8r20wzPu97BthwpxmI/0w4+G3eX1I4tQHWfoEVJGgxO0pF4GFAEeHm0mnMf
 xthV28K0MXNFPtpnroRzCP5Hxm0qzuVmvI6Ka5B2keebuW6b8m4//t+4oo3S01/wUy0PqbX
 /X5VJgA3Llo4eKrBvE5IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eFx58rWYpb0=:MvxiUqlsQo4C9H9S6UEm+E
 O8byYmvdtvT0gpLFsTaDJlAFeOpGcCMzvmOFujC5G4Ty7vKs8yuasOgUwAt8TXILUTBzFhi5R
 yLxt+Xhp30SRgTiC10+Z+EKmwtUhcbLbTjVN5CKjdptemHXwFoCpNtp4h8U6W1PqeQMyTI8NS
 EwVLgpjODr09xbK+Dv8hwYZnNAHLS7RXlOM+jHqmsNL76H/h2X7kKwWfEdqQ+L/BwTbkZnR+L
 HPwctjpEkSJZJcO6hatp77lQ+r+xApM/sgU55ylRBluTbPKTz5Jd7BzUdp16D3I+l+xHnoXaj
 9brnCfd/+xD8CbA9+UYsM61CW2V3zHZvl0RP9GUqtEI/kHMyVEJHl+z8QbAdylgrwkzI1ih8F
 8kxnGMdNBzCk/sPj2prJLAoKqRFsY0Src3mnweBevS52UsFG073HiUiToE2A5j2Pv0kdTv9t5
 loa3y6l+5Hb10xX0NGyqAFM3R6UthEbHcVhN6tMgI2Xhxs9YcHSBi9heLWoHrEP6Uw1B5DwPy
 OU0m9bBIx5SJzf70UKKefuIlf7fRAR5fdEtce9436gx0JpLM/H1feSKzIIrNGhg/3Wp45AtfW
 Qel4tNaKDSgiktnSU2l75e5Mp8bJxc7f2jYLyAlrUBNhaGun7rYDYXGOYhJlLBk71H9LJkHCo
 j4ZAxcBLqFd+23fuNP29DQfnRsPhMcNgcqd180WqkaEb7bCS9STiGqbimsRuqaZYDEGGOvyRX
 SbfytFXV616nU41f
X-Spam-Status: No, score=-96.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Tue, 18 Jan 2022 11:05:27 -0000

On Jan 18 08:05, Takashi Yano wrote:
> - When open fails, archetype stored in archetypes[] is not cleared.
>   This causes double free when next open fail. This patch fixes the
>   issue.
> 
> Addresses:
>   https://cygwin.com/pipermail/cygwin/2022-January/250518.html
> ---
>  winsup/cygwin/fhandler.cc   | 4 ++--
>  winsup/cygwin/release/3.3.4 | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)

Yup, please push.


Thanks,
corinna
