Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 0ABD73858D39
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 13:20:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0ABD73858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 221DKCuR011263;
 Tue, 1 Mar 2022 22:20:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 221DKCuR011263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646140819;
 bh=xj0KKUdYRwkoylqyn4b7GryyohPaPFfvTZilLM4uIeQ=;
 h=From:To:Cc:Subject:Date:From;
 b=A3QjiY8V9o0w0gWFXRAFSU1/gKJRsx86HNngBvJzav50WhXxgCmar7vm+nT5nGgb5
 2Z3T6QGZ0RtSbAbqMAmXOPERuzoWbcxq2he9Z0Y97oOC2u6oKfWTlP61ZcouJj+2v6
 E94CtT1OMde/uToUgDf9wc9UcCvHEzArVSGVSyKI0KWMjgR7qlH8OJJZYuRAzqp2jP
 /y8BMRx3xPeJrOi3PRk5IP5mgfGH1Tb4d8AMP3KJGOZtsaFlfBYBPXSic/56nqoFVp
 7ysdv/jlvbbLhSBgiBW8wmUz84poLxiF2oXfuOA09tslh3jxUvJHYJ0AiRCx8GUNYz
 X9+B/pXQ7O9LA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Rename some functions/variables with the name
 *pcon*.
Date: Tue,  1 Mar 2022 22:20:03 +0900
Message-Id: <20220301132003.3610-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 01 Mar 2022 13:20:49 -0000

- With this patch, some pty functions/variables have been renamed
  so that the name *pcon* is not used for those that are called
  even when the pseudo console is not active.
---
 winsup/cygwin/fhandler.h      |  14 +-
 winsup/cygwin/fhandler_tty.cc | 314 ++++++++++++++++++----------------
 winsup/cygwin/select.cc       |   6 +-
 winsup/cygwin/tty.cc          |  26 +--
 winsup/cygwin/tty.h           |  22 ++-
 5 files changed, 203 insertions(+), 179 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 919479948..dd1ab0422 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2269,13 +2269,13 @@ class fhandler_pty_common: public fhandler_termios
  public:
   fhandler_pty_common ()
     : fhandler_termios (),
-    output_mutex (NULL), input_mutex (NULL), pcon_mutex (NULL),
+    output_mutex (NULL), input_mutex (NULL), pipe_sw_mutex (NULL),
     input_available_event (NULL)
   {
     pc.file_attributes (FILE_ATTRIBUTE_NORMAL);
   }
   static const unsigned pipesize = 128 * 1024;
-  HANDLE output_mutex, input_mutex, pcon_mutex;
+  HANDLE output_mutex, input_mutex, pipe_sw_mutex;
   HANDLE input_available_event;
 
   bool use_archetype () const {return true;}
@@ -2311,7 +2311,7 @@ class fhandler_pty_common: public fhandler_termios
   static DWORD get_console_process_id (DWORD pid, bool match,
 				       bool cygwin = false,
 				       bool stub_only = false);
-  bool to_be_read_from_pcon (void);
+  bool to_be_read_from_nat_pipe (void);
 
  protected:
   static BOOL process_opost_output (HANDLE h, const void *ptr, ssize_t& len,
@@ -2337,7 +2337,7 @@ class fhandler_pty_slave: public fhandler_pty_common
     HANDLE from_master_nat;
     HANDLE input_available_event;
     HANDLE input_mutex;
-    HANDLE pcon_mutex;
+    HANDLE pipe_sw_mutex;
   };
 
   /* Constructor */
@@ -2394,9 +2394,9 @@ class fhandler_pty_slave: public fhandler_pty_common
   static void close_pseudoconsole (tty *ttyp, DWORD force_switch_to = 0);
   static void hand_over_only (tty *ttyp, DWORD force_switch_to = 0);
   bool term_has_pcon_cap (const WCHAR *env);
-  void set_switch_to_pcon (void);
-  void reset_switch_to_pcon (void);
-  void mask_switch_to_pcon_in (bool mask, bool xfer);
+  void set_switch_to_nat_pipe (void);
+  void reset_switch_to_nat_pipe (void);
+  void mask_switch_to_nat_pipe (bool mask, bool xfer);
   void setup_locale (void);
   void create_invisible_console (void);
   static void transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3d74f9a0c..673f4167a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -48,6 +48,8 @@ struct pipe_request {
   DWORD pid;
 };
 
+/* The name *nat* comes from 'native' which means non-cygwin
+   (native windows). They are used for non-cygwin process. */
 struct pipe_reply {
   HANDLE from_master_nat;
   HANDLE from_master;
@@ -74,7 +76,7 @@ void release_attach_mutex (void)
   ReleaseMutex (attach_mutex);
 }
 
-inline static bool pcon_pid_alive (DWORD pid);
+inline static bool nat_pipe_owner_alive (DWORD pid);
 
 DWORD
 fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
@@ -107,7 +109,7 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 		res_pri = stub_only ? p->exec_dwProcessId : list[i];
 		break;
 	      }
-	    if (!p && !res && pcon_pid_alive (list[i]) && stub_only)
+	    if (!p && !res && nat_pipe_owner_alive (list[i]) && stub_only)
 	      res = list[i];
 	    if (!!p && !res && !stub_only)
 	      res = list[i];
@@ -116,16 +118,17 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
   return res_pri ?: res;
 }
 
-static bool isHybrid;
-static HANDLE h_gdb_process;
+static bool isHybrid; /* Set true if the active pipe is set to nat pipe even
+			 though the current process is a cygwin process. */
+static HANDLE h_gdb_inferior; /* Handle of GDB inferior process. */
 
 static void
