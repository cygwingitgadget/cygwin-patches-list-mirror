Return-Path: <SRS0=4oHy=ZD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DF48839FD1E3
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 18:02:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF48839FD1E3
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF48839FD1E3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750442566; cv=none;
	b=LewvSBCzCcdGzJq4MugP16gYkw4xrdP06JG1bAu1/0YKiBx3kLyQHWEGJ1Tqk5/ZUJmQNxh0CENn2os2SYALwp5yua37pr8LejAclfDe+gbj9FHmQIrvdUGdaJpbOprpmGCYO0eWFVWuwcgMsK2davpwDGldtWfHP2SU+mMCUBk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750442566; c=relaxed/simple;
	bh=QrWmAUhxpjnjWKt4JU6tErxvgNQtVyhD5Z3M3ihDeYw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=AGQsp0vSsMUAanLJRUIbpHQSx9E/XUHnR1cK3CZkB6XvBaUf17Zsw/aDwJNRYvm19rYLRAx6BhFwVy2vKtIKWbTp2+at0iH7XKr8irSxEHHle8Nju5UVAEJClRKrqCH2zSU23gxndv5gyr3LMIDRBWeE5vxgQ/rfxGCBdwPFR3k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF48839FD1E3
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=tkxBo6R/
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B8E9945D03
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=Xz1eg
	rPtwX/FW/8VKKRBk7x0aN0=; b=tkxBo6R/hSL72VvJWOZd7CU6fyi83axB7ipYI
	i/Xv4nx9ysoBq18XLkpbksvXSsN+NIFVcg/ZB4C1MYvVXKLZcqKe3x6xKLxKtkru
	CKGjB0NQoLkMxTKIgc57ZJX8No1YuBWFDBwxjFgw+387Rw1vQvG91viSwET6h1lX
	A3oAxo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B27F645CFE
	for <cygwin-patches@cygwin.com>; Fri, 20 Jun 2025 14:02:45 -0400 (EDT)
Date: Fri, 20 Jun 2025 11:02:45 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/4] Cygwin: testsuite: test posix_spawnp
Message-ID: <e6f73817-4a1a-d101-26c9-2041d9e27597@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Given the limited binaries available (sh, ls, sleep), use sh -c true

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/testsuite/Makefile.am                  |  1 +
 .../testsuite/winsup.api/posix_spawn/spawnp.c | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/posix_spawn/spawnp.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 0b265261cd..1cda72905e 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -312,6 +312,7 @@ check_PROGRAMS = \
 	winsup.api/pthread/threadidafterfork \
 	winsup.api/pthread/tsd1 \
 	winsup.api/posix_spawn/errors \
+	winsup.api/posix_spawn/spawnp \
 	winsup.api/samples/sample-fail \
 	winsup.api/samples/sample-pass
 # winsup.api/ltp/ulimit01 is omitted as we don't have <ulimit.h>
diff --git a/winsup/testsuite/winsup.api/posix_spawn/spawnp.c b/winsup/testsuite/winsup.api/posix_spawn/spawnp.c
new file mode 100644
index 0000000000..c7bee878f8
--- /dev/null
+++ b/winsup/testsuite/winsup.api/posix_spawn/spawnp.c
@@ -0,0 +1,25 @@
+#include "test.h"
+#include <spawn.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+int main (void)
+{
+  pid_t pid;
+  int status;
+  /* the test installation has very limited binaries on the PATH, but sh is one
+     of them and 'true' should be a builtin */
+  char *childargv[] = {"sh", "-c", "true", NULL};
+  char *childenv[] = {NULL};
+
+  /* unbuffer stdout */
+  setvbuf(stdout, NULL, _IONBF, 0);
+
+  /* can posix_spawnp find a program even with an empty environment? */
+  errCode (posix_spawnp (&pid, childargv[0], NULL, NULL, childargv, childenv));
+  negError (waitpid (pid, &status, 0));
+  exitStatus (status, 0);
+
+  return 0;
+}
-- 
2.49.0.windows.1

