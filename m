Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 51016390EAD4
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 17:26:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 51016390EAD4
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 51016390EAD4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750267613; cv=none;
	b=HIRRKBB03PTXBlwcDi8l+9E1yPnQmQk1GfkBnpzKsaIEtcaE3k9YbWuAdlghkPObYKbrOhOqpcA50YtJen96k33ATyUO8zhIhwVHBRgGpSQBoREC3wov0fOAK1+Di8K/G1v0c1jPf58eDtW7Xl4a/uAMjrSGLZwl4BIuFEaC7Lk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750267613; c=relaxed/simple;
	bh=mkRB9oIgpfwzNmYpMlLJKMizAtoebXGXJYSorNHSO3E=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=GtckaXaU4Sg5pwHsZh4iraeir395hzhLmn02gT6mx5sBaTg1FMSJ+ID8cIIiUh+zgSPaCX74jtiFCLGHOnHU1vHfq2uUtpd8pVsY0yQz8Jvj6T6R1iIs27gTLKsHmETWT+Ndfis2WZ3oHh3r/1HtVa2FeW7mEgYklVDSrN97CZI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 51016390EAD4
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=XX5lOIes
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E657145D3F;
	Wed, 18 Jun 2025 13:26:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=6p3m5ZfUTJOWGa9xKLMzB6xSjok=; b=XX5lO
	IesRHaQpB39WagLZc84mzHAYp29QA7LTScpWdsVny2AuX4IH50WHGR5qT3VkDL0l
	21NNQ236dHbRxtXRuDVSRSOW1JyTbeY8QNBsjRkNgp2ZFqICgHI140UhH1Ys8Y+5
	nv9Fshp+hj0v/ah3lWgMeKTL8KiI9tztSl3buI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E10D145D37;
	Wed, 18 Jun 2025 13:26:52 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:26:52 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: implement spinlock pause for AArch64
In-Reply-To: <DB9PR83MB092313132E1B9E5C8A8F91B79270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <2d42e239-1ed3-95ab-81d2-f310472e76c9@jdrake.com>
References: <DB9PR83MB09237758F38BC0ACB9AAB51B9274A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <c03e5943-d622-4381-8ce1-c85f1ffa3c69@SystematicSW.ab.ca> <e768114d-c2e5-7033-c30d-9991c5982f3b@jdrake.com> <7329e318-02fc-40d0-8f06-7c5ef8642182@SystematicSW.ab.ca>
 <DB9PR83MB092313132E1B9E5C8A8F91B79270A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 16 Jun 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> Thank you for your insights. The patch has ben changed according to your suggestions.
>
> Radek
>
> ---
> From b055fb898c8f09ee1ae598c4c7d85ab2673d7a4c Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Radek=20Barto=C5=88?= <radek.barton@microsoft.com>
> Date: Thu, 5 Jun 2025 12:41:37 +0200
> Subject: [PATCH v2] Cygwin: implement spinlock pause for AArch64
>
> ---
>  winsup/cygwin/local_includes/cygtls.h           | 5 ++++-
>  winsup/cygwin/thread.cc                         | 5 +++++
>  winsup/testsuite/winsup.api/pthread/cpu_relax.h | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/local_includes/cygtls.h
> index 4698352ae..0b8439475 100644
> --- a/winsup/cygwin/local_includes/cygtls.h
> +++ b/winsup/cygwin/local_includes/cygtls.h
> @@ -242,8 +242,11 @@ public: /* Do NOT remove this public: line, it's a marker for gentls_offsets. */
>    {
>      while (InterlockedExchange (&stacklock, 1))
>        {
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>         __asm__ ("pause");
> +#elif defined(__aarch64__)
> +       __asm__ ("dmb ishst\n"
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
>         {
> diff --git a/winsup/testsuite/winsup.api/pthread/cpu_relax.h b/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> index 1936dc5f4..71cec0b2b 100644
> --- a/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> +++ b/winsup/testsuite/winsup.api/pthread/cpu_relax.h
> @@ -4,7 +4,8 @@
>  #if defined(__x86_64__) || defined(__i386__)  // Check for x86 architectures
>     #define CPU_RELAX() __asm__ volatile ("pause" :::)
>  #elif defined(__aarch64__) || defined(__arm__)  // Check for ARM architectures
> -   #define CPU_RELAX() __asm__ volatile ("yield" :::)
> +   #define CPU_RELAX() __asm__ volatile ("dmb ishst \
> +                                          yield" :::)
>  #else
>     #error unimplemented for this target
>  #endif
> --
> 2.49.0.vfs.0.3
>

This LGTM, but you'll need a Signed-off-by trailer at least.
