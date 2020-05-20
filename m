Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id CCE193840C18
 for <cygwin-patches@cygwin.com>; Wed, 20 May 2020 08:46:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CCE193840C18
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 04K8jx1H031959;
 Wed, 20 May 2020 17:45:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 04K8jx1H031959
X-Nifty-SrcIP: [124.155.38.192]
Date: Wed, 20 May 2020 17:46:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Make system_printf() work after closing
 pty slave.
Message-Id: <20200520174611.2249f4d6b1a8043f2bdeca86@nifty.ne.jp>
In-Reply-To: <c6a10e57-9492-adf1-6773-1d731512ce20@cornell.edu>
References: <20200519113600.467-1-takashi.yano@nifty.ne.jp>
 <c6a10e57-9492-adf1-6773-1d731512ce20@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 20 May 2020 08:46:25 -0000

On Tue, 19 May 2020 15:04:24 -0400
Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> Hi Takashi,
> 
> On 5/19/2020 7:35 AM, Takashi Yano via Cygwin-patches wrote:
> > - Current pty cannot show system_printf() output after closing pty
> >    slave. This patch fixes the issue.
> 
> Sorry to be returning the favor so soon, but this patch causes 'make check' in 
> the texinfo source tree to hang.  I don't have time at the moment to try to 
> produce a simple test case, so here's a complicated way to reproduce the problem:
> 
> 1. Clone the texinfo git repo:
> 
>    $ git clone https://git.savannah.gnu.org/git/texinfo.git
> 
> 2. Build texinfo:
> 
>    $ cd texinfo
>    $ ./autogen.sh && ./configure # Maybe CFLAGS='-g -O0' for debugging
>    $ make
> 
> 3. Test the standalone info reader:
> 
>    $ cd info
>    $ make check
> 
> It hangs while running the test t/malformed-split.sh, leaving a ginfo process 
> and a pseudotty process running, with ginfo trying to close a pty slave.
> 
> Note that this test uses both ptys and fifos, so there's always a chance that 
> this is another fifo bug.  But reverting your patch fixes the problem, so I 
> think it's probably a pty bug.

Sorry for inconvenience. I can reproduce your problem.
I will check what is happening. Please wait a while. 

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
