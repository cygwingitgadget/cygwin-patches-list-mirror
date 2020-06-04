Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 6F9E3386F477
 for <cygwin-patches@cygwin.com>; Thu,  4 Jun 2020 01:17:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6F9E3386F477
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 0541HJid008725
 for <cygwin-patches@cygwin.com>; Thu, 4 Jun 2020 10:17:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0541HJid008725
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 4 Jun 2020 10:17:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix screen distortion after less for
 native apps again.
Message-Id: <20200604101727.0a87578e067aa3a3eff5fca0@nifty.ne.jp>
In-Reply-To: <20200603094511.9-1-takashi.yano@nifty.ne.jp>
References: <20200603094511.9-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Thu, 04 Jun 2020 01:17:48 -0000

On Wed,  3 Jun 2020 18:45:11 +0900
Takashi Yano wrote:
> - Commit c4b060e3fe3bed05b3a69ccbcc20993ad85e163d seems to be not
>   enough. Moreover, it does not work as expected at all in Win10
>   1809. This patch essentially reverts that commit and add another
>   fix. After all, the cause of the problem was a race issue in
>   switch_to_pcon_out flag. That is, this flag is set when native
>   app starts, however, it is delayed by wait_pcon_fwd(). Since the
>   flag is not set yet when less starts, the data which should go
>   into the output_handle accidentally goes into output_handle_cyg.
>   This patch fixes the problem more essentially for the cause of
>   the problem than previous one.

I will submit v3 patch which removes unnecessary (and should not)
guard that uses output mutex.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
