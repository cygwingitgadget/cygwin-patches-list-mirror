Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id EFEE3386EC7E
 for <cygwin-patches@cygwin.com>; Thu, 21 Jan 2021 13:11:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EFEE3386EC7E
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10LD9eEb019369;
 Thu, 21 Jan 2021 22:10:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10LD9eEb019369
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/4] Cygwin: pty: Make apps using console APIs be able to
 debug with gdb.
Date: Thu, 21 Jan 2021 22:09:10 +0900
Message-Id: <20210121130911.855-4-takashi.yano@nifty.ne.jp>
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
  2) The apps which use console API cannot be debugged with gdb. This
     is because pseudo console is not activated since gdb uses
     CreateProcess() rather than exec(). Even with this limitation,
     attaching gdb to native app, in which pseudo console is already
     activated, works.
  This patch clears this disadvantage.
---
 winsup/cygwin/fhandler_tty.cc | 124 +++++++++++++++++++++++++---------
 winsup/cygwin/spawn.cc        |   2 +
 winsup/cygwin/tty.cc          |   5 +-
 winsup/cygwin/tty.h           |   2 +-
 4 files changed, 97 insertions(+), 36 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a815e5312..8ac620acf 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -85,21 +85,42 @@ get_console_process_id (DWORD pid, bool match)
 }
 
 static bool isHybrid;
+static HANDLE h_gdb_process;
 
 static void
-set_switch_to_pcon (HANDLE h)
+set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err)
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
+  if (ptys_pcon)
+    ptys_pcon->set_switch_to_pcon ();
+  if (replace_in)
+    *in = replace_in->get_handle ();
+  if (replace_out)
+    *out = replace_out->get_output_handle ();
+  if (replace_err)
+    *err = replace_err->get_output_handle ();
 }
 
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
@@ -113,16 +134,26 @@ CreateProcessA_Hooked
       BOOL inh, DWORD f, LPVOID e, LPCSTR d,
       LPSTARTUPINFOA si, LPPROCESS_INFORMATION pi)
 {
-  HANDLE h;
-  if (!isHybrid)
-    {
-      if (si->dwFlags & STARTF_USESTDHANDLES)
-	h = si->hStdInput;
-      else
-	h = GetStdHandle (STD_INPUT_HANDLE);
-      set_switch_to_pcon (h);
-    }
-  return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+  STARTUPINFOEXA siex = {0, };
+  if (si->cb == sizeof (STARTUPINFOEXA))
+    siex = *(STARTUPINFOEXA *)si;
+  else
+    siex.StartupInfo = *si;
+  STARTUPINFOA *siov = &siex.StartupInfo;
+  if (!(si->dwFlags & STARTF_USESTDHANDLES))
+    {
+      siov->dwFlags |= STARTF_USESTDHANDLES;
+      siov->hStdInput = GetStdHandle (STD_INPUT_HANDLE);
+      siov->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
+      siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
+    }
+  set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError);
+  BOOL ret = CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
+  h_gdb_process = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), h_gdb_process,
+		   GetCurrentProcess (), &h_gdb_process,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  return ret;
 }
 static BOOL WINAPI
 CreateProcessW_Hooked
@@ -130,16 +161,26 @@ CreateProcessW_Hooked
       BOOL inh, DWORD f, LPVOID e, LPCWSTR d,
       LPSTARTUPINFOW si, LPPROCESS_INFORMATION pi)
 {
-  HANDLE h;
-  if (!isHybrid)
-    {
-      if (si->dwFlags & STARTF_USESTDHANDLES)
-	h = si->hStdInput;
-      else
-	h = GetStdHandle (STD_INPUT_HANDLE);
-      set_switch_to_pcon (h);
-    }
-  return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
+  STARTUPINFOEXW siex = {0, };
+  if (si->cb == sizeof (STARTUPINFOEXW))
+    siex = *(STARTUPINFOEXW *)si;
+  else
+    siex.StartupInfo = *si;
+  STARTUPINFOW *siov = &siex.StartupInfo;
+  if (!(si->dwFlags & STARTF_USESTDHANDLES))
+    {
+      siov->dwFlags |= STARTF_USESTDHANDLES;
+      siov->hStdInput = GetStdHandle (STD_INPUT_HANDLE);
+      siov->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
+      siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
+    }
+  set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError);
+  BOOL ret = CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
+  h_gdb_process = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), h_gdb_process,
+		   GetCurrentProcess (), &h_gdb_process,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  return ret;
 }
 
 static void
@@ -833,9 +874,9 @@ fhandler_pty_slave::set_switch_to_pcon (void)
   if (!get_ttyp ()->switch_to_pcon_in)
     {
       isHybrid = true;
-      if (get_ttyp ()->pcon_pid == 0 || !pinfo (get_ttyp ()->pcon_pid))
-	get_ttyp ()->pcon_pid = myself->pid;
-      get_ttyp ()->switch_to_pcon_in = true;
+      setup_locale ();
+      bool nopcon = (disable_pcon || !term_has_pcon_cap (NULL));
+      setup_pseudoconsole (nopcon);
     }
 }
 
@@ -846,6 +887,16 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       && !!pinfo (get_ttyp ()->pcon_pid))
     /* There is a process which is grabbing pseudo console. */
     return;
+  if (h_gdb_process)
+    {
+      if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT)
+	get_ttyp ()->wait_pcon_fwd (false);
+      else
+	{
+	  CloseHandle (h_gdb_process);
+	  h_gdb_process = NULL;
+	}
+    }
   if (isHybrid)
     return;
   get_ttyp ()->pcon_pid = 0;
@@ -2781,6 +2832,14 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
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
       cygheap_fdenum cfd (false);
       while (cfd.next () >= 0)
 	if (cfd->get_device () == get_device ())
@@ -2846,7 +2905,6 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
 {
   if (ttyp->h_pseudo_console)
     {
-      ttyp->wait_pcon_fwd ();
       ttyp->previous_code_page = GetConsoleCP ();
       ttyp->previous_output_code_page = GetConsoleOutputCP ();
       FreeConsole ();
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

