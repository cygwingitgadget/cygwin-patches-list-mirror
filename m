Return-Path: <SRS0=TksR=EZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1009.nifty.com (mta-snd01012.nifty.com [106.153.227.44])
	by sourceware.org (Postfix) with ESMTPS id 2CBD63858D1E
	for <cygwin-patches@cygwin.com>; Sat,  9 Sep 2023 23:37:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2CBD63858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta1009.nifty.com with ESMTP
          id <20230909233709905.TRFU.19111.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 10 Sep 2023 08:37:09 +0900
Date: Sun, 10 Sep 2023 08:37:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix __cpuset_zero_s prototype
Message-Id: <20230910083709.0b7c6de6da6c46e1705a8873@nifty.ne.jp>
In-Reply-To: <ZPzjskmDV+RIynoS@calimero.vinschen.de>
References: <20230908053639.5689-1-mark@maxrnd.com>
	<ZPzjskmDV+RIynoS@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Sat, 9 Sep 2023 23:29:22 +0200
Corinna Vinschen wrote:
> On Sep  7 22:36, Mark Geisert wrote:
> > Add a missing "void" to the prototype for __cpuset_zero_s().
> > 
> > Reported-by: Marco Mason <marco.mason@gmail.com>
> > Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
> > Signed-off-by: Mark Geisert <mark@maxrnd.com>
> > Fixes: c6cfc99648d6 (Cygwin: sys/cpuset.h: add cpuset-specific external functions)
> > 
> > ---
> >  winsup/cygwin/include/sys/cpuset.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Pushed, including doc fix.

These patch shoud be applied also to cygwin-3_4-branch, but didn't.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
