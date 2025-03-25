Return-Path: <SRS0=MFHH=WM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id A98A93858408
	for <cygwin-patches@cygwin.com>; Tue, 25 Mar 2025 12:57:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A98A93858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A98A93858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742907439; cv=none;
	b=N68U+tNTtjryvNItsZugnhgTQZztdjKWlmg7kP4Flr7bhFzFqnjgxcswdhAujKW38cSXOJd8fcRYy81PEDXifj+lztktxEE3pe0TAFTemp825+W2fyTqm6PM0KEE8IkwkSPXTV7rX/sqH1j0GnYmKfzRAYxSF62gEFq74ruf8zc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742907439; c=relaxed/simple;
	bh=72bQcDmBYQOCRc4X1TJ4nppPzkY6U+ZhsbJlO5Xg3Nk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=V3sqZqZy7CjIeILYhz3dM9W/XXaX00elRMMZIIE3nCH45937LTlq9eur/cF3LaBssNJFws4KAmuC5o2MK6jQEZ8Ff/eMh1JsgHboQtUeHZZNe57wg6B/WZR1usfewfa3G8WCPJ2sELeRs6AtGEL3I9LL9m0syN7Pi/27hwvfsb8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A98A93858408
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hs8MZVAa
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20250325125717088.DRHP.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 25 Mar 2025 21:57:17 +0900
Date: Tue, 25 Mar 2025 21:57:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Do not copy context to stack area in
 call_signal_handler()
Message-Id: <20250325215716.03e2d229b970959d67de7dfe@nifty.ne.jp>
In-Reply-To: <2498376.n97fhnxGW3@nimes>
References: <20250325101611.1872-1-takashi.yano@nifty.ne.jp>
	<2498376.n97fhnxGW3@nimes>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742907437;
 bh=o20muUFdwNnsmmBkoQCm33CNyeoRl2R4CjY0YT+M1p8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=hs8MZVAaJGpCxyJ/smsvEwOnIMg4BRTVS9BlJqzJYg0EGOQLvLdyZ76xa/Ecco1pNyToz3gh
 UBEKu12FYzdFdPXF0XsNqxlhGuLJWWDCqeMFPhxQFXqg0Ukw4O8wlMUnHNt4cyUpK2wAMNsTkg
 S+xSjOwlCGxSap5b9f+ILoCY4tZ3Kdg4V/uQH1kRDdejvauVObJoG35gFN80al1WMZtqFSj+vD
 t8IylGjezqOAPg9neSS28ivzcUAPX6XUKy+wW6UKYJXK/J+t79yvMHfOZLVKT4znaOd8J7aRn1
 wkBen//L7f86J08CtjclHc9G7yzGjHUf1z9nnifjiBevh55Q==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 25 Mar 2025 13:02:29 +0100
Bruno Haible wrote:
> Takashi Yano wrote:
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257714.html
> > Reported-by: Bruno Haible <bruno@clisp.org>
> 
> Thanks. What output do you now get by running

I submitted v2 patch. With v2 patch,

> $ ./test-c-stack; echo $?
> 
> 10 times and

The all results are:
$ gltests/test-c-stack; echo $?
test-c-stack: stack overflow
1

and

> $ ./test-sigsegv-catch-stackoverflow1; echo $?
> 
> 10 times as well?

$ gltests/test-sigsegv-catch-stackoverflow1; echo $?
Starting recursion pass 1.
Stack overflow 1 caught.
Starting recursion pass 2.
Stack overflow 2 caught.
Test passed.
0

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
