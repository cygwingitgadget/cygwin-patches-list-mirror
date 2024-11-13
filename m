Return-Path: <SRS0=o/PE=SI=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 018233858D26
	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2024 18:20:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 018233858D26
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 018233858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731522052; cv=none;
	b=A/h7JbN8Iao35TdtonMjdvp4dx1Gr/pABBNbFxES/Hnz+q8/IKSc7yxH5sNoJAwVYK/9wTmaCUf+bWgY1D4NKEvHq5MdZf01/E5rFeHJBVlechMjtZbWVkpsD/tQREhro8Z3Zka7SRXyEFxSeLieSGbwXHkYlq1WeRULcjBYkU8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731522052; c=relaxed/simple;
	bh=m3z34E8KMcliNKMpHJdyh7NrDXIJfpWjy2XAuc2y3fE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jTSlfSdCl5NPMKxTxxyRKfl5JxMfvGn0hm3SfbVuvOL51Mp+GZBckWo0bTujh3XMN1go46m0itufIIv0wLZ4WM7nks3W0X+jk7ucoofj+Zh/wHTk8x0R/7U4KtUijJCB0HcJLVdDvZ2nrhwcb6ECpC68WZyb0QZ/pIaJcK0+twg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 018233858D26
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=NGPJZeIV
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9F53545C1F;
	Wed, 13 Nov 2024 13:20:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=7+5FFzhmuazxVcALmF/TNL/RDUo=; b=NGPJZ
	eIVdW0FuZphp5XHyNLPXaDj2qa6QSLjYiwM+pbQOGPW84FpWRGxdxQtvW4+VH8bP
	hoEz/VpY53FPgkALT67YM3lKDeTFYhgt3ciz8BPkV2Fa705FypoTHUc6phsJwN9D
	yLkels4N1BMLfisWIm9Vm3cE7ETX2E03/+sIYU=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 6C0BF45C12;
	Wed, 13 Nov 2024 13:20:51 -0500 (EST)
Date: Wed, 13 Nov 2024 10:20:51 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygthread: suspend thread before terminating.
In-Reply-To: <eee61bf2-edfe-c06c-bf80-188b7cdf22df@gmx.de>
Message-ID: <747a0848-dee5-7840-2318-661db4aa8373@jdrake.com>
References: <2c68d6fe-5493-b7e0-6335-de5a68d3cd3f@jdrake.com> <eee61bf2-edfe-c06c-bf80-188b7cdf22df@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 13 Nov 2024, Johannes Schindelin wrote:

> Hi Jeremy,
>
> Excellent work! Thank you for your impressive tenacity to stick with this
> problem. I built an MSYS2 runtime with the fix in
> https://github.com/git-for-windows/msys2-runtime/pull/73, and then started
> your reproducer from
> https://inbox.sourceware.org/cygwin-developers/78f294de-4c94-242a-722e-fd98e51edff9@jdrake.com/,
> and it failed to dead-lock so far (it's been running for almost an hour).

I ran the reproducer for 12+ hours with the patch to msys2-runtime, 4x
instances on QC710 running x86_64/msys2-runtime-3.5.4, and 2x instances on
Raspberry Pi 4 8GB running i686/msys2-runtime-3.3.6 (this is Windows 10 so
cannot do x86_64 emulation).  All failed to deadlock and are still
running.

