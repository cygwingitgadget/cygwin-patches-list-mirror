Return-Path: <cygwin-patches-return-10075-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64532 invoked by alias); 17 Feb 2020 12:38:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64495 invoked by uid 89); 17 Feb 2020 12:38:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 12:38:03 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id 01HCbsbZ028357	for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2020 21:37:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01HCbsbZ028357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581943075;	bh=+VkiuU36MN+e2Rx/4SPALT5nz5X8k0WigN/ISJMvNTI=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=ibM0YsJKQUrnjxf84tpxLY2suROPqFsKcFUO5vL2fBodKXw4O95F7LxXSKJaiGtO+	 JAuws1Q45FW6+VdrJ33A6RKZIyTH9pPYi+u158TwxMS5nz1u7MYH0GsvXWYH0oBugx	 Xoew9gEHnbGo33LuMEtf58/JUBZ/vwYjdTWtxR5sb5zh8yEYjYS+vgy1lladZLxLBO	 SSU6/AyGnbCWH6JmaRTwPtcz9PT9BRIZwMb32szQRNXqi9CCWxHAHsatE4m5L7xQpq	 +6vGd/gXlbTH7PL/51Hrjfe58bw28X5PZCD8YjWDUbEXKoHRsL6+tKhg+GXo7082bT	 0iCoueqnhp7NA==
Date: Mon, 17 Feb 2020 12:38:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-Id: <20200217213759.7e373930ae752aa918b2a426@nifty.ne.jp>
In-Reply-To: <20200217101650.GD4092@calimero.vinschen.de>
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>	<20200217090015.GB4092@calimero.vinschen.de>	<20200217184545.43be636858734d029f2f5a11@nifty.ne.jp>	<20200217101650.GD4092@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00181.txt

On Mon, 17 Feb 2020 11:16:50 +0100
Corinna Vinschen wrote:
> On Feb 17 18:45, Takashi Yano wrote:
> > On Mon, 17 Feb 2020 10:00:15 +0100
> > Corinna Vinschen wrote:
> > > On Feb 16 17:13, Takashi Yano wrote:
> > > > - If two cygwin programs are executed simultaneousley with pipes
> > > >   in cmd.exe, xterm compatible mode is accidentally disabled by
> > > >   the process which ends first. After that, escape sequences are
> > > >   not handled correctly in the other app. This is the problem 2
> > > >   reported in https://cygwin.com/ml/cygwin/2020-02/msg00116.html.
> > > >   This patch fixes the issue. This patch also fixes the problem 3.
> > > >   For these issues, the timing of setting and unsetting xterm
> > > >   compatible mode is changed. For read, xterm compatible mode is
> > > >   enabled only within read() or select() functions. For write, it
> > > >   is enabled every time write() is called, and restored on close().
> > > 
> > > Oh well, I was just going to release 3.1.3 :}
> > > 
> > > In terms of this patch, rather than to change the mode on every
> > > invocation of read/write/select/close, wouldn't it make more sense to
> > > count the number of mode switches in a shared per-console variable, i.e.
> > > 
> > > LONG shared_console_info::xterms_mode = 0;
> > > 
> > > on open:
> > > 
> > >   if (InterlockedIncrement (&xterm_mode) == 1)
> > >     switch to xterm mode;
> > > 
> > > on close:
> > > 
> > >   if (InterlockedDecrement (&xterm_mode)) == 0)
> > >     switch back to compat mode;
> > > 
> > > ?
> > 
> > Thanks for the advice. However this unfortunately does not work
> > in bash->cmd->bash case.
> > For cmd.exe, xterm mode should be disabled, however, the second
> > bash need xterm mode enabled.
> > 
> > On Mon, 17 Feb 2020 10:28:19 +0100
> > Corinna Vinschen wrote:
> > > On second thought, also consider that switching the mode and
> > > reading/writing is not atomic.  You'd either have to add locking, or you
> > > may suffer the same problem on unfortunate task switching.
> > 
> > Hmm, it may be. Let me consider. It may need time, so please
> > go ahead for 3.1.3.
> 
> Ok.  I just wonder if I should merge your patch into 3.1.3 as is for the
> time being.  It's better than the old state, right?

I am very sorry but I found one more mistake. Is it possible to
add a patch for 3.1.3?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
