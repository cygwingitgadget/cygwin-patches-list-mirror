Return-Path: <SRS0=5WD9=G6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id D69864BB8F61
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 11:01:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D69864BB8F61
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D69864BB8F61
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788692472; cv=none;
	b=iRbRemsWdY8bW8fWtvJvJfMutthYnTtnUPBCLr4tRLLeqOO1duIcLPwLXd1X3DDNuGAk4i7VRt0+P+ioG5M5VO3pfwd+IEKa+XJKfng+CiHa0eWB0iW8Lyt0dFNBp81iswdyrW6mdJ0qIWO73Y1+rJtp1DzC15jR72U8ovRtXRc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788692472; c=relaxed/simple;
	bh=62TbK4aYQTxUBtlSw9Nm2dZgGdnEsGrG+O3gNTBtA9w=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=kpA6fLMduGzhhFrYRNoz8HJZaxV4w37ifqF/QhUGDVT0KyFt3NzpuS8SNwNgsELQBm7YwuM1pggSaRa4Apf3sqsBQKmGPyL++Sr6ouScA33At2idKtbKu0B3d6r2WLl/WpWz5TAsOzyzgEDS4IW9XCaH3tSYa3CSW1ndjt7aKoA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WdbK1i7s
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D69864BB8F61
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WdbK1i7s
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260906110107609.SYTB.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 6 Sep 2026 20:01:07 +0900
Date: Sun, 6 Sep 2026 20:01:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: proc: Cache system process information
Message-Id: <20260906200105.068b9478fb6a2301f6560dfa@nifty.ne.jp>
In-Reply-To: <cdc9d74e-f95b-4fb9-849c-b9f80f99bbb2@maxrnd.com>
References: <20260904035910.1376-1-takashi.yano@nifty.ne.jp>
	<cdc9d74e-f95b-4fb9-849c-b9f80f99bbb2@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788692467;
 bh=PIicvcf07tj/ZcTfMDCTagFM380NZSOxt0e2ohaiHjk=;
 h=Date:From:To:Subject:In-Reply-To;
 b=WdbK1i7s4hTKXwJcL5p1T3Z+bsZKyKPsIEr0nCyfxhOaSr/XoxctM24A4DUkZJHuwByV1Fvz
 D17M+ZSVDvE6Nrlv8NTC01Er2S1c19KCgBkfAxRCJyvwTnLknR8tsADdbwlLgqrGNu5RPtsfw6
 J8lHqw6fianNBOxCBo6UN3eoM+OxB+7vpLDiuNkuTQfgHxL5cqHq1OBvgFQ6aYYGI3S5OCFFX1
 wPgwTmUXAy97N7t/B16daE0tahqo7Vklt/bVJaK5lgKfzRyhTkPb9gkf7oqClX1xW0DuB8ZLpV
 FUzafO/JsoEPUOFYkKtk4gbJ8MQP8ZnL27gtXvH4m3XPafeA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Thanks for the review.

On Sat, 5 Sep 2026 01:00:36 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 9/3/2026 8:58 PM, Takashi Yano wrote:
> > If a process reads /proc/<pid>/stat for multiple PIDs, current code
> > every time calls NtQuerySystemInformation(SystemProcessInformation).
> > In addition, the buffer size is estimated by calling that function
> > with increasing buffer size. This takes 15 - 20 msec. This is looks
> > short time, however it is not negligible in some situation. If the
> > number of the process is 100, reading /proc/<pid>/stat takes 1.5 -
> 
>    ^^^^^^^^^^^^^^^^^^^^^ number of processes
> 
> > 2.0 sec. Due to this behaviour, process pane of the btop is very
> > heavy.
> 
> (I've noticed that 'top' seems to use somewhat excessive cpu for what 
> it's doing; maybe this area of Cygwin has something to do with it.)

I agree.

> > With this patch, system process information is cached per process
> > for a short time (20 msec) to improve efficiency. Also, the buffer
> > size needed by NtQuerySystemInformation() is stored in static area,
> > so that the number of function call is reduced (~1/7). As a result,
> > the process pane of btop becomes significantly light (takes only
> > ~15 msec for 100 processes).
> 
> I think you're on the right track with this fix.  I would suggest 
> keeping the address of the malloc'd buffer in static storage too.  That 
> way the buffer can be extended as needed (but not shrunk), over many 
> calls to the function, and doesn't have to be freed.  What do you think?

Ah, that makes sense. I'll revise the patch and submit v2.

>    Also needs a Fixed: line.

Strictly speaking, this is not a bug fix; however, an O(n²) processing
time for every access to the /proc file system is undesirable. So,
I'll add Fixes: line and would like to apply cygwin-3_6-branch as well.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
