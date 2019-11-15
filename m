Return-Path: <cygwin-patches-return-9854-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69490 invoked by alias); 15 Nov 2019 23:27:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69480 invoked by uid 89); 15 Nov 2019 23:27:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Who, sk:attach, inherited, Close
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 15 Nov 2019 23:27:38 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-01.nifty.com with ESMTP id xAFNRNiR009952;	Sat, 16 Nov 2019 08:27:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com xAFNRNiR009952
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573860448;	bh=RQ+BrEV4ST48tKH3Y1N+XA08LvPf8h/JmohrroL9wlM=;	h=From:To:Cc:Subject:Date:From;	b=tEITeOeNjUapDY6dhh5jTAqfE93I4Sjl1wREPxta9HBA9GmLUoknesOjTmjWFiZY1	 kd3ZCNBOX16lXg7NWcNBNaWK3IkfWE4xYEUMxd7tZf4hABLsRQBQyJfkceUSmpb1uT	 7zLK+UH11tTEkuCknvcebMn/9wl0dfDjMU/DBksdZ+13fjW4aIH8vSfYiuiK9BB/+o	 4zOLCfE5qrQgU1F718FDCVP00v8UQ+49aPhV8pG2GNYP86zjFvsLBWzk4tQS6whyjf	 bkjOcNttGSLJJWXC1mFGxxv7RYpU8mi4EFGdYCFIunUCtCpmJG8MKrxKfGYIobWNLl	 IZ42x1CHmKbvw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Convert CamelCase names to snake_case names.
Date: Fri, 15 Nov 2019 23:27:00 -0000
Message-Id: <20191115232724.1270-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00125.txt.bz2

