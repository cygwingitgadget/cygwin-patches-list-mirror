Return-Path: <cygwin-patches-return-9587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6670 invoked by alias); 1 Sep 2019 21:58:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6623 invoked by uid 89); 1 Sep 2019 21:58:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham version=3.3.1 spammy=H*MI:sk:2019090, screen
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 01 Sep 2019 21:58:07 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x81LvkaN022613;	Mon, 2 Sep 2019 06:57:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x81LvkaN022613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567375074;	bh=1yza5zppgaBODKBQiHQhyLx76Pjg3xVk3073wg0041E=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=vekmHxAaXJEskTAspsV6nWvmGSy3YuAvpbtHeExwC6EljQWIIntSLMlaLRB7BHITh	 11ODPqooPndGK7LHeuoQzaNZk6AcJUMkBEdgDlE+fMuCzYH1LcO48HLy89veGQasJL	 zmOOBnb3wl2Pr0c3VvxU3GQMsBgVvCX9phUoCA2MG14+6uEsMBstIAoUoF/8kHMbU7	 WcAXNaTDc/ahlAcz1Jfq0316yhNXodVp6DV3IP5NtOnnH/OhpVPY/2EfEQFutFUjm6	 ql9g7qnmWVjgkEyiLBhsgFRdQM4xV+7RKzdRg/BvY1tWzPjT+4gwmEQU3gG0pGPB4z	 LvFbhZDVQxYhA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 1/1] Cygwin: pty: Fix state management for pseudo console support.
Date: Sun, 01 Sep 2019 21:58:00 -0000
Message-Id: <20190901215741.752-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190901215741.752-1-takashi.yano@nifty.ne.jp>
References: <20190901215741.752-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00107.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 has some bugs which
  cause mismatch between state variables and real pseudo console
  state regarding console attaching and r/w pipe switching. This
  patch fixes this issue by redesigning the state management.
---
 winsup/cygwin/dtable.cc           |  15 +-
 winsup/cygwin/fhandler.h          |   6 +-
 winsup/cygwin/fhandler_console.cc |   6 +-
 winsup/cygwin/fhandler_tty.cc     | 413 ++++++++++++++++--------------
 winsup/cygwin/fork.cc             |  24 +-
 winsup/cygwin/spawn.cc            |  65 +++--
 6 files changed, 288 insertions(+), 241 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index ba5d16206..6266f1bc2 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -150,8 +150,11 @@ dtable::stdio_init ()
   bool need_fixup_handle = false;
   fhandler_pty_slave *ptys = NULL;
   bool is_pty[3] = {false, false, false};
