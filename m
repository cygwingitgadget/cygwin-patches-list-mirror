Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 8BA74398E462
 for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2021 12:30:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8BA74398E462
Received: from Express5800-S70 (v040204.dynamic.ppp.asahi-net.or.jp
 [124.155.40.204]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 11ACULVx010873
 for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2021 21:30:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 11ACULVx010873
X-Nifty-SrcIP: [124.155.40.204]
Date: Wed, 10 Feb 2021 21:30:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Reduce unecessary input transfer.
Message-Id: <20210210213024.975a7e82dd9e03d65a164da6@nifty.ne.jp>
In-Reply-To: <20210210090259.25996-1-takashi.yano@nifty.ne.jp>
References: <20210210090259.25996-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 10 Feb 2021 12:30:52 -0000

On Wed, 10 Feb 2021 18:02:59 +0900
Takashi Yano wrote:
> - Currently, input transfer is performed every time one line is read(),
>   if the non-cygwin app is running in the background. With this patch,
>   transfer is triggered by setpgid() rather than read() so that the
>   unnecessary input transfer can be reduced much in that situation.
> ---
>  winsup/cygwin/fhandler.h      |  15 +-
>  winsup/cygwin/fhandler_tty.cc | 371 ++++++++++++++++++++--------------
>  winsup/cygwin/spawn.cc        |  76 ++++---
>  winsup/cygwin/tty.cc          |  89 ++++++++
>  winsup/cygwin/tty.h           |  16 +-
>  5 files changed, 371 insertions(+), 196 deletions(-)

Hmm. This patch seems to have some race issues.
Please wait for v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
