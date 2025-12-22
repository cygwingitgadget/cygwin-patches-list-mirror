Return-Path: <SRS0=d9R/=64=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 121FC4BA2E07
	for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 11:37:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 121FC4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 121FC4BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766403453; cv=none;
	b=j47tQhDDHZbsiLmfKuAZgc3Ydlo4xOi4BjbBXoXX1sWakxZLwZpbr/HcoUjY6whJfvXmtGKtGHPU0XUpXaVdgemxmHl8ka05p9lqg5o8YaIdjdzcBAURB0g9H2Z0H1PU5Gsyyk8cEYJo1WY2MLeYIgQA5EJU5I6Lb84waCyMyao=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766403453; c=relaxed/simple;
	bh=lJmndcL6kcpKZTKokDIPmck0b32fMygJ93K8kHpr2/4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=BYk001eABhx6IKswpkEDn3aJFFg9JSyzbH3CvM81h+135EPhrdtMCJ6Xu7uvkZQ0KK6i33EhY4fyjtHz8G1SaVViSvLRvL1skMt3jJP/02JuUpCxEWQ1diKp2v4FesLnzyO2Hch8l5Aevx98hk3AndzgY2Gn8So1DKPW3vKXS70=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 121FC4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DI3yQzpF
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20251222113730822.SQYP.88147.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 22 Dec 2025 20:37:30 +0900
Date: Mon, 22 Dec 2025 20:37:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Refactor workaround code for pseudo
 console output
Message-Id: <20251222203731.e7e2cd15ab91eada344c5899@nifty.ne.jp>
In-Reply-To: <aUkh6WFkebCZl5YN@calimero.vinschen.de>
References: <20251219131732.1433-1-takashi.yano@nifty.ne.jp>
	<aUkh6WFkebCZl5YN@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766403450;
 bh=zS0roimpenfJq7BYB2t8hOG8U4dTVXGGkTDYt83nnxM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DI3yQzpFi+daQSAhN+q7oFTMgUPSbG+hz8utMlXxZwt3VYID2vIHfi/CHhgF4k+JEQ0ld54M
 UhKn1TEynIxR8BYaufgwJ3Nz0qVlFQrkUq21ytcNwHAE/Db1qsqTtLB5T8McfyOHvoImUObIzD
 m4MhW9WSHRhoAjYNrdRdzhPlw7vuXPnBmII8jNwmcRkpwCM7q9do0T5tYuupr/WHDzK3bTOGOY
 6SotpDLzsivJE5YdU6X06HNcSHoTGsk2my2SASNMD8o/SxQh+e6qG7bWYWBhkQMLpRanoWYt3W
 QDmGaiLniX5d9nxEkDzESWGMEO0Eb5WPZslAIWWiea8S8unw==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 22 Dec 2025 11:48:09 +0100
Corinna Vinschen wrote:
> On Dec 19 22:17, Takashi Yano wrote:
> > Currently, there are four separate workarounds for pseudo console
> > output in pty_master_fwd_thread. Each workaround has its own 'for'
> > loop that iterates over the entire output buffer, which is not
> > efficient. This patch consolidates these loops and introduces a
> > single state machine to handle all workarounds at once. In addition,
> > the workarounds are moved into a dedicated function,
> > 'workarounds_for_pseudo_console_output()' to improve readability.
> > 
> > Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 301 +++++++++++++++++-----------------
> >  1 file changed, 147 insertions(+), 154 deletions(-)
> 
> There's just one typo missing, but you don't have to send a new version for
> that:
> 
> > +	  /* Workaround for rlwrap in Win11. rlwrap treats text between
> > +	     NLs as a line, however, pseudo console in Win11 somtimes
>                                                              sometimes
> 
> > +#define CSIH_INSERT "\033[H\r\n"
> > +#define CSIH_INSLEN (sizeof (CSIH_INSERT) - 1)
> > +[...]
> > +#define CONSOLE_HELPER "\\bin\\cygwin-console-helper.exe"
> > +#define CONSOLE_HELPER_LEN (sizeof (CONSOLE_HELPER) - 1)
> 
> My personal preference would be to define these macros prior to the
> function, but that's a style question I'm not sure we should enforce.
> Whatever makes more sense to you. 
> 
> Other than those, LGTM. In terms of the macros, no new version required,
> just go ahead, whether you move them or not.

Thanks for reviewing.
I fixed the typo and location of #define.

Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
