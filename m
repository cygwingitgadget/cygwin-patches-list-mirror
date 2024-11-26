Return-Path: <SRS0=DNbP=SV=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5FFD53858D37
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 22:42:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5FFD53858D37
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5FFD53858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732660953; cv=none;
	b=AnGfuN0eCXSpK8IhqU/GebtpT52j1MmDpgMNjUKaHl6+cOoZFpVRHkniSBJDmTxka7V4Nt96ZJ2gtTQruZdE41AJrz7cT17TSi21lBK1AOqBIipVm1cYIbbTd57xAxdFz9h8MbT1dLTmrblFk03diJe6FAw5NIF35I16HstNu5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732660953; c=relaxed/simple;
	bh=XxVzQ4HmtBzSHdu/CWvCHatVwC4L9OPgF2HJxG4L6bo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PI+cMMw/3lQ1v6yP9e29Gfq4bzbK6udicMe4AfLC8Ey+5KjPuvHcAsE9Tng5ocaV03HlXzBQVfDw9VNdN+atJTObsKUrluCoStLySCmn5pjVKGZrI3s2NF2UCjAgDJl2sOoS1GZu6nYHK65/AfkweMM+72t66ot95dnQQe12k1E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5FFD53858D37
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=F+wAdbWC
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 368D545CA3
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 17:42:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=xtlGZ4Q4T01l8nHt14uJKuOcjbg=; b=F+wAd
	bWCL77nWOn4ZQ0LKwfCtFyqcWZg4goHij3C5Ea+EtAvIkkzHG5KisixUjzLMlBgk
	COB7DPpiwAdVVpZE06jSBOjWWWa6B1Sq9P4JowVfkwjXDGL1C0rWjw/A0brsxNyE
	CgX2Y1SnGoNKgyEO9/whQ9lvf9gumbJs/YrYj4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 31C0545CA1
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 17:42:33 -0500 (EST)
Date: Tue, 26 Nov 2024 14:42:32 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: cache IsWow64Process2 host arch in
 wincap.
In-Reply-To: <Z0XOOW365ff53K6B@calimero.vinschen.de>
Message-ID: <59f580ca-bded-6d45-c624-fd1ca13bd744@jdrake.com>
References: <9d0630f7-e8d6-b4f6-116b-1df6095877c3@jdrake.com> <Z0XOOW365ff53K6B@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 26 Nov 2024, Corinna Vinschen wrote:

> Btw...
>
> We're doing this because nobody being able to debug ARM64 assembler came
> up with a piece of code checking the ntdll assembler code to find the
> address of the fast_cwd_pointer on ARM64.
>
> You seem to have the knowledge and the means to do that, Jeremy.
>
> Any fun tracking this down?

Ha, no, not really.  I looked into something similar trying to get Ruby
running on Windows on ARM64, and learned enough to know that how ARM64
encodes addresses is odd enough that I didn't want to dig further ;)

Somebody else did end up implementing getting a private variable (out of
UCRT) by looking at ARM64 assembler, maybe that could work as a starting
point?

https://github.com/ruby/ruby/commit/784fdecc4c9f6ba9a8fc872518872ed6bdbc6670#diff-883ccab70529ab9c4e51fa7b67e178a205940056b21cd123115ebadd8029f50f

(on the Ruby issue, I was of the opinion that it wasn't worth the effort
and periodic breakage to dig out that variable, and I kind of have that
opinion about the FAST_CWD stuff too - I've yet to see any issue from
*not* having it on ARM64, so all of this is probably just to deal with
some rare edge-case).
