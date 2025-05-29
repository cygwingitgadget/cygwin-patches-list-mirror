Return-Path: <SRS0=7LkC=YN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DE2093857810
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 17:58:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DE2093857810
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DE2093857810
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748541506; cv=none;
	b=dsFHX8MAy43KFdDykLTz2+Mk6Zn1mGWPj952mFNSCWeuHFypG63IZDxzuD5uGos8R9D8L+sWd8QnmsL4lE3ru4mAONB3VmvFifQJVlvH+PQND8i1E4wICh5JJ39gfJNx4qmED2P2QcrFx/5zUFDy3lsAKtnA60XRVd/ar2sDahM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748541506; c=relaxed/simple;
	bh=zkx9rcjb+StGYd23p43OUEXNOj6x4iX0xkIfFeyI4Sw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZVCAqyhnhrL3gjmfkPmbEq2XQJ67I8KE2vOSU699aqCJoeXtfHi7OypdddJKeoT2/t2eqn4nbS5jq4d5zhmWz6VH7TmJGUHuOP4mTTPdA31zbhX4VcqovPJescUtKiYrJpl1PKwNur7S6nIoYRJm1D4cD/LE3xXo/rxjJW6tkdY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B8B8145CB2
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:message-id:mime-version:content-type; s=csoft; bh=4if3K
	WaizXePCvdIXpcHUP5LF24=; b=G/vh7fsxneUJVXKGM0cJA38sNh1AXzk/pugjw
	AxitsQIP+Gf+Z8vliYW1zNcrL4AzQvER+j/1qNw5iWiIZ86c4dqXfKwgK6pZFnTD
	Yghey30KP5XQQOpn3yeXOKmVe6hh5WV5v6EgNTCw182AS0fnHR9jE1KdbmDkPYXb
	ZgloB0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B3EAC45CA8
	for <cygwin-patches@cygwin.com>; Thu, 29 May 2025 13:58:26 -0400 (EDT)
Date: Thu, 29 May 2025 10:58:26 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: [RFC PATCH 2/3] Cygwin: hook posix_spawn/posix_spawnp
Message-ID: <610f9534-b03b-a495-d046-6f09f7a077db@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This will allow checking for and optimizing cases that can easily be
implemented using ch_spawn instead of using a full fork/exec.
---
 winsup/cygwin/cygwin.din |  4 +--
 winsup/cygwin/spawn.cc   | 70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

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
index 9a7f0bbf73..dc5f04db98 100644
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
@@ -1376,3 +1378,71 @@ __posix_spawn_execvpe (const char *path, char * const *argv, char *const *envp,
   __posix_spawn_sem_release (sem, errno);
   return -1;
 }
+
+/* HACK: duplicate some structs from newlib/libc/posix/posix_spawn.c */
+struct __posix_spawn_file_actions {
+  STAILQ_HEAD(, __posix_spawn_file_actions_entry) fa_list;
+};
+
+typedef struct __posix_spawn_file_actions_entry {
+  STAILQ_ENTRY(__posix_spawn_file_actions_entry) fae_list;
+  enum {
+    FAE_OPEN,
+    FAE_DUP2,
+    FAE_CLOSE,
+    FAE_CHDIR,
+    FAE_FCHDIR
+  } fae_action;
+
+  int fae_fildes;
+  union {
+    struct {
+      char *path;
+#define fae_path	fae_data.open.path
+      int oflag;
+#define fae_oflag	fae_data.open.oflag
+      mode_t mode;
+#define fae_mode	fae_data.open.mode
+    } open;
+    struct {
+      int newfildes;
+#define fae_newfildes	fae_data.dup2.newfildes
+    } dup2;
+    char *dir;
+#define fae_dir		fae_data.dir
+    int dirfd;
+#define fae_dirfd		fae_data.dirfd
+  } fae_data;
+} posix_spawn_file_actions_entry_t;
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

