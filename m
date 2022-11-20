Return-Path: <SRS0=2gir=3U=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
	by sourceware.org (Postfix) with ESMTPS id EB19A3959C41
	for <cygwin-patches@cygwin.com>; Sun, 20 Nov 2022 09:44:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EB19A3959C41
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (w165151.dynamic.ppp.asahi-net.or.jp [121.1.165.151]) (authenticated)
	by conuserg-10.nifty.com with ESMTP id 2AK9hkLi012142;
	Sun, 20 Nov 2022 18:43:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 2AK9hkLi012142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1668937432;
	bh=AtBYVeDTg/YxQaqS7wY3hvpsZAzY0eD9dQ3G1ZuR4AI=;
	h=From:To:Cc:Subject:Date:From;
	b=xYQBYm0v9vqa2LqNI7AqQX2WqdZAUDSFFbCJumA0lJO2T0i/k+Egcb6Or8XZSeu0s
	 bQmnAkMGQcc6tNmzfj78h4fLlsBKDne3GjiacHohtLIxHR1mo7lXCrlU/idRnH7s+y
	 vOH6fveVidjefJnzFtPYKHz58xTb9bp4aQ74e+bHSorl17v63yun0t3W9FAmnU2QgA
	 Cpac//ab8wp7cJ1DZjcTeUINCM/Jj+4AlyG10+R1Zn0AjXjLrOvmsFPu7AJLvEJIf/
	 QDDlGRe6hXCzRPRJUEKznmXk5Ks8aFqQwMx6wyDC5g6RhG5CcrPDE3jXnaVpyYXAL+
	 u9x0FGsrWXEsA==
X-Nifty-SrcIP: [121.1.165.151]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty, console: Encapsulate spawn.cc code related to pty/console.
Date: Sun, 20 Nov 2022 18:43:36 +0900
Message-Id: <20221120094336.1637-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

- The codes related to pty and console in spawn.cc have been moved
  into the new class fhandler_termios::spawn_worker, and make spawn.cc
  call them. The functionality has not been changed at all.
---
 winsup/cygwin/fhandler/termios.cc       |  99 ++++++++++++++++++++
 winsup/cygwin/fhandler/tty.cc           |   5 +-
 winsup/cygwin/local_includes/fhandler.h |  52 +++++++----
 winsup/cygwin/spawn.cc                  | 114 +++---------------------
 4 files changed, 149 insertions(+), 121 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 328c73fcd..517e74e77 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -692,6 +692,29 @@ fhandler_termios::tcgetsid ()
   return -1;
 }
 
+static bool
+is_console_app (const WCHAR *filename)
+{
+  HANDLE h;
+  const int id_offset = 92;
+  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
+		   NULL, OPEN_EXISTING, 0, NULL);
+  char buf[1024];
+  DWORD n;
+  ReadFile (h, buf, sizeof (buf), &n, 0);
+  CloseHandle (h);
+  char *p = (char *) memmem (buf, n, "PE\0\0", 4);
+  if (p && p + id_offset < buf + n)
+    return p[id_offset] == '\003'; /* 02: GUI, 03: console */
+  else
+    {
+      wchar_t *e = wcsrchr (filename, L'.');
+      if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
+	return true;
+    }
+  return false;
+}
+
 int
 fhandler_termios::ioctl (int cmd, void *varg)
 {
@@ -718,3 +741,79 @@ fhandler_termios::ioctl (int cmd, void *varg)
   myself->set_ctty (this, 0);
   return 0;
 }
