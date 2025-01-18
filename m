Return-Path: <SRS0=STgq=UK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 069DE3858D21
	for <cygwin-patches@cygwin.com>; Sat, 18 Jan 2025 23:59:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 069DE3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 069DE3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737244766; cv=none;
	b=Mr7d/zFUWWY+peB6zWXXwsOgs3/poezXGBjVwTds6bDIuKlw7NMJyuoNH9B0gpw/qoY/N6UCe4jrgfBHEObqmyYT1SLfFgI0ypfrFJRpcFGwC++Cuz0tTzmZdwUrw61It/s2zKjLK6MkMjD3C8LTbyYkteHIRZxI6HX61Q4EgFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737244766; c=relaxed/simple;
	bh=3B/2dFPRXx8CPRgxLpqb1KaXR6ZPB2fX6eX3pznvpqI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LBeBkfIznyV+BppAyHK4bjvsxQfZ/yRo/+W2Zx4TWlfYy80zHKtny+gq77MNfdfWpKtLMRk7jBu7M1qxxSMgEH6i3raHIDvSAbrNyYnEkWJZWlrzg+OmXTE6Yme09Zxda4lbZQbj1niy0u86OV78ASuYOTboXS8E8CY/bUbV5As=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 069DE3858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=foO/qt0A
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20250118235923096.ORZM.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 08:59:23 +0900
Date: Sun, 19 Jan 2025 08:59:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119085921.e6a4a78cba5d8108b8c3de65@nifty.ne.jp>
In-Reply-To: <20250117185241.34202389178435578f251727@nifty.ne.jp>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737244763;
 bh=gWcHlRQF02rF3R4fUcUadsAb/RAHrrAcD/uKcQaI+mM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=foO/qt0AaALT401YP3DE3tE1H5E7ke/a8TYp6EqMMaGPJG3/sXmKEZv9pZZQpAuQb8rB7cVK
 U3KHtNx4a/T1l08lm2KklgdlI6CYgCZ36yEccAuqVmJiw61vgrYqLvl1IZ5paNVJjkuCd+UzV/
 wuwLBSnpwe/tX81gQ7r5y9YBfw/nB7gHz77ZNYKA2tDLQtInqDtgpLFdBtMGf0jbxDcSgjOsbu
 YPi9ala8kqQdGazjnzLaPF/UUjofFDrzVpJhMH2QKnh4w4CAlAK8je/nJyIvFmq/A9qFJMM78H
 73K0+ee0vyvc1rZvU6EiA1GqOYQbjzw3n1sMlH0eXaZwI0zQ==
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 17 Jan 2025 18:52:41 +0900
Takashi Yano wrote:
> On Wed, 8 Jan 2025 18:05:53 -0800 (PST)
> Jeremy Drake wrote:
> > On Thu, 9 Jan 2025, Takashi Yano wrote:
> > 
> > > On Wed, 8 Jan 2025 16:48:41 +0100
> > > Corinna Vinschen wrote:
> > > > Does this patch fix Bruno's bash issue as well?
> > >
> > > I'm not sure because it is not reproducible as he said.
> > > I also could not reproduce that.
> > >
> > > However, at least this fixes the issue that Jeremy encountered:
> > > https://cygwin.com/pipermail/cygwin/2024-December/256977.html
> > >
> > > But, even with this patch, Jeremy reported another hang issue
> > > that also is not reproducible:
> > > https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> > 
> > Yes, this patch helped the hangs I was seeing on Windows on ARM64.
> > However, there is still some hang issue in 3.5.5 (which occurs on
> > native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
> > seems to be somewhat reliable at triggering this, but it's hardly a
> > minimal test case ;).
> > 
> > Because of this issue, MSYS2 has been keeping 3.5.5 in its 'staging' state
> > (rather than deploying it to normal users), and Git for Windows rolled
> > back to 3.5.4 before the release of the latest Git RC.
> 
> I might have successfully reproduced this issue. I tried building
> cygwin1.dll repeatedly for some of my machines, and one of them
> hung in fhandler_pipe::raw_read() as lazka's case:
> https://github.com/msys2/msys2-runtime/pull/251#issuecomment-2571338429
> 
> The call:
> L358:         waitret = cygwait (select_sem, select_sem_timeout);
> never returned even with select_sem_timeout == 1 until a signal
> (such as SIGTERM, SIGKILL) arrives. In this situation, attaching
> gdb to the process hanging and issuing 'si' command do not return.
> Something (stack?) seems to be completely broken.

This behaviour ('si' command of gdb does not return) is the normal
bahaviour for WF[SM]O. The problem may be a broken timer, I guess?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
