Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 6882C382C0A5
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 18:35:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6882C382C0A5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6882C382C0A5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750185314; cv=none;
	b=mF6iauRTqrBhw0h5whpzyJHKfKmcA01LZlo3Ur6fyxQh9xd+xNU9k49iSPtxYr/KiiyXegLmWsHbRXVF1B8+T91ALCYQrk8vUk8GNifcU+4FDHjqM5Z/JU21awvnrMk6VPajziXwgGBm18W6hImuPG9IxO6/OkcyFXT9909AwRY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750185314; c=relaxed/simple;
	bh=aMivbkAJyXvZpWQuiaMXSwLsxA4nR6HdNKSAyveroBo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Cb7y3wEySH6Z7+FP+mLUQIZyaZHV65PmLw6e0Gi0MjFS5EKRNJKUvSg7ULliiRQQ1tc85SLAn8Rvsc2Eli1mUhcElQxfrWW6eCCEtmzvLAOWAORwVT0wT53RMk2LsuXaNkc8oJIFOfUWAvMnFaAsxlfzxIpmNlnj3at0cF5clX4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6882C382C0A5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=vK0/SLog
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 28CAA45D53
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 14:35:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=4iOWU5PI5N/ZOLhP/nCUvHkmelk=; b=vK0/S
	Log8Y7BFmVFL6XUjtREOR3KlutjWsk1PO4Xmh4M/13qVraTED/+/6BrpRWLQc6gq
	qwq8rPqm/TFrnjpV5xGvFbl4Ubsjx4flHBSobHIxq/qapg4c1ainTO/CupHMi2tl
	W/JsuotFXwFus51Agf5crShKBBLLHXweu606Xs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0CB8445D51
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 14:35:14 -0400 (EDT)
Date: Tue, 17 Jun 2025 11:35:13 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: make pthread initializer macros constinit
 compliant
In-Reply-To: <aFGyoVdstMJOjEBD@calimero.vinschen.de>
Message-ID: <b668190b-65c4-6c0a-4188-39733ce2ab49@jdrake.com>
References: <1277a22d-9beb-52b3-c9ea-7980f54fb84b@jdrake.com> <9f2971ca-114a-cfec-646a-a32eabfc3ac3@jdrake.com> <aFFNnpI5eBgSl805@calimero.vinschen.de> <413d1875-ed41-9ad0-3954-4df6bae666e7@jdrake.com> <aFGyoVdstMJOjEBD@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

> On Jun 17 10:21, Jeremy Drake via Cygwin-patches wrote:
> > The pthread macros were previously casts of integers to pointers, which
> > would always be full absolute pointers.  This change is making them actual
> > symbols which the linker fills in with absolute addresses.  This would be
> > out of range of a 32-bit rip-relative relocation in cases where the image
> > base is >4GB.
> >
> > This is really gross, as I said, but was the only way I came up with to
> > make them satisfy constinit's restrictions in clang (and the standard, it
> > seems GCC allows things that are explicitly disallowed by the standard).
>
> Ok, but then I'm still puzzled about the code.
>
> First of all, shouldn't the new symbols get exported explicitly via
> cygwin.din?

No, as i said they can't be used from the DLL anyway.  I included them in
libcygwin.a (LIB_FILES) for external users, and in the dll (DLL_FILES) for
internal uses.

> Second, I'm puzzeling over the #if expression (cut for a simple example):
>
>   #if !defined(__INSIDE_CYGWIN__) || !defined(__cplusplus)
>   /* use symbols */
>   #else
>   /* use const int cast to pointer */
>   #endif
>
> So this is a problem in terms of constinit.  Constinit is a C++20
> expression.  But the condition will only define PTHREAD_...  using the
> symbols if this is either outside Cygwin, or if the Cygwin code is NOT
> C++.
>
> The usage inside Cygwin seems upside down to me.  Shouldn't it use the
> symbols in C++ code but not in plain C?  Or am I misunderstanding the
> condition entirely?

The reason I kept the old cast-to-pointer path inside Cygwin C++ code is
that that case triggered the "relocation truncated to fit" error.  Also,
that matches the condition inside sys/_pthreadtypes.h to cast to a class
pointer instead of a struct pointer.
>
> > Somewhat surprising to me is that clang also disallows using the address
> > of a dllimported extern variable in constinit, so we couldn't even
> > dllexport "magic" objects from the DLL whose addresses could be compared
> > against instead of (pthread_mutex_t)19 and such.
>
> We also have the choice to export the symbols from libcygwin.a, see the
> files in LIB_FILES in Makefile.am.  Would that allow clang to use them
> in constinit?  Theoretically we could also define them in crt0.o, but
> this looks too much like just another hack...

Yes, that's what I did...
