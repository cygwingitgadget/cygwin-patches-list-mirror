Return-Path: <cygwin-patches-return-9656-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 83644 invoked by alias); 7 Sep 2019 03:20:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 83520 invoked by uid 89); 7 Sep 2019 03:20:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1297, H*i:sk:3cf7455, H*f:sk:3cf7455, screen
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 07 Sep 2019 03:20:30 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id x873KDxb021006	for <cygwin-patches@cygwin.com>; Sat, 7 Sep 2019 12:20:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x873KDxb021006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567826414;	bh=/JKuomN2GS8BMryK9ZNDCCc4HTAyfDZ3/RfnTVndqxU=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=jZbW0cnIa7K1ZS/lJBokMDHPbB56Be/Nq/8daAyMMHfHgj4e3Zv59aDsQ9f+sqdez	 r2Hzsr8WrW+IzN+33G6BsQkZCDbKDi/B6BQRLEEeIgMM/0aipYNl2u4N9LqFrfFogK	 G4XdhQzVmk5jnAH9Amh798/APMwoMx2CG+Iy8GM8lqgmLQx0y/YCB6dZEJcd69tk2Y	 oCm5zaTCFGTEg0uFH/7bqfR9CsxfKkExDmZS/MFMTwUg35I9st8rcwzLkMVu4vjvri	 WM/ijdCKRA4cyFGZnEzTo6L0kZninL7IVc0PTz5zeUGAf7r79L302UkPydt3z6uVLp	 AlX3bc115ttyA==
Date: Sat, 07 Sep 2019 03:20:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190907122015.22ff05b1087c98dff581653f@nifty.ne.jp>
In-Reply-To: <3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>
References: <20190906145200.802-1-takashi.yano@nifty.ne.jp>	<3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00176.txt.bz2

Hi Ken,

I appreciate checking the patch.

On Fri, 6 Sep 2019 17:59:02 +0000
Ken Brown wrote:
> I had several problems after applying this patch.
> 
> 1. I noticed some display glitches when building cygwin (with -j13 if that's 
> relevant).  For example, there were some unexpected blank lines and indented lines.
> 
> 2. At one point the build wouldn't complete at all.  It hung and had to be 
> killed with Ctrl-C.

I could not reproduce these with 32-bit cygwin (which I usually use),
however, I noticed that they happen with 64-bit cygwin. I apologize
for the lack of enough test.

I will post fixed version as v4 patch.

> 3. I used ssh from my normal account to log into an administrator account.  I 
> ran a script that produced a lot of output and piped it to less.  I pressed 'q' 
> after the first screen was displayed, and the displayed text didn't get cleared.

Are you using non-cygwin program in the script? If so, this may happen
in test release 3.1.0-0.4 as well.

> P.S. I'm leaving tomorrow for a short vacation, so I might not have time to 
> review any more patches until I return in about a week.

I see. So I have at least a week for consideration. :)

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
