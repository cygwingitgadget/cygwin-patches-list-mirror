Return-Path: <SRS0=ejch=WS=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3948E3858283
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 02:16:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3948E3858283
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3948E3858283
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743387413; cv=none;
	b=P0WckhppkJ2n/J/KQ1bVgips9TiwNB1hG9Ta5C8lylpkZq//ct7Pxi7e+pmqJ4y7LOoxfjzpMhFhAinNOivKbuQcBOlTW5kpjgroPGySHFPPw9gB+nRzRZM60TeE2oBFYTXknHiBK5fJTLhBpr6eyjVG5w0c6Z3ZUyL9B/VNdWA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743387413; c=relaxed/simple;
	bh=2K4mJuJUrmHy9uZG8rTyW1TwI3t8T+wvncwkfOYgcW8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=jWUtnPs58+/2pVELUH4NdtDZPm/g+ekWKkXJFiQAuVegub07+cJ8hh1wkgQCNJIZv2bmrYXNDmBe5HgUwmnPseV/9jNCkGjAz0Urluy1zD+49Q4wokMDGD+xrhDNkLE+O82vFCqDUnipzYmL4by5Bbjgcr/Qm0JZHss6aUkjNqE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3948E3858283
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=I9Ex2zjc
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 96DB845C82
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 22:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=g1kcyAiPXh5ZG4qP/ukd6E/m2Cs=; b=I9Ex2
	zjcmzDBw3pFToO0rHiStFqHfTPtl8PW30H4WPCej/wXUy1mvEpRknjimWLDqSHMs
	y6ZEFWo8jeAQ/Auf/Fgzz/rP+6/y6U4XUooXaGEnffHED8YF8uiAoA4kSAjtQLAW
	t8//fj1QcjBUh/WlylM1g4qn7QQ7Gy75e91bLI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7E9B845C7F
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 22:16:52 -0400 (EDT)
Date: Sun, 30 Mar 2025 19:16:52 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 4/5] Cygwin: use udis86 to find fast cwd pointer on
 x64
In-Reply-To: <07bdad3b-0193-f6d3-905a-98c6c65c9046@jdrake.com>
Message-ID: <a294c915-1eb8-7fa3-a6f8-4c01a05c3478@jdrake.com>
References: <07bdad3b-0193-f6d3-905a-98c6c65c9046@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For fun, I extended the version of this in my prototype gist to work on
32-bit also, based on the behavior from 3.3, still with support for 8.0
omitted.

https://gist.github.com/jeremyd2019/aa167df0a0ae422fa6ebaea5b60c80c9/revisions#diff-1080b9098565759481130b81915e7a975f8243b7472c97c43a63500f0f432e93

