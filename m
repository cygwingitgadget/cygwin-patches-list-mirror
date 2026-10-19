Return-Path: <SRS0=3tSx=IJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 742CE4BA23CF
	for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 11:52:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 742CE4BA23CF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 742CE4BA23CF
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792410740; cv=none;
	b=KMxj96ryK20YgJAbRvNzfFBAPKUQc8WL9hEdm/R63lnklYA9kJRyp76xZYJJWFmGYhgUM/YLzdtjCKsGtnASlndJhHbrX5hz7eu0Gqi/MHCsq3FTI1RDwROq9EhHTeb+BSdwuuGfr4O4Zc8FCzd0sWkKgPyOx5EvcS9WBaVUc50=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792410740; c=relaxed/simple;
	bh=0YSNWEkB/CvwFAjzOtwfNs3QvFtBUmPIYa4dOKgjfu0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=K9TU1vfM14+8Nih+G9mKkWmLxn50oDAphrW6xkWsZoHDOkUrweKnkoeD0rMYJOaPNljCjUA9ql7Bx1IElbIKtFt2lK3UUI5lzJwVBSfg5gV9wfTF/5FZrad1wpFTG24bRygYXPddn52M/YiCUl3CMdtLbyMpVffuC9kUOLw4iOk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G1p0fZbE
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 742CE4BA23CF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G1p0fZbE
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20261019115216645.PFCC.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 19 Oct 2026 20:52:16 +0900
Date: Mon, 19 Oct 2026 20:52:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: preserve runtime nesting across user
 handlers
Message-Id: <20261019205214.699aca625bcc5647255244a2@nifty.ne.jp>
In-Reply-To: <10c80d37-7b83-465b-a041-8f64153a20d6@dronecode.org.uk>
References: <pull.12.cygwin.1791398786755.gitgitgadget@gmail.com>
	<40c7ebb4-ff69-45d1-9106-b62457477e04@dronecode.org.uk>
	<20261015144134.a4eb492e28ac4c72891593e9@nifty.ne.jp>
	<20261017152549.d0583b317aa494345f79b18d@nifty.ne.jp>
	<10c80d37-7b83-465b-a041-8f64153a20d6@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1792410736;
 bh=481N4oVa6I+cwAunGNNSsWN6PfuJV8xae0ZcrrJ5z98=;
 h=Date:From:To:Subject:In-Reply-To;
 b=G1p0fZbEYtaZ9+lNIEdRFeK5gFsOZeq/I2s3Y3RekmyVO/FPdMiLt6QJDI3utserI7rMgEwr
 pGWmsF7Gp+5UeeCsUBhkjtLopGObD66xCgyJt1IsCPo+80QfdHE5VLzWKkSmcud5Os4R5b83e1
 kAf7KmM6SoqqztQgLi5eyNkiRVbye+u1bNFz4ev/f3vngmFPs8Ng8up3HnwISYah7gN8nkrFKq
 vw9Hx1AlVW/gTTjbEBbUeqLtipQ24EHzqHhWOw//hVBgzjQnVzyLyKgP3zuEEtHWbH7QTXVWaF
 8671HfHS6AUcrL71CSGJjXA1C3mRpF6rzwnK11ze/kZdwsZg==
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 19 Oct 2026 12:38:49 +0100
Jon Turney wrote:
> On 17/10/2026 07:25, Takashi Yano wrote:
> > Hi Jon,
> > 
> > On Thu, 15 Oct 2026 14:41:34 +0900
> > Takashi Yano wrote:
> >> Hi Johannes,
> >>
> >> On Tue, 13 Oct 2026 19:47:43 +0100
> >> Jon Turney wrote:
> >>> On 07/10/2026 19:46, Johannes Schindelin via GitGitGadget wrote:
> >>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>>>
> >>>> CMake/libuv `posix_spawn` callers can hang waiting for `SIGCHLD` after
> >>>> nested signal delivery. Restoring `_cygtls::incyg` to `1` loses the
> >>>> concrete nesting level; subsequent balancing can leave it at zero,
> >>>> disabling the controlled signal-wakeup path.
> >>>>
> >>>> Preserve the incoming count, including zero, to keep runtime nesting
> >>>> balanced. The public-API regression targets lost wakeups after nested
> >>>> delivery, including within `pthread_once`.
> >>>>
> >>>> This was suggested by Takashi Yano on May 28th, 2025 in
> >>>> https://inbox.sourceware.org/cygwin-patches/20250528125311.2589-1-takashi.yano@nifty.ne.jp/,
> >>>> part of which was applied as 8201c57dd1 (Cygwin: signal: Revert
> >>>> _cygtls::inside_kernel() change, 2025-05-28). The remaining part is what
> >>>> is applied here, together with a regression test that exercises the code
> >>>> path that is fixed by it.
> >>>
> >>> It seems like restoring the level was part of v1 of the patch, but
> >>> dropped in v2, so maybe he has some context for this I'm missing.
> >>
> >> Embarrassingly, I have absolutely no recollection of why I
> >> reverted part of the v1 changes in v2. But since that change
> >> indeed fixes your test case, it clearly did have a purpose.
> >> Thank you for resubmitting the patch!
> >>
> >>> But thank you so much for including a test!
> >>>
> >>>> Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> >>>> Fixes: b7097ab39ed0 ("Cygwin: signal: Revive toggling incyg flag in call_signal_handler()")
> >>>> Assisted-by: GPT-6.1
> >>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>>> ---
> >>>>       Cygwin: signal: preserve runtime nesting across user handlers
> >>>>       
> >>>>       This patch addresses the hangs experienced in
> >>>>       https://github.com/msys2/msys2-runtime/pull/375#issuecomment-5967746825.
> > 
> > If you have no objections, I’d like to apply the patch. What do you think?
> 
> Uh, I can't claim to have any deep understanding of this part of the 
> code, but restoring the original nesting level seems obviously more 
> correct, so go ahead.

Thanks! Pushed.

> (Some more commentary, or updating in DevDocs to say "incyg must be zero 
> and sigstack unlocked while we call the signal handler because (i) it 
> might longjmp rather than returning, and (ii) it can be interrupted by 
> signals" or whatever the situation actually is might be nice.)

Noted. Thanks.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
