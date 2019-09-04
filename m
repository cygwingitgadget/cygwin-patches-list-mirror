Return-Path: <cygwin-patches-return-9604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 895 invoked by alias); 4 Sep 2019 02:12:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 811 invoked by uid 89); 4 Sep 2019 02:12:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 02:12:41 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id x842CX29010067	for <cygwin-patches@cygwin.com>; Wed, 4 Sep 2019 11:12:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x842CX29010067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567563153;	bh=wjHZ7AxX9JIJY/9czVe9byfl7Ft66ES0oufBJaZz3Cc=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=yI6g6IMq71f3IoH/F2Bd+pjgJa8zpQoBiqhHVUN6qd7WtuWeqnzJJHbNZLzcTStXh	 +Mj957uyzEIcPZEurKUnQ1P0fbeI+DUFAJ/9TP+4VVq0z37O5Nnclp/e0yAqWI7acj	 mxMduSyGkZ8MCGsKkhldVwoxrGnfjr47f8mvIqC6uy5PofqZeaAd8Sl4T/70/+PbEk	 C9TzdKce6/Sn2nyC1Jjy5kVxuOmh/PdN7Dv92sZbEUbZx6KNR/bP25fpAZahAPm8q+	 ihLtSiA/8dtyw2/f6KFWNdsCYcWsjjQ+CJUk7NYcWo/SAxWo4QQkgp2cuZL6VC7LGa	 o/98iyeMyCY5g==
Date: Wed, 04 Sep 2019 02:12:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/1] Cygwin: pty: Fix state management for pseudo console support.
Message-Id: <20190904111237.f965f57a8daa1d118da96e18@nifty.ne.jp>
In-Reply-To: <20190903091638.GH4164@calimero.vinschen.de>
References: <20190901221156.1367-1-takashi.yano@nifty.ne.jp>	<20190901221156.1367-2-takashi.yano@nifty.ne.jp>	<20190902143716.GF4164@calimero.vinschen.de>	<20190903120530.f7b31bfa6feb2118762891a2@nifty.ne.jp>	<20190903091638.GH4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00124.txt.bz2

Hi Corinna,

I have posted several patches for PTY with pseudo console support.
Please apply them in the following order.

[PATCH 1/4] Cygwin: pty: Code cleanup
- Cleanup the code which is commented out by #if 0 regarding pseudo
  console.
- Remove #if 1 for experimental code which seems to be stable.

[PATCH 2/4] Cygwin: pty: Speed up a little hooked Win32 API for pseudo console.
- Some Win32 APIs are hooked in pty code for pseudo console support.
  This causes slow down. This patch improves speed a little.

[PATCH 3/4] Cygwin: pty: Move function hook_api() into hookapi.cc.
- PTY uses Win32 API hook for pseudo console suppot. The function
  hook_api() is used for this purpose and defined in fhandler_tty.cc
  previously. This patch moves it into hookapi.cc.

[PATCH 4/4] Cygwin: pty: Limit API hook to the program linked with the APIs.
- API hook used for pseudo console support causes slow down.
  This patch limits API hook to only program which is linked
  with the corresponding APIs. Normal cygwin program is not
  linked with such APIs (such as WriteFile, etc...) directly,
  therefore, no slow down occurs. However, console access by
  cygwin.dll itself cannot switch the r/w pipe to pseudo console
  side. Therefore, the code to switch it forcely to pseudo
  console side is added to smallprint.cc and strace.cc.

[PATCH v5 1/1] Cygwin: pty: Fix state management for pseudo console support.
- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 has some bugs which
  cause mismatch between state variables and real pseudo console
  state regarding console attaching and r/w pipe switching. This
  patch fixes this issue by redesigning the state management.

This hopefully fixes the problem 3 in
https://cygwin.com/ml/cygwin/2019-08/msg00401.html
This also fixes the first problem regarding "Bad file descriptor" error
reported in
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html

[PATCH 1/2] Cygwin: pty: Add a workaround for ^C handling.
- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 sometimes cause random
  crash or freeze by pressing ^C while cygwin and non-cygwin
  processes are executed simultaneously in the same pty. This
  patch is a workaround for this issue.

[PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
  some of emacs screens. These screens do not handle ANSI escape
  sequences. Therefore, clear screen is disabled on these screens.

This fixes the second problem on emacs reported in
https://cygwin.com/ml/cygwin-patches/2019-q3/msg00104.html

On Tue, 3 Sep 2019 11:16:38 +0200
Corinna Vinschen wrote:
> This is a slowdown of about 15%.  That's quite a lot.  Can't you just
> check the incoming handle against the interesting handles somehow?
> If there's no other way around it, we should at least make sure (in a
> separate patch) that Cygwin calls NtReadFile/NtWriteFile throughout,
> except in tty and console code.

I came up with an idea, and implemented it. As described obove,
Win32 APIs are not hooked any more in normal cygwin process.
Hook is done only if the program is directly linked with corresponding
APIs. However, this strategy does not have the effect for console
access by cygwin1.dll itself. So, to switch r/w pipe to pseudo console
side, I added the code in strace.cc and smallprint.cc.

Could you please have a look?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
