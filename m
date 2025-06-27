Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 442823854A8E
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 00:00:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 442823854A8E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 442823854A8E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750982432; cv=none;
	b=p/D4/SOissjfWM5BsyGhaqqSoLxFpYf+l0ice4N85E1BIc8gL8VDOci9yAhRO3pzT2ayQh8Unfaq2KkLQWt8AisRJx4vU5jIFlutJcZbSBFpFXpPyVv1MmNAsToJrU84usL2x2LW/uZpjofsa5wi0rSHBomoTmNrbDuvnFLClF0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750982432; c=relaxed/simple;
	bh=dOWqzk10Ee1KLzN3UHBaOTxjAr6rLpy9Xhs91lRodtk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=L0GFp4t3/Cu4aZioDL5L8YK478a5mOz9RxDTsPhUpEJ7AU3SLubAm85aIto1nGi/Sk0u4BdWH2Gckx9g4SmucPapcJYt2S7A8qDcI8aFHg3r/wBgEEFS2Culi/69Ff5vWdGo/N1wiNTZXZkFbmiCo/7jObcmP2UcbM5wqk04Ibc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 442823854A8E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=zCnN4r1K
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 224D145D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=hcseJ
	7yRodFpHf6fdykG96VEkyo=; b=zCnN4r1KeMA4sdMhWWWJ+bWqZd6srMUWjCiqM
	HnZrp1Y9Rg5FKbbhtV0qnAitEdKQrCo8iFrHZAR99q1neT9QBiUzAZEGzQ4VmHpS
	gSlKkRDzvvO1CNIOqZwYvSsp58A37YR3l5TvZUGtQTh9yF9ZamSMySK+/M5BuYaD
	iDmLNY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1DA2745D30
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:00:31 -0400 (EDT)
Date: Thu, 26 Jun 2025 17:00:31 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/5] Cygwin: posix_spawn: add fastpath support for SETSIGMASK
 and SETSIGDEF.
Message-ID: <91d460a0-9953-41a5-e011-c6284cfd0991@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,PROLO_LEO2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/local_includes/child_info.h |  3 +-
 winsup/cygwin/spawn.cc                    | 53 ++++++++++++++++++++---
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 95bdd5cd1c..706acb7a9d 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -191,7 +191,8 @@ public:
   bool has_execed_cygwin () const { return iscygwin () && has_execed (); }
   operator HANDLE& () {return hExeced;}
   int worker (const char *, const char *const *, const char *const [],
-		     int, int = -1, int = -1, int = -1, int = AT_FDCWD);
+		     int, int = -1, int = -1, int = -1, int = AT_FDCWD,
+		     sigset_t * = NULL);
 };

 extern child_info_spawn ch_spawn;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 7b02512212..fec9a21815 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -285,7 +285,7 @@ int
 child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			  const char *const envp[], int mode,
 			  int in__stdin, int in__stdout, int in__stderr,
-			  int cwdfd)
+			  int cwdfd, sigset_t *sigmaskp)
 {
   bool rc;
   int res = -1;
@@ -575,6 +575,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       __stdin = in__stdin;
       __stdout = in__stdout;
       __stderr = in__stderr;
+      if (sigmaskp)
+	sigmask = *sigmaskp;
       record_children ();

       si.lpReserved2 = (LPBYTE) this;
@@ -1440,6 +1442,8 @@ do_posix_spawn (pid_t *pid, const char *path,
 		const posix_spawnattr_t *sa, char * const argv[],
 		char * const envp[], int use_env_path)
 {
+  sigset_t *sigmaskp = NULL;
+  struct sigaction *sigs = NULL;
   syscall_printf ("posix_spawn%s (%p, %s, %p, %p, %p, %p)",
       use_env_path ? "p" : "", pid, path, fa, sa, argv, envp);

@@ -1447,11 +1451,23 @@ do_posix_spawn (pid_t *pid, const char *path,
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
+	sigmaskp = &(*sa)->sa_sigmask;
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
@@ -1537,12 +1553,33 @@ do_posix_spawn (pid_t *pid, const char *path,
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
+	sigs = (struct sigaction *) InterlockedExchangePointer (
+						(PVOID *) &cygheap->sigs, sigs);
+      }
+
     chpid = ch_spawn.worker (
 	use_env_path ? (find_exec (path, buf, "PATH", FE_NNF) ?: "")
 		     : path,
 	argv, envp ?: environ,
 	_P_NOWAIT | (use_env_path ? _P_PATH_TYPE_EXEC : 0),
-	fds[0], fds[1], fds[2]);
+	fds[0], fds[1], fds[2], AT_FDCWD, sigmaskp);
+
+    if (sigs)
+      sigs = (struct sigaction *) InterlockedExchangePointer (
+						(PVOID *) &cygheap->sigs, sigs);

     if (chpid < 0)
       {
@@ -1556,6 +1593,8 @@ do_posix_spawn (pid_t *pid, const char *path,

 closes:
     int save_errno = get_errno ();
+    if (sigs)
+      cfree (sigs);
     for (size_t i = 0; i < 3; i++)
       if (fds[i] != -1)
 	close (fds[i]);
-- 
2.49.0.windows.1

