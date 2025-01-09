Return-Path: <SRS0=UmZJ=UB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 558DF3858C56
	for <cygwin-patches@cygwin.com>; Thu,  9 Jan 2025 19:35:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 558DF3858C56
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 558DF3858C56
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736451303; cv=none;
	b=DeLCBjejsQ7OED5TVKSZmYemr0Tuv0oGIyEZIOX5orB6ftI3GozfBbVdbjWE7gDgoDJlLi2GXwkNj2QmX28A7eSBdkXHp4QWA9tmIZzQeRqQwq9edpo+Sx1rrMWpyrnC5YqDYSayxCq8zH07LGgQEi6v/fSIsb/dB9S4hx+3XNg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736451303; c=relaxed/simple;
	bh=NotsWuv4DEm9Y2YHn77EzRNunU1HzBAxF07x04kyvGI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=s0JYs+tz+fnuOfUUQ+n/isHYajiorL86fr6grhuRL7XaM2+b0/MTN3WNZgpf+eX1haw/iuakNPl7vn/B4R56RJDIprO+K4y76LjBfdRU5/PKxjlpNFtpq8eKMc/e1mrr1uiBAy13lJjvf8vKWY0RnFU0/C6N6vT/6p16lihmPBI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 558DF3858C56
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=S2K34SKu
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E529C45AFB;
	Thu,  9 Jan 2025 14:35:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=F7wQGqC+0gKiXBSmTk436RY9Gug=; b=S2K34
	SKuMAibz9QlZKqVbz6Pv7Aj+wWL9tLLtKMj4pYU+mNqbcCo32emeWLRhw5ZRz9Hm
	BdJbCPQEhBBqm3+XgPFW/qqk4LG1eglwyvjRMKwFEXcDtKdZhCvJfIU5ok/SNK0d
	zrfeU723CyMUZF/Bcqo2QnhBeEWGd8Oz3kHic4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B3AB645A49;
	Thu,  9 Jan 2025 14:35:02 -0500 (EST)
Date: Thu, 9 Jan 2025 11:35:01 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST
 is sent
In-Reply-To: <Z4AhWrXpbQYVZ4Gl@calimero.vinschen.de>
Message-ID: <429ae2aa-c2b6-302a-0417-c267475c096e@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp> <Z36eWXU8Q__9fUhr@calimero.vinschen.de> <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp> <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com> <Z4AhWrXpbQYVZ4Gl@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 9 Jan 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> Can you perhaps bisect 3.5.5 to tell us which signal-related patch
> exactly has introduced this specific hang?  It may give us a clue.

I believe Johannes was planning to do this, after holidays/vacation.  It
seems that Git for Windows' test suite is the most reliable way to
reproduce this.  There are occasional hangs in MSYS2 builds, but they
go away on a re-run of the build.  FWIW, I don't think we've even proven
that this is signal-related.  The latest backtraces seem to suggest pipes,
but I wouldn't bet on anything at this point.  The only reason signals
came into it is that the last (more common) hang was signal-related.
