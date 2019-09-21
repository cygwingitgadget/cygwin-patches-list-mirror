Return-Path: <cygwin-patches-return-9717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65797 invoked by alias); 21 Sep 2019 23:01:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65786 invoked by uid 89); 21 Sep 2019 23:01:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=D*jp, UD:jp, H*i:sk:8f51dfc, H*F:D*ne.jp
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 21 Sep 2019 23:01:34 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id x8LN1K3r028878	for <cygwin-patches@cygwin.com>; Sun, 22 Sep 2019 08:01:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x8LN1K3r028878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1569106880;	bh=XFUDUgTZVrdcEHEj+7SkXohEJrVZqqRNJmK1WniO/4I=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=xF58Bb8oC4ruUj9AXJslrogzWNj89IQVkIGh0pav57auIF6jfaTAd14wh7CrB+6VC	 9nwx3cA9IKdZXglCfUSflEFnl8iRcUbuioXyLo8D9r3C+w8sloAdkHNnpuvWNbsDcQ	 a2N1axBL/c5y+ik0VRT5dgqjvBSC5Oqe74qLpL6gods6UmBehqz/B0uVdj10zbBLSx	 75piNxbdrclYCJEOFQx0LaETF9GFAPQd7TJGU1zrpbj5rnM/pJTwbT2Y+mzJu30D1o	 LMQr91jx05QuoETdfyD9GNgWYjiT1zLJFWPva3jBAF3Z/XjwafLXMbT8gBQgii2J45	 4JRb0U7e5v2Nw==
Date: Sat, 21 Sep 2019 23:01:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [ANNOUNCEMENT] cygwin 3.1.0-0.5 (TEST)
Message-Id: <20190922080133.1e1cda44d451d1883d9606d6@nifty.ne.jp>
In-Reply-To: <8f51dfc4-4eae-bfa5-eea7-9daa940f435d@cornell.edu>
References: <announce.20190915144631.711-1-kbrown@cornell.edu>	<20190918234043.5dcf3104ec188bb6f3c81218@nifty.ne.jp>	<b4bc7a67-87ab-7876-8b8c-69a1b75e3a85@cornell.edu>	<8f51dfc4-4eae-bfa5-eea7-9daa940f435d@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00237.txt.bz2

Hi Ken,

On Sat, 21 Sep 2019 21:58:07 +0000
Ken Brown wrote:
> On 9/20/2019 6:05 PM, Ken Brown wrote:> I'll make a new test release this 
> weekend, or whenever you think it's time.
> 
> I'm building a new test release right now.  I'll upload it in about 24 hours 
> unless you tell me that you'd like me to wait for further patches.

I currently do not have any patch planning. Please go ahead.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
