Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 471A9383E806
 for <cygwin-patches@cygwin.com>; Thu, 21 Jan 2021 20:59:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 471A9383E806
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 10LKx0aH005280;
 Fri, 22 Jan 2021 05:59:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 10LKx0aH005280
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/4] Cygwin: pty: Inherit typeahead data between two input
 pipes.
Date: Fri, 22 Jan 2021 05:58:49 +0900
Message-Id: <20210121205852.536-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
References: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 21 Jan 2021 20:59:38 -0000

- PTY has a problem that the key input, which is typed during windows
  native app is running, disappears when it returns to shell. This is
  beacuse pty has two input pipes, one is for cygwin apps and the other
  one is for native windows apps. The key input during windows native
  program is running is sent to the second input pipe while cygwin
  shell reads input from the first input pipe. This issue had been
  fixed once by commit 29431fcb, however, the new implementation of
  pseudo console support by commit bb428520 could not inherit this
  feature. This patch realize transfering input data between these
  two pipes bidirectionally by utilizing cygwin-console-helper process.
  The helper process is launched prior to starting the non-cygwin app,
  however, exits immediately unlike previous implementation.
---
 winsup/cygwin/fhandler.h      |  12 +-
 winsup/cygwin/fhandler_tty.cc | 468 ++++++++++++++++++++++++++--------
 winsup/cygwin/spawn.cc        |  78 +++---
 winsup/cygwin/tty.cc          |   2 -
 winsup/cygwin/tty.h           |   8 +-
 5 files changed, 422 insertions(+), 146 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index af1ef3a45..10c5973dd 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2291,6 +2291,13 @@ class fhandler_pty_slave: public fhandler_pty_common
   void fch_close_handles ();
 
  public:
+  /* Transfer direction for transfer_input() */
+  enum xfer_dir
+  {
+    to_nat,
+    to_cyg
+  };
+
   /* Constructor */
   fhandler_pty_slave (int);
 
@@ -2340,7 +2347,7 @@ class fhandler_pty_slave: public fhandler_pty_common
     copyto (fh);
     return fh;
   }
-  bool setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon);
+  bool setup_pseudoconsole (bool nopcon);
   static void close_pseudoconsole (tty *ttyp);
   bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
@@ -2349,6 +2356,9 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setup_locale (void);
   tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
   void create_invisible_console (void);
+  static void transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
+			      HANDLE input_available_event);
+  HANDLE get_input_available_event (void) { return input_available_event; }
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7f0752614..75ab500b1 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1591,7 +1591,7 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
   size.X = ws->ws_col;
   size.Y = ws->ws_row;
   pinfo p (get_ttyp ()->pcon_pid);
-  if (p && !get_ttyp ()->do_not_resize_pcon)
+  if (p)
     {
       HPCON_INTERNAL hpcon_local;
       HANDLE pcon_owner =
@@ -1763,6 +1763,17 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      get_ttyp ()->pcon_start = false;
 	    }
 	  ReleaseMutex (input_mutex);
+	  if (get_ttyp ()->switch_to_pcon_in)
+	    {
+	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
+						  from_master_cyg,
+						  get_ttyp (),
+						  input_available_event);
+	      /* This accept_input() call is needed in order to transfer input
+		 which is not accepted yet to non-cygwin pipe. */
+	      if (get_readahead_valid ())
+		accept_input ();
+	    }
 	  return len;
 	}
 