-set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
+set_switch_to_nat_pipe (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
 {
   cygheap_fdenum cfd (false);
   int fd;
   fhandler_base *replace_in = NULL, *replace_out = NULL, *replace_err = NULL;
-  fhandler_pty_slave *ptys_pcon = NULL;
+  fhandler_pty_slave *ptys_nat = NULL;
   while ((fd = cfd.next ()) >= 0)
     {
       if (*in == cfd->get_handle () ||
@@ -144,11 +147,11 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
 	  if (*in == ptys->get_handle ()
 	      || *out == ptys->get_output_handle ()
 	      || *err == ptys->get_output_handle ())
-	    ptys_pcon = ptys;
+	    ptys_nat = ptys;
 	}
     }
-  if (!iscygwin && ptys_pcon)
-    ptys_pcon->set_switch_to_pcon ();
+  if (!iscygwin && ptys_nat)
+    ptys_nat->set_switch_to_nat_pipe ();
   if (replace_in)
     *in = replace_in->get_handle_nat ();
   if (replace_out)
@@ -230,9 +233,9 @@ atexit_func (void)
 	if (cfd->get_device () == (dev_t) myself->ctty)
 	  {
 	    DWORD force_switch_to = 0;
-	    if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT
+	    if (WaitForSingleObject (h_gdb_inferior, 0) == WAIT_TIMEOUT
 		&& !debug_process)
-	      force_switch_to = GetProcessId (h_gdb_process);
+	      force_switch_to = GetProcessId (h_gdb_inferior);
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	    tty *ttyp = (tty *) ptys->tc ();
@@ -243,14 +246,14 @@ atexit_func (void)
 		ptys->get_handle_nat (),
 		ptys->get_input_available_event (),
 		ptys->input_mutex,
-		ptys->pcon_mutex
+		ptys->pipe_sw_mutex
 	      };
 	    fhandler_pty_slave::cleanup_for_non_cygwin_app (&handles, ttyp,
 							    stdin_is_ptys,
 							    force_switch_to);
 	    break;
 	  }
-      CloseHandle (h_gdb_process);
+      CloseHandle (h_gdb_inferior);
     }
 }
 
@@ -279,12 +282,12 @@ CreateProcessA_Hooked
       siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
   bool path_iscygexec = fhandler_termios::path_iscygexec_a (n, c);
-  set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError,
-		      path_iscygexec);
+  set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
+			  &siov->hStdError, path_iscygexec);
   BOOL ret = CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
-  h_gdb_process = pi->hProcess;
-  DuplicateHandle (GetCurrentProcess (), h_gdb_process,
-		   GetCurrentProcess (), &h_gdb_process,
+  h_gdb_inferior = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
+		   GetCurrentProcess (), &h_gdb_inferior,
 		   0, 0, DUPLICATE_SAME_ACCESS);
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
@@ -317,12 +320,12 @@ CreateProcessW_Hooked
       siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
   bool path_iscygexec = fhandler_termios::path_iscygexec_w (n, c);
-  set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError,
-		      path_iscygexec);
+  set_switch_to_nat_pipe (&siov->hStdInput, &siov->hStdOutput,
+			  &siov->hStdError, path_iscygexec);
   BOOL ret = CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
-  h_gdb_process = pi->hProcess;
-  DuplicateHandle (GetCurrentProcess (), h_gdb_process,
-		   GetCurrentProcess (), &h_gdb_process,
+  h_gdb_inferior = pi->hProcess;
+  DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
+		   GetCurrentProcess (), &h_gdb_inferior,
 		   0, 0, DUPLICATE_SAME_ACCESS);
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
@@ -519,8 +522,8 @@ fhandler_pty_master::accept_input ()
 
   HANDLE write_to = get_output_handle ();
   tmp_pathbuf tp;
-  if (to_be_read_from_pcon ()
-      && get_ttyp ()->pcon_input_state == tty::to_nat)
+  if (to_be_read_from_nat_pipe ()
+      && get_ttyp ()->pty_input_state == tty::to_nat)
     {
       write_to = to_slave_nat;
 
@@ -776,7 +779,7 @@ fhandler_pty_slave::open (int flags, mode_t)
   {
     &from_master_nat_local, &input_available_event, &input_mutex, &inuse,
     &output_mutex, &to_master_nat_local, &pty_owner, &to_master_local,
-    &from_master_local, &pcon_mutex,
+    &from_master_local, &pipe_sw_mutex,
     NULL
   };
 
@@ -804,9 +807,10 @@ fhandler_pty_slave::open (int flags, mode_t)
       errmsg = "open input mutex failed, %E";
       goto err;
     }
-  if (!(pcon_mutex = get_ttyp ()->open_mutex (PCON_MUTEX, MAXIMUM_ALLOWED)))
+  if (!(pipe_sw_mutex
+	= get_ttyp ()->open_mutex (PIPE_SW_MUTEX, MAXIMUM_ALLOWED)))
     {
-      errmsg = "open pcon mutex failed, %E";
+      errmsg = "open pipe switch mutex failed, %E";
       goto err;
     }
   shared_name (buf, INPUT_AVAILABLE_EVENT, get_minor ());
@@ -1079,21 +1083,21 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t)
 }
 
 void
-fhandler_pty_slave::set_switch_to_pcon (void)
+fhandler_pty_slave::set_switch_to_nat_pipe (void)
 {
   if (!isHybrid)
     {
       isHybrid = true;
       setup_locale ();
       myself->exec_dwProcessId = myself->dwProcessId;
-      myself->process_state |= PID_NEW_PG; /* Marker for pcon_fg */
+      myself->process_state |= PID_NEW_PG; /* Marker for nat_fg */
       bool stdin_is_ptys = GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
       setup_for_non_cygwin_app (false, NULL, stdin_is_ptys);
     }
 }
 
 inline static bool
-pcon_pid_alive (DWORD pid)
+nat_pipe_owner_alive (DWORD pid)
 {
   if (pid == 0)
     return false;
@@ -1109,31 +1113,35 @@ pcon_pid_alive (DWORD pid)
 }
 
 inline static bool
