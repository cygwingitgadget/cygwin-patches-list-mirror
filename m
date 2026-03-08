Return-Path: <SRS0=dH/q=BI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 422DD4BA2E15
	for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2026 06:58:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 422DD4BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 422DD4BA2E15
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772953132; cv=none;
	b=Z7N1CsvYAWc2kPM7Ty1g/RTLHzivIl4rhfnq//4vTl/p1Ds1V3fAfg1hpLZxKJ27lZeyBSUVIaqsZigiee09HUU+kQeLDNhvUVqciItsRt6SaBOIUr8pZMDoBUKJJ46BpP9UQGGEqmBnzGUoFhpFGf3aBg437Nqdxr9rPDSLtEY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772953132; c=relaxed/simple;
	bh=KapInYNcXlRIiYuWF8caHuXN6KxzjBAIwMAJDZExyHg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EFA/QuQDRXpPfZgn9l9LNGIbufmxurzxsdEAF0qkVP1+mBMDv8FxLO2hq83ZaAiRR/lz2fFCaTuWqutzjaLradhIpiH0dv+Voft2oWtIz5JqB7/yLeAsGTjRaha2CXTWnMQc/vT6KYh4jvs96V1paF9e6WPjhY8P/ResVtQqDT8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 422DD4BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Le7strwi
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260308065849385.HZQX.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 8 Mar 2026 15:58:49 +0900
Date: Sun, 8 Mar 2026 15:58:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix nat pipe hand-over when pcon is
 disabled
Message-Id: <20260308155847.74abf089868d7ad3071c4f9c@nifty.ne.jp>
In-Reply-To: <5f24a7c4-ed7a-da39-2e95-8f9252576ed9@gmx.de>
References: <20260306005037.1934-1-takashi.yano@nifty.ne.jp>
	<5f24a7c4-ed7a-da39-2e95-8f9252576ed9@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772953129;
 bh=1hqlAh1toyEIpOPhsfwjXQ9/1okR5yfoUq1FiM48jng=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Le7strwiMLLoyOSaqLFkDGNewkprotxqH9fKLKHLQBr+7bp1LZoKVu57Uqt/Y2SZwCDBviqd
 IM79ojzvFwdr3Ws0h1XOfY/486gQJltOthLknZN+tJHTqK+Uy+EiBqX1K4kjGZBAi6tMUvLvrS
 mRTYHlwXd6PBXBHmxj0SW5gFjhf19aoV3hrMOBIHjW8AHXKnMnx0kv7B4So/1cEY/+3G6Qdm8Z
 lNWpCyzv8MTr72vGYd71zSssJReT9enVq5ax4LLyjg0eBXCrVgctbsogMg6/PAT8hu8RndcUUB
 PYJCcIriiLFUi5dVY3DueY5cRuXuutH2/22LfSBvzVNn+n+Q==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 7 Mar 2026 13:07:01 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Fri, 6 Mar 2026, Takashi Yano wrote:
> 
> > The nat pipe ownership hand-over mechanism relies on the console
> > process list - the set of processes attached to a console, enumerable
> > via `GetConsoleProcessList()`. For non-cygwin process in pcon_activated
> > case, this list contains all processes attached to the pseudo console.
> > Otherwise, it contains all processes attached to the invisible console.
> > 
> > 04f386e9af (Cygwin: console: Inherit pcon hand over from parent pty,
> > 2024-10-31) added a last-resort fallback in `get_winpid_to_hand_over()`
> > that hands nat pipe ownership to any process in the console process
> > list, including Cygwin processes. This fallback is needed when a
> > Cygwin process on the pseudo console (that might be exec'ed from non-
> > cygwin process) must take over management of an active pseudo console
> > after the original owner exits.
> > 
> > When the pseudo console is disabled, this fallback incorrectly finds a
> > Cygwin process (such as the shell) and assigns it nat pipe ownership,
> > because both the original nat pipe owner and the shell are assosiated
> > with the same invisible console. Since there is no console for that
> > process to manage, ownership never gets released, input stays stuck on
> > the nat pipe.
> > 
> > Only the third (last-resort) call in the cascade needs guarding: the
> > first two calls filter for native (non-Cygwin) processes via the `nat`
> > parameter, and handing ownership to another native process is fine
> > regardless of pcon state. It is only the fallback to Cygwin processes
> > that is dangerous without an active pseudo console.
> > 
> > Guard the fallback with a `pcon_activated` check, since handing nat
> > pipe ownership to a Cygwin process only makes sense when there is an
> > active pseudo console for it to manage.
> 
> I recognize that commit message (and your edits) ;-)
> 
> Thank you for indulging me, this looks ready to go to me.

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