@@ -2130,22 +2141,44 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
       char *ptr = outbuf;
       if (p->ttyp->h_pseudo_console)
 	{
-	  if (!p->ttyp->has_set_title)
-	    {
-	      /* Remove Set title sequence */
-	      char *p0, *p1;
-	      p0 = outbuf;
-	      while ((p0 = (char *) memmem (p0, rlen, "\033]0;", 4))
-		     && (p1 = (char *) memchr (p0, '\007', rlen-(p0-outbuf))))
-		{
-		  memmove (p0, p1 + 1, rlen - (p1 + 1 - outbuf));
-		  rlen -= p1 + 1 - p0;
-		  wlen = rlen;
-		}
-	    }
-	  /* Remove CSI > Pm m */
+	  /* Avoid setting window title to "cygwin-console-helper.exe" */
 	  int state = 0;
 	  int start_at = 0;
+	  for (DWORD i=0; i<rlen; i++)
+	    if (outbuf[i] == '\033')
+	      {
+		start_at = i;
+		state = 1;
+		continue;
+	      }
+	    else if ((state == 1 && outbuf[i] == ']') ||
+		     (state == 2 && outbuf[i] == '0') ||
+		     (state == 3 && outbuf[i] == ';'))
+	      {
+		state ++;
+		continue;
+	      }
+	    else if (state == 4 && outbuf[i] == '\a')
+	      {
+		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
+		if (memmem (&outbuf[start_at], i + 1 - start_at,
+			    helper_str, strlen (helper_str)))
+		  {
+		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		    rlen = wlen = start_at + rlen - i - 1;
+		  }
+		state = 0;
+		continue;
+	      }
+	    else if (outbuf[i] == '\a')
+	      {
+		state = 0;
+		continue;
+	      }
+
+	  /* Remove CSI > Pm m */
+	  state = 0;
+	  start_at = 0;
 	  for (DWORD i = 0; i < rlen; i++)
 	    if (outbuf[i] == '\033')
 	      {
@@ -2419,6 +2452,8 @@ fhandler_pty_master::setup ()
   t.set_from_master_cyg (from_master_cyg);
   t.set_to_master (to_master);
   t.set_to_master_cyg (to_master_cyg);
+  t.set_to_slave (to_slave);
+  t.set_to_slave_cyg (get_output_handle ());
   t.winsize.ws_col = 80;
   t.winsize.ws_row = 25;
   t.master_pid = myself->pid;
@@ -2579,10 +2614,15 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
   return res;
 }
 
+  /* Pseudo console supprot is realized using a tricky technic.
+     PTY need the pseudo console handles, however, they cannot
+     be retrieved by normal procedure. Therefore, run a helper
+     process in a pseudo console and get them from the helper.
+     Slave process will attach to the pseudo console in the
+     helper process using AttachConsole(). */
 bool
-fhandler_pty_slave::setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon)
+fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 {
-
   /* Setting switch_to_pcon_in is necessary even if
      pseudo console will not be activated. */
   fhandler_base *fh = ::cygheap->fdtab[0];
@@ -2613,60 +2653,151 @@ fhandler_pty_slave::setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon)
       return false;
     }
 
-  COORD size = {
-    (SHORT) get_ttyp ()->winsize.ws_col,
-    (SHORT) get_ttyp ()->winsize.ws_row
-  };
-  const DWORD inherit_cursor = 1;
-  SetLastError (ERROR_SUCCESS);
-  HRESULT res = CreatePseudoConsole (size, get_handle (), get_output_handle (),
-				     inherit_cursor,
-				     &get_ttyp ()->h_pseudo_console);
-  if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
-    {
-      if (res != S_OK)
-	system_printf ("CreatePseudoConsole() failed. %08x %08x\n",
-		       GetLastError (), res);
-      goto fallback;
-    }
-
-  SIZE_T bytesRequired;
-  InitializeProcThreadAttributeList (NULL, 1, 0, &bytesRequired);
-  ZeroMemory (si, sizeof (*si));
-  si->StartupInfo.cb = sizeof (STARTUPINFOEXW);
-  si->lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
-    HeapAlloc (GetProcessHeap (), 0, bytesRequired);
-  if (si->lpAttributeList == NULL)
-    goto cleanup_pseudo_console;
-  if (!InitializeProcThreadAttributeList (si->lpAttributeList,
-					  1, 0, &bytesRequired))
-    goto cleanup_heap;
-  if (!UpdateProcThreadAttribute (si->lpAttributeList,
-				  0,
-				  PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
-				  get_ttyp ()->h_pseudo_console,
-				  sizeof (get_ttyp ()->h_pseudo_console),
-				  NULL, NULL))
-    goto cleanup_heap;
-  si->StartupInfo.dwFlags = STARTF_USESTDHANDLES;
-  si->StartupInfo.hStdInput = NULL;
-  si->StartupInfo.hStdOutput = NULL;
-  si->StartupInfo.hStdError = NULL;
+  STARTUPINFOEXW si;
+  PROCESS_INFORMATION pi;
+  HANDLE hello, goodbye;
+  HANDLE hr, hw;
+  HANDLE hpConIn, hpConOut;
 
