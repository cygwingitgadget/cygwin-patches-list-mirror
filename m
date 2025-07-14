Return-Path: <SRS0=dar+=Z3=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E11403857356
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 17:20:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E11403857356
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E11403857356
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752513660; cv=none;
	b=bdjGkOj8FiuqMdDcJBKfBC2TXgOHbhaOudLryO5ANItw3qcjM4kmfFxjeRzFOcrtDpXuujv7DNTPTit9ndjGnXiewlqduKrHp7GxqzYLhMhuEz0wzm0HnG3zWkmGlVGfqz4UuMt66vE1jA1jA+yZ4FhDehKnbUI5/hwf07MUm7I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752513660; c=relaxed/simple;
	bh=gd68bP8ggZeNTeBULeGs8DW/pc0fVBm+0JQ+rN0PRaE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rCRUn3vIj/K6qrfAAH4igGLQWZiPai99fyjG79ZfAgxRKh2DrUte4AYWXqLFWmmA7yIrBicrGYlI/9i7VlFZr77yzO9xTwHNttm1SDQE9qDdrPPDZD9B05NNZ1LrDu3DV92zT3i1xnjOwe6seSSsorCY/IAq0dxryoPwaZid6eE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E11403857356
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=0+OdQxl4
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 34B7245A5F;
	Mon, 14 Jul 2025 13:20:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=SiXsjtj1dQU/OfV/Q5GKrsUO8ao=; b=0+OdQ
	xl47jqS9LVXGq687QhMrBAeD17PRMRiBSF2Baq3BfIsQ8VqRDt7r8dpNx5bm5aU7
	4gNns8cjmFhfUB6h4rLcFPB2o1UoIF0peLuFxR+2+arPo17niQnqBQyR5o7CN3Jv
	IfaRd9Be0vzU+JvApZc3HT58XG7Gh4yN//crO8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1883E45A25;
	Mon, 14 Jul 2025 13:20:46 -0400 (EDT)
Date: Mon, 14 Jul 2025 10:20:45 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
In-Reply-To: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <52e4e7cf-22d4-f8f7-0c1a-abbd9ca8f2a8@jdrake.com>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="12021613461504-1878027928-1752513646=:74162"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--12021613461504-1878027928-1752513646=:74162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> This patch implements `import_address` function by decoding `adr`=C2=A0=
AArch64 instructions to get
> target address.

Out of curiosity, can you elaborate on when `adr` is used rather than
`adrp`/`add` pair?  I know adr has much less range, but it seems like the
compiler can't know how far away many symbols will be (perhaps it can for
things like local labels).  When I was looking at ntdll in the fastcwd
stuff (and ucrt in ruby) adrp/add (or adrp/ldr) were used, never saw adr.

> Radek
>
> ---
> From 8bfc01898261e341bbc8abb437e159b6b33a9312 Mon Sep 17 00:00:00 2001
> From: Evgeny Karpov <evgeny.karpov@microsoft.com>
> Date: Fri, 4 Jul 2025 20:20:37 +0200
> Subject: [PATCH] Cygwin: malloc_wrapper: port to AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Implements import_address function by decoding adr AArch64 instructions=
 to get
> target address.
>
> Signed-off-by: Evgeny Karpov <evgeny.karpov@microsoft.com>
> ---
> =C2=A0winsup/cygwin/mm/malloc_wrapper.cc | 14 ++++++++++++++
> =C2=A01 file changed, 14 insertions(+)
>
> diff --git a/winsup/cygwin/mm/malloc_wrapper.cc b/winsup/cygwin/mm/mall=
oc_wrapper.cc
> index de3cf7ddc..863d3089c 100644
> --- a/winsup/cygwin/mm/malloc_wrapper.cc
> +++ b/winsup/cygwin/mm/malloc_wrapper.cc
> @@ -50,6 +50,19 @@ import_address (void *imp)
> =C2=A0{
> =C2=A0 =C2=A0__try
> =C2=A0 =C2=A0 =C2=A0{
> +#if defined(__aarch64__)
> + =C2=A0 =C2=A0 =C2=A0// If opcode is an adr instruction.
> + =C2=A0 =C2=A0 =C2=A0uint32_t opcode =3D *(uint32_t *) imp;
> + =C2=A0 =C2=A0 =C2=A0if ((opcode & 0x9f000000) =3D=3D 0x10000000)
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0uint32_t immhi =3D=
 (opcode >> 5) & 0x7ffff;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0uint32_t immlo =3D=
 (opcode >> 29) & 0x3;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0int64_t sign_exten=
d =3D (0l - (immhi >> 18)) << 21;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0int64_t imm =3D si=
gn_extend | (immhi << 2) | immlo;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0uintptr_t jmpto =3D=
 *(uintptr_t *) ((uint8_t *) imp + imm);
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0return (void *) jm=
pto;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82}
> +#else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*((uint16_t *) imp) =3D=3D 0x25ff)
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0const char *p=
tr =3D (const char *) imp;
> @@ -57,6 +70,7 @@ import_address (void *imp)
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=
=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0=
 (ptr + 6 + *(int32_t *)(ptr + 2));
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 =C2=A0return (void =
*) *jmpto;
> =C2=A0=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82}
> +#endif
> =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0__except (NO_ERROR) {}
> =C2=A0 =C2=A0__endtry
> --
> 2.50.1.vfs.0.0
>
>

--=20
Croll's Query:
	If tin whistles are made of tin, what are foghorns made of?
--12021613461504-1878027928-1752513646=:74162--
