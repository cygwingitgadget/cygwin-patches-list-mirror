Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 277E2392409E
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 17:52:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 277E2392409E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 277E2392409E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750269133; cv=none;
	b=mfyhpivjTOfnwRK355TrW15+OTjeygzbhcwMG+2en6STvD5d1s5fnO6Ru4T7Ni8rWpe8ApyMdmoMhEBKG2GO6lewhNRo+KBlJ5k6ShmNwLVPCZQ0UP/G4InxOn0VpN4Q6GqozDkj1cA1kQAzqESMfED3b7lrCAwojEK/gpBW5CI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750269133; c=relaxed/simple;
	bh=ddWzUj/9luKXawt2Ki8nzy4bGAnnBYcuUzAJhP6DbsA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=h6G+WKER3Z7Bk7nzeSGsZ7TOOl9n8kzIsBrwLMR1TgfrgDjHc8scHCXLN796o/qlM29LzyzDhvEg59zpBKi40LBuH9s4/lKUAQBSbZHRJvsE4w5HnuZISqH/OXONGqpYSzL38rkCnQ7nujReDXooWLGGoPwheelcNBh0uZg53Ww=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 277E2392409E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=bNIrWIZa
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id ECF7D45D3F;
	Wed, 18 Jun 2025 13:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=aDme6I0YTg5xs7+C4IbMIfr6YZg=; b=bNIrW
	IZaDsSCPvrpqX0O6GXWjg5ELquxB6bpp8at1PgeMjgGckmvng3HGoR9p1LlTE++t
	KpmRD0EurZ9xZ8zbWu10mebYOng2iTSj/4hvHtrF5H/T5gvvbE0v9NFv6Thso9XE
	yXiq0S8Kkw7m+8s2sRi3sG5fgfnNHHblIK/qyA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CD7AF45D37;
	Wed, 18 Jun 2025 13:52:12 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:52:12 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
In-Reply-To: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
Message-ID: <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 5 Jun 2025, Thirumalai Nagalingam wrote:

> Hello,
>
> Please find my patch attached for review.

Please either send patches via something like git send-email that puts the
patch in the body, or if you can't send patches in that way without some
mail software mangling them, please include the patch in the body of the
email in addition to attaching it, for easier review.

>
> This patch adds AArch64-specific inline assembly block for the pthread
> wrapper used to bootstrap new threads. It sets up the thread stack,
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
> stack via VirtualFree, and invokes the target thread function.
>
> Thanks & regards
> Thirumalai Nagalingam
>


> From c897d7361356c73b5837afa466f78a58520c1e9e Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> Date: Thu, 5 Jun 2025 00:30:48 -0700
> Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper
>
> This patch adds AArch64-specific inline assembly block for the pthread
> wrapper used to bootstrap new threads. It sets up the thread stack,
> adjusts for __CYGTLS_PADSIZE__ and shadow space, releases the original
> stack via VirtualFree, and invokes the target thread function.
> ---
>  winsup/cygwin/create_posix_thread.cc | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_posix_thread.cc
> index 8e06099e4..b1d0cbb43 100644
> --- a/winsup/cygwin/create_posix_thread.cc
> +++ b/winsup/cygwin/create_posix_thread.cc
> @@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
>    /* Initialize new _cygtls. */
>    _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
>  		       (DWORD (*)(void*, void*)) wrapper_arg.func);
> -#ifdef __x86_64__
> +#if defined(__x86_64__)
>    __asm__ ("\n\
>  	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
>  	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
> @@ -99,6 +99,23 @@ pthread_wrapper (PVOID arg)
>  	   call  *%%r12			# Call thread func		\n"
>  	   : : [WRAPPER_ARG] "o" (wrapper_arg),
>  	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
> +#elif defined(__aarch64__)
> +  /* Sets up a new thread stack, frees the original OS stack,
> +   * and calls the thread function with its arg using AArch64 ABI. */
> +  __asm__ __volatile__ ("\n\
> +	   mov     x19, %[WRAPPER_ARG]           // x19 = &wrapper_arg            \n\
> +	   ldr     x10, [x19, #24]               // x10 = wrapper_arg.stackbase   \n\
> +	   sub     sp, x10, %[CYGTLS]            // sp = stackbase - (CYGTLS + 32)\n\
> +	   mov     fp, xzr                       // clear frame pointer (x29)     \n\
> +	   mov     x0, sp                        // x0 = new stack pointer        \n\

This seems wrong.  Shouldn't it be
           mov     x0, [x19, #16]                // x0 = wrapper_arg.stackaddr

> +	   mov     x1, xzr                       // x1 = 0 (dwSize)               \n\
> +	   mov     x2, #0x8000                   // x2 = MEM_RELEASE              \n\
> +	   bl      VirtualFree                   // free original stack           \n\
> +	   ldp     x19, x0, [x19]                // x19 = func, x0 = arg          \n\
> +	   blr     x19                           // call thread function          \n"
> +	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
> +	       [CYGTLS] "r" (__CYGTLS_PADSIZE__ + 32) // add 32 bytes shadow space

I asked this on another patch, but is the 32-byte shadow area actually
part of the aarch64 calling convention, or is this just following what x64
was doing (where it is part of the calling convention)

> +	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.34.1
>
