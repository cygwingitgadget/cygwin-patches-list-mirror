Return-Path: <cygwin-patches-return-9765-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90881 invoked by alias); 18 Oct 2019 23:50:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90872 invoked by uid 89); 18 Oct 2019 23:50:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-7.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Oct 2019 23:50:54 +0000
Received: from Express5800-S70 (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id x9INomj2004198	for <cygwin-patches@cygwin.com>; Sat, 19 Oct 2019 08:50:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x9INomj2004198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571442648;	bh=2gGqrmcr5+P6GIgW6MwOUHHWfCxVIKLNynlcvSeCZk8=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=V5tYHIOuL6s6YDZg2+nDaSVWPljz6qZSohPHhbWN9pLcUzVbLQCaLPQ7a04K7ORYu	 1FAfz8qVxrhqXPA+MrpqWgpre/xL8NCbSN8/UbqlDoB3JZH6aVsxDL4XmCO2dnyBdR	 B+C/JYzQU158BL5td/Vp90FmLk6IS3on9vekc6e31LTBtUxVcYfUMo7Y+ijxkBt1MS	 PVL6RV1SNFDoAT6v1kG4QeTYyIEeRFAUzL281yq7kdHDvNyuUUULG89LmWEtr1BAA4	 gWMgJ0AIUTCrI0IgL57jt6rxck4FJiNhbMkt2qE/wz2oSv0XG03/ERK5vwujwzUXVN	 ddfs37gFj2gsw==
Date: Fri, 18 Oct 2019 23:50:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>
In-Reply-To: <20191018143306.GG16240@calimero.vinschen.de>
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>	<20191018143306.GG16240@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00036.txt.bz2

Hi Corinna,

On Fri, 18 Oct 2019 16:33:06 +0200
Corinna Vinschen wrote:
> Sorry, but this doesn't look feasible.
> 
> You can't base the behaviour on the name of an application.  What about
> other applications like telnetd, rshd, just to name the first ones
> coming to mind?  What about a renamed sshd, or sshd installed into
> another directory, or just an sshd in the build dir during testing?
> 
> Is this workaround really necessary at all?  Even basing this on the
> terminal name looks pretty fragile.

I agree with you. However, I couldn't come up with better method.
Now I have come up with another implementation. Could you please
have a look at v2 patch?

As a caution, this patch is for:
https://www.cygwin.com/ml/cygwin/2019-10/msg00074.html
therefore, telnetd or rshd is not targeted.

> Why exactly is the clear screen necessary?  You wrote something about
> synchronizing the pseudo console and the pseudo tty content, IIRC, but
> it still seems artificial to enforce a clear screen.  Is there no
> other way to make the pseudo console happy?

Using cygwin 3.1.0-0.7 (TEST), by the following steps, you can see
what happens if clear screen is not done.

1) Execute ls or ps to draw something to screen.
2) env TERM=dumb script
3) Execute cmd.exe.

If we can accept this behaviour, clear screen is not necessary.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
