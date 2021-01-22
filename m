Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id E449B3890417
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 11:40:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E449B3890417
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 10MBeP34029637
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 20:40:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 10MBeP34029637
X-Nifty-SrcIP: [122.249.67.108]
Date: Fri, 22 Jan 2021 20:40:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Improve pseudo console support.
Message-Id: <20210122204026.06a4ef5454034b4de6a52291@nifty.ne.jp>
In-Reply-To: <20210122095028.GC810271@calimero.vinschen.de>
References: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
 <20210122095028.GC810271@calimero.vinschen.de>
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
X-List-Received-Date: Fri, 22 Jan 2021 11:40:59 -0000

On Fri, 22 Jan 2021 10:50:28 +0100
Corinna Vinschen wrote:
> On Jan 22 05:58, Takashi Yano via Cygwin-patches wrote:
> > The new implementation of pseudo console support by commit bb428520
> > provides the important advantages, while there also has been several
> > disadvantages compared to the previous implementation.
> > 
> > These patches overturn some of them.
> > 
> > The disadvantage:
> >  1) The cygwin program which calls console API directly does not work.
> > is supposed to be able to be overcome as well, however, I am not sure
> > it is worth enough. This will need a lot of hooks for console APIs.
> 
> Definitely not.  We should really not cave in to such expectations.
> Cygwin apps are POSIX apps in the first place and should use the API
> provided by Cygwin and other Cygwin libs.  Yes, there are border cases
> like the X server or cygrunsrv, but these are limited and should stay
> limited.

I agree. I will stop working on it.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
