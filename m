Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 0254C3858429
 for <cygwin-patches@cygwin.com>; Mon, 21 Feb 2022 22:45:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0254C3858429
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21LMj1hn007051;
 Tue, 22 Feb 2022 07:45:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21LMj1hn007051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645483506;
 bh=xCK1ov5ewQWn5ZpIFzNcgr+spXWDAo16bHDvLV9a3L4=;
 h=From:To:Cc:Subject:Date:From;
 b=AUKciu1IkSHeSKYZ9xRKCKinPc6zjwfjYnwFHdxM2AOtpyWheTtKtOCyXl+BQuNqF
 aIF7grai1gVz5aFhd/QFOgDeXJb+UIJhpbhww54T3XY1hOJA1lKE4Secy9AHkqf460
 96mpgrKnIE3LRvwfMRsfPmkMmjJxBn+bDl8r2h6vg7qSTS3xSNA1KvgVBuHc0nMUQL
 1HkWW7eDwt7gH0jXZLVTdzjtOvRWfyTCW7/M1T3S2dPSOeyYkDQqBgZBoeJ04Vb+74
 03rX49bnmOobScCpK8ha6a+Xiuqb/APSsnDxD8LrKKTLcGQMJOKcirYM7WPO+Q8s8V
 LAXeIasOg4pIg==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty,
 console: Fix handle leak which occurs on exec() error.
Date: Tue, 22 Feb 2022 07:44:58 +0900
Message-Id: <20220221224458.1299-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Mon, 21 Feb 2022 22:45:49 -0000

- This patch fixes the handle leak which occurs when exec() fails
  with an error. The duplicated handles will be closed when the
  exec'ed process is terminated. However, if exec() fails, the code
  path does not reach to the code closing the duplicated handles.
  To implement this fix more appropriately, the setup, cleanup and
  closing pty codes which was previously located in spawn.cc are
  encapsulated into the fhandler_pty_slave class functions.
---
 winsup/cygwin/fhandler.h          |  20 +++-
 winsup/cygwin/fhandler_console.cc |  17 ++-
 winsup/cygwin/fhandler_tty.cc     |  70 +++++++++++-
 winsup/cygwin/spawn.cc            | 182 +++++++++++-------------------
 winsup/cygwin/tty.cc              |   2 +-
 5 files changed, 157 insertions(+), 134 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4fadbd82a..40dab9346 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2249,9 +2249,8 @@ private:
   static void close_handle_set (handle_set_t *p);
 
   static void cons_master_thread (handle_set_t *p, tty *ttyp);
-  pid_t get_owner (void) { return shared_console_info->con.owner; }
-  void setup_console_for_non_cygwin_app ();
-  void cleanup_console_for_non_cygwin_app ();
+  void setup_for_non_cygwin_app ();
+  static void cleanup_for_non_cygwin_app (handle_set_t *p);
   static void set_console_mode_to_native ();
 
   friend tty_min * tty_list::get_cttyp ();
@@ -2325,6 +2324,14 @@ class fhandler_pty_slave: public fhandler_pty_common
   void fch_close_handles ();
 
  public:
+  struct handle_set_t
+  {
+    HANDLE from_master_nat;
+    HANDLE input_available_event;
+    HANDLE input_mutex;
+    HANDLE pcon_mutex;
+  };
+
   /* Constructor */
   fhandler_pty_slave (int);
 
@@ -2381,13 +2388,18 @@ class fhandler_pty_slave: public fhandler_pty_common
   void reset_switch_to_pcon (void);
   void mask_switch_to_pcon_in (bool mask, bool xfer);
   void setup_locale (void);
-  tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
   void create_invisible_console (void);
   static void transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 			      HANDLE input_available_event);
   HANDLE get_input_available_event (void) { return input_available_event; }
   bool pcon_activated (void) { return get_ttyp ()->pcon_activated; }
   void cleanup_before_exit ();
+  void get_duplicated_handle_set (handle_set_t *p);
+  static void close_handle_set (handle_set_t *p);
+  void setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
+				 bool stdin_is_ptys);
+  static void cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
+					  bool stdin_is_ptys);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 03ec88804..ec33a9d3c 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -507,10 +507,8 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
   ReleaseMutex (p->output_mutex);
 }
 
