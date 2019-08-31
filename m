Return-Path: <cygwin-patches-return-9583-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51519 invoked by alias); 31 Aug 2019 23:03:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51510 invoked by uid 89); 31 Aug 2019 23:03:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=management
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 31 Aug 2019 23:03:16 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x7VN37b7030458	for <cygwin-patches@cygwin.com>; Sun, 1 Sep 2019 08:03:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7VN37b7030458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567292588;	bh=f/+mkrJyIORG6xIUtBSDzW5+L2AlJNo23F7zhRLy+hU=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=OCVZZdXfyPyNG+A53I3qiBUiNfI1JU4KKHZ+AmLDxT3jNLDOF22398D9ol7ZWqxlh	 cmQRD9cE34rCcxfmDdMmhDjdrGveg6GwP7hgOi/6lXSS4sFBx3xUzpqrreq4x8CDEU	 PBIUMsc7dov4un7t4nD/FgseH0/VF2NW0T79r/INKNDODPFx82na9UiDay82CDGXsC	 8RLA+By5IZ4Ffxhpc+p1u/PLj/vOteCg4sRFOQvT25ZPiZxqbNmawnace7BDvDE9xo	 QWwyNaO9yr+W1ByTOKql7tf8UdCtPZ0Kv6OZqPPjWP1IgFVFe/CMaJNnOIdFooCBuR	 AfxJAomtBozEw==
Date: Sat, 31 Aug 2019 23:03:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix PTY state management in pseudo console support.
Message-Id: <20190901080315.d7255ff2e66e3748391cf692@nifty.ne.jp>
In-Reply-To: <20190831145318.1854-1-takashi.yano@nifty.ne.jp>
References: <20190831145318.1854-1-takashi.yano@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00103.txt.bz2

This patch has a small bug.
Please use v2 instead.

On Sat, 31 Aug 2019 23:53:17 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:

> Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
> introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
> has some bugs which cause mismatch between state variables and
> real pseudo console state regarding console attaching and r/w
> pipe switching. This patch fixes this issue by redesigning the
> state management.
> 
> Takashi Yano (1):
>   Cygwin: pty: Fix state management for pseudo console support.
> 
>  winsup/cygwin/dtable.cc           |  15 +-
>  winsup/cygwin/fhandler.h          |   6 +-
>  winsup/cygwin/fhandler_console.cc |   6 +-
>  winsup/cygwin/fhandler_tty.cc     | 401 ++++++++++++++++--------------
>  winsup/cygwin/fork.cc             |  24 +-
>  winsup/cygwin/spawn.cc            |  65 ++---
>  6 files changed, 280 insertions(+), 237 deletions(-)
> 
> -- 
> 2.21.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
