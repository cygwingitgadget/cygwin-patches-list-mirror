Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 20955385840C
 for <cygwin-patches@cygwin.com>; Mon, 13 Dec 2021 10:47:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 20955385840C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v050141.dynamic.ppp.asahi-net.or.jp
 [124.155.50.141]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1BDAkuW5009870;
 Mon, 13 Dec 2021 19:47:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BDAkuW5009870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639392420;
 bh=/SKxMn4BE9UHQufqnG/sdWnwmX9qswPwkBb/gALiBdw=;
 h=From:To:Cc:Subject:Date:From;
 b=hp+nuNr5kOEs4gqi7FbxYxyp9g/1DOLSrHUtazQv8O062R6qb08PTxVLYWfVKg54u
 vibo7jBPh35KZ3IqQU63uyrxPp7OPPlRJpG1EEi4zNdEFig80IH1hruCpIrTuY+LJq
 aMPJfhI0Y18laGIjWupXZoNr0oPkvTYuqR1x4C11WjUTL1NuZh4w/UfufnoBV+zKLd
 hq7Ma8UzwQt+gSu4x4Bgy/Kcz31CwZUa8vFGwGI5f/UoM9A8hU7T1syQK6oBHFmg5s
 0xIch74AQJ6elDK2qNwhPYsQIUcPl+D+Y/DkXsFtjJqNxzzlqxqHG4jmPyB9lPlMg1
 48wajQk3kLIIw==
X-Nifty-SrcIP: [124.155.50.141]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix Ctrl-C handling further for non-cygwin apps.
Date: Mon, 13 Dec 2021 19:46:46 +0900
Message-Id: <20211213104646.1372-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 13 Dec 2021 10:47:22 -0000

- The recent commit: "Cygwin: pty: Fix Ctrl-C handling for non-cygwin
  apps in background." causes the problem that cmd.exe is terminated
  by Ctrl-C even if it is running in pseudo console. This patch fixes
  the issue.
---
 winsup/cygwin/fhandler_tty.cc      | 36 +++++++++++++++++++++++++++++-
 winsup/cygwin/include/sys/cygwin.h |  2 ++
 winsup/cygwin/spawn.cc             |  3 +++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7b18a15e7..5ec5b235d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2251,7 +2251,41 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
       if ((ti.c_lflag & ISIG) && memchr (buf, '\003', nlen))
 	{
-	  get_ttyp ()->kill_pgrp (SIGINT);
+	  /* If the process is started with CREATE_NEW_PROCESS_GROUP
+	     flag, Ctrl-C will not be sent to that process. Therefore,
+	     send Ctrl-break event to that process here. */
+	  DWORD wpid = 0;
+	  winpids pids ((DWORD) 0);
+	  for (unsigned i = 0; i < pids.npids; i++)
+	    {
+	      _pinfo *p = pids[i];
+	      if (p->ctty == get_ttyp ()->ntty
+		  && p->pgid == get_ttyp ()->getpgid ()
+		  && (p->process_state & PID_NEW_PG))
+		{
+		  wpid = p->dwProcessId;
+		  break;
+		}
+	    }
+	  pinfo pinfo_resume = pinfo (myself->ppid);
+	  DWORD resume_pid;
+	  if (pinfo_resume)
+	    resume_pid = pinfo_resume->dwProcessId;
+	  else
+	    resume_pid = get_console_process_id (myself->dwProcessId, false);
+	  if (wpid && resume_pid)
+	    {
+	      WaitForSingleObject (pcon_mutex, INFINITE);
+	      FreeConsole ();
+	      AttachConsole (wpid);
+	      /* CTRL_C_EVENT does not work for the process started with
+		 CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
+		 instead. */
+	      GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, wpid);
+	      FreeConsole ();
+	      AttachConsole (resume_pid);
+	      ReleaseMutex (pcon_mutex);
+	    }
 	  if (!(ti.c_lflag & NOFLSH))
 	    get_ttyp ()->discard_input = true;
 	}
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index 805671ef9..ac55ab09c 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -274,6 +274,8 @@ enum
   PID_NEW	       = 0x01000, /* Available. */
   PID_ALLPIDS	       = 0x02000, /* used by pinfo scanner */
   PID_PROCINFO	       = 0x08000, /* caller just asks for process info */
+  PID_NEW_PG	       = 0x10000, /* Process created with
+				     CREATE_NEW_PROCESS_GROUOP flag */
   PID_EXITED	       = 0x40000000, /* Free entry. */
   PID_REAPED	       = 0x80000000  /* Reaped */
 };
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index bea4d0194..b93063d9b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -575,6 +575,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();
 
+      if (c_flags & CREATE_NEW_PROCESS_GROUP)
+	myself->process_state |= PID_NEW_PG;
+
       if (mode == _P_DETACH)
 	/* all set */;
       else if (mode != _P_OVERLAY || !my_wr_proc_pipe)
-- 
2.34.1

