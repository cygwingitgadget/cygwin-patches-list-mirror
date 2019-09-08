Return-Path: <cygwin-patches-return-9660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13008 invoked by alias); 8 Sep 2019 12:57:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12989 invoked by uid 89); 8 Sep 2019 12:57:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=cygwin-patches, cygwinpatches, rarely, HDKIM-Filter:v2.10.3
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 08 Sep 2019 12:57:54 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id x88CvZO9007660	for <cygwin-patches@cygwin.com>; Sun, 8 Sep 2019 21:57:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x88CvZO9007660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567947455;	bh=0ymsKfiNTpqhZ6SlfK/23urPNbe52gdhEYwVVjdyAR8=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=FHbTb3i/jYcMD6zYfFQ/Fg311FVxfA4olf9iYGJMEcolEWIYwYBot6+QybqO9s7Vy	 LbJYwMwRVZVjnEJ196wD9BzpkbMZ8H/WJqxK94RDWnWAwX3clhU3mfdJpG9O2rNND2	 YUexX5DyjVQY02RX7+Pf+k5+eK7QVYYHdgDBSCHeA2FiPu7a5s1eWa9mU4UhsQP46U	 MhHnVEFTFkUxCOLfM86RdzexXJFKFUSagqDhqMM7HIMDKEeO3Xaq6dAVyXNhp0YRtw	 BnhjIUgthLk+SPOTyCwYwXbFz+7ZG3CLEQRlGN/PnWTCWuR9606eQhDcKe3e+0t/7F	 F4q2oidkO6Jeg==
Date: Sun, 08 Sep 2019 12:57:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/1] Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
Message-Id: <20190908215741.4e817d21a98669f4708f1e9f@nifty.ne.jp>
In-Reply-To: <20190907053925.828-1-takashi.yano@nifty.ne.jp>
References: <20190907053925.828-1-takashi.yano@nifty.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00180.txt.bz2

Sorry, revised again. Please apply v5 patch.

On Sat,  7 Sep 2019 14:39:24 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:

> - When the I/O pipe is switched to the pseudo console side, the
>   behaviour of Ctrl-C is unstable. This rarely happens, however,
>   for example, shell sometimes crashes by Ctrl-C in that situation.
>   This patch fixes that issue.
> 
> v4:
> Fix the problem 1 and 2 reported in
> https://cygwin.com/ml/cygwin-patches/2019-q3/msg00175.html
> 
> v3:
> Fix mistake in v2.
> 
> v2:
> Remove the code which accidentally clears ENABLE_ECHO_INPUT flag.
> 
> Takashi Yano (1):
>   Cygwin: pty: Fix the behaviour of Ctrl-C in the pseudo console mode.
> 
>  winsup/cygwin/fhandler.h      |  4 ----
>  winsup/cygwin/fhandler_tty.cc | 33 +++++++++++++++++----------
>  winsup/cygwin/select.cc       |  2 +-
>  winsup/cygwin/spawn.cc        | 42 ++++++++++++++---------------------
>  4 files changed, 39 insertions(+), 42 deletions(-)
> 
> -- 
> 2.21.0
> 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
