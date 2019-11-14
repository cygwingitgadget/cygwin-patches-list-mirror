Return-Path: <cygwin-patches-return-9851-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44086 invoked by alias); 14 Nov 2019 11:51:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44074 invoked by uid 89); 14 Nov 2019 11:51:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*ne.jp, screen
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Nov 2019 11:51:46 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id xAEBpg9G020237	for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2019 20:51:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xAEBpg9G020237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573732302;	bh=D+nyYuBpI/2ftk7GyHVMhDi/E9hkKDBETiHizwcpKwY=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=m2FhNLNj5g8UEpTpr2kzxzheISkAcMl2ugXG3yTJ0o2fMHJRfWmCbAbF0ARRZJ9rE	 7LP+NGVDjTRKFs2s/WxldTL90At46G9Kxvj5zC1KYLLu6Fk/mQgWBoYNVguX7xeRL1	 FUk3jyY6ol04otcF2LKyax2vY+nZBnqKYt1TLfc1Zt4HhmSVNHAS1fCcFzqFuL3RkT	 4uN4LIPosDHnfsrgQo9AZ5f2on0PfTIsg+W6Oz/s1wEzzNuVKyey7lPdQJTsDm4Mes	 2C6+I6yT7tnZY1+J5Vvx9oMw+VdTcNuieULtgRMCb+yYgH72xH01JBlqW0oS4UaeE7	 D+epJF5KjHkBw==
Date: Thu, 14 Nov 2019 11:51:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Trigger redraw screen if ESC[?3h or ESC[?3l is sent.
Message-Id: <20191114205148.4a3c138ab38085f023e677c3@nifty.ne.jp>
In-Reply-To: <20191114093541.GS3372@calimero.vinschen.de>
References: <20191113104929.748-1-takashi.yano@nifty.ne.jp>	<20191114093541.GS3372@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00122.txt.bz2

Hi Corinna,

On Thu, 14 Nov 2019 10:35:41 +0100
Corinna Vinschen wrote:
> This is only correct if xterm hasn't been started with the c132 widget
> resource set to 'true'.  This resource specifies whether the ESC[?3h
> and ESC[?3l ESC sequences are honored or not.  The default is 'false'.
> 
> However, if you specify the c132 resource, or if you start xterm
> with the commandline option -132, it will resize when these sequences
> are sent.  And here's the joke: The resize also clears the screen
> in xterm.

Thanks for the information.

> My question now is, does this change anything in terms of the below
> code, or is it still valid as is?

It still valid as is. Bacause, if -132 option is specified and the
real sreen is cleared by ESC[?3h and ESC[?3l, mismatch does not occur.
In this case, this patch tries to synchronize the real screen with
the console screen buffer in spite that they are already synchronized,
but there should be no side effects.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
