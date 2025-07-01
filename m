Return-Path: <SRS0=8TyM=ZO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3AC0D3854A95
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 23:44:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3AC0D3854A95
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3AC0D3854A95
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751413488; cv=none;
	b=amp6BQwclABW3sobxLRw7roin6G/rvwQPfWXA4M4LL17qbrGDzLZ4pq4w+njcLVZxaUixZQ88Xb2pALD7Uhw2zQuyyio2YPbzavTZ3ZYXGYtFqnwRYcE3v7BzCCmomJeIn9barrVpoL8p27mlN/TTnS68LoRULTiJmqNJhBuJ9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751413488; c=relaxed/simple;
	bh=UaPUtHnHrQi+dh3zh47WiIj1WSnA2tsebhu1na8s+iU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=l5t7KqIJHr2qF6TBlonSVDps+EREnyZ9Nv8o05y6jSqYlLC+FhxwHEvUDr63dXSzBQPWL36TXxYsWeiu5gOvNGJ9oWjE9a2HhUQUtzilM3Ks3Y2n/+RlU9M3S91nNUV3QBKYaWPHkMxXLo9RKmHwh3+kV7nnq9AI7OUbOottE58=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3AC0D3854A95
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=gcFCEU5Q
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1552345CA9
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:44:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=V6W8J
	t3xLFswKcgUtCoLhlp2E5w=; b=gcFCEU5Qg4SADd2o01fP7nCZDlbV3rnP0W9In
	Q3D8cuMsRlg3ASPvryxPSSUaFZ2HiDo97NdZSZQ4ktf4rb/SJH3LMna3wGAlq1L4
	fszINcYRNOwisxpDQoRtVP9xlBq4FsEJBVBzfGBps6dAKd22F9RK+cRbt16puKXt
	sKNN+g=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1003345CA7
	for <cygwin-patches@cygwin.com>; Tue, 01 Jul 2025 19:44:48 -0400 (EDT)
Date: Tue, 1 Jul 2025 16:44:47 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/6] Cygwin: hook posix_spawn/posix_spawnp
Message-ID: <b2d6820f-e43f-a54b-2d0d-20711664641a@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index 629a648a18..9fe3d1f4c5 100644
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
@@ -1444,3 +1447,35 @@ __posix_spawn_execvpe (const char *path, char * const *argv, char *const *envp,
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