+
+void
+fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
+				       const WCHAR *runpath, bool nopcon,
+				       bool reset_sendsig,
+				       const WCHAR *envblock)
+{
+  fhandler_pty_slave *ptys_primary = NULL;
+  fhandler_console *cons_native = NULL;
+
+  for (int i = 0; i < 3; i ++)
+    {
+      const int chk_order[] = {1, 0, 2};
+      int fd = chk_order[i];
+      fhandler_base *fh = ::cygheap->fdtab[fd];
+      if (fh && fh->get_major () == DEV_PTYS_MAJOR && ptys_primary == NULL)
+	ptys_primary = (fhandler_pty_slave *) fh;
+      else if (fh && fh->get_major () == DEV_CONS_MAJOR
+	       && !iscygwin && cons_native == NULL)
+	cons_native = (fhandler_console *) fh;
+    }
+  if (cons_native)
+    {
+      cons_native->setup_for_non_cygwin_app ();
+      /* Console handles will be already closed by close_all_files()
+	 when cleaning up, therefore, duplicate them here. */
+      cons_native->get_duplicated_handle_set (&cons_handle_set);
+      cons_need_cleanup = true;
+    }
+  if (!iscygwin)
+    {
+      int fd;
+      cygheap_fdenum cfd (false);
+      while ((fd = cfd.next ()) >= 0)
+	if (cfd->get_major () == DEV_PTYS_MAJOR)
+	  {
+	    fhandler_pty_slave *ptys
+	      = (fhandler_pty_slave *)(fhandler_base *) cfd;
+	    ptys->create_invisible_console ();
+	    ptys->setup_locale ();
+	  }
+    }
+  if (!iscygwin && ptys_primary && is_console_app (runpath))
+    {
+      if (h_stdin == ptys_primary->get_handle_nat ())
+	stdin_is_ptys = true;
+      if (reset_sendsig)
+	myself->sendsig = myself->exec_sendsig;
+      ptys_primary->setup_for_non_cygwin_app (nopcon, envblock, stdin_is_ptys);
+      if (reset_sendsig)
+	myself->sendsig = NULL;
+      ptys_primary->get_duplicated_handle_set (&ptys_handle_set);
+      ptys_ttyp = (tty *) ptys_primary->tc ();
+      ptys_need_cleanup = true;
+    }
+}
+
+void
+fhandler_termios::spawn_worker::cleanup ()
+{
+  if (ptys_need_cleanup)
+    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
+						    ptys_ttyp, stdin_is_ptys);
+  if (cons_need_cleanup)
+    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
+  close_handle_set ();
+}
+
+void
+fhandler_termios::spawn_worker::close_handle_set ()
+{
+  if (ptys_need_cleanup)
+    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
+  if (cons_need_cleanup)
+    fhandler_console::close_handle_set (&cons_handle_set);
+}
diff --git a/winsup/cygwin/fhandler/tty.cc b/winsup/cygwin/fhandler/tty.cc
index 0f9dec570..7959d4b0a 100644
--- a/winsup/cygwin/fhandler/tty.cc
+++ b/winsup/cygwin/fhandler/tty.cc
@@ -247,7 +247,7 @@ atexit_func (void)
 	    tty *ttyp = (tty *) ptys->tc ();
 	    bool stdin_is_ptys =
 		GetStdHandle (STD_INPUT_HANDLE) == ptys->get_handle ();
-	    struct fhandler_pty_slave::handle_set_t handles =
+	    fhandler_pty_slave::handle_set_t handles =
 	      {
 		ptys->get_handle_nat (),
 		ptys->get_input_available_event (),
@@ -4096,7 +4096,8 @@ fhandler_pty_slave::close_handle_set (handle_set_t *p)
 }
 
 void
-fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
+fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
+					      const WCHAR *envblock,
 					      bool stdin_is_ptys)
 {
   if (disable_pcon || !term_has_pcon_cap (envblock))
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index b012c6e8f..bc02eae66 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1989,6 +1989,40 @@ class fhandler_termios: public fhandler_base
   virtual bool need_console_handler () { return false; }
   virtual bool need_send_ctrl_c_event () { return true; }
   virtual DWORD get_helper_pid () { return 0; }
+
+  struct ptys_handle_set_t
+  {
+    HANDLE from_master_nat;
+    HANDLE input_available_event;
+    HANDLE input_mutex;
+    HANDLE pipe_sw_mutex;
+  };
+  struct cons_handle_set_t
+  {
+    HANDLE input_handle;
+    HANDLE output_handle;
+    HANDLE input_mutex;
+    HANDLE output_mutex;
+  };
+  class spawn_worker
+  {
+  private:
+    ptys_handle_set_t ptys_handle_set;
+    cons_handle_set_t cons_handle_set;
+    bool ptys_need_cleanup;
+    bool cons_need_cleanup;
+    bool stdin_is_ptys;
+    tty *ptys_ttyp;
+  public:
+    spawn_worker () :
+      ptys_need_cleanup (false), cons_need_cleanup (false),
+      stdin_is_ptys (false), ptys_ttyp (NULL) {}
+    void setup (bool iscygwin, HANDLE h_stdin, const WCHAR *runpath,
+		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
+    bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
+    void cleanup ();
+    void close_handle_set ();
+  };
 };
 
 enum ansi_intensity
@@ -2133,13 +2167,7 @@ public:
     input_signalled = 2,
     input_winch = 3
   };
