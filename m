Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 4ADBD3989001
 for <cygwin-patches@cygwin.com>; Tue, 26 Jan 2021 03:16:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4ADBD3989001
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10Q3EYa4006375;
 Tue, 26 Jan 2021 12:16:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10Q3EYa4006375
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 3/4] Cygwin: pty: Make apps using console APIs be able to
 debug with gdb.
Date: Tue, 26 Jan 2021 12:14:32 +0900
Message-Id: <20210126031433.668-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126031433.668-1-takashi.yano@nifty.ne.jp>
References: <20210126031433.668-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 26 Jan 2021 03:16:23 -0000

- After commit bb428520, there has been the disadvantage:
  2) The apps which use console API cannot be debugged with gdb. This
     is because pseudo console is not activated since gdb uses
     CreateProcess() rather than exec(). Even with this limitation,
     attaching gdb to native app, in which pseudo console is already
     activated, works.
  This patch clears this disadvantage.
---
 winsup/cygwin/fhandler.h      |   3 +-
 winsup/cygwin/fhandler_tty.cc | 236 +++++++++++++++++++++++++++++-----
 winsup/cygwin/select.cc       |  18 ++-
 winsup/cygwin/select.h        |   8 +-
 winsup/cygwin/spawn.cc        |   2 +
 winsup/cygwin/tty.cc          |   5 +-
 winsup/cygwin/tty.h           |   2 +-
 7 files changed, 226 insertions(+), 48 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 10c5973dd..dcdf65292 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2352,13 +2352,14 @@ class fhandler_pty_slave: public fhandler_pty_common
   bool term_has_pcon_cap (const WCHAR *env);
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
-  void mask_switch_to_pcon_in (bool mask);
+  bool mask_switch_to_pcon_in (bool mask);
   void setup_locale (void);
   tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
   void create_invisible_console (void);
   static void transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 			      HANDLE input_available_event);
   HANDLE get_input_available_event (void) { return input_available_event; }
+  bool pcon_activated (void) { return get_ttyp ()->h_pseudo_console; }
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index cd6b71620..878cf59b6 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -27,6 +27,7 @@ details. */
 #include "cygwait.h"
 #include "registry.h"
 #include "tls_pbuf.h"
+#include "winf.h"
 
 #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
@@ -85,21 +86,47 @@ get_console_process_id (DWORD pid, bool match)
 }
 
 static bool isHybrid;
+static HANDLE h_gdb_process;
 
 static void
-set_switch_to_pcon (HANDLE h)
+set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
 {
   cygheap_fdenum cfd (false);
   int fd;
+  fhandler_base *replace_in = NULL, *replace_out = NULL, *replace_err = NULL;
+  fhandler_pty_slave *ptys_pcon = NULL;
   while ((fd = cfd.next ()) >= 0)
-    if (cfd->get_major () == DEV_PTYS_MAJOR)
-      {
-	fhandler_base *fh = cfd;
-	fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	if (h == ptys->get_handle ())
-	  ptys->set_switch_to_pcon ();
-	return;
-      }
+    {
+      if (*in == cfd->get_handle () ||
+	  (fd == 0 && *in == GetStdHandle (STD_INPUT_HANDLE)))
+	replace_in = (fhandler_base *) cfd;
+      if (*out == cfd->get_output_handle () ||
+	  (fd == 1 && *out == GetStdHandle (STD_OUTPUT_HANDLE)))
+	replace_out = (fhandler_base *) cfd;
+      if (*err == cfd->get_output_handle () ||
+	  (fd == 2 && *err == GetStdHandle (STD_ERROR_HANDLE)))
+	replace_err = (fhandler_base *) cfd;
+      if (cfd->get_major () == DEV_PTYS_MAJOR)
+	{
+	  fhandler_base *fh = cfd;
+	  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+	  if (*in == ptys->get_handle ())
+	    ptys_pcon = ptys;
+	}
+    }
+  if (!iscygwin && ptys_pcon)
+    ptys_pcon->set_switch_to_pcon ();
+  if (replace_in)
+    {
+      if (iscygwin && ptys_pcon->pcon_activated ())
+	*in = replace_in->get_handle_cyg ();
+      else
+	*in = replace_in->get_handle ();
+    }
+  if (replace_out)
+    *out = replace_out->get_output_handle ();
+  if (replace_err)
+    *err = replace_err->get_output_handle ();
 }
 
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
@@ -113,16 +140,55 @@ CreateProcessA_Hooked
       BOOL inh, DWORD f, LPVOID e, LPCSTR d,
       LPSTARTUPINFOA si, LPPROCESS_INFORMATION pi)
 {
-  HANDLE h;
-  if (!isHybrid)
+  STARTUPINFOEXA siex = {0, };
+  if (si->cb == sizeof (STARTUPINFOEXA))
+    siex = *(STARTUPINFOEXA *)si;
+  else
+    siex.StartupInfo = *si;
+  STARTUPINFOA *siov = &siex.StartupInfo;
+  if (!(si->dwFlags & STARTF_USESTDHANDLES))
     {
-      if (si->dwFlags & STARTF_USESTDHANDLES)
-	h = si->hStdInput;
-      else
-	h = GetStdHandle (STD_INPUT_HANDLE);
-      set_switch_to_pcon (h);
+      siov->dwFlags |= STARTF_USESTDHANDLES;
+      siov->hStdInput = GetStdHandle (STD_INPUT_HANDLE);
+      siov->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
+      siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
-  return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+  path_conv path;
+  tmp_pathbuf tp;
+  char *prog =tp.c_get ();
+  if (n)
+    __small_sprintf (prog, "%s", n);
+  else
+    {
+      __small_sprintf (prog, "%s", c);
+      char *p = prog;
+      char *p1;
+      do
+	if ((p1 = strstr (p, ".exe")) || (p1 = strstr (p, ".com")))
+	  {
+	    p = p1 + 4;
+	    if (*p == ' ')
+	      {
+		*p = '\0';
+		path.check (prog);
+		*p = ' ';
+	      }
+	    else if (*p == '\0')
+	      path.check (prog);
+	  }
+      while (!path.exists() && p1);
+    }
+  const char *argv[] = {"", NULL}; /* Dummy */
+  av av1;
+  av1.setup ("", path, "", 1, argv, false);
+  set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError,
+		      path.iscygexec ());
+  BOOL ret = CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
+  h_gdb_process = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), h_gdb_process,
+		   GetCurrentProcess (), &h_gdb_process,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  return ret;
 }
 static BOOL WINAPI
 CreateProcessW_Hooked
