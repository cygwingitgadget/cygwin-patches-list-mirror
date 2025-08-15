Return-Path: <SRS0=/C6y=23=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id E22333858D1E
	for <cygwin-patches@cygwin.com>; Fri, 15 Aug 2025 21:35:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E22333858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E22333858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755293738; cv=none;
	b=GdgJHF/wvgJWR5CkBwJlPr6BSabT1xzv6Oyx+0Ag4ogRRJ76rIDuQSlvqkkdqYGDecUl1NVGZkl36K87iA0r2w3Jg5EsCXUOqw8hUIX6AXstEnAvXtBj9O+t0fhU2c5z6K7lIAb2I7RDrma/OPFCp9CGsaRhxyPtqFyMPBpjZEA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755293738; c=relaxed/simple;
	bh=sGnjC7bKkOw5T+Jygm77luuSzFVnD4+ZsoktO5E0VBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=d3RfjNnbOc/mxCiDV7HlijmSz6TTmTz4IL4mEYPPxE7KgNbzTV1AINXdZWEWr8FXeLNa+NydkcxcRxc4VvaDqsHQ8HRHxqVwDx7eIuXsIMSCN6gZt16J0slQX9lCyd+ktbYmTF3DocpApHjnRvR34ut2cxnqYHvFfRHY2aybcHY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E22333858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=r1ojzuu/
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250815213536154.XVQ.48098.localhost.localdomain@nifty.com>;
          Sat, 16 Aug 2025 06:35:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Denis Excoffier <cygwin@Denis-Excoffier.org>
Subject: [PATCH] Cygwin: spawn: Make ch_spwan_local be fully initialized
Date: Sat, 16 Aug 2025 06:35:11 +0900
Message-ID: <20250815213519.3049-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755293736;
 bh=GRpC6LDd2v7txobVpu9NbWGrIUO8F/MIZF4f1Lrsp0c=;
 h=From:To:Cc:Subject:Date;
 b=r1ojzuu/QBAZBtTladqaCanWN9X+guDlt9rJj7NhmTJZ2N4yE7aeT47loEcucNDL4WIEGce1
 1mN59BoeVhoFSTvNWaSJMU72+wsIXo/lBjxOR/hreG96jm2eXJufSegcrj/fDE3ZLl2swTPktA
 y+jjmCFnLJAvDSz8R7PBHZPkPHSclzb0DU6pnkysr/Ocf4Yzt9xOPMCYVEL+m9bWBqY9b+b6Cn
 5LKkFzDJEZVJRBvRzhFIfu3dVC2kArv3o1HVF1Bd5izOzoctXDTTUBZM2wsFblkj7TL3cnWZo5
 8W3tvyyacNuoL59oLBV49IOZY4i4c9JNDBAtpMbaXzjRKOzw==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The class child_info_spawn has two constructors: one without arguments
and one with two arguments. The former does not initialize any members.
Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
(i.e., ch_spawn_local) would be properly initialized. However, this was
insufficient - it initialized only the base child_info members, not the
fields specific to child_info_spawn. This led to the issue reported in
https://cygwin.com/pipermail/cygwin/2025-August/258660.html.

This patch updates the former constructor to properly initialize all
member variables and switches ch_spawn_local to use it.

Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/child_info.h | 4 +++-
 winsup/cygwin/spawn.cc                    | 2 +-
 winsup/cygwin/syscalls.cc                 | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 2da62ffaa..e359d3645 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -148,7 +148,9 @@ public:
   char filler[4];
 
   void cleanup ();
-  child_info_spawn () {};
+  child_info_spawn () : child_info (sizeof *this, _CH_NADA, false),
+    hExeced (NULL), ev (NULL), sem (NULL), cygpid (0),
+    moreinfo (NULL), __stdin (0), __stdout (0) {};
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

