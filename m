Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id C67D64BA2E06
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 13:20:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C67D64BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C67D64BA2E06
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766150450; cv=none;
	b=gWZFCwnvD8piLaEyh3rx7Oyl+s8W1+NjEi5RHqnmqqncYcPPN5dlI8IW7/RKYEofbN0Q1lqncrRScJfqx0KtOlV73K9pYzvriNDB/NEIioou7BIsGSoapk/5MFC6LVPzRsEkavmSjmne0a0p3+aEjodmQaHGTq6l2UoBEMYHpNs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766150450; c=relaxed/simple;
	bh=F3RcC5EW8ksWKgBskkib8Nn5SmkIZHg+Nvv0CXgel60=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=F3bOa3n3cM/zmK326Bn9/2gfKnVz1AR1p3O4gQ4ZxaRUuvc2qQyGoUjpq0eXlzjrmbsFH2QBvctHFVJzv5HMsspMdtk/q4+afI0+FHWcLaMbq8gA8IWLOMP1nv/JOYJV9ay/Fg50bJKahcEmv44BIrCZMFOgfHAIKc/0JGcvQzY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C67D64BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bKaETjv+
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20251219132048038.LGEW.4197.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 22:20:48 +0900
Date: Fri, 19 Dec 2025 22:20:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Refactor workaround code for pseudo
 console output
Message-Id: <20251219222045.582805bba5e0c781ba8e50e0@nifty.ne.jp>
In-Reply-To: <aUUeFSTkhMvPAM6Z@calimero.vinschen.de>
References: <20251219074831.953-1-takashi.yano@nifty.ne.jp>
	<aUUeFSTkhMvPAM6Z@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766150448;
 bh=cgUx0D7+MzB/sAjxCc3UzTjqPn8TgcG54E5ReeYt9jk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bKaETjv+BVwWGSEqIpu5Q/1vjildaPOwtXAKaRkRLMH+Cm7ZHuBG7QSFFdwzpDA+xkolACRv
 ajhTMlzDAYOYu35NXqLmWS3MADtKB10lJpNAWflzehzwRe5pQp78xyVzm5UlaYrPxsmgD19Aj8
 1aIzLHQ3a4Z2cdax+jmyzwnUEyfc7KZDJeh1YBFuBf0x9py1Je0SKev1bLXDAamRnlwPXK0c2X
 xx5kkEB2UhXhhbH9adEdm1cohDT+NnIiQFgTSCvlLhaofUmgkFzDguBxTR8+kgAw4l75b2CZ/m
 MhC+ADvPDnwU5ohH+D/yUVlryH7gdwiuKEwSLLSQ8Vrr3E+g==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,
Hi Johannes,

Thanks for reviewing. I have just submitted v2 patch.

Changes from v1:
 - Make sure to reset state variables
 - Introduce saw_question_mark flag

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
