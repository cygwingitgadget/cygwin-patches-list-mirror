Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1EC083854A95
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:42:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1EC083854A95
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1EC083854A95
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413376; cv=none;
	b=EDhMDimnGabMtnzQDFj1a7gWlt3g67ledlCY+s12sh93Ru1UJPcVu74UOZVcMxVt9ssenA1zvCEgCqPaMJMNfhLIkXr8nGN6HY85NBruHVq3bSQvz38rWUcwdGmSmjKoXbM1Jc9lB93c4Mm9tBffNT6MTqN2uznV4L+XMm3W/I0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413376; c=relaxed/simple;
	bh=Zzg1z8jewFdKvdfkXvXnleQU2L54xbq1/KoyUsSL87g=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=JBvOruZerzAApVDfhvkLel+pRhVsq7uS5iiItTjj0JnCT5FQ4WtHT8odQJooHHK1Yz09hVb73fynLmNo3gbSz3dJ/gDr/b23xKfAsMtnZH0GhMOGzIrExEPYlUPSWUslRZzczRQXunBZYE+B+Nqw7vAoSZdKH9sjMjETVIK3bVE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1EC083854A95
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ZDpHPEUC
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id ED03545CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:42:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=trjKO
	yc3XMJZBKnd2QnlXKEJYRg=; b=ZDpHPEUCojMyemN+dRYFfFJF5sW+ShoGEQxg5
	kdBQbDMhb8CAxoltxVbWENKxdG7yZsHo4kXb3PJspNcxIanwFmXwBmLcqm4bcMA+
	2md+lAY0qSK8fpYaQzS2ctiwsg6Du08xJoKnQCi04aq8/1ISAD4KeSbx8d7ocDif
	EGX6/I=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D585545CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:42:55 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:42:55 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/6] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <eb1ac9d3-350b-1df4-72ea-bcfe4861ceaf@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

stdin and stdout were alreadly allowed for popen, but implementing
posix_spawn in terms of spawn would require stderr as well.

Replace the conveniently-located 4 filler bytes with int __stderr so
that child_info_spawn doesn't have to grow.

Introduce a struct for passing additional args to ch_worker.spawn, since
there are getting to be quite a lot of additional args.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dcrt0.cc                    |  2 ++
 winsup/cygwin/local_includes/child_info.h | 16 ++++++++++++---
 winsup/cygwin/spawn.cc                    | 25 ++++++++++++-----------
 winsup/cygwin/syscalls.cc                 | 14 ++++++-------
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c247..b0fb5c9c1e 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -662,6 +662,8 @@ child_info_spawn::handle_spawn ()
     cygheap->fdtab.move_fd (__stdin, 0);
   if (__stdout >= 0)
     cygheap->fdtab.move_fd (__stdout, 1);
+  if (__stderr >= 0)
+    cygheap->fdtab.move_fd (__stderr, 2);
   cygheap->user.groups.clear_supp ();

   /* If we're execing we may have "inherited" a list of children forked by the
diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 2da62ffaa3..9f6f45db46 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)

 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
+#define CURR_CHILD_INFO_MAGIC 0x8af37cfU

 #include "pinfo.h"
 struct cchildren
@@ -135,6 +135,16 @@ public:
   void reattach_children (HANDLE);
 };

+struct spawn_worker_args
+{
+  int mode;
+  int stdfds[3];
+
+  spawn_worker_args (int mode)
+    : mode (mode), stdfds {-1, -1, -1}
+  { }
+};
+
 class child_info_spawn: public child_info
 {
   HANDLE hExeced;
@@ -145,7 +155,7 @@ public:
   cygheap_exec_info *moreinfo;
   int __stdin;
   int __stdout;
-  char filler[4];
+  int __stderr;

   void cleanup ();
   child_info_spawn () {};
@@ -190,7 +200,7 @@ public:
   bool has_execed_cygwin () const { return iscygwin () && has_execed (); }
   operator HANDLE& () {return hExeced;}
   int worker (const char *, const char *const *, const char *const [],
-		     int, int = -1, int = -1);
+	      const spawn_worker_args &);
 };

 extern child_info_spawn ch_spawn;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index ef175e7082..4d7790047e 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -280,16 +280,16 @@ extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */

 int
 child_info_spawn::worker (const char *prog_arg, const char *const *argv,
-			  const char *const envp[], int mode,
-			  int in__stdin, int in__stdout)
+			  const char *const envp[],
+			  const spawn_worker_args &args)
 {
   bool rc;
   int res = -1;

   /* Check if we have been called from exec{lv}p or spawn{lv}p and mask
      mode to keep only the spawn mode. */
-  bool p_type_exec = !!(mode & _P_PATH_TYPE_EXEC);
-  mode = _P_MODE (mode);
+  bool p_type_exec = !!(args.mode & _P_PATH_TYPE_EXEC);
+  int mode = _P_MODE (args.mode);

   if (prog_arg == NULL)
     {
@@ -515,8 +515,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  __leave;
 	}
       set (chtype, real_path.iscygexec ());
-      __stdin = in__stdin;
-      __stdout = in__stdout;
+      __stdin = args.stdfds[0];
+      __stdout = args.stdfds[1];
+      __stderr = args.stdfds[2];
       record_children ();

       si.lpReserved2 = (LPBYTE) this;
@@ -577,9 +578,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			 PROCESS_QUERY_LIMITED_INFORMATION))
 	sa = &sec_none_nih;

