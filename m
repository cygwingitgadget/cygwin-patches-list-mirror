Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 3440A384B060
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 11:49:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3440A384B060
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 10SBnScC030384
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 20:49:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 10SBnScC030384
X-Nifty-SrcIP: [122.249.67.108]
Date: Thu, 28 Jan 2021 20:49:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: console: Make read() thread-safe.
Message-Id: <20210128204930.93d8270735cf62e7e3a10e05@nifty.ne.jp>
In-Reply-To: <20210128111409.581-2-takashi.yano@nifty.ne.jp>
References: <20210128111409.581-1-takashi.yano@nifty.ne.jp>
 <20210128111409.581-2-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Thu, 28 Jan 2021 11:49:49 -0000

On Thu, 28 Jan 2021 20:14:08 +0900
Takashi Yano wrote:
> - Currently read() is somehow not thread-safe. This patch fixes the
>   issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 7 +++----
>  winsup/cygwin/select.cc           | 3 ---
>  2 files changed, 3 insertions(+), 7 deletions(-)

Sorry, this does not seem to be enough. Please wait a while.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
