Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id F1D46382393A
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 05:47:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F1D46382393A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F1D46382393A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750225657; cv=none;
	b=jLwXOkDGRzZlWOGwTIpXD6kb/LshHKUgoKdLt+iUim+pnrQANMUrCN3XbiV3p1bkHzOL+Gy4VVVY+6QOKZ0RU2mrTha2Ex6Y/HV8S3rT3jkzhhRhLAoUPn6g0kW0JnZhdi1UIiy7xVbr8z+RflMfb5BxAim0GYIFgV5KWKlSrZw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750225657; c=relaxed/simple;
	bh=U7Fq3m++6kxc+JAG+mgAUOyy/0nmhS5Q1awUwFlYbUs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=VKaW9UOHvy43/wj3lDRK6LH8vVyNZdK46tHHRcWgf9IQ3mRPJ31qfCepHymeO8iGUrFSi+QbFdt4JK3o1sGQf1moBuy27SpaeFEaz065XaW7fQpXq9EDcbIoVzM5dOORU+CHQ1Fwl8ZUYpryTTDJI9CPeI6lXUxQSVqEgvm+uss=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F1D46382393A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Xm3isHsY
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B306A45D56
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 01:47:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=EDnJsA18CfjQ3wr3TJjAe56gTIA=; b=Xm3is
	HsYyJTHpw+T2YWxf5IbpIJ0ujTUhnUjBxSm0qWYUhuKz9enTTGCr+Gs+sGs9Tgbv
	NVO7o9jqAJUeVIk21oYvEVUDZHMeCStz50hofPs/vPZUSbriu1HPWgHYsmutiH8B
	mC4aQwbXZ95uF3Gd0yw9hyHhu8W0On43XeidlY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id AD01445D50
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 01:47:36 -0400 (EDT)
Date: Tue, 17 Jun 2025 22:47:36 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: testsuite: add posix_spawn tests
In-Reply-To: <555fc9f8-0ab9-6902-f59f-e57d6a74b7e2@jdrake.com>
Message-ID: <9ac1505a-3e36-7a3d-97cf-3dd6567cbcf4@jdrake.com>
References: <555fc9f8-0ab9-6902-f59f-e57d6a74b7e2@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently just a couple of tests of error conditions, but I have more
tests to add.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---

v2: wrap some lines, and add a test for ENOEXEC error (it does NOT fall
back to invoking the shell).

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

