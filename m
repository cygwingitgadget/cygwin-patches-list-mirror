Return-Path: <cygwin-patches-return-9779-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16696 invoked by alias); 22 Oct 2019 07:26:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 16685 invoked by uid 89); 22 Oct 2019 07:26:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 07:26:49 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x9M7QTr4032522	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 16:26:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9M7QTr4032522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571729189;	bh=pPJoQINQ7HnV6ZPAqtGO4AvATJ9jbg24yUXrMVxfhhg=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=BgWQXSByvS99KKs6CyppiZ4r3aU2E2okhUM5r2K5KhBBcWelOL4gUDFpxCC9KhUjD	 l/Xeq3Kj+lmcZQU3e2ybTl+z0WNxp0Gb/XtIol0VtV2feIvUIfDYnBxr3+auGk/p93	 VRWdvQbf07V4A252/4t/XH3kRmPfTwqU6ehT69uM+2XrsTSA7UGUxlin7FhcSoqJom	 7BglWeukiEnGcmg6wXZlA/rEi+Lmwwt5S7hROeEPVKpQJOHXqzFyFs+A7204okA2CW	 Efl67IintKykq7eCy4Pgbi1y/Qy6N9jNFvW0N8EmaHkNLR+tbBrH0XV9EJT9CsZ2ml	 NCbJsNxrUDSJg==
Date: Tue, 22 Oct 2019 07:26:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191022162634.2edebc40a326d7558708ecb0@nifty.ne.jp>
In-Reply-To: <20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp>
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>	<20191018143306.GG16240@calimero.vinschen.de>	<20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>	<20191021094356.GI16240@calimero.vinschen.de>	<20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00050.txt.bz2

On Tue, 22 Oct 2019 09:09:30 +0900
Takashi Yano wrote:
> On Mon, 21 Oct 2019 11:43:56 +0200
> Corinna Vinschen wrote:
> > The (admittedly vague) idea is, maybe cmd.exe can be cheated into
> > not changing the console buffer by changing it to what it expects
> > right after creating the pseudo console...
> 
> To do this, it is necessary to log past data written to pty and
> push them into console screen buffer when pseudo console is started.

This does not make sence because ssh session may opened from other
systems than cygwin, i.e. Linux. In this case there is no way to
know real screen contents.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
