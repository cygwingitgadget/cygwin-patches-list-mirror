Return-Path: <SRS0=7LkC=YN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 724623857823
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 17:59:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 724623857823
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 724623857823
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748541550; cv=none;
	b=x+by17qj/d9dpXsLQVBTflLLzwC0BtyIoRprwXiPZtIsSpBO7MzXP/gDFuB8VRMO9Msea0gSoaZ9Ww1vzbWEYH/Nt7A3ZjB8HrVLEpv+/xvfqdQNefFAgIwoVvmniHft9fitVx64onTPplUccysh3kg95IzSaizELN3Vd6l4w+o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748541550; c=relaxed/simple;
	bh=gAIPhnz71HQmRrO30hza4O3I3fvlrKZ9PgLmAo1HY9w=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UXkgVh7MpbldHz+gWf9lvEpXJ3p30w35ID3/qQwfCaGcIApM0i2ug5bHFpbOyG62i8u5N1RRpsQZ4lm9zheMoFxEvPamvizGc8L36/X6QLy9U1C1s60dGifXFGf3GsOWtP1jmXo0R4FLhNoKD59PMhyAtAinG8oZG2FiEVKi1X0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4D50F45CB2
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:59:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=69I4e
	RwXkTl//SFWJ7p8RxzVTD0=; b=aUB4lXKJ3fJQ+UP/px7TCPzpRMsrxizUjIIA9
	zDD5qYjC9xoffD6BfZ8lXP8mr3+5aBU1ZraPM0m2Q2IhQRARuk0Y0TJn1wMRCZdp
	tY4cVUBbiZcg6cCTr0Fc8QHO+N5+pKZbYV98YzhW7ez6AZIe0XGO+b7E+CoNMO8j
	YXVXZ4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4739545CA8
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:59:10 -0400 (EDT)
Date: Thu, 29 May 2025 10:59:10 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [RFC PATCH 3/3] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently just file actions open/close/dup2 are supported in the fast
path.
---
 winsup/cygwin/spawn.cc | 92 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index dc5f04db98..8a3879256c 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -1421,8 +1421,100 @@ do_posix_spawn (pid_t *pid, const char *path,
 		const posix_spawnattr_t *sa, char * const argv[],
 		char * const envp[], int use_env_path)
 {
+  short flags;
   syscall_printf ("posix_spawn%s (%p, %s, %p, %p, %p, %p)",
       use_env_path ? "p" : "", pid, path, fa, sa, argv, envp);
+
+  /* TODO: possibly implement spawnattr flags:
+     POSIX_SPAWN_RESETIDS
+     POSIX_SPAWN_SETPGROUP
+     POSIX_SPAWN_SETSCHEDPARAM
+     POSIX_SPAWN_SETSCHEDULER
+     POSIX_SPAWN_SETSIGDEF
+     POSIX_SPAWN_SETSIGMASK */
+  if (sa && (posix_spawnattr_getflags (sa, &flags) || flags))
+    goto fallback;
+
+  {
+    path_conv buf;
+    lock_process now;
+    posix_spawn_file_actions_entry_t *fae;
+    pid_t chpid;
+    int fds[3] = {-1, -1, -1};
+    int oldflags[cygheap->fdtab.size];
+    int ret = -1;
+    memset (oldflags, -1, sizeof (oldflags));
+
+    if (fa)
+      {
+	STAILQ_FOREACH(fae, &(*fa)->fa_list, fae_list)
+	  {
+	    switch (fae->fae_action)
+	      {
+	      case __posix_spawn_file_actions_entry::FAE_DUP2:
+		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
+		  goto closes;
+		fds[fae->fae_newfildes] = dup (fae->fae_fildes);
+		oldflags[fae->fae_newfildes] = fcntl (fae->fae_newfildes,
+						      F_GETFD, 0);
+		fcntl (fae->fae_newfildes, F_SETFD, FD_CLOEXEC);
+		break;
+
+	      case __posix_spawn_file_actions_entry::FAE_OPEN:
+		if (fae->fae_fildes < 0 || fae->fae_fildes > 2)
+		  goto closes;
+		fds[fae->fae_fildes] = open (fae->fae_path, fae->fae_oflag,
+					     fae->fae_mode);
+		if (fds[fae->fae_fildes] < 0)
+		  {
+		    fds[fae->fae_fildes] = -1;
+		    ret = get_errno ();
+		    goto closes;
+		  }
+		fcntl (fds[fae->fae_fildes], F_SETFD, 0);
+		fallthrough;
+	      case __posix_spawn_file_actions_entry::FAE_CLOSE:
+		oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes, F_GETFD, 0);
+		fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
+		break;
+	      /* TODO: FAE_(F)CHDIR */
+	      default:
+		goto closes;
+	      }
+	  }
+      }
+
+    chpid = ch_spawn.worker (
+	use_env_path ? (find_exec (path, buf, "PATH", FE_NNF) ?: "")
+		     : path,
+	argv, envp ?: environ,
+	_P_NOWAIT | (use_env_path ? _P_PATH_TYPE_EXEC : 0),
+	fds[0], fds[1], fds[2]);
+
+    if (chpid < 0)
+      {
+	ret = get_errno ();
+      }
+    else
+      {
+	*pid = chpid;
+	ret = 0;
+      }
+
+closes:
+    int save_errno = get_errno ();
+    for (size_t i = 0; i < 3; i++)
+      if (fds[i] != -1)
+	close (fds[i]);
+    for (size_t i = 0; i < sizeof (oldflags) / sizeof (oldflags[0]); i++)
+      if (oldflags[i] != -1)
+	fcntl (i, F_SETFD, oldflags[i]);
+    set_errno (save_errno);
+    if (ret != -1)
+      return ret;
+  }
+
+fallback:
   if (use_env_path)
     return posix_spawnp (pid, path, fa, sa, argv, envp);
   else
-- 
2.49.0.windows.1

