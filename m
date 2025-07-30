Return-Path: <SRS0=BSe6=2L=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 96D693858CD1
	for <cygwin-patches@cygwin.com>; Wed, 30 Jul 2025 18:27:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 96D693858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 96D693858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753900062; cv=none;
	b=sy9KOZFUP8MT0bTKC2v8HPMKn6OMpwrWX+FoqhbmQ9RJgRh4z9WYRw4Ik3Iu/BLjpw8hu1lsLO7faJD7fohrEdft8Zlk5GurU7paL3xMHIN0+rhx/uXU+/ll4spcxGe1K2+6YF5L65G8AVkthXFIlcXUvZuRx8blnxF1p+Qa7p0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753900062; c=relaxed/simple;
	bh=MPhA/VMNLaTM/TS4RtLlwtwT0tIG/J7KfYzwVx9M86k=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hKVUZtkCWlzUrVKh0ns+9vRJFLgbnlG0BmagO+A9qdYogkXbrsWOEPBPZEFoBLwp9pqI4wo7sre4epXkBAMnIRC/h2BcyLVP0hygmom3luk5TQq7rH71KuUSaHHQ0sLc8zIWADEoEqFftyCQ8ioS1tOkgtIx1dW7DcgJD966LnI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96D693858CD1
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=xwUDWDIj
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 50CFD45CD3
	for <cygwin-patches@cygwin.com>; Wed, 30 Jul 2025 14:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=LKCkZcOI6Aw/bs38mSac9ON0qtU=; b=xwUDW
	DIjVMgOcUveAHmHWQVFeQEQG+9cX6nAUw5KwW1b7AG2aLSSSQeRRZxm0cs9zkx5+
	AAgF4+eN3GvkH0nBTgU56iRHxlwz4bPnMSnqUQ/aEMiBvyNv/FzqSW9Cn8Di830o
	psmmi0qUV/3LbFugjb6pVyq2yD0td8t5m6/OPo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3491445CC5
	for <cygwin-patches@cygwin.com>; Wed, 30 Jul 2025 14:27:42 -0400 (EDT)
Date: Wed, 30 Jul 2025 11:27:42 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
In-Reply-To: <aIoOKpzb557bX0cE@calimero.vinschen.de>
Message-ID: <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com>
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com> <aIoOKpzb557bX0cE@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 30 Jul 2025, Corinna Vinschen wrote:

> On Jul 25 16:10, Jeremy Drake via Cygwin-patches wrote:
> > A sized delete (with a std::size_t parameter) was added in C++14 (but
> > doesn't combine with nothrow_t)
> >
> > An aligned new/delete (with a std::align_val_t parameter) was added in
> > C++17, and combinations with the sized delete and nothrow_t variants.
> >
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> > I added #pragma GCC diagnostic ignored "-Wc++17-compat" preemptively to
> > cxx.cc to match what was done with c++14-compat with the one sized delete
> > that was already present (presumably because it broke things when GCC
> > started to emit that instead of the non-sized delete).
> >
> > The default new implementation uses calloc, so I'm not sure if it's
> > expected that the aligned new call memset to zero the returned memory.
> > It'd be easy enough to add if necessary.
> >
> > GCC will need to be updated circa
> > https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/i386/cygwin-w64.h;h=160a290a03d00f6408252f5d8751fea7cd44e1be;hb=HEAD#l27
> > but only after this change is stable because it will cause linker errors
> > if the new __wrap symbols are not exported.
> >
> > Does there need to be a version bump somewhere to make sure a module
> > linked against a new libcygwin.a doesn't run against an old cygwin1.dll,
> > resulting in _cygwin_crt0_common.cc writing too much data to
> > default_cygwin_cxx_malloc?
> >
> >  winsup/cygwin/cxx.cc                      | 120 +++++++++++++++++++++-
> >  winsup/cygwin/cygwin.din                  |  12 +++
> >  winsup/cygwin/lib/_cygwin_crt0_common.cc  |  59 +++++++++++
> >  winsup/cygwin/libstdcxx_wrapper.cc        |  99 ++++++++++++++++++
> >  winsup/cygwin/local_includes/cygwin-cxx.h |  14 +++
> >  5 files changed, 299 insertions(+), 5 deletions(-)
>
> LGTM.  Please push (to main only, at least for now)

Done.  I was figuring this was a 3.7-only change.

I was thinking, in _cygwin_crt0_common.cc where the __cygwin_cxx_malloc
struct is handled, perhaps it could "CONDITIONALLY_OVERRIDE" into the
newu->cxx_malloc struct (from the dll) directly instead of merging into
the local __cygwin_cxx_malloc struct and copying the entire struct over
the dll struct.  This might allow a binary built against a newer
libcygwin.a to not crash (or corrupt memory) if run against an older dll,
as long as the newer C++ new/delete operators were not defined.  The
sticking point would be libstdc++-6.dll once it is rebuilt with the
additional --wrap arguments in GCC, because it would define all the
operators and thus be incompatbile with older dll versions.