-  struct handle_set_t
-  {
-    HANDLE input_handle;
-    HANDLE output_handle;
-    HANDLE input_mutex;
-    HANDLE output_mutex;
-  };
+  typedef cons_handle_set_t handle_set_t;
   HANDLE thread_sync_event;
 private:
   static const unsigned MAX_WRITE_CHARS;
@@ -2375,13 +2403,7 @@ class fhandler_pty_slave: public fhandler_pty_common
  public:
   pid_t tc_getpgid () { return _tc ? _tc->pgid : 0; }
 
-  struct handle_set_t
-  {
-    HANDLE from_master_nat;
-    HANDLE input_available_event;
-    HANDLE input_mutex;
-    HANDLE pipe_sw_mutex;
-  };
+  typedef ptys_handle_set_t handle_set_t;
 
   /* Constructor */
   fhandler_pty_slave (int);
@@ -2450,7 +2472,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void cleanup_before_exit ();
   void get_duplicated_handle_set (handle_set_t *p);
   static void close_handle_set (handle_set_t *p);
-  void setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
+  void setup_for_non_cygwin_app (bool nopcon, const WCHAR *envblock,
 				 bool stdin_is_ptys);
   static void cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 					  bool stdin_is_ptys,
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 01225afe2..32ba5b377 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -211,29 +211,6 @@ handle (int fd, bool writing)
   return h;
 }
 
-static bool
-is_console_app (WCHAR *filename)
-{
-  HANDLE h;
-  const int id_offset = 92;
-  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
-		  NULL, OPEN_EXISTING, 0, NULL);
-  char buf[1024];
-  DWORD n;
-  ReadFile (h, buf, sizeof (buf), &n, 0);
-  CloseHandle (h);
-  char *p = (char *) memmem (buf, n, "PE\0\0", 4);
-  if (p && p + id_offset < buf + n)
-    return p[id_offset] == '\003'; /* 02: GUI, 03: console */
-  else
-    {
-      wchar_t *e = wcsrchr (filename, L'.');
-      if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
-	return true;
-    }
-  return false;
-}
-
 int
 iscmd (const char *argv0, const char *what)
 {
@@ -345,10 +322,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   STARTUPINFOW si = {};
   int looped = 0;
 
-  struct fhandler_pty_slave::handle_set_t ptys_handle_set = { 0, };
-  bool ptys_need_cleanup = false;
-  struct fhandler_console::handle_set_t cons_handle_set = { 0, };
-  bool cons_need_cleanup = false;
+  fhandler_termios::spawn_worker term_spawn_worker;
 
   system_call_handle system_call (mode == _P_SYSTEM);
 
@@ -598,29 +572,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			 PROCESS_QUERY_LIMITED_INFORMATION))
 	sa = &sec_none_nih;
 
-      fhandler_pty_slave *ptys_primary = NULL;
-      fhandler_console *cons_native = NULL;
-      for (int i = 0; i < 3; i ++)
-	{
-	  const int chk_order[] = {1, 0, 2};
-	  int fd = chk_order[i];
-	  fhandler_base *fh = ::cygheap->fdtab[fd];
-	  if (fh && fh->get_major () == DEV_PTYS_MAJOR && ptys_primary == NULL)
-	    ptys_primary = (fhandler_pty_slave *) fh;
-	  else if (fh && fh->get_major () == DEV_CONS_MAJOR
-		   && !iscygwin () && cons_native == NULL)
-	    cons_native = (fhandler_console *) fh;
-	}
-
-      if (cons_native)
-	{
-	  cons_native->setup_for_non_cygwin_app ();
-	  /* Console handles will be already closed by close_all_files()
-	     when cleaning up, therefore, duplicate them here. */
-	  cons_native->get_duplicated_handle_set (&cons_handle_set);
-	  cons_need_cleanup = true;
-	}
-
       int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
       int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
       int fileno_stderr = 2;
