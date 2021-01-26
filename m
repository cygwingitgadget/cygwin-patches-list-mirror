Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 3726E3851C2E
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 03:54:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3726E3851C2E
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 10Q3qTGo020221;
 Tue, 26 Jan 2021 12:54:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 10Q3qTGo020221
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 4/4] Cygwin: pty: Allow multiple apps to enable pseudo
 console simultaneously.
Date: Tue, 26 Jan 2021 12:52:29 +0900
Message-Id: <20210126035229.1666-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126035229.1666-1-takashi.yano@nifty.ne.jp>
References: <20210126035229.1666-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 26 Jan 2021 03:54:30 -0000

- After commit bb428520, there has been the disadvantage:
  7) Pseudo console cannot be activated if it is already activated for
     another process on same pty.
  This patch clears this disadvantage.
---
 winsup/cygwin/fhandler.h      |   7 +-
 winsup/cygwin/fhandler_tty.cc | 346 ++++++++++++++++++++++++++--------
 winsup/cygwin/select.cc       |   4 +-
 winsup/cygwin/spawn.cc        |  40 ++--
 winsup/cygwin/tty.cc          |   2 +-
 winsup/cygwin/tty.h           |   6 +-
 6 files changed, 313 insertions(+), 92 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index dcdf65292..9472cf504 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2273,6 +2273,9 @@ class fhandler_pty_common: public fhandler_termios
   }
 
   void resize_pseudo_console (struct winsize *);
+  static DWORD get_console_process_id (DWORD pid, bool match,
+				       bool cygwin = false,
+				       bool stub_only = false);
 
  protected:
   static BOOL process_opost_output (HANDLE h, const void *ptr, ssize_t& len,
@@ -2352,14 +2355,14 @@ class fhandler_pty_slave: public fhandler_pty_common
   bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
-  bool mask_switch_to_pcon_in (bool mask);
+  bool mask_switch_to_pcon_in (bool mask, bool xfer);
   void setup_locale (void);
   tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
   void create_invisible_console (void);
   static void transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 			      HANDLE input_available_event);
   HANDLE get_input_available_event (void) { return input_available_event; }
-  bool pcon_activated (void) { return get_ttyp ()->h_pseudo_console; }
+  bool pcon_activated (void) { return get_ttyp ()->pcon_activated; }
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 09e5b3e97..c2a39cd41 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -62,8 +62,9 @@ struct pipe_reply {
 
 extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
 
-static DWORD
-get_console_process_id (DWORD pid, bool match)
+DWORD
+fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
+					     bool cygwin, bool stub_only)
 {
   tmp_pathbuf tp;
   DWORD *list = (DWORD *) tp.c_get ();
@@ -73,16 +74,34 @@ get_console_process_id (DWORD pid, bool match)
   if (num == 0 || num > buf_size)
     return 0;
 
-  DWORD res = 0;
+  DWORD res_pri = 0, res = 0;
   /* Last one is the oldest. */
   /* https://github.com/microsoft/terminal/issues/95 */
   for (int i = (int) num - 1; i >= 0; i--)
     if ((match && list[i] == pid) || (!match && list[i] != pid))
       {
-	res = list[i];
-	break;
+	if (!cygwin)
+	  {
+	    res_pri = list[i];
+	    break;
+	  }
+	else
+	  {
+	    pinfo p (cygwin_pid (list[i]));
+	    if (!!p && p->dwProcessId && p->exec_dwProcessId
+		&& p->dwProcessId != p->exec_dwProcessId)
+	      {
+		res_pri = list[i];
+		break;
+	      }
+	    if (!!p && !res)
+	      res = list[i];
+	  }
       }
-  return res;
+  if (stub_only)
+    return res_pri;
+  else
+    return res_pri ?: res;
 }
 
 static bool isHybrid;
