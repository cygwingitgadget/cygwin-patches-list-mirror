Return-Path: <cygwin-patches-return-9968-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124499 invoked by alias); 21 Jan 2020 13:23:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124490 invoked by uid 89); 21 Jan 2020 13:23:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1914, our, HContent-Transfer-Encoding:8bit
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Jan 2020 13:23:41 +0000
Received: from Express5800-S70 (ntsitm247158.sitm.nt.ngn.ppp.infoweb.ne.jp [124.27.253.158]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 00LDNSIv017006	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2020 22:23:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 00LDNSIv017006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1579613009;	bh=G9ZN/tRHFWl84hVZcvAeXK6eH0TpTi/L8JDFn2CTq1Q=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=vVIGWewQ4sgLdAZ7sgcLFXyc7EwQtnluzHMbP09FC8Bsv47zx538F0bHtV5DDDd5D	 v4UxVTzl62kLD53ofZgz9gVaojmHFF/hsqggp931SIN9YgxPJpsyVZcBHgLNsrr4gp	 FlM1rO8+o9W7Puno6Osu6E2L8r5eP9HBJwlXduYPFS/R5I8kdtNs2Dxz8+qKenmoIB	 FvrHbwt5DQX/9YVbd0GQq7T5E2V+1LN8nP89HYTzNw3kZIsJKh1YM7phC2abgwJ1Ex	 KseEs5DA2NdkmwjU9HUrBQRXImqCavoHoqB9S4lB6XJDi7Y4o6yzX7mk3hPhVzIbgz	 ZYJmMR018CSWw==
Date: Tue, 21 Jan 2020 13:23:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
Message-Id: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp>
In-Reply-To: <8f78d0f4-6a03-505a-6b69-9df1e4c6cf4a@cornell.edu>
References: <20200120025015.1520-1-takashi.yano@nifty.ne.jp>	<20200120100646.GE20672@calimero.vinschen.de>	<20200120214124.9da79990b75a658016cf34d7@nifty.ne.jp>	<ed59eb98-8e59-f0d1-d1c3-9f44cb6cbee7@dronecode.org.uk>	<8f78d0f4-6a03-505a-6b69-9df1e4c6cf4a@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00074.txt

On Mon, 20 Jan 2020 14:58:52 +0000
Ken Brown wrote:
> [Adding the cgdb maintainer to the CC.]
> 
> On 1/20/2020 9:18 AM, Jon Turney wrote:
> > On 20/01/2020 12:41, Takashi Yano wrote:
> >> Hi Corinna,
> >>
> >> On Mon, 20 Jan 2020 11:06:46 +0100
> >> Corinna Vinschen wrote:
> >>> On Jan 20 11:50, Takashi Yano wrote:
> >>>> - For programs which does not work properly with pseudo console,
> >>>>    disable_pcon in environment CYGWIN is introduced. If disable_pcon
> >>>>    is set, pseudo console support is disabled.
> >>> Oh well, do we really need that?
> >>
> >> This is, for example, needed to solve the issue reported in
> >> https://www.cygwin.com/ml/cygwin/2020-01/msg00147.html.
> >>
> >> I looked into this problem, and found that cgdb read output of
> >> gdb from pty master and write it to ncurses. The output from
> >> pty master includes a lot of escape sequences which are generated
> >> by pseudo console, however, ncurses does not pass-through them
> >> and shows garbages. This is the cause of that issue.
> >>
> >> cgdb is the only program do such things so far, however, there
> >> may be more programs which do not expect escape sequences read
> >> from pty.
> >>
> >> There is no way to control pseudo console not to generate
> >> escape sequences, therefore, I proposed this patch.
> >>
> > 
> > I think this may actually be an issue with cgdb being old.
> > 
> > The latest gdb enables "output styling" using ANSI escape sequences by default, 
> > but our cgdb can't handle them?
> > 
> > See: https://github.com/cgdb/cgdb/issues/211

I downloaded latest cgdb source from
https://github.com/cgdb/cgdb
and
https://github.com/atotic/cgdb
then built them in cygwin, however, both do not work under
cygwin pseudo console enabled.

Therefore I think this patch is needed for now.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
