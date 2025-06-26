Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 22698385C6DE
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 20:33:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 22698385C6DE
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 22698385C6DE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750970032; cv=none;
	b=EQ9PXRkwjngjskrLs5So5eNu6reC3/h16Zb9sFTLqk7P6U4uWuMRnbLmgSInB3mRprpvgNsG7X5QrnfEML+GbiVY4PU83m2OL2j8yJJkn5MS8b75QGe5R1tJb44MI/DNEzzFKAxcveoQezeJ24jzYQPkl17nDGjdyC5Gwgtlze8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750970032; c=relaxed/simple;
	bh=Hki1lknvzhrAFMQrP5/wbYpe1cen1E7aJ735NRs9Wpo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=N+R2JSp887gd+hfDd1X46GpZ19duZfJEut83m0+uY7yui1XlXGFGTNwGMILUkeA+UFKkZpuNS1izZSceg2J9wb21xsqAqZulnedAHyVCpLhRWNP1pGbb3tW3zxL3onu34qF0sNIHxPMYXSP93RBuYdZ6pLBRX0UxKSyVxI98AWw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 22698385C6DE
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=LJRud6rA
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id ECEC545D3B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=sjGZr
	ArPE+mkOvGb/FRWgggI3vo=; b=LJRud6rA+/2jdJDOVhUA0U1HM3JOw5bSkUgqi
	+UTDHjD1Jiho0WXCAfGA1f44mlUW7P8UJ32mwO9xdjc2jPKw7/rSZ91ErEUZBxNj
	+tu0u24UwrvolgjsFOO+qerXeLo13N8IRuY0S72Zw7Go6DfK10ws3Dg0YduN3HJ1
	X8YTQY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D223245D37
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 16:33:51 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:33:51 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: testsuite: test posix_spawn of a non-Cygwin
 executable.
Message-ID: <21125701-8385-d5ca-9dcb-702f862f90ee@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Test CWD and redirection of standard handles.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/Makefile.am                  |   1 +
 .../testsuite/winsup.api/posix_spawn/win32.c  | 170 ++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/win32.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 03f65d8184..20e06b9c51 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -316,6 +316,7 @@ check_PROGRAMS = \
 	winsup.api/posix_spawn/fds \
 	winsup.api/posix_spawn/signals \
 	winsup.api/posix_spawn/spawnp \
+	winsup.api/posix_spawn/win32 \
 	winsup.api/samples/sample-fail \
 	winsup.api/samples/sample-pass
 # winsup.api/ltp/ulimit01 is omitted as we don't have <ulimit.h>
diff --git a/winsup/testsuite/winsup.api/posix_spawn/win32.c b/winsup/testsuite/winsup.api/posix_spawn/win32.c
new file mode 100644
index 0000000000..cd2bedcd95
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/win32.c
@@ -0,0 +1,170 @@
+#include "test.h"
+#include <dlfcn.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/cygwin.h>
+#include <unistd.h>
+
+char * find_winchild (void)
+{
+  static const char winchild[] = "/winchild";
+  char *mingwtestdir = getenv ("mingwtestdir");
+  if (!mingwtestdir)
+    {
+      Dl_info dli;
+      if (dladdr (&find_winchild, &dli))
+        {
+	  ssize_t i = strlen (dli.dli_fname) - 1;
+	  for (int slashes = 0; i >= 0 && slashes < 3; --i)
+	    if (dli.dli_fname[i] == '/')
+	      slashes++;
+	  stpcpy (stpcpy (dli.dli_fname + i + 1, "/mingw"), winchild);
+	  return realpath (dli.dli_fname, NULL);
+	}
+      else
+        {
+	  return realpath ("../../mingw/winchild", NULL);
+	}
+    }
+  else
+    {
+      char *ret, *tmp = malloc (strlen (mingwtestdir) + sizeof (winchild));
+      stpcpy (stpcpy (tmp, mingwtestdir), winchild);
+      ret = realpath (tmp, NULL);
+      free (tmp);
+      return ret;
+    }
+}
+
+static char tmppath[] = "pspawn.XXXXXX";
+static char tmpcwd[] = "tmpcwd.XXXXXX";
+static char tmppath2[sizeof (tmpcwd) + 9] = {0};
+
+static void cleanup_tmpfiles (void)
+{
+  if (tmppath2[0])
+    unlink (tmppath2);
+  rmdir (tmpcwd);
+  unlink (tmppath);
+}
+
+int main (void)
+{
+  posix_spawn_file_actions_t fa;
+  pid_t pid;
+  int status;
+  int fd, fdcloexec, cwdfd;
+  char *childargv[] = {"winchild", NULL, NULL, NULL};
+  char *winchild = find_winchild ();
+
+  /* unbuffer stdout */
+  setvbuf(stdout, NULL, _IONBF, 0);
+
+  /* temp regular file */
+  negError (fd = mkstemp (tmppath));
+  atexit (cleanup_tmpfiles);
+  negError (close (fd));
+
+  /* temp directory */
+  nullError (mkdtemp (tmpcwd));
+
+  /* temp file within temp directory */
+  stpcpy (stpcpy (stpcpy (tmppath2, tmpcwd), "/"), "tmpfile2");
+  negError (fd = open (tmppath2, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR));
+  negError (close (fd));
+
+  /* open file descriptors to test inheritance */
+  negError (fd = open ("/dev/null", O_RDONLY, 0644));
+  negError (fdcloexec = open ("/dev/full", O_RDONLY|O_CLOEXEC, 0644));
+
+  /* test posix_spawn_file_actions_addopen */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 0, "/dev/zero", O_RDONLY,
+					     0644));
+  childargv[1] = "0";
+  childargv[2] = "\\Device\\Null";
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_adddup2 */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, fd, 0));
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_adddup2 with CLOEXEC fd */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, fdcloexec, 0));
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_adddup2 with out to err */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, "/dev/zero", O_WRONLY,
+					     0644));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, 1, 2));
+  childargv[1] = "2";
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_addopen with real file */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, tmppath, O_WRONLY, 0644));
+  childargv[1] = "1";
+  childargv[2] = cygwin_create_path (CCP_POSIX_TO_WIN_A|CCP_ABSOLUTE, tmppath);
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+  free (childargv[2]);
+
+  /* test posix_spawn_file_actions_addchdir */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addchdir (&fa, tmpcwd));
+  childargv[1] = "CWD";
+  childargv[2] = cygwin_create_path (CCP_POSIX_TO_WIN_A|CCP_ABSOLUTE, tmpcwd);
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_addfchdir */
+  negError (cwdfd = open (tmpcwd, O_SEARCH|O_DIRECTORY|O_CLOEXEC, 0755));
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addfchdir (&fa, cwdfd));
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+  free (childargv[2]);
+
+  /* test posix_spawn_file_actions_addfchdir followed by addopen */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addfchdir (&fa, cwdfd));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, "tmpfile2", O_WRONLY, 0644));
+  childargv[1] = "1";
+  childargv[2] = cygwin_create_path (CCP_POSIX_TO_WIN_A|CCP_ABSOLUTE, tmppath2);
+  errCode (posix_spawn (&pid, winchild, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+  free (childargv[2]);
+
+  negError (close (cwdfd));
+  negError (close (fd));
+  negError (close (fdcloexec));
+
+  return 0;
+}
-- 
2.49.0.windows.1

