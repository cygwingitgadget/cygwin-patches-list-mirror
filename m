Return-Path: <SRS0=4oHy=ZD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 87FA53921E61
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 18:02:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 87FA53921E61
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 87FA53921E61
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750442522; cv=none;
	b=BjkBtaheiaAJQZ/rXbS8OQon1vksVn+Y3zDf9oBzBQTwiC0DIM86OcI6q2L0RP+7+W4+TeswFM0fBkHIZd9AfY9YVk4DhTP87cEG53PaZuAhClscImjuXNY/XaWgZy6p8eRSVRFBmIg1Q3jQa0foaMnyy5b2VLpZtK1cmgUMrOA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750442522; c=relaxed/simple;
	bh=5MPAIk0xeIF3WvYszRFbefN4Z4GSWLj68j6KCWhy9/c=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Bo5VKDo8C7qj8BzewYzflE9Vo93a9azgtOtSoZYF1XWVTarAiqSc3VDnmayqVlu4NPDnMqnYGk+9R9Re3kTgg6OuytD527LB3yYwzU3KEc0nJwehRc28hPEjEdRY/5mfSuMQfGLCOXMv2qFaINKf8xedSJRz18NbX5VLe86Qngs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 636EE45D03
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:02:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=63kki
	WldDPpslDHvmWygDg+mFRM=; b=yUVZHOf5u9IqeVcNlcQ26PGA+a0fDLvxx9S2J
	YAYUc0pEOOKx8MYxCNIlaOv1SkRvy0gfsznGbO7oCzAFfKSBk2o3b7BbWz13di43
	f7YF2C8q2P4rusD2jFUdGeXErnnv6/gXVEzOEzJt9xrfuRipB3TYN9pjQSTdnDPG
	E2BNl4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 5D5ED45CFE
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:02:02 -0400 (EDT)
Date: Fri, 20 Jun 2025 11:02:02 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/4] Cygwin: testsuite: add posix_spawn tests
Message-ID: <3e66d0a5-3c75-0af1-0cc9-066f53481003@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently just a couple of tests of error conditions, but I have more
tests to add.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/Makefile.am                  |  1 +
 .../testsuite/winsup.api/posix_spawn/errors.c | 57 +++++++++++++++++++
 .../testsuite/winsup.api/posix_spawn/test.h   | 38 +++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/errors.c
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/test.h

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 8f2967a6dc..0b265261cd 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -311,6 +311,7 @@ check_PROGRAMS = \
 	winsup.api/pthread/self2 \
 	winsup.api/pthread/threadidafterfork \
 	winsup.api/pthread/tsd1 \
+	winsup.api/posix_spawn/errors \
 	winsup.api/samples/sample-fail \
 	winsup.api/samples/sample-pass
 # winsup.api/ltp/ulimit01 is omitted as we don't have <ulimit.h>
diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
new file mode 100644
index 0000000000..38563441f3
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
@@ -0,0 +1,57 @@
+#include "test.h"
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static char tmppath[] = "pspawn.XXXXXX";
+static const char exit0[] = "exit 0\n";
+
+void cleanup_tmpfile (void)
+{
+  unlink (tmppath);
+}
+
+int main (void)
+{
+  pid_t pid;
+  int fd;
+  char *childargv[] = {"ls", NULL};
+  char tmpsub[sizeof (tmppath) + 3];
+  char *p;
+
+  /* unbuffer stdout */
+  setvbuf(stdout, NULL, _IONBF, 0);
+
+  negError (fd = mkstemp (tmppath));
+  atexit (cleanup_tmpfile);
+  negError (write (fd, exit0, sizeof (exit0) - 1));
+  negError (close (fd));
+
+  /* expected ENOENT: posix_spawn without full path */
+  errCodeExpected (ENOENT,
+      posix_spawn (&pid, childargv[0], NULL, NULL, childargv, environ));
+
+  /* expected EACCES: posix_spawn with path to non-executable file */
+  errCodeExpected (EACCES,
+      posix_spawn (&pid, tmppath, NULL, NULL, childargv, environ));
+
+  negError (chmod (tmppath, 0755));
+
+  /* expected ENOEXEC: posix_spawn with unrecognized file format */
+  errCodeExpected (ENOEXEC,
+      posix_spawn (&pid, tmppath, NULL, NULL, childargv, environ));
+
+  p = stpcpy (tmpsub, tmppath);
+  p = stpcpy (p, "/ls");
+
+#ifndef __CYGWIN__
+  /* Cygwin returns ENOENT rather than ENOTDIR here */
+  /* expected ENOTDIR: posix_spawn with file as non-leaf entry in path */
+  errCodeExpected (ENOTDIR,
+      posix_spawn (&pid, tmpsub, NULL, NULL, childargv, environ));
+#endif
+
+  return 0;
+}
diff --git a/winsup/testsuite/winsup.api/posix_spawn/test.h b/winsup/testsuite/winsup.api/posix_spawn/test.h
new file mode 100644
index 0000000000..e10b6ce5e3
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/test.h
@@ -0,0 +1,38 @@
+#ifndef _POSIX_SPAWN_TEST_H_
+#define _POSIX_SPAWN_TEST_H_
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <error.h>
+#include <signal.h>
+#include <sys/wait.h>
+
+#define negError(x) do { \
+  if ((x) < 0) \
+    error_at_line(1, errno, __FILE__, __LINE__, "%s", #x); \
+} while (0)
+
+#define sigError(x) do { \
+  if ((x) == SIG_ERR) \
+    error_at_line(1, errno, __FILE__, __LINE__, "%s", #x); \
+} while (0)
+
+#define errCodeExpected(expected, x) do { \
+  int _errcode = (x); \
+  if (_errcode != (expected)) \
+    error_at_line(1, _errcode, __FILE__, __LINE__, "%s", #x); \
+} while (0)
+
+#define errCode(x) errCodeExpected(0, x)
+
+#define exitStatus(status, expectedExitCode) do { \
+  if (WIFSIGNALED ((status))) \
+    error_at_line (128 + WTERMSIG ((status)), 0, __FILE__, __LINE__ - 2, \
+		   "child terminated with signal %d", WTERMSIG ((status))); \
+  else if (WIFEXITED ((status)) && WEXITSTATUS ((status)) != (expectedExitCode)) \
+    error_at_line (WEXITSTATUS ((status)), 0, __FILE__, __LINE__ - 2, \
+		   "child exited with code %d", WEXITSTATUS ((status))); \
+} while (0)
+
+#endif /* _POSIX_SPAWN_TEST_H_ */
+
-- 
2.49.0.windows.1

