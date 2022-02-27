Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 471933858D28
 for <cygwin-patches@cygwin.com>; Sun, 27 Feb 2022 00:46:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 471933858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 21R0k9dE022141;
 Sun, 27 Feb 2022 09:46:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 21R0k9dE022141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645922775;
 bh=ar9c3vxr5+Feipxs5jWJS1P/qNZ/AsspBQBH78eWg4s=;
 h=From:To:Cc:Subject:Date:From;
 b=Hi6mm+P3VXD4V49/3xFYBv1/eBK3aYVv03XWjIe+6ihRWkGZAKuTm1QOcb6SKz9nt
 8o9pme07zBIK2aiQBJLgo0JgyEiBfjStb1bUXtbof7DApAmSQ/xHnAzhADBHYo+EQN
 shBNhECKSxkaiFIBwVGu9O+t6TJHqW0ZxUyon8G+uDkJM6cOotSk9SP6ldzfbiJsPm
 PhWwicP0xxGJtdcv/BaIn6yxG5Qr8yLckZDN90VtnsVFl616GDA6x5HnbZiSprF8Wj
 5XwAnQla5W5zJMB5Z1Zjqyl9405P1bAmS2rsbS4cop8dj8rVfJ9YNAZogkaNCjzYh5
 D+9XK28sFJrZw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pinfo: Fix exit code for non-cygwin apps which
 reads console.
Date: Sun, 27 Feb 2022 09:46:07 +0900
Message-Id: <20220227004607.2051-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 27 Feb 2022 00:46:46 -0000

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
 winsup/cygwin/spawn.cc      | 15 ++++++++++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 6e0b862c7..070e52e76 100644
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
index 3647580a6..3b54309a2 100644
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
@@ -966,6 +974,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
 	      fhandler_console::close_handle_set (&cons_handle_set);
 	    }
+	  /* Make sure that ctrl_c_handler() is not on going. Calling
+	     init_console_handler(false) locks until returning from
+	     ctrl_c_handler(). This insures that setting sigExeced
+	     on Ctrl-C key has been completed. */
+	  init_console_handler (false);
 	  myself.exit (EXITCODE_NOSET);
 	  break;
 	case _P_WAIT:
-- 
2.35.1