-static fhandler_console::handle_set_t NO_COPY duplicated_handle_set;
-
 void
-fhandler_console::setup_console_for_non_cygwin_app ()
+fhandler_console::setup_for_non_cygwin_app ()
 {
   /* Setting-up console mode for non-cygwin app. */
   /* If conmode is set to tty::native for non-cygwin apps
@@ -521,22 +519,21 @@ fhandler_console::setup_console_for_non_cygwin_app ()
     (get_ttyp ()->getpgid ()== myself->pgid) ? tty::native : tty::restore;
   set_input_mode (conmode, &tc ()->ti, get_handle_set ());
   set_output_mode (conmode, &tc ()->ti, get_handle_set ());
-  /* Console handles will be already closed by close_all_files()
-     when cleaning up, therefore, duplicate them here. */
-  get_duplicated_handle_set (&duplicated_handle_set);
 }
 
 void
-fhandler_console::cleanup_console_for_non_cygwin_app ()
+fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
 {
+  termios dummy = {0, };
+  termios *ti =
+    shared_console_info ? &(shared_console_info->tty_min_state.ti) : &dummy;
   /* Cleaning-up console mode for non-cygwin app. */
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode =
     (con.owner == myself->pid) ? tty::restore : tty::cygwin;
-  set_output_mode (conmode, &tc ()->ti, &duplicated_handle_set);
-  set_input_mode (conmode, &tc ()->ti, &duplicated_handle_set);
-  close_handle_set (&duplicated_handle_set);
+  set_output_mode (conmode, ti, p);
+  set_input_mode (conmode, ti, p);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a25690a0e..10026b995 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -235,7 +235,7 @@ atexit_func (void)
 	      force_switch_to = GetProcessId (h_gdb_process);
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	    tty *ttyp = ptys->get_ttyp ();
+	    tty *ttyp = (tty *) ptys->tc ();
 	    HANDLE from = ptys->get_handle_nat ();
 	    HANDLE input_available_event = ptys->get_input_available_event ();
 	    if (ttyp->getpgid () == myself->pgid
@@ -3979,3 +3979,71 @@ fhandler_pty_slave::cleanup_before_exit ()
   if (myself->process_state & PID_NOTCYGWIN)
     get_ttyp ()->wait_pcon_fwd ();
 }
+
+void
+fhandler_pty_slave::get_duplicated_handle_set (handle_set_t *p)
+{
+  DuplicateHandle (GetCurrentProcess (), get_handle_nat (),
+		   GetCurrentProcess (), &p->from_master_nat,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), input_available_event,
+		   GetCurrentProcess (), &p->input_available_event,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), input_mutex,
+		   GetCurrentProcess (), &p->input_mutex,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), pcon_mutex,
+		   GetCurrentProcess (), &p->pcon_mutex,
+		   0, 0, DUPLICATE_SAME_ACCESS);
+}
+
+void
+fhandler_pty_slave::close_handle_set (handle_set_t *p)
+{
+  CloseHandle (p->from_master_nat);
+  p->from_master_nat = NULL;
+  CloseHandle (p->input_available_event);
+  p->input_available_event = NULL;
+  CloseHandle (p->input_mutex);
+  p->input_mutex = NULL;
+  CloseHandle (p->pcon_mutex);
+  p->pcon_mutex = NULL;
+}
+
+void
+fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
+					      bool stdin_is_ptys)
+{
+  if (disable_pcon || !term_has_pcon_cap (envblock))
+    nopcon = true;
+  WaitForSingleObject (pcon_mutex, INFINITE);
+  bool enable_pcon = setup_pseudoconsole (nopcon);
+  ReleaseMutex (pcon_mutex);
+  /* For pcon enabled case, transfer_input() is called in master::write() */
+  if (!enable_pcon && get_ttyp ()->getpgid () == myself->pgid
+      && stdin_is_ptys && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
+    {
+      WaitForSingleObject (input_mutex, mutex_timeout);
+      transfer_input (tty::to_nat, get_handle (), get_ttyp (),
+		      input_available_event);
+      ReleaseMutex (input_mutex);
+    }
+}
+
+void
+fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
+						bool stdin_is_ptys)
+{
+  ttyp->wait_pcon_fwd ();
+  if (ttyp->getpgid () == myself->pgid && stdin_is_ptys
+      && ttyp->pcon_input_state_eq (tty::to_nat))
+    {
+      WaitForSingleObject (p->input_mutex, mutex_timeout);
+      transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
+		      p->input_available_event);
+      ReleaseMutex (p->input_mutex);
+    }
+  WaitForSingleObject (p->pcon_mutex, INFINITE);
+  close_pseudoconsole (ttyp);
+  ReleaseMutex (p->pcon_mutex);
+}
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 9ecc2d29e..3647580a6 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -281,21 +281,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 {
   bool rc;
   int res = -1;
-  pid_t ctty_pgid = 0;
-
-  /* Search for CTTY and retrieve its PGID */
-  cygheap_fdenum cfd (false);
-  while (cfd.next () >= 0)
-    if (cfd->get_major () == DEV_PTYS_MAJOR ||
-	cfd->get_major () == DEV_CONS_MAJOR)
-      {
-	fhandler_termios *fh = (fhandler_termios *) (fhandler_base *) cfd;
-	if (fh->tc ()->ntty == myself->ctty)
-	  {
-	    ctty_pgid = fh->tc ()->getpgid ();
-	    break;
-	  }
-      }
 
   /* Check if we have been called from exec{lv}p or spawn{lv}p and mask
      mode to keep only the spawn mode. */
@@ -339,6 +324,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   STARTUPINFOW si = {};
   int looped = 0;
 
+  struct fhandler_pty_slave::handle_set_t ptys_handle_set = { 0, };
+  bool ptys_need_cleanup = false;
+  struct fhandler_console::handle_set_t cons_handle_set = { 0, };
+  bool cons_need_cleanup = false;
+
   system_call_handle system_call (mode == _P_SYSTEM);
 
   __try
@@ -573,6 +563,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 in a console will break native processes running in the background,
 	 because the Ctrl-C event is sent to all processes in the console, unless
 	 they ignore it explicitely.  CREATE_NEW_PROCESS_GROUP does that for us. */
+      pid_t ctty_pgid =
+	::cygheap->ctty ? ::cygheap->ctty->tc ()->getpgid () : 0;
       if (!iscygwin () && ctty_pgid && ctty_pgid != myself->pgid)
 	c_flags |= CREATE_NEW_PROCESS_GROUP;
       refresh_cygheap ();
@@ -617,26 +609,30 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  const int chk_order[] = {1, 0, 2};
 	  int fd = chk_order[i];
 	  fhandler_base *fh = ::cygheap->fdtab[fd];
-	  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
-	    {
-	      fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	      if (ptys_primary == NULL)
-		ptys_primary = ptys;
-	    }
-	  else if (fh && fh->get_major () == DEV_CONS_MAJOR)
-	    {
-	      if (!iscygwin () && cons_native == NULL)
-		{
-		  cons_native = (fhandler_console *) fh;
-		  cons_native->setup_console_for_non_cygwin_app ();
-		}
-	    }
+	  if (fh && fh->get_major () == DEV_PTYS_MAJOR && ptys_primary == NULL)
+	    ptys_primary = (fhandler_pty_slave *) fh;
+	  else if (fh && fh->get_major () == DEV_CONS_MAJOR
+		   && !iscygwin () && cons_native == NULL)
+	    cons_native = (fhandler_console *) fh;
+	}
+
+      if (cons_native)
+	{
+	  cons_native->setup_for_non_cygwin_app ();
+	  /* Console handles will be already closed by close_all_files()
+	     when cleaning up, therefore, duplicate them here. */
+	  cons_native->get_duplicated_handle_set (&cons_handle_set);
+	  cons_need_cleanup = true;
 	}
 
