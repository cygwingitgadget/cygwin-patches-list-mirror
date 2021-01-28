Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id ED8023857011
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 03:27:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ED8023857011
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 10S3QHmd017704;
 Thu, 28 Jan 2021 12:27:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 10S3QHmd017704
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 3/4] Cygwin: pty: Make apps using console APIs be able to
 debug with gdb.
Date: Thu, 28 Jan 2021 12:26:13 +0900
Message-Id: <20210128032614.1678-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210128032614.1678-1-takashi.yano@nifty.ne.jp>
References: <20210128032614.1678-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 28 Jan 2021 03:27:55 -0000

- After commit bb428520, there has been the disadvantage:
  2) The apps which use console API cannot be debugged with gdb. This
     is because pseudo console is not activated since gdb uses
     CreateProcess() rather than exec(). Even with this limitation,
     attaching gdb to native app, in which pseudo console is already
     activated, works.
  This patch clears this disadvantage.
---
 winsup/cygwin/fhandler.h      |   3 +
 winsup/cygwin/fhandler_tty.cc | 299 ++++++++++++++++++++++++++++++----
 winsup/cygwin/select.cc       |   5 +-
 winsup/cygwin/spawn.cc        |   2 +
 winsup/cygwin/tty.cc          |   7 +-
 winsup/cygwin/tty.h           |   5 +-
 6 files changed, 279 insertions(+), 42 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 378e9c13b..3db33ea78 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2284,6 +2284,8 @@ class fhandler_pty_slave: public fhandler_pty_common
 {
   HANDLE inuse;			// used to indicate that a tty is in use
   HANDLE output_handle_cyg, io_handle_cyg;
+  HANDLE slave_reading;
+  LONG num_reader;
 
   /* Helper functions for fchmod and fchown. */
   bool fch_open_handles (bool chown);
@@ -2359,6 +2361,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   static void transfer_input (xfer_dir dir, HANDLE from, tty *ttyp,
 			      _minor_t unit, HANDLE input_available_event);
   HANDLE get_input_available_event (void) { return input_available_event; }
+  bool pcon_activated (void) { return get_ttyp ()->h_pseudo_console; }
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 34cff2ae5..c74e38c3d 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -27,6 +27,7 @@ details. */
 #include "cygwait.h"
 #include "registry.h"
 #include "tls_pbuf.h"
+#include "winf.h"
 
 #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
@@ -87,21 +88,47 @@ get_console_process_id (DWORD pid, bool match)
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
@@ -115,16 +142,55 @@ CreateProcessA_Hooked
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
@@ -132,16 +198,55 @@ CreateProcessW_Hooked
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
@@ -529,7 +634,7 @@ out:
 
 fhandler_pty_slave::fhandler_pty_slave (int unit)
   : fhandler_pty_common (), inuse (NULL), output_handle_cyg (NULL),
-  io_handle_cyg (NULL)
+  io_handle_cyg (NULL), slave_reading (NULL), num_reader (0)
 {
   if (unit >= 0)
     dev ().parse (DEV_PTYS_MAJOR, unit);
@@ -835,15 +940,100 @@ fhandler_pty_slave::set_switch_to_pcon (void)
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
+					    get_ttyp (), get_minor (),
+					    input_available_event);
     }
 }
 
 void
 fhandler_pty_slave::reset_switch_to_pcon (void)
 {
+  if (h_gdb_process)
+    {
+      if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT)
+	{
+	  if (isHybrid)
+	    get_ttyp ()->wait_pcon_fwd (false);
+	}
+      else
+	{
+	  CloseHandle (h_gdb_process);
+	  h_gdb_process = NULL;
+	  if (isHybrid && get_ttyp ()->pcon_pid == myself->pid)
+	    {
+	      if (get_ttyp ()->switch_to_pcon_in)
+		fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
+						    get_handle (),
+						    get_ttyp (), get_minor (),
+						    input_available_event);
+	      if (get_ttyp ()->master_is_running_as_service)
+		/* If the master is running as service, re-attaching to
+		   the console of the parent process will fail.
+		   Therefore, never close pseudo console here. */
+		return;
+	      bool need_restore_handles = !!get_ttyp ()->h_pseudo_console;
+	      close_pseudoconsole (get_ttyp ());
+	      if (need_restore_handles)
+		{
+		  pinfo p (get_ttyp ()->master_pid);
+		  HANDLE pty_owner =
+		    OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
+		  bool fix_in, fix_out, fix_err;
+		  fix_in =
+		    GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
+		  fix_out =
+		    GetStdHandle (STD_OUTPUT_HANDLE) == get_output_handle ();
+		  fix_err =
+		    GetStdHandle (STD_ERROR_HANDLE) == get_output_handle ();
+		  if (pty_owner)
+		    {
+		      CloseHandle (get_handle ());
+		      DuplicateHandle (pty_owner, get_ttyp ()->from_master (),
+				       GetCurrentProcess (), &get_handle (),
+				       0, TRUE, DUPLICATE_SAME_ACCESS);
+		      CloseHandle (get_output_handle ());
+		      DuplicateHandle (pty_owner, get_ttyp ()->to_master (),
+				       GetCurrentProcess (),
+				       &get_output_handle (),
+				       0, TRUE, DUPLICATE_SAME_ACCESS);
+		      CloseHandle (pty_owner);
+		    }
+		  else
+		    {
+		      char pipe[MAX_PATH];
+		      __small_sprintf (pipe,
+			       "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
+			       &cygheap->installation_key, get_minor ());
+		      pipe_request req = { GetCurrentProcessId () };
+		      pipe_reply repl;
+		      DWORD len;
+		      if (!CallNamedPipe (pipe, &req, sizeof req,
+					  &repl, sizeof repl, &len, 500))
+			return; /* What can we do? */
+		      CloseHandle (get_handle ());
+		      set_handle (repl.from_master);
+		      CloseHandle (get_output_handle ());
+		      set_output_handle (repl.to_master);
+		    }
+		  if (fix_in)
+		    SetStdHandle (STD_INPUT_HANDLE, get_handle ());
+		  if (fix_out)
+		    SetStdHandle (STD_OUTPUT_HANDLE, get_output_handle ());
+		  if (fix_err)
+		    SetStdHandle (STD_ERROR_HANDLE, get_output_handle ());
+		}
+	      get_ttyp ()->pcon_pid = 0;
+	      get_ttyp ()->switch_to_pcon_in = false;
+	    }
+	  isHybrid = false;
+	  return;
+	}
+    }
   if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
       && !!pinfo (get_ttyp ()->pcon_pid))
     /* There is a process which is grabbing pseudo console. */