-pcon_pid_self (DWORD pid)
+nat_pipe_owner_self (DWORD pid)
 {
   return (pid == (myself->exec_dwProcessId ?: myself->dwProcessId));
 }
 
+/* This function is called from many pty slave functions. The purpose
+   of this function is cleaning up the nat pipe state which is marked
+   as active but actually not used anymore. This is needed only when
+   non-cygwin process is not terminated cleanly. */
 void
-fhandler_pty_slave::reset_switch_to_pcon (void)
+fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 {
-  if (h_gdb_process)
+  if (h_gdb_inferior)
     {
-      if (WaitForSingleObject (h_gdb_process, 0) == WAIT_TIMEOUT)
+      if (WaitForSingleObject (h_gdb_inferior, 0) == WAIT_TIMEOUT)
 	{
 	  if (isHybrid)
-	    get_ttyp ()->wait_pcon_fwd ();
+	    get_ttyp ()->wait_fwd ();
 	}
       else
 	{
-	  CloseHandle (h_gdb_process);
-	  h_gdb_process = NULL;
+	  CloseHandle (h_gdb_inferior);
+	  h_gdb_inferior = NULL;
 	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
 	      if (get_ttyp ()->getpgid () == myself->pgid
 		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
-		  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
 		{
 		  WaitForSingleObject (input_mutex, mutex_timeout);
 		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
@@ -1147,12 +1155,12 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		   Therefore, never close pseudo console here. */
 		return;
 	      bool need_restore_handles = get_ttyp ()->pcon_activated;
-	      WaitForSingleObject (pcon_mutex, INFINITE);
+	      WaitForSingleObject (pipe_sw_mutex, INFINITE);
 	      if (get_ttyp ()->pcon_activated)
 		close_pseudoconsole (get_ttyp ());
 	      else
 		hand_over_only (get_ttyp ());
-	      ReleaseMutex (pcon_mutex);
+	      ReleaseMutex (pipe_sw_mutex);
 	      if (need_restore_handles)
 		{
 		  pinfo p (get_ttyp ()->master_pid);
@@ -1199,22 +1207,22 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   if (isHybrid)
     return;
-  if (get_ttyp ()->pcon_start)
+  if (get_ttyp ()->pcon_start) /* Pseudo console is initialization on going */
     return;
-  DWORD wait_ret = WaitForSingleObject (pcon_mutex, mutex_timeout);
+  DWORD wait_ret = WaitForSingleObject (pipe_sw_mutex, mutex_timeout);
   if (wait_ret == WAIT_TIMEOUT)
     return;
-  if (!pcon_pid_self (get_ttyp ()->pcon_pid)
-      && pcon_pid_alive (get_ttyp ()->pcon_pid))
+  if (!nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid)
+      && nat_pipe_owner_alive (get_ttyp ()->nat_pipe_owner_pid))
     {
-      /* There is a process which is grabbing pseudo console. */
-      if (!to_be_read_from_pcon ()
-	  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+      /* There is a process which owns nat pipe. */
+      if (!to_be_read_from_nat_pipe ()
+	  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
 	{
 	  if (get_ttyp ()->pcon_activated)
 	    {
-	      HANDLE pcon_owner =
-		OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+	      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					   get_ttyp ()->nat_pipe_owner_pid);
 	      if (pcon_owner)
 		{
 		  pinfo pinfo_resume = pinfo (myself->ppid);
@@ -1231,7 +1239,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 				       GetCurrentProcess (), &h_pcon_in,
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
 		      FreeConsole ();
-		      AttachConsole (get_ttyp ()->pcon_pid);
+		      AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
 		      init_console_handler (false);
 		      WaitForSingleObject (input_mutex, mutex_timeout);
 		      transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
@@ -1245,8 +1253,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		  CloseHandle (pcon_owner);
 		}
 	    }
-	  else if (!get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
-		   && get_ttyp ()->switch_to_pcon_in)
+	  else if (!get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
+		   && get_ttyp ()->switch_to_nat_pipe)
 	    {
 	      WaitForSingleObject (input_mutex, mutex_timeout);
 	      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
@@ -1254,22 +1262,23 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 	      ReleaseMutex (input_mutex);
 	    }
 	}
-      ReleaseMutex (pcon_mutex);
+      ReleaseMutex (pipe_sw_mutex);
       return;
     }
   /* This input transfer is needed if non-cygwin app is terminated
      by Ctrl-C or killed. */
   WaitForSingleObject (input_mutex, mutex_timeout);
-  if (get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated
-      && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+  if (get_ttyp ()->switch_to_nat_pipe && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 		    input_available_event);
   ReleaseMutex (input_mutex);
-  get_ttyp ()->pcon_input_state = tty::to_cyg;
-  get_ttyp ()->pcon_pid = 0;
-  get_ttyp ()->switch_to_pcon_in = false;
+  /* Clean up nat pipe state */
+  get_ttyp ()->pty_input_state = tty::to_cyg;
+  get_ttyp ()->nat_pipe_owner_pid = 0;
+  get_ttyp ()->switch_to_nat_pipe = false;
   get_ttyp ()->pcon_activated = false;
-  ReleaseMutex (pcon_mutex);
+  ReleaseMutex (pipe_sw_mutex);
 }
 
 ssize_t __stdcall
@@ -1285,7 +1294,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   push_process_state process_state (PID_TTYOU);
 
-  reset_switch_to_pcon ();
+  reset_switch_to_nat_pipe ();
 
   acquire_output_mutex (mutex_timeout);
   if (!process_opost_output (get_output_handle (), ptr, towrite, false,
@@ -1308,8 +1317,14 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   return towrite;
 }
 
+/* This function is called from some slave pty reading functions
+   to switch active pipe to cygwin pipe (not nat pipe) temporarily
+   even though there is another process which owns nat pipe. This
+   is needed if cygwin process reads input while another non-cygwin
+   process is running at the same time.
+   (e.g. Something like "cat | non-cygwin-app") */
 void
-fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
+fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 {
   char name[MAX_PATH];
   shared_name (name, TTY_SLAVE_READING, get_minor ());
@@ -1327,8 +1342,8 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
 
   /* This is needed when cygwin-app is started from non-cygwin app if
      pseudo console is disabled. */
-  bool need_xfer = get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
-    && get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
+  bool need_xfer = get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
+    && get_ttyp ()->switch_to_nat_pipe && !get_ttyp ()->pcon_activated;
 
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
@@ -1337,20 +1352,21 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
     isHybrid && GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
   if (!!masked != mask && xfer && (need_gdb_xfer || need_xfer))
     {
-      if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+      if (mask && get_ttyp ()->pty_input_state_eq (tty::to_nat))
 	transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 			input_available_event);
-      else if (!mask && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
+      else if (!mask && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 			input_available_event);
     }
   ReleaseMutex (input_mutex);
 }
 
+/* Return true when the non-cygwin app is reading the input. */
 bool
-fhandler_pty_common::to_be_read_from_pcon (void)
+fhandler_pty_common::to_be_read_from_nat_pipe (void)
 {
-  if (!get_ttyp ()->switch_to_pcon_in)
+  if (!get_ttyp ()->switch_to_nat_pipe)
     return false;
 
   char name[MAX_PATH];
@@ -1365,7 +1381,7 @@ fhandler_pty_common::to_be_read_from_pcon (void)
     /* GDB may set invalid process group for non-cygwin process. */
     return true;
 
-  return get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ());
+  return get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
 }
 
 void __reg3
@@ -1393,8 +1409,8 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 
   if (ptr) /* Indicating not tcflush(). */
     {
-      mask_switch_to_pcon_in (true, true);
-      reset_switch_to_pcon ();
+      mask_switch_to_nat_pipe (true, true);
+      reset_switch_to_nat_pipe ();
     }
 
   if (is_nonblocking () || !ptr) /* Indicating tcflush(). */
@@ -1513,7 +1529,7 @@ wait_retry:
       if (ptr && !bytes_in_pipe && !vmin && !time_to_wait)
 	{
 	  ReleaseMutex (input_mutex);
-	  mask_switch_to_pcon_in (false, false);
+	  mask_switch_to_nat_pipe (false, false);
 	  len = (size_t) bytes_in_pipe;
 	  return;
 	}
@@ -1621,7 +1637,7 @@ out:
   if (ptr0)
     { /* Not tcflush() */
       bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
-      mask_switch_to_pcon_in (false, saw_eol || len == 0);
+      mask_switch_to_nat_pipe (false, saw_eol || len == 0);
     }
 }
 
@@ -1652,7 +1668,7 @@ fhandler_pty_master::dup (fhandler_base *child, int)
 int
 fhandler_pty_slave::tcgetattr (struct termios *t)
 {
-  reset_switch_to_pcon ();
+  reset_switch_to_nat_pipe ();
   *t = get_ttyp ()->ti;
 
   /* Workaround for rlwrap */
@@ -1673,7 +1689,7 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
 int
 fhandler_pty_slave::tcsetattr (int, const struct termios *t)
 {
-  reset_switch_to_pcon ();
+  reset_switch_to_nat_pipe ();
   acquire_output_mutex (mutex_timeout);
   get_ttyp ()->ti = *t;
   release_output_mutex ();
@@ -1687,7 +1703,7 @@ fhandler_pty_slave::tcflush (int queue)
 
   termios_printf ("tcflush(%d) handle %p", queue, get_handle ());
 
-  reset_switch_to_pcon ();
+  reset_switch_to_nat_pipe ();
 
   if (queue == TCIFLUSH || queue == TCIOFLUSH)
     {
@@ -1708,7 +1724,7 @@ int
 fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
 {
   termios_printf ("ioctl (%x)", cmd);
-  reset_switch_to_pcon ();
+  reset_switch_to_nat_pipe ();
   int res = fhandler_termios::ioctl (cmd, arg);
   if (res <= 0)
     return res;
@@ -1781,7 +1797,7 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
 	  || get_ttyp ()->winsize.ws_xpixel != ((struct winsize *) arg)->ws_xpixel
 	 )
 	{
-	  if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid)
+	  if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid)
 	    resize_pseudo_console ((struct winsize *) arg);
 	  get_ttyp ()->arg.winsize = *(struct winsize *) arg;
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
@@ -1903,7 +1919,7 @@ fhandler_pty_slave::fch_open_handles (bool chown)
 				     TRUE, buf);
   output_mutex = get_ttyp ()->open_output_mutex (write_access);
   input_mutex = get_ttyp ()->open_input_mutex (write_access);
-  pcon_mutex = get_ttyp ()->open_mutex (PCON_MUTEX, write_access);
+  pipe_sw_mutex = get_ttyp ()->open_mutex (PIPE_SW_MUTEX, write_access);
   inuse = get_ttyp ()->open_inuse (write_access);
   if (!input_available_event || !output_mutex || !input_mutex || !inuse)
     {
@@ -2057,8 +2073,8 @@ fhandler_pty_common::close ()
 		  get_minor (), get_handle (), get_output_handle ());
   if (!ForceCloseHandle (input_mutex))
     termios_printf ("CloseHandle (input_mutex<%p>), %E", input_mutex);
-  if (!ForceCloseHandle (pcon_mutex))
-    termios_printf ("CloseHandle (pcon_mutex<%p>), %E", pcon_mutex);
+  if (!ForceCloseHandle (pipe_sw_mutex))
+    termios_printf ("CloseHandle (pipe_sw_mutex<%p>), %E", pipe_sw_mutex);
   if (!ForceCloseHandle1 (get_handle (), from_pty))
     termios_printf ("CloseHandle (get_handle ()<%p>), %E", get_handle ());
   if (!ForceCloseHandle1 (get_output_handle (), to_pty))
@@ -2076,7 +2092,7 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
   size.Y = ws->ws_row;
   HPCON_INTERNAL hpcon_local;
   HANDLE pcon_owner =
-    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->nat_pipe_owner_pid);
   DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
 		   GetCurrentProcess (), &hpcon_local.hWritePipe,
 		   0, TRUE, DUPLICATE_SAME_ACCESS);
@@ -2255,8 +2271,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  /* GDB may set WINPID rather than cygwin PID to process group
 	     when the debugged process is a non-cygwin process.*/
 	  pcon_fg |= !pinfo (get_ttyp ()->getpgid ());
-	  if (get_ttyp ()->switch_to_pcon_in && pcon_fg
-	      && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
+	  if (get_ttyp ()->switch_to_nat_pipe && pcon_fg
+	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	    {
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
@@ -2277,8 +2293,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   /* Write terminal input to to_slave_nat pipe instead of output_handle
      if current application is native console application. */
   WaitForSingleObject (input_mutex, mutex_timeout);
-  if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated
-      && get_ttyp ()->pcon_input_state == tty::to_nat)
+  if (to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
+      && get_ttyp ()->pty_input_state == tty::to_nat)
     {
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
@@ -2315,8 +2331,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* This input transfer is needed when cygwin-app which is started from
      non-cygwin app is terminated if pseudo console is disabled. */
-  if (to_be_read_from_pcon () && !get_ttyp ()->pcon_activated
-      && get_ttyp ()->pcon_input_state == tty::to_cyg)
+  if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->pty_input_state == tty::to_cyg)
     fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
 					get_ttyp (), input_available_event);
   ReleaseMutex (input_mutex);
@@ -2399,7 +2415,7 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
 	  || get_ttyp ()->winsize.ws_xpixel != ((struct winsize *) arg)->ws_xpixel
 	 )
 	{
-	  if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid)
+	  if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid)
 	    resize_pseudo_console ((struct winsize *) arg);
 	  get_ttyp ()->winsize = *(struct winsize *) arg;
 	  get_ttyp ()->kill_pgrp (SIGWINCH);
@@ -2473,7 +2489,7 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
 void
 fhandler_pty_slave::fixup_after_exec ()
 {
-  reset_switch_to_pcon ();
+  reset_switch_to_nat_pipe ();
   create_invisible_console ();
 
   if (!close_on_exec ())
@@ -2685,9 +2701,9 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
   termios_printf ("Started.");
   for (;;)
     {
-      p->ttyp->pcon_last_time = GetTickCount ();
+      p->ttyp->fwd_last_time = GetTickCount ();
       DWORD n;
-      p->ttyp->pcon_fwd_not_empty =
+      p->ttyp->fwd_not_empty =
 	::bytes_available (n, p->from_slave_nat) && n;
       if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NULL))
 	{
@@ -2900,6 +2916,7 @@ fhandler_pty_master::setup ()
   SECURITY_ATTRIBUTES sa = { sizeof (SECURITY_ATTRIBUTES), NULL, TRUE };
 
   /* Find an unallocated pty to use. */
+  /* Create a pipe for cygwin app (master to slave) simultaneously. */
   int unit = cygwin_shared->tty.allocate (from_master, get_output_handle ());
   if (unit < 0)
     return false;
@@ -2918,6 +2935,7 @@ fhandler_pty_master::setup ()
     termios_printf ("can't set output_handle(%p) to non-blocking mode",
 		    get_output_handle ());
 
+  /* Pipe for non-cygwin apps (slave to master) */
   char pipename[sizeof ("ptyNNNN-from-master-nat")];
   __small_sprintf (pipename, "pty%d-to-master-nat", unit);
   res = fhandler_pipe::create (&sec_none, &from_slave_nat, &to_master_nat,
@@ -2928,6 +2946,7 @@ fhandler_pty_master::setup ()
       goto err;
     }
 
+  /* Pipe for cygwin apps (slave to master) */
   __small_sprintf (pipename, "pty%d-to-master", unit);
   res = fhandler_pipe::create (&sec_none, &get_handle (), &to_master,
 			       fhandler_pty_common::pipesize, pipename, 0);
@@ -2937,6 +2956,7 @@ fhandler_pty_master::setup ()
       goto err;
     }
 
+  /* Pipe for non-cygwin apps (master to slave) */
   __small_sprintf (pipename, "pty%d-from-master-nat", unit);
   /* FILE_FLAG_OVERLAPPED is specified here in order to prevent
      PeekNamedPipe() from blocking in transfer_input().
@@ -2990,8 +3010,8 @@ fhandler_pty_master::setup ()
   if (!(input_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
-  errstr = shared_name (buf, PCON_MUTEX, unit);
-  if (!(pcon_mutex = CreateMutex (&sa, FALSE, buf)))
+  errstr = shared_name (buf, PIPE_SW_MUTEX, unit);
+  if (!(pipe_sw_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
   if (!attach_mutex)
@@ -3239,8 +3259,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
 	    Sleep (1);
 	}
       /* Attach to the pseudo console which already exits. */
-      HANDLE pcon_owner =
-	OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
       if (pcon_owner == NULL)
 	return false;
       DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
@@ -3251,7 +3271,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
 		       0, TRUE, DUPLICATE_SAME_ACCESS);
       CloseHandle (pcon_owner);
       FreeConsole ();
-      AttachConsole (get_ttyp ()->pcon_pid);
+      AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
       init_console_handler (false);
       goto skip_create;
     }
@@ -3408,10 +3428,10 @@ skip_create:
     }
   while (false);
 
