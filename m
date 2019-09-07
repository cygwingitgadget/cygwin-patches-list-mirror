Return-Path: <cygwin-patches-return-9659-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 33503 invoked by alias); 7 Sep 2019 06:03:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33494 invoked by uid 89); 7 Sep 2019 06:03:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 07 Sep 2019 06:03:10 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id x8762rMF025958	for <cygwin-patches@cygwin.com>; Sat, 7 Sep 2019 15:02:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x8762rMF025958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567836173;	bh=dgklJMSv7UVsnzO1Av81baGRM6ABW/1laZvIAMjzX1Y=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=isCXf5QPgXTe0/2t2ITwNzBl71WVKC5J0wQrwIO+HKQH27K5g8EbbLedFEC8vXDaX	 fy/Ysiv5lLnglOq/mTcgAoR+0TE/CCzabRzSjqqF+kDuz1dwkRhx0PgwPfB31sExpC	 Np+XUHDY83j7bw9qhpeZirdD7kW5UQYiastqR+RvmzfIo7hLUJIv193GcXvE+W94ur	 gwg9h0ngcDnZ26SutyjCoqqECueEO3FbevEQABZd9i/07n692Cs3dS/h4EGU/uLH0P	 hGLEnuSOAVCctv7McWnXlTBJsSM4N1ywZZ9rg/T3Zzv0VVVStGlP77CSokdxxuthFf	 dBrojLP5mY9ww==
Date: Sat, 07 Sep 2019 06:03:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190907150256.0ee8a9542e44d6361efad8cf@nifty.ne.jp>
In-Reply-To: <20190907122015.22ff05b1087c98dff581653f@nifty.ne.jp>
References: <20190906145200.802-1-takashi.yano@nifty.ne.jp>	<3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>	<20190907122015.22ff05b1087c98dff581653f@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00179.txt.bz2

On Sat, 7 Sep 2019 12:20:15 +0900
Takashi Yano wrote:
> On Fri, 6 Sep 2019 17:59:02 +0000
> Ken Brown wrote:
> > 3. I used ssh from my normal account to log into an administrator account.  I 
> > ran a script that produced a lot of output and piped it to less.  I pressed 'q' 
> > after the first screen was displayed, and the displayed text didn't get cleared.
> 
> Are you using non-cygwin program in the script? If so, this may happen
> in test release 3.1.0-0.4 as well.

3.1.0-0.3 as well.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
