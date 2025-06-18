Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id CAEA8389376A
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 00:19:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CAEA8389376A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CAEA8389376A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750205946; cv=none;
	b=myytFH8NXpGh1F0kBYuKZD8ez+pEyfmxwfCYeiK++4bOdbu5I7kmbj2blju3zLOJXwfRIVTllxGlwrrtVHxRBVxbRfTqyYSlbE3QSbrUCukY1Hvc9m3GZ/wb2nDkOwm1FjwfJp8NhR7kkvNxqrGCwfHEuUOB9zRImpdUZ4WY0sM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750205946; c=relaxed/simple;
	bh=/IOZ71il55GHIDgZx7ckWSntdME0xv5Wgie4JBt5Cfw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=v27brkPECBvh7XeW40CD4hFeMJ6eDtee6LI6/RSnEKBc1y8qlZA8FQjiUGwC8W280W63oFcsGx+Kr+9RV/dFq4Km5e5tg+bJY4Qc5/2tjziRTpNZfEIamGbky2Bujgq4I9KeWvMaOiX9y32WMz6Z4I4EF96aE9WMWvImSjHYmm4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAEA8389376A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=bzdD4sx4
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 66DFD45D43
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 20:19:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=NsNrC
	+7duiprWBmgOeVK3m5q5gY=; b=bzdD4sx4IjSWa/EPHbq21MEgWLwIH1jec+7Yo
	MfniKiNV9wDWqneddj+rorC8Psg9MxpHoAT68OEB/eefxlMIROwHnAuGVkgAFAwx
	9WnA90AsKDamadokAclAJE75RddaP8okOMtarYdXW84wjYlk6TN8BQ4/LDhYcG+8
	UfS+po=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4D42745D41
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 20:19:06 -0400 (EDT)
Date: Tue, 17 Jun 2025 17:19:06 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: testsuite: add posix_spawn tests
Message-ID: <555fc9f8-0ab9-6902-f59f-e57d6a74b7e2@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently just a couple of tests of error conditions, but I have more
tests to add.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

1) is testsuite subject to the same review requirements or can I push more
tests as I refactor them from my more monolithic test program?

2) This may have revealed a bug (or, non-compliance with POSIX docs).
The posix_spawn docs say posix_spawn returns the errors from exec ("If
posix_spawn() or posix_spawnp() fail for any of the reasons that would
cause fork() or one of the exec family of functions to fail, including
when the corresponding exec function would attempt a fallback to sh
instead of failing with [ENOEXEC], an error value shall be returned as
described by fork() and exec, respectively; or, if the error occurs after
the calling process successfully returns, the child process shall exit
with exit status 127.").  The exec docs say that it should return ENOTDIR
if "A component of the new process image file's path prefix names an
existing file that is neither a directory nor a symbolic link to a
directory, or the new process image file's pathname contains at least one
non-<slash> character and ends with one or more trailing <slash>
characters and the last pathname component names an existing file that is
neither a directory nor a symbolic link to a directory."

For the test of /path/to/file/ls where file is a regular file, Linux does
indeed return ENOTDIR but Cygwin returns ENOENT.  Is this a known
limitation of Cygwin, or just an error code that just wasn't hooked up
somewhere?



 winsup/testsuite/Makefile.am                  |  1 +
 .../testsuite/winsup.api/posix_spawn/errors.c | 46 +++++++++++++++++++
 .../testsuite/winsup.api/posix_spawn/test.h   | 36 +++++++++++++++
 3 files changed, 83 insertions(+)
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
index 0000000000..6f8d102b8f
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
@@ -0,0 +1,46 @@
+#include "test.h"
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+char tmppath[] = "empty.XXXXXX";
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
+  negError (close (fd));
+  atexit (cleanup_tmpfile);
+
+  /* expected ENOENT: posix_spawn without full path */
+  errCodeExpected (ENOENT, posix_spawn (&pid, childargv[0], NULL, NULL, childargv, environ));
+
+  /* expected EACCES: posix_spawn with path to non-executable file */
+  errCodeExpected (EACCES, posix_spawn (&pid, tmppath, NULL, NULL, childargv, environ));
+
+  p = stpcpy (tmpsub, tmppath);
+  p = stpcpy (p, "/ls");
+
+#ifndef __CYGWIN__
+  /* Cygwin returns ENOENT rather than ENOTDIR here */
+  /* expected ENOTDIR: posix_spawn with file as non-leaf entry in path */
+  errCodeExpected (ENOTDIR, posix_spawn (&pid, tmpsub, NULL, NULL, childargv, environ));
+#endif
+
+  return 0;
+}
diff --git a/winsup/testsuite/winsup.api/posix_spawn/test.h b/winsup/testsuite/winsup.api/posix_spawn/test.h
new file mode 100644
index 0000000000..9cdcc9079d
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/test.h
@@ -0,0 +1,36 @@
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
+    error_at_line (128 + WTERMSIG ((status)), 0, __FILE__, __LINE__ - 2, "child terminated with signal %d", WTERMSIG ((status))); \
+  else if (WIFEXITED ((status)) && WEXITSTATUS ((status)) != (expectedExitCode)) \
+    error_at_line (WEXITSTATUS ((status)), 0, __FILE__, __LINE__ - 2, "child exited with code %d", WEXITSTATUS ((status))); \
+} while (0)
+
+#endif /* _POSIX_SPAWN_TEST_H_ */
+
-- 
2.49.0.windows.1

