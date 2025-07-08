Return-Path: <SRS0=7BB9=ZV=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4F0243857C78
	for <cygwin-patches@cygwin.com>; Tue,  8 Jul 2025 22:56:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4F0243857C78
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4F0243857C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752015405; cv=none;
	b=Lu/H4GpCsiaknXdoFMcnydipXQ/SLCNWNhI7e+CeRby14t6ETK4dloao5s/Cq+SjNiy3vkN68QLgWB4pA4omiXs0HbhyWc92dgnV+23MtFw25fYkpkow+55IE++P2LDgCGdXiAdok/nK63UqySeoVPu90ecMsar3HcU9XYswgKc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752015405; c=relaxed/simple;
	bh=pV+Rkr00h+8Nw130UEABH0DE5LXkMwqpMGenmtXOzDA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=JlPsM5NcAHLPcxH0SoNu8g1lxzWA/9DiNNkLQOumNIYX+slZqdHieAkntT1PpK1guWIgNvGeYm6jcIJ/UzZ5CIThh/JJU14YVl1ShORcpXFW4U7uCbu8XIYPh1W6BZbwXW6+hlHWDLOCHZbXpnaGG55fJDnR2iLJKED3FdHmVD4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4F0243857C78
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=KIPKP4JW
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1FD9745C1D
	for <cygwin-patches@cygwin.com>; Tue, 08 Jul 2025 18:56:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=tbNIR
	ks/ES/DqKATQT0SIHG/lLA=; b=KIPKP4JWfjV83jxVuqSEMKQK18p+J8Z2JtxXD
	Ss15z9NS6gbvd54kgYcFH2u3dN0nkEz8a3Y5QYjQOz3XwaxII69xHydt5NzhlB1Q
	SEBZmbnQ5ArAC7Fs6QCJEoGFCWW8UyxyjSeT7D7vCoExroUwV2kRXVPsMepmQo2d
	HVrnD8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0780745A5F
	for <cygwin-patches@cygwin.com>; Tue, 08 Jul 2025 18:56:45 -0400 (EDT)
Date: Tue, 8 Jul 2025 15:56:44 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: testsuite: test posix_spawn_file_actions_addopen
 with O_CLOEXEC
Message-ID: <ff952d6d-fb58-3d97-fc95-67aa64749157@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This was previously not handled correctly by newlib.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
This requires a newlib fix
(https://sourceware.org/pipermail/newlib/2025/021971.html) to pass on
Cygwin.  It passes on Linux.

 winsup/testsuite/winsup.api/posix_spawn/fds.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/testsuite/winsup.api/posix_spawn/fds.c b/winsup/testsuite/winsup.api/posix_spawn/fds.c
index 98ce36ff36..dab96ab33c 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/fds.c
+++ b/winsup/testsuite/winsup.api/posix_spawn/fds.c
@@ -74,6 +74,16 @@ int main (int argc, char **argv)
   exitStatus (status, 0);
   errCode (posix_spawn_file_actions_destroy (&fa));

+  /* test posix_spawn_file_actions_addopen with O_CLOEXEC */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 0, "/dev/zero",
+					     O_RDONLY|O_CLOEXEC, 0644));
+  childargv[3] = "<ENOENT>";
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
   /* test posix_spawn_file_actions_adddup2 */
   errCode (posix_spawn_file_actions_init (&fa));
   errCode (posix_spawn_file_actions_adddup2 (&fa, fd, 0));
-- 
2.50.1.windows.1

