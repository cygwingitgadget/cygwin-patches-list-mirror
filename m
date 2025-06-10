Return-Path: <SRS0=9F77=YZ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 9F30D3858D35
	for <cygwin-patches@cygwin.com>; Tue, 10 Jun 2025 20:44:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F30D3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F30D3858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749588292; cv=none;
	b=B8OMRCtKKdiIY2vJBoMzz1F88EsbAieS8dMPwjYAACZZ46ZF1N4EOeU8K1uPRMmHtcOJLT0iCGYa/ZU/5/SYmlblalKKJrf1CofC8exa4jNY7v0xKDvBVbS5j5AQd46oTdLtL+17cjX/fFg+/eSzSOLgz+UGVA+dp8lZ9ZTLuns=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749588292; c=relaxed/simple;
	bh=+AtK74Rkbl/fQ6SHlxVxzvNXX7yPhZPDv1FKQokLy68=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=IpHVv3qwErxgXfUADc/smuWXOZG5uo57eJRzPcfYXP3jXOmC93gAHlNs9LvvAjyTVhAnyKmzYbTUGAhNyOGWK/UFlo5Db4fgAsz9HdPSUgZOF6h1fuzzh9V5XBOe1Wil7QkEhMQx+D4X6/fizXXHj7LGi/kKCXrYwhj2Ilwv8T4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F30D3858D35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Tf4EIsxj
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1E86245CCC;
	Tue, 10 Jun 2025 16:44:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type:content-id; s=csoft; bh=RJw7GWxUiLrngaBR80urFOR0f9
	A=; b=Tf4EIsxjfkVtRSWjWBUAE2p9Ec3cUHsqMSWMUvTX6fNmKu9YbUVKaQ9qFr
	CPuO0l/a8CFfyIZs/FYRR/W+RIJLNC4aPzUk5Uqd9CIf4q0RInE505xKEi2v/Xcv
	axH7419QMkyw5MU3PUJN2WDJlqeGv4sYiNAXws0Ak5U6szBGM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 02FA945C94;
	Tue, 10 Jun 2025 16:44:52 -0400 (EDT)
Date: Tue, 10 Jun 2025 13:44:51 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
In-Reply-To: <05bf71ad-5238-4f86-8b2d-21e16e4bf071@dronecode.org.uk>
Message-ID: <46193209-a30e-c73f-ea01-7db49d53c135@jdrake.com>
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com> <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com> <05bf71ad-5238-4f86-8b2d-21e16e4bf071@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1158555337-1749588246=:11368"
Content-ID: <ec7a9818-2a4d-f8f6-15b4-76f2ae098859@jdrake.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1158555337-1749588246=:11368
Content-Type: text/plain; charset=UTF-8
Content-ID: <5d8abf07-4e6a-5a1c-e86e-4ac66ab943ac@jdrake.com>
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2025, Jon Turney wrote:

> On 09/06/2025 19:54, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
> >
> > > Hello
> > >
> > > Since today,
> > > https://github.com/cygwin/cygwin/actions/runs/15537033468=C2=A0work=
flow=C2=A0started
> > > to fail as it seems that `cygwin/cygwin-install-action@master` acti=
on
> > > started to use newer MinGW headers.
> > >
> > > The attached patch fixes compatibility with v13 MinGW headers while
> > > preserving compatibility with v12.
> > >
> > > Radek
> >
> > The change to cygwin/socket.h concerns me, that is a public header, a=
nd
> > you can't assume they are including MinGW headers, and if they are ho=
w
> > they are configuring them (ie, _WIN32_WINNT define) or which ones the=
y
> > are including.  It looks like the mingw-w64 header #defines cmsghdr, =
maybe
>
> Yeah.
>
> That requires a different solution.
>
> > an #ifndef cmsghdr with a comment about this situation?  Or how do ot=
her
> > Cygwin headers handle potential conflicts with Windows headers?
> I think something like the attached to avoid seeing the conflicting
> definitions? (unpleasant, but perhaps necessary)
>

That makes sense to me, and satisfies not messing with the public header.
If a consumer of Cygwin includes both cygwin/socket.h and mswsock.h, they
can figure out the mess themselves ;)
--0-1158555337-1749588246=:11368--
