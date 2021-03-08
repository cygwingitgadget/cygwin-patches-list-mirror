Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id 7CF023850419
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 15:48:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7CF023850419
Received: from Express5800-S70 (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 128FmEoe021079
 for <cygwin-patches@cygwin.com>; Tue, 9 Mar 2021 00:48:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 128FmEoe021079
X-Nifty-SrcIP: [118.243.85.178]
Date: Tue, 9 Mar 2021 00:48:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Transfer input for native app only if the
 stdin is pcon.
Message-Id: <20210309004818.0e6973cfde7a563ab293e1ac@nifty.ne.jp>
In-Reply-To: <YEZDgPyUTu18fFD5@calimero.vinschen.de>
References: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
 <YEZDgPyUTu18fFD5@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 08 Mar 2021 15:48:38 -0000

On Mon, 8 Mar 2021 16:32:16 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Mar  8 23:55, Takashi Yano via Cygwin-patches wrote:
> > - Currently, transfer input is triggered even if the stdin of native
> >   app is not a pseudo console. With this patch it is triggered only
> >   if the stdin is a pseudo console.
> 
> do you have more patches in the loop?  I wonder if I should really start
> the test release cycle for 3.2.0 or if I should wait a bit...?

I'm sorry to submit patches one after another. However,
I think this should be the last one. Please go ahead.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
