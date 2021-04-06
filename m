Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id DDF1B3858034
 for <cygwin-patches@cygwin.com>; Tue,  6 Apr 2021 00:40:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DDF1B3858034
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 1360eEXj029110;
 Tue, 6 Apr 2021 09:40:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1360eEXj029110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1617669619;
 bh=yr+u3z4Cbh6RGuWEZ6F+6QnEii2V2d7/sne5st+FR0w=;
 h=From:To:Cc:Subject:Date:From;
 b=J5SwDYUZELZaQ/+GBoNmJJsTX5WtPZHQ2fom6+W6YYY25gmVt8JnU08guJ6WGnSNP
 nRuZqpKg8XoGd9JJTEHItKqTH1IUrvp/LCDA/YX2MaJyxmuRPUiATdRQ8DaEdOzijv
 qDd6CqhWPtRrHItdBGo0TCR+d3lQf0MlZE3w6ybOUpiHlOUtJ5UTS3rbe376W5vAP+
 MgiA+UJEp4cMbFn0a4TXRr6qRYN+4s9AkuoF1Hu/dUXdzx+YloHTXsO2dD7V0msuZi
 FquUavjADMgppxeYdN2QEZoL8005iFfBVjhkeDJ4QWkJ4qZWH71waKk6s8SdlkplPy
 e4JXd5/tpKE3w==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pty: Use atexit() instead of hooking exit() for
 GDB.
Date: Tue,  6 Apr 2021 09:40:13 +0900
Message-Id: <20210406004013.841-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Tue, 06 Apr 2021 00:40:41 -0000

- This patch utilizes atexit() instead of hooking exit() to clean
  up pseudo console stuff when debugging non-cygwin app using GDB.
---
 winsup/cygwin/fhandler.h      |   2 +-
 winsup/cygwin/fhandler_tty.cc | 100 +++++++++++++++++++++++-----------
 winsup/cygwin/tty.cc          |   2 +
 3 files changed, 70 insertions(+), 34 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 15fbd09b0..9df617b99 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2374,7 +2374,7 @@ class fhandler_pty_slave: public fhandler_pty_common
     return fh;
   }
   bool setup_pseudoconsole (bool nopcon);
-  static void close_pseudoconsole (tty *ttyp);
+  static void close_pseudoconsole (tty *ttyp, DWORD force_switch_to = 0);
   bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 12247dd99..470fe8d42 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -147,11 +147,47 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
     *err = replace_err->get_output_handle_nat ();
 }
 
+static bool atexit_func_registered = false;
+static bool debug_process = false;
+
+static void
+atexit_func (void)
+{
+  if (isHybrid)
+    {
+      cygheap_fdenum cfd (false);
+      while (cfd.next () >= 0)
+	if (cfd->get_device () == (dev_t) myself->ctty)
+	  {
+	    DWORD force_switch_to = 0;
+	    if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT
+		&& !debug_process)
+	      force_switch_to = GetProcessId (h_gdb_process);
+	    fhandler_base *fh = cfd;
+	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+	    tty *ttyp = ptys->get_ttyp ();
+	    HANDLE from = ptys->get_handle_nat ();
+	    HANDLE input_available_event = ptys->get_input_available_event ();
+	    if (ttyp->getpgid () == myself->pgid
+		&& GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ()
+		&& ttyp->pcon_input_state_eq (tty::to_nat) && !force_switch_to)
+	      {
+		WaitForSingleObject (ptys->input_mutex, INFINITE);
+		fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
+						    input_available_event);
+		ReleaseMutex (ptys->input_mutex);
+	      }
+	    ptys->close_pseudoconsole (ttyp, force_switch_to);
+	    break;
+	  }
+      CloseHandle (h_gdb_process);
+    }
+}
+
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
 /* CreateProcess() is hooked for GDB etc. */
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
-DEF_HOOK (exit);
 
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -207,8 +243,15 @@ CreateProcessA_Hooked
   DuplicateHandle (GetCurrentProcess (), h_gdb_process,
 		   GetCurrentProcess (), &h_gdb_process,
 		   0, 0, DUPLICATE_SAME_ACCESS);
