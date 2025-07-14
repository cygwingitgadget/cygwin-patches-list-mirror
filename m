Return-Path: <SRS0=dar+=Z3=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 8B9F33858D32
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 23:46:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8B9F33858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8B9F33858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752536801; cv=none;
	b=JxB3UjzSZENHKg7LS/Z3GSJID/EHQvIXeQVD8X52ZHbZC4miAg1FT77ps3B4/rHeDSMjRsBcpd1FqWFU7vf6dxjIuwixtq5YZu+zTkWY2V3WmtnVZ30hWhxGijU1nNGpcw5lki4eguKOI9+8CXAUc9UakVODue96KLiaNQ13ofg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752536801; c=relaxed/simple;
	bh=d3GQw9CJinH3enNs1F61siAm5vlLHpGvJ/wcXjgSbdI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HVrpGRMDkqEPhySH6EM3ehjf23cd4dUuLVy97A9Sb8YpzRohU9hVdhxnVtqJWYVgpAdVYAJ7GckVaYS1v5OpCB8gtUpG5xMBF1w6YnPBXB/k4RgqRnEx+PsSpQy1WDb99iT/FiTMaKNJNdjhbXuZaPjl+KCTMWGoLdKeipr3UhU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8B9F33858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=h3Qpj1fe
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3038D45CBA;
	Mon, 14 Jul 2025 19:46:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type:content-id; s=csoft; bh=vW6Nc9ofpoXefaQSaPZCsDpCiR
	8=; b=h3Qpj1febYMYlV45p4rZav21yh9yyWM4yVDJQ77jtLO96RVcmumFY/aDSs
	zW9/52Nd552ifyIPQUf/la/skzYFeCxibnphsTNPoQQmkaIWpli6ZA8kCdKHhCYk
	TGpCRMFDegIwfMTd+d9Zba3hIPpQaTg2gbNIvP7PYcTf0bII4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2ACA345C1D;
	Mon, 14 Jul 2025 19:46:41 -0400 (EDT)
Date: Mon, 14 Jul 2025 16:46:41 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Radek Barton <radek.barton@microsoft.com>
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
In-Reply-To: <392fde36-436d-4b6e-9218-48084fec19be@SystematicSW.ab.ca>
Message-ID: <e3ba06a3-357e-246c-8dbd-18be57bdc4c3@jdrake.com>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <52e4e7cf-22d4-f8f7-0c1a-abbd9ca8f2a8@jdrake.com> <3df9677e-9113-e7f0-3550-ac9f866d406d@jdrake.com> <392fde36-436d-4b6e-9218-48084fec19be@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1769378504-1752536399=:74162"
Content-ID: <b58dc924-c230-1709-3067-6a4a5cd33557@jdrake.com>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1769378504-1752536399=:74162
Content-Type: text/plain; charset=UTF-8
Content-ID: <06e2a554-2721-2b5c-bbc6-c631be235e5b@jdrake.com>
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Jul 2025, Brian Inglis wrote:

> On 2025-07-14 12:10, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 14 Jul 2025, Jeremy Drake wrote:
> > > On Thu, 10 Jul 2025, Radek Barton via Cygwin-patches wrote:
> > > > This patch implements `import_address` function by decoding
> > > > `adr`=C2=A0AArch64 instructions to get
> > > > target address.
> > >
> > > Out of curiosity, can you elaborate on when `adr` is used rather th=
an
> > > `adrp`/`add` pair?  I know adr has much less range, but it seems li=
ke the
> > > compiler can't know how far away many symbols will be (perhaps it c=
an for
> > > things like local labels).  When I was looking at ntdll in the fast=
cwd
> > > stuff (and ucrt in ruby) adrp/add (or adrp/ldr) were used, never sa=
w adr.
> >
> > adr has a +/- 1MB range from PC, while adrp/add has a +/- 4GB range.
>
> Details:
>
> https://devblogs.microsoft.com/oldnewthing/20220809-00/?p=3D106955

Both this and the mkimport script use/assume adr in the import thunk, but
I checked LLD and it has:

static const uint8_t importThunkARM64[] =3D {
    0x10, 0x00, 0x00, 0x90, // adrp x16, #0
    0x10, 0x02, 0x40, 0xf9, // ldr  x16, [x16]
    0x00, 0x02, 0x1f, 0xd6, // br   x16
};

(the actual offset is filled in later:
  int64_t off =3D impSymbol->getRVA() & 0xfff;
  memcpy(buf, importThunkARM64, sizeof(importThunkARM64));
  applyArm64Addr(buf, impSymbol->getRVA(), rva, 12);
  applyArm64Ldr(buf + 4, off);
)

I imagine both places need to use/handle the adrp/ldr pair.  Binutils
seems to use an extra instruction:
static const unsigned char aarch64_jtab[] =3D
{
  0x10, 0x00, 0x00, 0x90, /* adrp x16, 0        */
  0x10, 0x02, 0x00, 0x91, /* add x16, x16, #0x0 */
  0x10, 0x02, 0x40, 0xf9, /* ldr x16, [x16]     */
  0x00, 0x02, 0x1f, 0xd6  /* br x16             */
};

(the LLD code has an implicit 12-bit offset that is filled in, rather tha=
n
the 12-bit immediate that's filled in the add in binutils).  So that's
another wrinkle this malloc wrapper dereferencing thing needs to deal
with.
--0-1769378504-1752536399=:74162--
