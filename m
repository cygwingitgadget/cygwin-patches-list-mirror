Return-Path: <cygwin-patches-return-10091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52464 invoked by alias); 20 Feb 2020 14:13:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52448 invoked by uid 89); 20 Feb 2020 14:13:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 14:13:27 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 01KED8JU002821	for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 23:13:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01KED8JU002821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1582207988;	bh=cCKBY+zZaA6PpLs+kDmdkAFPnlLLgPaSKXsKlFEGv44=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=z0dXSeuIYrBnDYBS+gleHVJ5cbdFKBtizRo5H3QVijZYNayTz6kqaY0+mSVHUfJ9v	 Upe1y5jWXx3Bv03YqT6S/xTIGFhvWN8A78M8D4AqLlqloXT5229KZjbcZiYbL85Gmv	 8nfKlf8Dw08tiD8/7SzSzhS5i7enSXQ7PgHKBxMbZd+eQPDzgvTnsjOtgruaovplqR	 u4ZCdjMxev0Hw966YBc8fUoGwPuUCK4UnV4EVh8MrvoiLf7bnnTDPAL0KSJdJF81dC	 FbsgTg4ahDbjtO7d7PPtIeuG17o5PSQigy1XoJBfsUnRUi/f76IgP0DxxbVgtRzv8f	 ArmqXX5HQyvpw==
Date: Thu, 20 Feb 2020 14:13:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-Id: <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp>
In-Reply-To: <20200220134459.GS4092@calimero.vinschen.de>
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp>	<20200220133531.GR4092@calimero.vinschen.de>	<20200220134459.GS4092@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00197.txt

On Thu, 20 Feb 2020 14:44:59 +0100
Corinna Vinschen wrote:
> On Feb 20 14:35, Corinna Vinschen wrote:
> > On Feb 20 20:51, Takashi Yano wrote:
> > > - In xterm compatible mode, 0x00 on write() behaves incompatible
> > >   with real xterm. In xterm, 0x00 completely ignored. Therefore,
> > >   0x00 is ignored by console with this patch.
> > > ---
> > >  winsup/cygwin/fhandler_console.cc | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > [...]
> > 
> > Counter-proposal:
> > 
> > diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> > index 66e645aa1774..1b3aa0f34aa6 100644
> > --- a/winsup/cygwin/fhandler_console.cc
> > +++ b/winsup/cygwin/fhandler_console.cc
> > [...]
> 
> Btw., I tested this with
> 
>   write (1, "A\0B\0C\0D", 7);
> 
> it turned out that this results in broken output even with your patch.
> The reason is that a NUL byte must not (cannot) be evaluated by 
> dev_console::str_to_con() -> sys_cp_mbstowcs().  The latter doesn't
> handle embedded NUL bytes gracefully.

Indeed. Your patch is much better.

On Thu, 20 Feb 2020 14:35:31 +0100
Corinna Vinschen wrote:
> But, here's a question: Why do we move the cursor to the right at all?
> I assume this is compatible with legacy mode, right?

Hmm. This may be a bug of legacy console.
https://en.wikipedia.org/wiki/Null_character
says
(some terminals, however, incorrectly display it as space)

What about ignoring NUL in legacy mode too?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
