Return-Path: <SRS0=ihPJ=FI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id A893C4BA2E08
	for <cygwin-patches@cygwin.com>; Tue, 14 Jul 2026 00:54:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A893C4BA2E08
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A893C4BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783990447; cv=none;
	b=URAMZTFdqDdkBrNZ8vMpnONNZQc6gz+Zo1fjPLW3j8PzIF923JFyj6RQkEMBnbfghsqPdCpy5W9cIGzPkmTQMFcey+LDNiu7n2kPKCXNCBbnsN3pvdAgRuUaWhjFkguF8eoLful1lXBQcYklh0R1sQyJZM/zGMJ1f75iDTJKZHM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783990447; c=relaxed/simple;
	bh=R/NzBtQK5Yb7bqyCCs2+4nW/Z087Jw2uHRjJhWOXZe4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=n/bHNKP79yz16VlMekyRaZETFlsDg/StxJ2Y/CB76Qi2T05Dn1YxDWYxA9jiXHdtVcAVWRaJI95SwCWWmZkuo+sE51toSJNI+hxJfaBsdXmPqUpiurBNPQRY0hmESLdnKu1n+ZdEyPjvtpTGFnEUucgEYkPpY5n/89ZF5lyiMko=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ULIpT+2l
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A893C4BA2E08
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ULIpT+2l
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260714005403823.CKCH.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 14 Jul 2026 09:54:03 +0900
Date: Tue, 14 Jul 2026 09:54:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
Message-Id: <20260714095402.922a9ab49cae344b558be892@nifty.ne.jp>
In-Reply-To: <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
	<9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
	<20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
	<259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
	<20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
	<5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
	<20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp>
	<2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783990443;
 bh=ZmVFGGG+HDqLXOy8yRvkEVjjsqhWQvzR6nN5lzUIHF0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ULIpT+2lzJZW4NZlEuCr2vojhsbhjUEKjTEgJo1kmVjDDCpwvazMZFcYCnfhjh723QLFbJ7r
 tE9HyG8P8c5JsVMd0udKIov9pPtVspt0KitsGbgviMNLJAKLGk8owh+2NfZHo8Lqx+IetIg/NM
 IbbdferYfQlm4NHDj0EgcXm7A0mYHwofuUeoGFThlN2/qz0vxjTUoszcgmcIDEpGzH53fXieLz
 PdBBJkY0t5motnS3hOddcQWhrSr70F9VlZIRSKvNN0MbAA60HamhJb2KQDdZue3O/R+9l4ghDi
 GK0AIiKMDJKp3IO4NIAdI0P8hdxwQ5Fe/QDpLwNGxEEMHkaQ==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Thu, 18 Dec 2025 08:45:12 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 15 Jul 2025, Takashi Yano wrote:
> 
> > On Mon, 7 Jul 2025 12:50:24 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > 
> > > On Thu, 3 Jul 2025, Takashi Yano wrote:
> > > 
> > > > On Thu, 3 Jul 2025 11:15:44 +0200 (CEST)
> > > > Johannes Schindelin wrote:
> > > > > 
> > > > > On Thu, 3 Jul 2025, Takashi Yano wrote:
> > > > > 
> > > > > > I noticed this patch needs additional fix. Please apply also
> > > > > > https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html
> > > > > 
> > > > > Thank you for the update!
> > > > > 
> > > > > I am curious, though: Under what circumstances does this patch make a
> > > > > difference? I tried to deduce this from the diff and the commit
> > > > > message but was unable to figure it out.
> > > > 
> > > > In my environment, the command cat | /cygdrive/c/windows/system32/ping
> > > > -t localhost in Command Prompt cannt stop with single Ctrl-C. ping is
> > > > stopped, but cat remains without the sencond patch, IIRC.
> > > 
> > > I have added this as an (AutoHotKey-based) integration test to
> > > https://github.com/git-for-windows/msys2-runtime/pull/105 and was able to
> > > verify that your fix is necessary to let that test pass.
> > > 
> > > Speaking of tests: Have you had any time to consider how to accompany your
> > > fix by a regression test in `winsup/testsuite/`?
> > > 
> > > For several days, I tried to find a way to reproduce a way to reproduce
> > > the SSH hang using combinations of Cygwin programs and MINGW
> > > programs/Node.JS scripts and did not find any. FWIW I don't think that
> > > MINGW programs or Node.JS scripts would be allowed in the test suite,
> > > anyway, but I wanted to see whether I could replicate the conditions
> > > necessary for the hang without resorting to SSH and `git.exe` _at all_.
> > > 
> > > I deem it crucial to start including tests with your fixes that can be run
> > > automatically, and that catch regressions in the CI builds.
> > 
> > To be honest, I already have local test suites that check the behavior
> > of special keys for both pty and console. However, I currently have no
> > clear idea how to integrate them into winsup/testsuite...
> 
> If Cygwin were merely a personal project of yours, I would understand and
> probably agree.
> 
> However, Cygwin is used (via the MSYS2 runtime) in Git for Windows, and by
> extension millions of users rely on it.
> 
> Therefore, it would be good to at least publish those local tests.
> Ideally, a good deal of thought should be spent on figuring out a way to
> integrate the tests into the CI builds.
> 
> You mentioned winsup/testsuite, and I do agree that it sounds more than
> just tricky to integrate the tests there. Essentially, you would probably
> end up reimplementing AutoHotKey's fundamental functionality: sending
> keystrokes and inspecting the results.
> 
> Now, to be sure, running AutoHotKey-based tests is a lot more finicky than
> running winsup/testsuite. In the absence of any better idea, though, I
> would take the confidence from having tests over not having tests, any
> day. After all, you and I are both fully aware of the unfortunate pattern
> in the code under discussion where on multiple occasions, bug fixes
> introduced new bugs whose fixes introduced yet other bugs, etc ad nauseam.
> If AutoHotKey-based tests can help break that pattern, let's integrate
> them.

I’ve organized the tools, so I’m publishing them as a trial.
https://github.com/tyan0/chk_tty

sample/keystrokes.scr is the script which is a re-implementation of
your AutoHotKey test for this tool (chk_pty).

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
