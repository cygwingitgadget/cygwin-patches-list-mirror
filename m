Return-Path: <cygwin-patches-return-10113-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11773 invoked by alias); 25 Feb 2020 03:08:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11715 invoked by uid 89); 25 Feb 2020 03:08:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=gray, fore, screen, black
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 03:08:29 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 01P387g5003731	for <cygwin-patches@cygwin.com>; Tue, 25 Feb 2020 12:08:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 01P387g5003731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582600088;	bh=OW6xWFJTa/f0ilLUNLKr1u+S43PRXBvu4o1Rm6QL5FY=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=1PU3GQaCRu9R380WxGIKVq0cvrpyauWTTeuIxmjOsrIEAaQBR4kuxK1WO3kW6pRFR	 bwYqyJRDnS32HX4fuCjz9Yxc1quCSdeiOvY1HeuA+7rTZvKMQWFMAn8adnwfEBtP9p	 fsYtsi299Q7CkQDNeZEWnWlQM29PDAb1gcigcugSJ1Jhpv/t9ZzsouSWjG2dKg8AO+	 NeUUnTKfds29twohiInxnA3qZUyBitjxfAgjQQTWCfPpMulzBl3KadhKKwngRlC5vc	 XOm5sHJ/1c6m2YSmxG2yxqQIVXH85bUo75y0ji1Y6QrDNwR60uBxEeXJ4vn95foj4r	 zmbC/ShPW9adA==
Date: Tue, 25 Feb 2020 03:08:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-Id: <20200225120816.3abe69332aace2b7f1b392ae@nifty.ne.jp>
In-Reply-To: <20200224183318.GH4045@calimero.vinschen.de>
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>	<20200221194333.GZ4092@calimero.vinschen.de>	<20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>	<20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>	<20200224100835.GD4045@calimero.vinschen.de>	<20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp>	<20200224183318.GH4045@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00219.txt

Hi Corinna,

On Mon, 24 Feb 2020 19:33:18 +0100
Corinna Vinschen wrote:
> Is there some kind of workaround for that problem?  Otherwise defaulting
> to a (broken) xterm mode instead of a (working) cygwin mode is a bit
> questionable, isn't it?

In my environment, legacy cygwin mode is not 'working' with
gray background and black foreground. You can confirm what
happens if xterm mode is disabled by reverting cygwin to 3.0.7.

If you type 'aaa' in shell prompt and hit backspace, then
whole line after cursor gets black. Furthermore, if you run
vim, whole screen gets into black background and gray fore-
ground.

Do not these happen in your environment?

Oh, wait. I was setting foreground and background color in
"terminal" tab in property. If I set them in "colors" tab,
cmd.exe behaves differently. In this setting, your problem
does not seems to occur.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
