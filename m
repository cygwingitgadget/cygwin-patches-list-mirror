Return-Path: <SRS0=MmMu=R3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 443A2385772E
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 08:36:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 443A2385772E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 443A2385772E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730363809; cv=none;
	b=H4eSYlmf4FcamS0egFs60QyFcxqUEqMjgkIGG+o4+oykUMZMpv4JNHyIE2VEWgB3RTlCCOA6HUIzRlGMWc7GLPXrDVoCB9FmVyvQu8F00dYC2+/Cfb/isPbhBGfenH3rbwTtA9pEI3S74RqxlxekF9yO5PSXDPlxXQt8CkU0Puk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730363809; c=relaxed/simple;
	bh=MAopVh9XEmI3QbiO3e7hX4Tza5lRUq1rp+5ZYB9Uc0s=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=TXQsm3KAPpX9iWjexiw3+Ci9J0BkNcxR1c9HY31xskGQZZWzfnIxwDBC7ehH6Da7z/X8VbyXSF+MiINaU4U8ZtMJvKL8mi4xXSf38ltmT4MeIDqx+e9GDanaPs/0l+5oALD/sVpFcGIhC50cmVHmTio11H8OVe1+SH8Gemx3mbU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20241031083636587.ZRFL.87244.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 17:36:36 +0900
Date: Thu, 31 Oct 2024 17:36:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: sigfe: Fix a bug that signal handler
 destroys fpu states
Message-Id: <20241031173636.a174c2addf42ab8fde68ae81@nifty.ne.jp>
In-Reply-To: <Zxtbry_Qb70ouRw-@calimero.vinschen.de>
References: <20241014063914.6061-1-takashi.yano@nifty.ne.jp>
	<ZxfLig9716RXtWLu@calimero.vinschen.de>
	<20241024175802.a7d18a8e604ff2d18221cfcb@nifty.ne.jp>
	<Zxtbry_Qb70ouRw-@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730363796;
 bh=ikvkO8Tdt6lvDHZXK3Mf1hPRffogvw2wmq0CbIofMo8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=jYTWSCk9gpDKACxP6DGoZEf3knIr/2hlqI4cDDHe4z3R7GJgjZGjiOH7QaOHF2vFG2yvf0KT
 L/w0w99pQdIIyCzlx9cK7u1UH9JTGkw+pQ4QvPk2QcdtQ0vrHK4VpUd/8kBg1UcjT4E0izRD5X
 ZTkIU+3+rBVIbFHPxzboES4GsuC/Tr+n3ewZ+u0i1Ndyp09+UcWvikyHxEO4a8SPA/vK+SgzmS
 GCZ7ag0jxHg3y14+KQ0ZlHGjys7gaZbUu9gtFWYmqCJPcju6f03s8QqsdlOL4icYt7PcfSX0+S
 LalqMMPDMUSVLB7+iov4BP5SYeCwMdwvdDoJSz+R0Tx5S7sQ==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Fri, 25 Oct 2024 10:49:51 +0200
Corinna Vinschen wrote:
> On Oct 24 17:58, Takashi Yano wrote:
> > On Tue, 22 Oct 2024 17:58:02 +0200
> > Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> > > Hi Takashi,
> > > 
> > > big change, so, honest question: Do you think this is safe for 3.5.5?
> > > 
> > > This certainly also requires an entry in the release text and there
> > > are just a few minor typos in comments, see below.
> > 
> > What about adopting my first idea to 3.5.5
> > https://cygwin.com/pipermail/cygwin/2024-October/256506.html
> > and applying this patch to 3.6.0 branch?
> 
> Admittedly, I'm also not deep in FPU stuff.
> 
> fnstenv/fldenv and dropping fninit look like a simple approach to fix
> the worst problem.  Did you just discuss this on the mailing list or did
> you check that it actually fixes the reported problem?

I tested locally using Christian's test case and confirmed that
the problem has been fixed as well as that no new problem occurs.

> But either way, I wonder if it's worth the effort to have two different
> solutions.  This isn't a regression, so we don't have to fix this ASAP
> in 3.5.5.  It could easily wait a version.
> 
> So I'm thinking we should go with your sleek new code in 3.6 and let
> this simmer for a while, so it's put to use by people running 3.6
> versions.
> 
> Does that sound right?

Hmm, this is not a regression but a long-standing bug which can
easily be fixed. Also, there is only a very small risk of regression
with the fnstenv/fldenv patch. Moreover, the bug causes critical
miscalculations to result in long double processing.

So, I think it is better to apply the v3_5-branch patch (I have just
submitted) for cygwin-3_5-branch, and to apply the v3 patch (I already
submitted) to the master branch. v3_5-branch patch is simple and small,
so it will not be so painful to maintain.

Don't you think so?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
