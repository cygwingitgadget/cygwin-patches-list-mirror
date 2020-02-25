Return-Path: <cygwin-patches-return-10114-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53484 invoked by alias); 25 Feb 2020 03:53:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53473 invoked by uid 89); 25 Feb 2020 03:53:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, black
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 03:53:34 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 01P3rFWt028134	for <cygwin-patches@cygwin.com>; Tue, 25 Feb 2020 12:53:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 01P3rFWt028134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582602796;	bh=vD+PlEa49LtrBGtSs5iqHyYdFOC8KasLZu7MJrjmlbA=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=n2rojYD5Htwguev1x5cV4SpFIi/yXNyp+0OQ7MGHQPguHfWIT02Zt/18sUwx1POv/	 2BY7uisW7yj6yBGG0ujMohtPgmGXZ35blEjoIcnvInn12ueSbvx6fqKo/VsFzIhsn6	 SCWYPd7PbfVHa8ce8cQ7cK9JH8ICuMeXWcALXCNagPMkWSTnohV3B2DAgOYr7W6pyh	 CkLoo01SjSieMhnm6l/9hWRYyD4h8gnfTtSj+qwlQQHsTZG0p4DdM+grs3Oadj4LoC	 eTx5+svoahNOv3XnllNgqvujQqOJp8VMjMGk0cuNhrH2e5lhMG+K1GrY8NlUH0nTqy	 Cc0fY19YO8aiA==
Date: Tue, 25 Feb 2020 03:53:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-Id: <20200225125325.52039a023b7f21c497a05933@nifty.ne.jp>
In-Reply-To: <20200225120816.3abe69332aace2b7f1b392ae@nifty.ne.jp>
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>	<20200221194333.GZ4092@calimero.vinschen.de>	<20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>	<20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>	<20200224100835.GD4045@calimero.vinschen.de>	<20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp>	<20200224183318.GH4045@calimero.vinschen.de>	<20200225120816.3abe69332aace2b7f1b392ae@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00220.txt

On Tue, 25 Feb 2020 12:08:16 +0900
Takashi Yano wrote:
> On Mon, 24 Feb 2020 19:33:18 +0100
> Corinna Vinschen wrote:
> > Is there some kind of workaround for that problem?  Otherwise defaulting
> > to a (broken) xterm mode instead of a (working) cygwin mode is a bit
> > questionable, isn't it?
> 
> In my environment, legacy cygwin mode is not 'working' with
> gray background and black foreground. You can confirm what
> happens if xterm mode is disabled by reverting cygwin to 3.0.7.
> 
> If you type 'aaa' in shell prompt and hit backspace, then
> whole line after cursor gets black. Furthermore, if you run
> vim, whole screen gets into black background and gray fore-
> ground.
> 
> Do not these happen in your environment?
> 
> Oh, wait. I was setting foreground and background color in
> "terminal" tab in property. If I set them in "colors" tab,
> cmd.exe behaves differently. In this setting, your problem
> does not seems to occur.

I was wrong. The problem also occur with "colors" tab setting.
However, in this case, ScrollConsoleScreenBuffer() test case
does not cause the problem. Therefore it may be possible to
make a workaround for this. I will try.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
