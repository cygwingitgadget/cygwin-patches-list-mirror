Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 02CBD385C6F5
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 23:59:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 02CBD385C6F5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 02CBD385C6F5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750982345; cv=none;
	b=X3R3LkzKPsiNqH234yeV8nrtnmC/Nb7PnhxuB9m/vS+xEQxuIGwishBeTk2ns4MjdyzPv0+PgdBJHV11IC8/XsVaS+cjDkCCMzCWijIyQ4f54zydgLYeq4wbrmYh+kGzI+DA1lM0WxKmPeia7qN6ypWopqgXiE7DGLD9oF1pYyM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750982345; c=relaxed/simple;
	bh=a83tPsPpY3COjV4N5F1IxXNFUENBh8wK266sTy3i6Iw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=I9JYa/lYqQuA2QSCkcXFGrCJcDIMe6tGE5+GOOag+zhuo+Av4w50GlxHX2ophEIpmCwYwgsOYSVF6pI5kbFb5cDZ6Kgnh7LiPFBSW7dY42QLkikt3HfDnjZ/kuRI74JJ7tT6BZOwqBKFVvsjWIv1nbpBpWUxx8utmfptvH/xH3E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 02CBD385C6F5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=JXoR8y7B
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D4CD345D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:59:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=uJdqX
	2pH8p1wZHT1LQAfP0J0xH0=; b=JXoR8y7BRg7uI4ziOEspqnZ2iCWSGO3rymvSB
	dFGO2t6rsDenO5KpFCwJMcE8UIN9hnS7JvOx7cDx2UZF/HO9KFuP3oWY3Pg3OF7k
	TbWQ3jSXod7GDxbFPSYD4Xb3uRRBauNkX2MPUyxGNyCAp3pixMSRP8+IUIKHtWSf
	LDXu2Q=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CEC6A45D30
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:59:04 -0400 (EDT)
Date: Thu, 26 Jun 2025 16:59:04 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <15b3cf9b-62f1-1273-0df8-427db6962e87@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently just file actions open/close/dup2 are supported in the fast
path.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/spawn.cc | 126 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 63b6233255..7b02512212 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -1442,6 +1442,132 @@ do_posix_spawn (pid_t *pid, const char *path,
 {
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
+  if (sa && (*sa)->sa_flags)
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
+
+		if (fds[fae->fae_newfildes] != -1)
+		  close (fds[fae->fae_newfildes]);
+
+		if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
+		    fds[fae->fae_fildes] != -1)
+		  fds[fae->fae_newfildes] = dup (fds[fae->fae_fildes]);
+		else
+		  fds[fae->fae_newfildes] = dup (fae->fae_fildes);
+
+		if (fds[fae->fae_newfildes] < 0)
+		  {
+		    fds[fae->fae_newfildes] = -1;
+		    ret = get_errno ();
+		    goto closes;
+		  }
+
+		if (oldflags[fae->fae_newfildes] == -1)
+		  oldflags[fae->fae_newfildes] = fcntl (fae->fae_newfildes,
+							F_GETFD, 0);
+		fcntl (fae->fae_newfildes, F_SETFD, FD_CLOEXEC);
+		break;
+
+	      case __posix_spawn_file_actions_entry::FAE_OPEN:
+		if (fae->fae_fildes < 0 || fae->fae_fildes > 2)
+		  goto closes;
+		if (fds[fae->fae_fildes] != -1)
+		  close (fds[fae->fae_fildes]);
+		/* can we just mask out O_CLOEXEC from fae_oflag, or must we
+		   use F_SETFD later? */
+		fds[fae->fae_fildes] = open (fae->fae_path, fae->fae_oflag,
+					     fae->fae_mode);
+		if (fds[fae->fae_fildes] < 0)
+		  {
+		    fds[fae->fae_fildes] = -1;
+		    ret = get_errno ();
+		    goto closes;
+		  }
+		fcntl (fds[fae->fae_fildes], F_SETFD, 0);
+		if (oldflags[fae->fae_fildes] == -1)
+		  oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes, F_GETFD,
+						     0);
+		fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
+		break;
+	      case __posix_spawn_file_actions_entry::FAE_CLOSE:
+		if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
+		    fds[fae->fae_fildes] != -1)
+		  {
+		    fcntl (fds[fae->fae_fildes], F_SETFD, FD_CLOEXEC);
+		  }
+		else
+		  {
+		    if (oldflags[fae->fae_fildes] == -1)
+		      oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes,
+							 F_GETFD, 0);
+		    fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
+		  }
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