-  {
-    fhandler_base *fh0 = ::cygheap->fdtab[0];
-    if (fh0 && fh0->get_device () != get_device ())
-      si->StartupInfo.hStdInput = fh0->get_handle ();
-    fhandler_base *fh1 = ::cygheap->fdtab[1];
-    if (fh1 && fh1->get_device () != get_device ())
-      {
-	get_ttyp ()->do_not_resize_pcon = true;
-	si->StartupInfo.hStdOutput = fh1->get_output_handle ();
-      }
-    fhandler_base *fh2 = ::cygheap->fdtab[2];
-    if (fh2 && fh2->get_device () != get_device ())
-      si->StartupInfo.hStdError = fh2->get_output_handle ();
-  }
+  do
+    {
+      COORD size = {
+	(SHORT) get_ttyp ()->winsize.ws_col,
+	(SHORT) get_ttyp ()->winsize.ws_row
+      };
+      const DWORD inherit_cursor = 1;
+      SetLastError (ERROR_SUCCESS);
+      HRESULT res = CreatePseudoConsole (size, get_handle (),
+					 get_output_handle (),
+					 inherit_cursor,
+					 &get_ttyp ()->h_pseudo_console);
+      if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
+	{
+	  if (res != S_OK)
+	    system_printf ("CreatePseudoConsole() failed. %08x %08x\n",
+			   GetLastError (), res);
+	  goto fallback;
+	}
+
+      SIZE_T bytesRequired;
+      InitializeProcThreadAttributeList (NULL, 2, 0, &bytesRequired);
+      ZeroMemory (&si, sizeof (si));
+      si.StartupInfo.cb = sizeof (STARTUPINFOEXW);
+      si.lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
+	HeapAlloc (GetProcessHeap (), 0, bytesRequired);
+      if (si.lpAttributeList == NULL)
+	goto cleanup_pseudo_console;
+      if (!InitializeProcThreadAttributeList (si.lpAttributeList,
+					      2, 0, &bytesRequired))
+	goto cleanup_heap;
+      if (!UpdateProcThreadAttribute (si.lpAttributeList,
+				      0,
+				      PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
+				      get_ttyp ()->h_pseudo_console,
+				      sizeof (get_ttyp ()->h_pseudo_console),
+				      NULL, NULL))
+
+	goto cleanup_heap;
+
+      hello = CreateEvent (&sec_none, true, false, NULL);
+      goodbye = CreateEvent (&sec_none, true, false, NULL);
+      CreatePipe (&hr, &hw, &sec_none, 0);
+
+      HANDLE handles_to_inherit[] = {hello, goodbye, hw};
+      if (!UpdateProcThreadAttribute (si.lpAttributeList,
+				      0,
+				      PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+				      handles_to_inherit,
+				      sizeof (handles_to_inherit),
+				      NULL, NULL))
+	goto cleanup_event_and_pipes;
+
+      /* Execute helper process */
+      WCHAR cmd[MAX_PATH];
+      path_conv helper ("/bin/cygwin-console-helper.exe");
+      size_t len = helper.get_wide_win32_path_len ();
+      helper.get_wide_win32_path (cmd);
+      __small_swprintf (cmd + len, L" %p %p %p", hello, goodbye, hw);
+      si.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
+      si.StartupInfo.hStdInput = NULL;
+      si.StartupInfo.hStdOutput = NULL;
+      si.StartupInfo.hStdError = NULL;
+
+      get_ttyp ()->pcon_start = true;
+      if (!CreateProcessW (NULL, cmd, &sec_none, &sec_none,
+			   TRUE, EXTENDED_STARTUPINFO_PRESENT,
+			   NULL, NULL, &si.StartupInfo, &pi))
+	goto cleanup_event_and_pipes;
+
+      for (;;)
+	{
+	  DWORD wait_result = WaitForSingleObject (hello, 500);
+	  if (wait_result == WAIT_OBJECT_0)
+	    break;
+	  if (wait_result != WAIT_TIMEOUT)
+	    goto cleanup_helper_process;
+	  DWORD exit_code;
+	  if (!GetExitCodeProcess (pi.hProcess, &exit_code))
+	    goto cleanup_helper_process;
+	  if (exit_code == STILL_ACTIVE)
+	    continue;
+	  if (exit_code != 0 ||
+	      WaitForSingleObject (hello, 500) != WAIT_OBJECT_0)
+	    goto cleanup_helper_process;
+	  break;
+	}
+      CloseHandle (hello);
+      CloseHandle (pi.hThread);
+
+      /* Duplicate pseudo console handles */
+      DWORD rlen;
+      char buf[64];
+      if (!ReadFile (hr, buf, sizeof (buf), &rlen, NULL))
+	goto cleanup_helper_process;
+      buf[rlen] = '\0';
+      sscanf (buf, "StdHandles=%p,%p", &hpConIn, &hpConOut);
+      if (!DuplicateHandle (pi.hProcess, hpConIn,
+			    GetCurrentProcess (), &hpConIn, 0,
+			    TRUE, DUPLICATE_SAME_ACCESS))
+	goto cleanup_helper_process;
+      if (!DuplicateHandle (pi.hProcess, hpConOut,
+			    GetCurrentProcess (), &hpConOut, 0,
+			    TRUE, DUPLICATE_SAME_ACCESS))
+	goto cleanup_pcon_in;
+
+      CloseHandle (hr);
+      CloseHandle (hw);
+      DeleteProcThreadAttributeList (si.lpAttributeList);
+      HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
+
+      /* Attach to pseudo console */
+      FreeConsole ();
+      AttachConsole (pi.dwProcessId);
+
+      /* Terminate helper process */
+      SetEvent (goodbye);
+      WaitForSingleObject (pi.hProcess, INFINITE);
+      CloseHandle (goodbye);
+      CloseHandle (pi.hProcess);
+
+      /* Set handle */
+      HANDLE orig_input_handle = get_handle ();
+      HANDLE orig_output_handle = get_output_handle ();
+      cygheap_fdenum cfd (false);
+      while (cfd.next () >= 0)
+	if (cfd->get_device () == get_device ())
+	  {
+	    fhandler_base *fh = cfd;
+	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+	    if (ptys->get_handle () == orig_input_handle)
+	      ptys->set_handle (hpConIn);
+	    if (ptys->get_output_handle () == orig_output_handle)
+	      ptys->set_output_handle (hpConOut);
+	  }
+      CloseHandle (orig_input_handle);
+      CloseHandle (orig_output_handle);
+    }
+  while (false);
 
   if (get_ttyp ()->pcon_pid == 0 || !pinfo (get_ttyp ()->pcon_pid))
     get_ttyp ()->pcon_pid = myself->pid;
