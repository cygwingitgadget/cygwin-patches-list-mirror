Return-Path: <SRS0=ezLI=ZN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1DC6A3854A8E
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 17:11:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1DC6A3854A8E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1DC6A3854A8E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751303491; cv=none;
	b=PK8PImdOZHJa5fwpKQiGg0Ke1LGdLw3tb3XEozcgNyK57dlChoj9OhmK1oM8dE/3d/+OXnL7ZFofBjClYSbpemQ2oMVOfTr7QJWdFm6zLFzz9eQmltf4vdD4dKtrWKtmU09TeWzp6gd2kV3xhTQ9G7btdKu21Pn+SZWyuKuu7zc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751303491; c=relaxed/simple;
	bh=M2hNnaiMi7duW5Czdsa0diVj6ro2xKsrD+gnjEh4fYo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=AK2NnbTOmioWR7TSVq97ZhNLdv3+SfDH2051SiGytjYmjdXp1/mZoAGUYVoUM4IGSmK1P2bTF0ki1i7y9uGuENO5BrjVxAKhZ5hRsKjm6fuVTG612RiHjUJF17DsjPiD8QmV2PoJgOs0Xz3xmKjDbX7p31IDpmc6B6Ynzp0vw44=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1DC6A3854A8E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=OzJn8MBO
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 8A41645CCC
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 13:11:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ccHmIJ4O0VEMbdIQ6/an7RhIEfE=; b=OzJn8
	MBOiTapn5jMHQ4O6ghi7vzQ/JBpCukV58uMdRV2s7UayDzaRSjomXR04mpNMu+HZ
	kibSmERvV6EtXQfTpA0ytyG8/E0X9okbwmuv/8eTc8tuxu6Z/HJCBAR0xNlZ39Xn
	cPelm1FhUm0Y8R7ef007iJVXZm467VL0i32cv0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 852E645CC6
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 13:11:30 -0400 (EDT)
Date: Mon, 30 Jun 2025 10:11:29 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to
 spawn
In-Reply-To: <aGJeJH1rLCeitrqo@calimero.vinschen.de>
Message-ID: <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com> <aF6OibgUJ3IUvmLN@calimero.vinschen.de> <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com> <aGJeJH1rLCeitrqo@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 30 Jun 2025, Corinna Vinschen wrote:

> On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> >
> > > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > > -Wl,--disable-high-entropy-va in LDFLAGS?
> > >
> > > Why?
> >
> > With high-entropy-va, it has been observed that the PEB, TEB and stack can
> > happen to overlap with the cygheap
> > https://cygwin.com/pipermail/cygwin/2024-May/256000.html
>
> Yeah, but HEVA simply breaks fork.  We don't have to test this, because
> it won't work and we don't do it.  You can set the PE flag, but than
> you're on your own.

Outside of fork, is cygheap able to "relocate" in case the memory it would
like to occupy is already used?
