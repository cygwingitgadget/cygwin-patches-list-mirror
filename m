Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 6FB6B3858429
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 12:11:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FB6B3858429
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6FB6B3858429
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753186281; cv=none;
	b=E7r0RbqjsMnBm21LBnvv23o9lIkGK8udw1m2aWzpaRu3NDj1yHVFIWbb8BBEuQlbrPAiJWzUmWb7W2z4MCf6Sw8VKW1fXchxYSS/BBSaDDQTSRVlpXKLjCdqfgbaHmUUXCVrTO3j7Zqzy1K2PC3qWrIDEgaevLrN0lJLMWfcvB0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753186281; c=relaxed/simple;
	bh=O94FC8ug4kjSfItt7vQIEAo5Py/ZLm6NdeCONPtj7+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=a0rUivdgWbfx5i/7UhZU4vpTfRVdT2tN5yB2WySPz0OVo1sxAhaODMPuKfLvvPsT5juGPGxZb1XCMM0jZzaTCcp/lXVn3hWqjSwX6vzPe7/tB1/sFdNul26CZDapAw5XkrvPh3LNq86NrSwPUCiPX6c+P8X8TpQ6cJ6oMZdU+tU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6FB6B3858429
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QleUwKv7
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250722121118650.VVSG.74565.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 21:11:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v7 3/3] Cygwin: spawn: Make system() thread-safe
Date: Tue, 22 Jul 2025 21:10:16 +0900
Message-ID: <20250722121032.4755-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
References: <20250722121032.4755-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753186278;
 bh=PY4Ee/esyr5s4zxrq6nxY5CnR5Juy/Cb6xhA/IUKKKw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QleUwKv7SrqBhO9fi32a1YsuKTcuGBfiHRhJpNolGg/dNEeBkS/KoE5GmzgEK3DU/pPrFpRt
 Z3Ne4B0aZv/fzPC+rsMY1o1GO+pAvS3pBeUh3aD4JR0UL6J9wLwwHN3/1cJlIvweGOn8KNU396
 Cu47lRS7DnBOu5amtYCE/1+cZiEMMYU97ngU2AK73dhAnTRgU2v8dm1+8pb84C7VYDpmfVMaq6
 cVEmNPM7wQdI7jjJcEC5NNFy3J8YN4Quq3HYPoPvqhAPjKN26zgNeQF96RJV+ydZlOgV/SV5FJ
 mr9POMBqtVfTGtbrM8eBLvOSndObgnC7/vBfl2AX5JGOxeUA==
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
index 7f2f5a8aa..680f0fefd 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -950,6 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
+  child_info_spawn ch_spawn_local (_CH_NADA, false);
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

