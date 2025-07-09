Return-Path: <SRS0=on3G=ZW=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DCFA8385840C
	for <cygwin-patches@cygwin.com>; Wed,  9 Jul 2025 18:47:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DCFA8385840C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DCFA8385840C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752086846; cv=none;
	b=r5PWtXg9VnM0ra1DIV/ier+hnJbc6oIoR38wfJBSmsOYkmoGtTvxF3df5RMsaAyVVWsPp2zc9kjblSb1M39EoyqUuyoAJPTDYqSFfSeOiAnFB++C/A3lQi55JkxERnCj7J/kJXaSA77tI50CMMdN20Z9eGDCRtjbf5RG2IM+J38=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752086846; c=relaxed/simple;
	bh=TE8NhfuL39+v/YwM3aQydKPdiiX600W+JN6bUvhc5Cc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xnIqVwTM8pqAnkyva6F1n4wD2dL7dIJl5ujTzcnJ8/4GIDmC3elv6rdWJqSut65Lsshd1SqiPv3yi2uu7UkxLzGYLLUDQN0qtgkCcpZS5JZYb0Bpv3Gc1tNkkgrl/nS8CMmnMP7ha+4cinJSiIYZJ9SYCO+fWZi2YW7nc5j92g0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DCFA8385840C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=VOMC0xBo
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B420A45CCC
	for <cygwin-patches@cygwin.com>; Wed, 09 Jul 2025 14:47:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=O34tx
	xpx4gR4FcY1MmU5XREmwd8=; b=VOMC0xBosdgVAuWRTbk2ytR2y4YtfN9YFApaE
	5VdKNA3Ts34QVBD86nEh3ZarcXoMfCgHc6bYmKBhVRK+q2oK/TdT2GADG4J7Wb3p
	D9PYsWEdSmnFbpnK0RwVkph09bg1Q3hj/MdnlkQ/stfPJ/4bYtMsKqxBruYJLtia
	pKL1FA=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id AE3E345CC5
	for <cygwin-patches@cygwin.com>; Wed, 09 Jul 2025 14:47:26 -0400 (EDT)
Date: Wed, 9 Jul 2025 11:47:26 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: testsuite: link cygload with
 --disable-high-entropy-va
Message-ID: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a mingw program meant to demonstrate loading the Cygwin dll in a
non-Cygwin process, but the Cygwin dll still initializes the cygheap on
load in that case.  Without --disable-high-entropy-va, Windows may
occasionally locate the PEB, TEB, and/or stacks in the address space
that Cygwin tries to reserve for the cygheap, resulting in a failure.

Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin DLL")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/mingw/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Makefile.am
index 25300a15d9..775d617aef 100644
--- a/winsup/testsuite/mingw/Makefile.am
+++ b/winsup/testsuite/mingw/Makefile.am
@@ -23,7 +23,7 @@ cygrun_SOURCES = \

 cygload_SOURCES = \
 	../winsup.api/cygload.cc
-cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup
+cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup -Wl,--disable-high-entropy-va

 winchild_SOURCES = \
 	../winsup.api/posix_spawn/winchild.c
-- 
2.50.1.windows.1

