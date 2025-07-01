Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 769E63854A95
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:43:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 769E63854A95
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 769E63854A95
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413428; cv=none;
	b=Ji9PTRspldjNzWvLCRbPPRZaWbFaalc6RgdUTWUO4b84MsrHncQiLZG3Yan8ldPJCUKILI8FxoNRt0rwkm37fEc9vijbaOEdC1oDQwdLnSI0e7w9vl6m5GMrxOC8oQ6E3K5TSJXd4oVYwaAJPbWq2SL8FzCnd+v5ugPav0atnew=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413428; c=relaxed/simple;
	bh=+s7ahskWno28hHCH2MSj6bqnNqTBXquQsJEZW4lmMvw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vloOZV4aYH5R8njTV2ujk37cKQAIsmNw4nzS4bs+Hwjp2QYmc2dmGpINZCYAc7wjUkb7PMaP60DCyqfrjl88fjLy0fh+I2k92ufWEptAFEJugLJ8PG3KMjOyB/R3lW34hs0b+jREFQoX1gPbF3xfvRq1dqHHmvnb6X/6GamUMhQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 769E63854A95
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=P7UmVSdi
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5108345CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:43:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=8TS6G
	WYys0N7zHvXhhip61se0sQ=; b=P7UmVSdicro5TNXjClb7+wJl1dAcMyZ0B4wL1
	mgwk4GTc8wJ2V2dbn2Zg/4M2RFYYZWB7mAeVHtcLC/cIPL0vx98YG20F0LlbE1hA
	6Cbd8cm0R8lI89RLZZvci0IBXkAG63NtT0Je7UWU/wnm+J1o6lWy/oE1yLdJmHkQ
	ssnfT4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4B2D145CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:43:48 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:43:48 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/6] Cygwin: add ability to pass cwd to child process
Message-ID: <66a1dec3-77a2-6c9f-0388-da2f85489e89@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This will be used by posix_spawn_fileaction_add_(f)chdir.

The int cwdfd is placed such that it fits into space previously unused
due to alignment in the cygheap_exec_info class.

This uses a file descriptor rather than a path both because it is easier
to marshal to the child and because this should protect against races
where the directory might be renamed or removed between addfchdir and
the actual setting of the cwd in the child.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dcrt0.cc                    |  19 +++-
 winsup/cygwin/local_includes/child_info.h |   4 +-
 winsup/cygwin/local_includes/path.h       |   6 +-
 winsup/cygwin/local_includes/winf.h       |   2 +-
 winsup/cygwin/spawn.cc                    | 100 ++++++++++++++++++----
 winsup/cygwin/syscalls.cc                 |   4 +-
 6 files changed, 113 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index b0fb5c9c1e..6adc31495a 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -46,6 +46,7 @@ extern "C" void __sinit (_reent *);

 static int NO_COPY envc;
 static char NO_COPY **envp;
+static int NO_COPY cwdfd = AT_FDCWD;

 bool NO_COPY jit_debug;

@@ -656,6 +657,7 @@ child_info_spawn::handle_spawn ()
   __argv = moreinfo->argv;
   envp = moreinfo->envp;
   envc = moreinfo->envc;
+  cwdfd = moreinfo->cwdfd;
   if (!dynamically_loaded)
     cygheap->fdtab.fixup_after_exec ();
   if (__stdin >= 0)
@@ -842,7 +844,22 @@ dll_crt0_1 (void *)

   ProtectHandle (hMainThread);

-  cygheap->cwd.init ();
+  if (cwdfd >= 0)
+    {
+      int res = fchdir (cwdfd);
+      if (res < 0)
+	{
+	  /* if the error occurs after the calling process successfully
+	     returns, the child process shall exit with exit status 127. */
+	  /* why is this byteswapped? */
+	  set_api_fatal_return (0x7f00);
+	  api_fatal ("can't fchdir, %R", res);
+	}
+      close (cwdfd);
+      cwdfd = AT_FDCWD;
+    }
+  else
+    cygheap->cwd.init ();

   /* Initialize pthread mainthread when not forked and it is safe to call new,
      otherwise it is reinitalized in fixup_after_fork */
diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 9f6f45db46..ad7c8fc29a 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -128,6 +128,7 @@ public:
   int envc;
   char **envp;
   HANDLE myself_pinfo;
+  int cwdfd;
   int nchildren;
   cchildren children[0];
   static cygheap_exec_info *alloc ();
