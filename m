Return-Path: <SRS0=kOQ+=UL=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 0EB0D3858D21
	for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 01:06:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EB0D3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EB0D3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737248812; cv=none;
	b=HUeqpgBYp4dKN1jANFCBdpisjvpwGD7b6BvMh7A1VarYx4I2sgU/aLRMMRaWD/szzMW+PPDxUd7arfjnZnt9zTh2crkNuAV259kUvt9wRLEGVIV7v6XjDYwM0ZtEP4/kE6cJNV59Qr3m8z9G01O1c06VQHYJOoNif/XSEEMmzk8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737248812; c=relaxed/simple;
	bh=K0eVj4bS4OpHvYD41+POmD6SQsSY32OlugfRP9zYCW0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ndGZKJW4nkXP2QCBruYp9EEWhmeE9kXcGH8sgvtRxLdkNYymAYH1bhqXo1cZTlYg3wY4wRHCzPrYDooWap3zV1SffzJy0rUleDH1O8Qs9NHdUVvLZaCQ0SWB7f9Gaqc/PhWCoHKxswrrgEp1IcuCaP5OC1cH/B1+U9X1ZNdVn6I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0EB0D3858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=rxhLfXPs
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9C57645C94;
	Sat, 18 Jan 2025 20:06:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=w4UZ41NWenvAgxzbVtqUpHbA1WE=; b=rxhLf
	XPsY5pJzPAQU3T+WXFlEoPnaMCCOMfjvVqdTstshR8HSqd1KrvAN95c+bNFGLI25
	cmL1zJKaqPCR8jStnMMa2sML4lKr7RhbXJvOAK8IsohgAOn9F0Nh9F147pELx+r0
	ocOj0F1wtpEpC7L5Rf0+q2nhRmMR7bVhbAvS8w=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9839245C92;
	Sat, 18 Jan 2025 20:06:51 -0500 (EST)
Date: Sat, 18 Jan 2025 17:06:50 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST
 is sent
In-Reply-To: <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
Message-ID: <8bdee3d3-1200-b70d-5829-d0a081323562@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp> <Z36eWXU8Q__9fUhr@calimero.vinschen.de> <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp> <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com> <20250117185241.34202389178435578f251727@nifty.ne.jp>
 <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 18 Jan 2025, Takashi Yano wrote:

> While debugging this problem, I encountered another hang issue,
> which is fixed by:
> 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch

I'm concerned about this patch.  There's a window where current_sig could
be changed after exiting the while, before the lock is acquired by
cygheap->find_tls (_main_tls);  Should current_sig be rechecked after the
lock is acquired to make sure that hasn't happened?  Also, does
current_sig need to be volatile, or is yield a sufficient fence for the
compiler to know other threads may have changed the value?