@@ -899,10 +1089,23 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 void
 fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
 {
+  char name[MAX_PATH];
+  shared_name (name, TTY_SLAVE_READING, get_minor ());
+  HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+  CloseHandle (masked);
+
+  if (mask)
+    {
+      if (InterlockedIncrement (&num_reader) == 1)
+	slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
+    }
+  else if (InterlockedDecrement (&num_reader) == 0)
+    CloseHandle (slave_reading);
+
   if (get_ttyp ()->switch_to_pcon_in
       && (get_ttyp ()->pcon_pid == myself->pid
 	  || !get_ttyp ()->h_pseudo_console)
-      && get_ttyp ()->mask_switch_to_pcon_in != mask)
+      && !!masked != mask)
     {
       if (mask)
 	fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
@@ -915,14 +1118,19 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask)
 					    get_ttyp (), get_minor (),
 					    input_available_event);
     }
-  get_ttyp ()->mask_switch_to_pcon_in = mask;
+  return;
 }
 
 bool
 fhandler_pty_master::to_be_read_from_pcon (void)
 {
+  char name[MAX_PATH];
+  shared_name (name, TTY_SLAVE_READING, get_minor ());
+  HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+  CloseHandle (masked);
+
   return get_ttyp ()->pcon_start
-    || (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->mask_switch_to_pcon_in);
+    || (get_ttyp ()->switch_to_pcon_in && !masked);
 }
 
 void __reg3
@@ -2360,6 +2568,13 @@ pty_master_fwd_thread (VOID *arg)
   return fhandler_pty_master::pty_master_fwd_thread (&p);
 }
 
+inline static bool
+is_running_as_service (void)
+{
+  return check_token_membership (well_known_service_sid)
+    || cygheap->user.saved_sid () == well_known_system_sid;
+}
+
 bool
 fhandler_pty_master::setup ()
 {
@@ -2406,8 +2621,15 @@ fhandler_pty_master::setup ()
     }
 
   __small_sprintf (pipename, "pty%d-to-slave", unit);
