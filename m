Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 867A53858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 06:49:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 867A53858D1E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21Q6mnmt020729;
 Sat, 26 Feb 2022 15:48:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21Q6mnmt020729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645858136;
 bh=Et2fe5onTkB014823hcDk8eS6YC5JFwrRyTgGbLHljA=;
 h=From:To:Cc:Subject:Date:From;
 b=Ogb111Iu4w26zdZtgZ8rq8UURChdAZdmmltCWMRrog11gcD5VhMWc3hEKE4IjTjRK
 i6g/DNpRzsdSQrCOSCks22N9TYlYoHoSX8+81Ayc16ydfyr7wVgUYx7CR19TgP3oyd
 yTkmheAHNjiQGSgN1w0ubNobeh3BOyIhkRX00r89LlLhDUYQJqbdhyHMRqzRkXDxaX
 R3hWraKgWoUoQ6TCrFHAWC+I/GTCAo8sqew/llFbKESgZ2nWQatEYFMzKzZXfzFDum
 TC2C1H8yEFHaWPTY+3PAfFOdnRzwaz93ICR68S+/539TVLZOPvMp2gYfg+1Pdv/4yG
 Wp4gzHki87ucg==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pinfo: Fix exit code for non-cygwin apps which reads
 console.
Date: Sat, 26 Feb 2022 15:48:51 +0900
Message-Id: <20220226064851.1483-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 26 Feb 2022 06:49:12 -0000

- The recent commit "Cygwin: pinfo: Fix exit code when non-cygwin app
  exits by Ctrl-C." did not fix enough the issue. If a non-cygwin app
  is reading the console, it will not return STATUS_CONTROL_C_EXIT
  even if it is terminated by Ctrl-C. As a result, the previous patch
  does not take effect.
  This patch solves this issue by setting sigExeced to SIGINT in
  ctrl_c_handler(). In addition, sigExeced will be cleared if the app
  does not terminated within predetermined time period. The reason is
  that the app does not seem to be terminated by the signal sigExeced.
---
 winsup/cygwin/exceptions.cc |  6 +++++-
 winsup/cygwin/globals.cc    |  2 +-
 winsup/cygwin/spawn.cc      | 10 +++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 73bf68939..f6a755b3c 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1139,7 +1139,11 @@ ctrl_c_handler (DWORD type)
     }
 
   if (ch_spawn.set_saw_ctrl_c ())
-    return TRUE;
+    {
+      if (myself->process_state & PID_NOTCYGWIN)
+	sigExeced = SIGINT;
+      return TRUE;
+    }
 
   /* We're only the process group leader when we have a valid pinfo structure.
      If we don't have one, then the parent "stub" will handle the signal. */
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index ac5ad0307..d3a2e11a4 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -20,7 +20,7 @@ HANDLE NO_COPY hProcImpToken;
 HANDLE my_wr_proc_pipe;
 HMODULE NO_COPY cygwin_hmodule;
 HMODULE NO_COPY hntdll;
-int NO_COPY sigExeced;
+LONG NO_COPY sigExeced;
 WCHAR windows_system_directory[MAX_PATH];
 UINT windows_system_directory_length;
 WCHAR system_wow64_directory[MAX_PATH];
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 3647580a6..df9ad84a7 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -953,7 +953,15 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (sem)
 	    __posix_spawn_sem_release (sem, 0);
 	  if (ptys_need_cleanup || cons_need_cleanup)
-	    WaitForSingleObject (pi.hProcess, INFINITE);
+	    {
+	      LONG prev_sigExeced = sigExeced;
+	      while (WaitForSingleObject (pi.hProcess, 100) == WAIT_TIMEOUT)
+		/* If child process does not exit in predetermined time
+		   period, the process does not seem to be terminated by
+		   the signal sigExeced. Therefore, clear sigExeced here. */
+		prev_sigExeced =
+		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
+	    }
 	  if (ptys_need_cleanup)
 	    {
 	      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
-- 
2.35.1

