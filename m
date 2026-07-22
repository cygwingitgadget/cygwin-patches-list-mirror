Return-Path: <SRS0=IG9T=FQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 338BE4BA2E08
	for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 12:56:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 338BE4BA2E08
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 338BE4BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784725007; cv=none;
	b=MkuLZ2IxuLuE2oT5mp9sEAKeAHRlOIU3NXpBle0zuBZv1HB3bPJClCZGQaUhTj2RvfdKgm7Aw3p8vm6gleyH59tanWPa1UWBanH5nwJ16Jyo0rRVJjsy83U7IOQcJ07SkX6c6IoGm3hY/r4PDUdaNeHJMYLPRlSV0YiTIhFDWLo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784725007; c=relaxed/simple;
	bh=MqeVxMx7R//Rte07xeWUPuYBOiggaaK7ictZvfokhkI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=GBvOKP699nlK/er9FXmUZ8z1LAGbuRr9aXyHDiCUvo5v7wbW98J49OCKA2My6apZ8YbXXXdDQ3f0YgWyGutMwPAwlHL0KNklB4aj1gF+AYWSFWheruvis2s7kNXTLIah57+UFiPePCN4qkLd3NbQsXZVoWZXsz4L4VESwGJdf+I=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IDrDLRme
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 338BE4BA2E08
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IDrDLRme
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260722125643339.PDVQ.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 22 Jul 2026 21:56:43 +0900
Date: Wed, 22 Jul 2026 21:56:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: open: Unlock fdtab before open_with_arch()
Message-Id: <20260722215641.e9aad82023614cea4e1aec63@nifty.ne.jp>
In-Reply-To: <20260722201012.8403bbf6045b2fb041af985b@nifty.ne.jp>
References: <20260717031021.1537-1-takashi.yano@nifty.ne.jp>
	<bccbac3b-78e9-67d3-2a92-30986f6ff9b6@gmx.de>
	<20260722201012.8403bbf6045b2fb041af985b@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784725003;
 bh=zSU2cd+JLffP1sujaxN188QqGNVrqng3cU/EjX+bIp8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IDrDLRmeFWo8YdU5c7MMW8uIzaDiC1bDvldX0OjcrlZjUryDkH+002dA3SoTp1xXcRxV+Nv1
 3cWPUWqGATGcysbRe0fcnIeJrINMXIQAVDBczRXROjMlU8rbkBK7BJH5y7IwL7bYLdvzhtTUKN
 qQ9ZcppQVgsEYmAuBPvJKmGsMztBFA+asqfSWkgYBecq/JgmR1X1kcxBnpLd/X0fsnEn73ssax
 JDvZkzg13L5X9PHmCBlB47lhyB8Z04J8DiDwFjZX7lwKhR/lLRMV3WzVNUL/qv+YxO2hN+O+pG
 krkM799S55qrQulPkRBYbljNoeygPGS51qNV02a5qEOjUeHg==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 22 Jul 2026 20:10:12 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> Thanks for reviewing!
> 
> On Tue, 21 Jul 2026 19:16:11 +0200 (CEST)
> Johannes Schindelin wrote:
> > This is the first point where the slot and its reference count agree
> > again; Too late for anything that looked in between. And the cleanup only
> > runs for non-negative descriptors, so it never covers the case above.
> > 
> > Since it is already in `master`, a follow-up patch probably makes most
> > sense. Two things to fix: release the lock when no descriptor is
> > available, and stop a reserved-but-not-yet-open descriptor from looking
> > like a fully open one to the rest of the fdtable. Reviving the old integer
> > marker would mean teaching every consumer of the table about it, so it is
> > not a drop-in.
> 
> Ah, I got it. The user program cannot know that, but cygwin1.dll can
> refere fdtab inside it. What about adding reserved flag to fdtab?

I tried it as quick experiment.

The result of the first reproducer is:
baseline close(-1): result=-1 errno=9
descriptor allocation stopped after 3197 opens: errno=24
second-thread close(-1): result=-1 errno=9

The result of the second reproducer is:
expected FIFO writer descriptor: 4
provisional descriptor query: result=-1 writer_done=0

Are these results as you expected?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
