Return-Path: <SRS0=JvsG=ZH=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 240D03858405
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 20:54:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 240D03858405
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 240D03858405
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750798460; cv=none;
	b=RsI7Sk6lWHUNX9YEV0QMoa2T+HT3mVNdtTSnEeUItmM5Rnz+6G4T6F++UEK/2aYoGmMGhOGMc7zOwV1g27HlTrFt+M3X3sBwKbfpOD31f7y4FnGyLgfN2aDHl17SbmSGKSBPWAuNklQ0GidPs0m28SKG7j2mPdeFXwZrUytZjzg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750798460; c=relaxed/simple;
	bh=jCzA3GJ0oI8vPEmT3+UAtSlavdyQlpiMHmYGnk1DJuc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DJZetc2492jsi8mLi1l/8JBYNUl5wvAl0U2zv8zaVfP7vaC4o0p0Ltochn4AXVXrr3PvyvOW0RMo3n/w+w2i9jiPXx4BVYB6MH4enqQjCiSSxNXQS6bLTpYmUt1/Ue4rtN5Z+PMF5zbyvNvngdtvjIsHmE60gX/eHBbJqQJjuCk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 240D03858405
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=m4QVosgP
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id F31EA45CEB
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 16:47:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=boda9
	cykv4lloL6EYgW0SmBCz0I=; b=m4QVosgP+26l95hAd3agx7cGqypY8LXU4nc5X
	eR2gvbs8vlm254DZM1Ei2GXKWNrsPrRxUCbwjH18C6Fji4npa4hYo/RuFQrJBoXa
	BYw6KOwWJ8/ZNgls4vCnD1inMgl8xqJpqqM1C1OOF29/fVw0Zxsa1tYkkdnWn2dt
	9j3Gc8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EC9A045CE9
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 16:47:41 -0400 (EDT)
Date: Tue, 24 Jun 2025 13:47:41 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: testsuite: test posix_file_actions_add(f)chdir
Message-ID: <4e2155b6-941b-29b6-e610-059f8a1e7539@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Also test their interaction with addopen, as opens added subsequent to a
chdir need to be relative to that new cwd.

In order for the tests to compile on Linux, define O_SEARCH to O_PATH if
O_SEARCH is not defined, and use the *chdir_np names instead of the
now-standardized *chdir.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/Makefile.am                  |   1 +
 .../testsuite/winsup.api/posix_spawn/chdir.c  | 146 ++++++++++++++++++
 winsup/testsuite/winsup.api/posix_spawn/fds.c |   2 +-
 .../testsuite/winsup.api/posix_spawn/test.h   |   5 +
 4 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/chdir.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 4b056bd5bf..957554a828 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -311,6 +311,7 @@ check_PROGRAMS = \
 	winsup.api/pthread/self2 \
 	winsup.api/pthread/threadidafterfork \
 	winsup.api/pthread/tsd1 \
+	winsup.api/posix_spawn/chdir \
 	winsup.api/posix_spawn/errors \
 	winsup.api/posix_spawn/fds \
 	winsup.api/posix_spawn/signals \
