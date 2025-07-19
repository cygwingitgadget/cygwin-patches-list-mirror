Return-Path: <SRS0=jPCG=2A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 3BEC9385802C
	for <cygwin-patches@cygwin.com>; Sat, 19 Jul 2025 21:48:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3BEC9385802C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3BEC9385802C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752961735; cv=none;
	b=dfUajewikr1iZH9M5a0ifpyVeG+MmeE7mcm/E2QLOGdf0tk2eAT9mFDwiMq2G5qFmB6TuYiLT8AGHtm59PkpnU6c8BoJYhFxWEafgsTdpi5Gz29VQBGx0L71nNCEUCuk/9b8U0m66om9bPTWSnsLEMFVTymoMyqVe9EfOB2H3yc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752961735; c=relaxed/simple;
	bh=lLtx+rD0KxX7jXfUmBjJMM3uhg4NFIZrdi1La9JPk+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=O+qCn0hyXr7yzWYg0pALbXY7piFCekCKAQI0wRg0Q3OLBGOeCn6bsrd38T6yLkkUjDV9Wh0e4IkVqoP4hrl7gPWpG1tR2eaSq5KyvIs3NzWezLDgaBvtGzHt/rl79lFfrHR8rXUqHQWXJDCRZrrQYf5WQYi9k4Gh1OwKDcOTdN0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3BEC9385802C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=c6BR21hR
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250719214853618.XWZZ.116286.localhost.localdomain@nifty.com>;
          Sun, 20 Jul 2025 06:48:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2 2/2] Cygwin: spawn: Make system() thread-safe
Date: Sun, 20 Jul 2025 06:48:13 +0900
Message-ID: <20250719214823.1556-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250719214823.1556-1-takashi.yano@nifty.ne.jp>
References: <20250719214823.1556-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752961733;
 bh=KtcACfOntRjAa+Lcy0HpESZ881WKpL1M2Bk6dYKNaeI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c6BR21hRAdCkbcoyHnR6g59QtTS4ZwCZZGpxjjKgGHPhE5jRR+pP/d8rZi4iKzdSRkNJurpp
 nAX0HJWxuu5bgso4wSifNg+tzOtzUsPnQWI/4QmO4GqXY9W7fgoNv0H1+y/6kkpTpTQiDYE9Sj
 lJb8s0yuP+PwoM2pgsG1qDzh7FJJf31BLiphPgQb52O604dF5PdECC37bq6rqvFGPrwxFwJC/u
 XCYXgRhB7KLVjfvKfk3xtcRVFPl/U/LTzxWoohXeTUEmkoVzJ5CYtGKEMX/L3UcZXtNOV7F8Ux
 3oGSnFMUjKqS8MGTqARyXEPEuBqYkPD+tkE0D9HjFHi4rJaQ==
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

