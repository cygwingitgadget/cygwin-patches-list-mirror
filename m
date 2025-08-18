Return-Path: <SRS0=J2yH=26=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 62BF1385735A
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 23:30:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 62BF1385735A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 62BF1385735A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755559849; cv=none;
	b=ePjFu65daUm6T3La5n8p0OkaHic3B5vW3cpPim8ab5aWUY5cAIQCrRNgAt7JwaKgJR+Sid9uaBbl6jiWSLK9CrVh78qfVkHpnc4+if63enRCkYO2fXmlMTsA2Q7stORGQDp10CMYUvvZ9/SvvSUCuNtGyPsxkTLvVDeWKYebn5U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755559849; c=relaxed/simple;
	bh=PjPAk3kYmSR5wFqUQuBkwsqqndeH1c3mCD253/naTtQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Gy2YshTKxVTGuqvmJclKKJ/kHkQZzKfFQUFR8flKjAyzZhtLxUZoESerhh2YozzMMzCffqYUiZGYbt/Mrf0aOmInDbFQ4mUU/XoaCOfqWeaxqlodb+xWBhkt8D/3tqEK8g7kmMrB3JbGx6jzKX9quuBbiHUYqFS7qUgsLXKH99o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 62BF1385735A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=O9R3rX97
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1426345CF3
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 19:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=CMypP
	aipBtgcUyJtuvUcnr3/r40=; b=O9R3rX97KTqlyiOpD1n8W/ZH1xuT51FNuq7Jq
	Wtke3kt8Buw194pg4i3nW0kPfeAQIHGuj0dAsYKxr1iFipEGB1hEq4PNbzdY2iFc
	Amtjuttvk5UrXEu0Sa0zCa5CA0E7OdlfEv4de5UTZxpLea/d2Mb7jYjt5uh/2L+R
	b81ej0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EF15F45CEF
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 19:30:48 -0400 (EDT)
Date: Mon, 18 Aug 2025 16:30:48 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix finding overlaps from F_SETLKW.
Message-ID: <a8581a49-fe01-37a8-edb7-95ccccf66549@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit adding OFD locks changed from comparing just the F_POSIX and
F_LOCK flags to comparing the entire flags value in order to make sure
the locks are of the same type.  However, the F_WAIT flag may or may not
be set, and result in that comparison not matching.  Mask the F_WAIT
flag when attempting to compare the types of the locks.

This fixes the "many_locks" stc.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
Fixes: a66ed519884d ("Cygwin: fcntl: implement Open File Description (OFD) locks")
---
 winsup/cygwin/flock.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index e9f49a8900..e03caba27a 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -1722,7 +1722,7 @@ lf_findoverlap (lockf_t *lf, lockf_t *lock, int type, lockf_t ***prev,
       /* We're "self" only if the semantics and the id matches.  OFD and POSIX
          locks potentially block each other.  This is true even for OFD and
 	 POSIX locks created by the same process. */
-      bool self = (lf->lf_flags == lock->lf_flags)
+      bool self = ((lf->lf_flags & ~F_WAIT) == (lock->lf_flags & ~F_WAIT))
 		  && (lf->lf_id == lock->lf_id);

       if (bsd_flock || ((type & SELF) && !self) || ((type & OTHERS) && self))
-- 
2.50.1.windows.1