@@ -631,14 +582,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  int fd;
 	  cygheap_fdenum cfd (false);
 	  while ((fd = cfd.next ()) >= 0)
-	    if (cfd->get_major () == DEV_PTYS_MAJOR)
-	      {
-		fhandler_pty_slave *ptys =
-		  (fhandler_pty_slave *)(fhandler_base *) cfd;
-		ptys->create_invisible_console ();
-		ptys->setup_locale ();
-	      }
-	    else if (cfd->get_dev () == FH_PIPEW
+	    if (cfd->get_dev () == FH_PIPEW
 		     && (fd == fileno_stdout || fd == fileno_stderr))
 	      {
 		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
@@ -666,24 +610,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
-      bool stdin_is_ptys = false;
-      tty *ptys_ttyp = NULL;
-      if (!iscygwin () && ptys_primary && is_console_app (runpath))
-	{
-	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
-	  HANDLE h_stdin = handle (fileno_stdin, false);
-	  if (h_stdin == ptys_primary->get_handle_nat ())
-	    stdin_is_ptys = true;
-	  if (reset_sendsig)
-	    myself->sendsig = myself->exec_sendsig;
-	  ptys_primary->setup_for_non_cygwin_app (nopcon, envblock,
-						  stdin_is_ptys);
-	  if (reset_sendsig)
-	    myself->sendsig = NULL;
-	  ptys_primary->get_duplicated_handle_set (&ptys_handle_set);
-	  ptys_ttyp = (tty *) ptys_primary->tc ();
-	  ptys_need_cleanup = true;
-	}
+      bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
+      term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
+			       runpath, no_pcon, reset_sendsig, envblock);
 
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
@@ -844,11 +773,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       /* Name the handle similarly to proc_subproc. */
       ProtectHandle1 (pi.hProcess, childhProc);
 
-      /* Do not touch these terminal instances after here.
-	 They may be destroyed by close_all_files(). */
-      ptys_primary = NULL;
-      cons_native = NULL;
-
       if (mode == _P_OVERLAY)
 	{
 	  myself->dwProcessId = pi.dwProcessId;
@@ -966,7 +890,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	  if (sem)
 	    __posix_spawn_sem_release (sem, 0);
-	  if (ptys_need_cleanup || cons_need_cleanup)
+	  if (term_spawn_worker.need_cleanup ())
 	    {
 	      LONG prev_sigExeced = sigExeced;
 	      while (WaitForSingleObject (pi.hProcess, 100) == WAIT_TIMEOUT)
@@ -975,18 +899,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		   the signal sigExeced. Therefore, clear sigExeced here. */
 		prev_sigExeced =
 		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
-	    }
-	  if (ptys_need_cleanup)
-	    {
-	      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
-							      ptys_ttyp,
-							      stdin_is_ptys);
-	      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
-	    }
-	  if (cons_need_cleanup)
-	    {
-	      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
-	      fhandler_console::close_handle_set (&cons_handle_set);
+	      term_spawn_worker.cleanup ();
+	      term_spawn_worker.close_handle_set ();
 	    }
 	  /* Make sure that ctrl_c_handler() is not on going. Calling
 	     init_console_handler(false) locks until returning from
@@ -1000,12 +914,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  system_call.arm ();
 	  if (waitpid (cygpid, &res, 0) != cygpid)
 	    res = -1;
-	  if (ptys_need_cleanup)
-	    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
-							    ptys_ttyp,
-							    stdin_is_ptys);
-	  if (cons_need_cleanup)
-	    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
+	  term_spawn_worker.cleanup ();
 	  break;
 	case _P_DETACH:
 	  res = 0;	/* Lost all memory of this child. */
@@ -1028,10 +937,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       res = -1;
     }
   __endtry
-  if (ptys_need_cleanup)
-    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
-  if (cons_need_cleanup)
-    fhandler_console::close_handle_set (&cons_handle_set);
+  term_spawn_worker.close_handle_set ();
   this->cleanup ();
   if (envblock)
     free (envblock);
-- 
2.38.1