---
 winsup/cygwin/dtable.cc           |  6 +--
 winsup/cygwin/fhandler.h          |  8 ++--
 winsup/cygwin/fhandler_console.cc |  2 +-
 winsup/cygwin/fhandler_tty.cc     | 68 +++++++++++++++----------------
 winsup/cygwin/fork.cc             |  8 ++--
 winsup/cygwin/spawn.cc            | 18 ++++----
 winsup/cygwin/tty.cc              |  2 +-
 winsup/cygwin/tty.h               |  8 ++--
 8 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index cb5f47395..4652de929 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -155,10 +155,10 @@ dtable::stdio_init ()
       if (fh && fh->get_major () == DEV_PTYS_MAJOR)
 	{
 	  fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	  if (ptys->getPseudoConsole ())
+	  if (ptys->get_pseudo_console ())
 	    {
 	      bool attached = !!fhandler_console::get_console_process_id
-		(ptys->getHelperProcessId (), true);
+		(ptys->get_helper_process_id (), true);
 	      if (attached)
 		break;
 	      else
@@ -167,7 +167,7 @@ dtable::stdio_init ()
 		     by some reason. This happens if the executable is
 		     a windows GUI binary, such as mintty. */
 		  FreeConsole ();
-		  if (AttachConsole (ptys->getHelperProcessId ()))
+		  if (AttachConsole (ptys->get_helper_process_id ()))
 		    {
 		      ptys->fixup_after_attach (false, fd);
 		      break;
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 313172ec5..3954c37d1 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2101,13 +2101,13 @@ class fhandler_pty_common: public fhandler_termios
   {
     return get_ttyp ()->attach_pcon_in_fork;
   }
-  DWORD getHelperProcessId (void)
+  DWORD get_helper_process_id (void)
   {
-    return get_ttyp ()->HelperProcessId;
+    return get_ttyp ()->helper_process_id;
   }
-  HPCON getPseudoConsole (void)
+  HPCON get_pseudo_console (void)
   {
-    return get_ttyp ()->hPseudoConsole;
+    return get_ttyp ()->h_pseudo_console;
   }
   bool to_be_read_from_pcon (void);
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 0b1c82fb9..b3095bbe3 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1099,7 +1099,7 @@ fhandler_console::close ()
       {
 	fhandler_pty_common *t =
 	  (fhandler_pty_common *) (fhandler_base *) cfd;
-	if (get_console_process_id (t->getHelperProcessId (), true))
+	if (get_console_process_id (t->get_helper_process_id (), true))
 	  return 0;
       }
 
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f9c7c3ade..1d344c7fe 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -88,7 +88,7 @@ set_switch_to_pcon (void)
       {
 	fhandler_base *fh = cfd;
 	fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	if (ptys->getPseudoConsole ())
+	if (ptys->get_pseudo_console ())
 	  ptys->set_switch_to_pcon (fd);
       }
 }
@@ -107,19 +107,19 @@ force_attach_to_pcon (HANDLE h)
 	  {
 	    fhandler_base *fh = cfd;
 	    fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	    if (!ptys->getPseudoConsole ())
+	    if (!ptys->get_pseudo_console ())
 	      continue;
 	    if (n != 0
 		|| h == ptys->get_handle ()
 		|| h == ptys->get_output_handle ())
 	      {
 		if (fhandler_console::get_console_process_id
-				  (ptys->getHelperProcessId (), true))
+				  (ptys->get_helper_process_id (), true))
 		  attach_done = true;
 		else
 		  {
 		    FreeConsole ();
-		    if (AttachConsole (ptys->getHelperProcessId ()))
+		    if (AttachConsole (ptys->get_helper_process_id ()))
 		      {
 			pcon_attached_to = ptys->get_minor ();
 			attach_done = true;
@@ -711,7 +711,7 @@ fhandler_pty_slave::~fhandler_pty_slave ()
   if (!get_ttyp ())
     /* Why comes here? Who clears _tc? */
     return;
-  if (getPseudoConsole ())
+  if (get_pseudo_console ())
     {
       int used = 0;
       int attached = 0;
@@ -919,7 +919,7 @@ fhandler_pty_slave::open (int flags, mode_t)
   set_output_handle (to_master_local);
   set_output_handle_cyg (to_master_cyg_local);
 
-  if (!getPseudoConsole ())
+  if (!get_pseudo_console ())
     {
       fhandler_console::need_invisible ();
       pcon_attached_to = -1;
@@ -931,7 +931,7 @@ fhandler_pty_slave::open (int flags, mode_t)
       pcon_attached_to = -1;
     }
   else if (fhandler_console::get_console_process_id
-			       (getHelperProcessId (), true))
+			       (get_helper_process_id (), true))
     /* Attached to pcon of this pty */
     {
       pcon_attached_to = get_minor ();
@@ -990,7 +990,7 @@ fhandler_pty_slave::close ()
   if (!ForceCloseHandle (get_handle_cyg ()))
     termios_printf ("CloseHandle (get_handle_cyg ()<%p>), %E",
 	get_handle_cyg ());
-  if (!getPseudoConsole () &&
+  if (!get_pseudo_console () &&
       (unsigned) myself->ctty == FHDEV (DEV_PTYS_MAJOR, get_minor ()))
     fhandler_console::free_console ();	/* assumes that we are the last pty closer */
   fhandler_pty_common::close ();
@@ -1063,10 +1063,10 @@ fhandler_pty_slave::try_reattach_pcon (void)
     return false;
 
   FreeConsole ();
-  if (!AttachConsole (getHelperProcessId ()))
+  if (!AttachConsole (get_helper_process_id ()))
     {
       system_printf ("pty%d: AttachConsole(helper=%d) failed. 0x%08lx",
-		     get_minor (), getHelperProcessId (), GetLastError ());
+		     get_minor (), get_helper_process_id (), GetLastError ());
       return false;
     }
   return true;
@@ -1170,14 +1170,14 @@ void
 fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
 {
   bool attached =
-    !!fhandler_console::get_console_process_id (getHelperProcessId (), true);
+    !!fhandler_console::get_console_process_id (get_helper_process_id (), true);
   if (!attached && pcon_attached_to == get_minor ())
     {
       for (DWORD t0 = GetTickCount (); GetTickCount () - t0 < 100; )
 	{
 	  Sleep (1);
 	  attached = fhandler_console::get_console_process_id
-				      (getHelperProcessId (), true);
+				      (get_helper_process_id (), true);
 	  if (attached)
 	    break;
 	}
@@ -1383,7 +1383,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   restore_reattach_pcon ();
 
   /* Push slave output to pseudo console screen buffer */
-  if (getPseudoConsole ())
+  if (get_pseudo_console ())
     {
       acquire_output_mutex (INFINITE);
       push_to_pcon_screenbuffer ((char *)ptr, len);
@@ -1701,7 +1701,7 @@ out:
   termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
   /* Push slave read as echo to pseudo console screen buffer. */
-  if (getPseudoConsole () && ptr0 && (get_ttyp ()->ti.c_lflag & ECHO))
+  if (get_pseudo_console () && ptr0 && (get_ttyp ()->ti.c_lflag & ECHO))
     {
       acquire_output_mutex (INFINITE);
       push_to_pcon_screenbuffer (ptr0, len);
@@ -1847,7 +1847,7 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
       get_ttyp ()->winsize = get_ttyp ()->arg.winsize;
       break;
     case TIOCSWINSZ:
-      if (getPseudoConsole ())
+      if (get_pseudo_console ())
 	{
 	  /* If not attached to this pseudo console,
 	     try to attach temporarily. */
@@ -2230,21 +2230,21 @@ fhandler_pty_master::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (!NT_SUCCESS (status))
     debug_printf ("NtQueryObject: %y", status);
-  else if (obi.HandleCount == (getPseudoConsole () ? 2 : 1))
+  else if (obi.HandleCount == (get_pseudo_console () ? 2 : 1))
 			      /* Helper process has inherited one. */
     {
       termios_printf ("Closing last master of pty%d", get_minor ());
       /* Close Pseudo Console */
-      if (getPseudoConsole ())
+      if (get_pseudo_console ())
 	{
 	  /* Terminate helper process */
-	  SetEvent (get_ttyp ()->hHelperGoodbye);
-	  WaitForSingleObject (get_ttyp ()->hHelperProcess, INFINITE);
+	  SetEvent (get_ttyp ()->h_helper_goodbye);
+	  WaitForSingleObject (get_ttyp ()->h_helper_process, INFINITE);
 	  /* FIXME: Pseudo console can be accessed via its handle
 	     only in the process which created it. What else can we do? */
 	  if (master_pid_tmp == myself->pid)
 	    /* Release pseudo console */
-	    ClosePseudoConsole (getPseudoConsole ());
+	    ClosePseudoConsole (get_pseudo_console ());
 	  get_ttyp ()->switch_to_pcon_in = false;
 	  get_ttyp ()->switch_to_pcon_out = false;
 	}
@@ -2403,12 +2403,12 @@ fhandler_pty_master::ioctl (unsigned int cmd, void *arg)
     case TIOCSWINSZ:
       /* FIXME: Pseudo console can be accessed via its handle
 	 only in the process which created it. What else can we do? */
-      if (getPseudoConsole () && get_ttyp ()->master_pid == myself->pid)
+      if (get_pseudo_console () && get_ttyp ()->master_pid == myself->pid)
 	{
 	  COORD size;
 	  size.X = ((struct winsize *) arg)->ws_col;
 	  size.Y = ((struct winsize *) arg)->ws_row;
-	  ResizePseudoConsole (getPseudoConsole (), size);
+	  ResizePseudoConsole (get_pseudo_console (), size);
 	}
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
@@ -2675,9 +2675,9 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
   if (fd < 0)
     fd = fd_set;
-  if (getPseudoConsole ())
+  if (get_pseudo_console ())
     {
-      if (fhandler_console::get_console_process_id (getHelperProcessId (),
+      if (fhandler_console::get_console_process_id (get_helper_process_id (),
 						    true))
 	{
 	  if (pcon_attached_to != get_minor ())
@@ -2769,7 +2769,7 @@ fhandler_pty_slave::fixup_after_exec ()
 
   if (!close_on_exec ())
     fixup_after_fork (NULL);
-  else if (getPseudoConsole ())
+  else if (get_pseudo_console ())
     {
       int used = 0;
       int attached = 0;
@@ -2802,7 +2802,7 @@ fhandler_pty_slave::fixup_after_exec ()
 
 #if USE_API_HOOK
   /* Hook Console API */
-  if (getPseudoConsole ())
+  if (get_pseudo_console ())
     {
 #define DO_HOOK(module, name) \
       if (!name##_Orig) \
@@ -3004,7 +3004,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	}
       ssize_t wlen = rlen;
       char *ptr = outbuf;
-      if (getPseudoConsole ())
+      if (get_pseudo_console ())
 	{
 	  /* Avoid duplicating slave output which is already sent to
 	     to_master_cyg */
@@ -3152,7 +3152,7 @@ fhandler_pty_master::setup_pseudoconsole ()
   CreatePipe (&from_master, &to_slave, &sec_none, 0);
   SetLastError (ERROR_SUCCESS);
   HRESULT res = CreatePseudoConsole (size, from_master, to_master,
-				     0, &get_ttyp ()->hPseudoConsole);
+				     0, &get_ttyp ()->h_pseudo_console);
   if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
     {
       if (res != S_OK)
@@ -3162,7 +3162,7 @@ fhandler_pty_master::setup_pseudoconsole ()
       CloseHandle (to_slave);
       from_master = from_master_cyg;
       to_slave = NULL;
-      get_ttyp ()->hPseudoConsole = NULL;
+      get_ttyp ()->h_pseudo_console = NULL;
       return false;
     }
 
@@ -3186,8 +3186,8 @@ fhandler_pty_master::setup_pseudoconsole ()
   UpdateProcThreadAttribute (si_helper.lpAttributeList,
 			     0,
 			     PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
-			     get_ttyp ()->hPseudoConsole,
-			     sizeof (get_ttyp ()->hPseudoConsole),
+			     get_ttyp ()->h_pseudo_console,
+			     sizeof (get_ttyp ()->h_pseudo_console),
 			     NULL, NULL);
   HANDLE hello = CreateEvent (&sec_none, true, false, NULL);
   HANDLE goodbye = CreateEvent (&sec_none, true, false, NULL);
@@ -3228,9 +3228,9 @@ fhandler_pty_master::setup_pseudoconsole ()
   DeleteProcThreadAttributeList (si_helper.lpAttributeList);
   HeapFree (GetProcessHeap (), 0, si_helper.lpAttributeList);
   /* Setting information of stuffs regarding pseudo console */
-  get_ttyp ()->hHelperGoodbye = goodbye;
-  get_ttyp ()->hHelperProcess = pi_helper.hProcess;
-  get_ttyp ()->HelperProcessId = pi_helper.dwProcessId;
+  get_ttyp ()->h_helper_goodbye = goodbye;
+  get_ttyp ()->h_helper_process = pi_helper.hProcess;
+  get_ttyp ()->helper_process_id = pi_helper.dwProcessId;
   CloseHandle (from_master);
   CloseHandle (to_master);
   from_master = hpConIn;
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 0a929dffd..a8f0fb82a 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -140,12 +140,12 @@ frok::child (volatile char * volatile here)
       {
 	fhandler_base *fh = cfd;
 	fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
-	if (ptym->getPseudoConsole ())
+	if (ptym->get_pseudo_console ())
 	  {
 	    debug_printf ("found a PTY master %d: helper_PID=%d",
-			  ptym->get_minor (), ptym->getHelperProcessId ());
+			  ptym->get_minor (), ptym->get_helper_process_id ());
 	    if (fhandler_console::get_console_process_id (
-				ptym->getHelperProcessId (), true))
+				ptym->get_helper_process_id (), true))
 	      /* Already attached */
 	      break;
 	    else
@@ -153,7 +153,7 @@ frok::child (volatile char * volatile here)
 		if (ptym->attach_pcon_in_fork ())
 		  {
 		    FreeConsole ();
-		    if (!AttachConsole (ptym->getHelperProcessId ()))
+		    if (!AttachConsole (ptym->get_helper_process_id ()))
 		      /* Error */;
 		    else
 		      break;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index f82860e72..cea79e326 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -259,7 +259,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 {
   bool rc;
   int res = -1;
-  DWORD pidRestore = 0;
+  DWORD pid_restore = 0;
   bool attach_to_console = false;
   pid_t ctty_pgid = 0;
 
@@ -581,7 +581,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	sa = &sec_none_nih;
 
       /* Attach to pseudo console if pty salve is used */
-      pidRestore = fhandler_console::get_console_process_id
+      pid_restore = fhandler_console::get_console_process_id
 	(GetCurrentProcessId (), false);
       for (int i = 0; i < 3; i ++)
 	{
@@ -591,19 +591,19 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
 	    {
 	      fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
-	      if (ptys->getPseudoConsole ())
+	      if (ptys->get_pseudo_console ())
 		{
-		  DWORD dwHelperProcessId = ptys->getHelperProcessId ();
+		  DWORD helper_process_id = ptys->get_helper_process_id ();
 		  debug_printf ("found a PTY slave %d: helper_PID=%d",
-				    fh->get_minor (), dwHelperProcessId);
+				    fh->get_minor (), helper_process_id);
 		  if (fhandler_console::get_console_process_id
-					      (dwHelperProcessId, true))
+					      (helper_process_id, true))
 		    /* Already attached */
 		    attach_to_console = true;
 		  else if (!attach_to_console)
 		    {
 		      FreeConsole ();
-		      if (AttachConsole (dwHelperProcessId))
+		      if (AttachConsole (helper_process_id))
 			attach_to_console = true;
 		    }
 		  ptys->fixup_after_attach (!iscygwin (), fd);
@@ -922,10 +922,10 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
   if (envblock)
     free (envblock);
 
-  if (attach_to_console && pidRestore)
+  if (attach_to_console && pid_restore)
     {
       FreeConsole ();
-      AttachConsole (pidRestore);
+      AttachConsole (pid_restore);
     }
 
   return (int) res;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 9c66b89d8..695ce91f1 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -235,7 +235,7 @@ tty::init ()
   master_pid = 0;
   is_console = false;
   attach_pcon_in_fork = false;
-  hPseudoConsole = NULL;
+  h_pseudo_console = NULL;
   column = 0;
   switch_to_pcon_in = false;
   switch_to_pcon_out = false;
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index a6732aecc..cd4c0ed44 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -93,10 +93,10 @@ private:
   HANDLE _from_master_cyg;
   HANDLE _to_master;
   HANDLE _to_master_cyg;
-  HPCON hPseudoConsole;
-  HANDLE hHelperProcess;
-  DWORD HelperProcessId;
-  HANDLE hHelperGoodbye;
+  HPCON h_pseudo_console;
+  HANDLE h_helper_process;
+  DWORD helper_process_id;
+  HANDLE h_helper_goodbye;
   bool attach_pcon_in_fork;
   bool switch_to_pcon_in;
   bool switch_to_pcon_out;
-- 
2.21.0
