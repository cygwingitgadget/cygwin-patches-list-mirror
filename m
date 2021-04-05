Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 423B13857C4C
 for <cygwin-patches@cygwin.com>; Mon,  5 Apr 2021 08:31:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 423B13857C4C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1358UplH019574;
 Mon, 5 Apr 2021 17:30:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1358UplH019574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1617611458;
 bh=E5qUZ+Ljl+V4laLaq83pGInWy/PTwHPBYModZf/0oVw=;
 h=From:To:Cc:Subject:Date:From;
 b=vEUhvHkmhHlZ8U2j6Ciaxfyk75cHO0UNNyQGtg7Ea49uK3FRx+GqMj3g2fiMgs0r/
 hXrIEhAMIpwMCtdxoaEqcKU2bsOQcvYA88nL6voJS4jkMp09SfL6wzZl45Hu7BQuYr
 eWXBmpKxsKxrFBUbW0Ui50a8PpJoTHA+Qj3eFNCbOnUnQ7K36XeJvTQ1t6osVwL+aN
 lOPV2KNvEMFFWDusFxmwCEGcG373xC+Stub6aq2HwE4053EsjoCRitLHOiJDPxHi3Z
 Kvmh021DIghSUkY7fH5FwjIG2GSeWQFUa65SOTovXhwKJgDABLzFPrrpzpl9Fs96hf
 jFXyRv0aUzS5Q==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fhandler: Rename handles from XXX_cyg/XXX to
 XXX/XXX_nat.
Date: Mon,  5 Apr 2021 17:30:41 +0900
Message-Id: <20210405083041.880-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_OBF,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 05 Apr 2021 08:31:24 -0000

- Currently, functions/variables regarding the handles for cygwin
  apps are with "_cyg", and those of handles for non-cygwin apps
  are without "_cyg", such as get_handle_cyg() and get_handle().
  This patch renames these to the names without "_nat" and with
  "_nat" respectively, such as get_handle() and get_handle_nat().
---
 winsup/cygwin/fhandler.h      |  30 +--
 winsup/cygwin/fhandler_tty.cc | 350 ++++++++++++++++------------------
 winsup/cygwin/select.cc       |  22 +--
 winsup/cygwin/spawn.cc        |  24 +--
 winsup/cygwin/tty.cc          |   4 +-
 winsup/cygwin/tty.h           |  18 +-
 6 files changed, 215 insertions(+), 233 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4da35b7f5..15fbd09b0 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -456,9 +456,9 @@ public:
   /* Virtual accessor functions to hide the fact
      that some fd's have two handles. */
   virtual HANDLE& get_handle () { return io_handle; }
-  virtual HANDLE& get_handle_cyg () { return io_handle; }
+  virtual HANDLE& get_handle_nat () { return io_handle; }
   virtual HANDLE& get_output_handle () { return io_handle; }
-  virtual HANDLE& get_output_handle_cyg () { return io_handle; }
+  virtual HANDLE& get_output_handle_nat () { return io_handle; }
   virtual HANDLE get_stat_handle () { return pc.handle () ?: io_handle; }
   virtual HANDLE get_echo_handle () const { return NULL; }
   virtual bool hit_eof () {return false;}
@@ -1931,7 +1931,7 @@ class fhandler_termios: public fhandler_base
     need_fork_fixup (true);
   }
   HANDLE& get_output_handle () { return output_handle; }
-  HANDLE& get_output_handle_cyg () { return output_handle; }
+  HANDLE& get_output_handle_nat () { return output_handle; }
   line_edit_status line_edit (const char *rptr, size_t nread, termios&,
 			      ssize_t *bytes_read = NULL);
   void set_output_handle (HANDLE h) { output_handle = h; }
