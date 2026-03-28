Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:29])
	by sourceware.org (Postfix) with ESMTPS id 5A4154BA23D1
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:41:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5A4154BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5A4154BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774694467; cv=none;
	b=eHhPgIvz67JJ3vb7gOZygE6noWZA/gV1wORbo3b5kU1zSGmHQjP5Grh1p2vTj1fen6uK6mmwWj9ryp3FMYBJKY7gVIsK5Tnj7NsxOzohgZH4rBM2CaHixZxkzSNnQ17iPxeTh+sVUJFLbAaumUKlh4CPNQo+VonxlwWhwlq05iM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774694467; c=relaxed/simple;
	bh=HweiNICkzo+BnawVLub0YQoofsXc81RXNUYrxC382x4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=RRSQ/vo0qvu61pn8CZs3r4VfZ02QRIpyYLtD1+Jx613hju9Sx3hlaTI9oj2DuxQmL7yiSSMTiCPhB0yOvwTt5n1DX8tLXFWvwfE294PbppsvU1B9r0d4bEzxQQSPZF6AmMjE6DsJgQEFKq5BeR4XsK49xIFJUQG6lhv818QmLKo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5A4154BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=s9odxdIo
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260328104104435.LRAQ.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 19:41:04 +0900
Date: Sat, 28 Mar 2026 19:41:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 0/7] Fix out-of-order keystrokes
Message-Id: <20260328194102.8bc7e98fae3b33cd81d057bf@nifty.ne.jp>
In-Reply-To: <414565bd-99c7-a044-eba8-94c11e6e3c91@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-1-takashi.yano@nifty.ne.jp>
	<85e4fc6c-0d00-906e-67b3-94bb7e03c72f@gmx.de>
	<414565bd-99c7-a044-eba8-94c11e6e3c91@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774694464;
 bh=/ckUeS7Dx4MAFknQay431Otyh1OBnsapnfYQ1//a0js=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=s9odxdIo4BxSB/Jc2WYrU5wJYu1VlTEwLvrntuRo41OXhxShT+B9MIvrLbn5ZTSNAb2PPE86
 9PJBPA4OriQTZi2ifXgK60NDuhUMej5HkEefNDOtzMkBlSUqpKvbIi2Un8DespFi3aUehEWEGA
 PUueyLdCHJTp45MemDDR+tZn5kuYt9eHWRry3qD+PQQ9zsUg1qop2frQuASMDfjl1utfStY25X
 OZFcqYE93w6A9dNiNF8UKV+Yrt/cdE0sycJAfo1V1VsRkxCYP0V7p9Qr4hG2WVYaMCegXeWoDY
 +QDfpl3HbBMybsBtvo1OzSeDaWq9fty6AsaNGiXhr993Tm9g==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing entire patch series!

On Fri, 27 Mar 2026 17:18:49 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 27 Mar 2026, Johannes Schindelin wrote:
> 
> > On Wed, 25 Mar 2026, Takashi Yano wrote:
> > 
> > > The reproducer that uses AutoHotKey provided by Johannes:
> > > https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> > > uncovered several issues regarding input transfer between nat-
> > > pipe and cyg-pipe. Most of the issues happen when non-cygwin
> > > shell start cygwin-app. This patch series addresses these issues.
> > > 
> > > [...]
> > 
> > Thank you for your hard work, and also: Thank you for figuring out a way
> > to drop the Backspace handling via WriteConsoleInputW() I objected to.
> > 
> > I tested this patch series (which required cherry-picking 699c6892f1
> > (Cygwin: pty: Fix nat pipe hand-over when pcon is disabled, 2026-03-03)
> > and applying
> > https://inbox.sourceware.org/cygwin-patches/20260310085139.113-1-takashi.yano@nifty.ne.jp/
> > ("Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist")
> > before the 7 patches would apply cleanly.
> > 
> > I can confirm that the AutoHotKey-based test now finishes.
> > 
> > However, I have some concerns about the commit messages, and also about
> > some coding patterns (such as introducing an expensive `OpenProcess()`
> > into a potentially hot code path).
> > 
> > I haven't managed to finish a full review yet, but hope to send out at
> > least my finalized feedback for v7 patch 1/7 today, still.
> 
> I unexpectedly got some time this afternoon and was able to finish the
> review of all 7 patches, with big help of Claude Opus (whenever I had a
> "dumb question", it really helped to lean on Opus' quick reading skills).
> 
> It's too bad that we cannot "fix this for real", which would be to buffer
> the input in a single queue and only deliver it to the consumer on demand,
> whether that be a Cygwin or a native process. But there's not really any
> way to be notified when a pseudo console's foreground process wants to
> consume input. So there is no actual alternative to the current approach:
> routing the input preemptively.
> 
> For the record, I integrated your v7 patches (with my proposed commit
> messages) into https://github.com/git-for-windows/msys2-runtime/pull/124
> (which also has an updated AutoHotKey test that now verifies the `cmd.exe`
> side of things). The PR build demonstrates the fixes work!
> 
> Thank you so much for all your effort to fix these bugs,

I’ve incorporated your feedback and posted the v8 patch, so please
take a look. The most commit messages are replaced by yours.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
