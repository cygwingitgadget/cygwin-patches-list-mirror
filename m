Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id E9F43385C6C9
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 00:32:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E9F43385C6C9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E9F43385C6C9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753144349; cv=none;
	b=v5TwzI2zoT+DlO966cWLyEaBtJmgSTmA9exMvDTyErkJs5NjM1BqxdxKBUbcHfMDTCv12+xL580w2C1mQBR64q97EOiZTZUGzct7gJZ3SXO/maKnp/o0RWMDNJ8/ILWkKWhitVr6Jiq8g9UKa++mWWA/+1bzpCtuChEnsI2PoLM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753144349; c=relaxed/simple;
	bh=NUTdRWlF5E5+dZXr3CtCvE0/cTTfXrrB6zJrEc6Q6dg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IEMk1uhrRk/TnIxlYYzpguSL+BJUqGd1G8m/I84GyBv0anAxTRL21zt+2PW3BPP6XvL9caxOhI7uUsPuw/0hyMIkcfGNRg0z4F1TpP8XsdxDPwp6ig+Wr9/5GBPrTujv0nNd9R5qgDJt/OXIMNWduXBtWMWGcQRUqNSaErrMdjc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E9F43385C6C9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XasPOcMH
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20250722003227336.NVHQ.42575.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 09:32:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v5 3/3] Cygwin: spawn: Make system() thread-safe
Date: Tue, 22 Jul 2025 09:31:33 +0900
Message-ID: <20250722003142.4722-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
References: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753144347;
 bh=/CZXObRE0q3yMu0qyoLVDyOO9LFqyQFIEwZsJ64DubU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XasPOcMHgLQrqJcfAOsb4nFH6jvlW0RBgZgRSRRSABrDa+Gz883qdaNbP+SNZk5IAoNgvwJC
 N5bfVNBYFDoRIwzvw+n3YI+Arcnb2Ua9IFJ+6bHCzWWT8uI9vSsEkkCKwpkceDmF7TXlhOyH4m
 taVh+uGkpyYxBdSzZ6gaB82GFMNEjzXO/a1RamtWATng24hoViPjanQsKMxwrCkpXQj7raChSj
 HouTJdE3/VU2wdr3SPBfvqK81KfgRUHbTJg8s5zOAho99e67wSDBPrOtcuhC7oAwPP/7NIxCLW
 TXpW9RPq6DvtHHTQZj+w6owfjdqfMb6zM0Asfjtb9DtZqaCQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index cf344d382..d2a390078 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -958,6 +958,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
+  child_info_spawn ch_spawn_local;
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
@@ -971,7 +972,7 @@ spawnve (int mode, const char *path, const char *const *argv,
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