-  if (!pcon_pid_alive (get_ttyp ()->pcon_pid))
-    get_ttyp ()->pcon_pid = myself->exec_dwProcessId;
+  if (!nat_pipe_owner_alive (get_ttyp ()->nat_pipe_owner_pid))
+    get_ttyp ()->nat_pipe_owner_pid = myself->exec_dwProcessId;
 
-  if (hpcon && pcon_pid_self (get_ttyp ()->pcon_pid))
+  if (hpcon && nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
     {
       HPCON_INTERNAL *hp = (HPCON_INTERNAL *) hpcon;
       get_ttyp ()->h_pcon_write_pipe = hp->hWritePipe;
@@ -3506,7 +3526,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       switch_to = force_switch_to;
       ttyp->setpgid (force_switch_to + MAX_PID);
     }
-  else if (pcon_pid_self (ttyp->pcon_pid))
+  else if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       /* Search another native process which attaches to the same console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
@@ -3520,17 +3540,17 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
 void
 fhandler_pty_slave::hand_over_only (tty *ttyp, DWORD force_switch_to)
 {
-  if (pcon_pid_self (ttyp->pcon_pid))
+  if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
       if (switch_to)
 	/* The process switch_to takes over the ownership of the nat pipe. */
-	ttyp->pcon_pid = switch_to;
+	ttyp->nat_pipe_owner_pid = switch_to;
       else
 	{
 	  /* Abandon the ownership of the nat pipe */
-	  ttyp->pcon_pid = 0;
-	  ttyp->switch_to_pcon_in = false;
+	  ttyp->nat_pipe_owner_pid = 0;
+	  ttyp->switch_to_nat_pipe = false;
 	}
     }
 }
