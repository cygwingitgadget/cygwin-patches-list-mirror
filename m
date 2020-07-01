Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 654E33861029
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 07:28:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 654E33861029
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mv3I0-1izwbi0MxU-00r3u8 for <cygwin-patches@cygwin.com>; Wed, 01 Jul 2020
 09:28:02 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2622EA80991; Wed,  1 Jul 2020 09:27:59 +0200 (CEST)
Date: Wed, 1 Jul 2020 09:27:59 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty, termios: Unify thoughts of read ahead
 beffer handling.
Message-ID: <20200701072759.GJ3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200630111250.2724-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630111250.2724-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:J3xdnwhtgdTT5J5UYH0crNf/fOUY66cM5KniqHmL/moGCemoi+4
 TBS/EIypZCoDW6Pn5QMD4K0PLoGjYwLKnP/aRwL/HS8R4LCxXJcY2eLZPJvLRm/MPUi9OnM
 AttKCiwKEJVKYm3P9+7JUn9YXC5XPgP4/l5VOX0DWg7nuO+ECPDs5Lq4nATTiABzDHVX1Z6
 /KNg3ThWULR2V6HdgvCRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NwQ4TtzsIE=:bv3rYUEI6UCvYdZyt+WTgZ
 tGCJJaDLksm4/7xHVlmB1MQN+MOJKI05H3DDP4ZjHmAqCUOG2jdC/rwz2DMZGFHNES3B+/Mo/
 X6fa8/hnTSo9zdz1UDCNXqV3j9wzG0xUGS6yLw9LV3EraQDlQ/CDzDLU25WHHuj8oklnKjwsQ
 6cErzY6aoXJECn2BKG4LpMpLyhfiA2a2GT+6BKf2cQRWmncjyUj3cNYf/QAXuXmW3TLGuoqgh
 G+TQJ5Kc7zi+o1xXG9vNk2UpbCjCybKmFDPgatJf8tI7uAJFKAil15JfTrWigSgRjzdjhJYBn
 7jeA8+AaSy/3+6h2tYx+G/cvA+mroe74gE96ZYFMDMetBChfvjPjg/6s39KnsZOlHTiVk4Ak/
 MU8JSIPTv87gHUb0kLQ83ZfXJ7SekvuQM+rUqUlVcK1kIMAsVkGH8aiE6McVTv0rgnOBWnK1a
 IM+o8DORpq3gQReHCcYiD0ZpYqkEC05CboOMCk7F2O4LAzIS6VrdofvU5aUh0hDd3rcou6BbQ
 nnLVoCaKuVnn7zu9jjKPu/lFzm+Rn1CH28r6HIRswpzrm7ZyuZtjWQzH2o21Gu6R0ZL4iT6QQ
 6MQYjQRaYS4kQlP4bEwLry31bcmOxYvNrOGoUAPi2dGzedtqATLUbdrPE3c7ZKNxarfOBnvI3
 /cpN8H9gEm67L/2SxoTbF6+euUC7MKh/d2TozXsCpLahl4v4gO7y87hB0y2aLKdmqU8N548iw
 IEymS5QCkht2kr6gbI3BoUmyY8bznVGIEEA0TyWeFBs+ZgTLgYGQlhUfLsygVfhpP2/nwHXs1
 JDnU8otUQbAIHCSJeJIN/4CDvau8Ri8ExXSG4pFgTGKvjJlMGp97aCcYq0lCeYQZGTfpp/d
X-Spam-Status: No, score=-99.3 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 01 Jul 2020 07:28:04 -0000

On Jun 30 20:12, Takashi Yano via Cygwin-patches wrote:
> - Return value of eat_readahead() is redefined. The return values
>   of fhandler_termios::eat_readahead() and fhandler_pty_slave::
>   eat_readahead() were little bit different. This patch unifies
>   them to number of bytes eaten by eat_readahead().
> - Considerration for raixget() is added to fhandler_pty_master::
>   accept_input() code.
> - Transfering contents of read ahead buffer in
>   fhandler_pty_master::transfer_input_to_pcon() is removed since
>   it is not necessary.
> - fhandler_pty_slave::eat_readahead() ckecks EOL only when ICANON
>   is set.
> - Guard for _POSIX_VDISABLE is added in checking EOL.
> ---
>  winsup/cygwin/fhandler_termios.cc | 20 ++++++++---------
>  winsup/cygwin/fhandler_tty.cc     | 37 +++++++++++++------------------
>  2 files changed, 26 insertions(+), 31 deletions(-)

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
