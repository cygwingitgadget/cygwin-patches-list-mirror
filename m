Return-Path: <cygwin-patches-return-9648-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95803 invoked by alias); 6 Sep 2019 14:41:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95794 invoked by uid 89); 6 Sep 2019 14:41:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Sep 2019 14:41:35 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id x86EfDCu014420	for <cygwin-patches@cygwin.com>; Fri, 6 Sep 2019 23:41:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x86EfDCu014420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567780874;	bh=GHAQPG0LtXlL7jATQYlmmxpA1e7wzyiWPs0HP+s6unM=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=eOmf+NHwE56Upq0iNnSNs6VY2rYr2Mp+t2MfXWxwiYypkYlcR/ZRp8DFpQq1kS4zv	 bkb9wNdOc3ISemqclLncIU5WHRXfX6OOwkGK/TunxLAh1TzhtLhqAyjuw+Q+MuS1YV	 h9h4OV7n/9W+sr+WJ9oV7vqveR6x1oj+OOyu6DTRMiGiM5dFclu2ueO3wv8DIkMQz0	 9V7XiabloP3Ux3wAVoPv/0Fg6JYOt6WNU+51mWVgQIoS9Iem59KOzvK6+He3rNK3pJ	 Ja4eVK76XP4QqoxvqIuMShNJvki1tScUIRN0UpjcB3uAGaVx0mb1p5JRfnlhvg3WMv	 cXiaohaWDvDMQ==
Date: Fri, 06 Sep 2019 14:41:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190906234123.ede89775c70e646dc2d1aac2@nifty.ne.jp>
In-Reply-To: <20190906124816.1424-1-takashi.yano@nifty.ne.jp>
References: <20190906124816.1424-1-takashi.yano@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00168.txt.bz2

This has small problem. Please apply v2.

On Fri,  6 Sep 2019 21:48:15 +0900
Takashi Yano wrote:

> - When the I/O pipe is switched to the pseudo console side, the
>   behaviour of Ctrl-C is unstable. This rarely happens, however,
>   for example, shell sometimes crashes by Ctrl-C in that situation.
>   This patch fixes that issue.
> 
> Takashi Yano (1):
>   Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
> 
>  winsup/cygwin/fhandler.h      |   4 +-
>  winsup/cygwin/fhandler_tty.cc |  32 +++++----
>  winsup/cygwin/select.cc       |   2 +-
>  winsup/cygwin/spawn.cc        | 128 +++++++++++++++++-----------------
>  4 files changed, 88 insertions(+), 78 deletions(-)
> 
> -- 
> 2.21.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