+  /* FILE_FLAG_OVERLAPPED is specified here in order to prevent
+     PeekNamedPipe() from blocking in transfer_input().
+     Accordig to the official document, in order to access the handle
+     opened with FILE_FLAG_OVERLAPPED, it is mandatory to pass the
+     OVERLAPP structure, but in fact, it seems that the access will
+     fallback to the blocking access if it is not specified. */
   res = fhandler_pipe::create (&sec_none, &from_master, &to_slave,
-			       fhandler_pty_common::pipesize, pipename, 0);
+			       fhandler_pty_common::pipesize, pipename,
+			       FILE_FLAG_OVERLAPPED);
   if (res)
     {
       errstr = "input pipe";
@@ -2498,6 +2720,8 @@ fhandler_pty_master::setup ()
 
   dev ().parse (DEV_PTYM_MAJOR, unit);
 
+  t.master_is_running_as_service = is_running_as_service ();
+
   termios_printf ("this %p, pty%d opened - from_pty <%p,%p>, to_pty %p",
 	this, unit, from_slave, get_handle (),
 	get_output_handle ());
@@ -2819,6 +3043,14 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
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
@@ -2888,7 +3120,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
 {
   if (ttyp->h_pseudo_console)
     {
-      ttyp->wait_pcon_fwd ();
       ttyp->previous_code_page = GetConsoleCP ();
       ttyp->previous_output_code_page = GetConsoleOutputCP ();
       FreeConsole ();
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index d6c13241e..4e7946435 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1411,12 +1411,11 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
 {
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-  if (me->read_selected)
-    ptys->mask_switch_to_pcon_in (false);
-
   select_pipe_info *pi = (select_pipe_info *) stuff->device_specific_ptys;
   if (!pi)
     return;
+  if (me->read_selected && pi->start)
+    ptys->mask_switch_to_pcon_in (false);
   if (pi->thread)
     {
       pi->stop_thread = true;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index b80a20f13..383a5a03e 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -964,6 +964,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    WaitForSingleObject (pi.hProcess, INFINITE);
 	  if (ptys_ttyp)
 	    {
+	      ptys_ttyp->wait_pcon_fwd ();
 	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
 						  ptys_from_master,
 						  ptys_ttyp, ptys_unit,
@@ -990,6 +991,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    res = -1;
 	  if (ptys_ttyp)
 	    {
+	      ptys_ttyp->wait_pcon_fwd ();
 	      fhandler_pty_slave::transfer_input (fhandler_pty_slave::to_cyg,
 						  ptys_from_master,
 						  ptys_ttyp, ptys_unit,
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 908166a37..e6c0b680e 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -237,7 +237,6 @@ tty::init ()
   column = 0;
   h_pseudo_console = NULL;
   switch_to_pcon_in = false;
-  mask_switch_to_pcon_in = false;
   pcon_pid = 0;
   term_code_page = 0;
   pcon_last_time = 0;
@@ -248,6 +247,7 @@ tty::init ()
   invisible_console_pid = 0;
   previous_code_page = 0;
   previous_output_code_page = 0;
+  master_is_running_as_service = false;
 }
 
 HANDLE
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
index 061357437..47be8e4a0 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -21,6 +21,7 @@ details. */
 #define OUTPUT_MUTEX		"cygtty.output.mutex"
 #define INPUT_MUTEX		"cygtty.input.mutex"
 #define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
+#define TTY_SLAVE_READING	"cygtty.slave_reading"
 
 #include <sys/termios.h>
 
@@ -98,7 +99,6 @@ private:
   HPCON h_pseudo_console;
   bool pcon_start;
   bool switch_to_pcon_in;
-  bool mask_switch_to_pcon_in;
   pid_t pcon_pid;
   UINT term_code_page;
   DWORD pcon_last_time;
@@ -109,6 +109,7 @@ private:
   pid_t invisible_console_pid;
   UINT previous_code_page;
   UINT previous_output_code_page;
+  bool master_is_running_as_service;
 
 public:
   HANDLE from_master () const { return _from_master; }
@@ -142,7 +143,7 @@ public:
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

