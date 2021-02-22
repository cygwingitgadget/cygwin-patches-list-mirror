Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id F34823857809
 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021 13:28:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F34823857809
Received: from Express5800-S70 (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 11MDSFqc003753
 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021 22:28:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11MDSFqc003753
X-Nifty-SrcIP: [118.243.85.178]
Date: Mon, 22 Feb 2021 22:28:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
Message-Id: <20210222222816.90c09a753de37dbc12d993e5@nifty.ne.jp>
In-Reply-To: <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
 <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
 <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
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
X-List-Received-Date: Mon, 22 Feb 2021 13:28:31 -0000

On Mon, 22 Feb 2021 20:41:00 +0900
Takashi Yano wrote:
> On Mon, 22 Feb 2021 10:51:19 +0100
> Corinna Vinschen wrote:
> > So, what do you think is the state of the console code, Takashi?
> > Shall we start a release cycle next week?
> 
> I think all the fixes and improvements that come to mind at this
> point have been completed. As for releasing, I believe I've done
> enough testing, but honestly I'm not without anxiety because total
> amount of changes for pty and console code is relatively large
> since the beginning of this year.

Sure enough, I found a problem in the console code...

I will submit a patch for that.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
