Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 18C84385C6DE
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:34:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 18C84385C6DE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 18C84385C6DE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750970088; cv=none;
	b=K0vOUUFB49DPaUwfglWPcCUjT0PQU75A8AV2njnqnuROQrVFVfJ5YJbYZ0c98z8ORipBtJXSsoSddE5W2YiUSFQM8s6t7DKxw8atdtxDJJbN5P4Kq7diMBmKaU30liGm9RxfaJ2DNzhJEBnzyHCG059ZHC+3/tjKfhrkt+uc/+c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750970088; c=relaxed/simple;
	bh=l/vYZDhyKXO9il71hoECjsI+dH9ORMQnEMsoRBuxJBo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=tkJ3ElUtX+jPDxzqNdJL+mcJH/gs27OeMvzvNBRYqGOTtNPXsJUfFlZr5O+tf4yNEB2zLJvu6/yNd7YGpslnGwmMEQgui3EfxCRCXH0cc1vWRPqvTRjkFK3lzAXZWrpmbKTPjPEZiEdb4yXP0V9FQssu7WOuasDQRkpXzNE/yrs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18C84385C6DE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=jl6603/s
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id EA08D45D3B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=lOJ7o
	5FYB5OePB4sms8fZ90ucjw=; b=jl6603/s1cVdrRHpfmfmNfMq9WKp7chbtvy85
	Kosgmm68u+4xWx0Q3yo3zXk/68TWEQzXFfxKnQLvx+DBqRNVqvkeTYny3tNv9Lee
	kjW+QHI/M5BOIO/yTAjRb2sN+zdmjIZK6Q9ntBfVso+TooC4AIKipKGJsUPadm0t
	O8uhLc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E18EE45D37
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:34:47 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:34:47 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: testsuite: test passing directory fd to child
Message-ID: <1b4da216-51cb-cbc5-7a2d-db997429eed3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

It doesn't make a whole lot of sense to redirect stdin/out/err to/from a
directory handle, but test it anyway.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/winsup.api/posix_spawn/chdir.c | 12 ++++++++++++
 winsup/testsuite/winsup.api/posix_spawn/win32.c | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/winsup/testsuite/winsup.api/posix_spawn/chdir.c b/winsup/testsuite/winsup.api/posix_spawn/chdir.c
index c6ccc45fb2..0951d2d745 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/chdir.c
+++ b/winsup/testsuite/winsup.api/posix_spawn/chdir.c
@@ -140,6 +140,18 @@ int main (int argc, char **argv)
   negError (waitpid (pid, &status, 0));
   exitStatus (status, 0);
   errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_addfchdir + adddup2 of directory fd */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, fd, 0));
+  errCode (posix_spawn_file_actions_addfchdir_np (&fa, fd));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, "tmpfile2", O_WRONLY, 0644));
+  childargv[3] = buf;
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
   negError (close (fd));

   return 0;
diff --git a/winsup/testsuite/winsup.api/posix_spawn/win32.c b/winsup/testsuite/winsup.api/posix_spawn/win32.c
index cd2bedcd95..8998c4337d 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/win32.c
+++ b/winsup/testsuite/winsup.api/posix_spawn/win32.c
@@ -162,6 +162,17 @@ int main (void)
   errCode (posix_spawn_file_actions_destroy (&fa));
   free (childargv[2]);

+  /* test posix_spawn_file_actions_adddup2 of directory handle */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, cwdfd, 0));
+  childargv[1] = "0";
+  childargv[2] = cygwin_create_path (CCP_POSIX_TO_WIN_A|CCP_ABSOLUTE, tmpcwd);
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+  free (childargv[2]);
+
   negError (close (cwdfd));
   negError (close (fd));
   negError (close (fdcloexec));
-- 
2.49.0.windows.1