-  for (int fd = 0; fd < 3; fd ++)
+  bool already_attached = false;
+  int chk_order[] = {1, 0, 2};
+  for (int i = 0; i < 3; i ++)
     {
+      int fd = chk_order[i];
       fhandler_base *fh = cygheap->fdtab[fd];
       if (fh && fh->get_major () == DEV_PTYS_MAJOR)
 	{
@@ -161,14 +164,18 @@ dtable::stdio_init ()
 	      is_pty[fd] = true;
 	      bool attached = !!fhandler_console::get_console_process_id
 		(ptys->getHelperProcessId (), true);
-	      if (!attached)
+	      already_attached = already_attached || attached;
+	      if (!already_attached)
 		{
 		  /* Not attached to pseudo console in fork() or spawn()
 		     by some reason. This happens if the executable is
 		     a windows GUI binary, such as mintty. */
 		  FreeConsole ();
-		  AttachConsole (ptys->getHelperProcessId ());
-		  need_fixup_handle = true;
+		  if (AttachConsole (ptys->getHelperProcessId ()))
+		    {
+		      need_fixup_handle = true;
+		      already_attached = true;
+		    }
 		}
 	      ptys->reset_switch_to_pcon ();
 	    }
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c75e40c0a..af2b948cb 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2106,19 +2106,22 @@ class fhandler_pty_common: public fhandler_termios
  protected:
   BOOL process_opost_output (HANDLE h,
 			     const void *ptr, ssize_t& len, bool is_echo);
-  bool check_switch_to_pcon (void);
 };
 
 class fhandler_pty_slave: public fhandler_pty_common
 {
   HANDLE inuse;			// used to indicate that a tty is in use
   HANDLE output_handle_cyg, io_handle_cyg;
+  DWORD pidRestore;
 
   /* Helper functions for fchmod and fchown. */
   bool fch_open_handles (bool chown);
   int fch_set_sd (security_descriptor &sd, bool chown);
   void fch_close_handles ();
 
+  bool try_reattach_pcon ();
+  void restore_reattach_pcon ();
+
  public:
   /* Constructor */
   fhandler_pty_slave (int);
@@ -2172,7 +2175,6 @@ class fhandler_pty_slave: public fhandler_pty_common
   void set_switch_to_pcon (void);
   void reset_switch_to_pcon (void);
   void push_to_pcon_screenbuffer (const char *ptr, size_t len);
-  bool has_master_opened (void);
   void mask_switch_to_pcon (bool mask)
   {
     get_ttyp ()->mask_switch_to_pcon = mask;
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 997c50d23..ae7f66b80 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -3138,14 +3138,14 @@ fhandler_console::get_console_process_id (DWORD pid, bool match)
   DWORD tmp;
   int num = GetConsoleProcessList (&tmp, 1);
   DWORD *list = (DWORD *)
-	      HeapAlloc (GetProcessHeap (), 0, num * sizeof (DWORD));
-  num = GetConsoleProcessList (list, num);
+	      HeapAlloc (GetProcessHeap (), 0, (num + 16) * sizeof (DWORD));
+  num = GetConsoleProcessList (list, num + 16);
   tmp = 0;
   for (int i=0; i<num; i++)
     if ((match && list[i] == pid) || (!match && list[i] != pid))
       {
 	tmp = list[i];
-	//break;
+	break;
       }
   HeapFree (GetProcessHeap (), 0, list);
   return tmp;
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index dd5ab528a..2b9c3f3ed 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -71,7 +71,7 @@ struct pipe_reply {
   DWORD error;
 };
 
-static bool pcon_attached[NTTYS];
+static int pcon_attached_to = -1;
 static bool isHybrid;
 
 #if USE_API_HOOK
@@ -129,7 +129,6 @@ set_switch_to_pcon (void)
 	fhandler_base *fh = cfd;
 	fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	ptys->set_switch_to_pcon ();
-	return;
       }
 }
 
@@ -381,25 +380,6 @@ fhandler_pty_common::__release_output_mutex (const char *fn, int ln)
 #endif
 }
 
-static bool switch_to_pcon_prev;
-
-bool
-fhandler_pty_common::check_switch_to_pcon (void)
-{
-  bool switch_to_pcon_now = get_ttyp ()->switch_to_pcon;
-  if (!isHybrid && !switch_to_pcon_prev && switch_to_pcon_now)
-    {
-      Sleep (40);
-      /* Check again */
-      switch_to_pcon_now = get_ttyp ()->switch_to_pcon;
-      if (switch_to_pcon_now)
-	switch_to_pcon_prev = true;
-    }
-  else
-    switch_to_pcon_prev = switch_to_pcon_now;
-  return switch_to_pcon_prev;
-}
-
 /* Process pty input. */
 
 void
@@ -595,7 +575,7 @@ out:
 
 fhandler_pty_slave::fhandler_pty_slave (int unit)
   : fhandler_pty_common (), inuse (NULL), output_handle_cyg (NULL),
