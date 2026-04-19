Return-Path: <SRS0=mhjT=CS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id A86134BA23FD
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 10:53:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A86134BA23FD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A86134BA23FD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776596023; cv=none;
	b=HvRf8ebXoMwmTXj2W/LA0zyJ64x+HeuDamM1Im4Ce7GQh/qgkUlLQ5MRoFdug0OzIoPIJjnRs4uccToSBd4yPo+LQy24FiIOKKfCuoNrJQQXdoG1UyD6NGgGVx1xSnNXqxC/6yTSwSYa84qdiYDDafGZeXkiQ4ysTEQ39i/2mPM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776596023; c=relaxed/simple;
	bh=gbMCw2gczqh3T1jn14dfeYOEEOf0xcC+2yAAUkpY7IY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=w/aKRUkj3H+3jP2L8voa+Y03VMOLK9+xwMsIgSJLj4tnCbjSWWa2iAdcgZ8PIphXpe/q9SKCoaQnGhGxw9mazwdDq7KvMnz5kC66tShpusqqJ8c1nIqvWKemzgfiYASWG7QL8cyUYpvXP0lrqCjOhopGjAsHTDWL9lOGZoqJF/Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A86134BA23FD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=i38GuScC
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260419105338676.XUCZ.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 19:53:38 +0900
Date: Sun, 19 Apr 2026 19:53:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: select: Set errno when peek() returns -1
Message-Id: <20260419195336.32d7d8b2c424714bda4f2d40@nifty.ne.jp>
In-Reply-To: <aeStNfAaLRmw9H3X@calimero.vinschen.de>
References: <20260417194531.993-1-takashi.yano@nifty.ne.jp>
	<aeStNfAaLRmw9H3X@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776596018;
 bh=pauhfqr/RYRsjPJOMLsBewAxP3kj7Etuj4B+2Tq9nrU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=i38GuScCQ6xiU7ROpUlg+es9rhFTjxpulkCsxddIyL5ipuWg8hTaqHEnsK8bVvbTogX1w+2R
 B0p+vEJH+sRnjePnQk86aGagg91MY7GEnVJjuuaV2wvQZq5IFiqieXtU4zTsJuFRkt3hI+dQfF
 kPMmteKQV2rRK8ofNhsjsrFSpolfZAhhjBTrfMmif9SxjGfmuQC8A8D2IOWaUDhHglCCx1ut0i
 TfQoIimK06jTPaNL0l+iEyxcY57uy6PgHB29W/LmiECUxlVL8rszwr5yPlp4eF2O09Rm+1HmTf
 wXW2Rm3eQUU7jyYgHFwlnbbpmohEfK7pLpy7a6ueMweZIHfg==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 19 Apr 2026 12:23:49 +0200
Corinna Vinschen wrote:
> On Apr 18 04:45, Takashi Yano wrote:
> > Currently, poll() sometimes returns -1 with errno == 0 if the fd is
> > not opened. This is due to lack of setting errno when peek() fails.
> > This patch ensure to set errno to thread_errno if peek() returns
> > NULL.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-April/259602.html
> > Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> > Reported-by: Nahor <nahor.j+cygwin@gmail.com>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/select.cc | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Looks like an obvious fix :)

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
