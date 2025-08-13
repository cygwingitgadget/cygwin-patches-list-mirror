Return-Path: <SRS0=XKsG=2Z=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C885E3858D20
	for <cygwin-patches@cygwin.com>; Wed, 13 Aug 2025 17:33:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C885E3858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C885E3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755106439; cv=none;
	b=iDz5J0IzZOWjsoCBxtf9DIoF6uSjvNWkCItmfBM+x3mLMbZ+s7KYS25VG6k1ZJKEitukz/jGakIA+MI7FX7fRiTZqawhEC4X7WU8OnIGcn1/Em7+fDkaCLswlXU4nDamxsVVK9hrcqGA2Yijvo2582CRaV5BixK+sKn2T5C8Ks4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755106439; c=relaxed/simple;
	bh=bqX2KVWfhu/QWVgGbU+X1KvY1/gqCdPe7YZjU+5UliI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Z08C/85Mh5sapmU0OQ45BmsCVjehneqqcNg+xGslaE9C0TcCOnaaHDKM6yk/wshOFlRI1pPibf0MlXLQ4bKUI6WyEpbJBZ+7k6CP40/yAUXqd9u+ZyOBiL+yIDYCVLnXu0RSLfCYqDuZ9UExleK9fQhzIdpjiGAJ2QugAHspoCY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C885E3858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=UN4/4tdv
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 78E8A45CE1;
	Wed, 13 Aug 2025 13:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=GeiqAxA727OdBMmVwdnb2oNQ0ug=; b=UN4/4
	tdvColYrRAz9jdl4wXXLpjd6+NUzn0Gw3GQZeMKschlzXuyL16k00AEFhkeksQMP
	mGMe7YUIt9qKYKgQTkEZOyvsmBxeTFhj52ZxHP4CB1qbv4vHFw4Oe5DhkpOIxrgs
	6Fuw1cumNTtnfopTU6YmAgIG2I+TdK0hRvt5zE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7380A45CDA;
	Wed, 13 Aug 2025 13:33:59 -0400 (EDT)
Date: Wed, 13 Aug 2025 10:33:59 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
In-Reply-To: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Message-ID: <4335043f-7b4c-4147-65e6-de0199da413f@jdrake.com>
References: <MA0P287MB308276F1ACA00942D9BEAE6D9F22A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 5 Aug 2025, Thirumalai Nagalingam wrote:

> Hi all,
>
> This patch adds support for the `fsqrt` instruction on AArch64 platforms
> in the `__FLT_ABI(sqrt)` implementation.

This looks OK as far as it goes, but I have a few thoughts.

From the comments, it appears this code originally came from mingw-w64.
Their current version of this code has aarch64 implementations.  The
difference with this one is they have a version for float as well as
double.  The versions here seem to only be used for long double (which on
aarch64 is the same as double).

Given that long double is the same as double on aarch64, might it make
sense to redirect/alias the long double names to the double
implementations in the def file (cygwin.din) on aarch64, rather than
providing two different implementations (one in newlib for double and one
in this cygwin/math directory for long double)?  It seems like that's
asking for subtle discrepancies between the implementations.  I'm not
seeing any obvious preprocesor-like operations in gendef (mingw-w64 uses
cpp to preprocess .def.in => .def files for arch-specific #ifdefs) so
maybe this would be more complicated.


>
> In-lined Patch:
>
> From aee895b4b7c4045dea64d1206731dc01d29c155c Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> Date: Wed, 23 Jul 2025 00:37:09 -0700
> Subject: [PATCH] Cygwin: math: Add AArch64 support for sqrt()
>
> Extend `__FLT_ABI(sqrt)` implementation to support AArch64 using the
> `fsqrt` instruction for double-precision floating point values.
> This addition enables square root computation on 64-bit ARM platforms
> improving compatibility and performance.
>
> Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> ---
>  winsup/cygwin/math/sqrt.def.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/winsup/cygwin/math/sqrt.def.h b/winsup/cygwin/math/sqrt.def.h
> index 3d1a00908..598614d3a 100644
> --- a/winsup/cygwin/math/sqrt.def.h
> +++ b/winsup/cygwin/math/sqrt.def.h
> @@ -89,6 +89,8 @@ __FLT_ABI (sqrt) (__FLT_TYPE x)
>    __fsqrt_internal(x);
>  #elif defined(_X86_) || defined(__i386__) || defined(_AMD64_) || defined(__x86_64__)
>    asm volatile ("fsqrt" : "=t" (res) : "0" (x));
> +#elif defined(__aarch64__)
> +  asm volatile ("fsqrt %d0, %d1" : "=w"(res) : "w"(x));
>  #else
>  #error Not supported on your platform yet
>  #endif
> --
> 2.49.0.windows.1
>
> Thanks,
> Thirumalai Nagalingam
>
>
>

