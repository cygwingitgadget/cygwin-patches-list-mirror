Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id ECA54385DC1F
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:46:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ECA54385DC1F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ECA54385DC1F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413570; cv=none;
	b=vcX3pY6cLtdn9D1MLhN4jo1UvIcxQxhVSCIyPvZvcSjOxuIwp2+vGdVBuJwOfb/oOlAOwjRX1oUpF77QuIDOX/gdirQpJnk34p3qGBPGxGFrXA7IwtOP5Uuba9Homp2Nk8jiF7ywA9R9z4Lu4EyVQ+L5HdnMJyAiDZfuPizKzL8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413570; c=relaxed/simple;
	bh=NGj+/GFp9g/HaXTw6HMKAfUMwKf+y+6WxxCO/Rhod64=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Z+EJ2Hu6HKGdJP6txYVwaWzGK+j21+MWYKcjOr+oib/RcbS8OzkbAVe9aFOTuZLcL/MoHQyhkDSToxrjN0pTEggp5i+ZSb+gc2uE66J8Je6Jc7sOzxCo2iJsbS4mASQRabf8fRm+OE7ChDhO+WFKXxAIB2hqE6kzMR8nx8/CiSk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECA54385DC1F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=n7UF2NFO
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CA8D745CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=UuKOe
	SNY+S7j6mUWv0UF3A7wZJc=; b=n7UF2NFOdJepW5lmdZRh3JEToANtDjnjVTWed
	l77Eh8OyKLcA+eNzPjyhujg3eH9QxTIL7tRTV+hWCFxdR9KxgDosdc5AMgj2mK9v
	vG4GSNplRr948GIXI3M3hodv13GRJOYKfjfwdR5IqIvxtRagR5k/pxyHM9IYBIdW
	DTta48=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id C55C945CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:46:09 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:46:09 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/6] Cygwin: add fast-path for posix_spawn(p)
Message-ID: <d0fabce5-ef18-ef53-79ae-e6eafb4239a5@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently just file actions are supported in the fast path, open/dup2
with a target fd of stdin/out/err, close of any fd, and chdir and
fchdir.  These were chosen as the least-common-denominator of
functionality supported for any child process, as they are allowed to be
specified via CreateProcess.  They also happen to be the most common
file operations, performed by the likes of GNU make, ninja, LLVM, and rust.

