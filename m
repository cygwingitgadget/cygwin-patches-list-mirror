Return-Path: <SRS0=qSGf=SB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 1D60D3858D21
	for <cygwin-patches@cygwin.com>; Wed,  6 Nov 2024 08:44:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D60D3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D60D3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730882697; cv=none;
	b=TYCU7UbLADGSkjpmNYMvWDY84JK6OmVQtFjIpKf7r3RNBonryNBrqzUCnamkM/2OPvhrAm8bGeHq3KYXXwtGNYzquxyf87gsMa09DBXohp4wse1srzGMCpvjkCqM5bTuFllMUzeS6esWeUAqOk3g36PSuIUchXOafyDWsaiyvIw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730882697; c=relaxed/simple;
	bh=lin7K3+CAtV6/dyjg9Ar+7WTlJjK/4o65UVMKGQmIxU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=esYT2WbU0WX+tM2L64Po3US6WVasGMycyS9Ahpw+BfbWp5iR3z0D7Gg3TR7Ma7I9WFxzAyDA9qaxvWO5CIsS/ItKpfp/PS+1KQ4q+bkwWuOzgCyIDIXxVb9x7VYkkHGzA0/r4LoOQUQq84HC2JZuRCD3woqfZlvyVtO2+cG6u5c=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241106084450427.RQDR.81160.localhost.localdomain@nifty.com>;
          Wed, 6 Nov 2024 17:44:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Re-fix open() failure on exec() by console owner
Date: Wed,  6 Nov 2024 17:44:26 +0900
Message-ID: <20241106084435.17357-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730882690;
 bh=j8OYd3ZhUcLKvmVb5miaWVXaH1JlxRedrmesngQUnGM=;
 h=From:To:Cc:Subject:Date;
 b=Tsyl5JphJJUMu1SE4eepMCpOKF1oFrtAMk9TB7b8PrtNWAY4CSvSmlsbVJ2ZwUlAdrFrutyw
 T4sBS1T0bHL6u7ukMS1kyeZLgZfklH1etQNiNpN4I9jLSiNU/uz26nnZNfuNQJCygXju4vQowA
 7g8wl9AiI812hxnkmZldPsaeB0T+YlurkagMX+iSSghzqO1ssx69mQy8gmKARldBIp8YQBXX7G
 xm5WqMR89Gie0hugYXXaDouvJ42tHFbsEOPrg6u/TcOUnZho2cSKvltdTXSWLYXSu3GBv9p0np
 YjeM5KZNhj1v3Q7GwDwzxmu33v1BbUG5veQg1yRr/UzNBOnQ==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previous fix (commit df0953aa298c) fixes only a part of the problem.
Since exec() overrides the cygwin pid of the caller process, it makes
console owner handling complex. This patch makes console use Windows
pid as the owner pid (con.owner) instead of cygwin pid to make the
handling simpler.

Fixes: df0953aa298c ("Cygwin: console: Fix open() failure when the console owner calls exec().")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc       | 86 ++++++++++---------------
 winsup/cygwin/fhandler/pty.cc           | 73 ---------------------
 winsup/cygwin/fhandler/termios.cc       | 72 +++++++++++++++++++++
 winsup/cygwin/local_includes/fhandler.h | 19 +++---
 4 files changed, 117 insertions(+), 133 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index ac47c8374..7ac926554 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -75,43 +75,33 @@ static struct fhandler_base::rabuf_t con_ra;
 static wchar_t last_char;
 
 DWORD
-fhandler_console::attach_console (pid_t owner, bool *err)
+fhandler_console::attach_console (DWORD owner, bool *err)
 {
   DWORD resume_pid = (DWORD) -1;
-  pinfo p (owner);
-  if (p)
+  if (!process_alive (owner))
+    return resume_pid;
+  DWORD attached =
+    get_console_process_id (owner, true, false, false);
+  if (!attached)
     {
-      DWORD attached =
-	fhandler_pty_common::get_console_process_id (p->dwProcessId,
-						     true, false, false);
-      if (!attached)
-	attached =
-	  fhandler_pty_common::get_console_process_id (p->exec_dwProcessId,
-						       true, false, false);
-      if (!attached)
+      resume_pid =
+	get_console_process_id (myself->dwProcessId, false, false, false);
+      FreeConsole ();
+      BOOL r = AttachConsole (owner);
+      if (!r)
 	{
-	  resume_pid =
-	    fhandler_pty_common::get_console_process_id (myself->dwProcessId,
-							 false, false, false);
-	  FreeConsole ();
-	  BOOL r = AttachConsole (p->dwProcessId);
-	  if (!r)
-	    r = AttachConsole (p->exec_dwProcessId);
-	  if (!r)
-	    {
-	      if (resume_pid)
-		AttachConsole (resume_pid);
-	      if (err)
-		*err = true;
-	      return (DWORD) -1;
-	    }
+	  if (resume_pid)
+	    AttachConsole (resume_pid);
+	  if (err)
+	    *err = true;
+	  return (DWORD) -1;
 	}
     }
   return resume_pid;
 }
 
 void
