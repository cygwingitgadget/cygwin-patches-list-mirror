Return-Path: <SRS0=Dc4B=36=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5F3423858402
	for <cygwin-patches@cygwin.com>; Fri, 19 Sep 2025 21:43:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F3423858402
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5F3423858402
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758318237; cv=none;
	b=ow8n8/3ZE0BGY8d2dqvO5fDsiJTZ6GmC7A0of7y9bEeovM5jQeHiDXIG+yDA8MSREOAbZBswX24i/8YwxOhoutABXDmfsiL+LnqYMt4CReOk4z/az2brxLFy1yJ2x9sX95/DtAqbQoOvRsoeW2LzrRmIu9NYbrVjkxKtBoc+q1I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758318237; c=relaxed/simple;
	bh=+oksOp6njPJWL8flqiWRJD6Ea1sESXKGoJ7DHwN0ALM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=d3r4z051gE9IT+GTCo1Ku97ZO7omjeMXqtqr9nJ+ttdDwgXYt5BAnMe265WyfzHPUMCyMWC+342b7hKSWxrMHkGHmlCb+zH8QnULc4Xn8ucV1Eb2ekhZeEckOEbLxqAo5fzp8yKXzWsTYcOwhfKu0zx1CdjGMRePzZHWpJbxOIM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F3423858402
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=rvEwwr/O
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1362545D45
	for <cygwin-patches@cygwin.com>; Fri, 19 Sep 2025 17:43:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=HpuHA
	XJkxtYZVVJSc0woJFV4qIo=; b=rvEwwr/OWv+DbFUfuVJK8gecr6StLrXYlUR0S
	ytOUpmJCYxxzQBjzLiAfetFFBm18rzz33VEds2ADd/c+wmNOQiZuIJptMMyAApRE
	+RQlBcz6rR1C2Cspkg8riB9wjIeZ2k9xJy2bf+xsHwOViKBMfPpriHdk5vjVvCZ9
	hktsJc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EE72145D41
	for <cygwin-patches@cygwin.com>; Fri, 19 Sep 2025 17:43:56 -0400 (EDT)
Date: Fri, 19 Sep 2025 14:43:56 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: lock cygheap during fork
Message-ID: <e3dfa011-3ddd-6f69-439e-87746ae3a2b2@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

another thread may simultaneously be doing a cmalloc/cfree while the
cygheap is being copied to the child.

Addresses: https://cygwin.com/pipermail/cygwin/2025-September/258801.html
Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
I'm seeing a timeout failure of pthread/cancel2.exe test in GitHub CI.
This seems to be happening even without this change, so perhaps it is more
to do with the update to windows-2025 runners?  In any event, this
prevents the 'stress' jobs from running against this change.

 winsup/cygwin/fork.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 4abc525986..7156fc31de 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -329,6 +329,7 @@ frok::parent (volatile char * volatile stack_here)
   /* NEVER, EVER, call a function which in turn calls malloc&friends while this
      malloc lock is active! */
   __malloc_lock ();
+  cygheap->lock ();
   bool locked = true;

   /* Remove impersonation */
@@ -483,6 +484,7 @@ frok::parent (volatile char * volatile stack_here)
 		   impure, impure_beg, impure_end,
 		   NULL);

+  cygheap->unlock ();
   __malloc_unlock ();
   locked = false;
   if (!rc)
@@ -568,7 +570,10 @@ cleanup:
   if (fix_impersonation)
     cygheap->user.reimpersonate ();
   if (locked)
-    __malloc_unlock ();
+    {
+      cygheap->unlock ();
+      __malloc_unlock ();
+    }

   /* Remember to de-allocate the fd table. */
   if (hchild)
-- 
2.51.0.windows.1

