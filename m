Return-Path: <SRS0=jPCG=2A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id F2EDA3858C2D
	for <cygwin-patches@cygwin.com>; Sat, 19 Jul 2025 15:16:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F2EDA3858C2D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F2EDA3858C2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752938195; cv=none;
	b=AT2yYee0S5+a57hcET+RDURKe8lNPuTMIcYUKBZh8aWAOMu/+V6h289fLDYzHkoooCS32pP0BOhzBhRoKOfHG9izZ2w4VnVLiNJxCLvts65tC8ts5i/69m1884KeQbyuZUmXWUTLHLYJFPIOcUZfvKzaQ1Ce/HAh+lHr2zc/7fU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752938195; c=relaxed/simple;
	bh=TKF8BXiEIbmnxZtY9uVpbuwTZ383WL0j2a9scfRJr0s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=uFA6MvZpn1gqi9F3lXL1/7MmSbkIw6BMk0t5R9C6AWCq7o256+iCeZ4cDgNs70/crggKklgYG8gdOLAH2WOxwFOnGF+NY5o2I0GWZ8QZ1VtCyhKY+4a0wNCHkHYBv4SQ9v7K8ppAlfBlhFL4vWpKbrqDcv6DVqBdQgLVPg8hWII=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F2EDA3858C2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nez4snin
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250719151633402.GEFC.69071.localhost.localdomain@nifty.com>;
          Sun, 20 Jul 2025 00:16:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH 2/2] Cygwin: spawn: Make system() thread-safe
Date: Sun, 20 Jul 2025 00:15:43 +0900
Message-ID: <20250719151557.340849-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250719151557.340849-1-takashi.yano@nifty.ne.jp>
References: <20250719151557.340849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752938193;
 bh=bPwG3Rufzptyu4u4MTZX5j91nhhqemghQ+et4SIuo0U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nez4sninhbeIsf2PMjCziB6inaXknsLX3ZfvJ804qbJCPbHnUJw12DuEisXE8LDyR67uXW6b
 y0xT82F2Rw6pXMBjm6DJEG7ffM/6NHkivPPtsOkTnN1wKXkNX+PpoYym9bza7PGFO9OcRY461m
 PZ8JoboEkhog2aqU3bMkC52axbL+mIMW/wUKJzXEd9/go7TrJ4I2AmjBnO1nL6ioaMIS4KGp1B
 a0RBOyvUt8JjbBLlEh+6xQBhPoSdZkZ5SjAg4kV0hZwpXajx1kZc5JTt0+PydtjxS4N9GqBUtj
 k+qM8ijxcWb9BHdEpVO6prM9udeztuJyPrinFoJNaIpcRa8g==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index a4c2b0549..f07bd1fcc 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -951,6 +951,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
+  child_info_spawn ch_spawn_local;
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
@@ -964,7 +965,7 @@ spawnve (int mode, const char *path, const char *const *argv,
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

