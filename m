Return-Path: <SRS0=8F9w=ZJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id AA0A1385C6F5
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 23:57:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA0A1385C6F5
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA0A1385C6F5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750982268; cv=none;
	b=PyIBRrdG20aIOrGBqePMjLnvF3SBEgcYY4GIEB8LglRhPXSLEkur1BngsCs8zC7fL+5E1nYNJXUdG/W/onLqpf+hm7dnYbxvZre5EnhfYy7JaDMkSwwIliR+jO50CQATJ6EE/4/OnIw0Th0zjtVlo78Zm7qG17SfFtX1IqVa0PQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750982268; c=relaxed/simple;
	bh=v01mWDx0ytyqpcc5ZGLsZefnV2Y1fZIZDlFc4L2uV6U=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hJcNRSK9R6UMw8mR+htMyITBjrmjotHOeoeYthdHUZ+CJUWrIiLkDEqymDdXfuPOJt7SDHD9YxP4BU3i/THkYJ010xpSrVDDUqm+u3aH46Uf6S+hMryXXUei5RFlU8ToP2ObKgUJue5jn7ZdS2jPBxJ60JuFxA1fBnDUb3ZQ1xE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA0A1385C6F5
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=wdZ9hmv2
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 883BA45D31
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:57:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=AE/cj
	kmh4k/SaNX95gsQDiNt8XA=; b=wdZ9hmv2Y67og+g0ZRtYUZ8BcJ1uWeGfchOYj
	55oPlYgdAcv5jeao23Q2stI1GYI7kDXOQHcolE/xBosjF2+VEpRm+ppEMq+pLpfR
	I5SalFuaXwlNrmHOxaVqeV6Wd5UH7ZfL3ySVHszMbqWqpi0+BKQBHwWgGMvZWffO
	d1zYx0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 82DC545D30
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 19:57:48 -0400 (EDT)
Date: Thu, 26 Jun 2025 16:57:48 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/5] Cygwin: hook posix_spawn/posix_spawnp
Message-ID: <06bbad78-ac4b-8054-2db8-88656fb27968@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This will allow checking for and optimizing cases that can easily be
implemented using ch_spawn instead of using a full fork/exec.

Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
---
 winsup/cygwin/cygwin.din |  4 ++--
 winsup/cygwin/spawn.cc   | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index d7a17b234a..3f21d6899e 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -1058,7 +1058,7 @@ posix_getdents SIGFE
 posix_madvise SIGFE
 posix_memalign SIGFE
 posix_openpt SIGFE
-posix_spawn SIGFE
+posix_spawn = cygwin_posix_spawn SIGFE
 posix_spawn_file_actions_addchdir = posix_spawn_file_actions_addchdir_np SIGFE
 posix_spawn_file_actions_addchdir_np SIGFE
 posix_spawn_file_actions_addclose SIGFE
@@ -1082,7 +1082,7 @@ posix_spawnattr_setschedparam NOSIGFE
 posix_spawnattr_setschedpolicy NOSIGFE
 posix_spawnattr_setsigdefault NOSIGFE
 posix_spawnattr_setsigmask NOSIGFE
-posix_spawnp SIGFE
+posix_spawnp = cygwin_posix_spawnp SIGFE
 pow NOSIGFE
 pow10 NOSIGFE
 pow10f NOSIGFE
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8625725d49..63b6233255 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -10,6 +10,8 @@ details. */
 #include <stdlib.h>
 #include <unistd.h>
 #include <process.h>
+#include <spawn.h>
+#include <sys/queue.h>
 #include <sys/wait.h>
 #include <wchar.h>
 #include <ctype.h>
@@ -29,6 +31,7 @@ details. */
 #include "winf.h"
 #include "ntdll.h"
 #include "shared_info.h"
+#include "../posix/posix_spawn.h"

 /* Add .exe to PROG if not already present and see if that exists.
    If not, return PROG (converted from posix to win32 rules if necessary).
@@ -1430,3 +1433,35 @@ __posix_spawn_execvpe (const char *path, char * const *argv, char *const *envp,
   __posix_spawn_sem_release (sem, errno);
   return -1;
 }
+
+static int
+do_posix_spawn (pid_t *pid, const char *path,
+		const posix_spawn_file_actions_t *fa,
+		const posix_spawnattr_t *sa, char * const argv[],
+		char * const envp[], int use_env_path)
+{
+  syscall_printf ("posix_spawn%s (%p, %s, %p, %p, %p, %p)",
+      use_env_path ? "p" : "", pid, path, fa, sa, argv, envp);
+  if (use_env_path)
+    return posix_spawnp (pid, path, fa, sa, argv, envp);
+  else
+    return posix_spawn (pid, path, fa, sa, argv, envp);
+}
+
+extern "C" int
+cygwin_posix_spawn (pid_t *pid, const char *path,
+		    const posix_spawn_file_actions_t *fa,
+		    const posix_spawnattr_t *sa, char * const argv[],
+		    char * const envp[])
+{
+  return do_posix_spawn (pid, path, fa, sa, argv, envp, 0);
+}
+
+extern "C" int
+cygwin_posix_spawnp (pid_t *pid, const char *path,
+		     const posix_spawn_file_actions_t *fa,
+		     const posix_spawnattr_t *sa, char * const argv[],
+		     char * const envp[])
+{
+  return do_posix_spawn (pid, path, fa, sa, argv, envp, 1);
+}
-- 
2.49.0.windows.1

