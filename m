Return-Path: <cygwin-patches-return-9627-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 97402 invoked by alias); 4 Sep 2019 15:35:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 97393 invoked by uid 89); 4 Sep 2019 15:35:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:568, convinced, screen
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 15:35:27 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id x84FZG9T026045	for <cygwin-patches@cygwin.com>; Thu, 5 Sep 2019 00:35:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x84FZG9T026045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567611317;	bh=YBDhs/b+ABQfJMl8oq/nH5+/zAk1RPwCHJ6MlMfl6CQ=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=kkDgyZf//Ea1Llq6HayBO6UwAoOso5tUXn9oKyluZvh1gcmwxDvMot9ZCDCtL1YBU	 bbKgqp3wzuhjHKIjd7YQ7S+KS0Of+9gQIhraukZACbhqyw2xbxYYPwQ/bsB7Q6U8m4	 uEU8ZDv3hWcYAGjoDgAeYHdJsjPflxrLAIwya63V5/CTH/NbOs2EOMoIudh+N6K1f2	 csSEOF688WT4H1MtCwxVPzRG+ObhxKNRY+M1wRQ+snGKXLItgqaMIdYwxJKqW8p1Jg	 AXWxu8K5q69XHxrebppj4Yad6iLznwS6dpEY6YvO51NiTu3aKlbwEx+4NZxTv0Ea3i	 nXJp1gm6jhztw==
Date: Wed, 04 Sep 2019 15:35:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-Id: <20190905003527.6a18f2e9c782dfa4efea5c2f@nifty.ne.jp>
In-Reply-To: <20190904151905.GZ4164@calimero.vinschen.de>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-3-takashi.yano@nifty.ne.jp>	<20190904104738.GP4164@calimero.vinschen.de>	<20190904214953.50fc84221ea7508475c80859@nifty.ne.jp>	<20190904135503.GS4164@calimero.vinschen.de>	<20190904234222.4c8bfbb31d9a899eb2670082@nifty.ne.jp>	<544d0b3f-0623-f2d6-8e35-b21140ea323a@cornell.edu>	<20190904151905.GZ4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00147.txt.bz2

On Wed, 4 Sep 2019 17:19:05 +0200
Corinna Vinschen wrote:
> > But the first check (the one in fixup_after_attach()) could be dropped, couldn't it?
> 
> IIUC the second test first checks for need_clear_screen but then the
> TERM might have changed in the meantime which in turn requires to change
> the behaviour again.  But yeah, this sound like the first patch is not
> actually required at all.

I was convinced. I will revise the patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
