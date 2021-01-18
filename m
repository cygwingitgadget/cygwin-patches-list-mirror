Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 8DD59385B805
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:25:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8DD59385B805
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10IBPHAK007817;
 Mon, 18 Jan 2021 20:25:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10IBPHAK007817
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 4/5] Cygwin: pty: Prevent pty from changing code page of
 parent console.
Date: Mon, 18 Jan 2021 20:24:47 +0900
Message-Id: <20210118112447.1518-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:25:41 -0000

- After commit 232fde0e, pty changes console code page when the first
  non-cygwin app is executed. If pty is started in real console device,
  pty changes the code page of root console. This causes very annoying
  result because changing code page changes the font of command prompt
  if console is in legacy mode. This patch avoids this by creating a
  new invisible console for the first pty started in console device.
---
 winsup/cygwin/fhandler.h          |   5 +-
 winsup/cygwin/fhandler_console.cc |  38 +++++++--
 winsup/cygwin/fhandler_tty.cc     | 133 +++++++++++++++++++++++++++++-
 winsup/cygwin/spawn.cc            |   1 +
 winsup/cygwin/tty.cc              |   2 +
 winsup/cygwin/tty.h               |   2 +
 6 files changed, 170 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 2077b5245..a0c6645fb 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2127,7 +2127,7 @@ private:
   int input_tcsetattr (int a, const struct termios *t);
   void set_cursor_maybe ();
   static bool create_invisible_console (HWINSTA);
-  static bool create_invisible_console_workaround ();
+  static bool create_invisible_console_workaround (bool force);
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
   void fix_tab_position (void);
 
@@ -2185,7 +2185,7 @@ private:
   bool send_winch_maybe ();
   void setup ();
   bool set_unit ();
-  static bool need_invisible ();
+  static bool need_invisible (bool force = false);
   static void free_console ();
   static const char *get_nonascii_key (INPUT_RECORD& input_rec, char *);
 
@@ -2346,6 +2346,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void mask_switch_to_pcon_in (bool mask);
   void setup_locale (void);
   tty *get_ttyp () { return (tty *) tc (); } /* Override as public */
+  void create_invisible_console (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index a4c054e24..dd00079fa 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -53,6 +53,23 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 
 bool NO_COPY fhandler_console::invisible_console;
 
+/* Mutex for AttachConsole()/FreeConsole() in fhandler_tty.cc */
+HANDLE NO_COPY attach_mutex;
+
+static inline void
+acquire_attach_mutex (DWORD t)
+{
+  if (attach_mutex)
+    WaitForSingleObject (attach_mutex, t);
+}
+
+static inline void
+release_attach_mutex ()
+{
+  if (attach_mutex)
+    ReleaseMutex (attach_mutex);
+}
+
 /* con_ra is shared in the same process.
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
@@ -599,6 +616,8 @@ fhandler_console::process_input_message (void)
   if (!shared_console_info)
     return input_error;
 
+  acquire_attach_mutex (INFINITE);
+
   termios *ti = &(get_ttyp ()->ti);
 
   fhandler_console::input_states stat = input_processing;
@@ -608,6 +627,7 @@ fhandler_console::process_input_message (void)
   if (!PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read))
     {
       termios_printf ("PeekConsoleInput failed, %E");
+      release_attach_mutex ();
       return input_error;
     }
 
@@ -972,6 +992,7 @@ out:
   /* Discard processed recored. */
   DWORD dummy;
   ReadConsoleInputW (get_handle (), input_rec, min (total_read, i+1), &dummy);
+  release_attach_mutex ();
   return stat;
 }
 
@@ -2973,6 +2994,7 @@ fhandler_console::write (const void *vsrc, size_t len)
   if (bg <= bg_eof)
     return (ssize_t) bg;
 
+  acquire_attach_mutex (INFINITE);
   push_process_state process_state (PID_TTYOU);
   acquire_output_mutex (INFINITE);
 
@@ -3298,6 +3320,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 
   syscall_printf ("%ld = fhandler_console::write(...)", len);
 
+  release_attach_mutex ();
   return len;
 }
 
@@ -3469,12 +3492,13 @@ fhandler_console::create_invisible_console (HWINSTA horig)
    function is currently only called at startup and during exec, it shouldn't
    be a big deal.  */
 bool
