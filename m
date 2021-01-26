Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id 616B7386100E
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 08:45:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 616B7386100E
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 10Q8jHmS021003
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 17:45:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 10Q8jHmS021003
X-Nifty-SrcIP: [122.249.67.108]
Date: Tue, 26 Jan 2021 17:45:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 0/4] Improve pseudo console support.
Message-Id: <20210126174517.350317dd95ee1539af8505c3@nifty.ne.jp>
In-Reply-To: <20210126035229.1666-1-takashi.yano@nifty.ne.jp>
References: <20210126035229.1666-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Tue, 26 Jan 2021 08:45:45 -0000

On Tue, 26 Jan 2021 12:52:25 +0900
Takashi Yano wrote:
> The new implementation of pseudo console support by commit bb428520
> provides the important advantages, while there also has been several
> disadvantages compared to the previous implementation.
> 
> These patches overturn some of them.
> 
> The disadvantage:
>  1) The cygwin program which calls console API directly does not work.
> is supposed to be able to be overcome as well, however, I am not sure
> it is worth enough. This will need a lot of hooks for console APIs.
>  --> Respecting Corinna's opinion, we decided not to implement this.
> 
> v3: Fix typeahead input issue in GDB. Several other bugs have also
>     been fixed.
> v4: Change the conditions for calling transfer_input() slightly in
>     reset_switch_to_pcon() to avoid calling it if uncecessary or
>     with no effect.
> v5: Small bug fix in v4.

I have another fix for v5. Please wait for v6.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
