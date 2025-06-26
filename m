Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 93762385C6F5
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 23:56:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 93762385C6F5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 93762385C6F5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750982201; cv=none;
	b=nO3aYSu8JlKgOPpmgLJ/FhKt3KvCwc5JskczZU5A6CxDe4vWv4hKN5emyGsROOEQqWENgmgoNK7kdHSkk1Z5cQPUS+dzOJn6VE6LO4MYBqI/oazO4tNDo7q4TG8aGvBr/fwYEoU1Fh+w3EIDjP8NX8M50tMGNH+TjZMnE8nMV48=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750982201; c=relaxed/simple;
	bh=YL80wdbSX/ZkfpNR+rdClReKfvAfKWBLlgl5xYPdDLg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=LDPQOv2TIie+Pyr88gRI1Ks1FZL4R3iEEdp5cXj0eTZuKp22W+95F/TE+BpmMZXrFa7m8g5Fvkd2pVm8paxBj5ROFETAOPoLp+SJavuHWq5f0tpw25pnh/CN7YI7zR3HeY71VjX7E4cJshCTDQeL2yeiT+QoZETtTdvd0TgMzGI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 93762385C6F5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=GANV799m
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6FB8A45D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:56:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=9RTnI
	dF5gpH4Eg2ObhcHe1RDAGA=; b=GANV799mObfv4JdtLwbc6Y4ZqohTeyMJajNLR
	8zz/8/uUW9VArotKzxAiml5Uc92qcOt3Dqji/bT7ln8YxY2TTBpp4+/FDE4Rg2Pv
	miabwpPk3RR4JKoYrQPLBbXqlDfETnxXkoj7iBSwlDFsAhIth7EgO6e8VE0BKuwh
	wIFmSs=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 68DF645D30
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:56:41 -0400 (EDT)
Date: Thu, 26 Jun 2025 16:56:41 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/5] Cygwin: add ability to pass cwd to child process
Message-ID: <24e81c12-102f-9afe-206f-ec65577e9a3b@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This will be used by posix_spawn_fileaction_add_(f)chdir.

This implementation is not quite complete enough for posix_spawn, as it
also needs to treat relative paths to the program as relative to the
specified CWD.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/dcrt0.cc                    | 19 +++++-
 winsup/cygwin/local_includes/child_info.h |  5 +-
 winsup/cygwin/spawn.cc                    | 72 ++++++++++++++++++++---
 3 files changed, 84 insertions(+), 12 deletions(-)

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
index 902be8727b..95bdd5cd1c 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)

 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0x6ccb18aeU
+#define CURR_CHILD_INFO_MAGIC 0xeb5dce32U

 #include "pinfo.h"
 struct cchildren
@@ -128,6 +128,7 @@ public:
   int envc;
   char **envp;
   HANDLE myself_pinfo;
+  int cwdfd;
   int nchildren;
   cchildren children[0];
   static cygheap_exec_info *alloc ();
@@ -190,7 +191,7 @@ public:
   bool has_execed_cygwin () const { return iscygwin () && has_execed (); }
   operator HANDLE& () {return hExeced;}
   int worker (const char *, const char *const *, const char *const [],
-		     int, int = -1, int = -1, int = -1);
+		     int, int = -1, int = -1, int = -1, int = AT_FDCWD);
 };

 extern child_info_spawn ch_spawn;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 9a7f0bbf73..8625725d49 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -281,7 +281,8 @@ extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
 int
 child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			  const char *const envp[], int mode,
-			  int in__stdin, int in__stdout, int in__stderr)
+			  int in__stdin, int in__stdout, int in__stderr,
+			  int cwdfd)
 {
   bool rc;
   int res = -1;
@@ -362,7 +363,65 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       if (res)
 	__leave;

-      if (!real_path.iscygexec () && ::cygheap->cwd.get_error ())
+      LPWSTR cwd = NULL;
+      if (real_path.iscygexec ())
+	{
+	  moreinfo->argc = newargv.argc;
+	  moreinfo->argv = newargv;
+	  moreinfo->cwdfd = cwdfd;
+	}
+
+      if (cwdfd > 0)
+        {
+	  cygheap_fdget cfd (cwdfd);
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
@@ -372,11 +431,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
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
@@ -624,7 +678,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			       TRUE,		/* inherit handles */
 			       c_flags,
 			       envblock,	/* environment */
-			       NULL,
+			       cwd,
 			       &si,
 			       &pi);
 	}
@@ -676,7 +730,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			       TRUE,		/* inherit handles */
 			       c_flags,
 			       envblock,	/* environment */
-			       NULL,
+			       cwd,
 			       &si,
 			       &pi);
 	  if (hwst)
-- 
2.49.0.windows.1

