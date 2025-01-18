Return-Path: <SRS0=W5W4=UK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 151C13858D1E
	for <cygwin-patches@cygwin.com>; Sat, 18 Jan 2025 18:58:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 151C13858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 151C13858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737226715; cv=none;
	b=F/Y5Ae4s9GcRjeJtY0QggmMffszVnDnLvmP1TLoaiO+11GQ9RiEJf7S4JIhfVhmf3w5Ou+WTjPwSvFuzRDoIjwxZR9Sv8r7uiHMokJtoSzaNvjYYRJx7jLQdcmnbhTKTVqy8hstCPbWZLFOPbdtEVtTIcKyAnbln2uOS/byJ2zg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737226715; c=relaxed/simple;
	bh=eIC/g36pm7wud0B9LUNga82SPdAfhwFsUYLekZwCYjc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=LIiry5k+hFIJ8Iy2GSXZK97zONtM0rW2BaON8rmP+/IItYh5qcJhBp3NNNDF3O0HqDggSv/ZCIUIYPOojMWdpe7/G/EP3W02qwUDg5lLQhImJNDUNGoIgrAF4884+OY0jUTNPcL293SjIAP9Ww7BGufvEGt0kOytd01Cv/bt2N8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 151C13858D1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=vdf+QcWA
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 8376945C9C;
	Sat, 18 Jan 2025 13:58:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=XsSLkzLf3fsEk32nwVfC4HxxsWo=; b=vdf+Q
	cWA7BjDz7j06lVa3lw/NPuhWz11qaGVdXd8Ba1m3+inmmSZiCxO5vYB5CSGNvK/3
	aJfsfk1wZi6Z8OOPglwvgt8uwNpvIX4jj+WQv4V60j3kHxP3ZaExpx6UWGcAzHIU
	a7+pRrw6ZqTDpIU983A0wm04+Ll0IkM9q8h8lM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7D47D45C98;
	Sat, 18 Jan 2025 13:58:34 -0500 (EST)
Date: Sat, 18 Jan 2025 10:58:34 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST
 is sent
In-Reply-To: <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
Message-ID: <c76fbd4d-c3c4-b5e6-0e1f-22bb43416060@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp> <Z36eWXU8Q__9fUhr@calimero.vinschen.de> <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp> <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com> <20250117185241.34202389178435578f251727@nifty.ne.jp>
 <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Jan 2025, Takashi Yano wrote:

> Jeremy,
> could you please apply the attached patches:
> 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> against cygwin-3_5-branch and test if these fix the issue?

I opened a draft PR at https://github.com/msys2/msys2-runtime/pull/253,
but those patches didn't apply cleanly (probably because we already
applied your v2 patch) so I'd like your confirmation that they are what
you intended.

Note that I have never seen this hang issue personally.  Git for Windows
seemed to reproduce it most often, but msys2 also saw some occasional
hangs in builds even with your v2 patch applied.
