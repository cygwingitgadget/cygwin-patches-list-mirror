Return-Path: <SRS0=KdRA=YY=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B33DA3858C39
	for <cygwin-patches@cygwin.com>; Mon,  9 Jun 2025 18:54:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B33DA3858C39
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B33DA3858C39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749495276; cv=none;
	b=GvNeF17dTy2QpheQgfBJUJHYVVUtxTb7ithzgYDxfmT+B8E9qlqnpf28KvlFVu///c158CYqB+8wFQ8WS8uN4u2RBEFqFiS213CfnZf/g4h1SVGLOk2OwS2tqyfMIydVcQTReipBpeZDEE6jV0AFuPCiaz0qUg/6yQq/bN/6OZo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749495276; c=relaxed/simple;
	bh=mjORGghWfcyF5ISMnGYx9Mmgw+zK1BJEPVToqSVJs/A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ddv4IDRB0yXmWPYFAoyb8v3Ljwh8QrfAPWoOuwMuQpOQNbFGFwK8owQAnsTnpSAyBeSqCteKoxff4ydY2QWZBjjEIej4OEytzuWUza/DQXqJoVvlaANf4rLxSPpdTCf0Enk+N2F524VtmGC0AtH1zS8NIj8CDXLjmvKeliF2wCg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B33DA3858C39
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=tAF3l0Hb
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 85D6C45CBC;
	Mon, 09 Jun 2025 14:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ZfSdkNnwcJZxdaLp12Z1n/5ObF0=; b=tAF3l
	0Hbv9PsHsapnsGG6IGuvbtn5EbAzKyMmOtlCGmPrM7oStAFpjMovPTSj/ZUXup63
	oYr5OuEX7SANNxIKhQn7MluYtE1IpU1wNykasn9tDwKtEHfVzBfhG2wBhpkj/6CP
	Jic1bWHyV0lZST+6jcRUInJpoq6GQifUtP2i0M=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 63B3245CBA;
	Mon, 09 Jun 2025 14:54:36 -0400 (EDT)
Date: Mon, 9 Jun 2025 11:54:36 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
In-Reply-To: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-90019484-1749495276=:11368"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-90019484-1749495276=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello
>
> Since today, https://github.com/cygwin/cygwin/actions/runs/15537033468=C2=
=A0workflow=C2=A0started to fail as it seems that `cygwin/cygwin-install-=
action@master` action started to use newer MinGW headers.
>
> The attached patch fixes compatibility with v13 MinGW headers while pre=
serving compatibility with v12.
>
> Radek

The change to cygwin/socket.h concerns me, that is a public header, and
you can't assume they are including MinGW headers, and if they are how
they are configuring them (ie, _WIN32_WINNT define) or which ones they
are including.  It looks like the mingw-w64 header #defines cmsghdr, mayb=
e
an #ifndef cmsghdr with a comment about this situation?  Or how do other
Cygwin headers handle potential conflicts with Windows headers?
--15599321219072-90019484-1749495276=:11368--
