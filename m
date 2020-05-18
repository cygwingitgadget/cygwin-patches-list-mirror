Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id EA912386F02B
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 05:37:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EA912386F02B
Received: from Express5800-S70 (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 04I5aq6O027069
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 14:36:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04I5aq6O027069
X-Nifty-SrcIP: [124.155.40.7]
Date: Mon, 18 May 2020 14:36:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
Message-Id: <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
In-Reply-To: <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 18 May 2020 05:37:07 -0000

On Mon, 18 May 2020 14:25:19 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> However, mc hangs by several operations.
> 
> To reproduce this:
> 1. Start mc with 'env SHELL=tcsh mc -a'

I mean 'env SHELL=/bin/tcsh mc -a'

> 2. Select a file using up/down cursor keys.
> 3. Press F3 (View) key.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
