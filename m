Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 38DC8384802F
 for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021 08:47:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 38DC8384802F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MScox-1l6Ysz2IXp-00SyIK for <cygwin-patches@cygwin.com>; Tue, 20 Apr 2021
 10:47:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1B42FA80EDA; Tue, 20 Apr 2021 10:47:12 +0200 (CEST)
Date: Tue, 20 Apr 2021 10:47:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Fix race issues.
Message-ID: <YH6VEDovWFJ2y1pI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419103046.21838-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:UU62EXmUWDfTHuyyk6LoLx6IG+/SygVvVtNBBT+sgxB/UW9o0hK
 5sntSnQzo0BP8Bszs1djpJbtdk4lDDYLA01NvXmuHLF3yQrM/y39/T9oyYrnsSp8goH6fqS
 zpL3XLGtXqNGmh5E7AUGhRMtzsoBXZ27dW11IQTF8C94lWi++yWketXx3e+Rh0nHI2EqUnV
 lbYjZyY6v6aZQoP55UCWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:59ZrxjKwOq4=:NoKTPa/UdF1VFf8ds4KzMw
 D790Fxa5aBGkTYYZnwLCgWvhnf2j1ye5PgEnZxPy3F7dUxTOWjIKQBbfn9VLYp40mcbcErC/V
 CwM5D00pQubc+ndOzwsndxD+hlo7ZFbPc7Il248A7YpEcHob7uAGcf9BKrcJLcBU29iorP/vd
 GYSM2BWrqxYBZEqj51fgwwWrU1w30cT3pjoJvd9Luu0jGczijqdPAovdfmJ9OMrYqI6IRjmQB
 LhE5Fzhx14ItpOtcgYwFaHlbpDea8pgt76ocup7Q5VHnBTmyDhIMNY/wDz5t/xwVe2b1+7ZB2
 raxewYF//E4opAnLw1ukYNctDY+L/2fFWAAs/7zacArB4Fi7p3V1pNvmMmAt/aBoxkDkxpa+k
 tK46XNcQzZEe/qTJtrZSua5B72cV8sN75ieWp4mN+NHOqVFl1VBhARLxw3QqoJhEGWuaVhIsA
 KWSuU7uic7Y7kw0gD7zgMGsk3YRkb1FnQykqIA3Ka8f9XEGHJ1Bjxp+xJkiF5ul428IrKZ3Re
 uHi27gynZ8M9rlbc4LxPes=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 20 Apr 2021 08:47:19 -0000

On Apr 19 19:30, Takashi Yano wrote:
> Takashi Yano (2):
>   Cygwin: console: Fix race issue regarding cons_master_thread().
>   Cygwin: pty: Fix race issue in inheritance of pseudo console.
> 
>  winsup/cygwin/fhandler_console.cc |  10 ++-
>  winsup/cygwin/fhandler_tty.cc     | 108 ++++++++++++++++++------------
>  winsup/cygwin/tty.cc              |  15 ++---
>  winsup/cygwin/tty.h               |   2 +-
>  4 files changed, 77 insertions(+), 58 deletions(-)
> 
> -- 
> 2.31.1

Pushed.


Thanks,
Corinna