@@ -2676,11 +2807,23 @@ fhandler_pty_slave::setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon)
       HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
       get_ttyp ()->h_pcon_write_pipe = hp->hWritePipe;
     }
-  get_ttyp ()->pcon_start = true;
   return true;
 
+cleanup_pcon_in:
+  CloseHandle (hpConIn);
+cleanup_helper_process:
+  SetEvent (goodbye);
+  WaitForSingleObject (pi.hProcess, INFINITE);
+  CloseHandle (pi.hProcess);
+  goto skip_close_hello;
+cleanup_event_and_pipes:
+  CloseHandle (hello);
+skip_close_hello:
+  CloseHandle (goodbye);
+  CloseHandle (hr);
+  CloseHandle (hw);
 cleanup_heap:
-  HeapFree (GetProcessHeap (), 0, si->lpAttributeList);
+  HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
 cleanup_pseudo_console:
   if (get_ttyp ()->h_pseudo_console)
     {
@@ -2690,6 +2833,7 @@ cleanup_pseudo_console:
       CloseHandle (tmp);
     }
 fallback:
+  get_ttyp ()->pcon_start = false;
   get_ttyp ()->h_pseudo_console = NULL;
   return false;
 }
@@ -2702,6 +2846,8 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
   if (ttyp->h_pseudo_console)
     {
       ttyp->wait_pcon_fwd ();
+      FreeConsole ();
+      AttachConsole (ATTACH_PARENT_PROCESS);
       HPCON_INTERNAL *hp = (HPCON_INTERNAL *) ttyp->h_pseudo_console;
       HANDLE tmp = hp->hConHostProcess;
       ClosePseudoConsole (ttyp->h_pseudo_console);
@@ -2710,7 +2856,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
       ttyp->switch_to_pcon_in = false;
       ttyp->pcon_pid = 0;
       ttyp->pcon_start = false;
-      ttyp->do_not_resize_pcon = false;
     }
 }
 