@@ -139,9 +140,10 @@ struct spawn_worker_args
 {
   int mode;
   int stdfds[3];
+  int cwdfd;

   spawn_worker_args (int mode)
-    : mode (mode), stdfds {-1, -1, -1}
+    : mode (mode), stdfds {-1, -1, -1}, cwdfd (AT_FDCWD)
   { }
 };

diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
index 1fd542c96b..74dafcc436 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -462,6 +462,9 @@ class path_conv
 /* Interix symlink marker */
 #define INTERIX_SYMLINK_COOKIE  "IntxLNK\1"

+int gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
+		      int flags = 0);
+
 enum fe_types
 {
   FE_NADA = 0,		/* Nothing special */
@@ -472,7 +475,8 @@ enum fe_types
 const char *find_exec (const char *name, path_conv& buf,
 				 const char *search = "PATH",
 				 unsigned opt = FE_NADA,
-				 const char **known_suffix = NULL);
+				 const char **known_suffix = NULL,
+				 int cwdfd = AT_FDCWD);

 /* Common macros for checking for invalid path names */
 #define isdrive(s) (isalpha (*(s)) && (s)[1] == ':')
diff --git a/winsup/cygwin/local_includes/winf.h b/winsup/cygwin/local_includes/winf.h
index b586934410..57ccd2df32 100644
--- a/winsup/cygwin/local_includes/winf.h
+++ b/winsup/cygwin/local_includes/winf.h
@@ -63,7 +63,7 @@ class av
     calloced = argc;
   }
   int setup (const char *, path_conv&, const char *, int, const char *const *,
-	     bool);
+	     bool, int = AT_FDCWD);
 };

 class linebuf
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 4d7790047e..629a648a18 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -37,12 +37,25 @@ details. */
    Returns (possibly NULL) suffix */

 static const char *
-perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
+perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt,
+		int cwdfd)
 {
+  tmp_pathbuf tp;
   const char *ext;

   err = 0;
   debug_printf ("prog '%s'", prog);
+  if (cwdfd != AT_FDCWD && !isabspath_strict (prog))
+    {
+      char *tmp = tp.c_get ();
+      if (gen_full_path_at (tmp, cwdfd, prog))
+	{
+	  err = get_errno ();
+	  return NULL;
+	}
+      prog = tmp;
+    }
+
   buf.check (prog,
 	     PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP | PC_NULLEMPTY | PC_POSIX,
 	     stat_suffixes);
@@ -79,7 +92,7 @@ perhaps_suffix (const char *prog, path_conv& buf, int& err, unsigned opt)
    and NULL is returned.  */
 const char *
 find_exec (const char *name, path_conv& buf, const char *search,
-	   unsigned opt, const char **known_suffix)
+	   unsigned opt, const char **known_suffix, int cwdfd)
 {
   const char *suffix = "";
   const char *retval = NULL;
@@ -94,7 +107,7 @@ find_exec (const char *name, path_conv& buf, const char *search,

   /* Check to see if file can be opened as is first. */
   if ((has_slash || opt & FE_CWD)
-      && (suffix = perhaps_suffix (name, buf, err, opt)) != NULL)
+      && (suffix = perhaps_suffix (name, buf, err, opt, cwdfd)) != NULL)
     {
       /* Overwrite potential symlink target with original path.
 	 See comment preceeding this method. */
@@ -153,7 +166,7 @@ find_exec (const char *name, path_conv& buf, const char *search,

       int err1;

-      if ((suffix = perhaps_suffix (tmp_path, buf, err1, opt)) != NULL)
+      if ((suffix = perhaps_suffix (tmp_path, buf, err1, opt, cwdfd)) != NULL)
 	{
 	  if (buf.has_acls () && check_file_access (buf, X_OK, true))
 	    continue;
@@ -350,19 +363,79 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,

       int err;
       const char *ext;
-      if ((ext = perhaps_suffix (prog_arg, real_path, err, FE_NADA)) == NULL)
+      if ((ext = perhaps_suffix (prog_arg, real_path, err, FE_NADA,
+				 args.cwdfd)) == NULL)
 	{
 	  set_errno (err);
 	  res = -1;
 	  __leave;
 	}

-      res = newargv.setup (prog_arg, real_path, ext, ac, argv, p_type_exec);
+      res = newargv.setup (prog_arg, real_path, ext, ac, argv, p_type_exec,
+			   args.cwdfd);

       if (res)
 	__leave;

-      if (!real_path.iscygexec () && ::cygheap->cwd.get_error ())
+      LPWSTR cwd = NULL;
+      if (real_path.iscygexec ())
+	{
+	  moreinfo->argc = newargv.argc;
+	  moreinfo->argv = newargv;
+	  moreinfo->cwdfd = args.cwdfd;
+	}
+
+      if (args.cwdfd > 0)
+        {
+	  cygheap_fdget cfd (args.cwdfd);
+	  if (cfd < 0)
+	    {
+	      set_errno (EBADF);
+	      res = -1;
+	      __leave;
+	    }
+	  cfd->set_close_on_exec (!real_path.iscygexec ());
+	  if (!real_path.iscygexec ())
+	    {
+	      PUNICODE_STRING natcwd = cfd->pc.get_nt_native_path ();
+	      cwd = tp.w_get ();
+	      USHORT len = natcwd->Length / sizeof (WCHAR);
+	      if (RtlEqualUnicodePathPrefix (natcwd, &ro_u_natp, FALSE))
+		{
+		  cwd = cfd->pc.get_wide_win32_path (cwd);
+		  if (len < MAX_PATH + 2)
+		    {
+		      if (cwd[5] == L':')
+			cwd += 4;
+		      else
+			*(cwd += 6) = L'\\';
+		    }
+		  else
+		    {
+		      set_errno (ENAMETOOLONG);
+		      res = -1;
+		      __leave;
+		    }
+		}
+	      else if (len <
+			NT_MAX_PATH - ro_u_globalroot.Length / sizeof (WCHAR))
+		{
+		  UNICODE_STRING ucwd;
+
+		  RtlInitEmptyUnicodeString (&ucwd, cwd,
+					    (NT_MAX_PATH - 1) * sizeof (WCHAR));
+		  RtlCopyUnicodeString (&ucwd, &ro_u_globalroot);
+		  RtlAppendUnicodeStringToString (&ucwd, natcwd);
+		}
+	      else
+		{
+		  set_errno (ENAMETOOLONG);
+		  res = -1;
+		  __leave;
+		}
+	    }
+	}
+      else if (!real_path.iscygexec () && ::cygheap->cwd.get_error ())
 	{
 	  small_printf ("Error: Current working directory %s.\n"
 			"Can't start native Windows application from here.\n\n",
@@ -372,11 +445,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  __leave;
 	}

-      if (real_path.iscygexec ())
-	{
-	  moreinfo->argc = newargv.argc;
-	  moreinfo->argv = newargv;
-	}
       if ((wincmdln || !real_path.iscygexec ())
 	   && !cmd.fromargv (newargv, real_path.get_win32 (),
 			     real_path.iscygexec ()))
@@ -624,7 +692,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			       TRUE,		/* inherit handles */
 			       c_flags,
 			       envblock,	/* environment */
-			       NULL,
+			       cwd,
 			       &si,
 			       &pi);
 	}
@@ -676,7 +744,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			       TRUE,		/* inherit handles */
 			       c_flags,
 			       envblock,	/* environment */
-			       NULL,
+			       cwd,
 			       &si,
 			       &pi);
 	  if (hwst)
@@ -1087,7 +1155,7 @@ spawnvpe (int mode, const char *file, const char * const *argv,

 int
 av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
-	   int ac_in, const char *const *av_in, bool p_type_exec)
+	   int ac_in, const char *const *av_in, bool p_type_exec, int cwdfd)
 {
   const char *p;
   bool exeext = ascii_strcasematch (ext, ".exe");
@@ -1266,7 +1334,7 @@ av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
 	if (arg1)
 	  unshift (arg1);

-	find_exec (pgm, real_path, "PATH", FE_NADA, &ext);
+	find_exec (pgm, real_path, "PATH", FE_NADA, &ext, cwdfd);
 	unshift (real_path.get_posix ());
       }
   if (real_path.iscygexec ())
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index c8e0908290..fa0981cd2f 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4615,9 +4615,9 @@ pclose (FILE *fp)

 /* Preliminary(?) implementation of the openat family of functions. */

-static int
+int
 gen_full_path_at (char *path_ret, int dirfd, const char *pathname,
-		  int flags = 0)
+		  int flags)
 {
   /* futimesat allows a NULL pathname. */
   if (!pathname && !(flags & _AT_NULL_PATHNAME_ALLOWED))
-- 
2.49.0.windows.1