-fhandler_console::detach_console (DWORD resume_pid, pid_t owner)
+fhandler_console::detach_console (DWORD resume_pid, DWORD owner)
 {
   if (resume_pid == (DWORD) -1)
     return;
@@ -120,11 +110,11 @@ fhandler_console::detach_console (DWORD resume_pid, pid_t owner)
       FreeConsole ();
       AttachConsole (resume_pid);
     }
-  else if (myself->pid != owner)
+  else if (myself->dwProcessId != owner)
     FreeConsole ();
 }
 
-pid_t
+DWORD
 fhandler_console::get_owner ()
 {
   return con.owner;
@@ -143,14 +133,14 @@ public:
   {
     empty ();
   }
-  inline void put (HANDLE output_handle, pid_t owner, char x)
+  inline void put (HANDLE output_handle, DWORD owner, char x)
   {
     if (ixput == WPBUF_LEN)
       send (output_handle, owner);
     buf[ixput++] = x;
   }
   inline void empty () { ixput = 0u; }
-  inline void send (HANDLE output_handle, pid_t owner)
+  inline void send (HANDLE output_handle, DWORD owner)
   {
     if (!output_handle)
       {
@@ -405,7 +395,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       }
   };
   termios &ti = ttyp->ti;
-  while (con.owner == myself->pid)
+  while (con.owner == myself->dwProcessId)
     {
       DWORD total_read, n, i;
 
@@ -719,7 +709,7 @@ fhandler_console::set_unit ()
 		unit = device::minor (cs->tty_min_state.ntty);
 	      shared_console_info[unit] = cs;
 	      if (created)
-		con.owner = myself->pid;
+		con.owner = myself->dwProcessId;
 	    }
 	}
     }
@@ -927,10 +917,10 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode =
-    (con.owner == myself->pid) ? tty::restore : tty::cygwin;
+    (con.owner == myself->dwProcessId) ? tty::restore : tty::cygwin;
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
-  set_disable_master_thread (con.owner == myself->pid);
+  set_disable_master_thread (con.owner == myself->dwProcessId);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1043,7 +1033,7 @@ fhandler_console::set_cursor_maybe ()
 /* Workaround for a bug of windows xterm compatible mode. */
 /* The horizontal tab positions are broken after resize. */
 void
