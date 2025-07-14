Return-Path: <SRS0=dar+=Z3=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 63ED43858D32
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 18:10:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 63ED43858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 63ED43858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752516621; cv=none;
	b=v4II6apoYP3fhoYRZqRgjbWqVwsc38IsZxZ4K7ByvHyI1JGJClWpszyNZIX7VhPtXetkQUxVh1cBv1piA6H7GLOuVarlBZ6OpPX7O6doJsMVJgOlRzpqRiVwMQHtkBlLpf4U6wy4YQGF4jBSM7Oajx/uNOCkDOcv//hyQUWnAAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752516621; c=relaxed/simple;
	bh=JB3r9ZMVaSH6XsHatlLmuPRTfjUN/CHvK5OpRzbxgGI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ay7q1EG8haUfNfQBEQPQgYVjCr4T5zraAqaDok1jx8zH0LiAHIrUkf1OQnmzB/nQT+ERpPHEkSUVNdIWa9DDBjOpxLji054qnD+qLjSfkTPsNq/pGRx/foXMt524kRMPdNm2hBXnIwbBEajDGy5fdGBEsibytgxipQXIfxlonSY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 63ED43858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=nkEWqdRU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 39D6D45CBA;
	Mon, 14 Jul 2025 14:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=jlrfcQmBpxIpA9wjviqUN3xHjwk=; b=nkEWq
	dRU2HCzvXXaMOKekyUgg8XtMFrAYfj6kvm9reXtqejCGoTfoaefN5ejBV2BjW9M2
	Czq4V5OXDPoDc7MIJ6DjuAYOhEEIbQ9Mp/K/JCF0xZ7onA6hr0uFGWtGnln0SaTl
	fLzlJzcHJE7ptuopaX9VWC9h8n3zw3DPjTErvA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3545745C1D;
	Mon, 14 Jul 2025 14:10:21 -0400 (EDT)
Date: Mon, 14 Jul 2025 11:10:21 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
In-Reply-To: <52e4e7cf-22d4-f8f7-0c1a-abbd9ca8f2a8@jdrake.com>
Message-ID: <3df9677e-9113-e7f0-3550-ac9f866d406d@jdrake.com>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <52e4e7cf-22d4-f8f7-0c1a-abbd9ca8f2a8@jdrake.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="12021613461504-531883711-1752516621=:74162"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--12021613461504-531883711-1752516621=:74162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jul 2025, Jeremy Drake wrote:

> On Thu, 10 Jul 2025, Radek Barton via Cygwin-patches wrote:
>
> > Hello.
> >
> > This patch implements `import_address` function by decoding `adr`=C2=A0=
AArch64 instructions to get
> > target address.
>
> Out of curiosity, can you elaborate on when `adr` is used rather than
> `adrp`/`add` pair?  I know adr has much less range, but it seems like t=
he
> compiler can't know how far away many symbols will be (perhaps it can f=
or
> things like local labels).  When I was looking at ntdll in the fastcwd
> stuff (and ucrt in ruby) adrp/add (or adrp/ldr) were used, never saw ad=
r.

adr has a +/- 1MB range from PC, while adrp/add has a +/- 4GB range.
--12021613461504-531883711-1752516621=:74162--
