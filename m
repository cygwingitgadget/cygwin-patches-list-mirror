Return-Path: <cygwin-patches-return-9673-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24776 invoked by alias); 13 Sep 2019 21:52:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24766 invoked by uid 89); 13 Sep 2019 21:52:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=PS, P.S, UD:P.S, screen
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Sep 2019 21:52:31 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id x8DLqRBW005374	for <cygwin-patches@cygwin.com>; Sat, 14 Sep 2019 06:52:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x8DLqRBW005374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568411548;	bh=eXXt4cFzPbrRlcQUKLip8zr5f4ScdZIrOm3MMNhx2mE=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=ITOaYcNGlZdzt+dQYEjfCj7qRsGC7z48mDESn9/zSCJ8Qcnyk2g/jOTESC2oOPeCD	 z+KeIMIM3nBA6+LpsNThjIlnvQjQa5a+aoRw062utZdzEpkTsdcARP16YgEikqq+Aw	 NlJies/TZHGk4JYLMjHWdbeGS56FXiHo/mQFgidQcjWvrunPDEsjOUDSf5uCcpghlj	 KAyI2LW8TqoOrS1bl2oU4emI4485+PON4WsuioZaBo0OeC+Ew+LoV2W0oNOR5brotf	 3KGEODXjuWtBAYmakjLF/ig40jaYNqmShLghHBfIgD2nGq6r1WnyoxoRFEVirlylQY	 Huv0h5LK9xDlQ==
Date: Fri, 13 Sep 2019 21:52:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190914065234.21c01267db0e0eb3f1347ff2@nifty.ne.jp>
In-Reply-To: <3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>
References: <20190906145200.802-1-takashi.yano@nifty.ne.jp>	<3cf7455c-25b6-5c97-3cdb-d68590e44d8f@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00193.txt.bz2

Hi Ken,

On Fri, 6 Sep 2019 17:59:02 +0000
Ken Brown wrote:
> P.S. I'm leaving tomorrow for a short vacation, so I might not have time to 
> review any more patches until I return in about a week.

I submitted five patches during your absence.

Four of them are for pseudo console support, the other one is for console.

[PATCH v5 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
[PATCH 0/1] Cygwin: pty: Fix screen alternation while pseudo console switching.
[PATCH 0/1] Cygwin: pty: Prevent the helper process from exiting by Ctrl-C
[PATCH v2 0/1] Cygwin: pty: Switch input and output pipes individually.
[PATCH 0/1] Cygwin: console: Fix read() in non-canonical mode.

Could you please review them?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
