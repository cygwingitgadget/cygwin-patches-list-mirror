Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 042443887024
 for <cygwin-patches@cygwin.com>; Thu, 21 Jan 2021 13:11:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 042443887024
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10LD9eEd019369;
 Thu, 21 Jan 2021 22:10:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10LD9eEd019369
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/4] Cygwin: pty: Allow multiple apps to enable pseudo console
 simultaneously.
Date: Thu, 21 Jan 2021 22:09:11 +0900
Message-Id: <20210121130911.855-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121130911.855-1-takashi.yano@nifty.ne.jp>
References: <20210121130911.855-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 21 Jan 2021 13:11:23 -0000

- After commit bb428520, there has been the disadvantage:
  7) Pseudo console cannot be activated if it is already activated for
     another process on same pty.
  This patch clears this disadvantage.
---
 winsup/cygwin/fhandler.h      |   3 +
 winsup/cygwin/fhandler_tty.cc | 239 ++++++++++++++++++++++++++--------
 winsup/cygwin/spawn.cc        |  40 ++++--
 winsup/cygwin/tty.cc          |   2 +-
 winsup/cygwin/tty.h           |   6 +-
 5 files changed, 225 insertions(+), 65 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 10c5973dd..698de051d 100644
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
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8ac620acf..282a3b914 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -61,8 +61,9 @@ struct pipe_reply {
 
 extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
 
-static DWORD
-get_console_process_id (DWORD pid, bool match)
+DWORD
+fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
+					     bool cygwin, bool stub_only)
 {
   tmp_pathbuf tp;
   DWORD *list = (DWORD *) tp.c_get ();
@@ -72,16 +73,34 @@ get_console_process_id (DWORD pid, bool match)
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
@@ -871,7 +890,7 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t)
 void
 fhandler_pty_slave::set_switch_to_pcon (void)
 {
-  if (!get_ttyp ()->switch_to_pcon_in)
+  if (!isHybrid)
     {
       isHybrid = true;
       setup_locale ();
@@ -883,10 +902,6 @@ fhandler_pty_slave::set_switch_to_pcon (void)
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
@@ -897,6 +912,10 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	  h_gdb_process = NULL;
 	}
     }
+  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
+      && !!pinfo (get_ttyp ()->pcon_pid))
+    /* There is a process which is grabbing pseudo console. */
+    return;
   if (isHybrid)
     return;
   get_ttyp ()->pcon_pid = 0;
@@ -1236,7 +1255,7 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
       {
 	if (get_ttyp ()->pcon_start)
 	  t->c_lflag &= ~(ICANON | ECHO);
-	if (get_ttyp ()->h_pseudo_console)
+	if (get_ttyp ()->pcon_activated)
 	  t->c_iflag &= ~ICRNL;
 	break;
       }
@@ -1351,7 +1370,7 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
 	{
-	  if (get_ttyp ()->h_pseudo_console && get_ttyp ()->pcon_pid)
+	  if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid)
 	    resize_pseudo_console ((struct winsize *) arg);
 	  get_ttyp ()->arg.winsize = *(struct winsize *) arg;
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
@@ -1766,7 +1785,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* Write terminal input to to_slave pipe instead of output_handle
      if current application is native console application. */
-  if (to_be_read_from_pcon () && get_ttyp ()->h_pseudo_console)
+  if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated)
     {
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
@@ -1861,7 +1880,7 @@ fhandler_pty_master::tcgetattr (struct termios *t)
   /* Workaround for rlwrap v0.40 or later */
   if (get_ttyp ()->pcon_start)
     t->c_lflag &= ~(ICANON | ECHO);
-  if (get_ttyp ()->h_pseudo_console)
+  if (get_ttyp ()->pcon_activated)
     t->c_iflag &= ~ICRNL;
   return 0;
 }
@@ -1910,7 +1929,7 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
 	{
-	  if (get_ttyp ()->h_pseudo_console && get_ttyp ()->pcon_pid)
+	  if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid)
 	    resize_pseudo_console ((struct winsize *) arg);
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
 	  get_ttyp ()->kill_pgrp (SIGWINCH);
@@ -2190,7 +2209,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	}
       ssize_t wlen = rlen;
       char *ptr = outbuf;
