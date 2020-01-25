Return-Path: <cygwin-patches-return-10003-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113032 invoked by alias); 25 Jan 2020 11:38:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113023 invoked by uid 89); 25 Jan 2020 11:38:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=apps
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 25 Jan 2020 11:38:48 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id 00PBcTJP015329	for <cygwin-patches@cygwin.com>; Sat, 25 Jan 2020 20:38:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 00PBcTJP015329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579952309;	bh=k8+35H8KVQpzJNxBsgq+ZoU8r50oLjebazims7ncYCI=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=E/tDFGxCge6NvOV4ItETozPiB8KYPJ3w580CJBb/lMzKFXEOqWQSykRIwXWw2IV9h	 +HujdeVrI/D3uUD9J33HXyuJ5NAMf6QseCkDVc3MI6onesZmVhc5tnvzGufpZwV38C	 99gEeFC7Se+4IMO4UgW/4a+7qOlY6CzOWrDvaGmD8+fGwtrpPlJa/5wtZJDs4JwYAj	 0hoHksj0GEsmofdUyo5irAffd3YHf3zU/mK5enhwoII+/2vuChJ1odYNSWCmtSocjr	 JqEUKq1rMliO+ZyaXoO21BJH2qs3RjigvAYZ48OJRY9vhI6xhl0C+SBOIMDpDmPpPK	 f+cVwRfoCJkkw==
Date: Sat, 25 Jan 2020 11:38:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-Id: <20200125203837.e37257365f30d33002f9e9f6@nifty.ne.jp>
In-Reply-To: <20200124110730.GG263143@calimero.vinschen.de>
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp>	<20200123043007.1364-1-takashi.yano@nifty.ne.jp>	<20200123125154.GD263143@calimero.vinschen.de>	<20200123231623.ed57b0af319d1de545f2ab7c@nifty.ne.jp>	<20200124110730.GG263143@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00109.txt

Hi Corinna,

On Fri, 24 Jan 2020 12:07:30 +0100
Corinna Vinschen wrote:
> Too bad.  It's pretty strange that CreatePseudoConsole returns a
> valid HPCON but then isn't ready to take input immediately.
> 
> > I do not come up with other implementation so far.
> > 
> > Let me consider a while.
> 
> I wonder how others solve this problem.  I see that the native OpenSSH
> is using Sleeps, too, in their start_with_pty() function, calling
> AttachConsole in a loop, but I'm not sure if these are related to pseudo
> console usage.  The commit message don't explain anything there :(

The essence of the difficulty is that we have to support both cygwin
programs and native console apps. If we consider only of native console
apps, any time we can use pseudo console. However, pseudo console is
not transparent at all, so it cannot be used for cygwin programs.

Therefore, current cygwin is switching handles to be used between
named-pipe and pseudo console.

However, because pseudo console has relatively long latency, if pipe
is switched just after writing to pseudo console, the forwarding
does not get in time. So the "wait" is needed before switching.

I had tried WriteFile(), ReadFile() and DeviceIoControl() for
HANDLE hConDrvReference, however, all atempts of them failed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
