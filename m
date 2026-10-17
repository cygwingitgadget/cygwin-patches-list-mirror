Return-Path: <SRS0=U2Tp=IH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 55CA64BA2E04
	for <cygwin-patches@cygwin.com>; Sat, 17 Oct 2026 06:25:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 55CA64BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 55CA64BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792218353; cv=none;
	b=QELZfK5w8HXUCATDdUZXrWuvOmTBLI3fDqYH5QQm4DV5fPqZWoXMH0WDxpuxRjjRNWIZD87Qj16AJWnVIoBnHYuTKZVROyCGjSUmtdpxcB7hj+7WnB2Zt04LWPAzuCtT21e0NU+Nma0+5NrIltT4fdMxQBs/ITTKTFQ5Q+tl0yM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792218353; c=relaxed/simple;
	bh=sQV1vyuTvvGhedg9CFWTbuPv0dPC9LSWZe3kysXO3N0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=n1DBFaszg8K7dqwZEE6mTWGjDbOIURJAVNLNFWC7IevRBx7vh9PUjK2g2AgyIX+Vf9xs+9+Uh9GORbvUjvRX2OlvbXDpDA75SdWU7n+Xajt/OU5hoNANj/KGLDVRJVZ3QlzimS/eKHrfNrV6lHgMFUwlcum+LjqfTczU3WWnqIA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lilIhbqW
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55CA64BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lilIhbqW
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20261017062551354.IUXD.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 17 Oct 2026 15:25:51 +0900
Date: Sat, 17 Oct 2026 15:25:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: preserve runtime nesting across user
 handlers
Message-Id: <20261017152549.d0583b317aa494345f79b18d@nifty.ne.jp>
In-Reply-To: <20261015144134.a4eb492e28ac4c72891593e9@nifty.ne.jp>
References: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
	<40c7ebb4-ff69-45d1-9106-b62457477e04@dronecode.org.uk>
	<20261015144134.a4eb492e28ac4c72891593e9@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792218351;
 bh=bmdFl+/0PqCv4js4ASqow01syAwkhVJbT0vio1EHVJA=;
 h=Date:From:To:Subject:In-Reply-To;
 b=lilIhbqWZKRdV+ksypO9xtGXFxzrCAxQ8oWbpffjZSQQB/1IOPME9QSY5YXW3qFPFs4eLGjW
 qebDopEajoKH0L53qiWEXs4ml716sCjZDfTaNuHPCviywZX6Y54nx6HqjUb01w5VLY3FvfVtej
 yLjOICAJTTS3/sGD/Grop/GRsiSNzvmpLiZ1vc/zQaRuPvTaZaZyzcjhnbxmwPkwK+tgb+S/Fr
 02MZLWw9of7h07Otie9dS+CE99YDF3SNeQMsXC4l4iVPSIU2N3MyAFlJfaFKyi4X06Ye+kBk6B
 Uo5Vw/3Z2SjQ9u6rZ4hmjxUORjt3ySWZli6/qYxMVnO0Bs3w==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On Thu, 15 Oct 2026 14:41:34 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Tue, 13 Oct 2026 19:47:43 +0100
> Jon Turney wrote:
> > On 07/10/2026 19:46, Johannes Schindelin via GitGitGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > 
> > > CMake/libuv `posix_spawn` callers can hang waiting for `SIGCHLD` after
> > > nested signal delivery. Restoring `_cygtls::incyg` to `1` loses the
> > > concrete nesting level; subsequent balancing can leave it at zero,
> > > disabling the controlled signal-wakeup path.
> > > 
> > > Preserve the incoming count, including zero, to keep runtime nesting
> > > balanced. The public-API regression targets lost wakeups after nested
> > > delivery, including within `pthread_once`.
> > > 
> > > This was suggested by Takashi Yano on May 28th, 2025 in
> > > https://inbox.sourceware.org/cygwin-patches/20250528125311.2589-1-takashi.yano@nifty.ne.jp/,
> > > part of which was applied as 8201c57dd1 (Cygwin: signal: Revert
> > > _cygtls::inside_kernel() change, 2025-05-28). The remaining part is what
> > > is applied here, together with a regression test that exercises the code
> > > path that is fixed by it.
> > 
> > It seems like restoring the level was part of v1 of the patch, but 
> > dropped in v2, so maybe he has some context for this I'm missing.
> 
> Embarrassingly, I have absolutely no recollection of why I
> reverted part of the v1 changes in v2. But since that change
> indeed fixes your test case, it clearly did have a purpose.
> Thank you for resubmitting the patch!
> 
> > But thank you so much for including a test!
> > 
> > > Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
> > > Assisted-by: GPT-6.1
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >      Cygwin: signal: preserve runtime nesting across user handlers
> > >      
> > >      This patch addresses the hangs experienced in
> > >      https://github.com/msys2/msys2-runtime/pull/375#issuecomment-5967746825.

If you have no objections, I’d like to apply the patch. What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