-  io_handle_cyg (NULL)
+  io_handle_cyg (NULL), pidRestore (0)
 {
   if (unit >= 0)
     dev ().parse (DEV_PTYS_MAJOR, unit);
@@ -604,32 +584,34 @@ fhandler_pty_slave::fhandler_pty_slave (int unit)
 fhandler_pty_slave::~fhandler_pty_slave ()
 {
   if (!get_ttyp ())
-    {
-      /* Why it comes here? */
-      init_console_handler (false);
-      FreeConsole ();
-      pcon_attached[get_minor ()] = false;
-    }
-  else if (getPseudoConsole ())
+    /* Why comes here? Who clears _tc? */
+    return;
+  mask_switch_to_pcon (false);
+  if (getPseudoConsole ())
     {
       int used = 0;
+      int attached = 0;
       cygheap_fdenum cfd (false);
       while (cfd.next () >= 0)
-	if (cfd->get_major () == DEV_PTYS_MAJOR &&
-	    cfd->get_minor () == get_minor ())
-	  used ++;
-
-      /* Call FreeConsole() if no pty slave on this pty is
-	 opened and the process is attached to the pseudo
-	 console corresponding to this pty. This is needed
-	 to make GNU screen and tmux work in Windows 10 1903. */
-      if (used == 0 &&
-	  fhandler_console::get_console_process_id (getHelperProcessId (),
-						    true))
+	{
+	  if (cfd->get_major () == DEV_PTYS_MAJOR ||
+	      cfd->get_major () == DEV_CONS_MAJOR)
+	    used ++;
+	  if (cfd->get_major () == DEV_PTYS_MAJOR &&
+	      cfd->get_minor () == pcon_attached_to)
+	    attached ++;
+	}
+
+      /* Call FreeConsole() if no tty is opened and the process
+	 is attached to console corresponding to tty. This is
+	 needed to make GNU screen and tmux work in Windows 10
+	 1903. */
+      if (attached == 0)
+	pcon_attached_to = -1;
+      if (used == 0)
 	{
 	  init_console_handler (false);
 	  FreeConsole ();
-	  pcon_attached[get_minor ()] = false;
 	}
     }
 }
@@ -813,7 +795,38 @@ fhandler_pty_slave::open (int flags, mode_t)
   set_output_handle (to_master_local);
   set_output_handle_cyg (to_master_cyg_local);
 
-  fhandler_console::need_invisible ();
+  if (!getPseudoConsole () || ALWAYS_USE_PCON)
+    {
+      fhandler_console::need_invisible ();
+      pcon_attached_to = -1;
+    }
+#if 0
+  else if (!fhandler_console::get_console_process_id
+				     (GetCurrentProcessId (), true))
+    {
+      /* Not attached to any console */
+      if (AttachConsole (getHelperProcessId ()))
+	{
+	  pcon_attached_to = get_minor ();
+	  init_console_handler (true);
+	}
+      else
+	{
+	  fhandler_console::need_invisible ();
+	  pcon_attached_to = -1;
+	}
+    }
+#endif
+  else if (fhandler_console::get_console_process_id
+				     (getHelperProcessId (), true))
+    /* Attached to pcon of this pty */
+    {
+      pcon_attached_to = get_minor ();
+      init_console_handler (true);
+    }
+  else if (pcon_attached_to < 0)
+    fhandler_console::need_invisible ();
+
   set_open_status ();
   return 1;
 
@@ -855,26 +868,6 @@ fhandler_pty_slave::cleanup ()
 int
 fhandler_pty_slave::close ()
 {
-#if 0
-  if (getPseudoConsole ())
-    {
-      INPUT_RECORD inp[128];
-      DWORD n;
-      PeekFunc =
-	PeekConsoleInputA_Orig ? PeekConsoleInputA_Orig : PeekConsoleInput;
-      PeekFunc (get_handle (), inp, 128, &n);
-      bool pipe_empty = true;
-      while (n-- > 0)
-	if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
-	  pipe_empty = false;
-      if (pipe_empty)
-	{
-	  /* Flush input buffer */
-	  size_t len = UINT_MAX;
-	  read (NULL, len);
-	}
-    }
-#endif
   termios_printf ("closing last open %s handle", ttyname ());
   if (inuse && !CloseHandle (inuse))
     termios_printf ("CloseHandle (inuse), %E");
@@ -886,12 +879,13 @@ fhandler_pty_slave::close ()
   if (!ForceCloseHandle (get_handle_cyg ()))
     termios_printf ("CloseHandle (get_handle_cyg ()<%p>), %E",
 	get_handle_cyg ());
-  if ((unsigned) myself->ctty == FHDEV (DEV_PTYS_MAJOR, get_minor ()))
+  if (!getPseudoConsole () &&
+      (unsigned) myself->ctty == FHDEV (DEV_PTYS_MAJOR, get_minor ()))
     fhandler_console::free_console ();	/* assumes that we are the last pty closer */
   fhandler_pty_common::close ();
   if (!ForceCloseHandle (output_mutex))
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
-  if (pcon_attached[get_minor ()])
+  if (pcon_attached_to == get_minor ())
     get_ttyp ()->num_pcon_attached_slaves --;
   return 0;
 }
@@ -936,14 +930,53 @@ fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t)
   return ret;
 }
 