-fhandler_console::fix_tab_position (HANDLE h, pid_t owner)
+fhandler_console::fix_tab_position (HANDLE h, DWORD owner)
 {
   /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
      fixes the tab position. */
@@ -1783,13 +1773,8 @@ fhandler_console::open (int flags, mode_t)
   setup_io_mutex ();
   acquire_output_mutex (mutex_timeout);
 
-  do
-    {
-      pinfo p (con.owner);
-      if (!p)
-	con.owner = myself->pid;
-    }
-  while (false);
+  if (!process_alive (con.owner))
+    con.owner = myself->dwProcessId;
 
   /* Open the input handle as handle_ */
   bool err = false;
@@ -1853,7 +1838,7 @@ fhandler_console::open (int flags, mode_t)
 
   set_open_status ();
 
-  if (myself->pid == con.owner && wincap.has_con_24bit_colors ())
+  if (myself->dwProcessId == con.owner && wincap.has_con_24bit_colors ())
     {
       bool is_legacy = false;
       DWORD dwMode;
@@ -1884,7 +1869,7 @@ fhandler_console::open (int flags, mode_t)
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
 
-  if (myself->pid == con.owner)
+  if (myself->dwProcessId == con.owner)
     {
       if (GetModuleHandle ("ConEmuHk64.dll"))
 	hook_conemu_cygwin_connector ();
@@ -1914,8 +1899,7 @@ fhandler_console::setup_pcon_hand_over ()
 	if (!cygwin_shared->tty[i]->pcon_activated)
 	  continue;
 	DWORD owner = cygwin_shared->tty[i]->nat_pipe_owner_pid;
-	if (fhandler_pty_common::get_console_process_id
-					(owner, true, false, false, false))
+	if (get_console_process_id (owner, true, false, false, false))
 	  {
 	    inside_pcon = true;
 	    atexit (fhandler_console::pcon_hand_over_proc);
@@ -2001,7 +1985,7 @@ fhandler_console::close ()
 			      &obi, sizeof obi, NULL);
       if ((NT_SUCCESS (status) && obi.HandleCount == 1
 	   && (dev_t) myself->ctty == get_device ())
-	  || myself->pid == con.owner)
+	  || myself->dwProcessId == con.owner)
 	{
 	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
@@ -2010,7 +1994,7 @@ fhandler_console::close ()
 	}
     }
 
-  if (shared_console_info[unit] && con.owner == myself->pid)
+  if (shared_console_info[unit] && con.owner == myself->dwProcessId)
     {
       if (master_thread_started)
 	{
@@ -2019,7 +2003,7 @@ fhandler_console::close ()
 	  thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
 	  if (thread_sync_event)
 	    {
-	      con.owner = MAX_PID + 1;
+	      con.owner = (DWORD) -1;
 	      WaitForSingleObject (thread_sync_event, INFINITE);
 	      CloseHandle (thread_sync_event);
 	    }
@@ -3508,7 +3492,7 @@ enum_proc (const LOGFONTW *lf, const TEXTMETRICW *tm,
 }
 
 static void
-check_font (HANDLE hdl, pid_t owner)
+check_font (HANDLE hdl, DWORD owner)
 {
   CONSOLE_FONT_INFOEX cfi;
   LOGFONTW lf;
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c40adc289..4f0f71812 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -74,60 +74,6 @@ void release_attach_mutex (void)
   ReleaseMutex (attach_mutex);
 }
 
-inline static bool process_alive (DWORD pid);
-
-/* This functions looks for a process which attached to the same console
-   with current process and is matched to given conditions:
-     match: If true, return given pid if the process pid attaches to the
-	    same console, otherwise, return 0. If false, return pid except
-	    for given pid.
-     cygwin: return only process's pid which has cygwin pid.
-     stub_only: return only stub process's pid of non-cygwin process. */
-DWORD
-fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
-					     bool cygwin, bool stub_only,
-					     bool nat)
-{
-  tmp_pathbuf tp;
-  DWORD *list = (DWORD *) tp.c_get ();
-  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
-
-  DWORD num = GetConsoleProcessList (list, buf_size);
-  if (num == 0 || num > buf_size)
-    return 0;
-
-  DWORD res_pri = 0, res = 0;
-  /* Last one is the oldest. */
-  /* https://github.com/microsoft/terminal/issues/95 */
-  for (int i = (int) num - 1; i >= 0; i--)
-    if ((match && list[i] == pid) || (!match && list[i] != pid))
-      {
-	if (!process_alive (list[i]))
-	  continue;
-	if (!cygwin)
-	  {
-	    res_pri = list[i];
-	    break;
-	  }
-	else
-	  {
-	    pinfo p (cygwin_pid (list[i]));
-	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
-	      continue;
-	    if (!!p && p->exec_dwProcessId)
-	      {
-		res_pri = stub_only ? p->exec_dwProcessId : list[i];
-		break;
-	      }
-	    if (!p && !res && stub_only)
-	      res = list[i];
-	    if (!!p && !res && !stub_only)
-	      res = list[i];
-	  }
-      }
-  return res_pri ?: res;
-}
-
 static bool isHybrid; /* Set true if the active pipe is set to nat pipe
 			 owned by myself even though the current process
 			 is a cygwin process. */
@@ -1114,25 +1060,6 @@ fhandler_pty_slave::set_switch_to_nat_pipe (void)
     }
 }
 
