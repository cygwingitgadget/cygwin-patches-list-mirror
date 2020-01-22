Return-Path: <cygwin-patches-return-9973-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4772 invoked by alias); 22 Jan 2020 16:00:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4739 invoked by uid 89); 22 Jan 2020 16:00:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNSUBSCRIBE_BODY autolearn=no version=3.3.1 spammy=apologize, H*x:Sylpheed, H*UA:Sylpheed, AAAA
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 22 Jan 2020 16:00:33 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id 00MG081G004835	for <cygwin-patches@cygwin.com>; Thu, 23 Jan 2020 01:00:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 00MG081G004835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579708810;	bh=EaSCbvoKSv6hr1FiDbiQRTE5VC2uCk4sPY+nT1zoS5s=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=HMBSI1dVhrcT+3h652LxBZePysYIob8OyhjSAr5k3UngggTzP7SS+kRgT8MORjv4l	 eJrXh7xRSw5e+k6vPkpUrMs94bknglDLPZ1/k49n1vvG/qT7fAFhfKA54WZYG876rq	 P1eBPF33/kC59IGF9VwYFdD7Os6iv3032RrAUec2mvEzGFHFFQ7lR+bPygghUtCpEV	 lmRylTRV+ixclw0myt92Pep4HzC/CSNPEeDk6KDKV8mBcXhDEjBT2daKDWPitgBCmY	 1F6XGI66r6wmjpuQpR3Xrc03f/SR1rvU1wELDmk3YH1hhmhpuW7fQhLfDKYGeIP0N1	 kK6q0goEOJXcQ==
Date: Wed, 22 Jan 2020 16:00:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Message-Id: <20200123010011.e34b6999f3e852d2b9eb4787@nifty.ne.jp>
In-Reply-To: <20200121093735.GN20672@calimero.vinschen.de>
References: <20200121111556.ceb40aa746220718b44dfb25@nifty.ne.jp>	<20200121022202.2960-1-takashi.yano@nifty.ne.jp>	<20200121093735.GN20672@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00079.txt

Hi Corinna,

On Tue, 21 Jan 2020 10:37:35 +0100
Corinna Vinschen wrote:
> On Jan 21 11:22, Takashi Yano wrote:
> > - Though this rarely happens, sometimes the first printing of non-
> >   cygwin process does not displayed correctly. To fix this issue,
> >   the code for waiting for forwarding by master_fwd_thread is revised.
> 
> Looks good.  Pushed.

First of all, I have to apologize for insufficient test.
With this patch, the following test case frequently displays
its output incorrectly.

Sometimes it is just
AAAA
or
AAAA
AAAA (duplicated)
or
AAAA
<blank line>

Of course, the expected ersult is:
AAAA
BBBB

/* Test code */
#include <windows.h>
#include <stdio.h>

int main()
{
    DWORD n;
    printf("AAAA\n");
    WriteConsole(GetStdHandle(STD_OUTPUT_HANDLE), "BBBB\r\n", 6, &n, 0);
    return 0;
}

I looked into this problem and found that the cause. What we
really need is not waiting for forwarding by pty_master_fwd_thread
but is waiting for forwarding by pseudo console itself. In other
words, the latency between slave write to get_output_handle()
and master read from from_slave pipe is dominant.

We cannot touch the forwarding process in pseudo console, therefore
the strategy like this patch can not be used. So, we might have to
revert to dumb Sleep() wait.

As for the wait time, I have measured the latency of pseudo console
in following machines.

Machine1: Ryzen 9 3950X (3.5GHz)
Machine2: Core i7 6700K (4.0GHz)
Machine3: Xeon X5670 (2.93GHz)
Machine4: Core i7 870 (2.93GHz)
Machine5: PentinumD 930 (3.0GHz)  <- Very old!

Measuring is done 1000 times for each machine. The results are as
follows.

Machine1:
Count  Latency[ms]
  416   0
  222  15
  362  16

Machine2:
Count  Latency[ms]
  421   0
  185  15
  394  16

Machine3:
Count  Latency[ms]
  439   0
  199  15
  362  16

Machine4:
Count  Latency[ms]
  202  15
  340  16
  343  31
  115  32

Machine5:
Count  Latency[ms]
  140 15
  284 16
  410 31
  159 32
    7 47

Obviously, the latency depends on the machine performance.
Therefore, I will propose new patch which uses dumb Sleep()
with on-the-fly performance test.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
