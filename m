Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 847873854AB7
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 17:23:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 847873854AB7
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 847873854AB7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751390590; cv=none;
	b=XSlDC/WOjTem9tZON0dZLkHy1lqLoBuxweWx0WYqXIOEh4HRaSVlatzljXHzRfVeAKghkcQoRnLiYYSpqPjPfxgi96a3nCAtUpX9Tg2l9eQrRmdyyB872cOMLPKCxrq8RW/EPDlvsKMuEJjVfvEaNw8NRbMrGAQgZH+jI+Z2xs0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751390590; c=relaxed/simple;
	bh=KMYSwGDIj8+A735c25NAtZO3L2qa4jW8Rw0uJqfomi4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=S32FEoHlIk3sKGE2DtO+vv9IY9wxo2hNxhR1rYdoQ1CqQBgX1QwmGo9ANLrJ54zuYyA0bOLuTdToCMU9UeyyeEp/GqRL57yR0xnumxj8XmpPbjz0cXydV/0r/d8SySFRD92MDhxaJtRq4A9KfJJ4Kf2C+SLSl9Ja4x/Nzl8nUWI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 847873854AB7
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=AZ/1oBWi
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5667445CA8;
	Tue, 01 Jul 2025 13:23:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=sW5pJsjFBxTxtXmkUR6S+1CPA3U=; b=AZ/1o
	BWirxo1zLSJ55lYjydQdH8YELTqIKr6oQGSMT0X1j834N5BBKKqRUKrhEO/wv91u
	x7ua9T88MLnmMl78IORNPn00lrRvgP/fo/ala33/hPaOHHG0o7TZm8hALhoLaajn
	cbMPwdZqvrnHKKn07rbcb0Hvxa3RL+4+vLlEkY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3EC0C45C86;
	Tue, 01 Jul 2025 13:23:10 -0400 (EDT)
Date: Tue, 1 Jul 2025 10:23:10 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19
 and streamlining register usage
In-Reply-To: <MA0P287MB3082799B10054C7B9C07F51F9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Message-ID: <01c32140-1dd2-de2a-4d86-a74fca7af70c@jdrake.com>
References: <MA0P287MB3082799B10054C7B9C07F51F9F41A@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 1 Jul 2025, Thirumalai Nagalingam wrote:

> Hi all,
>
> This patch fixes existing issues in my earlier commit
> [https://github.com/cygwin/cygwin/commit/f4ba145056dbe99adf4dbe632bec035e006539f8]
> and optimizes the AArch64 thread startup sequence by eliminating the use
> of register x19 and streamlining register usage. The key modifications
> are detailed in the patch's commit description. These changes improve
> register efficiency while ensuring correct thread argument in register
> `x0` after virtual free call, preventing from any segmentation faults.
> The patch has been tested in our internal AArch64 environment where
> pthread related test cases are now passing as expected.
>
> Inlined Patch:
>
> From e197e39452e542d18812f41ac2a3af2fa172b273 Mon Sep 17 00:00:00 2001
> From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> Date: Tue, 1 Jul 2025 14:46:52 +0530
> Subject: [PATCH] Aarch64: Optimize pthread_wrapper by eliminating x19 and
>  streamlining register usage
>
> - Removed use of x19 by directly loading the thread func and arg using
> LDP from [WRAPPER_ARG], freeing up one additional register
> - Loaded thread function and argument into x20 and x21 before
> VirtualFree to preserve their values across the virtual free call
> - Used x1 as a temporary register to load stack base, subtract CYGTLS,
> and update SP
> - Moved thread argument back into x0 after VirtualFree and before
> calling the thread function
>

So the problem was that the registers used before were ones not required
to be preserved across function calls in the ABI?  Or was it that
wrapper_arg was on the now-freed stack so could not be accessed after the
VirtualFree?  Pleas include that in your commit message.  Also, please
wrap your commit message at 72 characters, prefix the subject/first line
"Cygwin: ", and include the trailer

Fixes: f4ba145056db ("Aarch64: Add inline assembly pthread wrapper")
Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>


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
> -     mov     x19, %[WRAPPER_ARG]  // x19 = &wrapper_arg              \n\
> -     ldp     x0, x10, [x19, #16]  // x0 = stackaddr, x10 = stackbase \n\
> -     sub     sp, x10, %[CYGTLS]   // sp = stackbase - (CYGTLS)       \n\
> -     mov     fp, xzr              // clear frame pointer (x29)       \n\
> -     mov     x1, xzr              // x1 = 0 (dwSize)                 \n\
> -     mov     x2, #0x8000          // x2 = MEM_RELEASE                \n\
> -     bl      VirtualFree          // free original stack             \n\
> -     ldp     x19, x0, [x19]       // x19 = func, x0 = arg            \n\
> -     blr     x19                  // call thread function            \n"
> +     ldp     x20, x21, [%[WRAPPER_ARG]]    // x20 = thread func, x21 = thread arg \n\
> +     ldp     x0, x1, [%[WRAPPER_ARG], #16] // x0 = stackaddr, x1 = stackbase \n\
> +     sub     sp, x1, %[CYGTLS]         // sp = stackbase - (CYGTLS)       \n\
> +     mov     fp, xzr                // clear frame pointer (x29)       \n\
> +                  // x0 already has stackaddr     \n\
> +     mov     x1, xzr                // x1 = 0 (dwSize)                 \n\
> +     mov     x2, #0x8000            // x2 = MEM_RELEASE                \n\
> +     bl      VirtualFree            // free original stack             \n\
> +     mov     x0, x21          // Move arg into x0       \n\
> +     blr     x20                    // call thread function            \n"
>       : : [WRAPPER_ARG] "r" (&wrapper_arg),
>           [CYGTLS] "r" (__CYGTLS_PADSIZE__)
> -     : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
> +     : "x0", "x1", "x2", "x20", "x21", "x29", "memory");
>  #else
>  #error unimplemented for this target
>  #endif
> --
> 2.49.0.windows.1
>
> Thanks,
> Thirumalai Nagalingam
>

-- 
"I'd love to go out with you, but there are important world issues that
need worrying about."
