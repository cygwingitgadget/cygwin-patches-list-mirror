Return-Path: <cygwin-patches-return-9612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5032 invoked by alias); 4 Sep 2019 12:39:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5019 invoked by uid 89); 4 Sep 2019 12:39:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 12:39:18 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id x84Cd54T027584	for <cygwin-patches@cygwin.com>; Wed, 4 Sep 2019 21:39:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x84Cd54T027584
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567600745;	bh=yNz/50UNFE8UKt75KjPzYcu629+cTb/pWmIPpgcbcyg=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=zf043Rl+54ZaDIh+7avzuB1nPg++wZTWyT+GTL06+cB1vlE3OLSfixAnRCofTOmLI	 qlXUTTbam+8C+iMKGg4MuUF/n97RVDJelpqn4aHnjilXY/NGhfrAVe8dTh8lnIHExh	 FfehB30v/UiWrxdrrnhsWA0tOSpMWBq3bIVVVMEaOI5ww+nHLyu7GA0NH2UmY1mE7V	 uUkm4p1bRiLNGY4qaE4BWojhSfag3khddw8NMuHr6bSXeFkyfddjj86mhT7IHHdn2A	 8s5MtU05D1IAdTV4OrmgnzlP2NxJjDGRvA6wLbKN1Le4J0geKksL0wIFKS21tvDo8Y	 ZuMn7v3scU6OQ==
Date: Wed, 04 Sep 2019 12:39:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/4] Cygwin: pty: Limit API hook to the program linked with the APIs.
Message-Id: <20190904213914.ce7cf3703871189e9613c7d1@nifty.ne.jp>
In-Reply-To: <20190904100351.GM4164@calimero.vinschen.de>
References: <20190904014426.1284-1-takashi.yano@nifty.ne.jp>	<20190904014426.1284-5-takashi.yano@nifty.ne.jp>	<20190904100351.GM4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00132.txt.bz2

Hi Corinna,

On Wed, 4 Sep 2019 12:03:51 +0200
Corinna Vinschen wrote:
> I'll push the other 3 patches from this series.  For this patch,
> I wonder why you create set_ishybrid_and_switch_to_pcon while
> at the same time define a macro CHK_CONSOLE_ACCESS with identical
> functionality.

Yah, indeed!

> Suggestion: Only define set_ishybrid_and_switch_to_pcon() as
> inline function (probably in winsup.h) and use only this througout.

This function uses static variable isHybrid (sorry camelback again)
and static function set_switch_to_pcon() defined in fhandler_tty.cc.

To make it inline, a lot of changes will be necessary. How about
non-inline function?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