-inline static bool
-process_alive (DWORD pid)
-{
-  /* This function is very similar to _pinfo::alive(), however, this
-     can be used for non-cygwin process which is started from non-cygwin
-     shell. In addition, this checks exit code as well. */
-  if (pid == 0)
-    return false;
-  HANDLE h = OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
-  if (h == NULL)
-    return false;
-  DWORD exit_code;
-  BOOL r = GetExitCodeProcess (h, &exit_code);
-  CloseHandle (h);
-  if (r && exit_code == STILL_ACTIVE)
-    return true;
-  return false;
-}
-
 inline static bool
 nat_pipe_owner_self (DWORD pid)
 {
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 2acb0e01f..585e6ac4a 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -20,6 +20,7 @@ details. */
 #include "cygheap.h"
 #include "child_info.h"
 #include "ntdll.h"
+#include "tls_pbuf.h"
 
 /* Wait time for some treminal mutexes. This is set to 0 when the
    process calls CreateProcess() with DEBUG_PROCESS flag, because
@@ -833,3 +834,74 @@ fhandler_termios::atexit_func ()
 {
   fhandler_console::pcon_hand_over_proc ();
 }
+
+bool
+fhandler_termios::process_alive (DWORD pid)
+{
+  /* This function is very similar to _pinfo::alive(), however, this
+     can be used for non-cygwin process which is started from non-cygwin
+     shell. In addition, this checks exit code as well. */
+  if (pid == 0)
+    return false;
+  HANDLE h = OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
+  if (h == NULL)
+    return false;
+  DWORD exit_code;
+  BOOL r = GetExitCodeProcess (h, &exit_code);
+  CloseHandle (h);
+  if (r && exit_code == STILL_ACTIVE)
+    return true;
+  return false;
+}
+
+/* This functions looks for a process which attached to the same console
+   with current process and is matched to given conditions:
+     match: If true, return given pid if the process pid attaches to the
+	    same console, otherwise, return 0. If false, return pid except
+	    for given pid.
+     cygwin: return only process's pid which has cygwin pid.
+     stub_only: return only stub process's pid of non-cygwin process. */
+DWORD
+fhandler_termios::get_console_process_id (DWORD pid, bool match,
+					     bool cygwin, bool stub_only,
+					     bool nat)
+{
+  tmp_pathbuf tp;
+  DWORD *list = (DWORD *) tp.c_get ();
+  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
+
+  DWORD num = GetConsoleProcessList (list, buf_size);
+  if (num == 0 || num > buf_size)
+    return 0;
+
+  DWORD res_pri = 0, res = 0;
+  /* Last one is the oldest. */
+  /* https://github.com/microsoft/terminal/issues/95 */
+  for (int i = (int) num - 1; i >= 0; i--)
+    if ((match && list[i] == pid) || (!match && list[i] != pid))
+      {
+	if (!process_alive (list[i]))
+	  continue;
+	if (!cygwin)
+	  {
+	    res_pri = list[i];
+	    break;
+	  }
+	else
+	  {
+	    pinfo p (cygwin_pid (list[i]));
+	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
+	      continue;
+	    if (!!p && p->exec_dwProcessId)
+	      {
+		res_pri = stub_only ? p->exec_dwProcessId : list[i];
+		break;
+	      }
+	    if (!p && !res && stub_only)
+	      res = list[i];
+	    if (!!p && !res && !stub_only)
+	      res = list[i];
+	  }
+      }
+  return res_pri ?: res;
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 4e274d854..327b636a7 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1938,6 +1938,11 @@ class fhandler_termios: public fhandler_base
     done_with_debugger /* The key was processed (CTRL_C_EVENT was sent)
 			  for inferior of GDB. */
   };
+  static bool process_alive (DWORD pid);
+  static DWORD get_console_process_id (DWORD pid, bool match,
+				       bool cygwin = false,
+				       bool stub_only = false,
+				       bool nat = false);
 
  public:
   virtual pid_t tc_getpgid () { return 0; };
@@ -2061,7 +2066,7 @@ enum cltype
 
 class dev_console
 {
-  pid_t owner;
+  DWORD owner;
   bool is_legacy;
   bool orig_virtual_terminal_processing_mode;
 
@@ -2211,7 +2216,7 @@ private:
   void set_cursor_maybe ();
   static bool create_invisible_console_workaround (bool force);
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
-  static void fix_tab_position (HANDLE h, pid_t owner);
+  static void fix_tab_position (HANDLE h, DWORD owner);
 
 /* console mode calls */
   const handle_set_t *get_handle_set (void) {return &handle_set;}
@@ -2336,9 +2341,9 @@ private:
   static void set_console_mode_to_native ();
   bool need_console_handler ();
   static void set_disable_master_thread (bool x, fhandler_console *cons = NULL);
-  static DWORD attach_console (pid_t, bool *err = NULL);
-  static void detach_console (DWORD, pid_t);
-  pid_t get_owner ();
+  static DWORD attach_console (DWORD, bool *err = NULL);
+  static void detach_console (DWORD, DWORD);
+  DWORD get_owner ();
   void wpbuf_put (char c);
   void wpbuf_send ();
   int fstat (struct stat *buf);
@@ -2402,10 +2407,6 @@ class fhandler_pty_common: public fhandler_termios
   }
 
   void resize_pseudo_console (struct winsize *);
-  static DWORD get_console_process_id (DWORD pid, bool match,
-				       bool cygwin = false,
-				       bool stub_only = false,
-				       bool nat = false);
   bool to_be_read_from_nat_pipe (void);
   static DWORD attach_console_temporarily (DWORD target_pid);
   static void resume_from_temporarily_attach (DWORD resume_pid);
-- 
2.45.1

