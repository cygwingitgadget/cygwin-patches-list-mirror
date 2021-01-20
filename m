Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id E4032394D8FE
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 10:41:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E4032394D8FE
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 10KAeQNB018399
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 19:40:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 10KAeQNB018399
X-Nifty-SrcIP: [122.249.67.108]
Date: Wed, 20 Jan 2021 19:40:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Reduce buffer size in
 get_console_process_id().
Message-Id: <20210120194026.0529a3daafa83e8c9dd9311b@nifty.ne.jp>
In-Reply-To: <20210120095024.GR59030@calimero.vinschen.de>
References: <20210120005700.531-1-takashi.yano@nifty.ne.jp>
 <20210120095024.GR59030@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 20 Jan 2021 10:41:06 -0000

On Wed, 20 Jan 2021 10:50:24 +0100
Corinna Vinschen wrote:
> On Jan 20 09:57, Takashi Yano via Cygwin-patches wrote:
> > - The buffer used in get_console_process_id(), introduced by commit
> >   72770148, is too large and ERROR_NOT_ENOUGH_MEMORY occurs in Win7.
> 
> Huh, funny!  Will we ever be happy with just 8192 processes per
> console? :)

According to my test, when the buffer size is larger than 15683,
this error occurs. Test environment is Win7 x64. Both inside and
outside of WOW64, the maximum allowed size seems to be the same.

Shall we increase to 15683? :p

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
