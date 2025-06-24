Return-Path: <SRS0=JvsG=ZH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1EE193858410
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 22:54:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1EE193858410
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1EE193858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750805651; cv=none;
	b=fGQ37pM5rGebxjS9GVQQX4VpKleMBOLNr2dLOacuAGKAC/v0dUMKcFvjDm0x0IhPH85V5tNIOX0Fhgqd44cx74wCAP3WjmKu+arOtQVUxtABL1NUWCHFixpjuTgasAOOxpgC+KnIpxTzKpzi6tszR8fgichT75Thqc3r9oC112I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750805651; c=relaxed/simple;
	bh=ceit+J8CE8vaw7uTjbCoHwrhjGtSNdB6hJTOD+AOIzY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=pD8t/CiXvsC+T/naraegdy67/xy05dUPAnxFywGml4Waixik2+9X101T0e4iUWs5XQmEIOwqM3DCfXjezYsNqQb55cBgn/eaKWxv9P/kM6EDdfFygL0lla6H1j8hPO8InJWt9oe6TFYKsTYGlZD1Y8TF4J1udzRC0jpwXzYvP0s=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1EE193858410
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Epj1cNyw
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C039D45CF8;
	Tue, 24 Jun 2025 18:54:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=UhfdzOcuGfkW4b5qE5UNgjAhuKE=; b=Epj1c
	NywlA4YRZqMT4cBp7ruyWI8s2OOANkyWXPvpowEjzevIB/axIy2Sf8LXS+/1McLP
	hE12/0OybCFMRTYZULcgQHTiWFiYsEQBARD5MNw4T1qs82ObLxnkRJyBKHqSDCeg
	HnQx0p+PcP2yfjN/PQFPHt4kyYkbzO44Cnzo6c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A288C45CF5;
	Tue, 24 Jun 2025 18:54:10 -0400 (EDT)
Date: Tue, 24 Jun 2025 15:54:10 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: stack base initialization for AArch64
In-Reply-To: <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <09e1b5fd-340b-7cbc-6ea4-b6a12007447d@jdrake.com>
References: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com> <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com> <DB9PR83MB0923E495EA001D0887EC80469279A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aFj-bZ28sTEOvVqj@calimero.vinschen.de> <DB9PR83MB0923D30C1D31D3B74457118C9278A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-974110579-1750805650=:11368"
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-974110579-1750805650=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello
>
> Finally we've managed to rule out that the regressions were actually in=
troduced by https://sourceware.org/pipermail/cygwin-patches/2025q2/013832=
.html, Thiru will send the fix soon.

I'm curious to see what this was.  I hope it wasn't my ugly hack change t=
o
pthread initializer macros...

>
> Radek
>
> ---
> From c33f2e1b0037f9e5a3dbae4a0c82070db851cb33 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Thu, 5 Jun 2025 13:15:22 +0200
> Subject: [PATCH v3] Cygwin: stack base initialization for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/dcrt0.cc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index f4c09befd..3dceae654 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -1030,14 +1030,20 @@ _dll_crt0 ()
>  	  PVOID stackaddr =3D create_new_main_thread_stack (allocationbase);
>  	  if (stackaddr)
>  	    {
> -#ifdef __x86_64__
>  	      /* Set stack pointer to new address.  Set frame pointer to
>  	         stack pointer and subtract 32 bytes for shadow space. */
> +#if defined(__x86_64__)
>  	      __asm__ ("\n\
>  		       movq %[ADDR], %%rsp \n\
>  		       movq  %%rsp, %%rbp  \n\
>  		       subq  $32,%%rsp     \n"
>  		       : : [ADDR] "r" (stackaddr));
> +#elif defined(__aarch64__)
> +	      __asm__ ("\n\
> +		       mov fp, %[ADDR] \n\
> +		       mov sp, fp      \n"
> +		       : : [ADDR] "r" (stackaddr)
> +		       : "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.49.0.vfs.0.4

LGTM, I'll push tomorrow if there are no objections.
--15599321219072-974110579-1750805650=:11368--
