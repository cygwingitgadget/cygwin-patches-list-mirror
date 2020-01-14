Return-Path: <cygwin-patches-return-9929-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36377 invoked by alias); 14 Jan 2020 01:37:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36368 invoked by uid 89); 14 Jan 2020 01:37:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=exhausted
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 01:37:26 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 00E1bHij008826	for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2020 10:37:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00E1bHij008826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1578965838;	bh=eOUoaSKkZeuEpc0ISBS8YBHlziY0WVVqIz4JVMg0+to=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=odFqSmytscucvV0rMTPzewkfSlOklGaxU67UKjZEBzThmZMuJH/yLBHD44AGL8FGV	 dZFjP6nWuZVEbJI+77wJiOgR8S7rgB2v1WlOqxqR0Kpxnx3t13RKgc1RifXaq3hkmZ	 Y/27gH8pJ3RKoPERDQgxtEgQ+62Qb6EVs2L84+imU2CJLYyhcevo1h9zgUqTN9xoLM	 NUywUg/2jqoOCCAeQcrAAPSZFIdXtSHssYoefOuqHaBmmpXNqn6K6i8WgNrFaUeLol	 QITC1y3o9un4CAO2Btg4gR3D/X6ihKfO7Pftbwzz1/8pfhzI0kM4fL07lILcuPrj2y	 Q/ZxLKVrdNH3g==
Date: Tue, 14 Jan 2020 01:37:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Add code to restore console mode on close.
Message-Id: <20200114103718.ca09c3251527ffcdc328c5cb@nifty.ne.jp>
In-Reply-To: <20200113162553.GO5858@calimero.vinschen.de>
References: <20200102131716.1179-1-takashi.yano@nifty.ne.jp>	<20200113162553.GO5858@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00035.txt

Hi Corinna, welcome back!

On Mon, 13 Jan 2020 17:25:53 +0100
Corinna Vinschen wrote:
> On Jan  2 22:17, Takashi Yano wrote:
> > - The console with 24bit color support has a problem that console
> >   mode is changed if cygwin process is executed in cmd.exe which
> >   started in cygwin shell. For example, cursor keys become not
> >   working if bash -> cmd -> true are executed in this order.
> >   This patch fixes the issue.
> 
> Is that supposed to work for deeper call trees as well?

I think so.

> I'm asking because I tried something like
> 
>   bash -> cmd -> bash -> cmd 
> 
> and it turned out that the cursor keys don't work at all in the second
> cmd, while they work fine again in the first cmd when returning to it.

The cursor key itsself works in this case. You can edit command line
by left and right arrow keys. However, history does not work in this
situation. This seems to be because the history buffers are exhausted.

The same happens if you try

cmd -> cmd -> cmd -> cmd -> ........ -> cmd

in command prompt without cygwin.

I confirmed that history works in this situation if NumberOfHistoryBuffers
is increased using SetConsoleHistoryInfo(). The default value of
NumberOfHistoryBuffers seems to be 4 in windows 10.

The history buffer seems to be consumed by any process which attached to
the same console. Therefore, the same happens by

bash -> bash -> cmd

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
