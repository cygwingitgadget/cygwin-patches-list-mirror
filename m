Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 75CF93816B86
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 17:36:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75CF93816B86
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75CF93816B86
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750268180; cv=none;
	b=xAnhrphudzxaoXUkikrRtzEfGRAcyrXzbg3sDUp/9lQ4JWSNuinqoY5CgCMxNam7JJ63mLp5CUX/HJ+XH6mb3kvgvTxtQdOTLlBMQZNolUHFHB5Xh1IdP+672eCtPg9AOSynl4LsGH3zs8ow9dfFA09fvF3O38EeJkWwx18UH/w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750268180; c=relaxed/simple;
	bh=oWcJ0UR11+teroD2SuCBYC6T2ChJgwFk9Jae+oPgQaY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=g+pyZ+tL34FXo4LQbWudcSOM3E+gxYXZx1IKsSMrd7EP3Qb3PPEXticBXyQSGU4zxBk6tSj/4DC/YRsRFFeAKTeEW69lyn0jMUQM4A/dQ30Vl0z6osnUmfttngj2Mqcsv6hrtIEjikjiVvny00ShlKnEsRoe72Dhnl/fgF3fohk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75CF93816B86
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=GmV2+I8P
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D00C345D3F;
	Wed, 18 Jun 2025 13:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=SklpGzJPIAJTX6zFE84yCk2rUAI=; b=GmV2+
	I8Paj2siJE7R8Ih/K+nY3YvvjmdyFYdHuF+lE8JJKlbjvS/5lmNiTQEUO9Em/osI
	pNeofFLK+Ar7Z6OalU27ODCEsvfQXKaar4raqjrKyUhQ5FNOJAs+upkSXOZWOLXk
	kuYnmDHDOv/L89RbCoupqDUbaZJs/4uqhba5Lg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CB4B545D37;
	Wed, 18 Jun 2025 13:36:13 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:36:13 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: obtain stack base on AArch64
In-Reply-To: <DB9PR83MB0923187D66011DE1CB903BF09272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <7b7b45f7-d126-5673-2961-7c7672f5f922@jdrake.com>
References: <DB9PR83MB0923187D66011DE1CB903BF09272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-32144479-1750268173=:11368"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-32144479-1750268173=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> This patch ports reading of stack base from TEB on AArch64 at cygload.c=
c and __getreent.
>
> Radek
>
> ---
> From 08f9be50573a085fd3e5cb840455ea5fc3b1e82a Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Wed, 4 Jun 2025 13:38:10 +0200
> Subject: [PATCH] Cygwin: obtain stack base on AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/include/cygwin/config.h  | 7 ++++++-
>  winsup/testsuite/winsup.api/cygload.cc | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/include/cygwin/config.h b/winsup/cygwin/incl=
ude/cygwin/config.h
> index 2a7083278..d9f911d47 100644
> --- a/winsup/cygwin/include/cygwin/config.h
> +++ b/winsup/cygwin/include/cygwin/config.h
> @@ -36,8 +36,13 @@ __attribute__((__gnu_inline__))
>  extern inline struct _reent *__getreent (void)
>  {
>    register char *ret;
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>    __asm __volatile__ ("movq %%gs:8,%0" : "=3Dr" (ret));
> +#elif defined(__aarch64__)
> +  /* x18 register points to TEB, offset 0x8 points to stack base.
> +     See _TEB structure definition in winsup\cygwin\local_includes\ntd=
ll.h
> +     for more details. */
> +  __asm __volatile__ ("ldr %0, [x18, #0x8]" : "=3Dr" (ret));
>  #else
>  #error unimplemented for this target
>  #endif
> diff --git a/winsup/testsuite/winsup.api/cygload.cc b/winsup/testsuite/=
winsup.api/cygload.cc
> index afd3ee90f..08372a302 100644
> --- a/winsup/testsuite/winsup.api/cygload.cc
> +++ b/winsup/testsuite/winsup.api/cygload.cc
> @@ -82,6 +82,13 @@ cygwin::padding::padding ()
>      "movl %%fs:4, %0"
>      :"=3Dr"(stackbase)
>      );
> +# elif __aarch64__
> +  // x18 register points to TEB. See _TEB structure definition in
> +  // winsup\cygwin\local_includes\ntdll.h
> +  __asm__ volatile (
> +    "ldr %0, [x18, #0x8]"
> +   :"=3Dr" (stackbase)
> +   );
>  # else
>  #  error Unknown architecture
>  # endif
> --
> 2.49.0.vfs.0.4
>

LGTM.  Should I be pushing these or just reviewing them on the list?
--15599321219072-32144479-1750268173=:11368--
