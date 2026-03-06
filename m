Return-Path: <SRS0=waNz=BG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id E97B24BA2E1C
	for <cygwin-patches@cygwin.com>; Fri,  6 Mar 2026 01:05:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E97B24BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E97B24BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772759107; cv=none;
	b=AwqsMokMWK5qpaV7+azIVnrzVq/C1t6BAuHnyhQqrttgvAHUGwvwjuN1XM15rdQLYyPfrRtjsf1PuzU07SkEsboIO7yx7bEHE49+EyienAQAZOGiQ+sfAOG1OdWZQtcP+121F9kzO+whPohpzgjJD1ssl/FZJuVHu4xzPpzASkc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772759107; c=relaxed/simple;
	bh=hN+fvhzQZz6Lyp2EMT58VpT97NhfJNPTF5krK/+IUFs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hGUvzfgBsTHM6yFjv6n8035aEJAYxITeNvm3J/wfOHc+EN3PG62EeC1coCKkFlyrPvPjxUvsJ8GG7YDVHqy8VKPHH9ECdFhq1rVIDBkP+sOzuZHKomvTxP1dolYun0/pA+FsbAc+Nxwdn+qdH3QU8LhA2X8P94YKRJSuTtKrVqk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E97B24BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JPmieeeH
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260306010504987.OWFR.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Mar 2026 10:05:04 +0900
Date: Fri, 6 Mar 2026 10:05:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/4] Add support for OpenConsole.exe
Message-Id: <20260306100503.787b2f6feb902036a2103fea@nifty.ne.jp>
In-Reply-To: <257059f0-abeb-2109-9b6e-a4683deedb14@gmx.de>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
	<257059f0-abeb-2109-9b6e-a4683deedb14@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772759105;
 bh=/Pq83imDQXxIr8cMa3H43Uy+4M38JV9g+IaogWogoBs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=JPmieeeHhajnvdqxa9xBWOvbSq8Gk5K/JkNJpCefh3fNoa+vY/Xx/lT6K5+auaIgduxgk8a3
 neGcVCXwaquIJv0UZ4Yt6M7FzHkCzwbOHDrTJSAvbf4HNQo+H4A0AVv44JWXdUPdjoRaGN8lzD
 ZcIaMWPKiT2BCFBherQMfJGcLVK7FtzD3fx/KPkyjOLlYXxV0qom5Q45E37vM1S7inMUuxPEVc
 mF4Aqlb6gABmQ6Y6mPm0Cz4qa1toOeHy278dezmTt2+eRfOdRUB196jROC/U8Z6KCeMQ1fc9dG
 cidFQ3HJM/bQOXhBb0bNVc7vpQPlFc/fNNXB9ZEo6mjd0XPg==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 3 Mar 2026 12:03:25 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 28 Feb 2026, Takashi Yano wrote:
> 
> > v4:
> >   * Do not close pi.hProcess in CreatePseudoConsole_new()
> >   * Modify handling of CSIc response
> > 
> > Takashi Yano (4):
> >   Cygwin: pty: Use OpenConsole.exe if available
> >   Cygwin: pty: Update workaround for rlwrap for pseudo console
> >   Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
> >   Cygwin: pty: Fix the terminal state after leaving pcon
> 
>  Three out of these four patches seem to be workarounds for bugs in
>  OpenConsole.exe. The project is open-source and accepts PRs. Would it not
>  make _much_ more sense to contribute fixes for those bugs?

Yeah, indeed. However, ...

Cygwin: pty: Update workaround for rlwrap for pseudo console
This is not a bug of OpenConsole.exe. This is for translation
between POSIX terminall attribute and console mode.

Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
This may be a bug, however, by any chance, an intended behaviour.

Cygwin: pty: Fix the terminal state after leaving pcon
Perhaps, this does not occur if the pseudo console is used as
suggested by Microsoft.

Anyway, for now, since I don't succeed to build OpenConsole.exe
in my environment, it is dificult to debug it by myself.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
