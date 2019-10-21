Return-Path: <cygwin-patches-return-9771-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130197 invoked by alias); 21 Oct 2019 11:35:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130188 invoked by uid 89); 21 Oct 2019 11:35:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=0900, HX-Languages-Length:463, brief, screen
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Oct 2019 11:35:41 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x9LBZYFC017331	for <cygwin-patches@cygwin.com>; Mon, 21 Oct 2019 20:35:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9LBZYFC017331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571657734;	bh=kxhH0p6aD3OMsM0e3NlSh4FX6WbGGYigDqes7XtLn1E=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Yv5zFzKR1DVialYeKCTkd7zHiF4TqPvyr0d3Q+JYW1UWPtpfj9wBuoEwBPxmyqiWz	 NGTdXx/pRHSIqoGmffCI5OoTac3NSUdNcDp2I7NQWKtevofcQE7TKQIAa8oKUPj5nO	 LR9iE8EErUAbQfDYxtGQmxPkC7diKq/okqXTiQClC5NvRAtJDZI+PuprAsuzdeAVQH	 xVxU7+IE9d2TGSOCQxucWDOgXc/kPZcUetDeVWthKA9SUMy5M+DCNpTxOsNNARaAUZ	 p77i7tcGIXdO3RNZNICBjnBnTaFDkip2HGBSXB3IFBI3pJJ5CMz+4WQdrSRvmJ1IaC	 yr0aIDxwx79WA==
Date: Mon, 21 Oct 2019 11:35:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191021203538.300a5f4999a54549dc42b8c4@nifty.ne.jp>
In-Reply-To: <20191021195515.7ca1a3a7f7f85cca79ad80b0@nifty.ne.jp>
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>	<20191018143306.GG16240@calimero.vinschen.de>	<20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>	<20191021094356.GI16240@calimero.vinschen.de>	<20191021195515.7ca1a3a7f7f85cca79ad80b0@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00042.txt.bz2

On Mon, 21 Oct 2019 19:55:15 +0900
Takashi Yano wrote:
> netsh is even worse. The cursor position will be broken by the follwing
> steps.
> 1) env TERM=dumb script
> 2) netsh
> 3) winhttp show proxy

wmic also has the cursor position problem.

1) env TERM=dumb script
2) /cygdrive/c/windows/system32/wbem/wmic
3) computersystem list brief

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
