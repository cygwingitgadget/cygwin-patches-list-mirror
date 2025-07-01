Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C27B4385C6DD
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 20:10:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C27B4385C6DD
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C27B4385C6DD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751400623; cv=none;
	b=utzaKZkfPQM8To/aqEudWDWl3A0Q+A9xo0knD6+KATWw1ahWqPjATFk08ZjsagwGb2Oh4vRqDVnp56JfdS/IYj8kRy/QH/zvPhSkBPjOvUXr3yfllXgqJaXfaRNwMg4xHSEdsvQXOedph7UNjjEAumkaG1RHP9/klurFPmbVDIw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751400623; c=relaxed/simple;
	bh=bc86wzh4jPtsCOFnbH6atPvx3QZKcIUMEL8soFmQxs0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=S1qkMx6zq2nzB9dStVlF7wkNdZLOijtiCMf5cBhk5O2rIDHolnGNzrxvWk0fV3BHGajvUAcp9i3lEUbYYz3NmydJgWHUTk9G/WMlEJs3dNAUEJJPI2CybNFmgR6BgFraoaddwWcCAc+Huasv7nbaFQxhQn5/PE7rWUxiKSqSYEU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C27B4385C6DD
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=kfd579b2
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 68D1A45CB2;
	Tue, 01 Jul 2025 16:10:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=8GCXiI61ItDTLAvY5YJ8mGm/LfM=; b=kfd57
	9b2rvwfkvBULhUY/HwNAeTB4/P9a68SLdXQ0roCdQdlqVrFQkWrAherRnOovUs4+
	tgFDDDc6PvJQfErDjF5rVpJaozJuT6WqtmdGMLMSkIWkbImNWzQv7u7M0KwCjwS4
	l2tjqNByWytle0fD+YFZ2Dvc8Hsmd59vHkwcu8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4DA8F45CA7;
	Tue, 01 Jul 2025 16:10:23 -0400 (EDT)
Date: Tue, 1 Jul 2025 13:10:23 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2] Aarch64: Optimize pthread_wrapper by eliminating x19
 and streamlining register usage
In-Reply-To:  <MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Message-ID: <4791450a-011a-9c61-da51-93b1e54a4ba4@jdrake.com>
References: <MA0P287MB3082799B10054C7B9C07F51F9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM> <01c32140-1dd2-de2a-4d86-a74fca7af70c@jdrake.com>  <MA0P287MB3082CA8A50FDA8CBFEA81A0B9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 1 Jul 2025, Thirumalai Nagalingam wrote:

> Hi Jeremy,
>
> Please find this revised version of the previous patch.
> The main issue being addressed is a segfault caused by accessing `wrapper_arg` on the stack after it had been deallocated by VirtualFree.
> This resulted in invalid memory access during thread startup on AArch64. In this version, the thread `func` and `arg` are loaded before the stack is freed, stored in callee-saved registers, and restored before calling the thread func.
>
> Commit message has been updated accordingly and wrapped at 72 characters with trailer. Thanks for the feedback!

Pushed, thanks

>
> In-Lined patch:
>
> From 53215b09e6a19c9493fa5fa58d91a82f6d51e1b2 Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> Date: Tue, 1 Jul 2025 18:17:24 +0000
> Subject: [PATCH] Cygwin: Aarch64: optimize pthread_wrapper register usage
>
> This patch resolves issues related to unsafe access to deallocated
> stack memory in the pthread wrapper for AArch64.
>
> Key changes:
> - Removed use of x19 by directly loading the thread function and
>   argument using LDP from [WRAPPER_ARG], freeing one register.
> - Stored thread function and argument in x20 and x21 before
>   VirtualFree to preserve them across calls.
> - Used x1 as a temporary register to load the stack base,
>   subtract CYGTLS, and update SP.
> - Moved the thread argument back into x0 after VirtualFree and
>   before calling the thread function.
>
> Earlier, `wrapper_arg` lived on the stack, which was freed via
> `VirtualFree`, risking segfaults on later access. Now, the thread
> `func` and `arg` are loaded before the stack is freed, stored in
> callee-saved registers, and restored to `x0` before calling the
> thread function.
>
> Fixes: f4ba145056db ("Aarch64: Add inline assembly pthread wrapper")
> Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> ---
>  winsup/cygwin/create_posix_thread.cc | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_posix_thread.cc
> index 592aaf1a5..17bb607f7 100644
> --- a/winsup/cygwin/create_posix_thread.cc
> +++ b/winsup/cygwin/create_posix_thread.cc
> @@ -103,18 +103,19 @@ pthread_wrapper (PVOID arg)
>    /* Sets up a new thread stack, frees the original OS stack,
>     * and calls the thread function with its arg using AArch64 ABI. */
>    __asm__ __volatile__ ("\n\
> -	   mov     x19, %[WRAPPER_ARG]  // x19 = &wrapper_arg              \n\
> -	   ldp     x0, x10, [x19, #16]  // x0 = stackaddr, x10 = stackbase \n\
> -	   sub     sp, x10, %[CYGTLS]   // sp = stackbase - (CYGTLS)       \n\
> -	   mov     fp, xzr              // clear frame pointer (x29)       \n\
> -	   mov     x1, xzr              // x1 = 0 (dwSize)                 \n\
> -	   mov     x2, #0x8000          // x2 = MEM_RELEASE                \n\
> -	   bl      VirtualFree          // free original stack             \n\
> -	   ldp     x19, x0, [x19]       // x19 = func, x0 = arg            \n\
> -	   blr     x19                  // call thread function            \n"
> +	   ldp     x20, x21, [%[WRAPPER_ARG]]    // x20 = thread func, x21 = thread arg \n\
> +	   ldp     x0, x1, [%[WRAPPER_ARG], #16] // x0 = stackaddr, x1 = stackbase	\n\
> +	   sub     sp, x1, %[CYGTLS]  		 // sp = stackbase - (CYGTLS)    	\n\
> +	   mov     fp, xzr              	 // clear frame pointer (x29)    	\n\
> +						 // x0 already has stackaddr		\n\
> +	   mov     x1, xzr              	 // x1 = 0 (dwSize)              	\n\
> +	   mov     x2, #0x8000          	 // x2 = MEM_RELEASE             	\n\
> +	   bl      VirtualFree          	 // free original stack          	\n\
> +	   mov     x0, x21  			 // Move arg into x0			\n\
> +	   blr     x20                  	 // call thread function         	\n"
>  	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
>  	       [CYGTLS] "r" (__CYGTLS_PADSIZE__)
> -	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
> +	   : "x0", "x1", "x2", "x20", "x21", "x29", "memory");
>  #else
>  #error unimplemented for this target
>  #endif
>

