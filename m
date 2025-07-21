Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 9145A3858430
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 13:47:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9145A3858430
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9145A3858430
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753105659; cv=none;
	b=RwHXPJgfFVsjAXK5w/+C76oX6NiEdWuO5BjueHhF7rE8DcTKFu8gIKOidVOHyQy1Bejoj3zdTpu6Z3YfGPHpTAo4vpgB5w8W58yGSYV/BRQ8v123wXk0Fo4GN6O2c2S8RdtNlchGTbFXgMl0/6XjIkjUsOwCP4kzxJobjtt3pKA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753105659; c=relaxed/simple;
	bh=lLtx+rD0KxX7jXfUmBjJMM3uhg4NFIZrdi1La9JPk+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=EydiQCND+pqxWHgod3K+tSPeHvCgiWShdAimhCshI/vZx27kn8VipuvkrfNQ82xM3Oc2vXr3+i+sOdJmSdoMSzMtHwmT9QXErMG8AY6FRlb60AnT7l/xYCp0/K8OGwZqeZCTeWx/a6YbDfGMso7OKoE2xWvn1eV6Vr1uEIm7VVc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250721134719685.SKCJ.74565.localhost.localdomain@nifty.com>;
          Mon, 21 Jul 2025 22:47:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3 3/3] Cygwin: spawn: Make system() thread-safe
Date: Mon, 21 Jul 2025 22:46:19 +0900
Message-ID: <20250721134628.2908-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
References: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753105639;
 bh=KtcACfOntRjAa+Lcy0HpESZ881WKpL1M2Bk6dYKNaeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gfExBnkSqq0O12dwWPVQgRdA92PpTrddq2YjXMhLzhoyLEC1FRdwzz+h/GGtzCbStSTQkeZu
 PJTNNBcnZvG5U1HkxO4owegJzNiVYsPXgzVTIV5AISebao35qyYoo6q9RgHzHnkWwmD6u+kpFH
 kBgG/C4UzStUIIQM2Rn/rYpNWe03YRgts7os2PM0fuJhuq/f/mvg0HC8WERANSIeW9PkWHcDpm
 dlvntNc2y0D0LFR/vOBmbwO9QrvDfIQQHzRoVUUoEx3w4aLt4DuGYHeOuzDMcjVpHr8PAb53DY
 Uv1HekEeezhJTKiGhxC99qXypLNoWrg4XM3e8Ej3Eh1UOaJg==
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

