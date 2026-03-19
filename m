Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 7EC464BC8986
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:55:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7EC464BC8986
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7EC464BC8986
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917703; cv=none;
	b=bWWBJo3hzkfLCtHtllXm0j2x8ng8bFfE7qvlVrvoJuUvazL6h6lma/vR+6PfiqQK4Rt9O83eO0yudPk0vmmsm4qr8G/1ZnQ9RD/il+oYv8uEGMHHSt9/Nxtb+3PA6auTbVydK0DXwrl9aPOWgsvPjj0lgmNOMv6XjTpD3ybnmyg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917703; c=relaxed/simple;
	bh=rAf1vU2otozQCxPjl7ah2U7fHVs5FxWNXkyUCYkoCas=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=cx8O81FY4GUzvNJeDATk3sIQ7RnQsOglt+uo3u17mr5XKWofnRFRmQXy9oLUl5qVFJIEQOPp1o9cG0SzcnxM/Y/fKf3AFrlgcBztl/QVU70n6LsM4/0ze+IpvwAc02Xsa2yKQWqpblz5wGUnMfvbh1/bjr1N0bSRDk+S38uYA/I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7EC464BC8986
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hzeXIRD4
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260319105500296.TBBH.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 19:55:00 +0900
Date: Thu, 19 Mar 2026 19:54:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/6] Cygwin: pty: Add workaround for handling of
 backspace when pcon enabled
Message-Id: <20260319195458.e449fc15e20cc10f9a3ad1c2@nifty.ne.jp>
In-Reply-To: <20260318234600.211af0aa09c330d145649239@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
	<20260317122433.721-1-takashi.yano@nifty.ne.jp>
	<20260317122433.721-3-takashi.yano@nifty.ne.jp>
	<2f8628d2-b79a-95a6-480d-7508375958d5@gmx.de>
	<20260318202032.54cf28ea83d863082f1bb153@nifty.ne.jp>
	<20260318220114.7ce48e354fdc4d3014b1b991@nifty.ne.jp>
	<20260318234600.211af0aa09c330d145649239@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917700;
 bh=6FycSwzEnquQSP35Ls8SMxWAMIpnjnYCM1PBqmRd/2Y=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=hzeXIRD4wSg10ZZK+DWOCp58zN0nXuTnx4704a2M8NnPB0eZgEsYLUz79pLiIZx8ohmOl647
 qXEfC20bxbvtwnq2Je47IvtXP/p5B3gat674aXeNzmdIvkervMshBeYSNkhlD92gSlthOSY2sd
 f4cd/TL1QbtnzRg75N9EVP8QhtVTyGg/ekEaJmq2xObg7AUifsPGya5sgq5V+k7Y4QEgmQcRsQ
 K+95RR/Ep0XqMTLPXj5YQUJIBfJL66wMVOE7/Bc7VCJuKK5tJEXAeiTAprgvIk0JZFdvokPbXG
 r9YnGUfXV1BA/BeydhSbLFoTCfqSH1bdS4cfMJEsgD33quhg==
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 18 Mar 2026 23:46:00 +0900
Takashi Yano wrote:
> On Wed, 18 Mar 2026 22:01:14 +0900
> Takashi Yano wrote:
> > On Wed, 18 Mar 2026 20:20:32 +0900
> > Takashi Yano wrote:
> > > Hi Johannes,
> > > 
> > > On Tue, 17 Mar 2026 16:28:28 +0100 (CET)
> > > Johannes Schindelin wrote:
> > > > This cannot be correct, and I am rather convinced that the idea behind the
> > > > patch (interleaving `WriteFile()` calls to the pipe with sending raw
> > > > keyboard events via `WriteConsoleInput()` to a _different_ handle) will
> > > > _never_ be robust enough.
> > > 
> > > Then, only the thing we can do till fixing the issue upstream, is
> > > writing all chars using WriteConsoleInput() instead of WriteFile()...
> > > 
> > > What do you think?
> > 
> > On second thought, replacing Ctrl-H with '\x7f' might be enough.
> > Please see PATCH 2/6 v2.
> 
> Sorry, something has been broken with the patch set:
> PATCH 1/6
> PATCH 2/6 v2
> PATCH 3/6
> PATCH 4/6 v2
> PATCH 5/6
> PATCH 6/6 v2
> 
> Please wait a while.

Since the version numbers were getting confusing, I'll send a unified
v3 of the updated patch set. Hopefully, this should fix the issues.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
