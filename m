Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 4E1CB3858429
 for <cygwin-patches@cygwin.com>; Mon, 21 Feb 2022 22:46:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4E1CB3858429
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21LMjjec007755;
 Tue, 22 Feb 2022 07:45:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21LMjjec007755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645483550;
 bh=Fld45aSR/2acLkwh6Oc4Iyw7qzscojwSrujKmQUU6fE=;
 h=From:To:Cc:Subject:Date:From;
 b=O5SXN1Hm7PI05THfh/vBkB8XBl3bPzfai1nya6pFiYd8Hh+zQr6a0J/Q9E9TFsVeC
 3URAZC+NWv4LX2q5m4FnMiwk1HB9dvHciCR5NoNzHwAISFa4xiFfhYWwrvPHOSsmEv
 krx++UMP8acAT7fp//PE4oyUQpxQpKNOOzCU6MPmFkUk/um68u+pH9fdPk0o0C6VK9
 JAqHMwt+1zcqzsVMGWm4V26g+Iu0sSJoitI4fhLkkvPuj6/jZSYXBXfvRxMabuIX6p
 bftbb9nI98GULELeM0DmVHnJcIqCvlvb89Gnrfg3dmCbfDoegZa9gqNDrZ6eTgH3ti
 c4IDLw9is0qiw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Encapsulate pty code in tty::setpgid().
Date: Tue, 22 Feb 2022 07:45:43 +0900
Message-Id: <20220221224543.1310-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 21 Feb 2022 22:46:15 -0000

- This patch hides complex pty codes in tty::setpgid() to transfer
  input into the class fhandler_pty_slave by encapsulating it.
---
 winsup/cygwin/fhandler.h      |  2 ++
 winsup/cygwin/fhandler_tty.cc | 51 ++++++++++++++++++++++++++++
 winsup/cygwin/tty.cc          | 62 ++---------------------------------
 3 files changed, 56 insertions(+), 59 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 40dab9346..91e5437ca 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1956,6 +1956,7 @@ class fhandler_termios: public fhandler_base
   static bool path_iscygexec_w (LPCWSTR n, LPWSTR c);
   virtual bool is_pty_master_with_pcon () { return false; }
   virtual void cleanup_before_exit () {}
+  virtual void setpgid_aux (pid_t pid) {}
 };
 
 enum ansi_intensity
@@ -2400,6 +2401,7 @@ class fhandler_pty_slave: public fhandler_pty_common
 				 bool stdin_is_ptys);
   static void cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 					  bool stdin_is_ptys);
+  void setpgid_aux (pid_t pid);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 10026b995..b9549bba9 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -4047,3 +4047,54 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
   close_pseudoconsole (ttyp);
   ReleaseMutex (p->pcon_mutex);
 }
