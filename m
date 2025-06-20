Return-Path: <SRS0=4oHy=ZD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 7A24F38BEC15
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 18:03:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7A24F38BEC15
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7A24F38BEC15
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750442605; cv=none;
	b=K0yuTrDB3S5OwXB1EylDrtfexX9YhOb5ihVxAlugqDPhpJF9xsTLfPq0macPi6Rru+VQyyffhIbXsHzFvrbwwdz/tc41HA3wNjgZ2t6ww/VXKSUIdHaUYdeTQ+EEpvLfKLFotjM0UwnRPATkiHlauPZwnV7zO9MqySyM7PuHb0U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750442605; c=relaxed/simple;
	bh=4auVYzhwNuwsNaJCkc97WiZSm7BnTZpnMlun9PkhQMs=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DHachZG/9hui9CwlyAoVJ6rbNW5UJ9uxE4svTt9bkv0dM6pl89CnCxGmm7r9H3W8sHMI1Ul4LQ5FnE044cG52CFNk70x6GaSd5n3NTrimcdxAOS1mmddjU452A9UXoUGeQU+l7ZO7WMKAsbQuacDUL+/a0X2dVILOEGADiyZS54=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7A24F38BEC15
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=sK5SaYeY
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 536D945D03
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:03:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=VMM/H
	L/yelbQFHPCRxwE8Af0k/E=; b=sK5SaYeY17fOABe32bneVNJjAKCBlSygSmqbN
	t7VyoxEbX+PgI7rbw4U39qKZVYG6R5Xl/l4r8DAHDGQb6OssUwA/L/KNRUrW8vo7
	Jc/CKEVkVUX8pNJ2WeQdukxAviGFVFsn8/Du1uq7iV+Aj+DifQCUtyLE0HwxWtXy
	tsijq4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4D97045CFE
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:03:25 -0400 (EDT)
Date: Fri, 20 Jun 2025 11:03:25 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/4] Cygwin: testsuite: test signal mask and ignore
 options.
Message-ID: <83bf0542-ea45-ab0f-73de-2181dda67d7a@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Test both that SIG_IGN and sigprocmask are inherited by default, and
that posix_spawnattr options can prevent this.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/Makefile.am                  |  1 +
 .../winsup.api/posix_spawn/signals.c          | 82 +++++++++++++++++++
 .../testsuite/winsup.api/posix_spawn/test.h   | 10 +++
 3 files changed, 93 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/signals.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 1cda72905e..b92532e4fe 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -312,6 +312,7 @@ check_PROGRAMS = \
 	winsup.api/pthread/threadidafterfork \
 	winsup.api/pthread/tsd1 \
 	winsup.api/posix_spawn/errors \
+	winsup.api/posix_spawn/signals \
 	winsup.api/posix_spawn/spawnp \
 	winsup.api/samples/sample-fail \
 	winsup.api/samples/sample-pass
diff --git a/winsup/testsuite/winsup.api/posix_spawn/signals.c b/winsup/testsuite/winsup.api/posix_spawn/signals.c
new file mode 100644
index 0000000000..f64404ddcb
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/signals.c
@@ -0,0 +1,82 @@
+#include "test.h"
+#include <signal.h>
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+int handle_child (char *arg)
+{
+  struct sigaction sa;
+  sigset_t mask;
+  int ret;
+
+  negError (sigaction (SIGUSR1, NULL, &sa));
+  negError (sigprocmask (SIG_SETMASK, NULL, &mask));
+  negError (ret = sigismember (&mask, SIGUSR2));
+
+  if (!strcmp (arg, "inherited"))
+    {
+      testAssert (sa.sa_handler == SIG_IGN);
+      testAssertMsg (ret, "SIGUSR2 not masked");
+    }
+  else
+    {
+      testAssert (sa.sa_handler == SIG_DFL);
+      testAssertMsg (!ret, "SIGUSR2 masked");
+    }
+
+  return 0;
+}
+
+int main (int argc, char **argv)
+{
+  posix_spawnattr_t sa;
+  pid_t pid;
+  int status;
+  sigset_t sigusr1mask, sigusr2mask, emptymask;
+  char *childargv[] = {"signal", "--child", "inherited", NULL};
+
+  /* unbuffer stdout */
+  setvbuf(stdout, NULL, _IONBF, 0);
+
+  if (argc == 3 && !strcmp (argv[1], "--child"))
+    return handle_child (argv[2]);
+
+  negError (sigemptyset (&sigusr1mask));
+  negError (sigaddset (&sigusr1mask, SIGUSR1));
+  negError (sigemptyset (&sigusr2mask));
+  negError (sigaddset (&sigusr2mask, SIGUSR2));
+  negError (sigemptyset (&emptymask));
+
+  /* set all signals to default */
+  for (int i = 1; i < NSIG; ++i)
+    if (i != SIGKILL && i != SIGSTOP)
+      signal (i, SIG_DFL);
+
+  /* change some signal states to test signal-related posix_spawn flags */
+  sigError (signal (SIGUSR1, SIG_IGN));
+  negError (sigprocmask (SIG_SETMASK, &sigusr2mask, NULL));
+
+  /* ensure ignored and blocked signals are inherited by default */
+  errCode (posix_spawn (&pid, MYSELF, NULL, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+
+  errCode (posix_spawnattr_init (&sa));
+  errCode (posix_spawnattr_setsigmask (&sa, &emptymask));
+  errCode (posix_spawnattr_setsigdefault (&sa, &sigusr1mask));
+  errCode (posix_spawnattr_setflags (&sa,
+	POSIX_SPAWN_SETSIGDEF|POSIX_SPAWN_SETSIGMASK));
+
+  /* ensure setsigmask and setsigdefault work */
+  childargv[2] = "spawnattr";
+  errCode (posix_spawn (&pid, MYSELF, NULL, &sa, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+
+  errCode (posix_spawnattr_destroy (&sa));
+
+  return 0;
+}
diff --git a/winsup/testsuite/winsup.api/posix_spawn/test.h b/winsup/testsuite/winsup.api/posix_spawn/test.h
index e10b6ce5e3..531d11c4dc 100644
--- a/winsup/testsuite/winsup.api/posix_spawn/test.h
+++ b/winsup/testsuite/winsup.api/posix_spawn/test.h
@@ -34,5 +34,15 @@
 		   "child exited with code %d", WEXITSTATUS ((status))); \
 } while (0)

+/* first vararg to testAssertMsg must be string msg */
+#define testAssertMsg(cond, ...) do { \
+  if (!(cond)) \
+    error_at_line (1, 0, __FILE__, __LINE__, __VA_ARGS__); \
+} while (0);
+
+#define testAssert(cond) testAssertMsg(cond, "%s", #cond)
+
+#define MYSELF "/proc/self/exe"
+
 #endif /* _POSIX_SPAWN_TEST_H_ */

-- 
2.49.0.windows.1

