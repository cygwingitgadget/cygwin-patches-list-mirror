Return-Path: <SRS0=wsbR=WV=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B7262384A40A
	for <cygwin-patches@cygwin.com>; Thu,  3 Apr 2025 17:01:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7262384A40A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B7262384A40A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743699667; cv=none;
	b=e4hb+kC8IxXgkvdxiFeG0RtjhzF8VnkyTZUeiT+Xp44PgB+CJJz7Koa/4H9rTdbo1LDxZgpbJSseqALNBhw06VvecC+YJLSCZnjJr7Lc1X270K83GVMNL+Mk2SDXb4fgILIW2VykF0Mi0aTawxwOkt350aHi8nyLwu+LBjXPFIo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743699667; c=relaxed/simple;
	bh=5dx14VxnqpLMyqWnorwKK3IJfgIqVM/SS1Y2UA8rmVU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nZ7PtSJ/XEUBLUAmZlJQvPJqaJm6LY1vWCHczt+JkHrCjrBavO3IxnzheLrcY/Y31wH2r5rw5fF+JUm6R5YKYTWWxFnkZfVG4KAVmmx1m7LcX0jD09eLuZ/YAdXyGe+m8FyrZnyISooBTSo3cmrWAZ2Anni6CjxGMW2dDO46xKw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7262384A40A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Avu9YFuf
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2382545C73;
	Thu, 03 Apr 2025 13:01:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=D6oMNJBkjL82xEeosjDLj1vZQD8=; b=Avu9Y
	FufoCW7gAobmMKR1ehQ9MnkDhdVRgB//Ujzy/JTEu7oD30iMAs7DEqLZPGEHP+Lu
	k0KK1QCebOQxoGPxVTlfljsVkIf0+ea4KYEpQ0Bi2+jDB0ZdcTFubzQuZADFrXyy
	F/mjw+KeiegcRdS7v3mAhjXQuwPtjM0DhbuGaE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1F1EA45C64;
	Thu, 03 Apr 2025 13:01:07 -0400 (EDT)
Date: Thu, 3 Apr 2025 10:01:07 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com, 
    Christoph Reiter <reiter.christoph@gmail.com>
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
In-Reply-To: <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
Message-ID: <ec45497d-a248-1056-4993-da137267b7c5@jdrake.com>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp> <969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 3 Apr 2025, Johannes Schindelin wrote:

> I still have a question that I would like to be answered in the commit
> message, too:
>
> If `signal_arrived` is only initialized in `fixup_after_fork()` but user
> callbacks that use this are called by `atforkchild()`, why did this not
> trigger _all the time_ before your reordering of the calls?

Based on my recollections, Takashi probably knows better

1) there has to be a pthread_atfork child callback registered
2) this callback has to call raw_write
3) raw_write now calls cygwait (which is now reenterancy-safe due to other
fallout from this)
4) cygwait allows signals to be processed, so needs the signal-handling
stuff to be properly initialized.

I'm guessing, if raw_write doesn't need to wait (ie, there's room in the
pipe for the write) it doesn't hit the signal stuff.

But I get your request for explaining the scenario in the commit message.