@@ -130,16 +196,55 @@ CreateProcessW_Hooked
       BOOL inh, DWORD f, LPVOID e, LPCWSTR d,
       LPSTARTUPINFOW si, LPPROCESS_INFORMATION pi)
 {
-  HANDLE h;
-  if (!isHybrid)
+  STARTUPINFOEXW siex = {0, };
+  if (si->cb == sizeof (STARTUPINFOEXW))
+    siex = *(STARTUPINFOEXW *)si;
+  else
+    siex.StartupInfo = *si;
+  STARTUPINFOW *siov = &siex.StartupInfo;
+  if (!(si->dwFlags & STARTF_USESTDHANDLES))
     {
-      if (si->dwFlags & STARTF_USESTDHANDLES)
-	h = si->hStdInput;
-      else
-	h = GetStdHandle (STD_INPUT_HANDLE);
-      set_switch_to_pcon (h);
+      siov->dwFlags |= STARTF_USESTDHANDLES;
+      siov->hStdInput = GetStdHandle (STD_INPUT_HANDLE);
+      siov->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
+      siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
-  return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+  path_conv path;
+  tmp_pathbuf tp;
+  char *prog =tp.c_get ();
+  if (n)
+    __small_sprintf (prog, "%W", n);
+  else
+    {
+      __small_sprintf (prog, "%W", c);
+      char *p = prog;
+      char *p1;
+      do
+	if ((p1 = strstr (p, ".exe")) || (p1 = strstr (p, ".com")))
+	  {
+	    p = p1 + 4;
+	    if (*p == ' ')
+	      {
+		*p = '\0';
+		path.check (prog);
+		*p = ' ';
+	      }
+	    else if (*p == '\0')
+	      path.check (prog);
+	  }
+      while (!path.exists() && p1);
+    }
+  const char *argv[] = {"", NULL}; /* Dummy */
+  av av1;
+  av1.setup ("", path, "", 1, argv, false);
+  set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError,
+		      path.iscygexec ());
+  BOOL ret = CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
+  h_gdb_process = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), h_gdb_process,
+		   GetCurrentProcess (), &h_gdb_process,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  return ret;
 }
 
 static void
@@ -833,9 +938,13 @@ fhandler_pty_slave::set_switch_to_pcon (void)
   if (!get_ttyp ()->switch_to_pcon_in)
     {
       isHybrid = true;
-      if (get_ttyp ()->pcon_pid == 0 || !pinfo (get_ttyp ()->pcon_pid))
-	get_ttyp ()->pcon_pid = myself->pid;
-      get_ttyp ()->switch_to_pcon_in = true;
+      setup_locale ();
+      bool nopcon = (disable_pcon || !term_has_pcon_cap (NULL));
+      if (!setup_pseudoconsole (nopcon))
+	fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_nat,
+					    get_handle_cyg (),
+					    get_ttyp (),
+					    input_available_event);
     }
 }
 
@@ -846,6 +955,55 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       && !!pinfo (get_ttyp ()->pcon_pid))
     /* There is a process which is grabbing pseudo console. */
     return;
