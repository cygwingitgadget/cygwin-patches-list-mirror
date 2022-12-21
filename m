Return-Path: <SRS0=tR/4=4T=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
	by sourceware.org (Postfix) with ESMTPS id 38B823858425
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 10:24:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 38B823858425
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conssluserg-04.nifty.com with ESMTP id 2BLANg8I014471
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 19:23:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BLANg8I014471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671618222;
	bh=CBY92OExlDDKV5inAyBqEbWSktBJpOtUiGmzWsPITvg=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=jpRORGOgGfI4ytCI+a+jIiSUL6CEXbDRS/wI4AqW7MOZte0N2Cq7ZzDbOGrWBw752
	 8pZytbVu/mX/viP+sXsR3CYI6YKgy3VvR1MRRJnKv7dapt2hQvPsS2C7I+qlrcNAb4
	 AC4JuBgXKWpvnTsVx/FvQo8ESalJvP/Tkeu+ul/bGQB4LFByqDPrax6zV3BUGGLOic
	 +iKAmjQn6wqI7kcx3FWnjrEJ8XFWkI3RkIvgqFliU7zLK1R0XAuhOepa6o5u6NFqiX
	 VUgUnFedD8VtRDAeki/PgnMUJ+kLDY8xuqQhPt92ufrU9J7nqLtALXeEYACBX8+Kc6
	 2BGpN5zlEURdw==
X-Nifty-SrcIP: [220.150.135.41]
Date: Wed, 21 Dec 2022 19:23:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-Id: <20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
In-Reply-To: <Y6ItllXJ8J20cEbp@calimero.vinschen.de>
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
	<Y6ItllXJ8J20cEbp@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 20 Dec 2022 22:48:06 +0100
Corinna Vinschen wrote:
> On Dec 20 21:45, Takashi Yano wrote:
> > Previously, the console device could not be accessed from other terminals.
> > Due to this limitation, GNU screen and tmux cannot be opened in console.
> > With this patch, console device can be accessed from other TTYs, such as
> > other consoles or ptys. Thanks to this patch, screen and tmux get working
> > in console.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/devices.cc                |  24 +-
> >  winsup/cygwin/devices.in                |  24 +-
> >  winsup/cygwin/fhandler/console.cc       | 438 +++++++++++++++++-------
> >  winsup/cygwin/fhandler/pty.cc           |   4 +-
> >  winsup/cygwin/local_includes/fhandler.h |  26 +-
> >  winsup/cygwin/local_includes/winsup.h   |   1 -
> >  winsup/cygwin/select.cc                 |   2 +
> >  7 files changed, 382 insertions(+), 137 deletions(-)
> 
> I just toyed around with screen and this looks really great.
> 
> Just one question: What about security?  If we now can share
> consoles, don't we need fchmod/fchown calls, too?

Thanks for reviewing.

As for security, AttachConsole() for another user's process
will failed with ERROR_ACCESS_DENIED, so the console of
another user is inaccessible.

However, fstat() does not return appropriate information,
so, I implemented fhandler_console::fstat(). I also set proper
errno for that case. Please see v2 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
