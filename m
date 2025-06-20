Return-Path: <SRS0=4oHy=ZD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5F5CE388C2C5
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 22:23:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F5CE388C2C5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F5CE388C2C5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750458190; cv=none;
	b=VRWztklKE2/Yr5VS8lGwUJc6/3TqEqI/26Rh4CNlKx1hA2RKWj6DLn5f19f3wBoNB2E1a5elyiah7MlvuKQXzAk7kGrmYq+2IRmT5m0qiWVP40rZkvH8+LjQ709NBKQ2JNUIwwe5uj9HHWABCm0/Q6CLE5zAXMWQnFPpPwueJlU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750458190; c=relaxed/simple;
	bh=21BtHWK2xyk3OXWI8XwNzT5MhgB0SrEM3D61qU3CLzI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=aycxUDJ6fBvPqsqdNx/iqyFPnoVsFAlkUfK+O7zpkGDFmKHlOZ+hB/jn3XuizMTjCCvjupGXCy9dWuBW/0DidFtYJqyoYzY5oku0A5GVUZr6TAwVmbrh20IoZr7SBWFHCYMkQXw9bzU5kFIeATntrijiLXm0ilTC+cAQeZjLKbs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F5CE388C2C5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=DWf5sHtn
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id E1C8F45D09;
	Fri, 20 Jun 2025 18:23:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=sSNR6SO4pKCTcwE4sztyW71jmno=; b=DWf5s
	Htn6BCM4Qpse57Rc1qaITkMuv1vEGdo+831cHiHReRMDm0zZ9jBT6rH34n6V8b/a
	7SwRSmYlSIBJ56GmAnbji4F9g8hIvf2D6m1QSYbtXRKiNneh6ZBmTNVzYX5aHzoB
	Bl3BhfSqOkO4XpL8v5V5Wm9/h4k0iJv8+6yVjI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id DCFD845D08;
	Fri, 20 Jun 2025 18:23:09 -0400 (EDT)
Date: Fri, 20 Jun 2025 15:23:09 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V4] Cygwin: Aarch64: Add inline assembly pthread
 wrapper
In-Reply-To: <dfd54268-c6f0-bd3e-b0b2-20e542bae4fc@jdrake.com>
Message-ID: <e08b593f-ad2a-a0ef-6ea7-2571b28cc443@jdrake.com>
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM> <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com> <MA0P287MB30826BECED54F4DFB50996C89F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM> <e898c913-6728-8c0a-3f06-4481c1551853@jdrake.com>
 <MA0P287MB30828CF024D946D3F575279B9F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM> <dfd54268-c6f0-bd3e-b0b2-20e542bae4fc@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 19 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> On Thu, 19 Jun 2025, Thirumalai Nagalingam wrote:
>
> > Hi Jeremy,
> >
> > Thanks again for the quick follow-up. `ldr` is the correct choice here, it's a nice idea for reducing loads.
> > I've updated the patch to use it for loading stackaddr and stackbase.
> > Also added the Signed-off-by line to the commit message as requested.
> >
> > Patch is In-lined below and attached.
> >
> > In-lined patch:
> >
> > From 609cc27fa50700ab135dff421f08473c29dcb533 Mon Sep 17 00:00:00 2001
> > From: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> > Date: Fri, 20 Jun 2025 02:12:51 +0530
> > Subject: [PATCH] Aarch64: Add inline assembly pthread wrapper
> >
> > This patch adds AArch64-specific inline assembly block for the pthread
> > wrapper used to bootstrap new threads. It sets up the thread stack,
> > adjusts for __CYGTLS_PADSIZE__, releases the original stack via
> > VirtualFree, and invokes the target thread function.
> >
> > Signed-off-by: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
> > ---
> >  winsup/cygwin/create_posix_thread.cc | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/winsup/cygwin/create_posix_thread.cc b/winsup/cygwin/create_posix_thread.cc
> > index 3fcd61707..592aaf1a5 100644
> > --- a/winsup/cygwin/create_posix_thread.cc
> > +++ b/winsup/cygwin/create_posix_thread.cc
> > @@ -75,7 +75,7 @@ pthread_wrapper (PVOID arg)
> >    /* Initialize new _cygtls. */
> >    _my_tls.init_thread (wrapper_arg.stackbase - __CYGTLS_PADSIZE__,
> >  		       (DWORD (*)(void*, void*)) wrapper_arg.func);
> > -#ifdef __x86_64__
> > +#if defined(__x86_64__)
> >    __asm__ ("\n\
> >  	   leaq  %[WRAPPER_ARG], %%rbx	# Load &wrapper_arg into rbx	\n\
> >  	   movq  (%%rbx), %%r12		# Load thread func into r12	\n\
> > @@ -99,6 +99,22 @@ pthread_wrapper (PVOID arg)
> >  	   call  *%%r12			# Call thread func		\n"
> >  	   : : [WRAPPER_ARG] "o" (wrapper_arg),
> >  	       [CYGTLS] "i" (__CYGTLS_PADSIZE__));
> > +#elif defined(__aarch64__)
> > +  /* Sets up a new thread stack, frees the original OS stack,
> > +   * and calls the thread function with its arg using AArch64 ABI. */
> > +  __asm__ __volatile__ ("\n\
> > +	   mov     x19, %[WRAPPER_ARG]  // x19 = &wrapper_arg              \n\
> > +	   ldp     x0, x10, [x19, #16]  // x0 = stackaddr, x10 = stackbase \n\
> > +	   sub     sp, x10, %[CYGTLS]   // sp = stackbase - (CYGTLS)       \n\
> > +	   mov     fp, xzr              // clear frame pointer (x29)       \n\
> > +	   mov     x1, xzr              // x1 = 0 (dwSize)                 \n\
> > +	   mov     x2, #0x8000          // x2 = MEM_RELEASE                \n\
> > +	   bl      VirtualFree          // free original stack             \n\
> > +	   ldp     x19, x0, [x19]       // x19 = func, x0 = arg            \n\
> > +	   blr     x19                  // call thread function            \n"
> > +	   : : [WRAPPER_ARG] "r" (&wrapper_arg),
> > +	       [CYGTLS] "r" (__CYGTLS_PADSIZE__)
> > +	   : "x0", "x1", "x2", "x10", "x19", "x29", "memory");
> >  #else
> >  #error unimplemented for this target
> >  #endif
> >
>
> LGTM.  I'll wait at least a day before pushing in case somebody else has
> any objections.

Pushed now, thanks
