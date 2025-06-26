Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 23698385C6DE
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:29:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23698385C6DE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23698385C6DE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750969746; cv=none;
	b=e799Su4VhZiztfcd7b2ga8UmQd1bw7uFlum/qZoVK2WOTwx4sJQPTYdicauhniHwUWFEk2zXpWdo94Aj/94yka/gB5so7gbT0alXHz3xyP/TEm8mtrH4BfQA51KGTzcKbte4Xn0qftFDPQL0YdMQDzwHu142az4q2/vzdhp3M4g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750969746; c=relaxed/simple;
	bh=PPjG6JAQ6mxjuJZKsvtnloMzlEuDuWHo4TncKSSawOs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vzTtIvRd8g5TIophaDDW0zb9l5SR4efkWb1roFP/5IdwFOQwgflHP9BabKiZjdlRFjdOq7vQ2z0235ykojn40nSn30G5ZWGvartAUj5Y/OS5IVbcjLp7XfjfCW2cfVy/WxShVsZ4VZHGFhnjU5t7YVQAqTg5eM6iHxQqQwmuDy0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23698385C6DE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=AJTm0Hk7
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 00D1B45D3B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:29:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=poOQw
	gwO6qErjCX5iod/5FLBzew=; b=AJTm0Hk72b6hiSa3+y/37DENQpV+4k53+t5py
	3yLoseAb3zDOxKyZDpYA4bB/4XSxEP+HXXv0ntlyU8qzA39mFD+1vOKyEzewZjQp
	3Evh/AERVghG5qEKodnh2QtUn4Cdmhf978SSKKU6TPIQ33XuNtvJNJT4aNucpLxd
	1ObszE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EF95C45D37
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:29:05 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:29:05 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: testsuite: test relative path to exe after
 addchdir.
Message-ID: <798a4efc-cd12-42be-c155-88284d16c721@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is apparently relative to the new cwd, but my implementation is
currently treating it as relative to the parent's cwd, so it's worth
testing.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/winsup.api/posix_spawn/errors.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
index 38563441f3..2fc3217bc0 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/errors.c
+++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
@@ -15,6 +15,7 @@ void cleanup_tmpfile (void)

 int main (void)
 {
+  posix_spawn_file_actions_t fa;
   pid_t pid;
   int fd;
   char *childargv[] = {"ls", NULL};
@@ -53,5 +54,12 @@ int main (void)
       posix_spawn (&pid, tmpsub, NULL, NULL, childargv, environ));
 #endif

+  /* expected ENOENT: relative path after chdir */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addchdir_np (&fa, "/tmp"));
+  errCodeExpected (ENOENT,
+      posix_spawn (&pid, tmppath, &fa, NULL, childargv, environ));
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
   return 0;
 }
-- 
2.49.0.windows.1

