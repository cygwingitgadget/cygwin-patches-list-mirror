Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2EDEC3857830
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 17:21:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2EDEC3857830
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2EDEC3857830
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750180895; cv=none;
	b=xKSnzv7c0TnWSDMfBajj+T2+pAw0MLFXQxD9j+uW9NaO3+lR5WkXqt9GaMZFkAurT0ggPrXCCj34tVACs1Pt60zsaa0iYtF4miNPP5g/V94O3ZmnBZlfctpHt97oIoxOPsUXYmRG4UpvJa27wGxl5IU7ZsTZLJ3FQ7qvyF0Nv+k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750180895; c=relaxed/simple;
	bh=Zp6arDUpIB0VL6zjLRkC4UhAP7IsxDQMJKI/qFbQzRc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UZEwYOJroo0A/6YWi/O4PaEL8uP/Lv1DCPbBod/HbOej/TFAhGP7a4x66T7Y2QHTbhBUmMhnfBtHM7UikqjOiXGqRYBoTTVe2de7cB8Tnu2A+fIDapCF/dV4BWyPCWMdTri70TAuIyDZz92zuE2QwXGuHFSHsh122qzJx61zN/o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2EDEC3857830
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=v/iDRiWb
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 08B3A45D53
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 13:21:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=fMt682zUzSBvSrz7OWgmL4oRFaA=; b=v/iDR
	iWbz6cruC1Rw6PoU+XTgsL17t67mLbOCPzG4A0qkc7J9UPz2pcxtgrq3zSPRScGr
	n3Vryw8AP9JmpfrOAPb4Hog2H0fbD1ZfO65eAZCX07MZHbL1QSLf0V8YwoI67Elh
	WbtTbBGcN4AVmK5IVzcGWp1SLtzrpv1YBn1E24=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 05AA245CBA
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 13:21:35 -0400 (EDT)
Date: Tue, 17 Jun 2025 10:21:34 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
In-Reply-To: <aFFNnpI5eBgSl805@calimero.vinschen.de>
Message-ID: <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com>
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com> <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com> <aFFNnpI5eBgSl805@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

> On Jun 16 22:12, Jeremy Drake via Cygwin-patches wrote:
> > gcc 13.4.0 rebuilt successfully too.  The thing to watch out for with this
> > is "relocation truncated to fit" link errors.
>
> I don't see those when building Cygwin. What are you doing differently?
> Compiler or binutils version?

This was with an earlier version of the patch that failed to build in CI
on Github.

https://github.com/jeremyd2019/cygwin/commit/cd822eb2569755e992d8ef94c4a3b4097ed2a36a

> > Oddly enough, I saw this
> > when using the absolute symbols from the C++ inside the Cygwin DLL build,
> > but have not seen it building either DLLs or EXEs using clang or gcc, even
> > when trying to recreate the scenario (comparing a pthread_mutex_t to
> > PTHREAD_MUTEX_INITIALIZER).
>
> This may be fallout from using -mcmodel=small, see winsup/cygwin/Makefile.am.
> Default is -mcmodel=medium, IIRC.

That's probably it.

> When we ported Cygwin to x86_64, we got "relocation truncated to fit"
> when we decided to move the address space used by Cygwin on 64 bit
> beyond the 2 Gigs border.  Gcc and binutils got tweaked specificially to
> allow Cygwin to use the full address space as desired.  But the PTHREAD
> macros never triggered this problem before, which is puzzeling.

The pthread macros were previously casts of integers to pointers, which
would always be full absolute pointers.  This change is making them actual
symbols which the linker fills in with absolute addresses.  This would be
out of range of a 32-bit rip-relative relocation in cases where the image
base is >4GB.

This is really gross, as I said, but was the only way I came up with to
make them satisfy constinit's restrictions in clang (and the standard, it
seems GCC allows things that are explicitly disallowed by the standard).
Somewhat surprising to me is that clang also disallows using the address
of a dllimported extern variable in constinit, so we couldn't even
dllexport "magic" objects from the DLL whose addresses could be compared
against instead of (pthread_mutex_t)19 and such.