-      int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
-      int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
-      int fileno_stderr = 2;
+      int fileno_stdin = args.stdfds[0] < 0 ? 0 : args.stdfds[0];
+      int fileno_stdout = args.stdfds[1] < 0 ? 1 : args.stdfds[1];
+      int fileno_stderr = args.stdfds[2] < 0 ? 2 : args.stdfds[2];

       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
@@ -946,7 +947,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
-      ch_spawn.worker (path, argv, envp, mode);
+      ch_spawn.worker (path, argv, envp, spawn_worker_args (mode));
       /* Errno should be set by worker.  */
       ret = -1;
       break;
@@ -956,7 +957,7 @@ spawnve (int mode, const char *path, const char *const *argv,
     case _P_WAIT:
     case _P_DETACH:
     case _P_SYSTEM:
-      ret = ch_spawn.worker (path, argv, envp, mode);
+      ret = ch_spawn.worker (path, argv, envp, spawn_worker_args (mode));
       break;
     default:
       set_errno (EINVAL);
@@ -1371,7 +1372,7 @@ __posix_spawn_execvpe (const char *path, char * const *argv, char *const *envp,
   ch_spawn.set_sem (sem);
   ch_spawn.worker (use_env_path ? (find_exec (path, buf, "PATH", FE_NNF) ?: "")
 				: path,
-		   argv, envp, _P_OVERLAY);
+		   argv, envp, spawn_worker_args (_P_OVERLAY));
   __posix_spawn_sem_release (sem, errno);
   return -1;
 }
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index d6a2c2d3b3..c8e0908290 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4507,10 +4507,11 @@ popen (const char *command, const char *in_type)
       int stdchild = myix ^ 1;	/* stdchild denotes the index into fd for the
 				   handle which will be redirected to
 				   stdin/stdout */
-      int __std[2];
-      __std[myix] = -1;		/* -1 means don't pass this fd to the child
-				   process */
-      __std[stdchild] = fds[stdchild]; /* Do pass this as the std handle */
+      spawn_worker_args spawnargs (_P_NOWAIT);
+      spawnargs.stdfds[myix] = -1; /* -1 means don't pass this fd to the child
+				      process */
+      spawnargs.stdfds[stdchild] = fds[stdchild]; /* Do pass this as the std
+						     handle */

       const char *argv[4] =
 	{
@@ -4524,7 +4525,7 @@ popen (const char *command, const char *in_type)
          end of the pipe.  Otherwise don't pass our end of the pipe to the
 	 child process. */
       if (pipe_flags & O_CLOEXEC)
-	fcntl (__std[stdchild], F_SETFD, 0);
+	fcntl (spawnargs.stdfds[stdchild], F_SETFD, 0);
       else
 	fcntl (myfd, F_SETFD, FD_CLOEXEC);

@@ -4535,8 +4536,7 @@ popen (const char *command, const char *in_type)
       fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);

       /* Start a shell process to run the given command without forking. */
-      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, _P_NOWAIT,
-				   __std[0], __std[1]);
+      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, spawnargs);

       /* Reinstate the close-on-exec state */
       fcntl (stdchild, F_SETFD, stdchild_state);
-- 
2.49.0.windows.1

