Return-Path: <cygwin-patches-return-9613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26724 invoked by alias); 4 Sep 2019 12:50:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26711 invoked by uid 89); 4 Sep 2019 12:50:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 12:50:00 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id x84Cnimi007851	for <cygwin-patches@cygwin.com>; Wed, 4 Sep 2019 21:49:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x84Cnimi007851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567601384;	bh=DZHmqDICM+VzPmcvo0cVbWiTdE5NBjBdhXtfEmEHNRc=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=eIPizsVxaqrb8phInMaky6hKEKzcPmz0MgPG0RR0cHC1Kl+FQh9qtqjjo3pYG4xmJ	 yBQiJAG2glJSSC1maZSnj35UAkI3H6NDvL04oVfRtjP5gOdIriJfY3STJT0BMXj7c5	 dVz1QtXvGwhfNt/0AViTIIj2K6xthoEuNTeJRlXk3m7U8qT9H6uK638XBYLUBhqe+5	 Ps0NxkVUFXcsdp+VcL1ITHSMAuT5Q2CDoJeSXJTInFBT4BOCS+BK/zuWG1L2pR96vA	 h6jFKojxWopHheacHlzs108gpQqntlz/5BAyfdFnkG1s0MK/ennV1DvaHuGWxyJjcL	 kG5lCF7LyaLZw==
Date: Wed, 04 Sep 2019 12:50:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-Id: <20190904214953.50fc84221ea7508475c80859@nifty.ne.jp>
In-Reply-To: <20190904104738.GP4164@calimero.vinschen.de>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-3-takashi.yano@nifty.ne.jp>	<20190904104738.GP4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00133.txt.bz2

On Wed, 4 Sep 2019 12:47:38 +0200
Corinna Vinschen wrote:
> Why do you check the TERMs again here?  After all, need_clear_screen
> is only true if one of these terms are used.

Because, emacs seems to set environment TERM after fixup_after_exec()
is called. At the first check, TERM has the value of the terminal
in which emacs is executed. The first check is just in case.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
