Return-Path: <SRS0=kOQ+=UL=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 336DF3858D21
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 03:24:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 336DF3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 336DF3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737257092; cv=none;
	b=mfB+mf7VEXeD4HZb4q+GETfhD4kpf7UqYc7rKe4zLjAKce7b/XKcG7sKzaAJE/VFllJpsPGf6gtqe5noNIBXyY/BYsJ15q6jH/8FPKQSVngcO3TA1UxNOwOjWNwXzlkV4RRKb0Ie0PGCVjG4fIGu9zxGKiJmha3FN1nBPen6dm8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737257092; c=relaxed/simple;
	bh=Wh+pWTafIHWhnn5qI12msP5WQ8kShljybBvK4cLcAkI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HxdlphVnnABnZmsNLlwz8ODAW9UBhWHUxucVk9YLNW6o5a0g3cPwBkg5Qf5wfn9CkQ6hodPT6olSDbvF90KmunsWKNM+WCHgYqFuIEqORVpW9dqV64Q9RT9OXjvkpTKsA9ZWAkpU7lvY3MMJfjOoQRlZ1Z+FQAocMy/Fd9jFWpo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 336DF3858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ArTYeBLU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CBBD545C8D;
	Sat, 18 Jan 2025 22:24:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=jdWCwOIjG0cOioeM/PMeT8olFIM=; b=ArTYe
	BLUZtOu3b1yq5PGnmqwcVEwfGnr1KQ1mE99sGdwIiE2oF17QBd1OefTNektthGXr
	8kOH/Zgbwwgpo775K6WeWFwyGTThI3PNInEgSBZd8geDQ4OEIOHlyf1iJCulbtxT
	dm9qAYHd7ULjlEVLPvqRrj+rrG+7p8LhvNCLNE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9D74D45C8B;
	Sat, 18 Jan 2025 22:24:51 -0500 (EST)
Date: Sat, 18 Jan 2025 19:24:51 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST
 is sent
In-Reply-To: <20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
Message-ID: <1dc76092-3328-a611-81f2-6d4138e320b0@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp> <Z36eWXU8Q__9fUhr@calimero.vinschen.de> <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp> <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com> <20250117185241.34202389178435578f251727@nifty.ne.jp>
 <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp> <8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com> <20250119114958.82129e29fae9093f38dac53c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 19 Jan 2025, Takashi Yano wrote:

> Thanks for pointing out this. You are right if othre threads may
> set current_sig to non-zero value. Current cygwin sets current_sig
> to non-zero only in
> _cygtls::interrupt_setup()
> and
> _cygtls::handle_SIGCONT()
> both are called from sigpacket::process() as follows.
>
> wait_sig()->
>  sigpacket::process() +-> sigpacket::setup_handler() -> _cygtls::interrupt_setup()
>                       \-> _cygtls::handle_SIGCONT()
>
> wait_sig() is a thread which handle received signals, so other
> threads than wait_sig() thread do not set the current_sig to non-zero.
> That is, other threads set current_sig only to zero. Therefore,
> I think we don't have to guard checking current_sig value by lock.
> The only thing we shoud guard is the following case.
>
> [wait_sig()]               [another thread]
> current_sig = SIGCONT;
>                            current_sig = 0;
> set_signal_arrived();
>
> So, we should place current_sig = SIGCONT and set_signal_arrived()
> inside the lock.
>

OK, that makes sense.

> As for volatile, personally, I have never had any problems by
> not marking variables that are accessed by multiple threads as
> volatile. Do you have any example that causes problem due to
> lack of volatile other than, say, hardware registers?

After I sent that, I realized that it should be fine - yield calls Sleep
which is an external function, and I think the compiler cannot know that
it doesn't modify the variable.

The thing I think volatile protects against is if you didn't do
something that could "clobber memory" in __asm__ speak:

while (sig == SIGCONT)
  __asm__ ("pause":::);

then the compiler could load the value into a register and just check the
register rather than re-loading from memory each time through the loop.
And at that point, just optimize it into an infinite loop.  Either calling
an external function or making sig volatile would fix that.  I was playing
with https://gcc.godbolt.org/z/f49vsecYe you can see the effects of making
mem volatile are the same as having Sleep be a function the compiler
cannot inline.
