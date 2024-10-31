Return-Path: <SRS0=MmMu=R3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 562F83857835
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 08:36:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 562F83857835
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 562F83857835
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730363815; cv=none;
	b=f3y2EpbFQneDJjOKgFyTaLRY9eI8ChFIbsH9P+TjDPSWaYhxiAyFkiJTQNRj+g4/YmcwmDRD75UXT5dHeLZFzW9sq9bG3VSehU7z9WNjisxQujqmCErQ0YYkW1cpb0bwmmHtCtgR0MxeFxYtZy7lI1oZusUcH6359idbvJGvj74=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730363815; c=relaxed/simple;
	bh=mFeWGR33fAiUKv4ZyNKaj73n/OtgZIxkr1qKKbJ16v0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YcQtuAbjamOT+CZMMCsWwYh6kGUpzKjHBBv7FJpPrQdgKmBw1BT4fb0kgNa9wUg6Z9d1VCc3kPuJOv4A5sFOXSkhYDa7b1J1MJICxHOqfRVDDpSsLBarGrV4buRzndjGLFLxWNh+MD63giRJSwP/6QlQVycvRQ4jzjGH2MV6ZE8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20241031083642680.MIBE.33191.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 17:36:42 +0900
Date: Thu, 31 Oct 2024 17:36:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-Id: <20241031173642.34cf4980cea2276e7402c4d2@nifty.ne.jp>
In-Reply-To: <Zx98ETE7E1DMGirF@calimero.vinschen.de>
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
	<Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
	<20241024175845.74efaa1eb6ca067d88d28b51@nifty.ne.jp>
	<ZxofkPUww7LOZ9ZB@calimero.vinschen.de>
	<20241027175722.827ae77c67c88a112862e07e@nifty.ne.jp>
	<Zx9fk6yQ1etCVwek@calimero.vinschen.de>
	<20241028202301.7499a9f04335f362c72310db@nifty.ne.jp>
	<20241028202516.0dd4c86cb2efa9f7db8c856d@nifty.ne.jp>
	<Zx98ETE7E1DMGirF@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730363802;
 bh=v7fk2FR7iovV0ykVqLIXuVwMArY0Uru+tdYHm5/aCfw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=pOQyEsl8F1QxpH/RL4r+imR+4poxKR4BtcVTqhcQgeIR7GluYag90QuqjzlccumwywH8R1Fg
 Oc6pi3km6akcFv1fDd4AvR09E9rr0aG36imRE0p6gA7ddialXkC2rBAnSL2n570ngGc2GVLb1B
 FkHL+gUcx/v7g31d2BhJv773VbPoVKyJSokRIvkyTezRVIVj0LKcVdviso42qJpj/+7UOzrt2+
 Io38pIFYXaiPbJcJp5kTVwxwY27q8e/BBT91BLwgFfu6KAJkBUzwzq9XY9P35AY6IfCsKcvYRa
 1f200e52PdPcQGDxXZTwZoILsAFF9aVp4gdL6ukPGSJMtqmw==
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 28 Oct 2024 12:57:05 +0100
Corinna Vinschen wrote:
> On Oct 28 20:25, Takashi Yano wrote:
> > Is the test case I used different from yours? Without the 2nd arg,
> > $ ./a.exe 40000
> > pipe capacity: 65536
> > write: writable 1, 40000 25536
> > write: writable 1, SIGALRM 24576 960
> > write: writable 0, SIGALRM -1 / Interrupted system call
> 
> This is the same testcase I pasted last week:
> 
>   $ ./x 40000
>   pipe capacity: 65536
>   write: writable 1, 40000 25536
>   write: writable 1, SIGALRM 24576 960
>   write: writable 0, SIGALRM 512 448
>   write: writable 0, SIGALRM 256 192
>   write: writable 0, SIGALRM 128 64
>   write: writable 0, SIGALRM 64 0
>   write: writable 0, SIGALRM -1 / Interrupted system call
> 
> So why does it not get into the last else case after calling
> pipe_data_available()?  Do you get a different return value
> from pipe_data_available()? If so, what and why?

I checked the behaviour in my environment.
__builtin_clzl(960) returns 54 in my environment.
So, result of
	len1 = 1 << (31 - __builtin_clzl (avail));
is undefined. If I modify this to:
	len1 = 1 << (63 - __builtin_clzl (avail));
I can get:

$ ./a.exe 40000 1
pipe capacity: 65536
write: writable 1, 40000 25536
write: writable 1, 24576 960
write: writable 0, 512 448
write: writable 0, 256 192
write: writable 0, 128 64
write: writable 0, 64 0
write: writable 0, -1 / Resource temporarily unavailable

with the commit 686e46ce7148 as well as with my v9 patch.

Could you please fix?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
