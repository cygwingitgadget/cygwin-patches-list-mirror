Return-Path: <SRS0=zksf=ZG=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 6C3B23845394
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 17:10:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6C3B23845394
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6C3B23845394
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750698627; cv=none;
	b=cDNbscJD3ibJvHIu4qs4WthNu7GDaViViVdNaTQcNwPxkiAir7LRRf2pWxDx+P+W+77rI4+rGcCDh+kEcFzbl/sg1OySm6OtMc14xdnr/jGm1J8h1Ghcy1p1cBAIRab89oAU9XmZElvaNyqrvhoaCDQ8S8WIOPtk6XRtFaqY8GE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750698627; c=relaxed/simple;
	bh=MLM1nml6oBpT3nX3AckCjWnQ0JViLXjQ4W6avmiPYLk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ix7nximSFdwYlXEtNtbSZ9QdLVKHiSzKo7yU8RWtBe0KbpmjmD4AK8kLcLs/FCTw0AtYFh4wTqekFpVUUnE/ELBRcWMM5Bi0eQEaTDjL6eqM9oU39h+cdCgUqadviXPhpZGJvkiunFmIsX9ZWUyoPs2FqPs017g5U9FRLtQi8S8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6C3B23845394
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=pqbZVhtG
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B693045CC5
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 13:10:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=HhZ1x7eQZq5UmrYzanN7DyP7fks=; b=pqbZV
	htG7mMZgVvVWEajaZtqfELRdpBmqB0zQDTXGcUNV2m+h9N+i0eQ5hI5tBHPD+//j
	o7HzUqQGDj1yvgMxcYoRZvBmH1ZGNd/3VT5pEggBU5GFucIjjFdOi2bLcJy02LJ9
	aVeoKZhGum6SqVMUPyqiBN5R/IEcTAI/Lj4cgc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9BAF445CC3
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 13:10:26 -0400 (EDT)
Date: Mon, 23 Jun 2025 10:10:26 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Add tests for posix_spawn
In-Reply-To: <aFkS1da-6fyZmYN8@calimero.vinschen.de>
Message-ID: <9230f8a4-1372-59de-d4e6-b7853e9003e3@jdrake.com>
References: <a86dac1a-d11d-d993-d0f7-d80fddeff087@jdrake.com> <aFkS1da-6fyZmYN8@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 23 Jun 2025, Corinna Vinschen wrote:

> On Jun 20 11:00, Jeremy Drake via Cygwin-patches wrote:
> > I got all of the tests that I had written ported to run within the
> > winsup/testsuite context.  I did not include a test for NULL envp, since
> > that seems to not be specified by the POSIX standard, and behavior differs
> > between Cygwin and Linux.
> >
> > More tests could be added (notably for
> > posix_spawn_file_actions_add(f)chdir), but this is a good start.
>
> Indeed.  If you tested them with current Cygwin, feel free to add
> them to the testsuite.

I am testing these on Linux and Cygwin locally, and then in situ in GHA in
a fork of cygwin/cygwin on Github.