+  debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
+  if (!atexit_func_registered && !path.iscygexec ())
+    {
+      atexit (atexit_func);
+      atexit_func_registered = true;
+    }
   return ret;
 }
+
 static BOOL WINAPI
 CreateProcessW_Hooked
      (LPCWSTR n, LPWSTR c, LPSECURITY_ATTRIBUTES pa, LPSECURITY_ATTRIBUTES ta,
@@ -263,36 +306,13 @@ CreateProcessW_Hooked
   DuplicateHandle (GetCurrentProcess (), h_gdb_process,
 		   GetCurrentProcess (), &h_gdb_process,
 		   0, 0, DUPLICATE_SAME_ACCESS);
-  return ret;
-}
-
-void
-exit_Hooked (int e)
-{
-  if (isHybrid)
+  debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
+  if (!atexit_func_registered && !path.iscygexec ())
     {
-      cygheap_fdenum cfd (false);
-      while (cfd.next () >= 0)
-	if (cfd->get_device () == (dev_t) myself->ctty)
-	  {
-	    fhandler_base *fh = cfd;
-	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	    tty *ttyp = ptys->get_ttyp ();
-	    HANDLE from = ptys->get_handle_nat ();
-	    HANDLE input_available_event = ptys->get_input_available_event ();
-	    if (ttyp->getpgid () == myself->pgid
-		&& GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ()
-		&& ttyp->pcon_input_state_eq (tty::to_nat))
-	      {
-		WaitForSingleObject (ptys->input_mutex, INFINITE);
-		fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
-						    input_available_event);
-		ReleaseMutex (ptys->input_mutex);
-	      }
-	    break;
-	  }
+      atexit (atexit_func);
+      atexit_func_registered = true;
     }
-  exit_Orig (e);
+  return ret;
 }
 
 static void
@@ -1131,6 +1151,15 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
   if (isHybrid)
     return;
   WaitForSingleObject (pcon_mutex, INFINITE);
+  HANDLE h;
+  if (get_ttyp ()->pcon_pid > MAX_PID &&
+      (h = OpenProcess (SYNCHRONIZE, FALSE, get_ttyp ()->pcon_pid - MAX_PID)))
+    {
+      /* There is a process which is grabbing pseudo console. */
+      CloseHandle (h);
+      ReleaseMutex (pcon_mutex);
+      return;
+    }
   if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
       && !!pinfo (get_ttyp ()->pcon_pid))
     {
@@ -1138,6 +1167,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       ReleaseMutex (pcon_mutex);
       return;
     }
+  get_ttyp ()->pcon_input_state = tty::to_cyg;
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->pcon_activated = false;
@@ -2337,8 +2367,6 @@ fhandler_pty_slave::fixup_after_exec ()
   /* CreateProcess() is hooked for GDB etc. */
   DO_HOOK (NULL, CreateProcessA);
   DO_HOOK (NULL, CreateProcessW);
-  if (CreateProcessA_Orig || CreateProcessW_Orig)
-    DO_HOOK (NULL, exit);
 }
 
 /* This thread function handles the master control pipe.  It waits for a
@@ -3344,11 +3372,17 @@ fallback:
 /* The function close_pseudoconsole() should be static so that it can
    be called even after the fhandler_pty_slave instance is deleted. */
 void
-fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
+fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 {
   DWORD switch_to_stub = 0, switch_to = 0;
   DWORD new_pcon_pid = 0;
-  if (ttyp->pcon_pid == myself->pid)
+  if (force_switch_to)
+    {
+      switch_to_stub = force_switch_to;
+      new_pcon_pid = force_switch_to + MAX_PID;
+      ttyp->setpgid (new_pcon_pid);
+    }
+  else if (ttyp->pcon_pid == myself->pid)
     {
       /* Search another process which attaches to the pseudo console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 5ed88d0e4..96acde387 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -402,5 +402,7 @@ tty::pcon_fg (pid_t pgid)
       if (p->ctty == ntty && p->pgid == pgid && p->exec_dwProcessId)
 	return true;
     }
+  if (pgid > MAX_PID)
+    return true;
   return false;
 }
-- 
2.31.1

