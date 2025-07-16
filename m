Return-Path: <SRS0=iojS=Z5=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id BBD393858D32
	for <cygwin-patches@cygwin.com>; Wed, 16 Jul 2025 00:45:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BBD393858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BBD393858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752626728; cv=none;
	b=ccr6EMe2usV5+o6rbanWoibeR7QrXMZLZ5UrAOk3PD2vTJ+Xaz3dj7QOKu0aveT5z2kRJ62c0iz95NA/encxjX2T1zLh/+RbQvmhy+7cnnwe9COkNGb1iw4XEmqFDJBYz9kwlLuINix+/Kfno97JdGyZiE07Dvtl12wsuHdMN60=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752626728; c=relaxed/simple;
	bh=itsoj3NYhhYrc4Eao62AhiuA1/8Borfj2S8Xi/1eq2M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZDKFrELXmZYp6c18xK3kAxQrbw7OIxql8TCpy8HAHohLYW6LckFwUB6L1poFKsZcvYzrKWSaxwZsvTafD2GJ45RRT+YuOkEDOQzNpW8D2tqzFtTf8Z7+zdkuRzCznq20WKLpDqjBDrPeMXdWI7WI/Im+ew4GTJKfYG61SzGgXqI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BBD393858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=lgqWGNqD
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7251045C1D
	for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 20:45:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Ytmh09argU7AOR0JGJ9WbjD3TW4=; b=lgqWG
	NqDLkNatu4uJZvMqOoGJT2WV94NPH9HI8ld2jnZHLpQ40lheiCZhDCeDFOnnAo5s
	EOOwkPihIsRFeIaj61lkdinoG7UEb6Ej4noG3B/3L63TrcysiC9jW7elKaUBtwq+
	BLGufL+6GTXGfAu6RJQ78EuBUI8pRObHz9vO9s=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 59F9B45C0C
	for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 20:45:28 -0400 (EDT)
Date: Tue, 15 Jul 2025 17:45:28 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: link cygload with
 --disable-high-entropy-va
In-Reply-To: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>
Message-ID: <04c19697-8144-2b3d-ca7f-bd06e9ffe600@jdrake.com>
References: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Is this OK to push?


On Wed, 9 Jul 2025, Jeremy Drake via Cygwin-patches wrote:

> This is a mingw program meant to demonstrate loading the Cygwin dll in a
> non-Cygwin process, but the Cygwin dll still initializes the cygheap on
> load in that case.  Without --disable-high-entropy-va, Windows may
> occasionally locate the PEB, TEB, and/or stacks in the address space
> that Cygwin tries to reserve for the cygheap, resulting in a failure.
>
> Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/testsuite/mingw/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Makefile.am
> index 25300a15d9..775d617aef 100644
> --- a/winsup/testsuite/mingw/Makefile.am
> +++ b/winsup/testsuite/mingw/Makefile.am
> @@ -23,7 +23,7 @@ cygrun_SOURCES = \
>
>  cygload_SOURCES = \
>  	../winsup.api/cygload.cc
> -cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup
> +cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup -Wl,--disable-high-entropy-va
>
>  winchild_SOURCES = \
>  	../winsup.api/posix_spawn/winchild.c
>

-- 
Although written many years ago, Lady Chatterley's Lover has just been
reissued by the Grove Press, and this pictorial account of the
day-to-day life of an English gamekeeper is full of considerable
interest to outdoor minded readers, as it contains many passages on
pheasant-raising, the apprehending of poachers, ways to control vermin,
and other chores and duties of the professional gamekeeper.
Unfortunately, one is obliged to wade through many pages of extraneous
material in order to discover and savour those sidelights on the
management of a midland shooting estate, and in this reviewer's opinion
the book cannot take the place of J. R. Miller's "Practical
Gamekeeping."
		-- Ed Zern, "Field and Stream" (Nov. 1959)
