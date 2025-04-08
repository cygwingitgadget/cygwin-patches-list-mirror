Return-Path: <SRS0=gAiW=W2=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id CFF173858CD9
	for <cygwin-patches@cygwin.com>; Tue,  8 Apr 2025 18:35:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CFF173858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CFF173858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744137349; cv=none;
	b=s+PrwAnaE7i4CDtdghtOVr/PLDZaQ669uZriIG0idkSIUWnpYEjd9z5CBowf2b/BrYZHxZdRVBHyCLn2+bqWu6jnG4xNC/YzC7KgAwqUedVuv6D5ow/kRss8HmQwBabWD4SNgJOf73KrohYaymJuC/Z8KL1ghZVIjYM4Fn8ahAk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744137349; c=relaxed/simple;
	bh=uScUzWiSrPdkGsUK7DxLF0Twep/1NXV8IHUpBDDuQaw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=pVIzUSB7eaeAiPyhE1a/TjrY3v+t14FdRU6W625FlJ639MpySWy84H3mF6wwKTFya31vRHKUBaegQEWhurajXKqMbo6C823o0Fct+PxyzQMec7D9kHNyUu7GI2UcZoZx6G15NrMn2RMHNEcBF3oh8M9D/PhNxd1CLD56zz6wGi4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CFF173858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=RI1tp8mz
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 86B5A45C7B
	for <cygwin-patches@cygwin.com>; Tue, 08 Apr 2025 14:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=j09n0z7U6hObg7+O6ZeG1+AmXho=; b=RI1tp
	8mzNZb9oBaLSUhnO+QCfQIZ8RgiMuZVfFsx90VDOo35gtFhwDeZBB1QpciWNGuDI
	zuigAaQ4EnK5qO3hRq1AELL2QIpteSlN9PUsQnALZwbsrtc3tkFUtCH0J8TftWLB
	RpQU6FWhen6RJNwhnlqalPwqwXpzQJKaqhuI7Y=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 82DCA45C78
	for <cygwin-patches@cygwin.com>; Tue, 08 Apr 2025 14:35:49 -0400 (EDT)
Date: Tue, 8 Apr 2025 11:35:49 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: thread: Allow fast_mutex to be acquired multiple
 times.
In-Reply-To: <Z_VngpFxvD_0rsew@calimero.vinschen.de>
Message-ID: <a381fc7a-2e43-cfe1-ca0b-a47a12aa4fb3@jdrake.com>
References: <20250324055340.975-1-takashi.yano@nifty.ne.jp> <Z-E6groYVnQAh-kj@calimero.vinschen.de> <20250324220522.fc26bee8c8cc50bae0ad742b@nifty.ne.jp> <Z-F7rKIQfY2aYHSD@calimero.vinschen.de> <20250326181404.847ecfadcad8977024580575@nifty.ne.jp>
 <Z-PJ_IvVeekUwYAA@calimero.vinschen.de> <20250404214943.5215476f96d46cf15587dd1b@nifty.ne.jp> <20250406195754.86176712205af9b956301697@nifty.ne.jp> <92ac7d14-4e71-14cf-91e0-080ca7a461f8@jdrake.com> <Z_VngpFxvD_0rsew@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 8 Apr 2025, Corinna Vinschen wrote:

> On Apr  8 10:26, Jeremy Drake via Cygwin-patches wrote:
> > On Sun, 6 Apr 2025, Takashi Yano wrote:
> >
> > > Revised.
> >
> > Sorry to be late to the party (I didn't open the attachment before, and
> > only saw the commit):
> >
> > > +  static class keys_list {
> > > +    LONG64 seq;
> > > +    LONG64 busy_cnt;
> >
> > Should these be `volatile`?  busy_cnt is probably OK, it only seems to be
> > dealt with via Interlocked functions, but seq is tested directly in some
> > cases and via Interlocked in others.
>
> One could think so, but...
>
> ....GLibc uses (basically) the same mechanism.  It reads seq in
> pthread_key_create and pthread_key_delete without atomic access, and
> neither the global array keeping the key info, nor the seq struct member
> in there are marked volatile.
>
> Is there anything which makes our version different?

I didn't realize that this was based on glibc code.  I don't know if they
know something I don't, or this is an oversight.  But it's probably OK
regardless, I don't think the compiler can know anything in practice that
could result in it skipping a read of those variables.
