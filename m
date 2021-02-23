Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 1824F3857C66
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 13:34:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1824F3857C66
Received: from Express5800-S70 (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 11NDXtJu012500
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 22:33:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 11NDXtJu012500
X-Nifty-SrcIP: [118.243.85.178]
Date: Tue, 23 Feb 2021 22:33:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
Message-Id: <20210223223358.96ba58e9d805b6f0caf3cf4b@nifty.ne.jp>
In-Reply-To: <20210223221352.aa792dd9afe6c2afbd364b17@nifty.ne.jp>
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
 <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
 <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
 <YDO4M0jllqibv4aq@calimero.vinschen.de>
 <22bb210b-bb7d-3863-e2e9-0394e506cae3@towo.net>
 <20210223221352.aa792dd9afe6c2afbd364b17@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 23 Feb 2021 13:34:29 -0000

On Tue, 23 Feb 2021 22:13:52 +0900
Takashi Yano wrote:
> Hi Thomas,
> 
> On Tue, 23 Feb 2021 12:24:09 +0100
> Thomas Wolff wrote:
> > I've downloaded yesterday's snapshot (2021-02-22) for some testing.
> > If I compile mintty (which passes without problem) and try to run it, it 
> > just exits silently (no window popped up).
> > After reverting to 3.1.7, it runs just fine (even the one compiled with 
> > the snapshot).
> 
> Thanks for testing. However, I cannot reproduce your problem.
> I downloaded mintty-3.4.6-1-src.tar.xz and extract it.
> Then run
> cygport mintty-3.4.6-1.cygport prep
> cygport mintty-3.4.6-1.cygport compile
> 
> The binary in build/bin directory works with cygwin snapshot
> 2021-02-22. I have tried both 32bit and 64bit build, and both
> work without problem.
> 
> Could you please provide some more information?

Difference of compiler version?
I am using gcc-g++ 10.2.0-1.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