-      if (p->ttyp->h_pseudo_console)
+      if (p->ttyp->pcon_activated)
 	{
 	  /* Avoid setting window title to "cygwin-console-helper.exe" */
 	  int state = 0;
@@ -2688,9 +2707,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 
   if (nopcon)
     return false;
-  if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
-      && !!pinfo (get_ttyp ()->pcon_pid))
-    return false;
+
   /* If the legacy console mode is enabled, pseudo console seems
      not to work as expected. To determine console mode, registry
      key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
@@ -2704,11 +2721,32 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
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
@@ -2720,8 +2758,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       SetLastError (ERROR_SUCCESS);
       HRESULT res = CreatePseudoConsole (size, get_handle (),
 					 get_output_handle (),
-					 inherit_cursor,
-					 &get_ttyp ()->h_pseudo_console);
+					 inherit_cursor, &hpcon);
       if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
 	{
 	  if (res != S_OK)
@@ -2744,9 +2781,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       if (!UpdateProcThreadAttribute (si.lpAttributeList,
 				      0,
 				      PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
-				      get_ttyp ()->h_pseudo_console,
-				      sizeof (get_ttyp ()->h_pseudo_console),
-				      NULL, NULL))
+				      hpcon, sizeof (hpcon), NULL, NULL))
 
 	goto cleanup_heap;
 
@@ -2775,6 +2810,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       si.StartupInfo.hStdError = NULL;
 
       get_ttyp ()->pcon_start = true;
+      get_ttyp ()->pcon_activated = true;
       if (!CreateProcessW (NULL, cmd, &sec_none, &sec_none,
 			   TRUE, EXTENDED_STARTUPINFO_PRESENT,
 			   NULL, NULL, &si.StartupInfo, &pi))
@@ -2830,7 +2866,12 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
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
@@ -2857,16 +2898,29 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
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
+      /* Discard the pseudo console handler container here. */
+      /* Reconstruct it temporary when it is needed. */
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
@@ -2878,6 +2932,8 @@ cleanup_helper_process:
   goto skip_close_hello;
 cleanup_event_and_pipes:
   CloseHandle (hello);
+  get_ttyp ()->pcon_start = false;
+  get_ttyp ()->pcon_activated = false;
 skip_close_hello:
   CloseHandle (goodbye);
   CloseHandle (hr);
@@ -2885,16 +2941,15 @@ skip_close_hello:
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
 
@@ -2903,20 +2958,102 @@ fallback:
 void
 fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
 {
-  if (ttyp->h_pseudo_console)
+  DWORD switch_to_stub = 0, switch_to = 0;
+  DWORD new_pcon_pid = 0;
+  if (ttyp->pcon_pid == myself->pid)
+    {
+      /* Search another process which attaches to the pseudo console */
+      switch_to =
+	get_console_process_id (myself->exec_dwProcessId, false, true);
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
+	    {
+	      /* Close pseudo console */
+	      FreeConsole ();
+	      AttachConsole (ATTACH_PARENT_PROCESS);
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
+    }
+  else
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
 
@@ -3007,9 +3144,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 
   /* Check if terminal has CSI6n */
   WaitForSingleObject (input_mutex, INFINITE);
-  /* Set h_pseudo_console and pcon_start so that the response
+  /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle rather than io_handle_cyg. */
-  get_ttyp ()->h_pseudo_console = (HPCON *) -1; /* dummy */
+  get_ttyp ()->pcon_activated = true;
   /* pcon_start will be cleared in master write() when CSI6n is responded. */
   get_ttyp ()->pcon_start = true;
   WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
@@ -3039,7 +3176,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 	Sleep (1);
     }
   while (len);
-  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->pcon_activated = false;
   if (len == 0)
     goto not_has_csi6n;
 
@@ -3053,7 +3190,7 @@ not_has_csi6n:
   /* If CSI6n is not responded, pcon_start is not cleared
      in master write(). Therefore, clear it here manually. */
   get_ttyp ()->pcon_start = false;
-  get_ttyp ()->h_pseudo_console = NULL;
+  get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
@@ -3122,7 +3259,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
   if (dir == to_nat)
     {
       cp_from = ttyp->term_code_page;
-      if (ttyp->h_pseudo_console)
+      if (ttyp->pcon_activated)
 	cp_to = CP_UTF8;
       else
 	cp_to = GetConsoleCP ();
@@ -3138,7 +3275,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 
   bool transfered = false;
 
-  if (dir == to_cyg && ttyp->h_pseudo_console)
+  if (dir == to_cyg && ttyp->pcon_activated)
     { /* from handle is console handle */
       INPUT_RECORD r[INREC_SIZE];
       DWORD n;
@@ -3210,7 +3347,7 @@ fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 	  DWORD n;
 	  ReadFile (from, buf, NT_MAX_PATH, &n, NULL);
 	  char *ptr = buf;
-	  if (dir == to_nat && ttyp->h_pseudo_console)
+	  if (dir == to_nat && ttyp->pcon_activated)
 	    {
 	      char *p = buf;
 	      while ((p = (char *) memchr (p, '\n', n - (p - buf))))
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