+      int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
+      int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
+      int fileno_stderr = 2;
+
       if (!iscygwin ())
 	{
 	  int fd;
-	  cfd.rewind ();
+	  cygheap_fdenum cfd (false);
 	  while ((fd = cfd.next ()) >= 0)
 	    if (cfd->get_major () == DEV_PTYS_MAJOR)
 	      {
@@ -646,72 +642,39 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		ptys->setup_locale ();
 	      }
 	    else if (cfd->get_dev () == FH_PIPEW
-		     && (fd == (in__stdout < 0 ? 1 : in__stdout) || fd == 2))
+		     && (fd == fileno_stdout || fd == fileno_stderr))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 		pipe->close_query_handle ();
 		pipe->set_pipe_non_blocking (false);
 	      }
-	    else if (cfd->get_dev () == FH_PIPER
-		     && fd == (in__stdin < 0 ? 0 : in__stdin))
+	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
 		pipe->set_pipe_non_blocking (false);
 	      }
 	}
 
-      bool enable_pcon = false;
-      HANDLE ptys_from_master_nat = NULL;
-      HANDLE ptys_input_available_event = NULL;
-      HANDLE ptys_pcon_mutex = NULL;
-      HANDLE ptys_input_mutex = NULL;
-      tty *ptys_ttyp = NULL;
       bool stdin_is_ptys = false;
