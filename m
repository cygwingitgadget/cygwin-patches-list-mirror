Return-Path: <cygwin-patches-return-9845-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51949 invoked by alias); 13 Nov 2019 10:44:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51938 invoked by uid 89); 13 Nov 2019 10:44:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=proxy, screen
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 10:43:58 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id xADAhrkR005474	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2019 19:43:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xADAhrkR005474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573641833;	bh=NRbBgmLIK+atbnhaCkGCpClwxxLH+ysY1qvhbWYA/vc=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Tu2H9DOcFv30hBLHODSQKrPw/0aotDKPcx64Eu6dD0MEIKmVIhZW3dhsZ9XeWDIlJ	 7NZ9R1iEE/Jc4PjO6hTgb1CPL04oMearzbYlqyX9Hf5bcZaxXldSb5sWRNlzR+Qtv0	 /nKJY6YcXDMmR7Um/gWuJGtcPhm7fNaHFKJ00QCLa2e2Z8fnlo5wMxerPMx6IKW9/v	 I1udLR3PYVfu173jlyYW0rW9FzOKulZ08nbw0aI7A4vRf6TeSRsWWxdxrukNkHKjXk	 s+cV2D42REqEUmwO4ZqJlueBHJ9hUfa6nmH5layj9/REoOdRnjnWqEWZApRkmieXMq	 KvyCvU8dOR1xg==
Date: Wed, 13 Nov 2019 10:44:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use redraw screen instead of clear screen.
Message-Id: <20191113194359.b7bd4dbfdea2b59f02066e4f@nifty.ne.jp>
In-Reply-To: <20191113091835.GM3372@calimero.vinschen.de>
References: <20191112130023.1730-1-takashi.yano@nifty.ne.jp>	<20191113091835.GM3372@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00116.txt.bz2

On Wed, 13 Nov 2019 10:18:35 +0100
Corinna Vinschen wrote:
> On Nov 12 22:00, Takashi Yano wrote:
> > - Previously, pty cleared screen at startup for synchronization
> >   between the real screen and console screen buffer for pseudo
> >   console. With this patch, instead of clearing screen, the screen
> >   is redrawn when the first native program is executed after pty
> >   is created. In other words, synchronization is deferred until
> >   the native app is executed. Moreover, this realizes excluding
> >   $TERM dependent code.
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 30 ++++++++++++++++--------------
> >  winsup/cygwin/tty.cc          |  2 +-
> >  winsup/cygwin/tty.h           |  2 +-
> >  3 files changed, 18 insertions(+), 16 deletions(-)
> 
> Great!  Pushed.

I have found the cursor position is broken even with this patch
if the following steps are executed.

1) start mintty
2) netsh
3) quit from netsh
4) start gnu screen
5) quit from gnu screen
6) netsh
7) winhttp show proxy

I will submit a patch for this issue.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
