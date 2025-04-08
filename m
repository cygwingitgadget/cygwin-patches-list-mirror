Return-Path: <SRS0=gAiW=W2=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 83AF1385843B
	for <cygwin-patches@cygwin.com>; Tue,  8 Apr 2025 17:26:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 83AF1385843B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 83AF1385843B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744133199; cv=none;
	b=HB+4RdQYG3Me/EjUQxl8G5U1yZ23Htdab6SSJcgJHBTJxIHN1EnFHoCZKH6Z73wORjuFpVeiKtM+OweyrI8UUi6xURpJRjDJmAETP7XqjUUhZt9fklSIk7Im06YsI5Awahspolyl5Wj1PoK8z9cxprGdGPGl97kl8H4KJD2WDdQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744133199; c=relaxed/simple;
	bh=b+rzzGCovZBUMBD2+dICSE4YgbNq7ME93Jfxa0m3t8g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UkxI6sYF9am1UPeU8ik8Pma/z0SiO8hEcF+1N5Yvzco/Fyz6v26bv8inCcd10QZm0urHRlk20zJ1mlEqeBRPR3RMSyQx04dngCiLN9poOiQmVVqMGJTWDkR2+P1nEGo4KVd8qrHoSz8Cn89ohV53ECErZ1Lf+QUICtrEFkUooYY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 83AF1385843B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=TevwURa5
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1B0B545C78;
	Tue, 08 Apr 2025 13:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=eak/hIILqneehVw19PwMLEvW3qs=; b=TevwU
	Ra5vBf84huCn4yLmpSewdZphxRiHIatOqDih6Oo8T/8d2dVyeeXPJwr7U1GIhA/L
	96W7bIfpnpLuVnaMrea11zK1U+1Rmg9DKKXc5D5+YVGcrD8KBbpsoI549uJYk+HN
	NvKuH8ql2+QZYCYj3OE6F4q2xRVqe0qWSYnTK0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 14B0545C73;
	Tue, 08 Apr 2025 13:26:39 -0400 (EDT)
Date: Tue, 8 Apr 2025 10:26:38 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
In-Reply-To: <20250406195754.86176712205af9b956301697@nifty.ne.jp>
Message-ID: <92ac7d14-4e71-14cf-91e0-080ca7a461f8@jdrake.com>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp> <Z-E6groYVnQAh-kj@calimero.vinschen.de> <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp> <Z-F7rKIQfY2aYHSD@calimero.vinschen.de> <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
 <Z-PJ_IvVeekUwYAA@calimero.vinschen.de> <20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp> <20250406195754.86176712205af9b956301697@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 6 Apr 2025, Takashi Yano wrote:

> Revised.

Sorry to be late to the party (I didn't open the attachment before, and
only saw the commit):

> +  static class keys_list {
> +    LONG64 seq;
> +    LONG64 busy_cnt;

Should these be `volatile`?  busy_cnt is probably OK, it only seems to be
dealt with via Interlocked functions, but seq is tested directly in some
cases and via Interlocked in others.