@@ -3543,7 +3563,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
   DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
   ttyp->previous_code_page = GetConsoleCP ();
   ttyp->previous_output_code_page = GetConsoleOutputCP ();
-  if (pcon_pid_self (ttyp->pcon_pid))
+  if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     { /* I am owner of the nat pipe. */
       if (switch_to)
 	{
@@ -3578,7 +3598,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  CloseHandle (ttyp->h_pcon_conhost_process);
 	  CloseHandle (ttyp->h_pcon_in);
 	  CloseHandle (ttyp->h_pcon_out);
-	  ttyp->pcon_pid = switch_to;
+	  ttyp->nat_pipe_owner_pid = switch_to;
 	  ttyp->h_pcon_write_pipe = new_write_pipe;
 	  ttyp->h_pcon_condrv_reference = new_condrv_reference;
 	  ttyp->h_pcon_conhost_process = new_conhost_process;
@@ -3608,8 +3628,8 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ClosePseudoConsole ((HPCON) hp);
 	  CloseHandle (ttyp->h_pcon_conhost_process);
 	  ttyp->pcon_activated = false;
-	  ttyp->switch_to_pcon_in = false;
-	  ttyp->pcon_pid = 0;
+	  ttyp->switch_to_nat_pipe = false;
+	  ttyp->nat_pipe_owner_pid = 0;
 	  ttyp->pcon_start = false;
 	  ttyp->pcon_start_pid = 0;
 	}
@@ -3710,7 +3730,7 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     goto maybe_dumb;
 
   /* Check if terminal has CSI6n */
-  WaitForSingleObject (pcon_mutex, INFINITE);
+  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle_nat rather than io_handle. */
@@ -3745,8 +3765,8 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     }
   while (len);
   get_ttyp ()->pcon_activated = false;
