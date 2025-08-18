Return-Path: <SRS0=nJKE=26=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 60EC83858C98
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 05:31:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60EC83858C98
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60EC83858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755495111; cv=none;
	b=JFisfVXIM/5Z0gxARYu6Y7cbsx3iXOvcPnRUd3u9CGSxLjBjYaMZT7hMcRBwI7XOoHpkpejRsTaLuB7j+qgO4M2YlPYC8KlDLP87+Ikoms7Zbl1LNnsipF9a4g4Ny3pSSFeH6QsM7nVBt44f8aCjSNNZU71ZyCwcKrInVe8mfOU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755495111; c=relaxed/simple;
	bh=zgk1OTUDmyvA7CjFgzcEMSlczhDmwCjdD8arFrJ17UI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pUbLkaADhjcQ8+Ey8XwtBXCWfZZ0NV/GrQ1dgOPO9d8UjHG6F6ImHfacjS+wd15H6jKqFfieGy9QKs9UWROdbB3cXw3AeD0WU8/EFEqQadLnRQC1/EzF0zyj+Y2uVk+pDeWsfEvINyPR3PhBE05PyZtQBnP06S5PH56v/lWqtlE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60EC83858C98
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fVXx4RCZ
Received: from localhost.localdomain by mta-snd-w08.mail.nifty.com
          with ESMTP
          id <20250818053148367.HVVJ.78984.localhost.localdomain@nifty.com>;
          Mon, 18 Aug 2025 14:31:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Denis Excoffier <cygwin@Denis-Excoffier.org>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH v3] Cygwin: spawn: Make ch_spwan_local be initialized properly
Date: Mon, 18 Aug 2025 14:31:23 +0900
Message-ID: <20250818053130.1184-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755495108;
 bh=hioj3LeRfe8kbD5DIIzKp3BZT6+nLsVBWfzbxcSYLJg=;
 h=From:To:Cc:Subject:Date;
 b=fVXx4RCZZH54WBZ3p593PXOk14MgZ7AFApg6n1QqJkzOAi266kSyiXYcb2I6RzGvBLB8rUha
 ulKRewVhka9qI4c49IPcGAXoLDK/BEzuzg83taCx8ZYUl+IIGewmRmoyiRL9Ii7t6fNzDDrbmR
 d6eYoy/gAAiLAEVx8pdXUR5rHwUyFwPk3scGvyCHzr2rPQQQtGx/rlFehTZeEzqfamkPZ1mdBE
 HkxYpFZt6ufUOhMZqu45Ce/v28jPc6TttWF4xGtjal8CTyNjQ42uPJRfLSEdczU+vJnHNtndcK
 W4Kllk2FvOH05hO5j6PvHNpCqR6GHWVjc31bIL4t08JeFfjA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The class child_info_spawn has two constructors: one without arguments
and one with two arguments. The former does not initialize any members.
Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
(i.e., ch_spawn_local) would be properly initialized. However, this was
insufficient - it initialized only the base child_info members, not the
fields specific to child_info_spawn. This led to the issue reported in
https://cygwin.com/pipermail/cygwin/2025-August/258660.html.

This patch introduces a new constructor to properly initialize member
variable 'ev', etc., which were referred without initialization, and
switches ch_spawn_local to use it. 'subproc_ready', which may not be
initialized, is also initialized in the constructor of the base class
child_info.

Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/local_includes/child_info.h | 3 ++-
 winsup/cygwin/sigproc.cc                  | 9 ++++++++-
 winsup/cygwin/spawn.cc                    | 2 +-
 winsup/cygwin/syscalls.cc                 | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index 2da62ffaa..25d99fa7d 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)
 
 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
+#define CURR_CHILD_INFO_MAGIC 0x77f25a01U
 
 #include "pinfo.h"
 struct cchildren
@@ -149,6 +149,7 @@ public:
 
   void cleanup ();
   child_info_spawn () {};
+  child_info_spawn (child_info_types);
   child_info_spawn (child_info_types, bool);
   void record_children ();
   void reattach_children ();
diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 361887981..30779cf8e 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -895,7 +895,8 @@ child_info::child_info (unsigned in_cb, child_info_types chtype,
   msv_count (0), cb (in_cb), intro (PROC_MAGIC_GENERIC),
   magic (CHILD_INFO_MAGIC), type (chtype), cygheap (::cygheap),
   cygheap_max (::cygheap_max), flag (0), retry (child_info::retry_count),
-  rd_proc_pipe (NULL), wr_proc_pipe (NULL), sigmask (_my_tls.sigmask)
+  rd_proc_pipe (NULL), wr_proc_pipe (NULL), subproc_ready (NULL),
+  sigmask (_my_tls.sigmask)
 {
   fhandler_union_cb = sizeof (fhandler_union);
   user_h = cygwin_user_h;
@@ -946,6 +947,12 @@ child_info_fork::child_info_fork () :
 {
 }
 
+child_info_spawn::child_info_spawn (child_info_types chtype) :
+  child_info (sizeof *this, chtype, false), hExeced (NULL), ev (NULL),
+  sem (NULL), moreinfo (NULL)
+{
+}
+
 child_info_spawn::child_info_spawn (child_info_types chtype, bool need_subproc_ready) :
   child_info (sizeof *this, chtype, need_subproc_ready)
 {
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 680f0fefd..71add8755 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -950,7 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
   if (!envp)
     envp = empty_env;
 
-  child_info_spawn ch_spawn_local (_CH_NADA, false);
+  child_info_spawn ch_spawn_local (_CH_NADA);
   switch (_P_MODE (mode))
     {
     case _P_OVERLAY:
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 863f8f23c..1b1ff17b0 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -4535,7 +4535,7 @@ popen (const char *command, const char *in_type)
       fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
 
       /* Start a shell process to run the given command without forking. */
-      child_info_spawn ch_spawn_local (_CH_NADA, false);
+      child_info_spawn ch_spawn_local (_CH_NADA);
       pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
 					 __std[0], __std[1]);
 
-- 
2.45.1

