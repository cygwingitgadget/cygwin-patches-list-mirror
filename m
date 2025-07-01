Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A6B393854A95
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:48:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A6B393854A95
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A6B393854A95
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413737; cv=none;
	b=JPlPngY7ptrw3xIWtYvqCALr1UakjxWj9de0fd+uE/caaOTZlpelm4MECt1vIjO1xj7O68iPWujkOJeJx/h9lKjHR/yETW1meoBPshQw2BZb8pWQMgUEBCh18ZieLuPQAz3iQCL9o1z9u2oy8QVUMX45vcqJozbgcburqjUx70Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413737; c=relaxed/simple;
	bh=BS7U29gDxqFdSECwN7wYCVz0h7f5r5ySSTLZhl0eXDY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vmaUUWi7XgppQVxXucpl2GhG2Vcjm8vv6gmHs13tzel61gh+hit0UEQ75D79V1EiKiC/T1wHgf90GLhMb+kgDUna17ukshkPIU9geFxY0YaWnlt6c8ZiY05cYoG8zpgj1dZ543SwRPFRyZPCQ/CHPgPF568i+vAOt9N96Lq1RkM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A6B393854A95
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=oGjAHGO+
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7E71A45CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:48:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Yt6ks
	WHOC9Ovz9vIwrs9rEbQHV4=; b=oGjAHGO+xra3idEA9wkhzWw2JMem4Tj79uiEz
	EOUEiisqxGq65xemB5cgEhoX/KPdiFPsWeTESz6EoG/sEKPa+UG2YjWlI2n38PFn
	m9ZevIneRGs847b5HMtyTLKYCLpwePhYWn9rPTGBsgmns6NJLAXJJ8NBrBat+Dlq
	rz+uho=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 64F7345CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:48:57 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:48:57 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 6/6] Cygwin: add pgroup support to posix_spawn fast path
Message-ID: <88a9f7c9-4a53-294c-c529-e84b9d682c44@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Tweak proc_subproc PROC_ADD_CHILD to only initialize vchild->pgid if
it's not already set.

The error checking of setpgid is lacking with respect to the POSIX
standard, but this code replicates what setpgid does.

This attribute is used by ninja, so is worth adding to the fast path.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/local_includes/child_info.h |  4 +++-
 winsup/cygwin/sigproc.cc                  |  2 +-
 winsup/cygwin/spawn.cc                    | 23 +++++++++++++++++++----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 63f398fa1d..9d98b2620e 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -141,10 +141,12 @@ struct spawn_worker_args
   int mode;
   int stdfds[3];
   int cwdfd;
+  pid_t pgid;
   sigset_t *sigmask;

   spawn_worker_args (int mode)
-    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD), sigmask (NULL)
+    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD), pgid (-1),
+      sigmask (NULL)
   { }
 };

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 361887981b..7020071bc5 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -257,7 +257,7 @@ proc_subproc (DWORD what, uintptr_t val)
 	{
 	  vchild->uid = myself->uid;
 	  vchild->gid = myself->gid;
-	  vchild->pgid = myself->pgid;
+	  InterlockedCompareExchange ((LONG*) &vchild->pgid, myself->pgid, 0);
 	  vchild->sid = myself->sid;
 	  vchild->ctty = myself->ctty;
 	  vchild->cygstarted = true;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index cd99644d60..52aac91c45 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -614,7 +614,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 they ignore it explicitely.  CREATE_NEW_PROCESS_GROUP does that for us. */
       pid_t ctty_pgid =
 	::cygheap->ctty ? ::cygheap->ctty->tc_getpgid () : 0;
-      if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
+      if (!iscygwin () && ctty_pgid &&
+	  ctty_pgid != (args.pgid == -1 ? myself->pgid : args.pgid))
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();

@@ -843,7 +844,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  myself->set_has_pgid_children ();
 	  ProtectHandle (pi.hThread);
 	  pinfo child (cygpid,
-		       PID_IN_USE | (real_path.iscygexec () ? 0 : PID_NOTCYGWIN));
+		       PID_IN_USE |
+		       (real_path.iscygexec () ? 0 : PID_NOTCYGWIN) |
+		       ((c_flags & CREATE_NEW_PROCESS_GROUP) ? PID_NEW_PG : 0));
 	  if (!child)
 	    {
 	      syscall_printf ("pinfo failed");
@@ -854,6 +857,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  child->dwProcessId = pi.dwProcessId;
 	  child.hProcess = pi.hProcess;
+	  if (args.pgid != -1)
+	    child->pgid = args.pgid ?: cygpid;

 	  real_path.get_wide_win32_path (child->progname);
 	  /* This introduces an unreferenced, open handle into the child.
@@ -1463,17 +1468,27 @@ do_posix_spawn (pid_t *pid, const char *path,

   /* TODO: possibly implement spawnattr flags:
      POSIX_SPAWN_RESETIDS
-     POSIX_SPAWN_SETPGROUP
      POSIX_SPAWN_SETSCHEDPARAM
      POSIX_SPAWN_SETSCHEDULER */
   if (sa)
     {
-      if ((*sa)->sa_flags & ~(POSIX_SPAWN_SETSIGMASK|POSIX_SPAWN_SETSIGDEF))
+      static const short FASTPATH_FLAGS =
+	POSIX_SPAWN_SETSIGMASK|POSIX_SPAWN_SETSIGDEF|POSIX_SPAWN_SETPGROUP;
+      if ((*sa)->sa_flags & ~FASTPATH_FLAGS)
 	goto fallback;

       if ((*sa)->sa_flags & POSIX_SPAWN_SETSIGMASK)
 	args.sigmask = &(*sa)->sa_sigmask;

+      if ((*sa)->sa_flags & POSIX_SPAWN_SETPGROUP)
+	{
+	  args.pgid = (*sa)->sa_pgroup;
+	  if (args.pgid < 0)
+	    return EINVAL;
+	  /* According to POSIX there should be more error cases, but setpgid
+	     does not implement them, so replicate its behavior. */
+	}
+
       if ((*sa)->sa_flags & POSIX_SPAWN_SETSIGDEF)
 	{
 	  sigs = (struct sigaction *) cmalloc (HEAP_SIGS,
-- 
2.49.0.windows.1