@@ -935,7 +954,7 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t)
 void
 fhandler_pty_slave::set_switch_to_pcon (void)
 {
-  if (!get_ttyp ()->switch_to_pcon_in)
+  if (!isHybrid)
     {
       isHybrid = true;
       setup_locale ();
@@ -951,10 +970,6 @@ fhandler_pty_slave::set_switch_to_pcon (void)
 void
 fhandler_pty_slave::reset_switch_to_pcon (void)
 {
-  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
-      && !!pinfo (get_ttyp ()->pcon_pid))
-    /* There is a process which is grabbing pseudo console. */
-    return;
   if (h_gdb_process)
     {
       if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT)
@@ -976,7 +991,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	  HANDLE pty_owner = NULL;
 	  if (p)
 	    pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
-	  if (pty_owner && get_ttyp ()->pcon_pid == myself->pid)
+	  if (pty_owner)
 	    {
 	      close_pseudoconsole (get_ttyp ());
 	      bool fixin, fixout, fixerr;
@@ -997,23 +1012,25 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		SetStdHandle (STD_OUTPUT_HANDLE, get_output_handle ());
 	      if (fixerr)
 		SetStdHandle (STD_ERROR_HANDLE, get_output_handle ());
+	      isHybrid = false;
 	    }
-	  isHybrid = false;
-	  get_ttyp ()->pcon_pid = 0;
-	  get_ttyp ()->switch_to_pcon_in = false;
 	  return;
 	}
     }
+  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
+      && !!pinfo (get_ttyp ()->pcon_pid))
+    /* There is a process which is grabbing pseudo console. */
+    return;
   if (isHybrid)
     return;
-  if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->h_pseudo_console)
+  if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated)
     fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
 					get_handle (),
 					get_ttyp (),
 					input_available_event);
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
-  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->pcon_activated = false;
 }
 
 ssize_t __stdcall
@@ -1053,24 +1070,65 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 }
 
 bool
-fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
+fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
 {
   bool orig = get_ttyp ()->mask_switch_to_pcon_in;
-  if (get_ttyp ()->switch_to_pcon_in
-      && (get_ttyp ()->pcon_pid == myself->pid
-	  || !get_ttyp ()->h_pseudo_console)
-      && get_ttyp ()->mask_switch_to_pcon_in != mask)
-    {
+  if (get_ttyp ()->switch_to_pcon_in && orig != mask && xfer)
+    { /* Transfer input */
+      bool attach_restore = false;
+      DWORD pcon_winpid = 0;
+      if (get_ttyp ()->pcon_pid)
+	{
+	  pinfo p (get_ttyp ()->pcon_pid);
+	  if (p)
+	    pcon_winpid = p->exec_dwProcessId ?: p->dwProcessId;
+	}
       if (mask)
-	fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
-					    get_handle (),
-					    get_ttyp (),
-					    input_available_event);
+	{
+	  HANDLE from = get_handle ();
+	  if (get_ttyp ()->pcon_activated && pcon_winpid
+	      && !get_console_process_id (pcon_winpid, true))
+	    {
+	      HANDLE pcon_owner =
+		OpenProcess (PROCESS_DUP_HANDLE, FALSE, pcon_winpid);
+	      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+			       GetCurrentProcess (), &from,
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      FreeConsole ();
+	      AttachConsole (pcon_winpid);
+	      attach_restore = true;
+	    }
+	  fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+					      from,
+					      get_ttyp (),
+					      input_available_event);
+	}
       else
-	fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
-					    get_handle_cyg (),
-					    get_ttyp (),
-					    input_available_event);
+	{
+	  if (get_ttyp ()->pcon_activated && pcon_winpid
+	      && !get_console_process_id (pcon_winpid, true))
+	    {
+	      FreeConsole ();
+	      AttachConsole (pcon_winpid);
+	      attach_restore = true;
+	    }
+	  fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
+					      get_handle_cyg (),
+					      get_ttyp (),
+					      input_available_event);
+	}
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
     }
   get_ttyp ()->mask_switch_to_pcon_in = mask;
   return orig;
@@ -1093,6 +1151,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
   DWORD bytes_in_pipe;
   char buf[INP_BUFFER_SIZE];
   DWORD time_to_wait;
+  char *ptr0 = (char *) ptr;
 
   bg_check_types bg = bg_check (SIGTTIN);
   if (bg <= bg_eof)
