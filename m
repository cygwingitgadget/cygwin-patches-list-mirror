Return-Path: <SRS0=8NMK=ZQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 040E63852FD4
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 06:47:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 040E63852FD4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 040E63852FD4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751525235; cv=none;
	b=pQIsqne5P++FPqCKxr4XucGAZRAho2RyIr8nzWF6mqZF/jVjAK02hqWJzTEt9ofd9sCyMO8WL9yn2fudf8uQSS5f5mDQGeOcq9giskHj4kSGMcofYfxhBfh7zSv5KPfL7ECOFD3Umm0mOUwGcfunVWqps9MJT3GNX7+fDjKoENI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751525235; c=relaxed/simple;
	bh=i9GO3ANL5cmBkj9yyQeoHzJ/j2S1Qqu2ThBy4kveUWk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=egorckOidpPovoHUNU6yvwo9yGA/cuFjOAJ9nLhw970Y6IFtpULQni8lLT9wZTVhQ4I557s4XD4xgQXRmxAa/4vZOUd8rn8bSD05JY/CsUt4u/tcKipLMJi8Z6q0XkONgGrOg5+uww/CR2R413o4oToytbMPyD3Of3GtlmCrf80=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 040E63852FD4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mbUl1JXj
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20250703064712924.VIOB.78984.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 3 Jul 2025 15:47:12 +0900
Date: Thu, 3 Jul 2025 15:47:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
Message-Id: <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
In-Reply-To: <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
	<9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751525232;
 bh=50uXjKgiJdZILigraGM+Pzy4UtP1cEgcaQ3AeMzplQ4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mbUl1JXj3BlBvk8DrnOIvbh06EYDgrCj8pp5cAa9NnQtJPgVypGgU05qSxAJp2tD/dskr+Bx
 AYkMxN7/CXEVv2qou9sT1d0kdZriwUNWMoKmRCp2r9h2zLw0P5hkF9d/Hw24+TchCX3w6KZo3m
 UznkZMmu7ze3EGs0+00VaAVKrS1hOh5Jj9TlSjrtAL3uqcG7Lc0aCJEoE0n6ir0Ac2ahTFqZwq
 9O+PoD++YgHYVt02tGkC9N1d4zHYeM/sW/+NfysqnU/ydtQCG+5cAySlY6kRk4D2IYtBS9UUKP
 WjeS8QViSvZ4Fm4tA6VhbMVWQEv1B5UfC5HBcaI9X3CgCYXQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 1 Jul 2025 14:01:45 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> thank you so much for this patch! I released a new Git for Windows version
> including it:
> https://github.com/git-for-windows/git/releases/tag/v2.50.0.windows.2

I noticed this patch needs additional fix.
Please apply also
https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html

Sorry for missing that.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