For other attributes or actions, fall back to the newlib implementation
of posix_spawn (which uses fork/exec to set everything up in the child
process).

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/spawn.cc | 199 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 9fe3d1f4c5..b8b623af7f 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -1456,6 +1456,205 @@ do_posix_spawn (pid_t *pid, const char *path,
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
+    spawn_worker_args args (_P_NOWAIT);
+    /* lock the process to temporarily manipulate file descriptors for the
+       spawn operation */
+    lock_process now;
+    posix_spawn_file_actions_entry_t *fae;
+    /* make sure there is enough room in oldflags for the standard descriptors
+       at least */
+    size_t oldflagslen = cygheap->fdtab.size > 3 ? cygheap->fdtab.size : 3;
+    pid_t chpid;
+    int oldflags[oldflagslen];
+    int ret = -1;
+    memset (oldflags, -1, oldflagslen * sizeof (int));
+
+    if (fa)
+      {
+	STAILQ_FOREACH(fae, &(*fa)->fa_list, fae_list)
+	  {
+	    switch (fae->fae_action)
+	      {
+	      case __posix_spawn_file_actions_entry::FAE_DUP2:
+		/* only support new file descriptors 0 through 2 for now as
+		   least-common-denominator for all proceses, and also the
+		   most common operation */
+		if (fae->fae_newfildes < 0 || fae->fae_newfildes > 2)
+		  goto closes;
+
+		if (args.stdfds[fae->fae_newfildes] != -1)
+		  close (args.stdfds[fae->fae_newfildes]);
+
+		if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
+		    args.stdfds[fae->fae_fildes] != -1)
+		  args.stdfds[fae->fae_newfildes] =
+					    dup (args.stdfds[fae->fae_fildes]);
+		else
+		  args.stdfds[fae->fae_newfildes] = dup (fae->fae_fildes);
+
+		if (args.stdfds[fae->fae_newfildes] < 0)
+		  {
+		    args.stdfds[fae->fae_newfildes] = -1;
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
+		/* only support new file descriptors 0 through 2 for now as
+		   least-common-denominator for all proceses, and also the
+		   most common operation */
+		if (fae->fae_fildes < 0 || fae->fae_fildes > 2)
+		  goto closes;
+		if (args.stdfds[fae->fae_fildes] != -1)
+		  close (args.stdfds[fae->fae_fildes]);
+		/* can we just mask out O_CLOEXEC from fae_oflag, or must we
+		   use F_SETFD later? */
+		args.stdfds[fae->fae_fildes] = openat (args.cwdfd,
+						       fae->fae_path,
+						       fae->fae_oflag,
+						       fae->fae_mode);
+		if (args.stdfds[fae->fae_fildes] < 0)
+		  {
+		    args.stdfds[fae->fae_fildes] = -1;
+		    ret = get_errno ();
+		    goto closes;
+		  }
+		fcntl (args.stdfds[fae->fae_fildes], F_SETFD, 0);
+		if (oldflags[fae->fae_fildes] == -1)
+		  oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes, F_GETFD,
+						     0);
+		fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
+		break;
+	      case __posix_spawn_file_actions_entry::FAE_CLOSE:
+		/* If we're asked to close one of the standard handles, and
+		   we've already opened or duped that handle, mark it as CLOEXEC
+		   rather than actually closing it to make sure the child gets a
+		   closed handle.  If that same handle then gets opened or duped
+		   again later, the existing handle will be closed then */
+		if (fae->fae_fildes >= 0 && fae->fae_fildes <= 2 &&
+		    args.stdfds[fae->fae_fildes] != -1)
+		  {
+		    fcntl (args.stdfds[fae->fae_fildes], F_SETFD, FD_CLOEXEC);
+		  }
+		else if (fae->fae_fildes >= 0 &&
+			 (unsigned) fae->fae_fildes < oldflagslen)
+		  {
+		    if (oldflags[fae->fae_fildes] == -1)
+		      oldflags[fae->fae_fildes] = fcntl (fae->fae_fildes,
+							 F_GETFD, 0);
+		    fcntl (fae->fae_fildes, F_SETFD, FD_CLOEXEC);
+		  }
+		else
+		  {
+		    ret = EBADF;
+		    goto closes;
+		  }
+		break;
+	      case __posix_spawn_file_actions_entry::FAE_FCHDIR:
+		if (args.cwdfd >= 0)
+		  close (args.cwdfd);
+		args.cwdfd = dup (fae->fae_dirfd);
+		if (args.cwdfd < 0)
+		  {
+		    ret = get_errno ();
+		    goto closes;
+		  }
+		/* the cloexec flag will be set or cleared in ch_spawn.worker
+		   as necessary */
+		fcntl (args.cwdfd, F_SETFD, FD_CLOEXEC);
+		break;
+	      case __posix_spawn_file_actions_entry::FAE_CHDIR:
+		{
+		  int newfd = openat (args.cwdfd, fae->fae_dir,
+				      O_SEARCH|O_DIRECTORY|O_CLOEXEC, 0755);
+		  if (newfd < 0)
+		  {
+		    ret = get_errno ();
+		    goto closes;
+		  }
+		  if (args.cwdfd >= 0)
+		    close (args.cwdfd);
+		  args.cwdfd = newfd;
+		  break;
+		}
+	      default:
+		goto closes;
+	      }
+	  }
+
+	/* From popen: If fds are in the range of stdin/stdout/stderr, move
+	   them out of the way.  Otherwise, spawn_guts will be confused.
+	   We do this here rather than adding logic to spawn_guts because
+	   spawn_guts is likely to be a more frequently used routine and
+	   having stdin/stdout/stderr closed and reassigned to pipe handles
+	   is an unlikely event. */
+	for (int i = 0; i < 3; i++)
+	  if (args.stdfds[i] >= 0 && args.stdfds[i] <= 2)
+	    {
+	      cygheap_fdnew newfd (3);
+	      cygheap->fdtab.move_fd (args.stdfds[i], newfd);
+	      args.stdfds[i] = newfd;
+	    }
+
+	if (args.cwdfd >= 0 && args.cwdfd <= 2)
+	  {
+	    cygheap_fdnew newfd (3);
+	    cygheap->fdtab.move_fd (args.cwdfd, newfd);
+	    args.cwdfd = newfd;
+	  }
+      }
+
+    chpid = ch_spawn.worker (
+	use_env_path ?
+		(find_exec (path, buf, "PATH", FE_NNF, NULL, args.cwdfd) ?: "")
+		     : path,
+	argv, envp ?: environ, args);
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
+    if (args.cwdfd >= 0)
+      close (args.cwdfd);
+    for (size_t i = 0; i < 3; i++)
+      if (args.stdfds[i] != -1)
+	close (args.stdfds[i]);
+    for (size_t i = 0; i < oldflagslen; i++)
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

