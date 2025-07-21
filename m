Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 1FF503858D1E
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 16:12:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1FF503858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1FF503858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753114357; cv=none;
	b=e5JE5TUwh5v+CBehuP5GyAFCl677c5Tb3XqX4+l+3Jo5zV7QCLmIaPCUkff+IHzUCHBRFynUFVb1/rtY/kUoxlA2y6B8+wc+BgjuhC5zOJKNVFu1k1z//tIJu+gtIaq7ih56E0bSG+bHCOrDmbU51dtbQBPMgohR6HnQGHOJXuc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753114357; c=relaxed/simple;
	bh=lLtx+rD0KxX7jXfUmBjJMM3uhg4NFIZrdi1La9JPk+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=d2f5YL9GYOk4GBqba+0whkqV/2/orRd4bAfdXwNnvfq20dOFCD9rh7f4Fs3bnGUiijQMNIXdzw+hGKjL2L4c1oPEP4mbLhayBqnnhyJkYPu3IPXl+tehbrXB5ZHSqaWdYrGK7SJT+IOJRRzu7+HZw7HKq+yB1RdZ/wKV3kjfsDY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250721161235550.TETV.91923.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 01:12:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4 3/3] Cygwin: spawn: Make system() thread-safe
Date: Tue, 22 Jul 2025 01:11:42 +0900
Message-ID: <20250721161151.1053-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
References: <20250721161151.1053-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753114355;
 bh=KtcACfOntRjAa+Lcy0HpESZ881WKpL1M2Bk6dYKNaeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bJ+KbxGRab+QUrJlpxPPuq6P2+yQ2RDwQ2v3927/MiKath91V89boD6wakkwmynduryJLzqv
 ZbvI2lm6lGsHeWvjvxYou9P5+3QGeGMvwP5Q5iTMBPR5muhUtebxtaE0/U/rXaJNYdZXHjEdLS
 4wWL047vjXMZd3MjqTvB/LpWrjhb6KCwRZFzrVEcq+oODwwaou6a0ykLgJedyALoSQGoZFgkAF
 QxmbfC7rdwOfME/1um/QpFLC+YkRzL8wOK/KPAPml+N3CF068G57ORAaYKSo1eSb6NQlBYv2ph
 Ww0cFgkLBsFjSSEXYerKKqp7jY1AfyA6hwzSP6E+zUeQD0bA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index fd623f4c5..c057f7ebd 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -950,6 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
+  child_info_spawn ch_spawn_local;
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
@@ -963,7 +964,7 @@ spawnve (int mode, const char *path, const char *const *argv,
     case _P_WAIT:
     case _P_DETACH:
     case _P_SYSTEM:
-      ret = ch_spawn.worker (path, argv, envp, mode);
+      ret = ch_spawn_local.worker (path, argv, envp, mode);
       break;
     default:
       set_errno (EINVAL);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index d6a2c2d3b..83a54ca05 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4535,8 +4535,9 @@ popen (const char *command, const char *in_type)
       fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
 
       /* Start a shell process to run the given command without forking. */
-      pid_t pid = ch_spawn.worker ("/bin/sh", argv, environ, _P_NOWAIT,
-				   __std[0], __std[1]);
+      child_info_spawn ch_spawn_local;
+      pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
+					 __std[0], __std[1]);
 
       /* Reinstate the close-on-exec state */
       fcntl (stdchild, F_SETFD, stdchild_state);
-- 
2.45.1

