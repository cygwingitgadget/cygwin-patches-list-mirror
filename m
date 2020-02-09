Return-Path: <cygwin-patches-return-10053-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2401 invoked by alias); 9 Feb 2020 15:06:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2386 invoked by uid 89); 9 Feb 2020 15:06:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1055, screen
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 15:06:02 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 019F5rEh007893	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 00:05:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 019F5rEh007893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581260753;	bh=SkHp6RTnh2isWsofcqiZu7PngAXno/kJRrlV4XLDMd4=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=NbiopWL6/GJOI04W0vQ7R5jQpijfZ6LFDg4Olc2f86uGdFoiGuMT0LiKFmW+rAX2L	 Td+Nov1oHDRi7CNvwFufjoArI33YzzH6/b7a1CQT+m1C4ow7/8upEzPFGsW85WNy3Q	 YtJS1rUhRjEFgZbsEmRioQTElARvxNr86O6qIJGExQ2Vg2OpOXAM70GQ0w3IwydLg6	 uqiitHT2/rDcWeDUMHDYyVJlw0SCZM/a6QPXTnBA7Gofxh/OpZ4tWXEx4wzs1uZZce	 sC1HjhYj1WYzTe7aya3PBinMMtqQSPlCk6AxFOPrmWsq5A7dotPGTuScyUrX2hu6di	 d8bKID9FYpBjQ==
Date: Sun, 09 Feb 2020 15:06:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use pinfo() rather than kill() with signal 0.
Message-Id: <20200210000603.3e72d135b91e11f6b35af34a@nifty.ne.jp>
In-Reply-To: <20200208235311.bda313987c047dc8bf69ed2e@nifty.ne.jp>
References: <20200206104817.1116-1-takashi.yano@nifty.ne.jp>	<20200206190330.GT3403@calimero.vinschen.de>	<20200208235311.bda313987c047dc8bf69ed2e@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00159.txt

On Sat, 8 Feb 2020 23:53:11 +0900
Takashi Yano wrote:
> On Thu, 6 Feb 2020 20:03:30 +0100
> Corinna Vinschen wrote:
> > I'm inclined to release 3.1.3 next week.  Is that ok with you or
> > do you anticipate more patches which should go into 3.1.3?
> 
> Currently, I have two patches which are under test. I would be
> happy if these could be included in 3.1.3. I am planning to
> divide one of them into several patches. I will submit these
> patches in a few days.

Please apply these patches in the following order.

[PATCH 1/4] Cygwin: pty: Define mask_switch_to_pcon_in() in fhandler_tty.cc.
[PATCH 2/4] Cygwin: pty: Avoid screen distortion on slave read.
[PATCH 3/4] Cygwin: pty: Remove debug codes and organize related codes.
[PATCH 4/4] Cygwin: pty: Add missing member initialization for struct pipe_reply.
[PATCH] Cygwin: pty: Inherit typeahead data between two input pipes.
[PATCH] Cygwin: pty: Fix state mismatch caused in mintty.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
