Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id C4651385DC00
 for <cygwin-patches@cygwin.com>; Wed,  3 Jun 2020 07:01:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C4651385DC00
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 05370tLk014398
 for <cygwin-patches@cygwin.com>; Wed, 3 Jun 2020 16:00:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 05370tLk014398
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 3 Jun 2020 16:01:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix screen distortion after less for
 native apps again.
Message-Id: <20200603160109.4144e59f56e655df26b52dc4@nifty.ne.jp>
In-Reply-To: <20200602124440.1925-1-takashi.yano@nifty.ne.jp>
References: <20200602124440.1925-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 03 Jun 2020 07:01:26 -0000

On Tue,  2 Jun 2020 21:44:40 +0900
Takashi Yano wrote:
> - Commit c4b060e3fe3bed05b3a69ccbcc20993ad85e163d seems to be not
>   enough. Fixed again.

This patch does not work as expected in Win10 1809.
I will submit v2 patch which is more essential shortly.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