+  if (h_gdb_process)
+    {
+      if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT)
+	{
+	  get_ttyp ()->wait_pcon_fwd (false);
+	  return;
+	}
+      else
+	{
+	  CloseHandle (h_gdb_process);
+	  h_gdb_process = NULL;
+	  if (get_ttyp ()->switch_to_pcon_in
+	      && get_ttyp ()->pcon_pid != myself->pid)
+	    fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+						get_handle (),
+						get_ttyp (),
+						input_available_event);
+	  pinfo p (get_ttyp ()->master_pid);
+	  HANDLE pty_owner = NULL;
+	  if (p)
+	    pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
+	  if (pty_owner && get_ttyp ()->pcon_pid == myself->pid)
+	    {
+	      close_pseudoconsole (get_ttyp ());
+	      bool fixin, fixout, fixerr;
+	      fixin = GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
+	      fixout = GetStdHandle (STD_OUTPUT_HANDLE) == get_output_handle ();
+	      fixerr = GetStdHandle (STD_ERROR_HANDLE) == get_output_handle ();
+	      CloseHandle (get_handle ());
+	      DuplicateHandle (pty_owner, get_ttyp ()->from_master (),
+			       GetCurrentProcess (), &get_handle (),
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      CloseHandle (get_output_handle ());
+	      DuplicateHandle (pty_owner, get_ttyp ()->to_master (),
+			       GetCurrentProcess (), &get_output_handle (),
+			       0, TRUE, DUPLICATE_SAME_ACCESS);
+	      if (fixin)
+		SetStdHandle (STD_INPUT_HANDLE, get_handle ());
+	      if (fixout)
+		SetStdHandle (STD_OUTPUT_HANDLE, get_output_handle ());
+	      if (fixerr)
+		SetStdHandle (STD_ERROR_HANDLE, get_output_handle ());
+	    }
+	  isHybrid = false;
+	  get_ttyp ()->pcon_pid = 0;
+	  get_ttyp ()->switch_to_pcon_in = false;
+	  return;
+	}
+    }
   if (isHybrid)
     return;
   if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->h_pseudo_console)
@@ -894,9 +1052,10 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   return towrite;
 }
 
-void
+bool
 fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
 {
+  bool orig = get_ttyp ()->mask_switch_to_pcon_in;
   if (get_ttyp ()->switch_to_pcon_in
       && (get_ttyp ()->pcon_pid == myself->pid
 	  || !get_ttyp ()->h_pseudo_console)
@@ -914,6 +1073,7 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
 					    input_available_event);
     }
   get_ttyp ()->mask_switch_to_pcon_in = mask;
+  return orig;
 }
 
 bool
@@ -945,9 +1105,10 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 
   push_process_state process_state (PID_TTYIN);
 
+  bool need_reset_mask = false;
   if (ptr) /* Indicating not tcflush(). */
     {
-      mask_switch_to_pcon_in (true);
+      need_reset_mask = !mask_switch_to_pcon_in (true);
       reset_switch_to_pcon ();
     }
 
@@ -1061,7 +1222,8 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
       if (ptr && !bytes_in_pipe && !vmin && !time_to_wait)
 	{
 	  ReleaseMutex (input_mutex);
-	  mask_switch_to_pcon_in (false);
+	  if (need_reset_mask)
+	    mask_switch_to_pcon_in (false);
 	  len = (size_t) bytes_in_pipe;
 	  return;
 	}
@@ -1166,7 +1328,8 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
-  mask_switch_to_pcon_in (false);
+  if (need_reset_mask)
+    mask_switch_to_pcon_in (false);
 }
 
 int
@@ -2803,6 +2966,14 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       CloseHandle (pi.hProcess);
 
       /* Set handle */
+      if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
+	SetStdHandle (STD_INPUT_HANDLE, hpConIn);
+      if (GetStdHandle (STD_OUTPUT_HANDLE) == get_output_handle ())
+	SetStdHandle (STD_OUTPUT_HANDLE, hpConOut);
+      if (GetStdHandle (STD_ERROR_HANDLE) == get_output_handle ())
+	SetStdHandle (STD_ERROR_HANDLE, hpConOut);
+
+      /* Fixup handles */
       HANDLE orig_input_handle = get_handle ();
       HANDLE orig_output_handle = get_output_handle ();
       cygheap_fdenum cfd (false);
