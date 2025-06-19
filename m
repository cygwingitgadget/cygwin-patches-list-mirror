Return-Path: <SRS0=mUBA=ZC=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 9BDF4388B06B
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 17:41:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9BDF4388B06B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9BDF4388B06B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750354892; cv=none;
	b=oYz7kAlRRVimfsuqPcgwyj6k4jEzX+fVD8eFKpPv8XjZ8mcDmnSOsjB1YknxbtDq3DyY9TJpaYCQExrE7TPphzYTfIo2P6DlZm2WfF7nwWS9YiqXYUhhBSmZvtu5u5HOxqsFHX3w9C2PA9Kl4u/AiaKAbc3Q5ZKwkTrSl8uygr8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750354892; c=relaxed/simple;
	bh=o3YT4bMRf61R3BM4sCPd6GycUOBqhpvHxnB+ZPe2p6A=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=XcfeR867oQnBY4MG6rNdnvZexpfxpkMpDYCQKG0xZhzJdEJ9okmxria1fdX9i3iSwJh7XctJuP/HRMeLHbd75H9k57DYR3x3PP25ib1fwc4JFixpY91U07FOA4v5c27TmjhISnNhmEa8sM+rI67e2NxTT0SOiGkyI4310vS0Qm8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9BDF4388B06B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=PRHr1uxW
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7802E45D04;
	Thu, 19 Jun 2025 13:41:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=WyirSRnStQF/kqc3ygn1FfRNrN0=; b=PRHr1
	uxWYHWz30yJtyhPUPEDKbyjCMUVPxo1HDZ1b2yJPFTf2AsDJfRZU6PXcuPJPd0LW
	Nks3+oSNAE3LeWklGCr7lg+VMwsPNVzNwkQJYVuaa7w52GiFAqIOflqfIawoTJPI
	+ldpj7ZbHTTEEYfi37q3bFOaU8Q5cB2BBnfKMQ=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 73AD045CC3;
	Thu, 19 Jun 2025 13:41:32 -0400 (EDT)
Date: Thu, 19 Jun 2025 10:41:32 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3] Cygwin: implement spinlock pause for AArch64
In-Reply-To:  <DB9PR83MB09234EABDFC5DAB5A16291A7927DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <56deae78-e295-b3af-68d6-fdfdcb0b1d43@jdrake.com>
References: <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca> <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com> <7329e318-02fc-40d0-8f06-7c5ef8642182@SystematicSW.ab.ca>
 <DB9PR83MB092313132E1B9E5C8A8F91B79270A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <2d42e239-1ed3-95ab-81d2-f310472e76c9@jdrake.com>  <DB9PR83MB09234EABDFC5DAB5A16291A7927DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-345686430-1750354892=:11368"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-345686430-1750354892=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Jun 2025, Radek Barton wrote:

> Hello.
>
> Sending new version with Signed-off-by header.
>
> Radek
>
> ---
> From 2726b40ae1b41586e410105d5fd5149f8e7f6b92 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Thu, 5 Jun 2025 12:41:37 +0200
> Subject: [PATCH v3] Cygwin: implement spinlock pause for AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/local_includes/cygtls.h           | 5 ++++-
>  winsup/cygwin/thread.cc                         | 5 +++++
>  winsup/testsuite/winsup.api/pthread/cpu_relax.h | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/loca=
l_includes/cygtls.h
> index 615361d3f..31cadd51a 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -243,8 +243,11 @@ public: /* Do NOT remove this public: line, it's a=
 marker for gentls_offsets. */
>    {
>      while (InterlockedExchange (&stacklock, 1))
>        {
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82__asm__ ("pause");
> +#elif defined(__aarch64__)
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82__asm__ ("dmb ishst\n"
> +                 "yield");
>  #else
>  #error unimplemented for this target
>  #endif
> diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
> index fea6079b8..510e2be93 100644
> --- a/winsup/cygwin/thread.cc
> +++ b/winsup/cygwin/thread.cc
> @@ -1968,7 +1968,12 @@ pthread_spinlock::lock ()
>        else if (spins < FAST_SPINS_LIMIT)
>          {
>            ++spins;
> +#if defined(__x86_64__)
>            __asm__ volatile ("pause":::);
> +#elif defined(__aarch64__)
> +          __asm__ volatile ("dmb ishst\n"
> +                            "yield":::);
> +#endif
>          }
>        else
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82{
> diff --git a/winsup/testsuite/winsup.api/pthread/cpu_relax.h b/winsup/t=
estsuite/winsup.api/pthread/cpu_relax.h
> index 1936dc5f4..71cec0b2b 100644
> --- a/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> +++ b/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> @@ -4,7 +4,8 @@
>  #if defined(__x86_64__) || defined(__i386__)  // Check for x86 archite=
ctures
>     #define CPU_RELAX() __asm__ volatile ("pause" :::)
>  #elif defined(__aarch64__) || defined(__arm__)  // Check for ARM archi=
tectures
> -   #define CPU_RELAX() __asm__ volatile ("yield" :::)
> +   #define CPU_RELAX() __asm__ volatile ("dmb ishst \
> +                                          yield" :::)
>  #else
>     #error unimplemented for this target
>  #endif
> --
> 2.49.0.vfs.0.4
>

Pushed, thanks
--15599321219072-345686430-1750354892=:11368--
