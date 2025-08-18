Return-Path: <SRS0=J2yH=26=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 7E8F13858023
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 20:25:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7E8F13858023
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7E8F13858023
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755548734; cv=none;
	b=lLr2/OfGR3Q7qjApbPHIJYTr+kyVuDuqP662C2lSvajP3RR4cAGAdk7DjEKshE7+2Yu2IdPkdGq5uPkjC+QrpMeU28cvHLhtoRXRo1WJZs7wuzqK6RSmtTcgo0DUc3WcjQd203dO0holYxpUcU7qakttCECpKl0lSapY5spu6T4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755548734; c=relaxed/simple;
	bh=5xnswgTrwvFx1Cotl9Amr9j+jAzw21+EZXH5Kt1lX5Y=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=k6DwQY0dllOJTi2Hb4w6GosTIox3YAD/qUs8ge5BIjNvolfbp4mGG99FGg0dwZeEE9cXOKsZTV34xFBea6vPQ1/I1yFiCW/BtiJDw+YQZegjkzmCrsh7mIUjd1q4RNI8gumU8lLS1Uio191wWEqe5B3g/doNZBicuPK2RLSPDd0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7E8F13858023
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=nrsgTD7t
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 279BA45CF3
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 16:25:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=z/Wxa
	79z7gsqlWQi8Eh/4oEU+9U=; b=nrsgTD7tbIqYOFcSwZc+GJJRYvSVUFd77CzQq
	fukPRNp6wJKQ2/LcLpLbmIAA1AZZ5OjtPeIUNsgn+EjMuJnMIOCMHKmgtBwkRy+G
	bMFFDTM4nBXJZNQqNFaAsyq6HBwxNm2YQMFb+8R7bOhSCavgplISwCWEQE/cb7Vi
	DGBG9Y=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0B2EF45CEF
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 16:25:34 -0400 (EDT)
Date: Mon, 18 Aug 2025 13:25:33 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix fcntl F_GETLK
Message-ID: <cdba49be-7b3d-d270-9d3f-f1c04f3287a3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit implementing OFD locks dropped the F_GETLK case from the
switch in fhandler_base::lock, replacing it with F_OFD_GETLK.  This
appears to have been an oversight, as F_OFD_SETLK was added as an
additional case above.

This resulted in the winsup.api/ltp/fcntl05 test failing.

Fixes: a66ed519884d ("Cygwin: fcntl: implement Open File Description (OFD) locks")
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
After this fix, the stc tests can run in CI and I'm also seeing many_locks
test fail with EDEADLK.

 winsup/cygwin/flock.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 85800e9714..e9f49a8900 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -1162,6 +1162,7 @@ restart:	/* Entry point after a restartable signal came in. */
       clean = lock;
       break;

+    case F_GETLK:
     case F_OFD_GETLK:
       error = lf_getlock (lock, node, fl);
       lock->lf_next = clean;
-- 
2.50.1.windows.1

