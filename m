Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id ABA8D3858D20
 for <cygwin-patches@cygwin.com>; Thu,  3 Mar 2022 18:15:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org ABA8D3858D20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 223IFUm3020146;
 Fri, 4 Mar 2022 03:15:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 223IFUm3020146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646331336;
 bh=4OlXoRRAL6WVwatnUtbK+OM2oI1abYPtVd1fSgVfFNo=;
 h=From:To:Cc:Subject:Date:From;
 b=aRK/ObWvYn+F8WmQ2CZWWv3jYOk04GYt+ypDMBtCeeeMCkokNM+Z+oxRIf/Rf81Qb
 fBJXnUREdRfvIn/vDXEx8HZqS6CFodGpcXIX0SfYXlR1M+BN8uUWNBTUhB2ar7reim
 u01Fw7kL0GpGhiKSt6EeJolVBN2UZnVOUR6ZZAALXLKe8eayketP/ipUURyIuVfhe3
 3mTMY/DO530hG+O5h8TO2PmMMymODopiTKt16ku21QmA3HUxaLZkFz70IveAMLvv62
 jY52UjgvijBB3Sc5F67xpax8NcG/ncYDb/WQ/YXPUstk4/sXgrwygDirZDPC44zfOw
 eL8CC0LWUyPfA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Stop to use PID_NEW_PG flag as a marker for GDB.
Date: Fri,  4 Mar 2022 03:15:24 +0900
Message-Id: <20220303181524.5123-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Thu, 03 Mar 2022 18:16:05 -0000

- Previously, the PID_NEW_PG flag was also used as a marker for GDB
  with non-cygwin inferior, unlike its original meaning. With this
  patch, the condition exec_dwProcessId == dwProcessId is used as a
  marker for that instead.
---
 winsup/cygwin/fhandler_termios.cc | 14 +++++++-------
 winsup/cygwin/fhandler_tty.cc     | 11 ++++++-----
 winsup/cygwin/tty.cc              |  4 +++-
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 3740ba011..5cd44d7bf 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -341,15 +341,16 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
     {
       _pinfo *p = pids[i];
       /* PID_NOTCYGWIN: check this for non-cygwin process.
-	 PID_NEW_PG: check this ofr GDB with non-cygwin inferior in pty
+	 exec_dwProcessId == dwProcessId:
+		     check this for GDB with non-cygwin inferior in pty
 		     without pcon enabled. In this case, the inferior is not
-		     cygwin process list. PID_NEW_PG is set as a marker for
-		     GDB with non-cygwin inferior in pty code.
+		     cygwin process list. This condition is set true as
+		     a marker for GDB with non-cygwin inferior in pty code.
 	 !PID_CYGPARENT: check this for GDB with cygwin inferior or
 			 cygwin apps started from non-cygwin shell. */
       if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
 	  && ((p->process_state & PID_NOTCYGWIN)
-	      || (p->process_state & PID_NEW_PG)
+	      || (p->exec_dwProcessId == p->dwProcessId)
 	      || !(p->process_state & PID_CYGPARENT)))
 	{
 	  /* Ctrl-C event will be sent only to the processes attaching
@@ -369,8 +370,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  /* CTRL_C_EVENT does not work for the process started with
 	     CREATE_NEW_PROCESS_GROUP flag, so send CTRL_BREAK_EVENT
 	     instead. */
-	  if ((p->process_state & PID_NEW_PG)
-	      && (p->process_state & PID_NOTCYGWIN))
+	  if (p->process_state & PID_NEW_PG)
 	    GenerateConsoleCtrlEvent (CTRL_BREAK_EVENT, p->dwProcessId);
 	  else if ((!fh || fh->need_send_ctrl_c_event () || cyg_leader)
 		   && !ctrl_c_event_sent) /* cyg_leader is needed by GDB
@@ -405,7 +405,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      && (p->process_state & PID_DEBUGGED))
 	    with_debugger = true; /* inferior is cygwin app */
 	  if (!(p->process_state & PID_NOTCYGWIN)
-	      && (p->process_state & PID_NEW_PG) /* Check marker */
+	      && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
 	      && p->pid == pgid)
 	    with_debugger_nat = true; /* inferior is non-cygwin app */
 	}
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c7588a073..52f0b8622 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -116,8 +116,9 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
   return res_pri ?: res;
 }
 
-static bool isHybrid; /* Set true if the active pipe is set to nat pipe even
-			 though the current process is a cygwin process. */
+static bool isHybrid; /* Set true if the active pipe is set to nat pipe 
+			 owned by myself even though the current process
+			 is a cygwin process. */
 static HANDLE h_gdb_inferior; /* Handle of GDB inferior process. */
 
 static void
@@ -1079,8 +1080,9 @@ fhandler_pty_slave::set_switch_to_nat_pipe (void)
     {
       isHybrid = true;
       setup_locale ();
-      myself->exec_dwProcessId = myself->dwProcessId;
-      myself->process_state |= PID_NEW_PG; /* Marker for nat_fg */
+      myself->exec_dwProcessId = myself->dwProcessId; /* Set this as a marker
+							 for tty::nat_fg()
+							 and process_sigs() */
       bool stdin_is_ptys = GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
       setup_for_non_cygwin_app (false, NULL, stdin_is_ptys);
     }
@@ -1199,7 +1201,6 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		    }
 		}
 	      myself->exec_dwProcessId = 0;
-	      myself->process_state &= ~PID_NEW_PG;
 	      isHybrid = false;
 	    }
 	}
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index b2218fef7..60f4a602a 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -342,7 +342,9 @@ tty::nat_fg (pid_t pgid)
     {
       _pinfo *p = pids[i];
       if (p->ctty == ntty && p->pgid == pgid
-	  && (p->process_state & (PID_NOTCYGWIN | PID_NEW_PG)))
+	  && ((p->process_state & PID_NOTCYGWIN)
+	      /* Below is true for GDB with non-cygwin inferior */
+	      || p->exec_dwProcessId == p->dwProcessId))
 	return true;
     }
   if (pgid > MAX_PID)
-- 
2.35.1