diff --git a/winsup/testsuite/winsup.api/posix_spawn/chdir.c b/winsup/testsuite/winsup.api/posix_spawn/chdir.c
new file mode 100644
index 0000000000..c6ccc45fb2
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/chdir.c
@@ -0,0 +1,146 @@
+#include "test.h"
+#include <fcntl.h>
+#include <limits.h>
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* Linux is behind the times a bit (also needs the *chdir_np functions) */
+#ifndef O_SEARCH
+#  define O_SEARCH O_PATH
+#endif
+
+int handle_child (char *expected)
+{
+  char buf[PATH_MAX + 1];
+
+  nullError (getcwd (buf, sizeof (buf)));
+  testAssertMsg (!strcmp (buf, expected), "cwd '%s' != expected '%s'",
+		 buf, expected);
+
+  return 0;
+}
+
+int handle_childfds (char *expectedcwd, char *expectedfd0, char *expectedfd1)
+{
+  char buf[PATH_MAX + 1];
+  ssize_t ret;
+
+  testAssert (handle_child (expectedcwd) == 0);
+
+  negError (ret = readlink ("/dev/fd/0", buf, PATH_MAX));
+  testAssertMsg (ret < PATH_MAX, "Path too long for PATH_MAX buffer");
+  buf[ret] = '\0';
+  testAssertMsg (!strcmp (buf, expectedfd0), "fd 0 '%s' != expected '%s'",
+		 buf, expectedfd0);
+
+  negError (ret = readlink ("/dev/fd/1", buf, PATH_MAX));
+  testAssertMsg (ret < PATH_MAX, "Path too long for PATH_MAX buffer");
+  buf[ret] = '\0';
+  testAssertMsg (!strcmp (buf, expectedfd1), "fd 1 '%s' != expected '%s'",
+		 buf, expectedfd1);
+
+  return 0;
+}
+
+static char tmpcwd[] = "tmpcwd.XXXXXX";
+static char tmppath[] = "tmpfile.XXXXXX";
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
+int main (int argc, char **argv)
+{
+  posix_spawn_file_actions_t fa;
+  pid_t pid;
+  int status;
+  int fd;
+  char buf[PATH_MAX + 1];
+  char buffd0[PATH_MAX + 1];
+  char buffd1[PATH_MAX + 1];
+  char *childargv[] = {"chdir", "--child", buf, NULL, NULL, NULL};
+
+  /* unbuffer stdout */
+  setvbuf(stdout, NULL, _IONBF, 0);
+
+  if (argc == 3 && !strcmp (argv[1], "--child"))
+    return handle_child (argv[2]);
+  else if (argc == 5 && !strcmp (argv[1], "--child"))
+    return handle_childfds (argv[2], argv[3], argv[4]);
+
+  /* make a directory and a couple of files for testing */
+  nullError (mkdtemp (tmpcwd));
+  atexit (cleanup_tmpfiles);
+
+  negError (fd = mkstemp (tmppath));
+  negError (close (fd));
+
+  stpcpy (stpcpy (stpcpy (tmppath2, tmpcwd), "/"), "tmpfile2");
+  negError (fd = open (tmppath2, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR));
+  negError (close (fd));
+
+
+  /* ensure cwd is inherited by default */
+  nullError (getcwd (buf, sizeof (buf)));
+  stpcpy (stpcpy (stpcpy (buffd0, buf), "/"), tmppath);
+  errCode (posix_spawn (&pid, MYSELF, NULL, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+
+  /* test posix_spawn_file_actions_addchdir */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addchdir_np (&fa, tmpcwd));
+
+  strcat (buf, "/");
+  strcat (buf, tmpcwd);
+  stpcpy (stpcpy (stpcpy (buffd1, buf), "/"), "tmpfile2");
+
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_addfchdir */
+  negError (fd = open (tmpcwd, O_SEARCH|O_DIRECTORY|O_CLOEXEC, 0755));
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addfchdir_np (&fa, fd));
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+  negError (close (fd));
+
+  /* test posix_spawn_file_actions_addchdir + addopen */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 0, tmppath, O_RDONLY, 0644));
+  errCode (posix_spawn_file_actions_addchdir_np (&fa, tmpcwd));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, "tmpfile2", O_WRONLY, 0644));
+  childargv[3] = buffd0;
+  childargv[4] = buffd1;
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_addfchdir + addopen */
+  negError (fd = open (tmpcwd, O_SEARCH|O_DIRECTORY|O_CLOEXEC, 0755));
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 0, tmppath, O_RDONLY, 0644));
+  errCode (posix_spawn_file_actions_addfchdir_np (&fa, fd));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, "tmpfile2", O_WRONLY, 0644));
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+  negError (close (fd));
+
+  return 0;
+}
diff --git a/winsup/testsuite/winsup.api/posix_spawn/fds.c b/winsup/testsuite/winsup.api/posix_spawn/fds.c
index 6e6e8c6357..98ce36ff36 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/fds.c
+++ b/winsup/testsuite/winsup.api/posix_spawn/fds.c
@@ -115,7 +115,7 @@ int main (int argc, char **argv)
   errCode (posix_spawn_file_actions_destroy (&fa));

   /* TODO: test new fds (open or dup2) not 0 through 2 */
-  /* TODO: test posix_spawn_file_actions_add(f)chdir */
+  /* TODO: test error cases */

   negError (close (fd));
   negError (close (fdcloexec));
diff --git a/winsup/testsuite/winsup.api/posix_spawn/test.h b/winsup/testsuite/winsup.api/posix_spawn/test.h
index 531d11c4dc..5c56ed10f3 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/test.h
+++ b/winsup/testsuite/winsup.api/posix_spawn/test.h
@@ -12,6 +12,11 @@
     error_at_line(1, errno, __FILE__, __LINE__, "%s", #x); \
 } while (0)

+#define nullError(x) do { \
+  if (!(x)) \
+    error_at_line(1, errno, __FILE__, __LINE__, "%s", #x); \
+} while (0)
+
 #define sigError(x) do { \
   if ((x) == SIG_ERR) \
     error_at_line(1, errno, __FILE__, __LINE__, "%s", #x); \
-- 
2.49.0.windows.1

