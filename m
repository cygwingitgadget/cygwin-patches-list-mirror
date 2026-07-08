Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 7EA2E4BA2E09
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 04:04:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7EA2E4BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7EA2E4BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783483495; cv=none;
	b=QmwUGHEXj7/FaL67r871rKHpwbTh+eB8ef3KHbR8mMl5V6ipUjG24/xL3pI/se6uyvXKlpTkLnA4bJxqjDIZVHmqe1QDylSkopDYYS0HCLUyAb02Y/0+41n2+eJaba3l70hc9hblgpMgC9/uFot3SypTL0Sink1phekkKVKBxeQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783483495; c=relaxed/simple;
	bh=5JaiQxrKub/1/044BTSL/qYx5/7zSMz4YVOLo1Mz4rU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=poY3FQao9BMeFVDslThsqWVeQJMU6r7KrvJ5BLlIep9kodS/8LM//APX/ytYHuYoQNZxBgjcO4vcnrmjuc00U+VishsUMD2nQTbjSxnZkqUhZv7FmuCpSf5uRc/2VJpas6bsjG2FuE8ztTc1ThTZfKIRFEozewjfNuUJOIRe6fg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RHGEiQ60
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7EA2E4BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RHGEiQ60
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260708040452618.ODIJ.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 8 Jul 2026 13:04:52 +0900
Date: Wed, 8 Jul 2026 13:04:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
Message-Id: <20260708130451.ba5f9d34d66ab7224e7285c2@nifty.ne.jp>
In-Reply-To: <20260708035757.885-1-takashi.yano@nifty.ne.jp>
References: <20260708035757.885-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783483492;
 bh=oLPuLOb0CxxaqAspPUjqJtxATkFR0+LadVWyIdtNkOw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=RHGEiQ60JhMh87v+2sbK2Ix7XUsAujN6xSjyb/0q3b2zyNjhcJgx58VeOrQfRMfAn5QhRYAv
 XdLVoPfmmbUTKelCFvvC5uWH+goR1Ae4GAFOiiKF/yu2PNXEmzj6ApwtrI/SYbO+dUEWvzpk7S
 B/duzJFE60+sXLJH8IfxY/zRF29US/CAkTPhcshhmVQwrhJ0Eb7abRsZaz4gp5g98JuewVaiyC
 wT0lTttzbkJM7XAV9QGvBKrPMc1Gs/fq0XMeFft9m3eEuSZaLhR0mVwB8wUO5KabNViiY8gBLf
 CaYd5WPULBbRnzp09W5azumluWe3l7pxUFuwLPbwtkkjyrwQ==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This was accidentally sent again. Sorry.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
