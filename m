Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 089FF392865D
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 17:35:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 089FF392865D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 089FF392865D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750268104; cv=none;
	b=IyVk27j3oNwZ2D4xGc8KcLH8jxCog8ftsD+QlO+Ug3mzP+Qt6HYwiGDaS/yLerfZyuurCNHw7PCUcZ/BIHbRIxJmYIMs8/yIQ6/IZxV4GrtCa5a7u4sfeH6notLdY7QMTvZWgqjxhB+u0LHc1+/OQVO96CnEInLhhfZwDeYJhXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750268104; c=relaxed/simple;
	bh=ANPnM9G2h4d4e71sVxXJLCnU1kAJt18cOXHUiUeg3R8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=gYVltGxrAKIQ7rFRuayooHiXvjKGQf4f74Q/muE+ovFQG60nb2Y12VcBqe5sW8M2aOhsLREUOvrUNCA+nLVNhILbf5muNRD/FWFiFHQR8GfpVIMOznGMoWRTsmlLCW9TTR+uX/8pCB1gnjmBn943+6AS8GJOJlruy/8chPueZro=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 089FF392865D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=cd9E+dWL
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D3AFF45D3F;
	Wed, 18 Jun 2025 13:35:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=m7PfwbIHSR/JTNsG4NH0YFSjjLA=; b=cd9E+
	dWL/3WfSr0S4C9XZQDHHArMhjwZ7uWhTby38xniHdkZ3ox+z0j27i79CxXxgAmjz
	8hl9tKe83C8PTy5cM8nba0GUBRC6b6aWT3TxJSXLtWaZeWDFuEMNkvynlpXOsU+F
	94pMIN5Htz2RrejWqqbcSToVAvuPmCXfbUVSD0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CCEC045D37;
	Wed, 18 Jun 2025 13:35:03 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:35:03 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: stack base initialization for AArch64
In-Reply-To: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
References: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-1554077390-1750268103=:11368"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-1554077390-1750268103=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> This patch ports stack base initialization at dcrt0.cc to AArch64.
>
> Radek
>
> ---
> From 5d470261d9b865bf709f9f4d8da350e3536e6251 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Thu, 5 Jun 2025 13:15:22 +0200
> Subject: [PATCH] Cygwin: stack base initialization for AArch64
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
> index f4c09befd..15b3479d3 100644
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
> +		       sub sp, fp, #32 \n"

Is the 32-byte shadow space part of the aarch64 calling convention spec,
or is this just copying what x86_64 was doing?  My impression is that thi=
s
space was part of the x86_64 calling convention.


> +		       : : [ADDR] "r" (stackaddr)
> +		       : "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.49.0.vfs.0.4

--15599321219072-1554077390-1750268103=:11368--
