Return-Path: <cygwin-patches-return-9960-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73792 invoked by alias); 20 Jan 2020 12:41:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73783 invoked by uid 89); 20 Jan 2020 12:41:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=D*jp, UD:www.cygwin.com, wwwcygwincom, www.cygwin.com
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 12:41:38 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id 00KCfMEA016595	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2020 21:41:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 00KCfMEA016595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579524082;	bh=NxoneY7+Vy4kQDUZV8WZ+OI2lLxfOYnZMPs0YJcpXhk=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=IZK6si5zoIEBNQeNNdRyy8YdDIjnq9r0NnTjDsYoNNCGzEZ5hjaivypGm8uKsTT9Y	 xxq70Ur/SydEALcgYBpx4O/bm62RdarxZXLdyQ2C6jgMyqPl72oKN3mfs6SCHfK/QI	 1H5a/RoX2R1jJWYG5BUfhJe/pNpY2PALZL2YV1coAVB+GsLiPNsGDg3z+wPXDhfVHJ	 tFOADz/zq24gyrtouMpZ7pLvqJnaOxu+KUXkO+brajmZf7wfRvVyF7MYA3Pm9+a1r4	 411UKdB7jg4Rn3+mtNOO4tahbbvLD4c3+4ox30d0B81K7/f1kFZhZsyLlyNDMa8Zrt	 P3V3IPQ3l58gg==
Date: Mon, 20 Jan 2020 12:41:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Message-Id: <20200120214124.9da79990b75a658016cf34d7@nifty.ne.jp>
In-Reply-To: <20200120100646.GE20672@calimero.vinschen.de>
References: <20200120025015.1520-1-takashi.yano@nifty.ne.jp>	<20200120100646.GE20672@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00066.txt

Hi Corinna,

On Mon, 20 Jan 2020 11:06:46 +0100
Corinna Vinschen wrote:
> On Jan 20 11:50, Takashi Yano wrote:
> > - For programs which does not work properly with pseudo console,
> >   disable_pcon in environment CYGWIN is introduced. If disable_pcon
> >   is set, pseudo console support is disabled.
> Oh well, do we really need that?

This is, for example, needed to solve the issue reported in
https://www.cygwin.com/ml/cygwin/2020-01/msg00147.html.

I looked into this problem, and found that cgdb read output of
gdb from pty master and write it to ncurses. The output from
pty master includes a lot of escape sequences which are generated
by pseudo console, however, ncurses does not pass-through them
and shows garbages. This is the cause of that issue.

cgdb is the only program do such things so far, however, there
may be more programs which do not expect escape sequences read
from pty.

There is no way to control pseudo console not to generate
escape sequences, therefore, I proposed this patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
