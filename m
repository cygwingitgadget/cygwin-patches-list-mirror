Return-Path: <cygwin-patches-return-9305-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64545 invoked by alias); 3 Apr 2019 16:26:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64534 invoked by uid 89); 3 Apr 2019 16:26:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HDKIM-Filter:v2.10.3, H*F:D*ne.jp
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 03 Apr 2019 16:26:15 +0000
Received: from localhost.localdomain (ntsitm424054.sitm.nt.ngn.ppp.infoweb.ne.jp [219.97.74.54]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x33GPxpn019653;	Thu, 4 Apr 2019 01:26:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x33GPxpn019653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1554308767;	bh=T4NnkxjjrCK9k721O3Q6ideA4FVVV7XL/UcDHFQbcV8=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=1axedRTCNrjQx4f6bGyNS054/fLeajVdYkVxHhuVYiTloGiTZ/58TzzpAdWkQaWwD	 /KYzkXz81oH0c5ieU95sb6n/7g8qdL3OrnZ2jbrO/ak4y7je46FhjuCmu/SIUsWqFj	 8MR6gDH9n4oMyy6s2YayylF5+MYPDgcp6NuKgFdp3L+3GryuB9HA10AaN9ae2A+FyW	 qH/pCLhvO472k9+7qRS9sKGhE6X+U1YhyZ+k2SZO0nJkJF51tOa//DpgbtU5kvWO/a	 hGzviUPpXt6SkmPL0KGDAQHiFU0j7pKh9tyJ77/cKDmCEfXFYC1lfgPlMFEZ8m8h7P	 N+gU+FJYWhYTw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/1] Fix console again (Re: Pseudo console support in PTY)
Date: Wed, 03 Apr 2019 16:26:00 -0000
Message-Id: <20190403162531.2837-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190403072758.GR3337@calimero.vinschen.de>
References: <20190403072758.GR3337@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00012.txt.bz2

Hi Corinna,

I have made a patch for the issue reported in cygwin-developers
mailing list as follows.

Could you please check?

On Wed, 3 Apr 2019 09:27:58 +0200 Corinna Vinschen wrote:
> On Apr  3 09:18, Thomas Wolff wrote:
> > > - cmd history works
> > In the cygwin console, it does not, echos the cursor-up escape sequence
> 
> Oh, right, ...
> 
> > instead. See my previous comment that I think ConPTY should only be applied
> > if running at a pty. (And for other reasons only when starting a non-cygwin
> > app.)
> 
> but you got that wrong.  The conpty stuff *is* only applied for ptys.
> 
> The above appears to be a fallout of the console changes to support
> the Windows console changes to emulate an xterm-256color,
> https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=bd627864ab41
> 
> Takashi, can you take a look?

Takashi Yano (1):
  Cygwin: console: fix key input for native console application

 winsup/cygwin/fhandler_console.cc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.17.0
