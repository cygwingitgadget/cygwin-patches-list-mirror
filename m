Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 4778B385C6EB
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 06:45:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4778B385C6EB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4778B385C6EB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753166700; cv=none;
	b=lDDouNK7i67rU9Aod/bKXyGzrhMAqBCKkr6r2Z2mDbJuI4i/tIDLUQzKzv8lmVtEKFaHDrUVypRXWwof0GhHZHkxJqdCDAbXkxUivCLymXJvSK00XEdPTONBjDnjgdFQUSE4zwlvBbV4D8wLODnDLbJMoP4Ch9Yd9PartQJYEm0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753166700; c=relaxed/simple;
	bh=TvoJMjG/j84d3g0ZdyC9UB/prU9f7ZW7/Y1vB4XccXs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YK2QF0kjwiK+0KkM6YFXObiTu0pRUTdxi3pY9zXS3B1dgX9DYti1nct44YYqLhmw03shtkawwoA7yDlhO5kSNdAaP6CW5l99DRIbnUy1/diWRH+5V85ygSTwwFLj0wFLoTtybhml9dVAmiE8a7LEY1zUZiV4aXC0w0Jkkad1ZZU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4778B385C6EB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L2sEC8LM
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250722064458554.TQWJ.62593.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 15:44:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v6 3/3] Cygwin: spawn: Make system() thread-safe
Date: Tue, 22 Jul 2025 15:44:02 +0900
Message-ID: <20250722064415.1590-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
References: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753166698;
 bh=8vXVqKu5fOuQ4GYwTfjzf3rCtSZjfF02kRdnJXoMRGU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L2sEC8LMA4bilFSiH93QUQ92Da0kPJ6l0yoxE5Ga42m4XAlm5yoxjM+DranVoFsBWkhN7xbb
 ijM3mvBGMA342rAahvN54na4JIAVCZKWCtkHZw69Q9FW3e6bmDysa1EZT95K9bYe7pcT5+aF/y
 VuvuWGkX21oRJFOqXSKEqgQFWPO8jkwDmFSOxQxbBQ0v+bmthHNH2nnAFAVt7VU5I6vmphFERU
 mT5vjMFU9Dxeu38nxI7WJ00QYQEhVMyQ1n7AqCMsvfEidGu3qhqTAe4YHRIoPQ5zmfrMXnKMij
 U6R4GOs0PNkHjScokxFJ08b8jFt0GRvPvtQXuPlj4Nb9BPgQ==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

POSIX states system() shall be thread-safe, however, it is not in
current cygwin. This is because ch_spawn is a global and is shared
between threads. With this patch, system() uses ch_spawn_local
instead which is local variable. popen() has the same problem, so
it has been fixed in the same way.

Addresses: https://cygwin.com/pipermail/cygwin/2025-June/258324.html
Fixes: 1fd5e000ace5 ("import winsup-2000-02-17 snapshot")
Reported-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/spawn.cc    | 3 ++-
 winsup/cygwin/syscalls.cc | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8ca19868a..96200ff88 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -953,6 +953,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
+  child_info_spawn ch_spawn_local (_CH_NADA, false);
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
@@ -966,7 +967,7 @@ spawnve (int mode, const char *path, const char *const *argv,
     case _P_WAIT:
     case _P_DETACH:
     case _P_SYSTEM:
-      ret = ch_spawn.worker (path, argv, envp, mode);
+      ret = ch_spawn_local.worker (path, argv, envp, mode);
       break;
     default:
       set_errno (EINVAL);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index d6a2c2d3b..863f8f23c 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4535,8 +4535,9 @@ popen (const char *command, const char *in_type)
       fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
 
       /* Start a shell process to run the given command without forking. */
-      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, _P_NOWAIT,
-				   __std[0], __std[1]);
+      child_info_spawn ch_spawn_local (_CH_NADA, false);
+      pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
+					 __std[0], __std[1]);
 
       /* Reinstate the close-on-exec state */
       fcntl (stdchild, F_SETFD, stdchild_state);
-- 
2.45.1