@@ -2314,7 +2314,7 @@ class fhandler_pty_common: public fhandler_termios
 class fhandler_pty_slave: public fhandler_pty_common
 {
   HANDLE inuse;			// used to indicate that a tty is in use
-  HANDLE output_handle_cyg, io_handle_cyg;
+  HANDLE output_handle_nat, io_handle_nat;
   HANDLE slave_reading;
   LONG num_reader;
 
@@ -2327,10 +2327,10 @@ class fhandler_pty_slave: public fhandler_pty_common
   /* Constructor */
   fhandler_pty_slave (int);
 
-  void set_output_handle_cyg (HANDLE h) { output_handle_cyg = h; }
-  HANDLE& get_output_handle_cyg () { return output_handle_cyg; }
-  void set_handle_cyg (HANDLE h) { io_handle_cyg = h; }
-  HANDLE& get_handle_cyg () { return io_handle_cyg; }
+  void set_output_handle_nat (HANDLE h) { output_handle_nat = h; }
+  HANDLE& get_output_handle_nat () { return output_handle_nat; }
+  void set_handle_nat (HANDLE h) { io_handle_nat = h; }
+  HANDLE& get_handle_nat () { return io_handle_nat; }
 
   int open (int flags, mode_t mode = 0);
   void open_setup (int flags);
@@ -2394,19 +2394,19 @@ class fhandler_pty_master: public fhandler_pty_common
 public:
   /* Parameter set for the static function pty_master_thread() */
   struct master_thread_param_t {
+    HANDLE from_master_nat;
     HANDLE from_master;
-    HANDLE from_master_cyg;
+    HANDLE to_master_nat;
     HANDLE to_master;
-    HANDLE to_master_cyg;
+    HANDLE to_slave_nat;
     HANDLE to_slave;
-    HANDLE to_slave_cyg;
     HANDLE master_ctl;
     HANDLE input_available_event;
   };
   /* Parameter set for the static function pty_master_fwd_thread() */
   struct master_fwd_thread_param_t {
-    HANDLE to_master_cyg;
-    HANDLE from_slave;
+    HANDLE to_master;
+    HANDLE from_slave_nat;
     HANDLE output_mutex;
     tty *ttyp;
   };
@@ -2414,10 +2414,10 @@ private:
   int pktmode;			// non-zero if pty in a packet mode.
   HANDLE master_ctl;		// Control socket for handle duplication
   cygthread *master_thread;	// Master control thread
-  HANDLE from_master, to_master, from_slave, to_slave;
+  HANDLE from_master_nat, to_master_nat, from_slave_nat, to_slave_nat;
   HANDLE echo_r, echo_w;
   DWORD dwProcessId;		// Owner of master handles
-  HANDLE to_master_cyg, from_master_cyg;
+  HANDLE to_master, from_master;
   cygthread *master_fwd_thread;	// Master forwarding thread
   HANDLE thread_param_copied_event;
 
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index d755f7d87..12247dd99 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -53,12 +53,12 @@ struct pipe_request {
 };
 
 struct pipe_reply {
+  HANDLE from_master_nat;
   HANDLE from_master;
-  HANDLE from_master_cyg;
+  HANDLE to_master_nat;
   HANDLE to_master;
-  HANDLE to_master_cyg;
+  HANDLE to_slave_nat;
   HANDLE to_slave;
-  HANDLE to_slave_cyg;
   DWORD error;
 };
 
@@ -140,16 +140,11 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
   if (!iscygwin && ptys_pcon)
     ptys_pcon->set_switch_to_pcon ();
   if (replace_in)
-    {
-      if (iscygwin && ptys_pcon->pcon_activated ())
-	*in = replace_in->get_handle_cyg ();
-      else
-	*in = replace_in->get_handle ();
-    }
+    *in = replace_in->get_handle_nat ();
   if (replace_out)
-    *out = replace_out->get_output_handle ();
+    *out = replace_out->get_output_handle_nat ();
   if (replace_err)
-    *err = replace_err->get_output_handle ();
+    *err = replace_err->get_output_handle_nat ();
 }
 
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
@@ -283,7 +278,7 @@ exit_Hooked (int e)
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	    tty *ttyp = ptys->get_ttyp ();
-	    HANDLE from = ptys->get_handle ();
+	    HANDLE from = ptys->get_handle_nat ();
 	    HANDLE input_available_event = ptys->get_input_available_event ();
 	    if (ttyp->getpgid () == myself->pgid
 		&& GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ()
@@ -372,7 +367,7 @@ bytes_available (DWORD& n, HANDLE h)
 bool
 fhandler_pty_common::bytes_available (DWORD &n)
 {
-  return ::bytes_available (n, get_handle_cyg ());
+  return ::bytes_available (n, get_handle ());
 }
 
 #ifdef DEBUGGING
@@ -402,8 +397,8 @@ fhandler_pty_master::discard_input ()
   DWORD n;
 
   WaitForSingleObject (input_mutex, INFINITE);
-  while (::bytes_available (bytes_in_pipe, from_master_cyg) && bytes_in_pipe)
-    ReadFile (from_master_cyg, buf, sizeof(buf), &n, NULL);
+  while (::bytes_available (bytes_in_pipe, from_master) && bytes_in_pipe)
+    ReadFile (from_master, buf, sizeof(buf), &n, NULL);
   ResetEvent (input_available_event);
   get_ttyp ()->discard_input = true;
   ReleaseMutex (input_mutex);
@@ -488,7 +483,7 @@ fhandler_pty_master::accept_input ()
   if (to_be_read_from_pcon ()
       && get_ttyp ()->pcon_input_state == tty::to_nat)
     {
-      write_to = to_slave;
+      write_to = to_slave_nat;
 
       UINT cp_to;
       pinfo pinfo_target = pinfo (get_ttyp ()->invisible_console_pid);
@@ -719,8 +714,8 @@ out:
 /* pty slave stuff */
 
 fhandler_pty_slave::fhandler_pty_slave (int unit)
-  : fhandler_pty_common (), inuse (NULL), output_handle_cyg (NULL),
-  io_handle_cyg (NULL), slave_reading (NULL), num_reader (0)
+  : fhandler_pty_common (), inuse (NULL), output_handle_nat (NULL),
+  io_handle_nat (NULL), slave_reading (NULL), num_reader (0)
 {
   if (unit >= 0)
     dev ().parse (DEV_PTYS_MAJOR, unit);
@@ -730,13 +725,13 @@ int
 fhandler_pty_slave::open (int flags, mode_t)
 {
   HANDLE pty_owner;
-  HANDLE from_master_local, from_master_cyg_local;
-  HANDLE to_master_local, to_master_cyg_local;
+  HANDLE from_master_nat_local, from_master_local;
+  HANDLE to_master_nat_local, to_master_local;
   HANDLE *handles[] =
   {
-    &from_master_local, &input_available_event, &input_mutex, &inuse,
-    &output_mutex, &to_master_local, &pty_owner, &to_master_cyg_local,
-    &from_master_cyg_local, &pcon_mutex,
+    &from_master_nat_local, &input_available_event, &input_mutex, &inuse,
+    &output_mutex, &to_master_nat_local, &pty_owner, &to_master_local,
+    &from_master_local, &pcon_mutex,
     NULL
   };
 
@@ -793,8 +788,8 @@ fhandler_pty_slave::open (int flags, mode_t)
     release_output_mutex ();
   }
 
-  if (!get_ttyp ()->from_master () || !get_ttyp ()->from_master_cyg ()
-      || !get_ttyp ()->to_master () || !get_ttyp ()->to_master_cyg ())
+  if (!get_ttyp ()->from_master_nat () || !get_ttyp ()->from_master ()
+      || !get_ttyp ()->to_master_nat () || !get_ttyp ()->to_master ())
     {
       errmsg = "pty handles have been closed";
       set_errno (EACCES);
@@ -829,34 +824,40 @@ fhandler_pty_slave::open (int flags, mode_t)
     }
   if (pty_owner)
     {
-      if (!DuplicateHandle (pty_owner, get_ttyp ()->from_master (),
-			    GetCurrentProcess (), &from_master_local, 0, TRUE,
+      if (!DuplicateHandle (pty_owner, get_ttyp ()->from_master_nat (),
+			    GetCurrentProcess (),
+			    &from_master_nat_local, 0, TRUE,
 			    DUPLICATE_SAME_ACCESS))
 	{
 	  termios_printf ("can't duplicate input from %u/%p, %E",
-			  get_ttyp ()->master_pid, get_ttyp ()->from_master ());
+			  get_ttyp ()->master_pid,
+			  get_ttyp ()->from_master_nat ());
 	  __seterrno ();
 	  goto err_no_msg;
 	}
-      if (!DuplicateHandle (pty_owner, get_ttyp ()->from_master_cyg (),
-			    GetCurrentProcess (), &from_master_cyg_local, 0, TRUE,
+      if (!DuplicateHandle (pty_owner, get_ttyp ()->from_master (),
+			    GetCurrentProcess (),
+			    &from_master_local, 0, TRUE,
 			    DUPLICATE_SAME_ACCESS))
 	{
 	  termios_printf ("can't duplicate input from %u/%p, %E",
-			  get_ttyp ()->master_pid, get_ttyp ()->from_master_cyg ());
+			  get_ttyp ()->master_pid,
+			  get_ttyp ()->from_master ());
 	  __seterrno ();
 	  goto err_no_msg;
 	}
-      if (!DuplicateHandle (pty_owner, get_ttyp ()->to_master (),
-			  GetCurrentProcess (), &to_master_local, 0, TRUE,
+      if (!DuplicateHandle (pty_owner, get_ttyp ()->to_master_nat (),
+			  GetCurrentProcess (),
+			  &to_master_nat_local, 0, TRUE,
 			  DUPLICATE_SAME_ACCESS))
 	{
 	  errmsg = "can't duplicate output, %E";
 	  goto err;
 	}
-      if (!DuplicateHandle (pty_owner, get_ttyp ()->to_master_cyg (),
-			  GetCurrentProcess (), &to_master_cyg_local, 0, TRUE,
-			  DUPLICATE_SAME_ACCESS))
+      if (!DuplicateHandle (pty_owner, get_ttyp ()->to_master (),
+			    GetCurrentProcess (),
+			    &to_master_local, 0, TRUE,
+			    DUPLICATE_SAME_ACCESS))
 	{
 	  errmsg = "can't duplicate output for cygwin, %E";
 	  goto err;
@@ -879,36 +880,36 @@ fhandler_pty_slave::open (int flags, mode_t)
 	  errmsg = "can't call master, %E";
 	  goto err;
 	}
+      from_master_nat_local = repl.from_master_nat;
       from_master_local = repl.from_master;
-      from_master_cyg_local = repl.from_master_cyg;
+      to_master_nat_local = repl.to_master_nat;
       to_master_local = repl.to_master;
-      to_master_cyg_local = repl.to_master_cyg;
-      if (!from_master_local || !from_master_cyg_local
-	  || !to_master_local || !to_master_cyg_local)
+      if (!from_master_nat_local || !from_master_local
+	  || !to_master_nat_local || !to_master_local)
 	{
 	  SetLastError (repl.error);
 	  errmsg = "error duplicating pipes, %E";
 	  goto err;
 	}
     }
+  VerifyHandle (from_master_nat_local);
   VerifyHandle (from_master_local);
-  VerifyHandle (from_master_cyg_local);
+  VerifyHandle (to_master_nat_local);
   VerifyHandle (to_master_local);
-  VerifyHandle (to_master_cyg_local);
 
+  termios_printf ("duplicated from_master_nat %p->%p from pty_owner",
+		  get_ttyp ()->from_master_nat (), from_master_nat_local);
   termios_printf ("duplicated from_master %p->%p from pty_owner",
 		  get_ttyp ()->from_master (), from_master_local);
-  termios_printf ("duplicated from_master_cyg %p->%p from pty_owner",
-		  get_ttyp ()->from_master_cyg (), from_master_cyg_local);
+  termios_printf ("duplicated to_master_nat %p->%p from pty_owner",
+		  get_ttyp ()->to_master_nat (), to_master_nat_local);
   termios_printf ("duplicated to_master %p->%p from pty_owner",
 		  get_ttyp ()->to_master (), to_master_local);
-  termios_printf ("duplicated to_master_cyg %p->%p from pty_owner",
-		  get_ttyp ()->to_master_cyg (), to_master_cyg_local);
 
+  set_handle_nat (from_master_nat_local);
   set_handle (from_master_local);
-  set_handle_cyg (from_master_cyg_local);
+  set_output_handle_nat (to_master_nat_local);
   set_output_handle (to_master_local);
-  set_output_handle_cyg (to_master_cyg_local);
 
   if (_major (myself->ctty) == DEV_CONS_MAJOR
       && !(!pinfo (myself->ppid) && getenv ("ConEmuPID")))
@@ -971,12 +972,12 @@ fhandler_pty_slave::close ()
     termios_printf ("CloseHandle (inuse), %E");
   if (!ForceCloseHandle (input_available_event))
     termios_printf ("CloseHandle (input_available_event<%p>), %E", input_available_event);
-  if (!ForceCloseHandle (get_output_handle_cyg ()))
-    termios_printf ("CloseHandle (get_output_handle_cyg ()<%p>), %E",
-	get_output_handle_cyg ());
-  if (!ForceCloseHandle (get_handle_cyg ()))
-    termios_printf ("CloseHandle (get_handle_cyg ()<%p>), %E",
-	get_handle_cyg ());
+  if (!ForceCloseHandle (get_output_handle_nat ()))
+    termios_printf ("CloseHandle (get_output_handle_nat ()<%p>), %E",
+	get_output_handle_nat ());
+  if (!ForceCloseHandle (get_handle_nat ()))
+    termios_printf ("CloseHandle (get_handle_nat ()<%p>), %E",
+	get_handle_nat ());
   if ((unsigned) myself->ctty == FHDEV (DEV_PTYS_MAJOR, get_minor ()))
     fhandler_console::free_console ();	/* assumes that we are the last pty closer */
   fhandler_pty_common::close ();
@@ -1042,7 +1043,7 @@ fhandler_pty_slave::set_switch_to_pcon (void)
 	  && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
 	{
 	  WaitForSingleObject (input_mutex, INFINITE);
-	  transfer_input (tty::to_nat, get_handle_cyg (), get_ttyp (),
+	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 			  input_available_event);
 	  ReleaseMutex (input_mutex);
 	}
@@ -1070,7 +1071,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 		{
 		  WaitForSingleObject (input_mutex, INFINITE);
-		  transfer_input (tty::to_cyg, get_handle (), get_ttyp (),
+		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 				  input_available_event);
 		  ReleaseMutex (input_mutex);
 		}
@@ -1089,23 +1090,18 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		  pinfo p (get_ttyp ()->master_pid);
 		  HANDLE pty_owner =
 		    OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
-		  bool fix_in, fix_out, fix_err;
-		  fix_in =
-		    GetStdHandle (STD_INPUT_HANDLE) == get_handle ();
-		  fix_out =
-		    GetStdHandle (STD_OUTPUT_HANDLE) == get_output_handle ();
-		  fix_err =
-		    GetStdHandle (STD_ERROR_HANDLE) == get_output_handle ();
 		  if (pty_owner)
 		    {
-		      CloseHandle (get_handle ());
-		      DuplicateHandle (pty_owner, get_ttyp ()->from_master (),
-				       GetCurrentProcess (), &get_handle (),
+		      CloseHandle (get_handle_nat ());
+		      DuplicateHandle (pty_owner,
+				       get_ttyp ()->from_master_nat (),
+				       GetCurrentProcess (), &get_handle_nat (),
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
-		      CloseHandle (get_output_handle ());
-		      DuplicateHandle (pty_owner, get_ttyp ()->to_master (),
+		      CloseHandle (get_output_handle_nat ());
+		      DuplicateHandle (pty_owner,
+				       get_ttyp ()->to_master_nat (),
 				       GetCurrentProcess (),
-				       &get_output_handle (),
+				       &get_output_handle_nat (),
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
 		      CloseHandle (pty_owner);
 		    }
@@ -1121,17 +1117,11 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 		      if (!CallNamedPipe (pipe, &req, sizeof req,
 					  &repl, sizeof repl, &len, 500))
 			return; /* What can we do? */
-		      CloseHandle (get_handle ());
-		      set_handle (repl.from_master);
-		      CloseHandle (get_output_handle ());
-		      set_output_handle (repl.to_master);
+		      CloseHandle (get_handle_nat ());
+		      set_handle_nat (repl.from_master_nat);
+		      CloseHandle (get_output_handle_nat ());
+		      set_output_handle_nat (repl.to_master_nat);
 		    }
-		  if (fix_in)
-		    SetStdHandle (STD_INPUT_HANDLE, get_handle ());
-		  if (fix_out)
-		    SetStdHandle (STD_OUTPUT_HANDLE, get_output_handle ());
-		  if (fix_err)
-		    SetStdHandle (STD_ERROR_HANDLE, get_output_handle ());
 		}
 	      myself->exec_dwProcessId = 0;
 	      isHybrid = false;
@@ -1170,7 +1160,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   reset_switch_to_pcon ();
 
   acquire_output_mutex (INFINITE);
-  if (!process_opost_output (get_output_handle_cyg (), ptr, towrite, false,
+  if (!process_opost_output (get_output_handle (), ptr, towrite, false,
 			     get_ttyp (), is_nonblocking ()))
     {
       DWORD err = GetLastError ();
@@ -1215,14 +1205,14 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
       if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	{
 	  WaitForSingleObject (input_mutex, INFINITE);
-	  transfer_input (tty::to_cyg, get_handle (), get_ttyp (),
+	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 			  input_available_event);
 	  ReleaseMutex (input_mutex);
 	}
       else if (!mask && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
 	{
 	  WaitForSingleObject (input_mutex, INFINITE);
-	  transfer_input (tty::to_nat, get_handle_cyg (), get_ttyp (),
+	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 			  input_available_event);
 	  ReleaseMutex (input_mutex);
 	}
@@ -1269,7 +1259,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
       return;
     }
 
-  termios_printf ("read(%p, %lu) handle %p", ptr, len, get_handle_cyg ());
+  termios_printf ("read(%p, %lu) handle %p", ptr, len, get_handle ());
 
   push_process_state process_state (PID_TTYIN);
 
@@ -1416,7 +1406,7 @@ wait_retry:
       if (readlen)
 	{
 	  termios_printf ("reading %lu bytes (vtime %d)", readlen, vtime);
-	  if (!ReadFile (get_handle_cyg (), buf, readlen, &n, NULL))
+	  if (!ReadFile (get_handle (), buf, readlen, &n, NULL))
 	    {
 	      termios_printf ("read failed, %E");
 	      ReleaseMutex (input_mutex);
@@ -1567,7 +1557,7 @@ fhandler_pty_slave::tcflush (int queue)
 {
   int ret = 0;
 
-  termios_printf ("tcflush(%d) handle %p", queue, get_handle_cyg ());
+  termios_printf ("tcflush(%d) handle %p", queue, get_handle ());
 
   reset_switch_to_pcon ();
 
@@ -1892,9 +1882,9 @@ errout:
 */
 fhandler_pty_master::fhandler_pty_master (int unit)
   : fhandler_pty_common (), pktmode (0), master_ctl (NULL),
-    master_thread (NULL), from_master (NULL), to_master (NULL),
-    from_slave (NULL), to_slave (NULL), echo_r (NULL), echo_w (NULL),
-    dwProcessId (0), to_master_cyg (NULL), from_master_cyg (NULL),
+    master_thread (NULL), from_master_nat (NULL), to_master_nat (NULL),
+    from_slave_nat (NULL), to_slave_nat (NULL), echo_r (NULL), echo_w (NULL),
+    dwProcessId (0), to_master (NULL), from_master (NULL),
     master_fwd_thread (NULL)
 {
   if (unit >= 0)
@@ -1973,8 +1963,8 @@ fhandler_pty_master::cleanup ()
 {
   report_tty_counts (this, "closing master", "");
   if (archetype)
-    from_master = from_master_cyg =
-      to_master = to_master_cyg = from_slave = to_slave = NULL;
+    from_master_nat = from_master =
+      to_master_nat = to_master = from_slave_nat = to_slave_nat = NULL;
   fhandler_base::cleanup ();
 }
 
@@ -1984,9 +1974,9 @@ fhandler_pty_master::close ()
   OBJECT_BASIC_INFORMATION obi;
   NTSTATUS status;
 
-  termios_printf ("closing from_master(%p)/from_master_cyg(%p)/to_master(%p)/to_master_cyg(%p) since we own them(%u)",
-		  from_master, from_master_cyg,
-		  to_master, to_master_cyg, dwProcessId);
+  termios_printf ("closing from_master_nat(%p)/from_master(%p)/to_master_nat(%p)/to_master(%p) since we own them(%u)",
+		  from_master_nat, from_master,
+		  to_master_nat, to_master, dwProcessId);
   if (cygwin_finished_initializing)
     {
       if (master_ctl && get_ttyp ()->master_pid == myself->pid)
@@ -2033,25 +2023,25 @@ fhandler_pty_master::close ()
       SetEvent (input_available_event);
     }
 
+  if (!ForceCloseHandle (from_master_nat))
+    termios_printf ("error closing from_master_nat %p, %E", from_master_nat);
   if (!ForceCloseHandle (from_master))
     termios_printf ("error closing from_master %p, %E", from_master);
-  if (!ForceCloseHandle (from_master_cyg))
-    termios_printf ("error closing from_master_cyg %p, %E", from_master_cyg);
+  if (!ForceCloseHandle (to_master_nat))
+    termios_printf ("error closing to_master_nat %p, %E", to_master_nat);
+  from_master_nat = to_master_nat = NULL;
+  if (!ForceCloseHandle (from_slave_nat))
+    termios_printf ("error closing from_slave_nat %p, %E", from_slave_nat);
+  from_slave_nat = NULL;
   if (!ForceCloseHandle (to_master))
     termios_printf ("error closing to_master %p, %E", to_master);
-  from_master = to_master = NULL;
-  if (!ForceCloseHandle (from_slave))
-    termios_printf ("error closing from_slave %p, %E", from_slave);
-  from_slave = NULL;
-  if (!ForceCloseHandle (to_master_cyg))
-    termios_printf ("error closing to_master_cyg %p, %E", to_master_cyg);
-  to_master_cyg = from_master_cyg = NULL;
+  to_master = from_master = NULL;
   ForceCloseHandle (echo_r);
   ForceCloseHandle (echo_w);
   echo_r = echo_w = NULL;
-  if (to_slave)
-    ForceCloseHandle (to_slave);
-  to_slave = NULL;
+  if (to_slave_nat)
+    ForceCloseHandle (to_slave_nat);
+  to_slave_nat = NULL;
 
   if (have_execed || get_ttyp ()->master_pid != myself->pid)
     termios_printf ("not clearing: %d, master_pid %d",
@@ -2105,7 +2095,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      else
 		{
 		  if (!get_ttyp ()->req_xfer_input)
-		    WriteFile (to_slave, wpbuf, ixput, &n, NULL);
+		    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
 		  ixput = 0;
 		  wpbuf[ixput++] = p[i];
 		}
@@ -2118,7 +2108,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       if (state == 2)
 	{
 	  if (!get_ttyp ()->req_xfer_input)
-	    WriteFile (to_slave, wpbuf, ixput, &n, NULL);
+	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
 	  ixput = 0;
 	  state = 0;
 	  get_ttyp ()->req_xfer_input = false;
@@ -2141,7 +2131,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      if (get_readahead_valid ())
 		accept_input ();
 	      WaitForSingleObject (input_mutex, INFINITE);
-	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master_cyg,
+	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
 						  get_ttyp (),
 						  input_available_event);
 	      ReleaseMutex (input_mutex);
@@ -2152,7 +2142,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       return len;
     }
 
-  /* Write terminal input to to_slave pipe instead of output_handle
+  /* Write terminal input to to_slave_nat pipe instead of output_handle
      if current application is native console application. */
   if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated
       && get_ttyp ()->pcon_input_state == tty::to_nat)
@@ -2175,7 +2165,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  && memchr (buf, '\003', nlen))
 	get_ttyp ()->discard_input = true;
       DWORD n;
-      WriteFile (to_slave, buf, nlen, &n, NULL);
+      WriteFile (to_slave_nat, buf, nlen, &n, NULL);
       ReleaseMutex (input_mutex);
 
       return len;
@@ -2456,6 +2446,13 @@ fhandler_pty_master::pty_master_thread (const master_thread_param_t *p)
 	      termios_printf ("OpenProcess, %E");
 	      goto reply;
 	    }
+	  if (!DuplicateHandle (GetCurrentProcess (), p->from_master_nat,
+			       client, &repl.from_master_nat,
+			       0, TRUE, DUPLICATE_SAME_ACCESS))
+	    {
+	      termios_printf ("DuplicateHandle (from_master_nat), %E");
+	      goto reply;
+	    }
 	  if (!DuplicateHandle (GetCurrentProcess (), p->from_master,
 			       client, &repl.from_master,
 			       0, TRUE, DUPLICATE_SAME_ACCESS))
@@ -2463,11 +2460,11 @@ fhandler_pty_master::pty_master_thread (const master_thread_param_t *p)
 	      termios_printf ("DuplicateHandle (from_master), %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), p->from_master_cyg,
-			       client, &repl.from_master_cyg,
-			       0, TRUE, DUPLICATE_SAME_ACCESS))
+	  if (!DuplicateHandle (GetCurrentProcess (), p->to_master_nat,
+				client, &repl.to_master_nat,
+				0, TRUE, DUPLICATE_SAME_ACCESS))
 	    {
-	      termios_printf ("DuplicateHandle (from_master_cyg), %E");
+	      termios_printf ("DuplicateHandle (to_master_nat), %E");
 	      goto reply;
 	    }
 	  if (!DuplicateHandle (GetCurrentProcess (), p->to_master,
@@ -2477,11 +2474,11 @@ fhandler_pty_master::pty_master_thread (const master_thread_param_t *p)
 	      termios_printf ("DuplicateHandle (to_master), %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), p->to_master_cyg,
-				client, &repl.to_master_cyg,
+	  if (!DuplicateHandle (GetCurrentProcess (), p->to_slave_nat,
+				client, &repl.to_slave_nat,
 				0, TRUE, DUPLICATE_SAME_ACCESS))
 	    {
-	      termios_printf ("DuplicateHandle (to_master_cyg), %E");
+	      termios_printf ("DuplicateHandle (to_slave_nat), %E");
 	      goto reply;
 	    }
 	  if (!DuplicateHandle (GetCurrentProcess (), p->to_slave,
@@ -2491,13 +2488,6 @@ fhandler_pty_master::pty_master_thread (const master_thread_param_t *p)
 	      termios_printf ("DuplicateHandle (to_slave), %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), p->to_slave_cyg,
-				client, &repl.to_slave_cyg,
-				0, TRUE, DUPLICATE_SAME_ACCESS))
-	    {
-	      termios_printf ("DuplicateHandle (to_slave_cyg), %E");
-	      goto reply;
-	    }
 	}
 reply:
       repl.error = GetLastError ();
@@ -2507,7 +2497,7 @@ reply:
 	cygheap->user.reimpersonate ();
       sd.free ();
       termios_printf ("Reply: from %p, to %p, error %u",
-		      repl.from_master, repl.to_master, repl.error );
+		      repl.from_master_nat, repl.to_master_nat, repl.error );
       if (!WriteFile (p->master_ctl, &repl, sizeof repl, &len, NULL))
 	termios_printf ("WriteFile, %E");
       if (!DisconnectNamedPipe (p->master_ctl))
@@ -2545,7 +2535,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
   for (;;)
     {
       p->ttyp->pcon_last_time = GetTickCount ();
-      if (!ReadFile (p->from_slave, outbuf, NT_MAX_PATH, &rlen, NULL))
+      if (!ReadFile (p->from_slave_nat, outbuf, NT_MAX_PATH, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
@@ -2659,11 +2649,11 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	    }
 
 	  /* OPOST processing was already done in pseudo console,
-	     so just write it to to_master_cyg. */
+	     so just write it to to_master. */
 	  DWORD written;
 	  while (rlen>0)
 	    {
-	      if (!WriteFile (p->to_master_cyg, ptr, wlen, &written, NULL))
+	      if (!WriteFile (p->to_master, ptr, wlen, &written, NULL))
 		{
 		  termios_printf ("WriteFile for forwarding failed, %E");
 		  break;
@@ -2713,7 +2703,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
       WaitForSingleObject (p->output_mutex, INFINITE);
       while (rlen>0)
 	{
-	  if (!process_opost_output (p->to_master_cyg, ptr, wlen, false,
+	  if (!process_opost_output (p->to_master, ptr, wlen, false,
 				     p->ttyp, false))
 	    {
 	      termios_printf ("WriteFile for forwarding failed, %E");
@@ -2750,7 +2740,7 @@ fhandler_pty_master::setup ()
   SECURITY_ATTRIBUTES sa = { sizeof (SECURITY_ATTRIBUTES), NULL, TRUE };
 
   /* Find an unallocated pty to use. */
-  int unit = cygwin_shared->tty.allocate (from_master_cyg, get_output_handle ());
+  int unit = cygwin_shared->tty.allocate (from_master, get_output_handle ());
   if (unit < 0)
     return false;
 
@@ -2770,7 +2760,7 @@ fhandler_pty_master::setup ()
 
   char pipename[sizeof ("ptyNNNN-from-master-nat")];
   __small_sprintf (pipename, "pty%d-to-master-nat", unit);
-  res = fhandler_pipe::create (&sec_none, &from_slave, &to_master,
+  res = fhandler_pipe::create (&sec_none, &from_slave_nat, &to_master_nat,
 			       fhandler_pty_common::pipesize, pipename, 0);
   if (res)
     {
@@ -2779,7 +2769,7 @@ fhandler_pty_master::setup ()
     }
 
   __small_sprintf (pipename, "pty%d-to-master", unit);
-  res = fhandler_pipe::create (&sec_none, &get_handle (), &to_master_cyg,
+  res = fhandler_pipe::create (&sec_none, &get_handle (), &to_master,
 			       fhandler_pty_common::pipesize, pipename, 0);
   if (res)
     {
@@ -2794,7 +2784,7 @@ fhandler_pty_master::setup ()
      opened with FILE_FLAG_OVERLAPPED, it is mandatory to pass the
      OVERLAPP structure, but in fact, it seems that the access will
      fallback to the blocking access if it is not specified. */
-  res = fhandler_pipe::create (&sec_none, &from_master, &to_slave,
+  res = fhandler_pipe::create (&sec_none, &from_master_nat, &to_slave_nat,
 			       fhandler_pty_common::pipesize, pipename,
 			       FILE_FLAG_OVERLAPPED);
   if (res)
@@ -2803,7 +2793,7 @@ fhandler_pty_master::setup ()
       goto err;
     }
 
-  ProtectHandle1 (from_slave, from_pty);
+  ProtectHandle1 (get_handle (), from_pty);
 
   __small_sprintf (pipename, "pty%d-echoloop", unit);
   res = fhandler_pipe::create (&sec_none, &echo_r, &echo_w,
@@ -2879,12 +2869,12 @@ fhandler_pty_master::setup ()
   WaitForSingleObject (thread_param_copied_event, INFINITE);
   CloseHandle (thread_param_copied_event);
 
+  t.set_from_master_nat (from_master_nat);
   t.set_from_master (from_master);
-  t.set_from_master_cyg (from_master_cyg);
+  t.set_to_master_nat (to_master_nat);
   t.set_to_master (to_master);
-  t.set_to_master_cyg (to_master_cyg);
-  t.set_to_slave (to_slave);
-  t.set_to_slave_cyg (get_output_handle ());
+  t.set_to_slave_nat (to_slave_nat);
+  t.set_to_slave (get_output_handle ());
   t.winsize.ws_col = 80;
   t.winsize.ws_row = 25;
   t.master_pid = myself->pid;
@@ -2894,24 +2884,24 @@ fhandler_pty_master::setup ()
   t.master_is_running_as_service = is_running_as_service ();
 
   termios_printf ("this %p, pty%d opened - from_pty <%p,%p>, to_pty %p",
-	this, unit, from_slave, get_handle (),
+	this, unit, from_slave_nat, get_handle (),
 	get_output_handle ());
   return true;
 
 err:
   __seterrno ();
-  close_maybe (from_slave);
-  close_maybe (to_slave);
+  close_maybe (from_slave_nat);
+  close_maybe (to_slave_nat);
   close_maybe (get_handle ());
   close_maybe (get_output_handle ());
   close_maybe (input_available_event);
   close_maybe (output_mutex);
   close_maybe (input_mutex);
   close_maybe (attach_mutex);
+  close_maybe (from_master_nat);
   close_maybe (from_master);
-  close_maybe (from_master_cyg);
+  close_maybe (to_master_nat);
   close_maybe (to_master);
-  close_maybe (to_master_cyg);
   close_maybe (echo_r);
   close_maybe (echo_w);
   close_maybe (master_ctl);
@@ -2929,20 +2919,20 @@ fhandler_pty_master::fixup_after_fork (HANDLE parent)
       tty& t = *get_ttyp ();
       if (myself->pid == t.master_pid)
 	{
+	  t.set_from_master_nat (arch->from_master_nat);
 	  t.set_from_master (arch->from_master);
-	  t.set_from_master_cyg (arch->from_master_cyg);
+	  t.set_to_master_nat (arch->to_master_nat);
 	  t.set_to_master (arch->to_master);
-	  t.set_to_master_cyg (arch->to_master_cyg);
 	}
       arch->dwProcessId = wpid;
     }
+  from_master_nat = arch->from_master_nat;
   from_master = arch->from_master;
-  from_master_cyg = arch->from_master_cyg;
+  to_master_nat = arch->to_master_nat;
   to_master = arch->to_master;
-  to_master_cyg = arch->to_master_cyg;
 #if 0 /* Not sure if this is necessary. */
-  from_slave = arch->from_slave;
-  to_slave = arch->to_slave;
+  from_slave_nat = arch->from_slave_nat;
+  to_slave_nat = arch->to_slave_nat;
 #endif
   report_tty_counts (this, "inherited master", "");
 }
@@ -2953,8 +2943,8 @@ fhandler_pty_master::fixup_after_exec ()
   if (!close_on_exec ())
     fixup_after_fork (spawn_info->parent);
   else
-    from_master = from_master_cyg = to_master = to_master_cyg =
-      from_slave = to_slave = NULL;
+    from_master_nat = from_master = to_master_nat = to_master =
+      from_slave_nat = to_slave_nat = NULL;
 }
 
 BOOL
@@ -3097,7 +3087,7 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 	  get_ttyp ()->req_xfer_input = true;
 	  get_ttyp ()->pcon_start = true;
 	  get_ttyp ()->pcon_start_pid = myself->pid;
-	  WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
+	  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
 	  ReleaseMutex (input_mutex);
 	}
       /* Attach to the pseudo console which already exits. */
@@ -3131,8 +3121,8 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       const DWORD inherit_cursor = 1;
       hpcon = NULL;
       SetLastError (ERROR_SUCCESS);
-      HRESULT res = CreatePseudoConsole (size, get_handle (),
-					 get_output_handle (),
+      HRESULT res = CreatePseudoConsole (size, get_handle_nat (),
+					 get_output_handle_nat (),
 					 inherit_cursor, &hpcon);
       if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
 	{
@@ -3248,30 +3238,22 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 skip_create:
   do
     {
-      /* Set handle */
-      if (GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
-	SetStdHandle (STD_INPUT_HANDLE, hpConIn);
-      if (GetStdHandle (STD_OUTPUT_HANDLE) == get_output_handle ())
-	SetStdHandle (STD_OUTPUT_HANDLE, hpConOut);
-      if (GetStdHandle (STD_ERROR_HANDLE) == get_output_handle ())
-	SetStdHandle (STD_ERROR_HANDLE, hpConOut);
-
       /* Fixup handles */
-      HANDLE orig_input_handle = get_handle ();
-      HANDLE orig_output_handle = get_output_handle ();
+      HANDLE orig_input_handle_nat = get_handle_nat ();
+      HANDLE orig_output_handle_nat = get_output_handle_nat ();
       cygheap_fdenum cfd (false);
       while (cfd.next () >= 0)
 	if (cfd->get_device () == get_device ())
 	  {
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	    if (ptys->get_handle () == orig_input_handle)
-	      ptys->set_handle (hpConIn);
-	    if (ptys->get_output_handle () == orig_output_handle)
-	      ptys->set_output_handle (hpConOut);
+	    if (ptys->get_handle_nat () == orig_input_handle_nat)
+	      ptys->set_handle_nat (hpConIn);
+	    if (ptys->get_output_handle_nat () == orig_output_handle_nat)
+	      ptys->set_output_handle_nat (hpConOut);
 	  }
-      CloseHandle (orig_input_handle);
-      CloseHandle (orig_output_handle);
+      CloseHandle (orig_input_handle_nat);
+      CloseHandle (orig_output_handle_nat);
     }
   while (false);
 
@@ -3572,19 +3554,19 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   WaitForSingleObject (pcon_mutex, INFINITE);
   WaitForSingleObject (input_mutex, INFINITE);
   /* Set pcon_activated and pcon_start so that the response
-     will sent to io_handle rather than io_handle_cyg. */
+     will sent to io_handle_nat rather than io_handle. */
   get_ttyp ()->pcon_activated = true;
   /* pcon_start will be cleared in master write() when CSI6n is responded. */
   get_ttyp ()->pcon_start = true;
-  WriteFile (get_output_handle_cyg (), "\033[6n", 4, &n, NULL);
+  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
   ReleaseMutex (input_mutex);
   p = buf;
   len = sizeof (buf) - 1;
   do
     {
-      if (::bytes_available (n, get_handle ()) && n)
+      if (::bytes_available (n, get_handle_nat ()) && n)
 	{
-	  ReadFile (get_handle (), p, len, &n, NULL);
+	  ReadFile (get_handle_nat (), p, len, &n, NULL);
 	  p += n;
 	  len -= n;
 	  *p = '\0';
@@ -3648,12 +3630,12 @@ fhandler_pty_slave::create_invisible_console ()
 void
 fhandler_pty_master::get_master_thread_param (master_thread_param_t *p)
 {
+  p->from_master_nat = from_master_nat;
   p->from_master = from_master;
-  p->from_master_cyg = from_master_cyg;
+  p->to_master_nat = to_master_nat;
   p->to_master = to_master;
-  p->to_master_cyg = to_master_cyg;
-  p->to_slave = to_slave;
-  p->to_slave_cyg = get_output_handle ();
+  p->to_slave_nat = to_slave_nat;
+  p->to_slave = get_output_handle ();
   p->master_ctl = master_ctl;
   p->input_available_event = input_available_event;
   SetEvent (thread_param_copied_event);
@@ -3662,8 +3644,8 @@ fhandler_pty_master::get_master_thread_param (master_thread_param_t *p)
 void
 fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
 {
-  p->to_master_cyg = to_master_cyg;
-  p->from_slave = from_slave;
+  p->to_master = to_master;
+  p->from_slave_nat = from_slave_nat;
   p->output_mutex = output_mutex;
   p->ttyp = get_ttyp ();
   SetEvent (thread_param_copied_event);
@@ -3677,9 +3659,9 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 {
   HANDLE to;
   if (dir == tty::to_nat)
-    to = ttyp->to_slave ();
+    to = ttyp->to_slave_nat ();
   else
-    to = ttyp->to_slave_cyg ();
+    to = ttyp->to_slave ();
 
   pinfo p (ttyp->master_pid);
   HANDLE pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
@@ -3702,9 +3684,9 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 			  &repl, sizeof repl, &len, 500))
 	return; /* What can we do? */
       if (dir == tty::to_nat)
-	to = repl.to_slave;
+	to = repl.to_slave_nat;
       else
-	to = repl.to_slave_cyg;
+	to = repl.to_slave;
     }
 
   UINT cp_from = 0, cp_to = 0;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index c8f288c27..6e8586d17 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -74,7 +74,7 @@ details. */
 })
 
 #define set_handle_or_return_if_not_open(h, s) \
-  h = (s)->fh->get_handle_cyg (); \
+  h = (s)->fh->get_handle (); \
   if (cygheap->fdtab.not_open ((s)->fd)) \
     { \
       (s)->thread_errno =  EBADF; \
@@ -715,7 +715,7 @@ out:
       fhandler_pty_master *fhm = (fhandler_pty_master *) fh;
       fhm->set_mask_flusho (s->read_ready);
     }
-  h = fh->get_output_handle_cyg ();
+  h = fh->get_output_handle ();
   if (s->write_selected && dev != FH_PIPER)
     {
       gotone += s->write_ready =  pipe_data_available (s->fd, fh, h, true);
@@ -1344,7 +1344,7 @@ peek_pty_slave (select_record *s, bool from_select)
     }
 
 out:
-  HANDLE h = ptys->get_output_handle_cyg ();
+  HANDLE h = ptys->get_output_handle ();
   if (s->write_selected)
     {
       gotone += s->write_ready =  pipe_data_available (s->fd, fh, h, true);
@@ -1572,7 +1572,7 @@ serial_read_cleanup (select_record *s, select_stuff *stuff)
 {
   if (s->h)
     {
-      HANDLE h = ((fhandler_serial *) s->fh)->get_handle_cyg ();
+      HANDLE h = ((fhandler_serial *) s->fh)->get_handle ();
       DWORD undefined;
 
       if (h)
@@ -1611,11 +1611,11 @@ fhandler_serial::select_read (select_stuff *ss)
 
   /* This is apparently necessary for the com0com driver.
      See: http://cygwin.com/ml/cygwin/2009-01/msg00667.html */
-  SetCommMask (get_handle_cyg (), 0);
-  SetCommMask (get_handle_cyg (), EV_RXCHAR);
-  if (ClearCommError (get_handle_cyg (), &io_err, &st) && st.cbInQue)
+  SetCommMask (get_handle (), 0);
+  SetCommMask (get_handle (), EV_RXCHAR);
+  if (ClearCommError (get_handle (), &io_err, &st) && st.cbInQue)
     s->read_ready = true;
-  else if (WaitCommEvent (get_handle_cyg (), &s->fh_data_serial->event,
+  else if (WaitCommEvent (get_handle (), &s->fh_data_serial->event,
 			  &s->fh_data_serial->ov))
     s->read_ready = true;
   else if (GetLastError () == ERROR_IO_PENDING)
@@ -1667,7 +1667,7 @@ fhandler_base::select_read (select_stuff *ss)
       s->startup = no_startup;
       s->verify = verify_ok;
     }
-  s->h = get_handle_cyg ();
+  s->h = get_handle ();
   s->read_selected = true;
   s->read_ready = true;
   return s;
@@ -1682,7 +1682,7 @@ fhandler_base::select_write (select_stuff *ss)
       s->startup = no_startup;
       s->verify = verify_ok;
     }
-  s->h = get_output_handle_cyg ();
+  s->h = get_output_handle ();
   s->write_selected = true;
   s->write_ready = true;
   return s;
@@ -1955,7 +1955,7 @@ fhandler_socket_unix::select_read (select_stuff *ss)
       s->startup = no_startup;
       s->verify = verify_ok;
     }
-  s->h = get_handle_cyg ();
+  s->h = get_handle ();
   s->read_selected = true;
   s->read_ready = true;
   return s;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index ec0cdd408..0bde0b04d 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -187,9 +187,9 @@ handle (int fd, bool writing)
   else if (cfd->close_on_exec ())
     h = INVALID_HANDLE_VALUE;
   else if (!writing)
-    h = cfd->get_handle ();
+    h = cfd->get_handle_nat ();
   else
-    h = cfd->get_output_handle ();
+    h = cfd->get_output_handle_nat ();
 
   return h;
 }
@@ -660,7 +660,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	}
 
       bool enable_pcon = false;
-      HANDLE ptys_from_master = NULL;
+      HANDLE ptys_from_master_nat = NULL;
       HANDLE ptys_input_available_event = NULL;
       HANDLE ptys_pcon_mutex = NULL;
       HANDLE ptys_input_mutex = NULL;
@@ -677,11 +677,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    enable_pcon = true;
 	  ReleaseMutex (ptys_primary->pcon_mutex);
 	  HANDLE h_stdin = handle ((in__stdin < 0 ? 0 : in__stdin), false);
-	  if (h_stdin == ptys_primary->get_handle ())
+	  if (h_stdin == ptys_primary->get_handle_nat ())
 	    stdin_is_ptys = true;
-	  ptys_from_master = ptys_primary->get_handle ();
-	  DuplicateHandle (GetCurrentProcess (), ptys_from_master,
-			   GetCurrentProcess (), &ptys_from_master,
+	  ptys_from_master_nat = ptys_primary->get_handle_nat ();
+	  DuplicateHandle (GetCurrentProcess (), ptys_from_master_nat,
+			   GetCurrentProcess (), &ptys_from_master_nat,
 			   0, 0, DUPLICATE_SAME_ACCESS);
 	  ptys_input_available_event =
 	    ptys_primary->get_input_available_event ();
@@ -700,7 +700,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    {
 	      WaitForSingleObject (ptys_input_mutex, INFINITE);
 	      fhandler_pty_slave::transfer_input (tty::to_nat,
-				    ptys_primary->get_handle_cyg (),
+				    ptys_primary->get_handle (),
 				    ptys_ttyp, ptys_input_available_event);
 	      ReleaseMutex (ptys_input_mutex);
 	    }
@@ -993,11 +993,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		{
 		  WaitForSingleObject (ptys_input_mutex, INFINITE);
 		  fhandler_pty_slave::transfer_input (tty::to_cyg,
-					    ptys_from_master, ptys_ttyp,
+					    ptys_from_master_nat, ptys_ttyp,
 					    ptys_input_available_event);
 		  ReleaseMutex (ptys_input_mutex);
 		}
-	      CloseHandle (ptys_from_master);
+	      CloseHandle (ptys_from_master_nat);
 	      CloseHandle (ptys_input_mutex);
 	      CloseHandle (ptys_input_available_event);
 	      WaitForSingleObject (ptys_pcon_mutex, INFINITE);
@@ -1030,11 +1030,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		{
 		  WaitForSingleObject (ptys_input_mutex, INFINITE);
 		  fhandler_pty_slave::transfer_input (tty::to_cyg,
-					    ptys_from_master, ptys_ttyp,
+					    ptys_from_master_nat, ptys_ttyp,
 					    ptys_input_available_event);
 		  ReleaseMutex (ptys_input_mutex);
 		}
-	      CloseHandle (ptys_from_master);
+	      CloseHandle (ptys_from_master_nat);
 	      CloseHandle (ptys_input_mutex);
 	      CloseHandle (ptys_input_available_event);
 	      WaitForSingleObject (ptys_pcon_mutex, INFINITE);
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 3c016315c..5ed88d0e4 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -319,7 +319,7 @@ tty_min::setpgid (int pid)
 	{
 	WaitForSingleObject (ptys->input_mutex, INFINITE);
 	fhandler_pty_slave::transfer_input (tty::to_nat,
-					    ptys->get_handle_cyg (), ttyp,
+					    ptys->get_handle (), ttyp,
 					    ptys->get_input_available_event ());
 	ReleaseMutex (ptys->input_mutex);
 	}
@@ -334,7 +334,7 @@ tty_min::setpgid (int pid)
 	      if (p)
 		pcon_winpid = p->exec_dwProcessId ?: p->dwProcessId;
 	    }
-	  HANDLE from = ptys->get_handle ();
+	  HANDLE from = ptys->get_handle_nat ();
 	  if (ttyp->pcon_activated && pcon_winpid
 	      && !ptys->get_console_process_id (pcon_winpid, true))
 	    {
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index f041250a3..12c926ec0 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -103,12 +103,12 @@ public:
   };
 
 private:
+  HANDLE _from_master_nat;
   HANDLE _from_master;
-  HANDLE _from_master_cyg;
+  HANDLE _to_master_nat;
   HANDLE _to_master;
-  HANDLE _to_master_cyg;
+  HANDLE _to_slave_nat;
   HANDLE _to_slave;
-  HANDLE _to_slave_cyg;
   bool pcon_activated;
   bool pcon_start;
   pid_t pcon_start_pid;
@@ -134,18 +134,18 @@ private:
   bool discard_input;
 
 public:
+  HANDLE from_master_nat () const { return _from_master_nat; }
   HANDLE from_master () const { return _from_master; }
-  HANDLE from_master_cyg () const { return _from_master_cyg; }
+  HANDLE to_master_nat () const { return _to_master_nat; }
   HANDLE to_master () const { return _to_master; }
-  HANDLE to_master_cyg () const { return _to_master_cyg; }
+  HANDLE to_slave_nat () const { return _to_slave_nat; }
   HANDLE to_slave () const { return _to_slave; }
-  HANDLE to_slave_cyg () const { return _to_slave_cyg; }
+  void set_from_master_nat (HANDLE h) { _from_master_nat = h; }
   void set_from_master (HANDLE h) { _from_master = h; }
-  void set_from_master_cyg (HANDLE h) { _from_master_cyg = h; }
+  void set_to_master_nat (HANDLE h) { _to_master_nat = h; }
   void set_to_master (HANDLE h) { _to_master = h; }
-  void set_to_master_cyg (HANDLE h) { _to_master_cyg = h; }
+  void set_to_slave_nat (HANDLE h) { _to_slave_nat = h; }
   void set_to_slave (HANDLE h) { _to_slave = h; }
-  void set_to_slave_cyg (HANDLE h) { _to_slave_cyg = h; }
 
   int read_retval;
   bool was_opened;	/* True if opened at least once. */
-- 
2.31.1

