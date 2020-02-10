Return-Path: <cygwin-patches-return-10060-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44724 invoked by alias); 10 Feb 2020 12:25:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44381 invoked by uid 89); 10 Feb 2020 12:25:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=para
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 12:24:58 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id 01ACOWPR019333	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 21:24:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 01ACOWPR019333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581337473;	bh=VdO7OMwkUW+M5Qbw30qOIQeiEOPJJ6isCr7eJCrqS4Q=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Xu9OfTE81PoRy9UG5TMKrXLnom4SSlyIoou1c43Mgs8nhhhf4BPMeZDwDRaqL2uS/	 VgMhV0InNwsVfKfS9O9E5Pn8P3B7vIHwzHjQL6A7dCsxvwdd8XMf1IzwYVEemwaft8	 qHYOFAdZFLFzSxDj9t8ucqGWZyQMcElIpVSsQTM+ioXyBzak0bBdodJQXCdhxV9QgT	 LWx7UZYbpqD79e8IVV6jK5Fe8NnCn3v45ddbn/raiUKklZYTbtyCNNMfRaxh68GxWz	 Izk9MtCJbN+u9rfB5KjM9IB/mZRD7MthrieI7Zp0Hp0hNgzl73Qbzv1Z6kQF59WZvP	 cuXa1LkMk7tcg==
Date: Mon, 10 Feb 2020 12:25:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Message-Id: <20200210212441.91b09887b3518b029560ff6a@nifty.ne.jp>
In-Reply-To: <20200210100710.GD4442@calimero.vinschen.de>
References: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp>	<20200121132513.3654-1-takashi.yano@nifty.ne.jp>	<20200122100651.GT20672@calimero.vinschen.de>	<a5724cea-edda-6ab9-fc7c-cbf3ad3091cc@towo.net>	<20200210100710.GD4442@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00166.txt

On Mon, 10 Feb 2020 11:07:10 +0100
Corinna Vinschen wrote:
> On Feb  8 18:13, Thomas Wolff wrote:
> > On 22.01.2020 11:06, Corinna Vinschen wrote:
> > > On Jan 21 22:25, Takashi Yano wrote:
> > > > - For programs which does not work properly with pseudo console,
> > > >    disable_pcon in environment CYGWIN is introduced. If disable_pcon
> > > >    is set, pseudo console support is disabled.
> > > Pushed.  I just fixed a missing </para> in the doc text.
> > > 
> > Sorry I didn't notice this before. I think rather than having to decide and
> > unconditionally switch on or off, a better approach would be to
> > automatically enable pseudo console when forking a non-cygwin program only,
> > or have that as a third option. (I think I had suggested this before.)
> > It's good we had pseudo console in unconditionally now for a while, as that
> > apparently helped identifying a bunch of issues, but targetting it to where
> > it's really needed would further help to avoid future trouble, including any
> > performance issues as recently reported.
> > I'm willing to prepare a patch if desired, as I had implemented that
> > condition already for my earlier "winpty injection" proposal.
> > Thomas
> 
> Interesting idea, but given that all the Pseudo Console code in
> Cygwin is from Takashi, he should decide how to go forward.
> 
> Takashi?  What do you think?

I cannot imagine how to realize this right now. Let me consider.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
