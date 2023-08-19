Return-Path: <SRS0=N3FD=EE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1007.nifty.com (mta-snd01011.nifty.com [106.153.227.43])
	by sourceware.org (Postfix) with ESMTPS id E4922385841C
	for <cygwin-patches@cygwin.com>; Sat, 19 Aug 2023 06:07:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E4922385841C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1007.nifty.com with ESMTP
          id <20230819060753603.IITI.19115.localhost.localdomain@nifty.com>;
          Sat, 19 Aug 2023 15:07:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix failure to clear switch_to_nat_pipe flag.
Date: Sat, 19 Aug 2023 15:07:39 +0900
Message-Id: <20230819060739.898-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit fbfea31dd9b9, switch_to_nat_pipe is not cleared
properly when non-cygwin app is terminated in the case where the
pseudo console is disabled. This is because get_winpid_to_hand_over()
sometimes returns PID of cygwin process even though it should return
only PID of non-cygwin process. This patch fixes the issue by adding
a new argument which requests only PID of non-cygwin process to
get_console_process_id().

Fixes: fbfea31dd9b9 ("Cygwin: pty: Avoid cutting the branch the pty master is sitting on.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc           | 11 ++++++++---
 winsup/cygwin/local_includes/fhandler.h |  3 ++-
 winsup/cygwin/release/3.4.9             |  6 ++++++
 3 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 winsup/cygwin/release/3.4.9

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 607333f52..3f4bc56b5 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -85,7 +85,8 @@ inline static bool process_alive (DWORD pid);
      stub_only: return only stub process's pid of non-cygwin process. */
 DWORD
 fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
-					     bool cygwin, bool stub_only)
+					     bool cygwin, bool stub_only,
+					     bool nat)
 {
   tmp_pathbuf tp;
   DWORD *list = (DWORD *) tp.c_get ();
@@ -109,6 +110,8 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 	else
 	  {
 	    pinfo p (cygwin_pid (list[i]));
+	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
+	      continue;
 	    if (!!p && p->exec_dwProcessId)
 	      {
 		res_pri = stub_only ? p->exec_dwProcessId : list[i];
@@ -3511,9 +3514,11 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
     {
       /* Search another native process which attaches to the same console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
-      switch_to = get_console_process_id (current_pid, false, true, true);
+      switch_to = get_console_process_id (current_pid,
+					  false, true, true, true);
       if (!switch_to)
-	switch_to = get_console_process_id (current_pid, false, true, false);
+	switch_to = get_console_process_id (current_pid,
+					    false, true, false, true);
     }
   return switch_to;
 }
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 03b51a7e4..9af5f716c 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2399,7 +2399,8 @@ class fhandler_pty_common: public fhandler_termios
   void resize_pseudo_console (struct winsize *);
   static DWORD get_console_process_id (DWORD pid, bool match,
 				       bool cygwin = false,
-				       bool stub_only = false);
+				       bool stub_only = false,
+				       bool nat = false);
   bool to_be_read_from_nat_pipe (void);
   static DWORD attach_console_temporarily (DWORD target_pid);
   static void resume_from_temporarily_attach (DWORD resume_pid);
diff --git a/winsup/cygwin/release/3.4.9 b/winsup/cygwin/release/3.4.9
new file mode 100644
index 000000000..d089e5a9a
--- /dev/null
+++ b/winsup/cygwin/release/3.4.9
@@ -0,0 +1,6 @@
+Bug Fixes
+---------
+
+- Fix a bug introduced in cygwin 3.4.0 that switch_to_nat_pipe flag is
+  not cleared properly when non-cygwin app is terminated in the case
+  where pseudo console is not activated.
-- 
2.39.0