+
+void
+fhandler_pty_slave::setpgid_aux (pid_t pid)
+{
+  WaitForSingleObject (pcon_mutex, INFINITE);
+  bool was_pcon_fg = get_ttyp ()->pcon_fg (tc ()->pgid);
+  bool pcon_fg = get_ttyp ()->pcon_fg (pid);
+  if (!was_pcon_fg && pcon_fg && get_ttyp ()->switch_to_pcon_in
+      && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
+    {
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      transfer_input (tty::to_nat, get_handle (), get_ttyp (),
+		      input_available_event);
+      ReleaseMutex (input_mutex);
+    }
+  else if (was_pcon_fg && !pcon_fg && get_ttyp ()->switch_to_pcon_in
+	   && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+    {
+      bool attach_restore = false;
+      HANDLE from = get_handle_nat ();
+      if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid
+	  && !get_console_process_id (get_ttyp ()->pcon_pid, true))
+	{
+	  HANDLE pcon_owner =
+	    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+			   GetCurrentProcess (), &from,
+			   0, TRUE, DUPLICATE_SAME_ACCESS);
+	  CloseHandle (pcon_owner);
+	  FreeConsole ();
+	  AttachConsole (get_ttyp ()->pcon_pid);
+	  attach_restore = true;
+	}
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      transfer_input (tty::to_cyg, from, get_ttyp (), input_available_event);
+      ReleaseMutex (input_mutex);
+      if (attach_restore)
+	{
+	  FreeConsole ();
+	  pinfo p (myself->ppid);
+	  if (p)
+	    {
+	      if (!AttachConsole (p->dwProcessId))
+		AttachConsole (ATTACH_PARENT_PROCESS);
+	    }
+	  else
+	    AttachConsole (ATTACH_PARENT_PROCESS);
+	}
+    }
+  ReleaseMutex (pcon_mutex);
+}
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index bc5c96e66..25b621227 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -306,65 +306,9 @@ extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
 void
 tty_min::setpgid (int pid)
 {
-  fhandler_pty_slave *ptys = NULL;
-  cygheap_fdenum cfd (false);
-  while (cfd.next () >= 0 && ptys == NULL)
-    if (cfd->get_device () == getntty ()
-	&& cfd->get_major () == DEV_PTYS_MAJOR)
-      ptys = (fhandler_pty_slave *) (fhandler_base *) cfd;
-
-  if (ptys)
-    {
-      tty *ttyp = (tty *) ptys->tc ();
-      WaitForSingleObject (ptys->pcon_mutex, INFINITE);
-      bool was_pcon_fg = ttyp->pcon_fg (pgid);
-      bool pcon_fg = ttyp->pcon_fg (pid);
-      if (!was_pcon_fg && pcon_fg && ttyp->switch_to_pcon_in
-	  && ttyp->pcon_input_state_eq (tty::to_cyg))
-	{
-	WaitForSingleObject (ptys->input_mutex, mutex_timeout);
-	fhandler_pty_slave::transfer_input (tty::to_nat,
-					    ptys->get_handle (), ttyp,
-					    ptys->get_input_available_event ());
-	ReleaseMutex (ptys->input_mutex);
-	}
-      else if (was_pcon_fg && !pcon_fg && ttyp->switch_to_pcon_in
-	       && ttyp->pcon_input_state_eq (tty::to_nat))
-	{
-	  bool attach_restore = false;
-	  HANDLE from = ptys->get_handle_nat ();
-	  if (ttyp->pcon_activated && ttyp->pcon_pid
-	      && !ptys->get_console_process_id (ttyp->pcon_pid, true))
-	    {
-	      HANDLE pcon_owner =
-		OpenProcess (PROCESS_DUP_HANDLE, FALSE, ttyp->pcon_pid);
-	      DuplicateHandle (pcon_owner, ttyp->h_pcon_in,
-			       GetCurrentProcess (), &from,
-			       0, TRUE, DUPLICATE_SAME_ACCESS);
-	      CloseHandle (pcon_owner);
-	      FreeConsole ();
-	      AttachConsole (ttyp->pcon_pid);
-	      attach_restore = true;
-	    }
-	  WaitForSingleObject (ptys->input_mutex, mutex_timeout);
-	  fhandler_pty_slave::transfer_input (tty::to_cyg, from, ttyp,
-				  ptys->get_input_available_event ());
-	  ReleaseMutex (ptys->input_mutex);
-	  if (attach_restore)
-	    {
-	      FreeConsole ();
-	      pinfo p (myself->ppid);
-	      if (p)
-		{
-		  if (!AttachConsole (p->dwProcessId))
-		    AttachConsole (ATTACH_PARENT_PROCESS);
-		}
-	      else
-		AttachConsole (ATTACH_PARENT_PROCESS);
-	    }
-	}
-      ReleaseMutex (ptys->pcon_mutex);
-    }
+  if (::cygheap->ctty)
+    ::cygheap->ctty->setpgid_aux (pid);
+
   pgid = pid;
 }
 
-- 
2.35.1