@@ -1108,7 +1167,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
   bool need_reset_mask = false;
   if (ptr) /* Indicating not tcflush(). */
     {
-      need_reset_mask = !mask_switch_to_pcon_in (true);
+      need_reset_mask = !mask_switch_to_pcon_in (true, true);
       reset_switch_to_pcon ();
     }
 
@@ -1223,7 +1282,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	{
 	  ReleaseMutex (input_mutex);
 	  if (need_reset_mask)
-	    mask_switch_to_pcon_in (false);
+	    mask_switch_to_pcon_in (false, false);
 	  len = (size_t) bytes_in_pipe;
 	  return;
 	}
@@ -1329,7 +1388,8 @@ out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
   if (need_reset_mask)
-    mask_switch_to_pcon_in (false);
+    mask_switch_to_pcon_in (false,
+		  totalread > 0 && ptr0[totalread - 1] == '\n');
 }
 
 int
@@ -1370,7 +1430,7 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
       {
 	if (get_ttyp ()->pcon_start)
 	  t->c_lflag &= ~(ICANON | ECHO);
-	if (get_ttyp ()->h_pseudo_console)
+	if (get_ttyp ()->pcon_activated)
 	  t->c_iflag &= ~ICRNL;
 	break;
       }
@@ -1485,7 +1545,7 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
 	{
-	  if (get_ttyp ()->h_pseudo_console && get_ttyp ()->pcon_pid)
+	  if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid)
 	    resize_pseudo_console ((struct winsize *) arg);
 	  get_ttyp ()->arg.winsize = *(struct winsize *) arg;
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
@@ -1900,7 +1960,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* Write terminal input to to_slave pipe instead of output_handle
      if current application is native console application. */
-  if (to_be_read_from_pcon () && get_ttyp ()->h_pseudo_console)
+  if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated)
     {
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
@@ -1995,7 +2055,7 @@ fhandler_pty_master::tcgetattr (struct termios *t)
   /* Workaround for rlwrap v0.40 or later */
   if (get_ttyp ()->pcon_start)
     t->c_lflag &= ~(ICANON | ECHO);
-  if (get_ttyp ()->h_pseudo_console)
+  if (get_ttyp ()->pcon_activated)
     t->c_iflag &= ~ICRNL;
   return 0;
 }
@@ -2044,7 +2104,7 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
 	{
-	  if (get_ttyp ()->h_pseudo_console && get_ttyp ()->pcon_pid)
+	  if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid)
 	    resize_pseudo_console ((struct winsize *) arg);
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
 	  get_ttyp ()->kill_pgrp (SIGWINCH);
@@ -2324,7 +2384,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	}
       ssize_t wlen = rlen;
       char *ptr = outbuf;
-      if (p->ttyp->h_pseudo_console)
+      if (p->ttyp->pcon_activated)
 	{
 	  /* Avoid setting window title to "cygwin-console-helper.exe" */
 	  int state = 0;
@@ -2822,9 +2882,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 
   if (nopcon)
     return false;
-  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
-      && !!pinfo (get_ttyp ()->pcon_pid))
-    return false;
+
   /* If the legacy console mode is enabled, pseudo console seems
      not to work as expected. To determine console mode, registry
      key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
@@ -2838,11 +2896,32 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       return false;
     }
 
+  HANDLE hpConIn, hpConOut;
+  acquire_output_mutex (INFINITE);
+  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
+      && !!pinfo (get_ttyp ()->pcon_pid) && get_ttyp ()->pcon_activated)
+    {
+      /* Attach to the pseudo console which already exits. */
+      pinfo p (get_ttyp ()->pcon_pid);
+      HANDLE pcon_owner =
+	OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->exec_dwProcessId);
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &hpConIn,
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_out,
+		       GetCurrentProcess (), &hpConOut,
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      CloseHandle (pcon_owner);
+      FreeConsole ();
+      AttachConsole (p->dwProcessId);
+      goto skip_create;
+    }
+
   STARTUPINFOEXW si;
   PROCESS_INFORMATION pi;
   HANDLE hello, goodbye;
   HANDLE hr, hw;
-  HANDLE hpConIn, hpConOut;
+  HPCON hpcon;
 
   do
     {
@@ -2851,11 +2930,11 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 	(SHORT) get_ttyp ()->winsize.ws_row
       };
       const DWORD inherit_cursor = 1;