@@ -2793,7 +2938,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   char buf[1024];
   char *p;
   int len;
-  int x1, y1, x2, y2;
   int wait_cnt = 0;
 
   /* Check if terminal has ANSI escape sequence. */
@@ -2820,8 +2964,9 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 	  len -= n;
 	  *p = '\0';
 	  char *p1 = strrchr (buf, '\033');
+	  int x, y;
 	  char c;
-	  if (p1 == NULL || sscanf (p1, "\033[%d;%d%c", &y1, &x1, &c) != 3
+	  if (p1 == NULL || sscanf (p1, "\033[%d;%d%c", &y, &x, &c) != 3
 	      || c != 'R')
 	    continue;
 	  wait_cnt = 0;
@@ -2833,48 +2978,13 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
 	Sleep (1);
     }
   while (len);
+  get_ttyp ()->h_pseudo_console = NULL;
   if (len == 0)
     goto not_has_csi6n;
 
   get_ttyp ()->has_csi6n = true;
   get_ttyp ()->pcon_cap_checked = true;
 
-  /* Check if terminal has set-title capability */
-  WaitForSingleObject (input_mutex, INFINITE);
-  /* Set pcon_start again because it should be cleared
-     in master write(). */
-  get_ttyp ()->pcon_start = true;
-  WriteFile (get_output_handle_cyg (), "\033]0;\033\\\033[6n", 10, &n, NULL);
-  ReleaseMutex (input_mutex);
-  p = buf;
-  len = sizeof (buf) - 1;
-  do
-    {
-      ReadFile (get_handle (), p, len, &n, NULL);
-      p += n;
-      len -= n;
-      *p = '\0';
-      char *p2 = strrchr (buf, '\033');
-      char c;
-      if (p2 == NULL || sscanf (p2, "\033[%d;%d%c", &y2, &x2, &c) != 3
-	  || c != 'R')
-	continue;
-      break;
-    }
-  while (len);
-  get_ttyp ()->h_pseudo_console = NULL;
-
-  if (len == 0)
-    return true;
-
-  if (x2 == x1 && y2 == y1)
-    /* If "\033]0;\033\\" does not move cursor position,
-       set-title is supposed to be supported. */
-    get_ttyp ()->has_set_title = true;
-  else
-    /* Try to erase garbage string caused by "\033]0;\033\\" */
-    for (int i=0; i<x2-x1; i++)
-      WriteFile (get_output_handle_cyg (), "\b \b", 3, &n, NULL);
   return true;
 
 not_has_csi6n:
@@ -2928,3 +3038,139 @@ fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
   p->ttyp = get_ttyp ();
   SetEvent (thread_param_copied_event);
 }
+
+#define ALT_PRESSED (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED)
+#define CTRL_PRESSED (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED)
+void
+fhandler_pty_slave::transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
+				    HANDLE input_available_event)
+{
+  HANDLE to;
+  if (dir == to_nat)
+    to = ttyp->to_slave ();
+  else
+    to = ttyp->to_slave_cyg ();
+
+  pinfo p (ttyp->master_pid);
+  HANDLE pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
+  DuplicateHandle (pty_owner, to, GetCurrentProcess (), &to,
+		   0, TRUE, DUPLICATE_SAME_ACCESS);
+
+  UINT cp_from = 0, cp_to = 0;
+
+  if (dir == to_nat)
+    {
+      cp_from = ttyp->term_code_page;
+      if (ttyp->h_pseudo_console)
+	cp_to = CP_UTF8;
+      else
+	cp_to = GetConsoleCP ();
+    }
+  else
+    {
+      cp_from = GetConsoleCP ();
+      cp_to = ttyp->term_code_page;
+    }
+
+  tmp_pathbuf tp;
+  char *buf = tp.c_get ();
+
+  bool transfered = false;
+
+  if (dir == to_cyg && ttyp->h_pseudo_console)
+    { /* from handle is console handle */
+      INPUT_RECORD r[INREC_SIZE];
+      DWORD n;
+      while (PeekConsoleInputA (from, r, INREC_SIZE, &n) && n)
+	{
+	  ReadConsoleInputA (from, r, n, &n);
+	  int len = 0;
+	  char *ptr = buf;
+	  for (DWORD i = 0; i < n; i++)
+	    if (r[i].EventType == KEY_EVENT && r[i].Event.KeyEvent.bKeyDown)
+	      {
+		DWORD ctrl_key_state = r[i].Event.KeyEvent.dwControlKeyState;
+		if (r[i].Event.KeyEvent.uChar.AsciiChar)
+		  {
+		    if ((ctrl_key_state & ALT_PRESSED)
+			&& r[i].Event.KeyEvent.uChar.AsciiChar <= 0x7f)
+		      buf[len++] = '\033'; /* Meta */
+		    buf[len++] = r[i].Event.KeyEvent.uChar.AsciiChar;
+		  }
+		/* Allow Ctrl-Space to emit ^@ */
+		else if (r[i].Event.KeyEvent.wVirtualKeyCode == '2'
+			 && (ctrl_key_state & CTRL_PRESSED)
+			 && !(ctrl_key_state & ALT_PRESSED))
+		  buf[len++] = '\0';
+		else
+		  { /* arrow/function keys */
+		    /* FIXME: The current code generates cygwin terminal
+		       sequence rather than xterm sequence. */
+		    char tmp[16];
+		    const char *add =
+		      fhandler_console::get_nonascii_key (r[i], tmp);
+		    if (add)
+		      {
+			strcpy (buf + len, add);
+			len += strlen (add);
+		      }
+		  }
+	      }
+	  if (cp_to != cp_from)
+	    {
+	      static mbstate_t mbp;
+	      char *mbbuf = tp.c_get ();
+	      size_t nlen = NT_MAX_PATH;
+	      convert_mb_str (cp_to, mbbuf, &nlen, cp_from, buf, len, &mbp);
+	      ptr = mbbuf;
+	      len = nlen;
+	    }
+	  /* Call WriteFile() line by line */
+	  char *p0 = ptr;
+	  char *p1 = ptr;
+	  while ((p1 = (char *) memchr (p0, '\r', len - (p0 - ptr))))
+	    {
+	      *p1 = '\n';
+	      n = p1 - p0 + 1;
+	      if (n && WriteFile (to, p0, n, &n, NULL) && n)
+		transfered = true;
+	      p0 = p1 + 1;
+	    }
+	  n = len - (p0 - ptr);
+	  if (n && WriteFile (to, p0, n, &n, NULL) && n)
+	    transfered = true;
+	}
+    }
+  else
+    {
+      DWORD bytes_in_pipe;
+      while (::bytes_available (bytes_in_pipe, from) && bytes_in_pipe)
+	{
+	  DWORD n;
+	  ReadFile (from, buf, NT_MAX_PATH, &n, NULL);
+	  char *ptr = buf;
+	  if (dir == to_nat && ttyp->h_pseudo_console)
+	    {
+	      char *p = buf;
+	      while ((p = (char *) memchr (p, '\n', n - (p - buf))))
+		*p = '\r';
+	    }
+	  if (cp_to != cp_from)
+	    {
+	      static mbstate_t mbp;
+	      char *mbbuf = tp.c_get ();
+	      size_t nlen = NT_MAX_PATH;
+	      convert_mb_str (cp_to, mbbuf, &nlen, cp_from, buf, n, &mbp);
+	      ptr = mbbuf;
+	      n = nlen;
+	    }
+	  if (n && WriteFile (to, ptr, n, &n, NULL) && n)
+	    transfered = true;;
+	}
+    }
+
+  if (dir == to_nat)
+    ResetEvent (input_available_event);
+  else if (transfered)
+    SetEvent (input_available_event);
+}
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index d03492ee6..d12e52e4f 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -653,6 +653,34 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      }
 	}
 
