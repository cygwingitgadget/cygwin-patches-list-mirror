Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id A3DDA3854805
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 12:52:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A3DDA3854805
Received: from Express5800-S70 (ae236159.dynamic.ppp.asahi-net.or.jp
 [14.3.236.159]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 12NCqPjv014714
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 21:52:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 12NCqPjv014714
X-Nifty-SrcIP: [14.3.236.159]
Date: Tue, 23 Mar 2021 21:52:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-Id: <20210323215227.eda395caff35c4d5aa9b9007@nifty.ne.jp>
In-Reply-To: <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <20210323214206.ebb5b1cb80a8b71ead4e8cda@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 23 Mar 2021 12:52:50 -0000

On Tue, 23 Mar 2021 21:42:06 +0900
Takashi Yano wrote:
> On Tue, 23 Mar 2021 21:32:12 +0900
> Takashi Yano wrote:
> > I try to check run.exe behaviour and noticed that
> > run cmd.exe
> > and
> > run cat.exe
> > does not work with cygwin 3.0.7 and 3.2.0 (TEST) while these
> > work in 3.1.7.
> 
> In obove cases, cmd.exe and cat.exe is running in *hidden* console,
> therefore nothing is shown. Right?

In what situation are
  psi->cb = sizeof (STARTUPINFO);
  psi->hStdInput  = GetStdHandle (STD_INPUT_HANDLE);
  psi->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
  psi->hStdError  = GetStdHandle (STD_ERROR_HANDLE);
these handles used?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
