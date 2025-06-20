Return-Path: <SRS0=4oHy=ZD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 5CB2C38757CC
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 18:04:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5CB2C38757CC
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5CB2C38757CC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750442653; cv=none;
	b=bGES+VX5cG7+kkAF2cBPuHlTsJWI5tU+nfHyzVyqg3XjdrguVJ9YigS3omfo/Ks5QyMhZpS+h7l5kBt70LC+B2rgk2JGgp1wdQ+ezwtKA3tWgYf+WmCKYUyvDrlmt7z3O2jp/qOLSYtw+8358iOCmSY68Ldh4ZrBKVXQ0LSDohw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750442653; c=relaxed/simple;
	bh=EkzBRkZRjOTSVoyFiejbgfmpuew9UA+44K7shKhZu6Q=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=q34f6oBUUCwcZvWrPilxIbtYVdM98wvfKWeO1KSbVSW4HLVJp71UopRC1GTZGxAAqmfDC6a+69CDEhXL/dcJkxGf0APChgyk7bilJqucEkPN83fYhDtfxFd8W9xzO1VyIIdolYv5IW5mBqLnEG7Sa+alRaYqUnxOkI4ulnUwJFc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5CB2C38757CC
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=pISgR/3n
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3608645D03
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=thbNO
	Eo2pukMkOnu3U9nxHOsf2c=; b=pISgR/3nWjo1jQKHbTdhgE+e6iQlFYwRCtpEQ
	lnWsHWiUM8h/+9VDWH72o1qNq0KLk3MXdH474ukncPm6fs1dUCRG+qd/6QaywFTx
	J3jJoEmry0kP4TLsWcUlesdPe0nPcbhzrZzxg/xou/pj7YRUYOPpswHdjxj6mYME
	iYKdyI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 305FB45CFE
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:04:13 -0400 (EDT)
Date: Fri, 20 Jun 2025 11:04:13 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/4] Cygwin: testsuite: test posix_spawn_file_actions.
Message-ID: <00106f8b-c027-1886-b71b-70ac78161c94@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

There are still more that could be tested, such as (f)chdir.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/Makefile.am                  |   1 +
 winsup/testsuite/winsup.api/posix_spawn/fds.c | 124 ++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/fds.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index b92532e4fe..4b056bd5bf 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -312,6 +312,7 @@ check_PROGRAMS = \
 	winsup.api/pthread/threadidafterfork \
 	winsup.api/pthread/tsd1 \
 	winsup.api/posix_spawn/errors \
+	winsup.api/posix_spawn/fds \
 	winsup.api/posix_spawn/signals \
 	winsup.api/posix_spawn/spawnp \
 	winsup.api/samples/sample-fail \
diff --git a/winsup/testsuite/winsup.api/posix_spawn/fds.c b/winsup/testsuite/winsup.api/posix_spawn/fds.c
new file mode 100644
index 0000000000..6e6e8c6357
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/fds.c
@@ -0,0 +1,124 @@
+#include "test.h"
+#include <fcntl.h>
+#include <limits.h>
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+int handle_child (char *devfd, char *target)
+{
+  char buf[PATH_MAX];
+  ssize_t ret;
+
+  ret = readlink (devfd, buf, PATH_MAX);
+  if (ret < 0)
+    {
+      int err = errno;
+      if (err == ENOENT && !strcmp (target, "<ENOENT>"))
+	return 0;
+      error_at_line (1, err, __FILE__, __LINE__ - 6,
+		     "ret = readlink (devfd, buf, PATH_MAX)");
+    }
+  testAssertMsg (ret < PATH_MAX, "Path too long for PATH_MAX buffer");
+  buf[ret] = '\0';
+  if (strcmp (target, buf))
+      error_at_line (1, 0, __FILE__, __LINE__ - 12,
+		     "Target '%s' != expected '%s'", buf, target);
+
+  return 0;
+}
+
+int main (int argc, char **argv)
+{
+  posix_spawn_file_actions_t fa;
+  pid_t pid;
+  int status;
+  int fd, fdcloexec;
+  char buf[16];
+  char *childargv[] = {"fds", "--child", buf, "", NULL};
+
+  /* unbuffer stdout */
+  setvbuf(stdout, NULL, _IONBF, 0);
+
+  if (argc == 4 && !strcmp (argv[1], "--child"))
+    return handle_child (argv[2], argv[3]);
+
+  /* open file descriptors to test inheritance */
+  negError (fd = open ("/dev/null", O_RDONLY, 0644));
+  negError (fdcloexec = open ("/dev/full", O_RDONLY|O_CLOEXEC, 0644));
+
+  /* ensure fd is inherited by default */
+  sprintf (buf, "/dev/fd/%d", fd);
+  childargv[3] = "/dev/null";
+  errCode (posix_spawn (&pid, MYSELF, NULL, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+
+  /* ensure CLOEXEC fd is closed */
+  sprintf (buf, "/dev/fd/%d", fdcloexec);
+  childargv[3] = "<ENOENT>";
+  errCode (posix_spawn (&pid, MYSELF, NULL, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+
+  /* test posix_spawn_file_actions_addopen */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 0, "/dev/zero", O_RDONLY,
+					     0644));
+  strcpy (buf, "/dev/fd/0");
+  childargv[3] = "/dev/zero";
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_adddup2 */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, fd, 0));
+  childargv[3] = "/dev/null";
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_adddup2 with CLOEXEC fd */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, fdcloexec, 0));
+  childargv[3] = "/dev/full";
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_adddup2 with out to err */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addopen (&fa, 1, "/dev/zero", O_WRONLY,
+					     0644));
+  errCode (posix_spawn_file_actions_adddup2 (&fa, 1, 2));
+  strcpy (buf, "/dev/fd/2");
+  childargv[3] = "/dev/zero";
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* test posix_spawn_file_actions_addclose */
+  errCode (posix_spawn_file_actions_init (&fa));
+  errCode (posix_spawn_file_actions_addclose (&fa, fd));
+  sprintf (buf, "/dev/fd/%d", fd);
+  childargv[3] = "<ENOENT>";
+  errCode (posix_spawn (&pid, MYSELF, &fa, NULL, childargv, environ));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+  errCode (posix_spawn_file_actions_destroy (&fa));
+
+  /* TODO: test new fds (open or dup2) not 0 through 2 */
+  /* TODO: test posix_spawn_file_actions_add(f)chdir */
+
+  negError (close (fd));
+  negError (close (fdcloexec));
+
+  return 0;
+}
-- 
2.49.0.windows.1