@@ -2872,7 +3043,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
 {
   if (ttyp->h_pseudo_console)
     {
-      ttyp->wait_pcon_fwd ();
       ttyp->previous_code_page = GetConsoleCP ();
       ttyp->previous_output_code_page = GetConsoleOutputCP ();
       FreeConsole ();
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index d6c13241e..7b3ec45ff 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1387,10 +1387,9 @@ pty_slave_startup (select_record *me, select_stuff *stuff)
 {
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
+  select_ptys_info *pi = stuff->device_specific_ptys;
   if (me->read_selected)
-    ptys->mask_switch_to_pcon_in (true);
-
-  select_pipe_info *pi = stuff->device_specific_ptys;
+    pi->need_reset_mask = !ptys->mask_switch_to_pcon_in (true);
   if (pi->start)
     me->h = *((select_pipe_info *) stuff->device_specific_ptys)->thread;
   else
@@ -1411,12 +1410,11 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
 {
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-  if (me->read_selected)
-    ptys->mask_switch_to_pcon_in (false);
-
-  select_pipe_info *pi = (select_pipe_info *) stuff->device_specific_ptys;
+  select_ptys_info *pi = stuff->device_specific_ptys;
   if (!pi)
     return;
+  if (me->read_selected && pi->need_reset_mask)
+      ptys->mask_switch_to_pcon_in (false);
   if (pi->thread)
     {
       pi->stop_thread = true;
@@ -1432,7 +1430,7 @@ select_record *
 fhandler_pty_slave::select_read (select_stuff *ss)
 {
   if (!ss->device_specific_ptys
-      && (ss->device_specific_ptys = new select_pipe_info) == NULL)
+      && (ss->device_specific_ptys = new select_ptys_info) == NULL)
     return NULL;
   select_record *s = ss->start.next;
   s->startup = pty_slave_startup;
@@ -1448,7 +1446,7 @@ select_record *
 fhandler_pty_slave::select_write (select_stuff *ss)
 {
   if (!ss->device_specific_ptys
-      && (ss->device_specific_ptys = new select_pipe_info) == NULL)
+      && (ss->device_specific_ptys = new select_ptys_info) == NULL)
     return NULL;
   select_record *s = ss->start.next;
   s->startup = pty_slave_startup;
@@ -1464,7 +1462,7 @@ select_record *
 fhandler_pty_slave::select_except (select_stuff *ss)
 {
   if (!ss->device_specific_ptys
-      && (ss->device_specific_ptys = new select_pipe_info) == NULL)
+      && (ss->device_specific_ptys = new select_ptys_info) == NULL)
     return NULL;
   select_record *s = ss->start.next;
   s->startup = pty_slave_startup;
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index b794690b6..61667e01e 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -74,6 +74,12 @@ struct select_pipe_info: public select_info
   select_pipe_info (): select_info () {}
 };
 
+struct select_ptys_info: public select_info
+{
+  select_ptys_info (): select_info (), need_reset_mask(false) {}
+  bool need_reset_mask;
+};
+
 struct select_fifo_info: public select_info
 {
   select_fifo_info (): select_info () {}
@@ -109,7 +115,7 @@ public:
      type in the descriptor lists. */
   select_console_info *device_specific_console;
   select_pipe_info *device_specific_pipe;
-  select_pipe_info *device_specific_ptys;
+  select_ptys_info *device_specific_ptys;
   select_fifo_info *device_specific_fifo;
   select_socket_info *device_specific_socket;
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index d12e52e4f..7984ffbc5 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -962,6 +962,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    WaitForSingleObject (pi.hProcess, INFINITE);
 	  if (ptys_ttyp)
 	    {
+	      ptys_ttyp->wait_pcon_fwd ();
 	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
 						  ptys_from_master, ptys_ttyp,
 						  ptys_input_available_event);
@@ -987,6 +988,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    res = -1;
 	  if (ptys_ttyp)
 	    {
+	      ptys_ttyp->wait_pcon_fwd ();
 	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
 						  ptys_from_master, ptys_ttyp,
 						  ptys_input_available_event);
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 908166a37..432113275 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -294,7 +294,7 @@ tty_min::ttyname ()
 }
 
 void
-tty::wait_pcon_fwd (void)
+tty::wait_pcon_fwd (bool init)
 {
   /* The forwarding in pseudo console sometimes stops for
      16-32 msec even if it already has data to transfer.
@@ -304,7 +304,8 @@ tty::wait_pcon_fwd (void)
      thread when the last data is transfered. */
   const int sleep_in_pcon = 16;
   const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
-  pcon_last_time = GetTickCount ();
+  if (init)
+    pcon_last_time = GetTickCount ();
   while (GetTickCount () - pcon_last_time < time_to_wait)
     {
       int tw = time_to_wait - (GetTickCount () - pcon_last_time);
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 061357437..47ccad670 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -142,7 +142,7 @@ public:
   void set_master_ctl_closed () {master_pid = -1;}
   static void __stdcall create_master (int);
   static void __stdcall init_session ();
-  void wait_pcon_fwd (void);
+  void wait_pcon_fwd (bool init = true);
   friend class fhandler_pty_common;
   friend class fhandler_pty_master;
   friend class fhandler_pty_slave;
-- 
2.30.0