-fhandler_console::create_invisible_console_workaround ()
+fhandler_console::create_invisible_console_workaround (bool force)
 {
-  if (!AttachConsole (-1))
+  /* If force is set, avoid to reattach to existing console. */
+  if (force || !AttachConsole (-1))
     {
       bool taskbar;
-      DWORD err = GetLastError ();
+      DWORD err = force ? 0 : GetLastError ();
       path_conv helper ("/bin/cygwin-console-helper.exe");
       HANDLE hello = NULL;
       HANDLE goodbye = NULL;
@@ -3559,10 +3583,12 @@ fhandler_console::free_console ()
 }
 
 bool
-fhandler_console::need_invisible ()
+fhandler_console::need_invisible (bool force)
 {
   BOOL b = false;
-  if (exists ())
+  /* If force is set, forcibly create a new invisible console
+     even if a console device already exists. */
+  if (exists () && !force)
     invisible_console = false;
   else
     {
@@ -3600,7 +3626,7 @@ fhandler_console::need_invisible ()
 	  invisible_console = true;
 	}
       else if (wincap.has_broken_alloc_console ())
-	b = create_invisible_console_workaround ();
+	b = create_invisible_console_workaround (force);
       else
 	b = create_invisible_console (h);
     }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0c92f41d4..b19d7d31b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -59,6 +59,46 @@ struct pipe_reply {
   DWORD error;
 };
 
+extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
+
+static DWORD
+get_console_process_id (DWORD pid, bool match)
+{
+  DWORD list1;
+  DWORD num, num_req;
+  num = 1;
+  num_req = GetConsoleProcessList (&list1, num);
+  DWORD *list;
+  if (num_req == 1)
+    list = &list1;
+  else
+    while (true)
+      {
+	list = (DWORD *)
+	  HeapAlloc (GetProcessHeap (), 0, num_req * sizeof (DWORD));
+	num = num_req;
+	num_req = GetConsoleProcessList (list, num);
+	if (num_req > num)
+	  HeapFree (GetProcessHeap (), 0, list);
+	else
+	  break;
+      }
+  num = num_req;
+
+  DWORD res = 0;
+  /* Last one is the oldest. */
+  /* https://github.com/microsoft/terminal/issues/95 */
+  for (int i = (int) num - 1; i >= 0; i--)
+    if ((match && list[i] == pid) || (!match && list[i] != pid))
+      {
+	res = list[i];
+	break;
+      }
+  if (num > 1)
+    HeapFree (GetProcessHeap (), 0, list);
+  return res;
+}
+
 static bool isHybrid;
 
 static void
@@ -289,7 +329,33 @@ fhandler_pty_master::accept_input ()
   if (to_be_read_from_pcon ())
     {
       write_to = to_slave;
-      UINT cp_to = GetConsoleCP ();
+
+      UINT cp_to;
+      pinfo pinfo_target = pinfo (get_ttyp ()->invisible_console_pid);
+      DWORD target_pid = 0;
+      if (pinfo_target)
+	target_pid = pinfo_target->dwProcessId;
+      pinfo pinfo_resume = pinfo (myself->ppid);
+      DWORD resume_pid;
+      if (pinfo_resume)
+	resume_pid = pinfo_resume->dwProcessId;
+      else
+	resume_pid = get_console_process_id (myself->dwProcessId, false);
+      if (target_pid && resume_pid)
+	{
+	  /* Slave attaches to a different console than master.
+	     Therefore reattach here. */
+	  WaitForSingleObject (attach_mutex, INFINITE);
+	  FreeConsole ();
+	  AttachConsole (target_pid);
+	  cp_to = GetConsoleCP ();
+	  FreeConsole ();
+	  AttachConsole (resume_pid);
+	  ReleaseMutex (attach_mutex);
+	}
+      else
+	cp_to = GetConsoleCP ();
+
       if (get_ttyp ()->term_code_page != cp_to)
 	{
 	  static mbstate_t mbp;
@@ -659,7 +725,20 @@ fhandler_pty_slave::open (int flags, mode_t)
   set_output_handle (to_master_local);
   set_output_handle_cyg (to_master_cyg_local);
 
-  fhandler_console::need_invisible ();
+  if (_major (myself->ctty) == DEV_CONS_MAJOR
+      && !(!pinfo (myself->ppid) && getenv ("ConEmuPID")))
+    /* This process is supposed to be a master process which is
+       running on console. Invisible console will be created in
+       primary slave process to prevent overriding code page
+       of root console by setup_locale(). */
+    /* ... except for ConEmu cygwin-connector in which this
+       code does not work as expected because it calls Win32
+       API directly rather than cygwin read()/write(). Due to
+       this behaviour, protection based on attach_mutex does
+       not take effect. */
+    get_ttyp ()->need_invisible_console = true;
+  else
+    fhandler_console::need_invisible ();
 
   set_open_status ();
   return 1;
@@ -1572,6 +1651,7 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  master_fwd_thread->terminate_thread ();
+	  CloseHandle (attach_mutex);
 	}
     }
 
@@ -1847,6 +1927,7 @@ void
 fhandler_pty_slave::fixup_after_exec ()
 {
   reset_switch_to_pcon ();
+  create_invisible_console ();
 
   if (!close_on_exec ())
     fixup_after_fork (NULL);	/* No parent handle required. */
@@ -2135,7 +2216,32 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  continue;
 	}
 
-      UINT cp_from = GetConsoleOutputCP ();
+      UINT cp_from;
+      pinfo pinfo_target = pinfo (get_ttyp ()->invisible_console_pid);
+      DWORD target_pid = 0;
+      if (pinfo_target)
+	target_pid = pinfo_target->dwProcessId;
+      pinfo pinfo_resume = pinfo (myself->ppid);
+      DWORD resume_pid;
+      if (pinfo_resume)
+	resume_pid = pinfo_resume->dwProcessId;
+      else
+	resume_pid = get_console_process_id (myself->dwProcessId, false);
+      if (target_pid && resume_pid)
+	{
+	  /* Slave attaches to a different console than master.
+	     Therefore reattach here. */
+	  WaitForSingleObject (attach_mutex, INFINITE);
+	  FreeConsole ();
+	  AttachConsole (target_pid);
+	  cp_from = GetConsoleOutputCP ();
+	  FreeConsole ();
+	  AttachConsole (resume_pid);
+	  ReleaseMutex (attach_mutex);
+	}
+      else
+	cp_from = GetConsoleOutputCP ();
+
       if (get_ttyp ()->term_code_page != cp_from)
 	{
 	  size_t nlen = NT_MAX_PATH;
@@ -2250,6 +2356,8 @@ fhandler_pty_master::setup ()
   if (!(input_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
+  attach_mutex = CreateMutex (&sa, FALSE, NULL);
+
   /* Create master control pipe which allows the master to duplicate
      the pty pipe handles to processes which deserve it. */
   __small_sprintf (buf, "\\\\.\\pipe\\cygwin-%S-pty%d-master-ctl",
@@ -2311,6 +2419,7 @@ err:
   close_maybe (input_available_event);
   close_maybe (output_mutex);
   close_maybe (input_mutex);
+  close_maybe (attach_mutex);
   close_maybe (from_master);
   close_maybe (from_master_cyg);
   close_maybe (to_master);
@@ -2757,3 +2866,21 @@ maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
 }
+
+void
+fhandler_pty_slave::create_invisible_console ()
+{
+  if (get_ttyp ()->need_invisible_console)
+    {
+      /* Detach from console device and create new invisible console. */
+      FreeConsole();
+      fhandler_console::need_invisible (true);
+      get_ttyp ()->need_invisible_console = false;
+      get_ttyp ()->invisible_console_pid = myself->pid;
+    }
+  if (get_ttyp ()->invisible_console_pid
+      && !pinfo (get_ttyp ()->invisible_console_pid))
+    /* If primary slave process does not exist anymore,
+       this process becomes the primary. */
+    get_ttyp ()->invisible_console_pid = myself->pid;
+}
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index bf1b08057..42044ab53 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -648,6 +648,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      {
 		fhandler_pty_slave *ptys =
 		  (fhandler_pty_slave *)(fhandler_base *) cfd;
+		ptys->create_invisible_console ();
 		ptys->setup_locale ();
 	      }
 	}
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index d4b8d7651..c6e13f111 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -246,6 +246,8 @@ tty::init ()
   has_csi6n = false;
   has_set_title = false;
   do_not_resize_pcon = false;
+  need_invisible_console = false;
+  invisible_console_pid = 0;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 2c1ac7f5d..a975aba45 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -105,6 +105,8 @@ private:
   bool has_csi6n;
   bool has_set_title;
   bool do_not_resize_pcon;
+  bool need_invisible_console;
+  pid_t invisible_console_pid;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.30.0

