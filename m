Return-Path: <cygwin-patches-return-10116-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123263 invoked by alias); 25 Feb 2020 16:54:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123250 invoked by uid 89); 25 Feb 2020 16:54:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 16:54:28 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 01PGs27V024750	for <cygwin-patches@cygwin.com>; Wed, 26 Feb 2020 01:54:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01PGs27V024750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582649642;	bh=OUcTobI0fMh8DmVY+Sm3n12lcZ0z7gElp8bTn00WgSg=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=xOXC3O4I0pS4EfsqMW9uoHQwP89HXmJL6zf5zCXL/rdwc+5qrgiwfXR/cXVHMvf6E	 MYdjJiLfj/vw0IBF4qKcS0A9LZrD0igmbpgxgVOvDGTx4VDYOp8fPBaQCR9Z2Txofs	 nWF2MUo/Wxsx0W+SzdgK+C2FkVWnmtVExTuEkg/KW4f/wUXSanphtN1snftogGJhG6	 /5f4tHdxZ7WX/lHN5osZ7i2ReCdTs0DLD20suz4O367/uDiHMshl30xqkctEX5jglE	 U2v+G+TyNbQ/nF7kV03Vpv2yGzmZJC+hoPq9sEv4NEiz0AicmM1LLV63bvOU4nTn3T	 jFWdUyJ6ubp0w==
Date: Tue, 25 Feb 2020 16:54:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-Id: <20200226015405.e268c11e91be65821b391271@nifty.ne.jp>
In-Reply-To: <20200225091656.GJ4045@calimero.vinschen.de>
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>	<20200221194333.GZ4092@calimero.vinschen.de>	<20200222170123.23099cf86117791daa1722c5@nifty.ne.jp>	<20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp>	<20200224100835.GD4045@calimero.vinschen.de>	<20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp>	<20200224183318.GH4045@calimero.vinschen.de>	<20200225120816.3abe69332aace2b7f1b392ae@nifty.ne.jp>	<20200225125325.52039a023b7f21c497a05933@nifty.ne.jp>	<20200225091656.GJ4045@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00222.txt

Hi Corinna,

On Tue, 25 Feb 2020 10:16:56 +0100
Corinna Vinschen wrote:
> > > Oh, wait. I was setting foreground and background color in
> > > "terminal" tab in property. If I set them in "colors" tab,
> > > cmd.exe behaves differently. In this setting, your problem
> > > does not seems to occur.
> > 
> > I was wrong. The problem also occur with "colors" tab setting.
> > However, in this case, ScrollConsoleScreenBuffer() test case
> > does not cause the problem. Therefore it may be possible to
> > make a workaround for this. I will try.
> 
> That would be great!

I have successfully made a workaround for this issue.
I will submit it shortly.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
