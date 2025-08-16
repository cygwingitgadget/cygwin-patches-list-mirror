Return-Path: <SRS0=EPME=24=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 42AD23858D1E
	for <cygwin-patches@cygwin.com>; Sat, 16 Aug 2025 03:17:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 42AD23858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 42AD23858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755314227; cv=none;
	b=NDCTRPL5NQa6Z14wj9aWwz9ZGg/E3IWH11lmp6Y6jQB86VVsbEILq8BBswiXPekp79nneb/vhDeH0tJLNLTwo78DYuAh/+uFIbBBxmF0bxp49WoXkpXw3YDG4vAiSGWS1qW8xfcFMd8oXirnoUAzAb5r7aDGnyYGwjzCXvek/3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755314227; c=relaxed/simple;
	bh=3aC56eicI/Am8vG2mSIWgmDSzJ9VFx08HSNtvD8bMgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vxzdsv8DUdBR+rKXVxmzOVnTw2YrO+dm7par9PZ++CE7dEZbjUKatDs5LU9qh+zyP39rP/IecD68vnlek0RrowobhN12aBokgdK2X7WjiIqDf93pNnHUigdZQiGP8oRLcCUbKRE74+GOccl0tEscZ9YwLcyqluEXKtZT3NmIcSs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 42AD23858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=t802kvtY
Received: from localhost.localdomain by mta-snd-w07.mail.nifty.com
          with ESMTP
          id <20250816031705457.ZHTX.19957.localhost.localdomain@nifty.com>;
          Sat, 16 Aug 2025 12:17:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Denis Excoffier <cygwin@Denis-Excoffier.org>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v2] Cygwin: spawn: Make ch_spwan_local be initialized properly
Date: Sat, 16 Aug 2025 12:16:42 +0900
Message-ID: <20250816031650.557-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755314225;
 bh=hxo85fe0AH9JzOlSMOzg6z02K3ONMqqfNU08dehjYuM=;
 h=From:To:Cc:Subject:Date;
 b=t802kvtYTZPwmwpIphlVZQfrshlqivLdsLUQ9XiJsTPc2QNP/LTcShJt5OI6/Th8+rskJ+bE
 VWtfuGb8zkaLLQHY7scsGNnqw9XHI/YRg94XT7zNmptwztWHm7+OFLV7kcBD4TU5y3xRZLzz3e
 K7PLBOK+E0PflYGo+fXcJ/qPsIditymCsEPfiHBwq/N+ClxkGJSkEYrZaHMJdQ7Shlg0Uhkr4T
 6l0/L/Z7OS7iVhp2LKC18YI0wRpOC2GxIsYFjoNzBvAF6/M3B4A23J+CIHwuNtpAZebaTKnD0G
 iv3gOevjkUIYzQ6VIfuoG4DKfIkAIrcCy5fpYvh8yUEhHnwA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The class child_info_spawn has two constructors: one without arguments
and one with two arguments. The former does not initialize any members.
Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
(i.e., ch_spawn_local) would be properly initialized. However, this was
insufficient - it initialized only the base child_info members, not the
fields specific to child_info_spawn. This led to the issue reported in
https://cygwin.com/pipermail/cygwin/2025-August/258660.html.

This patch updates the former constructor to properly initialize member
variable 'ev' which was referred without initialization, and switches
ch_spawn_local to use it.

Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/child_info.h | 5 +++--
 winsup/cygwin/spawn.cc                    | 2 +-
 winsup/cygwin/syscalls.cc                 | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 2da62ffaa..b8707b9ec 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)
 
 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
+#define CURR_CHILD_INFO_MAGIC 0x39f766b5U
 
 #include "pinfo.h"
 struct cchildren
@@ -148,7 +148,8 @@ public:
   char filler[4];
 
   void cleanup ();
-  child_info_spawn () {};
+  child_info_spawn () :
+    child_info (sizeof *this, _CH_NADA, false), ev (NULL) {};
   child_info_spawn (child_info_types, bool);
   void record_children ();
   void reattach_children ();
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 680f0fefd..6cd97ec17 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -950,7 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
-  child_info_spawn ch_spawn_local (_CH_NADA, false);
+  child_info_spawn ch_spawn_local;
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 863f8f23c..83a54ca05 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4535,7 +4535,7 @@ popen (const char *command, const char *in_type)
       fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
 
       /* Start a shell process to run the given command without forking. */
-      child_info_spawn ch_spawn_local (_CH_NADA, false);
+      child_info_spawn ch_spawn_local;
       pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
 					 __std[0], __std[1]);
 
-- 
2.45.1

