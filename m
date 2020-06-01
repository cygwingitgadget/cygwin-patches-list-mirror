Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id EF137386F432
 for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2020 06:21:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EF137386F432
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 0516KxDw009826
 for <cygwin-patches@cygwin.com>; Mon, 1 Jun 2020 15:21:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0516KxDw009826
X-Nifty-SrcIP: [124.155.38.192]
Date: Mon, 1 Jun 2020 15:21:15 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix screen distortion after using less for
 native apps.
Message-Id: <20200601152115.3b5492035b186072ea6ead5c@nifty.ne.jp>
In-Reply-To: <20200601061618.893-1-takashi.yano@nifty.ne.jp>
References: <20200601061618.893-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 01 Jun 2020 06:21:18 -0000

Hi Corinna,

On Mon,  1 Jun 2020 15:16:18 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> - If the output of non-cygwin apps is browsed using less, screen is
>   ocasionally distorted after less exits. This frequently happens
>   if cmd.exe is executed after less. This patch fixes the issue.

I have submitted this patch, but it's up to you to decide whether
to include it in the cygwin 3.1.5 release.

I apologize again for the submission at the very last minute.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
