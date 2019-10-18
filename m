Return-Path: <cygwin-patches-return-9762-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113760 invoked by alias); 18 Oct 2019 11:36:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113703 invoked by uid 89); 18 Oct 2019 11:36:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=AWL,BAYES_05,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=japan, Japan, western, Western
X-HELO: conssluserg-04.nifty.com
Received: from conssluserg-04.nifty.com (HELO conssluserg-04.nifty.com) (210.131.2.83) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Oct 2019 11:36:38 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-04.nifty.com with ESMTP id x9IBaIJb002976	for <cygwin-patches@cygwin.com>; Fri, 18 Oct 2019 20:36:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x9IBaIJb002976
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571398579;	bh=7ZaU5jknhUS3hQD7F0v8Wt2kvL2BkdrKI9+fqCLFipQ=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=JYJuK0EJ5UNlWDUMlNX9Cu/HW8kDTQtkvoDc8Hyv9LSxuuWEC2REqXcfaOjUgsvJo	 S46mRWTJZI1Y7WCXdauGAAtKHHKUKOWU28Fd8V6FRP/3poDLSMQycknvNs+UfTckY4	 EiYgA987hH0OMd7Uyfr4YHeSSsVkQQ3DseVAa2FlWW850/o2UWD+4Y9iexxhju1LEH	 ZUEMofAQuLP7mYljLjEnjK13Jw6B1tkDydctQIhzf+LgiiypKhPvYGg5ubwkP7GSS7	 X+vZ9IXCRUgE/DUHTjlQt13DFvRLwXyTLguCjx+spStl8EBmO3pyRC/DnEYgzj0TGH	 C/IXQcXVTgsUA==
Date: Fri, 18 Oct 2019 11:36:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Change the timing of clear screen.
Message-Id: <20191018203627.489cd4a45ab0ad073b4d8d24@nifty.ne.jp>
In-Reply-To: <1b7038e5-c0e4-b527-71e1-ee46799b215c@cornell.edu>
References: <20191016123409.457-1-takashi.yano@nifty.ne.jp>	<20191016123409.457-2-takashi.yano@nifty.ne.jp>	<0c90ed2b-ed1e-643c-5643-78f50444f97d@cornell.edu>	<2943cac3-3b48-3753-1d06-dff6590bb3b3@ssi-schaefer.com>	<1b7038e5-c0e4-b527-71e1-ee46799b215c@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00033.txt.bz2

On Thu, 17 Oct 2019 16:36:25 +0000
Ken Brown wrote:
> Thanks.  I'll go ahead and push both patches.  And thanks, Takashi.  (Or should 
> I be addressing you as "Yano"?  I'm ignorant about Japanese names.)

Takashi is the given name and Yano is the family name.
In Japan, we usualy use the order of family-name first,
i.e. Yano Takashi. However, many of us use inversed order
when we talk with Western people.

In formal situation, we use family name with "san", i.e.
Yano-san, just like Mr. Yano. Contrary, given name is used
for close relationships.

So, please call me Takashi as always.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