-  get_ttyp ()->pcon_pid = 0;
-  ReleaseMutex (pcon_mutex);
+  get_ttyp ()->nat_pipe_owner_pid = 0;
+  ReleaseMutex (pipe_sw_mutex);
   if (len == 0)
     goto not_has_csi6n;
 
@@ -3762,7 +3782,7 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
-  ReleaseMutex (pcon_mutex);
+  ReleaseMutex (pipe_sw_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
@@ -3974,7 +3994,7 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
     ResetEvent (input_available_event);
   else if (transfered)
     SetEvent (input_available_event);
-  ttyp->pcon_input_state = dir;
+  ttyp->pty_input_state = dir;
   ttyp->discard_input = false;
 }
 
@@ -3982,7 +4002,7 @@ void
 fhandler_pty_slave::cleanup_before_exit ()
 {
   if (myself->process_state & PID_NOTCYGWIN)
-    get_ttyp ()->wait_pcon_fwd ();
+    get_ttyp ()->wait_fwd ();
 }
 
 void
@@ -3997,8 +4017,8 @@ fhandler_pty_slave::get_duplicated_handle_set (handle_set_t *p)
   DuplicateHandle (GetCurrentProcess (), input_mutex,
 		   GetCurrentProcess (), &p->input_mutex,
 		   0, 0, DUPLICATE_SAME_ACCESS);
-  DuplicateHandle (GetCurrentProcess (), pcon_mutex,
-		   GetCurrentProcess (), &p->pcon_mutex,
+  DuplicateHandle (GetCurrentProcess (), pipe_sw_mutex,
+		   GetCurrentProcess (), &p->pipe_sw_mutex,
 		   0, 0, DUPLICATE_SAME_ACCESS);
 }
 
@@ -4011,8 +4031,8 @@ fhandler_pty_slave::close_handle_set (handle_set_t *p)
   p->input_available_event = NULL;
   CloseHandle (p->input_mutex);
   p->input_mutex = NULL;
-  CloseHandle (p->pcon_mutex);
-  p->pcon_mutex = NULL;
+  CloseHandle (p->pipe_sw_mutex);
+  p->pipe_sw_mutex = NULL;
 }
 
 void