+      hpcon = NULL;
       SetLastError (ERROR_SUCCESS);
       HRESULT res = CreatePseudoConsole (size, get_handle (),
 					 get_output_handle (),
-					 inherit_cursor,
-					 &get_ttyp ()->h_pseudo_console);
+					 inherit_cursor, &hpcon);
       if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
 	{
 	  if (res != S_OK)
@@ -2878,9 +2957,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       if (!UpdateProcThreadAttribute (si.lpAttributeList,
 				      0,
 				      PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
-				      get_ttyp ()->h_pseudo_console,
-				      sizeof (get_ttyp ()->h_pseudo_console),
-				      NULL, NULL))
+				      hpcon, sizeof (hpcon), NULL, NULL))
 
 	goto cleanup_heap;
 
@@ -2909,6 +2986,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       si.StartupInfo.hStdError = NULL;
 
       get_ttyp ()->pcon_start = true;
+      get_ttyp ()->pcon_activated = true;
       if (!CreateProcessW (NULL, cmd, &sec_none, &sec_none,
 			   TRUE, EXTENDED_STARTUPINFO_PRESENT,
 			   NULL, NULL, &si.StartupInfo, &pi))
@@ -2964,7 +3042,12 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       WaitForSingleObject (pi.hProcess, INFINITE);
       CloseHandle (goodbye);
       CloseHandle (pi.hProcess);
+    }
+  while (false);
 
+skip_create:
+  do
+    {
       /* Set handle */
       if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
 	SetStdHandle (STD_INPUT_HANDLE, hpConIn);
@@ -2995,16 +3078,29 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
   if (get_ttyp ()->pcon_pid == 0 || !pinfo (get_ttyp ()->pcon_pid))
     get_ttyp ()->pcon_pid = myself->pid;
 
-  if (get_ttyp ()->h_pseudo_console && get_ttyp ()->pcon_pid == myself->pid)
+  if (hpcon && get_ttyp ()->pcon_pid == myself->pid)
     {
-      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
+      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) hpcon;
       get_ttyp ()->h_pcon_write_pipe = hp->hWritePipe;
+      get_ttyp ()->h_pcon_condrv_reference = hp->hConDrvReference;
+      get_ttyp ()->h_pcon_conhost_process = hp->hConHostProcess;
+      DuplicateHandle (GetCurrentProcess (), hpConIn,
+		       GetCurrentProcess (), &get_ttyp ()->h_pcon_in,
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      DuplicateHandle (GetCurrentProcess (), hpConOut,
+		       GetCurrentProcess (), &get_ttyp ()->h_pcon_out,
+		       0, TRUE, DUPLICATE_SAME_ACCESS);
+      /* Discard the pseudo console handler container here.
+	 Reconstruct it temporary when it is needed. */
+      HeapFree (GetProcessHeap (), 0, hp);
     }
 
   if (get_ttyp ()->previous_code_page)
     SetConsoleCP (get_ttyp ()->previous_code_page);
   if (get_ttyp ()->previous_output_code_page)
     SetConsoleOutputCP (get_ttyp ()->previous_output_code_page);
+
+  release_output_mutex ();
   return true;
 
 cleanup_pcon_in:
@@ -3016,6 +3112,8 @@ cleanup_helper_process:
   goto skip_close_hello;
 cleanup_event_and_pipes:
   CloseHandle (hello);
+  get_ttyp ()->pcon_start = false;
+  get_ttyp ()->pcon_activated = false;
 skip_close_hello:
   CloseHandle (goodbye);
   CloseHandle (hr);
@@ -3023,16 +3121,15 @@ skip_close_hello:
 cleanup_heap:
   HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
 cleanup_pseudo_console:
-  if (get_ttyp ()->h_pseudo_console)
+  if (hpcon)
     {
-      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
+      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) hpcon;
       HANDLE tmp = hp->hConHostProcess;
-      ClosePseudoConsole (get_ttyp ()->h_pseudo_console);
+      ClosePseudoConsole (hpcon);
       CloseHandle (tmp);
     }
 fallback:
