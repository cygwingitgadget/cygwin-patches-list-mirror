Return-Path: <SRS0=QOKQ=WP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 9711D3857BA5
	for <cygwin-patches@cygwin.com>; Fri, 28 Mar 2025 19:51:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9711D3857BA5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9711D3857BA5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743191500; cv=none;
	b=oUAeZYRKwEPk484+NGabXMWDn+vVU7+edRfBKOCVGVfKOztVN/zaKF2jsEbtOxR35Te5cKwO82bCmc3DfqDNM21FqymKfBHcfsAhxZDq1p8toGYJUXvwsbk0tiacYV4Lvv+TBIy57pcQ6oCHBl9Zy8oDqTMe7WTllLkkTYYoM4s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743191500; c=relaxed/simple;
	bh=GdlewJAPcqbv4bthv1Ri4TD9+Up+OiLVruyI8igNAAE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UAO9fdULESsX38KoWr2WU5FOyChxdLpI0FPQUKbyIjtuCvUTnOPKynp7hhne1XO0lVISQQEMwJwFrVCqfA5v72yScQSZwrhTdzBs09rlUSjTKLL7v3cAtSubSPZ/FkL0hYOWnLLP40N+3YAIqFyykg76pIQOPgu83wJfBCSZMnM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9711D3857BA5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=L4T0H7Ks
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0027E45CD1
	for <cygwin-patches@cygwin.com>; Fri, 28 Mar 2025 15:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=7R7KaES0N2B09W8pq47W6cWG0KM=; b=L4T0H
	7KsOyZ1MqgeKQBWiQEnLnxvzjA0EMVBmNVcq4+JoKE9xwdMbKxx2RhYNIUSOuXYc
	UBGti8cEi69IPPjvtRIG5NVMOM4LPEEYPPt+2DlIqER1fR71qORVLNCPDlWtVYUr
	/BuQdUf4+OAObf/ypU4io1S9KIjiVNXbMwW1c8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D782145CC4
	for <cygwin-patches@cygwin.com>; Fri, 28 Mar 2025 15:51:39 -0400 (EDT)
Date: Fri, 28 Mar 2025 12:51:39 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on
 x64
In-Reply-To: <Z-Z1HJZKiHi6YUcd@calimero.vinschen.de>
Message-ID: <67305d04-d1b3-da31-672d-53fc8df2d0e0@jdrake.com>
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com> <Z-U5WFBxoUfeVwn7@calimero.vinschen.de> <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com> <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de> <580c99c4-d0bb-ee54-3a39-43b55f5abc1f@jdrake.com>
 <Z-Z1HJZKiHi6YUcd@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 28 Mar 2025, Corinna Vinschen wrote:

> This sounds great, but don't put too many effort into past preview
> releases.  We try hard that Cygwin runs on released versions of
> Windows.  But preview versions of the past are a thing of the past.  Not
> only that, but you're putting a lot of effort into versions sometimes
> used by a single machine.
> It might further simplify the code if you don't handle these old
> temporary versions anymore and concentrate on the past releases.

I'm not.  I'm only looking at *released* versions of Windows, but at least
considering what comments had to say about old preview releases as ways in
which this code might potentially be mangled by a compiler.

> Btw., wouldn't you have fun to join our Libera IRC channel
> #cygwin-developers?  https://cygwin.com/irc.html

I was on MSYS2's discord for a while, but I found that between the time
zone differences and my own feeling that I needed to keep up with all the
messages I had to give up on that.  I try to prune my Github notifications
down to a level where I can keep up with pieces I'm interested in without
getting overwhelmed.

I seem to remember that IRC doesn't deliver a backlog of messages from
when you're offline, so perhaps it would be worth a try.
