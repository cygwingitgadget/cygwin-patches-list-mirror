Return-Path: <SRS0=+TpR=JM=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
	by sourceware.org (Postfix) with ESMTPS id CFB1B3858289
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 18:48:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CFB1B3858289
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CFB1B3858289
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=96.47.74.235
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706986084; cv=none;
	b=g+iwmyFV1kPJrcMbl6iDprQ0RxK170Wad5nYhsMJlOaI66sr9H9DsWH254Ky6vUmxLC874RFtLxePi3offLwKBqdE2CK7H0OZJZIJczcxmofUk5Bt5vJ1q+1Yga+gmg5RlG7mMnJIdePwFWQND4rzwccGYyED7fAm6Gqx4PV93g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706986084; c=relaxed/simple;
	bh=QY9KvlgDbEuml2B8n0A5ft52GoRu2uRACkvx+p2RYhQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=g8A+f2ZPxuMaRV2XJOvCqN7iAFEh8YnG32qr6vprwVrHYrZiB/U9P5EyJGVYqo6MT3d2A6IQhXqR6syYK4w7VwYGvJ/hHd2b6nnyex0QHU4ejqRlnwgTpTbZgunEQTWj+GpwY5+w1zbAbXXI1Xehf6hoguGtnzWqlr2tVAKilss=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A480BCEAF
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 13:48:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ZOzYoI+wtCVCquflNZ498gkpq9o=; b=vTOHk
	63KJSVmaOeUIaTVacAmH2VgFbjxAsz3NfPLx2/oUby9LPZO8ZF9i6lwaa3YdvVQi
	btunjIUA4hnyF4seWGN4keBtB0syjSJNDPlMjIkyIcCWlqgaEzFYvcOSWRRHXvFY
	+t03Ws1YdR+5VmVbjqwS9s7cluZSiN7MxgylW4=
Received: from mail231 (mail231 [96.47.74.235])
	(using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 92D5ECEAD
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 13:48:02 -0500 (EST)
Date: Sat, 3 Feb 2024 10:48:02 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Avoid slipping past disable_master_thread
 check.
In-Reply-To: <c8c3a5c3-72b7-7e1b-3ddf-d399090b49a1@gmx.de>
Message-ID: <alpine.BSO.2.21.2402031042100.95909@resin.csoft.net>
References: <20240202161827.1847-1-takashi.yano@nifty.ne.jp> <c8c3a5c3-72b7-7e1b-3ddf-d399090b49a1@gmx.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Thanks for taking the time to write this up, this issue has been bugging
me for years... (see also:
https://cygwin.com/pipermail/cygwin-patches/2021q4/011638.html)

On Sat, 3 Feb 2024, Johannes Schindelin wrote:

> Concretely, the hangs occur typically when some `pacman` process (a
> package manager using the MSYS2 runtime, i.e. the Cygwin runtime with
> several dozen patches on top) calls a few non-Cygwin processes. Those
> processes seem to succeed, but there is an extra `pacman` process left
> hanging around (reported using the same command-line as its parent
> process, indicating a `fork()`ed child process or maybe that
> signal-handler that is spawned for every non-Cygwin child process) and at
> that point the program hangs indefinitely (or at least until the GitHub
> workflow run times out after 6 hours).

I don't think this requires running non-Cygwin children - I see this most
often when pacman is using GPGME to validate signatueres.  That
fork/exec's (Cygwin) gpg.

> I was not able to obtain any helpful stacktraces, they all seem to make no
> sense, I only vaguely remember that one thread was waiting for an object,
> but that could be a false flag.

My recollection when I tried to debug was that every debugger I tried got
an error trying to get the context of the main thread of the hung process.
There was another thread, which seemed to be for Cygwin signal handling,
which was blithely waiting for an object, but I kind of expect that's what
it was supposed to be doing.

> Stopping those hanging `pacman` processes via `wmic process ... delete`
> counter-intuitively fails to result in `pacman` to exit with a non-zero
> exit code. Instead, the program now runs to completion successfully!

> Do you have any idea what the bug could be? Or how I could diagnose this
> better? Attaching via `gdb` only produces unhelpful stacktraces (that may
> even be bogus, by the looks of it). Or do you think that your patch that I
> am replying to could potentially fix this problem? How could the code be
> improved to avoid those hangs altogether, or at least to make them easier
> to diagnose?

