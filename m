Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 51A043854A95
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:47:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 51A043854A95
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 51A043854A95
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413625; cv=none;
	b=r6XBGySaD61ObTlNw9Z7037A19HaLznhm60yRzpalWJ1nA/nnNrlV+7KHUNvfly8Yuqfya4ujkDNUZIYZaOc63qCLnOeGNXidr5VnunssZk2N7oKbGs4a7QvOlE/vt7Fs+T+E4wg5EagVR+X9V42KN7uzi55YI8AUT0XNpXss8g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413625; c=relaxed/simple;
	bh=nZa7KkCnJkPuv9TFqbDDS5XlURD3VuSnjXyBYfErZGk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=trxO0AVK4G/7o2fckRhzkd/MhvesD6UOFYwmQUALeP26A3QANsyGNYsy0DDqHL6AEo0MVmRinqHpueLnnPZS6zgSlWjZJkruZaTCej/q64JwkXstBD/yoWzRZTylhblGwAZrAUE6iFKD0Vf6Zfsr/Qwa/xs/VMPPvfLvhL+7Vkw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 51A043854A95
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=cTIVqjcM
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2E9A845CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:47:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Cp+bT
	iJSTKOI608hgliODQoV5SU=; b=cTIVqjcM0Q51GJWTRK8zksKxCYM/p3L3WJZBy
	QOXraego1c09faFwfnoHt+JIYd5Q/hcs72F5r8xcNr547erjF+tUAhyFRNvr7u6D
	AeUm/ZKr2pZRHJvwQth1Vc5TISFnDYbWPiU9pG4wKKezIsXzuzY8yG5Bsd/H6Pl+
	sVQWks=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2B6EE45CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:47:05 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:47:05 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 5/6] Cygwin: posix_spawn: add fastpath support for SETSIGMASK
 and SETSIGDEF.
Message-ID: <d981ba56-0ed0-2a1f-3c11-f95fdf5bbead@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

the sigmask was already a member of the child_info, so this just needed
an arg to allow overriding the value copied from cygheap.  The signal
handlers are referenced by two pointers, global_sigs which is used by
the signal routines, and cygheap->sigs which is only used during process
launch and startup.  Temporarily replace cygheap->sigs with a copy that
has the requested signals reset to default while spawning the child.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/local_includes/child_info.h |  3 +-
 winsup/cygwin/spawn.cc                    | 57 ++++++++++++++++++++---
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index ad7c8fc29a..63f398fa1d 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -141,9 +141,10 @@ struct spawn_worker_args
   int mode;
   int stdfds[3];
   int cwdfd;
+  sigset_t *sigmask;

   spawn_worker_args (int mode)
-    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD)
+    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD), sigmask (NULL)
   { }
 };

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index b8b623af7f..cd99644d60 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -589,6 +589,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       __stdin = args.stdfds[0];
       __stdout = args.stdfds[1];
       __stderr = args.stdfds[2];
+      if (args.sigmask)
+	sigmask = *args.sigmask;
       record_children ();

       si.lpReserved2 = (LPBYTE) this;
@@ -1454,6 +1456,8 @@ do_posix_spawn (pid_t *pid, const char *path,
 		const posix_spawnattr_t *sa, char * const argv[],
 		char * const envp[], int use_env_path)
 {
+  spawn_worker_args args (_P_NOWAIT);
+  struct sigaction *sigs = NULL;
   syscall_printf ("posix_spawn%s (%p, %s, %p, %p, %p, %p)",
       use_env_path ? "p" : "", pid, path, fa, sa, argv, envp);

@@ -1461,15 +1465,26 @@ do_posix_spawn (pid_t *pid, const char *path,
      POSIX_SPAWN_RESETIDS
      POSIX_SPAWN_SETPGROUP
      POSIX_SPAWN_SETSCHEDPARAM
-     POSIX_SPAWN_SETSCHEDULER
-     POSIX_SPAWN_SETSIGDEF
-     POSIX_SPAWN_SETSIGMASK */
-  if (sa && (*sa)->sa_flags)
-    goto fallback;
+     POSIX_SPAWN_SETSCHEDULER */
+  if (sa)
+    {
+      if ((*sa)->sa_flags & ~(POSIX_SPAWN_SETSIGMASK|POSIX_SPAWN_SETSIGDEF))
+	goto fallback;
+
+      if ((*sa)->sa_flags & POSIX_SPAWN_SETSIGMASK)
+	args.sigmask = &(*sa)->sa_sigmask;
+
+      if ((*sa)->sa_flags & POSIX_SPAWN_SETSIGDEF)
+	{
+	  sigs = (struct sigaction *) cmalloc (HEAP_SIGS,
+					     _NSIG * sizeof (struct sigaction));
+	  if (!sigs)
+	    return ENOMEM;
+	}
+    }

   {
     path_conv buf;
-    spawn_worker_args args (_P_NOWAIT);
     /* lock the process to temporarily manipulate file descriptors for the
        spawn operation */
     lock_process now;
@@ -1623,12 +1638,40 @@ do_posix_spawn (pid_t *pid, const char *path,
 	  }
       }

+    if (sigs)
+      {
+	memcpy (sigs, cygheap->sigs, _NSIG * sizeof (struct sigaction));
+	for (int i = 1; i < _NSIG; i++)
+	  {
+	    if ((*sa)->sa_sigdefault & SIGTOMASK (i))
+	      {
+		sigs[i].sa_mask = 0;
+		sigs[i].sa_handler = SIG_DFL;
+		sigs[i].sa_flags &= ~SA_SIGINFO;
+	      }
+	  }
+
+	/* the active signal handler info is kept in global_sigs and
+	   cygheap->sigs is only used for inheritance to child processes, so we
+	   can swap out cygheap->sigs without worrying about messing up the
+	   current process's state.  Use an InterlockedExchange just to be
+	   safe. */
+	sigs = (struct sigaction *) InterlockedExchangePointer (
+						(PVOID *) &cygheap->sigs, sigs);
+      }
+
     chpid = ch_spawn.worker (
 	use_env_path ?
 		(find_exec (path, buf, "PATH", FE_NNF, NULL, args.cwdfd) ?: "")
 		     : path,
 	argv, envp ?: environ, args);

+    /* put cygheap->sigs back how we found it (should be the same as
+       global_sigs */
+    if (sigs)
+      sigs = (struct sigaction *) InterlockedExchangePointer (
+						(PVOID *) &cygheap->sigs, sigs);
+
     if (chpid < 0)
       {
 	ret = get_errno ();
@@ -1641,6 +1684,8 @@ do_posix_spawn (pid_t *pid, const char *path,

 closes:
     int save_errno = get_errno ();
+    if (sigs)
+      cfree (sigs);
     if (args.cwdfd >= 0)
       close (args.cwdfd);
     for (size_t i = 0; i < 3; i++)
-- 
2.49.0.windows.1

