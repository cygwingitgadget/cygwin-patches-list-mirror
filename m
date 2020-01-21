Return-Path: <cygwin-patches-return-9965-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124537 invoked by alias); 21 Jan 2020 02:15:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124525 invoked by uid 89); 21 Jan 2020 02:15:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Jan 2020 02:15:55 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id 00L2Fkc5029483	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2020 11:15:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 00L2Fkc5029483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579572947;	bh=VnX17Shx44eB6rsILEqI63f0bSwQ3Frh7dbkCTLhMvQ=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=DrHvV+n/VNGpMUJ4nzE2tAGrHDmKHNroFKTzEWmgw/wMJpCx7xYDRd9hXn82cZlZd	 b8igUAJIn19j5KpXIR4NhSnbAf52hZVJqXiA8ClRQLUGumSNXBCafM6X2mSu/cyrq3	 Mj4gVjWgm1ZcaldW25mM9x41fnINXb9cDP/WLCdH0QVajNVCd9yuM7I3yCNoh9nQdW	 Y9iZOoeeglqBnP9qwNkTvIgFtuo1WfcZjzEVWZNPORazht2oUYydLaZhYKbnub+1On	 j9PYhMv1GuX4zI8qhA90TSn7uaCstGzJIHcqgC/MbpEupZlbDjixlawAvGLHMPXLmq	 BRTuzralqfSaw==
Date: Tue, 21 Jan 2020 02:15:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Revise code waiting for forwarding by master_fwd_thread.
Message-Id: <20200121111556.ceb40aa746220718b44dfb25@nifty.ne.jp>
In-Reply-To: <20200120103939.GF20672@calimero.vinschen.de>
References: <20200120025058.1568-1-takashi.yano@nifty.ne.jp>	<20200120103939.GF20672@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00071.txt

On Mon, 20 Jan 2020 11:39:39 +0100
Corinna Vinschen wrote:
> Are these 40 ms an experimental value or is that based on knowledge
> of implementation details? 

It is experimental value which I measured in several environment.

> The real question is, isn't there any
> other, more reliable indicator to see if forwarding will work?

I have tried another implementation and confirmed it works as expected.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
