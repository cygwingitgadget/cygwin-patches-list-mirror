Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 3068A3857C6C
 for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2020 13:39:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3068A3857C6C
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 089DdR29020397
 for <cygwin-patches@cygwin.com>; Wed, 9 Sep 2020 22:39:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 089DdR29020397
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 9 Sep 2020 22:39:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Revise convert_mb_str() function.
Message-Id: <20200909223928.539aa809096135ba629c9733@nifty.ne.jp>
In-Reply-To: <20200909080721.409-2-takashi.yano@nifty.ne.jp>
References: <20200909080721.409-1-takashi.yano@nifty.ne.jp>
 <20200909080721.409-2-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Wed, 09 Sep 2020 13:39:48 -0000

On Wed,  9 Sep 2020 17:07:20 +0900
Takashi Yano wrote:
> +	    /* Max bytes in multibyte char is 6. */
> +	    for (mblen = 1; mblen <= 6; mblen ++)

Sorry, I misunderstood that the max utf-8 char length is 6.
Actually, it is 4, therefore mbstate_t can be used.

I will submit v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
