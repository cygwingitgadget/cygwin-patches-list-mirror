Return-Path: <cygwin-patches-return-9585-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42757 invoked by alias); 1 Sep 2019 21:53:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42355 invoked by uid 89); 1 Sep 2019 21:53:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-5.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*i:sk:1169565, H*f:sk:1169565, management
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Sep 2019 21:53:30 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x81LrH1T025878	for <cygwin-patches@cygwin.com>; Mon, 2 Sep 2019 06:53:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x81LrH1T025878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567374797;	bh=VNN4y4k96dLah/q8L4o5+/R6uUpMPaeY59wxRu3b8Mk=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=LaaXOc8JXoal3/ISdLX2nnVy8nZJcBZ55F18/q9Zk8RkzF8B/efyvmhFb4KWSq+VP	 9Is5U89/hQlyj1QP9rzu370qq/jeBLIzYK9MJUWaT/emHR9KUrQ1/jm/iQAC2UjkKS	 aYA4ayFTMboTsrJwIhlh+8Gz459h/IEqFQLJ4VcShTITvYWTL9QX2aFrywOIQpRLuZ	 lDpAm+RYNcLBGRoJNYfY/medF5URvnl9hP4sxVVr4OLXb6FDnHM4ZRctSMiQA+U0V4	 yReT2Rtx9e6BVo3ZLINghRArxh47zVkixunncuAFQtChJGrvRoQ8UTs2502uZUYnMU	 oEGbp3G5Lmf5A==
Date: Sun, 01 Sep 2019 21:53:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/1] Fix PTY state management in pseudo console support.
Message-Id: <20190902065321.5c288f415052f88b6392622c@nifty.ne.jp>
In-Reply-To: <1169565b-6e96-2865-4cad-eb7b2e6abe05@cornell.edu>
References: <20190831225446.1506-1-takashi.yano@nifty.ne.jp>	<1169565b-6e96-2865-4cad-eb7b2e6abe05@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00105.txt.bz2

Hi Ken,

Thank you for testing.

On Sun, 1 Sep 2019 15:13:47 +0000
Ken Brown wrote:
> On 8/31/2019 6:54 PM, Takashi Yano wrote:
> > Pseudo console support in test release TEST: Cygwin 3.1.0-0.3,
> > introduced by commit 169d65a5774acc76ce3f3feeedcbae7405aa9b57,
> > has some bugs which cause mismatch between state variables and
> > real pseudo console state regarding console attaching and r/w
> > pipe switching. This patch fixes this issue by redesigning the
> > state management.
> 
> After applying this patch, I get the following in mintty:
> 
> $ cygcheck -cd | grep bash
> grep: write error: Bad file descriptor
> 
> Further commands after that lead to the cursor jumping around.

I have fixed this problem. I will post it as v3 patch soon.

> Here's a second glitch I've noticed (starting with commit 
> 169d65a5774acc76ce3f3feeedcbae7405aa9b57): In emacs, if I run a command that 
> uses compilation mode, the output displayed in the compilation buffer starts 
> with ^[[H^[[J.  Here ^[ is the escape character, so this is apparently the two 
> ANSI escape sequences ESC[H and ESC[J.
> 
> Sample commands that use compilation mode are 'M-x compile', 'M-x rgrep', and 
> 'M-x find-name-directory'.  I can provide more detailed reproduction 
> instructions if you're not an emacs user.

Hmmm, it seems that ANSI escape sequences are not recognized in emacs.

> 'M-x find-name-directory'
Do you mean find-name-dired ?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
