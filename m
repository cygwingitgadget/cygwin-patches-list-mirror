Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C44FD385C40E
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 23:32:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C44FD385C40E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C44FD385C40E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751067120; cv=none;
	b=vXMevI1THc/l2XFu81S74xSDPwyWLVkTM8wpPoxWSubpg6Xh3Uyd6HbNvBggzwqVgUnkyUI5kZgSp9+ayNt7sJTBUQvXCJxfeT/FmAOxBLYH1uNFIoi3943YKeIHBzQwC+sh5wA60dhYZ1jejxK81BA+katstJuyFrjYvbH8ZI4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751067120; c=relaxed/simple;
	bh=HOuRL44MZkwuaoFSWJBCPFLhjs/9PCYpkKENZdp/baA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=TTRJoyuAogqeaqkER1bKfbTX31dU3t0v5bLS41s3PyFDR0hjwPg7oraRRIuoBccBcsQaYZrxTxvpdmCzBW1pAALyhKuMBnFthN+x7EykSjR5GcBpVdKCBvcfmS57EK9U4Y+xlck6oNWdWgnWCCX6aLd2vs2y1HgSijiJF0KSpog=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C44FD385C40E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=lqpQ+oGr
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7D0F245D21
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 19:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=cGYx6ybBmraCsIU7XMmpGzWMkaM=; b=lqpQ+
	oGrvpyAh9zESd68vWn1enRF7vzdmGPXhAzByw8diSuM60L7bHZeqo7X8V1mCOGK+
	8TfZxuyup1cXPdLwrvaZv/Tupag1GryMJUnAPWFcOmSOSWjnt8imyLTTsfU8jmp+
	LNGTz4Y7dBJhqJBQTqUWH2f07P0yD9zKqp9G0A=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 630A045D18
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 19:32:00 -0400 (EDT)
Date: Fri, 27 Jun 2025 16:32:00 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
In-Reply-To: <aF6Qoq0yXMg4z3Jo@calimero.vinschen.de>
Message-ID: <e3b78bde-3b2e-cdc8-0319-fda17c47579e@jdrake.com>
References: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com> <aF59GwzNozRYeAp4@calimero.vinschen.de> <aF6Qoq0yXMg4z3Jo@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 27 Jun 2025, Corinna Vinschen wrote:

> On Jun 27 13:14, Corinna Vinschen wrote:
> > On Jun 26 16:55, Jeremy Drake via Cygwin-patches wrote:
> > > stdin and stdout were alreadly allowed for popen, but implementing
> > > posix_spawn in terms of spawn would require stderr as well.
> > >
> > > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > > ---
> > >  winsup/cygwin/dcrt0.cc                    | 2 ++
> > >  winsup/cygwin/local_includes/child_info.h | 6 +++---
> > >  winsup/cygwin/spawn.cc                    | 5 +++--
> > >  3 files changed, 8 insertions(+), 5 deletions(-)
> >
> > LGTM.  A sentence on why we can actually use the filler bytes now
> > wouldn't hurt in the commit message.
>
> ....or rather...
>
> > int worker (const char *, const char *const *, const char *const [],
> > -                    int, int = -1, int = -1);
> > +                    int, int = -1, int = -1, int = -1);
>
> ....maybe this should actually get an array of three descriptors,
> rather than getting one additional argument per descriptor, i.e.
>
>   int worker (const char *, const char *const *, const char *const [],
>   -                    int, int = -1, int = -1);
>   +                    int, int[3]);
>
> There's no good reason for these default args anyway.

It's getting kind of silly how many args this function has.  The
construction of this function (using placement new to reconstruct "this"
inside worker) is kind of awkward for using members and setters (though
this was done for the posix_spawn semaphore).  Might it make sense to pass
a (pointer to a) struct/class instead?


