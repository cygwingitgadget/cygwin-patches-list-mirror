Return-Path: <cygwin-patches-return-10059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7223 invoked by alias); 10 Feb 2020 11:44:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7214 invoked by uid 89); 10 Feb 2020 11:44:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 11:44:50 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id 01ABiXVT015727	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 20:44:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 01ABiXVT015727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581335074;	bh=rCh/nI8ndU51QBMRaBk1X/PadB423/14fy7fI+y5RRc=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=w9Vuf+0g1dF0qJ4EB3Bo5CChLLJjp7nFYdA3acesiV7efOHKqxAGhNYAgmG0KYOPh	 u8Ecmt3yDvgYIzfd06qZytuDBe4n++PtQvW8MBGt09uTkfNtuemAJrRFWYej/20hCb	 ZFV++Wd4kI/Poy8h4NuvKIdj2QgPWF7rXCE9+YyPM8HXNZwHA8bdO+aRQBm/KpzWtj	 Y4eMG9+hvFAkzGbIYUA05cDD092C1BH9CIsqGNUaoht1I2N4lrzIt/OtZRDv5R1Dit	 3woHs/CL6qeQ/ILhxQfrjqMhGJB3Foxf8Rkvr4MiqS0utiHGgEMgTxvYrMUxa3Dz8H	 2JjsYej1o4X6w==
Date: Mon, 10 Feb 2020 11:44:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use pinfo() rather than kill() with signal 0.
Message-Id: <20200210204442.8a9e8e162e122ba0383a9944@nifty.ne.jp>
In-Reply-To: <20200210000603.3e72d135b91e11f6b35af34a@nifty.ne.jp>
References: <20200206104817.1116-1-takashi.yano@nifty.ne.jp>	<20200206190330.GT3403@calimero.vinschen.de>	<20200208235311.bda313987c047dc8bf69ed2e@nifty.ne.jp>	<20200210000603.3e72d135b91e11f6b35af34a@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00165.txt

Hi Corinna,

On Mon, 10 Feb 2020 00:06:03 +0900
Takashi Yano wrote:
> On Sat, 8 Feb 2020 23:53:11 +0900
> Takashi Yano wrote:
> > On Thu, 6 Feb 2020 20:03:30 +0100
> > Corinna Vinschen wrote:
> > > I'm inclined to release 3.1.3 next week.  Is that ok with you or
> > > do you anticipate more patches which should go into 3.1.3?
> > 
> > Currently, I have two patches which are under test. I would be
> > happy if these could be included in 3.1.3. I am planning to
> > divide one of them into several patches. I will submit these
> > patches in a few days.
> 
> Please apply these patches in the following order.
> 
> [PATCH 1/4] Cygwin: pty: Define mask_switch_to_pcon_in() in fhandler_tty.cc.
> [PATCH 2/4] Cygwin: pty: Avoid screen distortion on slave read.
> [PATCH 3/4] Cygwin: pty: Remove debug codes and organize related codes.
> [PATCH 4/4] Cygwin: pty: Add missing member initialization for struct pipe_reply.
> [PATCH] Cygwin: pty: Inherit typeahead data between two input pipes.
> [PATCH] Cygwin: pty: Fix state mismatch caused in mintty.

I am sorry, but I have submitted one more trivial patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
