Return-Path: <SRS0=BojA=IF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w02.mail.nifty.com (mta-sp-w02.mail.nifty.com [106.153.228.34])
	by sourceware.org (Postfix) with ESMTPS id 6A0DA4BA2E09
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 05:41:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A0DA4BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A0DA4BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.228.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792042901; cv=none;
	b=KgTSwycahfUpBy/8ug07gp7O81YQFqxkRFHdpamS2jsIT8gJJqRuxmYy/c9ClYuycf3M+Si+Jmk+0fjf7aDsjAov4xmy7pA2TYv6T8WyikkoqN0KB/XBrDActark+zmFLmw1g9FUzUhMz8iNf4Z9GG4ToPFzUipRUUaucg/unG0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792042901; c=relaxed/simple;
	bh=dXMd35CDaR/NsH45aOLaLnUqpwr+XvUrxkAS0pFnbPk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=RvdrFEL81bmVInNY1tAFatl4ErokO3x9i4LaedwWAMLLVrPAh4tVeP9MVPHbPsg2ulQj3rQ+oIokf0KhlmaCkAlv/zmoEupg6Lv39VjUJCMrhA6zEXQYk/wPn8UvCWuQu2BYrfICw7PaHnQj7y28irbtIA12sJZFDZCxVQhwou4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ISO+LIBL
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A0DA4BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ISO+LIBL
Received: from mta-snd-w07.mail.nifty.com by mta-sp-w02.mail.nifty.com
          with ESMTP
          id <20261015054136664.RMLM.26854.mta-snd-w07.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 14:41:36 +0900
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20261015054136592.BHPC.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 14:41:36 +0900
Date: Thu, 15 Oct 2026 14:41:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: preserve runtime nesting across user
 handlers
Message-Id: <20261015144134.a4eb492e28ac4c72891593e9@nifty.ne.jp>
In-Reply-To: <40c7ebb4-ff69-45d1-9106-b62457477e04@dronecode.org.uk>
References: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
	<40c7ebb4-ff69-45d1-9106-b62457477e04@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792042896;
 bh=0EZpQD+bPKJMuGE+HmbabncZsAe2U0SaXm1wZyRXxEc=;
 h=Date:From:To:Subject:In-Reply-To;
 b=ISO+LIBLSEMAGH6EtqsbxbM8Si9zbzMSKiZar6tUwN8XjGh5fk3YP3QMDYOvrf9bnF3Z5Fpn
 OfRBkTeU+RrDQePcTveZoDj4JziAF+QHWcmauz+wMIGUpMWwUqU0d7d5R3BwrgPZ0vXi+zXuZd
 bFHPVY7prpCuV/HCi+xIWadXeEk1yyhASEHWLpoMqRUKzSxPOyT1pWP/41lHHG0BNGQ/3Ooo+K
 Lyk0GR+wTlnrlITbGCGG7NL8fDC3EAM1CQLGm4/L1Ot01A6CMVDC5wJB5i4phC7Yc3GIQVmDtK
 plpswWZyof4ZmvnEygKzksczMWLdI3P4E3YHsT2QQmVswqEA==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 13 Oct 2026 19:47:43 +0100
Jon Turney wrote:
> On 07/10/2026 19:46, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > CMake/libuv `posix_spawn` callers can hang waiting for `SIGCHLD` after
> > nested signal delivery. Restoring `_cygtls::incyg` to `1` loses the
> > concrete nesting level; subsequent balancing can leave it at zero,
> > disabling the controlled signal-wakeup path.
> > 
> > Preserve the incoming count, including zero, to keep runtime nesting
> > balanced. The public-API regression targets lost wakeups after nested
> > delivery, including within `pthread_once`.
> > 
> > This was suggested by Takashi Yano on May 28th, 2025 in
> > https://inbox.sourceware.org/cygwin-patches/20250528125311.2589-1-takashi.yano@nifty.ne.jp/,
> > part of which was applied as 8201c57dd1 (Cygwin: signal: Revert
> > _cygtls::inside_kernel() change, 2025-05-28). The remaining part is what
> > is applied here, together with a regression test that exercises the code
> > path that is fixed by it.
> 
> It seems like restoring the level was part of v1 of the patch, but 
> dropped in v2, so maybe he has some context for this I'm missing.

Embarrassingly, I have absolutely no recollection of why I
reverted part of the v1 changes in v2. But since that change
indeed fixes your test case, it clearly did have a purpose.
Thank you for resubmitting the patch!

> But thank you so much for including a test!
> 
> > Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
> > Assisted-by: GPT-6.1
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >      Cygwin: signal: preserve runtime nesting across user handlers
> >      
> >      This patch addresses the hangs experienced in
> >      https://github.com/msys2/msys2-runtime/pull/375#issuecomment-5967746825.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