+bool
+fhandler_pty_slave::try_reattach_pcon (void)
+{
+  pidRestore = 0;
+
+  /* Do not detach from the console because re-attaching will
+     fail if helper process is running as service account. */
+  if (pcon_attached_to >= 0 &&
+      cygwin_shared->tty[pcon_attached_to]->attach_pcon_in_fork)
+    return false;
+
+  pidRestore =
+    fhandler_console::get_console_process_id (GetCurrentProcessId (),
+					      false);
+  /* If pidRestore is not set, give up. */
+  if (!pidRestore)
+    return false;
+
+  FreeConsole ();
+  if (!AttachConsole (getHelperProcessId ()))
+    {
+      system_printf ("pty%d: AttachConsole(helper=%d) failed. 0x%08lx",
+		     get_minor (), getHelperProcessId (), GetLastError ());
+      return false;
+    }
+  return true;
+}
+
 void
-fhandler_pty_slave::set_switch_to_pcon (void)
+fhandler_pty_slave::restore_reattach_pcon (void)
 {
-  if (!pcon_attached[get_minor ()])
+  if (pidRestore)
     {
-      isHybrid = false;
-      return;
+      FreeConsole ();
+      if (!AttachConsole (pidRestore))
+	{
+	  system_printf ("pty%d: AttachConsole(restore=%d) failed. 0x%08lx",
+			 get_minor (), pidRestore, GetLastError ());
+	  pcon_attached_to = -1;
+	}
     }
+  pidRestore = 0;
+}
+
+void
+fhandler_pty_slave::set_switch_to_pcon (void)
+{
   if (!isHybrid)
     {
       reset_switch_to_pcon ();
@@ -951,6 +984,16 @@ fhandler_pty_slave::set_switch_to_pcon (void)
     }
   if (!get_ttyp ()->switch_to_pcon)
     {
+      pidRestore = 0;
+      if (pcon_attached_to != get_minor ())
+	if (!try_reattach_pcon ())
+	  goto skip_console_setting;
+      FlushConsoleInputBuffer (get_handle ());
+      DWORD mode;
+      GetConsoleMode (get_handle (), &mode);
+      SetConsoleMode (get_handle (), mode | ENABLE_ECHO_INPUT);
+skip_console_setting:
+      restore_reattach_pcon ();
       Sleep (20);
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
@@ -980,7 +1023,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       DWORD mode;
       GetConsoleMode (get_handle (), &mode);
       SetConsoleMode (get_handle (), mode & ~ENABLE_ECHO_INPUT);
-      Sleep (60); /* Wait for pty_master_fwd_thread() */
+      Sleep (20); /* Wait for pty_master_fwd_thread() */
     }
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon = false;
@@ -989,43 +1032,31 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 void
 fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
 {
-  DWORD pidRestore = 0;
-  if (!fhandler_console::get_console_process_id (getHelperProcessId (), true))
-    if (pcon_attached[get_minor ()])
-      {
-	Sleep (20);
-	/* Check again */
-	if (!fhandler_console::get_console_process_id
-				    (getHelperProcessId (), true))
-	  {
-	    system_printf ("pty%d: pcon_attach mismatch?????? (%p)",
-			   get_minor (), this);
-	    //pcon_attached[get_minor ()] = false;
-	    return;
-	  }
-      }
-  /* If not attached pseudo console yet, try to attach temporally. */
-  if (!pcon_attached[get_minor ()])
+  bool attached =
+    !!fhandler_console::get_console_process_id (getHelperProcessId (), true);
+  if (!attached && pcon_attached_to == get_minor ())
     {
-      if (has_master_opened ())
-	return;
-
-      pidRestore =
-	fhandler_console::get_console_process_id (GetCurrentProcessId (),
-						  false);
-      /* If pidRestore is not set, give up to push. */
-      if (!pidRestore)
-	return;
-
-      FreeConsole ();
-      if (!AttachConsole (getHelperProcessId ()))
+      for (DWORD t0 = GetTickCount (); GetTickCount () - t0 < 100; )
+	{
+	  Sleep (1);
+	  attached = fhandler_console::get_console_process_id
+				      (getHelperProcessId (), true);
+	  if (attached)
+	    break;
+	}
+      if (!attached)
 	{
-	  system_printf ("pty%d: AttachConsole(%d) failed. (%p) %08lx",
-			 get_minor (), getHelperProcessId (),
-			 this, GetLastError ());
-	  goto detach;
+	  system_printf ("pty%d: pcon_attach_to mismatch??????", get_minor ());
+	  return;
 	}
     }
+
+  /* If not attached to this pseudo console, try to attach temporarily. */
+  pidRestore = 0;
+  if (pcon_attached_to != get_minor ())
+    if (!try_reattach_pcon ())
+      goto detach;
+
   char *buf;
   size_t nlen;
   DWORD origCP;
@@ -1067,7 +1098,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
     }
   if (!nlen) /* Nothing to be synchronized */
     goto cleanup;
-  if (check_switch_to_pcon ())
+  if (get_ttyp ()->switch_to_pcon)
     goto cleanup;
   /* Remove ESC sequence which returns results to console
      input buffer. Without this, cursor position report
@@ -1122,27 +1153,7 @@ cleanup:
   SetConsoleOutputCP (origCP);
   HeapFree (GetProcessHeap (), 0, buf);
 detach:
-  if (!pcon_attached[get_minor ()])
-    {
-      FreeConsole ();
-      if (!AttachConsole (pidRestore))
-	{
-	  system_printf ("pty%d: AttachConsole(%d) failed. (%p) %08lx",
-			 get_minor (), pidRestore, this, GetLastError ());
-	  pcon_attached[get_minor ()] = false;
-	}
-    }
-}
-
-bool
-fhandler_pty_slave::has_master_opened (void)
-{
-  cygheap_fdenum cfd (false);
-  while (cfd.next () >= 0)
-    if (cfd->get_major () == DEV_PTYM_MAJOR &&
-	cfd->get_minor () == get_minor ())
-      return true;
-  return false;
+  restore_reattach_pcon ();
 }
 
 ssize_t __stdcall
@@ -1162,7 +1173,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 
   char *buf;
   ssize_t nlen;
-  UINT targetCodePage = (check_switch_to_pcon ()) ?
+  UINT targetCodePage = get_ttyp ()->switch_to_pcon ?
     GetConsoleOutputCP () : get_ttyp ()->TermCodePage;
   if (targetCodePage != get_ttyp ()->TermCodePage)
     {
@@ -1189,18 +1200,25 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
       nlen = len;
     }
 
+  /* If not attached this pseudo console, try to attach temporarily. */
+  pidRestore = 0;
+  bool fallback = false;
+  if (get_ttyp ()->switch_to_pcon && pcon_attached_to != get_minor ())
+    if (!try_reattach_pcon ())
+      fallback = true;
+
   DWORD dwMode, flags;
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   if (!(get_ttyp ()->ti.c_oflag & OPOST) ||
       !(get_ttyp ()->ti.c_oflag & ONLCR))
     flags |= DISABLE_NEWLINE_AUTO_RETURN;
-  if (check_switch_to_pcon ())
+  if (get_ttyp ()->switch_to_pcon && !fallback)
     {
       GetConsoleMode (get_output_handle (), &dwMode);
       SetConsoleMode (get_output_handle (), dwMode | flags);
     }
-  HANDLE to =
-    check_switch_to_pcon () ? get_output_handle () : get_output_handle_cyg ();
+  HANDLE to = (get_ttyp ()->switch_to_pcon && !fallback) ?
+    get_output_handle () : get_output_handle_cyg ();
   acquire_output_mutex (INFINITE);
   if (!process_opost_output (to, buf, nlen, false))
     {
@@ -1219,9 +1237,11 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   release_output_mutex ();
   HeapFree (GetProcessHeap (), 0, buf);
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
-  if (check_switch_to_pcon ())
+  if (get_ttyp ()->switch_to_pcon && !fallback)
     SetConsoleMode (get_output_handle (), dwMode | flags);
 
+  restore_reattach_pcon ();
+
   /* Push slave output to pseudo console screen buffer */
   if (getPseudoConsole ())
     {
@@ -1361,9 +1381,15 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    }
 	  goto out;
 	}
-      if (check_switch_to_pcon () &&
-	  !get_ttyp ()->mask_switch_to_pcon)
+      if (get_ttyp ()->switch_to_pcon &&
+	  (!get_ttyp ()->mask_switch_to_pcon || ALWAYS_USE_PCON))
 	{
+	  if (!try_reattach_pcon ())
+	    {
+	      restore_reattach_pcon ();
+	      goto do_read_cyg;
+	    }
+
 	  DWORD dwMode;
 	  GetConsoleMode (get_handle (), &dwMode);
 	  DWORD flags = ENABLE_VIRTUAL_TERMINAL_INPUT;
@@ -1406,8 +1432,13 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	    ResetEvent (input_available_event);
 	  ReleaseMutex (input_mutex);
 	  len = rlen;
+
+	  restore_reattach_pcon ();
+	  mask_switch_to_pcon (false);
 	  return;
 	}
+
+do_read_cyg:
       if (!bytes_available (bytes_in_pipe))
 	{
 	  ReleaseMutex (input_mutex);
@@ -1675,31 +1706,12 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
     case TIOCSWINSZ:
       if (getPseudoConsole ())
 	{
-	  /* If not attached pseudo console yet, try to attach
-	     temporally. */
-	  DWORD pidRestore = 0;
-	  if (!pcon_attached[get_minor ()])
-	    {
-	      if (has_master_opened () && get_ttyp ()->attach_pcon_in_fork)
-		goto resize_cyg;
-
-	      pidRestore = fhandler_console::get_console_process_id
-		(GetCurrentProcessId (), false);
-
-	      /* This happens at mintty startup if fhandler_console::
-		 need_invisible() is called in stdio_init() in dtable.cc */
-	      if (!pidRestore) /* Give up to resize pseudo console */
-		goto resize_cyg;
+	  /* If not attached this pseudo console, try to attach temporarily. */
+	  pidRestore = 0;
+	  if (pcon_attached_to != get_minor ())
+	    if (!try_reattach_pcon ())
+	      goto cleanup;
 
-	      FreeConsole ();
-	      if (!AttachConsole (getHelperProcessId ()))
-		{
-		  system_printf ("pty%d: AttachConsole(%d) failed. (%p) %08lx",
-				 get_minor(), getHelperProcessId (),
-				 this, GetLastError ());
-		  goto cleanup;
-		}
-	    }
 	  COORD size;
 	  size.X = ((struct winsize *) arg)->ws_col;
 	  size.Y = ((struct winsize *) arg)->ws_row;
@@ -1717,20 +1729,9 @@ fhandler_pty_slave::ioctl (unsigned int cmd, void *arg)
 	  rect.Bottom = size.Y-1;
 	  SetConsoleWindowInfo (get_output_handle (), TRUE, &rect);
 cleanup:
-	  /* Detach from pseudo console and resume. */
-	  if (pidRestore)
-	    {
-	      FreeConsole ();
-	      if (!AttachConsole (pidRestore))
-		{
-		  system_printf ("pty%d: AttachConsole(%d) failed. (%p) %08lx",
-				 get_minor (), pidRestore,
-				 this, GetLastError ());
-		  pcon_attached[get_minor ()] = false;
-		}
-	    }
+	  restore_reattach_pcon ();
 	}
-resize_cyg:
+
       if (get_ttyp ()->winsize.ws_row != ((struct winsize *) arg)->ws_row
 	  || get_ttyp ()->winsize.ws_col != ((struct winsize *) arg)->ws_col)
 	{
@@ -2106,7 +2107,7 @@ fhandler_pty_master::close ()
 	      ClosePseudoConsole = (VOID (WINAPI *) (HPCON)) func;
 	      ClosePseudoConsole (getPseudoConsole ());
 	    }
-	  get_ttyp ()->hPseudoConsole = NULL;
+	  //get_ttyp ()->hPseudoConsole = NULL; // Do not clear for safty.
 	  get_ttyp ()->switch_to_pcon = false;
 	}
       if (get_ttyp ()->getsid () > 0)
@@ -2160,8 +2161,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* Write terminal input to to_slave pipe instead of output_handle
      if current application is native console application. */
-  if (check_switch_to_pcon () &&
-      !get_ttyp ()->mask_switch_to_pcon)
+  if (get_ttyp ()->switch_to_pcon &&
+      (!get_ttyp ()->mask_switch_to_pcon || ALWAYS_USE_PCON))
     {
       char *buf;
       size_t nlen;
@@ -2770,8 +2771,9 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
       if (fhandler_console::get_console_process_id (getHelperProcessId (),
 						    true))
 	{
-	  if (!pcon_attached[get_minor ()])
+	  if (pcon_attached_to != get_minor ())
 	    {
+	      pcon_attached_to = get_minor ();
 	      init_console_handler (true);
 #if USE_OWN_NLS_FUNC
 	      char locale[ENCODING_LEN + 1] = "C";
@@ -2856,19 +2858,20 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 			   "\033[H\033[J", 6, &n, NULL);
 #endif
 
-	      pcon_attached[get_minor ()] = true;
 	      get_ttyp ()->num_pcon_attached_slaves ++;
 	    }
 	}
-      else
-	pcon_attached[get_minor ()] = false;
     }
