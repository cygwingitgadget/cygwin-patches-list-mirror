Return-Path: <cygwin-patches-return-9607-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16053 invoked by alias); 4 Sep 2019 03:45:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16034 invoked by uid 89); 4 Sep 2019 03:45:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=80x24, screen
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 03:45:56 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id x843jlMQ021526	for <cygwin-patches@cygwin.com>; Wed, 4 Sep 2019 12:45:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x843jlMQ021526
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567568747;	bh=NlEFNJd8XsOCjCvFPnZPSCugzrjr0m211wgz3KnB3FA=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=gIVbVVUqMysNWWfrstAfYehe0JlRK49uNaIFLpiAhf0qcNt9IKDq+/H/sELjfJ8q1	 TI1jh2eIVmiuJx0UgR+rnA7/62hPP0I8WuP/et99hOCRKzpHjTNTV7ceo+0Qhj8W7J	 aBwOHLmxlNWN3nF1bziNA5poNivfXdpRNRCqBYtReBQO1W9bpfiSOut61DDB5x3mox	 dHD1zr7PdHG1QOK5two7fCJNGEokAsL73K32bBEZwxLXzi+csj1Dm1AMIoNB/9Ruym	 jXHBKOmuxx9XtXmjGgoWmOMrT8rfaTRLZq73iMkPa5SbvXDiPUdsLgTLPWbeerW0sE	 DS5W4Bo6/iBTg==
Date: Wed, 04 Sep 2019 03:45:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-Id: <20190904124551.c1aa5b7a15689d384d95356a@nifty.ne.jp>
In-Reply-To: <20190904123431.59ac7a667f91e3cb65f2a9a9@nifty.ne.jp>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-3-takashi.yano@nifty.ne.jp>	<e8c3b43a-7988-bb2c-a52b-dc792677dd96@SystematicSw.ab.ca>	<20190904123431.59ac7a667f91e3cb65f2a9a9@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00127.txt.bz2

On Wed, 4 Sep 2019 12:34:31 +0900
Takashi Yano wrote:
> Attached is the raw output from pseudo console when the screen shows
> the simple text below.
> 
> ---- from here ----
> [yano@Express5800-S70 ~]$ cmd
> Microsoft Windows [Version 10.0.18362.329]
> (c) 2019 Microsoft Corporation. All rights reserved.
> 
> C:\cygwin\home\yano>exit
> [yano@Express5800-S70 ~]$ exit
> exit
> ---- to here ----
> 
> You will noticed that the screen is cleared if you execute
> cat pcon-output.log
> in a terminal which support ANSI escape sequences.

This pcon-output.log was recorded in screen of 80x24 size.
Please try above in 80x24 terminal.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
