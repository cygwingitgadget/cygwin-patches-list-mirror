Return-Path: <SRS0=4QXr=BF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 67B934BA23E8
	for <cygwin-patches@cygwin.com>; Thu,  5 Mar 2026 23:35:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 67B934BA23E8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 67B934BA23E8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772753720; cv=none;
	b=aVP9lazbcDzcEErfRRdvQVp6uFXbBdMfC7M4ZHAtTq5RfDkSJqz4SnAjFUIYYXkRvVemmjDZMR1KapzUDWz4x+0B/l+EGRo4GZLDEdzhPka0pG2mnTmyMphfgX2FZaKKI1Url+YEVHFandNXgXYv0xsUJ4dQt8iMHGAQ8aDqyMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772753720; c=relaxed/simple;
	bh=QkoZJ2k4JIibZ+qjaJLoK46P16AbYHHjSJ4Htvniq58=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=xCe4pk3NcyIwsGrrqojnf2RgdOkXh9pR1G3GbAq8FnkON96M8bOWf/yaooHPuYwliFjpDbifVAyImLv0dHPfZTLNxip/h1yxX0Lp7rUkRKJbO8OqghavgYiA9VzuUyzRnNkL7JFtSQmIGKCq+KZ5BBm53UtrZjCor78zC7n+DtA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 67B934BA23E8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FVo1QXXY
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260305233509427.TMKX.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 6 Mar 2026 08:35:09 +0900
Date: Fri, 6 Mar 2026 08:35:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Do not switch input to to_nat if native
 app is background
Message-Id: <20260306083508.497207c24385e3223c1c12df@nifty.ne.jp>
In-Reply-To: <c62dccd0-a723-1c06-b9b0-cc213b5b6eb7@gmx.de>
References: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
	<c62dccd0-a723-1c06-b9b0-cc213b5b6eb7@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772753709;
 bh=Mny9ELy9UgFIpGN2vhee705Y3dAZTDkVGyW4y0HOG4Q=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=FVo1QXXY5HME3sxx1o3fa2GdgCW2PQPcLN/8cGXlmaGEEl4KSQxCIdXI1doAXfWB54om2JZA
 NnQRcTohUi/jpuQVENg/97M2RehheXOJAyT2+ZMZ6mba/g0h1bvB0+G0E5enBwvein8BGr1yPo
 swXuBBappFzkdBkXysQcuXu5oeV4YuK6794LaWRq8sGJplou1bFfQLyZbMoRQq+hHveF7/YJif
 CoI/W2N/NRVsNLxtHiCUfSlBuWoJVYo7Ry/kPnc0/kM5hKtumueHrwrb66XpxeGBD1dXjOjeBZ
 pE9mklWTJZYwp4L6dkev52lHyBtkAEhqYcOEPfxF2VMnBw+Q==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Mar 2026 09:50:09 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 3 Mar 2026, Takashi Yano wrote:
> 
> > If the native (non-cygwin) app is started as background process,
> > the input should be kept in to_cyg mode because input data should
> > go to the cygwin shell that start the non-cygwin app. However,
> > currently it is switched to to_nat mode in a short time and reverted
> > to to_cyg mode just after that.
> > 
> > With this patch, to avoid this behaviour, switching to to_nat mode
> > is inhibited by checking PGID of the process, that is newly created
> > for a background process and differs from PGID of the tty.
> > 
> > Fixes: Fixes: 9fc746d17dc3 ("Cygwin: pty: Fix transferring type-ahead input between input pipes.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> 
> Well explained, and the patch is precise just like I like 'em!

Thanks for reviewing. Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