-  if (pcon_attached[get_minor ()] && native_maybe)
+  if (pcon_attached_to == get_minor () && (native_maybe || ALWAYS_USE_PCON))
     {
       FlushConsoleInputBuffer (get_handle ());
       DWORD mode;
       GetConsoleMode (get_handle (), &mode);
-      SetConsoleMode (get_handle (), mode | ENABLE_ECHO_INPUT);
+      SetConsoleMode (get_handle (),
+		      (mode & ~ENABLE_VIRTUAL_TERMINAL_INPUT) |
+		      ENABLE_ECHO_INPUT |
+		      ENABLE_LINE_INPUT |
+		      ENABLE_PROCESSED_INPUT);
       Sleep (20);
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
@@ -2896,23 +2899,28 @@ fhandler_pty_slave::fixup_after_exec ()
   else if (getPseudoConsole ())
     {
       int used = 0;
+      int attached = 0;
       cygheap_fdenum cfd (false);
       while (cfd.next () >= 0)
-	if (cfd->get_major () == DEV_PTYS_MAJOR &&
-	    cfd->get_minor () == get_minor ())
-	  used ++;
-
-      /* Call FreeConsole() if no pty slave on this pty is
-	 opened and the process is attached to the pseudo
-	 console corresponding to this pty. This is needed
-	 to make GNU screen and tmux work in Windows 10 1903. */
-      if (used == 1 /* About to close this one */ &&
-	  fhandler_console::get_console_process_id (getHelperProcessId (),
-						    true))
+	{
+	  if (cfd->get_major () == DEV_PTYS_MAJOR ||
+	      cfd->get_major () == DEV_CONS_MAJOR)
+	    used ++;
+	  if (cfd->get_major () == DEV_PTYS_MAJOR &&
+	      cfd->get_minor () == pcon_attached_to)
+	    attached ++;
+	}
+
+      /* Call FreeConsole() if no tty is opened and the process
+	 is attached to console corresponding to tty. This is
+	 needed to make GNU screen and tmux work in Windows 10
+	 1903. */
+      if (attached == 1 && get_minor () == pcon_attached_to)
+	pcon_attached_to = -1;
+      if (used == 1 /* About to close this tty */)
 	{
 	  init_console_handler (false);
 	  FreeConsole ();
-	  pcon_attached[get_minor ()] = false;
 	}
     }
 
@@ -3119,7 +3127,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	{
 	  /* Avoid duplicating slave output which is already sent to
 	     to_master_cyg */
-	  if (!check_switch_to_pcon ())
+	  if (!get_ttyp ()->switch_to_pcon)
 	    continue;
 
 	  /* Avoid setting window title to "cygwin-console-helper.exe" */
@@ -3134,25 +3142,42 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      }
 	    else if ((state == 1 && outbuf[i] == ']') ||
 		     (state == 2 && outbuf[i] == '0') ||
-		     (state == 3 && outbuf[i] == ';') ||
-		     (state == 4 && outbuf[i] == '\0'))
+		     (state == 3 && outbuf[i] == ';'))
 	      {
 		state ++;
 		continue;
 	      }