-  get_ttyp ()->pcon_start = false;
-  get_ttyp ()->h_pseudo_console = NULL;
+  release_output_mutex ();
   return false;
 }
 
@@ -3041,20 +3138,121 @@ fallback:
 void
 fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
 {
-  if (ttyp->h_pseudo_console)
+  DWORD switch_to_stub = 0, switch_to = 0;
+  DWORD new_pcon_pid = 0;
+  if (ttyp->pcon_pid == myself->pid)
+    {
+      /* Search another process which attaches to the pseudo console */
+      DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
+      switch_to =
+	get_console_process_id (current_pid, false, true);
+      if (switch_to)
+	{
+	  pinfo p (cygwin_pid (switch_to));
+	  if (p)
+	    {
+	      if (p->exec_dwProcessId)
+		switch_to_stub = p->exec_dwProcessId;
+	      new_pcon_pid = p->pid;
+	    }
+	}
+    }
+  if (ttyp->pcon_activated)
     {
       ttyp->previous_code_page = GetConsoleCP ();
       ttyp->previous_output_code_page = GetConsoleOutputCP ();
-      FreeConsole ();
-      AttachConsole (ATTACH_PARENT_PROCESS);
-      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) ttyp->h_pseudo_console;
-      HANDLE tmp = hp->hConHostProcess;
-      ClosePseudoConsole (ttyp->h_pseudo_console);
-      CloseHandle (tmp);
-      ttyp->h_pseudo_console = NULL;
-      ttyp->switch_to_pcon_in = false;
-      ttyp->pcon_pid = 0;
-      ttyp->pcon_start = false;
+      if (ttyp->pcon_pid == myself->pid)
+	{
+	  switch_to = switch_to_stub ?: switch_to;
+	  if (switch_to)
+	    {
+	      /* Change pseudo console owner to another process */
+	      HANDLE new_owner =
+		OpenProcess (PROCESS_DUP_HANDLE, FALSE, switch_to);
+	      HANDLE new_write_pipe = NULL;
+	      HANDLE new_condrv_reference = NULL;
+	      HANDLE new_conhost_process = NULL;
+	      HANDLE new_pcon_in = NULL, new_pcon_out = NULL;
+	      DuplicateHandle (GetCurrentProcess (),
+			       ttyp->h_pcon_write_pipe,
+			       new_owner, &new_write_pipe,
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      DuplicateHandle (GetCurrentProcess (),
+			       ttyp->h_pcon_condrv_reference,
+			       new_owner, &new_condrv_reference,
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      DuplicateHandle (GetCurrentProcess (),
+			       ttyp->h_pcon_conhost_process,
+			       new_owner, &new_conhost_process,
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_in,
+			       new_owner, &new_pcon_in,
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      DuplicateHandle (GetCurrentProcess (), ttyp->h_pcon_out,
+			       new_owner, &new_pcon_out,
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      CloseHandle (new_owner);
+	      CloseHandle (ttyp->h_pcon_write_pipe);
+	      CloseHandle (ttyp->h_pcon_condrv_reference);
+	      CloseHandle (ttyp->h_pcon_conhost_process);
+	      CloseHandle (ttyp->h_pcon_in);
+	      CloseHandle (ttyp->h_pcon_out);
+	      ttyp->pcon_pid = new_pcon_pid;
+	      ttyp->h_pcon_write_pipe = new_write_pipe;
+	      ttyp->h_pcon_condrv_reference = new_condrv_reference;
+	      ttyp->h_pcon_conhost_process = new_conhost_process;
+	      ttyp->h_pcon_in = new_pcon_in;
+	      ttyp->h_pcon_out = new_pcon_out;
+	    }
+	  else
+	    { /* Close pseudo console */
+	      FreeConsole ();
+	      pinfo p (myself->ppid);
+	      if (p)
+		{
+		  if (!AttachConsole (p->dwProcessId))
+		    AttachConsole (ATTACH_PARENT_PROCESS);
+		}
+	      else
+		AttachConsole (ATTACH_PARENT_PROCESS);
+	      /* Reconstruct pseudo console handler container here for close */
+	      HPCON_INTERNAL *hp =
+		(HPCON_INTERNAL *) HeapAlloc (GetProcessHeap (), 0,
+					      sizeof (*hp));
+	      hp->hWritePipe = ttyp->h_pcon_write_pipe;
+	      hp->hConDrvReference = ttyp->h_pcon_condrv_reference;
+	      hp->hConHostProcess = ttyp->h_pcon_conhost_process;
+	      /* HeapFree() will be called in ClosePseudoConsole() */
+	      ClosePseudoConsole ((HPCON) hp);
+	      CloseHandle (ttyp->h_pcon_conhost_process);
+	      ttyp->pcon_activated = false;
+	      ttyp->switch_to_pcon_in = false;
+	      ttyp->pcon_pid = 0;
+	      ttyp->pcon_start = false;
+	    }
+	}
+      else
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
+  else if (ttyp->pcon_pid == myself->pid)
+    {
+      if (switch_to_stub)
+	ttyp->pcon_pid = new_pcon_pid;
+      else
+	{
+	  ttyp->pcon_pid = 0;
+	  ttyp->switch_to_pcon_in = false;
+	}
     }
 }
 
@@ -3145,9 +3343,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 
   /* Check if terminal has CSI6n */
   WaitForSingleObject (input_mutex, INFINITE);
-  /* Set h_pseudo_console and pcon_start so that the response
+  /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle rather than io_handle_cyg. */
-  get_ttyp ()->h_pseudo_console = (HPCON *) -1; /* dummy */
+  get_ttyp ()->pcon_activated = true;
   get_ttyp ()->pcon_pid = myself->pid;
   /* pcon_start will be cleared in master write() when CSI6n is responded. */
   get_ttyp ()->pcon_start = true;
@@ -3178,7 +3376,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 	Sleep (1);
     }
   while (len);
-  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->pcon_activated = false;
   get_ttyp ()->pcon_pid = 0;
   if (len == 0)
     goto not_has_csi6n;
@@ -3193,7 +3391,7 @@ not_has_csi6n:
   /* If CSI6n is not responded, pcon_start is not cleared
      in master write(). Therefore, clear it here manually. */
   get_ttyp ()->pcon_start = false;
-  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
@@ -3262,7 +3460,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
   if (dir == to_nat)
     {
       cp_from = ttyp->term_code_page;
-      if (ttyp->h_pseudo_console)
+      if (ttyp->pcon_activated)
 	cp_to = CP_UTF8;
       else
 	cp_to = GetConsoleCP ();
@@ -3278,7 +3476,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 
   bool transfered = false;
 
-  if (dir == to_cyg && ttyp->h_pseudo_console)
+  if (dir == to_cyg && ttyp->pcon_activated)
     { /* from handle is console handle */
       INPUT_RECORD r[INREC_SIZE];
       DWORD n;
@@ -3362,7 +3560,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 	  DWORD n = MIN (bytes_in_pipe, NT_MAX_PATH);
 	  ReadFile (from, buf, n, &n, NULL);
 	  char *ptr = buf;
-	  if (dir == to_nat && ttyp->h_pseudo_console)
+	  if (dir == to_nat && ttyp->pcon_activated)
 	    {
 	      char *p = buf;
 	      while ((p = (char *) memchr (p, '\n', n - (p - buf))))
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 7b3ec45ff..c9821b318 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1389,7 +1389,7 @@ pty_slave_startup (select_record *me, select_stuff *stuff)
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
   select_ptys_info *pi = stuff->device_specific_ptys;
   if (me->read_selected)
-    pi->need_reset_mask = !ptys->mask_switch_to_pcon_in (true);
+    pi->need_reset_mask = !ptys->mask_switch_to_pcon_in (true, true);
   if (pi->start)
     me->h = *((select_pipe_info *) stuff->device_specific_ptys)->thread;
   else
@@ -1414,7 +1414,7 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
   if (!pi)
     return;
   if (me->read_selected && pi->need_reset_mask)
-      ptys->mask_switch_to_pcon_in (false);
+      ptys->mask_switch_to_pcon_in (false, false);
   if (pi->thread)
     {
       pi->stop_thread = true;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 7984ffbc5..5fb4587d8 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -656,6 +656,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       bool enable_pcon = false;
       HANDLE ptys_from_master = NULL;
       HANDLE ptys_input_available_event = NULL;
+      HANDLE ptys_output_mutex = NULL;
       tty *ptys_ttyp = NULL;
       if (!iscygwin () && ptys_primary && is_console_app (runpath))
 	{
@@ -674,6 +675,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  DuplicateHandle (GetCurrentProcess (), ptys_input_available_event,
 			   GetCurrentProcess (), &ptys_input_available_event,
 			   0, 0, DUPLICATE_SAME_ACCESS);
+	  DuplicateHandle (GetCurrentProcess (), ptys_primary->output_mutex,
+			   GetCurrentProcess (), &ptys_output_mutex,
+			   0, 0, DUPLICATE_SAME_ACCESS);
 	  if (!enable_pcon)
 	    fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
 						ptys_primary->get_handle_cyg (),
@@ -963,15 +967,21 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (ptys_ttyp)
 	    {
 	      ptys_ttyp->wait_pcon_fwd ();
-	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
-						  ptys_from_master, ptys_ttyp,
-						  ptys_input_available_event);
+	      /* Do not transfer input if another process using pseudo
+		 console exists. */
+	      WaitForSingleObject (ptys_output_mutex, INFINITE);
+	      if (!fhandler_pty_common::get_console_process_id
+			      (myself->exec_dwProcessId, false, true, true))
+		fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+						    ptys_from_master, ptys_ttyp,
+						    ptys_input_available_event);
 	      CloseHandle (ptys_from_master);
 	      CloseHandle (ptys_input_available_event);
+	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
+	      ReleaseMutex (ptys_output_mutex);
+	      CloseHandle (ptys_output_mutex);
 	    }
-	  if (enable_pcon)
-	    fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
-	  else if (cons_native)
+	  if (cons_native)
 	    {
 	      fhandler_console::request_xterm_mode_output (true,
 							   &cons_handle_set);
@@ -989,15 +999,21 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (ptys_ttyp)
 	    {
 	      ptys_ttyp->wait_pcon_fwd ();
-	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
-						  ptys_from_master, ptys_ttyp,
-						  ptys_input_available_event);
+	      /* Do not transfer input if another process using pseudo
+		 console exists. */
+	      WaitForSingleObject (ptys_output_mutex, INFINITE);
+	      if (!fhandler_pty_common::get_console_process_id
+			      (myself->exec_dwProcessId, false, true, true))
+		fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+						    ptys_from_master, ptys_ttyp,
+						    ptys_input_available_event);
 	      CloseHandle (ptys_from_master);
 	      CloseHandle (ptys_input_available_event);
+	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
+	      ReleaseMutex (ptys_output_mutex);
+	      CloseHandle (ptys_output_mutex);
 	    }
-	  if (enable_pcon)
-	    fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
-	  else if (cons_native)
+	  if (cons_native)
 	    {
 	      fhandler_console::request_xterm_mode_output (true,
 							   &cons_handle_set);
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 432113275..f495fa1b5 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -235,7 +235,7 @@ tty::init ()
   master_pid = 0;
   is_console = false;
   column = 0;
-  h_pseudo_console = NULL;
+  pcon_activated = false;
   switch_to_pcon_in = false;
   mask_switch_to_pcon_in = false;
   pcon_pid = 0;
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 47ccad670..90ebd98f0 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -95,7 +95,7 @@ private:
   HANDLE _to_master_cyg;
   HANDLE _to_slave;
   HANDLE _to_slave_cyg;
-  HPCON h_pseudo_console;
+  bool pcon_activated;
   bool pcon_start;
   bool switch_to_pcon_in;
   bool mask_switch_to_pcon_in;
@@ -103,6 +103,10 @@ private:
   UINT term_code_page;
   DWORD pcon_last_time;
   HANDLE h_pcon_write_pipe;
+  HANDLE h_pcon_condrv_reference;
+  HANDLE h_pcon_conhost_process;
+  HANDLE h_pcon_in;
+  HANDLE h_pcon_out;
   bool pcon_cap_checked;
   bool has_csi6n;
   bool need_invisible_console;
-- 
2.30.0

