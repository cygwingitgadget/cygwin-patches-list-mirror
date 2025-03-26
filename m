Return-Path: <SRS0=qRO6=WN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 724E5385AC1D
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 18:02:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 724E5385AC1D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 724E5385AC1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743012154; cv=none;
	b=L8oO8TCDffdizvB5wYtcUGaEzCPqJC/ac4IttFKkJyZJjOARaeExaxlY5pIeu8fraHOzJad22tC7go2rnOkfppoieZ8saT3vCyk+26aL+igGviY+/M0Ek3bHVzojSwJlBxHibJ60Dj8DjzQwZktjZ8mZOrxdSD7Af6JxB9QpXP4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743012154; c=relaxed/simple;
	bh=BOQwDHRw9/OUb3mIgnbKnKnADSHkhjV5VqUsa34X6NI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=bhs6LkeRdqPMSdOVw70HjKuN1RaVZ4peUKOjLzWRG3dQh27M/0x3+GkNAxrKawO4wZgZblc1U5DTC/g6JE8N2R4uNLVYLnjSwAMU33amntGPN5EwIFSVQGyCwtQr4mwqNnEZ+QuvgyFfwsZ8/PWyGQPeR15mRbcWQZTq7nKHXAw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 724E5385AC1D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=GvVq8Nac
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2B71045C8C;
	Wed, 26 Mar 2025 14:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=xI9CyXjVyCk4dZHiDx9ghGF087s=; b=GvVq8
	NacUvCYFSiOKl6bjlEiZJhBhOzg2PqKLxJAb8bGuX1tE5vMQRO4bU9tdGMvlF39+
	n7PGoFeAMmkBTDqjIb5vN7fodQNxZ8KKMsm1YLnwpuLa7gTf5aQ4l4bu6oMC2l8/
	pp5KSwgltPLWZ2xEsi5ZyMltyzbWHYjkD2tJBE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 262C845C8A;
	Wed, 26 Mar 2025 14:02:34 -0400 (EDT)
Date: Wed, 26 Mar 2025 11:02:34 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] find_fast_cwd_pointer rewrite
In-Reply-To: <3283c294-d62e-ac18-9fbe-d0e0071a1d64@gmx.de>
Message-ID: <399de145-447b-9db8-7fbf-73e2f3c923f8@jdrake.com>
References: <dd2918ee-0f21-a2e9-5427-e78be076bc5e@jdrake.com> <3283c294-d62e-ac18-9fbe-d0e0071a1d64@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> If I would change a thing, it would only be to extend the loop condition
> to include `&& ud_insn_mnemonic (&ud_obj) != UD_Iret`, so as to avoid
> running outside the function.

Yes, I was thinking about this after I sent the patches: terminate the
loop(s) if it hits a `ret` or possibly an unconditional `jmp`, and add the
same check to the ARM64 version.

I also was thinking about adding a link to the ARM doc I was using to
either the commit message or a comment.  The existing code didn't seem to
take any particular trouble that the reader might not be familiar with how
x86 instructions are represented in machine code, but dropping a link to
this doc shouldn't hurt (and it's substantially easier to follow than
Appendices A & B of Volume 2 of the Intel Software Developer's Manual :P)