-	    else if (state == 5 && outbuf[i] == '\a')
+	    else if (state == 4 && outbuf[i] == '\a')
 	      {
 		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
 		state = 0;
 		rlen = wlen = start_at + rlen - i - 1;
 		continue;
 	      }
-	    else if (state != 4 || outbuf[i] == '\a')
+	    else if (outbuf[i] == '\a')
 	      {
 		state = 0;
 		continue;
 	      }
 
+	  /* Remove ESC sequence which returns results to console
+	     input buffer. Without this, cursor position report
+	     is put into the input buffer as a garbage. */
+	  /* Remove ESC sequence to report cursor position. */
+	  char *p0;
+	  while ((p0 = (char *) memmem (outbuf, rlen, "\033[6n", 4)))
+	    {
+	      memmove (p0, p0+4, rlen - (p0+4 - outbuf));
+	      rlen -= 4;
+	    }
+	  /* Remove ESC sequence to report terminal identity. */
+	  while ((p0 = (char *) memmem (outbuf, rlen, "\033[0c", 4)))
+	    {
+	      memmove (p0, p0+4, rlen - (p0+4 - outbuf));
+	      rlen -= 4;
+	    }
+	  wlen = rlen;
+
 	  char *buf;
 	  size_t nlen;
 	  if (get_ttyp ()->TermCodePage != CP_UTF8)
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 0c089dbe9..a3a7e7505 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -140,20 +140,24 @@ frok::child (volatile char * volatile here)
       {
 	fhandler_base *fh = cfd;
 	fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
-	if (ptym->getPseudoConsole () &&
-	    !fhandler_console::get_console_process_id (
-				ptym->getHelperProcessId (), true))
-
+	if (ptym->getPseudoConsole ())
 	  {
 	    debug_printf ("found a PTY master %d: helper_PID=%d",
 			  ptym->get_minor (), ptym->getHelperProcessId ());
-	    if (ptym->attach_pcon_in_fork ())
+	    if (fhandler_console::get_console_process_id (
+				ptym->getHelperProcessId (), true))
+	      /* Already attached */
+	      break;
+	    else
 	      {
-		FreeConsole ();
-		if (!AttachConsole (ptym->getHelperProcessId ()))
-		  /* Error */;
-		else
-		  break;
+		if (ptym->attach_pcon_in_fork ())
+		  {
+		    FreeConsole ();
+		    if (!AttachConsole (ptym->getHelperProcessId ()))
+		      /* Error */;
+		    else
+		      break;
+		  }
 	      }
 	  }
       }
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 98612bd0f..4bb28c47b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -578,53 +578,62 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       pidRestore = fhandler_console::get_console_process_id
 	(GetCurrentProcessId (), false);
       fhandler_pty_slave *ptys = NULL;