+      bool enable_pcon = false;
+      HANDLE ptys_from_master = NULL;
+      HANDLE ptys_input_available_event = NULL;
+      tty *ptys_ttyp = NULL;
+      if (!iscygwin () && ptys_primary && is_console_app (runpath))
+	{
+	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
+	  if (disable_pcon || !ptys_primary->term_has_pcon_cap (envblock))
+	    nopcon = true;
+	  if (ptys_primary->setup_pseudoconsole (nopcon))
+	    enable_pcon = true;
+	  ptys_ttyp = ptys_primary->get_ttyp ();
+	  ptys_from_master = ptys_primary->get_handle ();
+	  DuplicateHandle (GetCurrentProcess (), ptys_from_master,
+			   GetCurrentProcess (), &ptys_from_master,
+			   0, 0, DUPLICATE_SAME_ACCESS);
+	  ptys_input_available_event =
+	    ptys_primary->get_input_available_event ();
+	  DuplicateHandle (GetCurrentProcess (), ptys_input_available_event,
+			   GetCurrentProcess (), &ptys_input_available_event,
+			   0, 0, DUPLICATE_SAME_ACCESS);
+	  if (!enable_pcon)
+	    fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
+						ptys_primary->get_handle_cyg (),
+						ptys_ttyp,
+						ptys_input_available_event);
+	}
+
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
       si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false);
@@ -664,25 +692,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       if (!iscygwin ())
 	init_console_handler (myself->ctty > 0);
 
-      bool enable_pcon = false;
-      tty *ptys_ttyp = NULL;
-      STARTUPINFOEXW si_pcon;
-      ZeroMemory (&si_pcon, sizeof (si_pcon));
-      STARTUPINFOW *si_tmp = &si;
-      if (!iscygwin () && ptys_primary && is_console_app (runpath))
-	{
-	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
-	  if (disable_pcon || !ptys_primary->term_has_pcon_cap (envblock))
-	    nopcon = true;
-	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
-	    {
-	      c_flags |= EXTENDED_STARTUPINFO_PRESENT;
-	      si_tmp = &si_pcon.StartupInfo;
-	      enable_pcon = true;
-	      ptys_ttyp = ptys_primary->get_ttyp ();
-	    }
-	}
-
     loop:
       /* When ruid != euid we create the new process under the current original
 	 account and impersonate in child, this way maintaining the different
@@ -711,7 +720,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			       c_flags,
 			       envblock,	/* environment */
 			       NULL,
-			       si_tmp,
+			       &si,
 			       &pi);
 	}
       else
@@ -765,7 +774,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			       c_flags,
 			       envblock,	/* environment */
 			       NULL,
