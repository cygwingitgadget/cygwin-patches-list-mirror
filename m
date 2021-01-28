Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 74FCD384B060
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 12:24:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 74FCD384B060
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 10SCO1O6009233
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 21:24:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 10SCO1O6009233
X-Nifty-SrcIP: [122.249.67.108]
Date: Thu, 28 Jan 2021 21:24:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: console: Make read() thread-safe.
Message-Id: <20210128212403.b3bca42a6af56c4281b77f86@nifty.ne.jp>
In-Reply-To: <20210128122010.1424-2-takashi.yano@nifty.ne.jp>
References: <20210128122010.1424-1-takashi.yano@nifty.ne.jp>
 <20210128122010.1424-2-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 28 Jan 2021 12:24:16 -0000

On Thu, 28 Jan 2021 21:20:09 +0900
Takashi Yano wrote:
> - Currently read() is somehow not thread-safe. This patch fixes the
>   issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Sorry again. This also has a problem......

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