+      tty *ptys_ttyp = NULL;
       if (!iscygwin () && ptys_primary && is_console_app (runpath))
 	{
 	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
-	  if (disable_pcon || !ptys_primary->term_has_pcon_cap (envblock))
-	    nopcon = true;
-	  ptys_ttyp = ptys_primary->get_ttyp ();
-	  WaitForSingleObject (ptys_primary->pcon_mutex, INFINITE);
-	  if (ptys_primary->setup_pseudoconsole (nopcon))
-	    enable_pcon = true;
-	  ReleaseMutex (ptys_primary->pcon_mutex);
-	  HANDLE h_stdin = handle ((in__stdin < 0 ? 0 : in__stdin), false);
+	  HANDLE h_stdin = handle (fileno_stdin, false);
 	  if (h_stdin == ptys_primary->get_handle_nat ())
 	    stdin_is_ptys = true;
-	  ptys_from_master_nat = ptys_primary->get_handle_nat ();
-	  DuplicateHandle (GetCurrentProcess (), ptys_from_master_nat,
-			   GetCurrentProcess (), &ptys_from_master_nat,
-			   0, 0, DUPLICATE_SAME_ACCESS);
-	  ptys_input_available_event =
-	    ptys_primary->get_input_available_event ();
-	  DuplicateHandle (GetCurrentProcess (), ptys_input_available_event,
-			   GetCurrentProcess (), &ptys_input_available_event,
-			   0, 0, DUPLICATE_SAME_ACCESS);
-	  DuplicateHandle (GetCurrentProcess (), ptys_primary->pcon_mutex,
-			   GetCurrentProcess (), &ptys_pcon_mutex,
-			   0, 0, DUPLICATE_SAME_ACCESS);
-	  DuplicateHandle (GetCurrentProcess (), ptys_primary->input_mutex,
-			   GetCurrentProcess (), &ptys_input_mutex,
-			   0, 0, DUPLICATE_SAME_ACCESS);
-	  if (!enable_pcon && ptys_ttyp->getpgid () == myself->pgid
-	      && stdin_is_ptys
-	      && ptys_ttyp->pcon_input_state_eq (tty::to_cyg))
-	    {
-	      WaitForSingleObject (ptys_input_mutex, mutex_timeout);
-	      fhandler_pty_slave::transfer_input (tty::to_nat,
-				    ptys_primary->get_handle (),
-				    ptys_ttyp, ptys_input_available_event);
-	      ReleaseMutex (ptys_input_mutex);
-	    }
+	  ptys_primary->setup_for_non_cygwin_app (nopcon, envblock,
+						  stdin_is_ptys);
+	  ptys_primary->get_duplicated_handle_set (&ptys_handle_set);
+	  ptys_ttyp = (tty *) ptys_primary->tc ();
+	  ptys_need_cleanup = true;
 	}
 
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
-      si.hStdInput = handle ((in__stdin < 0 ? 0 : in__stdin), false);
-      si.hStdOutput = handle ((in__stdout < 0 ? 1 : in__stdout), true);
-      si.hStdError = handle (2, true);
+      si.hStdInput = handle (fileno_stdin, false);
+      si.hStdOutput = handle (fileno_stdout, true);
+      si.hStdError = handle (fileno_stderr, true);
 
       si.cb = sizeof (si);
 
@@ -868,6 +831,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       /* Name the handle similarly to proc_subproc. */
       ProtectHandle1 (pi.hProcess, childhProc);
 