@@ -4021,24 +4041,24 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
 {
   if (disable_pcon || !term_has_pcon_cap (envblock))
     nopcon = true;
-  WaitForSingleObject (pcon_mutex, INFINITE);
-  /* Setting switch_to_pcon_in is necessary even if pseudo console
+  WaitForSingleObject (pipe_sw_mutex, INFINITE);
+  /* Setting switch_to_nat_pipe is necessary even if pseudo console
      will not be activated. */
   fhandler_base *fh = ::cygheap->fdtab[0];
   if (fh && fh->get_major () == DEV_PTYS_MAJOR)
     {
       fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-      ptys->get_ttyp ()->switch_to_pcon_in = true;
-      if (!pcon_pid_alive (ptys->get_ttyp ()->pcon_pid))
-	ptys->get_ttyp ()->pcon_pid = myself->exec_dwProcessId;
+      ptys->get_ttyp ()->switch_to_nat_pipe = true;
+      if (!nat_pipe_owner_alive (ptys->get_ttyp ()->nat_pipe_owner_pid))
+	ptys->get_ttyp ()->nat_pipe_owner_pid = myself->exec_dwProcessId;
     }
   bool pcon_enabled = false;
   if (!nopcon)
     pcon_enabled = setup_pseudoconsole ();
-  ReleaseMutex (pcon_mutex);
+  ReleaseMutex (pipe_sw_mutex);
   /* For pcon enabled case, transfer_input() is called in master::write() */
   if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
-      && stdin_is_ptys && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
+      && stdin_is_ptys && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
       WaitForSingleObject (input_mutex, mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
@@ -4052,53 +4072,53 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						bool stdin_is_ptys,
 						DWORD force_switch_to)
 {
-  ttyp->wait_pcon_fwd ();
+  ttyp->wait_fwd ();
   if (ttyp->getpgid () == myself->pgid && stdin_is_ptys
-      && ttyp->pcon_input_state_eq (tty::to_nat))
+      && ttyp->pty_input_state_eq (tty::to_nat))
     {
       WaitForSingleObject (p->input_mutex, mutex_timeout);
       transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
 		      p->input_available_event);
       ReleaseMutex (p->input_mutex);
     }
-  WaitForSingleObject (p->pcon_mutex, INFINITE);
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
     hand_over_only (ttyp, force_switch_to);
-  ReleaseMutex (p->pcon_mutex);
+  ReleaseMutex (p->pipe_sw_mutex);
 }
 
 void
 fhandler_pty_slave::setpgid_aux (pid_t pid)
 {
-  WaitForSingleObject (pcon_mutex, INFINITE);
-  bool was_pcon_fg = get_ttyp ()->pcon_fg (tc ()->pgid);
-  bool pcon_fg = get_ttyp ()->pcon_fg (pid);
-  if (!was_pcon_fg && pcon_fg && get_ttyp ()->switch_to_pcon_in
-      && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
+  WaitForSingleObject (pipe_sw_mutex, INFINITE);
+  bool was_nat_fg = get_ttyp ()->nat_fg (tc ()->pgid);
+  bool nat_fg = get_ttyp ()->nat_fg (pid);
+  if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
+      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
       WaitForSingleObject (input_mutex, mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 		      input_available_event);
       ReleaseMutex (input_mutex);
     }
-  else if (was_pcon_fg && !pcon_fg && get_ttyp ()->switch_to_pcon_in
-	   && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+  else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
+	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     {
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
-      if (get_ttyp ()->pcon_activated && get_ttyp ()->pcon_pid
-	  && !get_console_process_id (get_ttyp ()->pcon_pid, true))
+      if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
+	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
 	{
-	  HANDLE pcon_owner =
-	    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					   get_ttyp ()->nat_pipe_owner_pid);
 	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
 			   GetCurrentProcess (), &from,
 			   0, TRUE, DUPLICATE_SAME_ACCESS);
 	  CloseHandle (pcon_owner);
 	  FreeConsole ();
-	  AttachConsole (get_ttyp ()->pcon_pid);
+	  AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
 	  init_console_handler (false);
 	  attach_restore = true;
 	}
@@ -4114,7 +4134,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	  init_console_handler (false);
 	}
     }
-  ReleaseMutex (pcon_mutex);
+  ReleaseMutex (pipe_sw_mutex);
 }
 
 bool
@@ -4124,8 +4144,8 @@ fhandler_pty_master::need_send_ctrl_c_event ()
      apps will be done in pseudo console, therefore, sending it in
      fhandler_pty_master::write() duplicates that event for non-cygwin
      apps. So return false if pseudo console is activated. */
-  return !(to_be_read_from_pcon () && get_ttyp ()->pcon_activated
-    && get_ttyp ()->pcon_input_state == tty::to_nat);
+  return !(to_be_read_from_nat_pipe () && get_ttyp ()->pcon_activated
+    && get_ttyp ()->pty_input_state == tty::to_nat);
 }
 
 void
@@ -4135,11 +4155,11 @@ fhandler_pty_slave::release_ownership_of_nat_pipe (tty *ttyp,
   if (fh->get_major () == DEV_PTYM_MAJOR)
     {
       fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
-      WaitForSingleObject (ptym->pcon_mutex, INFINITE);
+      WaitForSingleObject (ptym->pipe_sw_mutex, INFINITE);
       if (ttyp->pcon_activated)
 	close_pseudoconsole (ttyp);
       else
 	hand_over_only (ttyp);
-      ReleaseMutex (ptym->pcon_mutex);
+      ReleaseMutex (ptym->pipe_sw_mutex);
     }
 }
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index b20cef78f..80a9527dc 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1351,7 +1351,7 @@ peek_pty_slave (select_record *s, bool from_select)
   fhandler_base *fh = (fhandler_base *) s->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 
