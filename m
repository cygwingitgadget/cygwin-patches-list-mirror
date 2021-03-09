Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id 72C553857832
 for <cygwin-patches@cygwin.com>; Tue,  9 Mar 2021 03:23:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 72C553857832
Received: from Express5800-S70 (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 1293MdOD002820
 for <cygwin-patches@cygwin.com>; Tue, 9 Mar 2021 12:22:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1293MdOD002820
X-Nifty-SrcIP: [118.243.85.178]
Date: Tue, 9 Mar 2021 12:22:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Transfer input for native app only if the
 stdin is pcon.
Message-Id: <20210309122249.6b0a1ae4335f7cf89ed6c1d0@nifty.ne.jp>
In-Reply-To: <YEaOlWwJDe/3R7m/@calimero.vinschen.de>
References: <20210308145510.1164-1-takashi.yano@nifty.ne.jp>
 <YEZDgPyUTu18fFD5@calimero.vinschen.de>
 <20210309004818.0e6973cfde7a563ab293e1ac@nifty.ne.jp>
 <YEaOlWwJDe/3R7m/@calimero.vinschen.de>
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
X-List-Received-Date: Tue, 09 Mar 2021 03:23:07 -0000

On Mon, 8 Mar 2021 21:52:37 +0100
Corinna Vinschen wrote:
> On Mar  9 00:48, Takashi Yano via Cygwin-patches wrote:
> > On Mon, 8 Mar 2021 16:32:16 +0100
> > Corinna Vinschen wrote:
> > > Hi Takashi,
> > > 
> > > On Mar  8 23:55, Takashi Yano via Cygwin-patches wrote:
> > > > - Currently, transfer input is triggered even if the stdin of native
> > > >   app is not a pseudo console. With this patch it is triggered only
> > > >   if the stdin is a pseudo console.
> > > 
> > > do you have more patches in the loop?  I wonder if I should really start
> > > the test release cycle for 3.2.0 or if I should wait a bit...?
> > 
> > I'm sorry to submit patches one after another. However,
> > I think this should be the last one. Please go ahead.
> 
> Great, thanks!

I am very sorry but I would like to submit just one more patch.
I apologize to overturn the previous statement...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