+      /* Do not touch these terminal instances after here.
+	 They may be destroyed by close_all_files(). */
+      ptys_primary = NULL;
+      cons_native = NULL;
+
       if (mode == _P_OVERLAY)
 	{
 	  myself->dwProcessId = pi.dwProcessId;
@@ -984,30 +952,20 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (sem)
 	    __posix_spawn_sem_release (sem, 0);
-	  if (enable_pcon || ptys_ttyp || cons_native)
+	  if (ptys_need_cleanup || cons_need_cleanup)
 	    WaitForSingleObject (pi.hProcess, INFINITE);
-	  if (ptys_ttyp)
+	  if (ptys_need_cleanup)
 	    {
-	      ptys_ttyp->wait_pcon_fwd ();
-	      if (ptys_ttyp->getpgid () == myself->pgid && stdin_is_ptys
-		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
-		{
-		  WaitForSingleObject (ptys_input_mutex, mutex_timeout);
-		  fhandler_pty_slave::transfer_input (tty::to_cyg,
-					    ptys_from_master_nat, ptys_ttyp,
-					    ptys_input_available_event);
-		  ReleaseMutex (ptys_input_mutex);
-		}
-	      CloseHandle (ptys_from_master_nat);
-	      CloseHandle (ptys_input_mutex);
-	      CloseHandle (ptys_input_available_event);
-	      WaitForSingleObject (ptys_pcon_mutex, INFINITE);
-	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
-	      ReleaseMutex (ptys_pcon_mutex);
-	      CloseHandle (ptys_pcon_mutex);
+	      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
+							      ptys_ttyp,
+							      stdin_is_ptys);
+	      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
+	    }
+	  if (cons_need_cleanup)
+	    {
+	      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
+	      fhandler_console::close_handle_set (&cons_handle_set);
 	    }
-	  if (cons_native)
-	    cons_native->cleanup_console_for_non_cygwin_app ();
 	  myself.exit (EXITCODE_NOSET);
 	  break;
 	case _P_WAIT:
@@ -1015,28 +973,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  system_call.arm ();
 	  if (waitpid (cygpid, &res, 0) != cygpid)
 	    res = -1;
-	  if (ptys_ttyp)
-	    {
-	      ptys_ttyp->wait_pcon_fwd ();
-	      if (ptys_ttyp->getpgid () == myself->pgid && stdin_is_ptys
-		  && ptys_ttyp->pcon_input_state_eq (tty::to_nat))
-		{
-		  WaitForSingleObject (ptys_input_mutex, mutex_timeout);
-		  fhandler_pty_slave::transfer_input (tty::to_cyg,
-					    ptys_from_master_nat, ptys_ttyp,
-					    ptys_input_available_event);
-		  ReleaseMutex (ptys_input_mutex);
-		}
-	      CloseHandle (ptys_from_master_nat);
-	      CloseHandle (ptys_input_mutex);
-	      CloseHandle (ptys_input_available_event);
-	      WaitForSingleObject (ptys_pcon_mutex, INFINITE);
-	      fhandler_pty_slave::close_pseudoconsole (ptys_ttyp);
-	      ReleaseMutex (ptys_pcon_mutex);
-	      CloseHandle (ptys_pcon_mutex);
-	    }
-	  if (cons_native)
-	    cons_native->cleanup_console_for_non_cygwin_app ();
+	  if (ptys_need_cleanup)
+	    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
+							    ptys_ttyp,
+							    stdin_is_ptys);
+	  if (cons_need_cleanup)
+	    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
 	  break;
 	case _P_DETACH:
 	  res = 0;	/* Lost all memory of this child. */
@@ -1059,6 +1001,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       res = -1;
     }
   __endtry
+  if (ptys_need_cleanup)
+    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
+  if (cons_need_cleanup)
+    fhandler_console::close_handle_set (&cons_handle_set);
   this->cleanup ();
   if (envblock)
     free (envblock);
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index c0015aceb..bc5c96e66 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -315,7 +315,7 @@ tty_min::setpgid (int pid)
 
   if (ptys)
     {
-      tty *ttyp = ptys->get_ttyp ();
+      tty *ttyp = (tty *) ptys->tc ();
       WaitForSingleObject (ptys->pcon_mutex, INFINITE);
       bool was_pcon_fg = ttyp->pcon_fg (pgid);
       bool pcon_fg = ttyp->pcon_fg (pid);
-- 
2.35.1

