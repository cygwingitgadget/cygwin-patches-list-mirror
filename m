Return-Path: <SRS0=iniK=2Q=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 23F053858012
	for <cygwin-patches@cygwin.com>; Mon,  4 Aug 2025 18:07:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23F053858012
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23F053858012
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1754330843; cv=none;
	b=ZnH7hcy95dizDYh2lgP50qMWA4igepSBDWUvtY3p3ppshlygWvR6hn3js8qNohAx/AD4l2TLuFtM2tiNF46fS/pAtALYsTBDJ4ZIJ3nwLsdsas4sSC5TX4wBKDs1YfKXUZfpYPDOphfgt6QF7adQn9tdhNktQYwWQsKOSm2d3n8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754330843; c=relaxed/simple;
	bh=JRR8fEnwkoytg/hzS2foQ7o3JN/2XYcIlSCjoX32SHA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=bxZqW5cgUomdKAG7EMIFbZasR5LjdCM7taXHo/wMzf3U1CYGCqHNuMSafoZAStLaPMi5aTKJUpeD4T9GJyYnMkLolOXw+9dl0v4QxCjuzzVm8FKX/ZVpQ05VIpeA7FIrnOT98iBe61+rH9agJohZjjNpNNjO5Er5DXCvHnl/Wus=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23F053858012
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=F4Bpbgsp
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2545145CC5
	for <cygwin-patches@cygwin.com>; Mon, 04 Aug 2025 14:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=emrMp/nP4vxLL5MmhNrcw5JZPGM=; b=F4Bpb
	gspXUSRtGzAw+ou+Qbimhz50o8+2/IZ8Okp9Z6IcNte9sMui0oBrBAuXCfim8UWF
	7UslwG2xmNV6ScJatwTiqEARma5gwnfCz1qFsNhcHzf63NFi/ZYhlcd8m0IzLGhG
	ljDuwRoihGohmB7L33QLSBOUQRWdou8IZwsrGY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0DB5F45C0C
	for <cygwin-patches@cygwin.com>; Mon, 04 Aug 2025 14:07:22 -0400 (EDT)
Date: Mon, 4 Aug 2025 11:07:20 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: add api version check to c++ malloc struct
 override.
In-Reply-To: <aJBwy4ScyIQPS5kY@calimero.vinschen.de>
Message-ID: <e2c92437-eec7-c7f7-5eae-3500e574bd78@jdrake.com>
References: <ff5e8cb0-205b-4d08-7eba-51f112e9619c@jdrake.com> <aI42aRxXOsYFOzpq@calimero.vinschen.de> <4f3bd8e1-b32c-9e9e-bc94-5dc0d0bd52a9@jdrake.com> <aI5Va0_O8rg0VCbh@calimero.vinschen.de> <72ca7654-451c-b8a0-dfd9-f2f82a63fc6c@jdrake.com>
 <aJBwy4ScyIQPS5kY@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 4 Aug 2025, Corinna Vinschen wrote:

> On Aug  2 11:18, Jeremy Drake via Cygwin-patches wrote:
> > This prevents memory corruption if a newer app or dll is used with an
> > older cygwin dll.  This is an unsupported scenario, but it's still a
> > good idea to avoid corrupting memory if possible.
> >
> > Fixes: 7d5c55faa1 ("Cygwin: add wrappers for newer new/delete overloads")
> > Co-authored-by: Corinna Vinschen <corinna@vinschen.de>
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> >  winsup/cygwin/globals.cc                 |  4 +--
> >  winsup/cygwin/include/cygwin/version.h   |  3 ++
> >  winsup/cygwin/lib/_cygwin_crt0_common.cc | 38 +++++++++++++-----------
> >  3 files changed, 26 insertions(+), 19 deletions(-)
>
> LGTM, please push.

Pushed.

> Now for the question if we should keep this with 3.7, or if it makes
> sense to backport to the 3.6 branch.
>
> I'm not sure.
>
> Theoretically this change doesn't change anything as long as libstdc++
> and gcc didn't catch up.  So it's no functional change for existing
> apps, but it would prepare newly build apps to the new compiler and
> libstdc++ lib builds.
>
> OTOH, as long as it's only in the non-released build, we have still time
> to fix things.  The fixes necessary due to introducing this right with a
> bug in 1.7.0-49 were not much fun.  It would be great if we already had
> a gcc/libstdc++ build to test against before a release...
>
> What do you think?

My gut feeling is that this is a "major version"-type change.  The missing
export failures on downgrade and the api version bump (which iirc would
conflict if backported to 3.6, I think there was another api version
before this on 3.7 that is not in 3.6).

For testing, I have
https://github.com/jeremyd2019/cygwin/releases/tag/cxx-test2 which has:

cygstdc++-6.{dll,dbg} built with gcc-13.4.0-1.src.patch adding wrap
arguments.

newwrappers.spec which can be used with "g++ -specs newwrappers.spec ..."

I think you can actually
cp newwrappers.spec /usr/lib/gcc/x86_64-pc-cygwin/specs
to have it used by default.

testnew.cpp where I was messing around with this, nothing really
groundbreaking.

