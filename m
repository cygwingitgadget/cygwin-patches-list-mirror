Return-Path: <SRS0=WO2z=WR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 37DE03858D29
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 01:54:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 37DE03858D29
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 37DE03858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743299663; cv=none;
	b=YtNzaJuNzCsovTuMFgtnKpxQn3eJUa7waSyF9aAVO93YWwcoAd5d0aON43V60yS10StV8V05+wtZxYJ8drDajw6N+UKlArxG7mrIBXGFzSGrDbdBkaJuPGjhkVJGnbW466bBch3UldAERqGVzGQqwuOS97n8Mn9Cqkki1lLHFWY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743299663; c=relaxed/simple;
	bh=OriQ2KnKuFPg/Ia8BgBCK1hBvDHJLtgx7QvL908NTmg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=X3/rzusN7eUca3PK4V9kh7aCSzjgzWSRGlGC8TERg6+snIcrdnbbDMNx2oBQaqGzvAKbcTMoqXCTIclK01DgJmxhvZFIg+X6bCggQWkTHqpvZWvhjBmpBhQIruPrhhrGPDiUMsnuTGXxHRMPdE5uhc+A7GW6eSYbXdGviiqqdnY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 37DE03858D29
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=yHuCuFOZ
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9A35145C92
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 21:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=fWR+u
	Wcc1Hq5Det9kpjP18xMkFw=; b=yHuCuFOZvJwRGivptIlsj20Dw7kM8EAeogXkT
	ws18HkJw4ErdV3CT0Mq6KqF7MZ7wi6pBFZ/LUiMIm4WBxdcFnPQg7W2qRKj1XlsL
	eZZ/JlbAGPucx3R8rjczca7ljwBHBc8bztuG/x6dWm0LQO5sCu4iolfSP5SykNLo
	UHPVOo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 830B545C8A
	for <cygwin-patches@cygwin.com>; Sat, 29 Mar 2025 21:54:22 -0400 (EDT)
Date: Sat, 29 Mar 2025 18:54:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v4:
fixes x86_64-on-aarch64 on Windows 11 22000.  I'm sending patch 5
only since 1-4 are identical, but I can send them again if necessary.

Jeremy Drake (5):
  Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
  Cygwin: vendor libudis86 1.7.2/libudis86
  Cygwin: patch libudis86 to build as part of Cygwin
  Cygwin: use udis86 to find fast cwd pointer on x64
  Cygwin: add find_fast_cwd_pointer_aarch64.

 winsup/cygwin/Makefile.am        |   14 +-
 winsup/cygwin/aarch64/fastcwd.cc |  207 +
 winsup/cygwin/path.cc            |  145 +-
 winsup/cygwin/udis86/decode.c    | 1113 ++++
 winsup/cygwin/udis86/decode.h    |  195 +
 winsup/cygwin/udis86/extern.h    |  109 +
 winsup/cygwin/udis86/itab.c      | 8404 ++++++++++++++++++++++++++++++
 winsup/cygwin/udis86/itab.h      |  680 +++
 winsup/cygwin/udis86/types.h     |  260 +
 winsup/cygwin/udis86/udint.h     |   91 +
 winsup/cygwin/udis86/udis86.c    |  464 ++
 winsup/cygwin/x86_64/fastcwd.cc  |  200 +
 12 files changed, 11759 insertions(+), 123 deletions(-)
 create mode 100644 winsup/cygwin/aarch64/fastcwd.cc
 create mode 100644 winsup/cygwin/udis86/decode.c
 create mode 100644 winsup/cygwin/udis86/decode.h
 create mode 100644 winsup/cygwin/udis86/extern.h
 create mode 100644 winsup/cygwin/udis86/itab.c
 create mode 100644 winsup/cygwin/udis86/itab.h
 create mode 100644 winsup/cygwin/udis86/types.h
 create mode 100644 winsup/cygwin/udis86/udint.h
 create mode 100644 winsup/cygwin/udis86/udis86.c
 create mode 100644 winsup/cygwin/x86_64/fastcwd.cc

Range-diff against v3:
1:  a1c9f722d7 = 1:  a1c9f722d7 Cygwin: factor out find_fast_cwd_pointer to arch-specific file.
2:  1c290dbc53 = 2:  1c290dbc53 Cygwin: vendor libudis86 1.7.2/libudis86
3:  bd2dca35eb = 3:  bd2dca35eb Cygwin: patch libudis86 to build as part of Cygwin
4:  140a61c9e1 = 4:  140a61c9e1 Cygwin: use udis86 to find fast cwd pointer on x64
5:  87f2bcf895 ! 5:  d55f8f3efa Cygwin: add find_fast_cwd_pointer_aarch64.
    @@ winsup/cygwin/aarch64/fastcwd.cc (new)
     +#if defined (__aarch64__)
     +  return proc;
     +#else
    -+#if defined(__i386__)
    ++#if defined (__i386__)
     +  static const BYTE thunk[] = "\x8b\xff\x55\x8b\xec\x5d\x90\xe9";
    -+#elif defined(__x86_64__)
    ++  static const BYTE thunk2[0];
    ++#elif defined (__x86_64__)
     +  /* see
     +     https://learn.microsoft.com/en-us/windows/arm/arm64ec-abi#fast-forward-sequences */
     +  static const BYTE thunk[] = "\x48\x8b\xc4\x48\x89\x58\x20\x55\x5d\xe9";
    ++  /* on windows 11 22000 the thunk is different than documented on that page */
    ++  static const BYTE thunk2[] = "\x48\x8b\xff\x55\x48\x8b\xec\x5d\x90\xe9";
     +#else
     +#error "Unhandled architecture for thunk detection"
     +#endif
    -+  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0)
    ++  if (memcmp (proc, thunk, sizeof (thunk) - 1) == 0 ||
    ++     (sizeof(thunk2) && memcmp (proc, thunk2, sizeof (thunk2) - 1) == 0))
     +    {
     +      proc += sizeof (thunk) - 1;
     +      proc += 4 + *(const int32_t *) proc;
-- 
2.48.1.windows.1