-      for (int fd = 0; fd < 3; fd ++)
+      int chk_order[] = {1, 0, 2};
+      for (int i = 0; i < 3; i ++)
 	{
+	  int fd = chk_order[i];
 	  fhandler_base *fh = ::cygheap->fdtab[fd];
 	  if (fh && fh->get_major () == DEV_PTYS_MAJOR)
 	    {
 	      ptys = (fhandler_pty_slave *) fh;
-	      if (ptys->getPseudoConsole () &&
-		  !fhandler_console::get_console_process_id (
-				     ptys->getHelperProcessId (), true))
+	      if (ptys->getPseudoConsole ())
 		{
 		  DWORD dwHelperProcessId = ptys->getHelperProcessId ();
 		  debug_printf ("found a PTY slave %d: helper_PID=%d",
-				fh->get_minor (), dwHelperProcessId);
-		  FreeConsole ();
-		  if (!AttachConsole (dwHelperProcessId))
+				    fh->get_minor (), dwHelperProcessId);
+		  if (fhandler_console::get_console_process_id
+					      (dwHelperProcessId, true))
 		    {
-		      /* Fallback */
-		      DWORD target[3] = {
-			STD_INPUT_HANDLE,
-			STD_OUTPUT_HANDLE,
-			STD_ERROR_HANDLE
-		      };
-		      if (fd == 0)
+		      /* Already attached */
+		      attach_to_pcon = true;
+		      break;
+		    }
+		  else
+		    {
+		      FreeConsole ();
+		      if (AttachConsole (dwHelperProcessId))
 			{
-			  ptys->set_handle (ptys->get_handle_cyg ());
-			  SetStdHandle (target[fd],
-					ptys->get_handle ());
+			  attach_to_pcon = true;
+			  break;
 			}
 		      else
 			{
-			  ptys->set_output_handle (
-				       ptys->get_output_handle_cyg ());
-			  SetStdHandle (target[fd],
-					ptys->get_output_handle ());
+			  /* Fallback */
+			  DWORD target[3] = {
+			    STD_INPUT_HANDLE,
+			    STD_OUTPUT_HANDLE,
+			    STD_ERROR_HANDLE
+			  };
+			  if (fd == 0)
+			    {
+			      ptys->set_handle (ptys->get_handle_cyg ());
+			      SetStdHandle (target[fd],
+					    ptys->get_handle ());
+			    }
+			  else if (fd < 3)
+			    {
+			      ptys->set_output_handle (
+					   ptys->get_output_handle_cyg ());
+			      SetStdHandle (target[fd],
+					    ptys->get_output_handle ());
+			    }
 			}
 		    }
-		  else
-		    {
-		      init_console_handler (true);
-		      attach_to_pcon = true;
-		      break;
-		    }
 		}
 	    }
 	}
       if (ptys)
-	ptys->fixup_after_attach (true);
+	ptys->fixup_after_attach (!iscygwin ());
 
     loop:
       /* When ruid != euid we create the new process under the current original
-- 
2.21.0