-			       si_tmp,
+			       &si,
 			       &pi);
 	  if (hwst)
 	    {
@@ -778,11 +787,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      CloseDesktop (hdsk);
 	    }
 	}
-      if (enable_pcon)
-	{
-	  DeleteProcThreadAttributeList (si_pcon.lpAttributeList);
-	  HeapFree (GetProcessHeap (), 0, si_pcon.lpAttributeList);
-	}
 
       if (mode != _P_OVERLAY)
 	SetHandleInformation (my_wr_proc_pipe, HANDLE_FLAG_INHERIT,
@@ -954,14 +958,20 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (sem)
 	    __posix_spawn_sem_release (sem, 0);
-	  if (enable_pcon)
+	  if (enable_pcon || ptys_ttyp || cons_native)
+	    WaitForSingleObject (pi.hProcess, INFINITE);
+	  if (ptys_ttyp)
 	    {
-	      WaitForSingleObject (pi.hProcess, INFINITE);
-	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
+	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+						  ptys_from_master, ptys_ttyp,
+						  ptys_input_available_event);
+	      CloseHandle (ptys_from_master);
+	      CloseHandle (ptys_input_available_event);
 	    }
+	  if (enable_pcon)
+	    fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
 	  else if (cons_native)
 	    {
-	      WaitForSingleObject (pi.hProcess, INFINITE);
 	      fhandler_console::request_xterm_mode_output (true,
 							   &cons_handle_set);
 	      fhandler_console::request_xterm_mode_input (true,
@@ -975,6 +985,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  system_call.arm ();
 	  if (waitpid (cygpid, &res, 0) != cygpid)
 	    res = -1;
+	  if (ptys_ttyp)
+	    {
+	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+						  ptys_from_master, ptys_ttyp,
+						  ptys_input_available_event);
+	      CloseHandle (ptys_from_master);
+	      CloseHandle (ptys_input_available_event);
+	    }
 	  if (enable_pcon)
 	    fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
 	  else if (cons_native)
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index c6e13f111..436f5c6c3 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -244,8 +244,6 @@ tty::init ()
   pcon_start = false;
   pcon_cap_checked = false;
   has_csi6n = false;
-  has_set_title = false;
-  do_not_resize_pcon = false;
   need_invisible_console = false;
   invisible_console_pid = 0;
 }
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index a975aba45..eb604588c 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -93,6 +93,8 @@ private:
   HANDLE _from_master_cyg;
   HANDLE _to_master;
   HANDLE _to_master_cyg;
+  HANDLE _to_slave;
+  HANDLE _to_slave_cyg;
   HPCON h_pseudo_console;
   bool pcon_start;
   bool switch_to_pcon_in;
@@ -103,8 +105,6 @@ private:
   HANDLE h_pcon_write_pipe;
   bool pcon_cap_checked;
   bool has_csi6n;
-  bool has_set_title;
-  bool do_not_resize_pcon;
   bool need_invisible_console;
   pid_t invisible_console_pid;
 
@@ -113,10 +113,14 @@ public:
   HANDLE from_master_cyg () const { return _from_master_cyg; }
   HANDLE to_master () const { return _to_master; }
   HANDLE to_master_cyg () const { return _to_master_cyg; }
+  HANDLE to_slave () const { return _to_slave; }
+  HANDLE to_slave_cyg () const { return _to_slave_cyg; }
   void set_from_master (HANDLE h) { _from_master = h; }
   void set_from_master_cyg (HANDLE h) { _from_master_cyg = h; }
   void set_to_master (HANDLE h) { _to_master = h; }
   void set_to_master_cyg (HANDLE h) { _to_master_cyg = h; }
+  void set_to_slave (HANDLE h) { _to_slave = h; }
+  void set_to_slave_cyg (HANDLE h) { _to_slave_cyg = h; }
 
   int read_retval;
   bool was_opened;	/* True if opened at least once. */
-- 
2.30.0