-  ptys->reset_switch_to_pcon ();
+  ptys->reset_switch_to_nat_pipe ();
 
   if (s->read_selected)
     {
@@ -1437,7 +1437,7 @@ pty_slave_startup (select_record *me, select_stuff *stuff)
   fhandler_base *fh = (fhandler_base *) me->fh;
   fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
   if (me->read_selected)
-    ptys->mask_switch_to_pcon_in (true, true);
+    ptys->mask_switch_to_nat_pipe (true, true);
 
   select_pipe_info *pi = stuff->device_specific_ptys;
   if (pi->start)
@@ -1464,7 +1464,7 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
   if (!pi)
     return;
   if (me->read_selected && pi->start)
-    ptys->mask_switch_to_pcon_in (false, false);
+    ptys->mask_switch_to_nat_pipe (false, false);
   if (pi->thread)
     {
       pi->stop_thread = true;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 25b621227..b2218fef7 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -236,11 +236,11 @@ tty::init ()
   is_console = false;
   column = 0;
   pcon_activated = false;
-  switch_to_pcon_in = false;
-  pcon_pid = 0;
+  switch_to_nat_pipe = false;
+  nat_pipe_owner_pid = 0;
   term_code_page = 0;
-  pcon_last_time = 0;
-  pcon_fwd_not_empty = false;
+  fwd_last_time = 0;
+  fwd_not_empty = false;
   pcon_start = false;
   pcon_start_pid = 0;
   pcon_cap_checked = false;
@@ -251,7 +251,7 @@ tty::init ()
   previous_output_code_page = 0;
   master_is_running_as_service = false;
   req_xfer_input = false;
-  pcon_input_state = to_cyg;
+  pty_input_state = to_cyg;
   last_sig = 0;
   mask_flusho = false;
   discard_input = false;
@@ -313,27 +313,27 @@ tty_min::setpgid (int pid)
 }
 
 void
-tty::wait_pcon_fwd ()
+tty::wait_fwd ()
 {
   /* The forwarding in pseudo console sometimes stops for
      16-32 msec even if it already has data to transfer.
      If the time without transfer exceeds 32 msec, the
-     forwarding is supposed to be finished. pcon_last_time
+     forwarding is supposed to be finished. fwd_last_time
      is reset to GetTickCount() in pty master forwarding
      thread when the last data is transfered. */
-  const int sleep_in_pcon = 16;
-  const int time_to_wait = sleep_in_pcon * 2 + 1/* margine */;
+  const int sleep_in_nat_pipe = 16;
+  const int time_to_wait = sleep_in_nat_pipe * 2 + 1/* margine */;
   int elapsed;
-  while (pcon_fwd_not_empty
-	 || (elapsed = GetTickCount () - pcon_last_time) < time_to_wait)
+  while (fwd_not_empty
+	 || (elapsed = GetTickCount () - fwd_last_time) < time_to_wait)
     {
-      int tw = pcon_fwd_not_empty ? 10 : (time_to_wait - elapsed);
+      int tw = fwd_not_empty ? 10 : (time_to_wait - elapsed);
       cygwait (tw);
     }
 }
 
 bool
-tty::pcon_fg (pid_t pgid)
+tty::nat_fg (pid_t pgid)
 {
   /* Check if the terminal pgid matches with the pgid of the
      non-cygwin process. */
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 87ff43ea2..3a8711039 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -20,7 +20,7 @@ details. */
 #define INPUT_AVAILABLE_EVENT	"cygtty.input.avail"
 #define OUTPUT_MUTEX		"cygtty.output.mutex"
 #define INPUT_MUTEX		"cygtty.input.mutex"
-#define PCON_MUTEX		"cygtty.pcon.mutex"
+#define PIPE_SW_MUTEX		"cygtty.pipe_sw.mutex"
 #define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
 #define TTY_SLAVE_READING	"cygtty.slave_reading"
 
@@ -80,6 +80,10 @@ public:
   const __reg1 char *ttyname () __attribute (());
 };
 
+
+/* The name *nat* comes from 'native' which means non-cygwin
+   (native windows). They are used for non-cygwin process. */
+
 class fhandler_pty_master;
 
 class tty: public tty_min
@@ -112,11 +116,11 @@ private:
   bool pcon_activated;
   bool pcon_start;
   pid_t pcon_start_pid;
-  bool switch_to_pcon_in;
-  DWORD pcon_pid;
+  bool switch_to_nat_pipe;
+  DWORD nat_pipe_owner_pid;
   UINT term_code_page;
-  DWORD pcon_last_time;
-  bool pcon_fwd_not_empty;
+  DWORD fwd_last_time;
+  bool fwd_not_empty;
   HANDLE h_pcon_write_pipe;
   HANDLE h_pcon_condrv_reference;
   HANDLE h_pcon_conhost_process;
@@ -130,7 +134,7 @@ private:
   UINT previous_output_code_page;
   bool master_is_running_as_service;
   bool req_xfer_input;
-  xfer_dir pcon_input_state;
+  xfer_dir pty_input_state;
   bool mask_flusho;
   bool discard_input;
   bool stop_fwd_thread;
@@ -167,9 +171,9 @@ public:
   void set_master_ctl_closed () {master_pid = -1;}
   static void __stdcall create_master (int);
   static void __stdcall init_session ();
-  void wait_pcon_fwd ();
-  bool pcon_input_state_eq (xfer_dir x) { return pcon_input_state == x; }
-  bool pcon_fg (pid_t pgid);
+  void wait_fwd ();
+  bool pty_input_state_eq (xfer_dir x) { return pty_input_state == x; }
+  bool nat_fg (pid_t pgid);
   friend class fhandler_pty_common;
   friend class fhandler_pty_master;
   friend class fhandler_pty_slave;
-- 
2.35.1

