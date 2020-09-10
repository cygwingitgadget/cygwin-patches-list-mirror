Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id DF32C3857830
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 00:00:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DF32C3857830
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 08A00Pvb022862
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 09:00:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08A00Pvb022862
X-Nifty-SrcIP: [124.155.38.192]
Date: Thu, 10 Sep 2020 09:00:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/2] Cygwin: pty: Changes regarding charset conversion.
Message-Id: <20200910090031.6d308400f21b443d7ca3976f@nifty.ne.jp>
In-Reply-To: <20200909214604.GZ4127@calimero.vinschen.de>
References: <20200909152800.791-1-takashi.yano@nifty.ne.jp>
 <20200909214604.GZ4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Thu, 10 Sep 2020 00:00:44 -0000

On Wed, 9 Sep 2020 23:46:04 +0200
Corinna Vinschen wrote:
> On Sep 10 00:27, Takashi Yano via Cygwin-patches wrote:
> > Takashi Yano (2):
> >   Cygwin: pty: Revise convert_mb_str() function.
> >   Cygwin: pty: Fix input charset for non-cygwin apps with disable_pcon.
> > 
> >  winsup/cygwin/fhandler_tty.cc | 151 +++++++++++++++++++++++-----------
> >  1 file changed, 103 insertions(+), 48 deletions(-)
> 
> Pushed.

Thanks.

> Do we really have to support UTF-7?  Is anybody actually using it?
> Usually Cygwin does not support UTF-7 at all.

term_code_page can never be UTF-7, however, GetConsoleCP() and
GetConsoleOutputCP() can be. Therefore, I think it is necessary
for non-cygwin apps if pseudo console is disabled.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
