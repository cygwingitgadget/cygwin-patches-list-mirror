Return-Path: <SRS0=bHOJ=4U=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
	by sourceware.org (Postfix) with ESMTPS id 7461B3858D1E
	for <cygwin-patches@cygwin.com>; Thu, 22 Dec 2022 12:16:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7461B3858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 2BMCFgFs010632;
	Thu, 22 Dec 2022 21:15:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2BMCFgFs010632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671711347;
	bh=KDDqbHuwd5b1Tf2fvP2XxW7DxWAHnyz5pamwZb/MSLo=;
	h=From:To:Cc:Subject:Date:From;
	b=FoYZlMTp63MKp4t+UyQDERLnrfMupZOjteiR9JoL9mAPLC7e3z/aZmq6FHXxeyyiv
	 CV5vjw6qMMtUE4vCBwRW2dBgRvcPagYwaydVqNUy5o12QWCC9oOOs8noXE1o9ku2UY
	 Bs3goqmsGgFYg+AHB+cwcsDAek/u3CR1SPowOOvDWCKxFij9Ph4xcOlf6BjRElXQa5
	 kXiuGEaG6cby3SEJYlPnXgFxHMhH9iXpVGzcJ2M1IqyKyu1g3durRExFc4p4TbNZgo
	 v8lTOxqUYsWOhlBmrspYnB6AXdjHLD9nPToJTh7hm+8+qsTeDQIfRoooapZaalTU2r
	 cp8J225OEqZAA==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v3] Cygwin: console: Make the console accessible from other terminals.
Date: Thu, 22 Dec 2022 21:15:31 +0900
Message-Id: <20221222121531.8901-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SOMETLD_ARE_BAD_TLD,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the console device could not be accessed from other terminals.
Due to this limitation, GNU screen and tmux cannot be opened in console.
With this patch, console device can be accessed from other TTYs, such as
other consoles or ptys. Thanks to this patch, screen and tmux get working
in console.

Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/devices.cc                |  24 +-
 winsup/cygwin/devices.in                |  24 +-
 winsup/cygwin/fhandler/console.cc       | 474 ++++++++++++++++++------
 winsup/cygwin/fhandler/pty.cc           |   4 +-
 winsup/cygwin/local_includes/fhandler.h |  27 +-
 winsup/cygwin/local_includes/winsup.h   |   1 -
 winsup/cygwin/select.cc                 |   2 +
 7 files changed, 418 insertions(+), 138 deletions(-)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index 9f6e80acb..747dcc8c6 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -69,6 +69,21 @@ exists_ntdev_silent (const device& dev)
   return exists_ntdev (dev) ? -1 : false;
 }
 
+static BOOL CALLBACK
+enum_cons_dev (HWND hw, LPARAM lp)
+{
+  unsigned long *bitmask = (unsigned long *) lp;
+  HANDLE h = NULL;
+  fhandler_console::console_state *cs;
+  if ((cs = fhandler_console::open_shared_console (hw, h)))
+    {
+      *bitmask |= (1UL << cs->tty_min_state.getntty ());
+      UnmapViewOfFile ((void *) cs);
+      CloseHandle (h);
+    }
+  return TRUE;
+}
+
 static int
 exists_console (const device& dev)
 {
@@ -81,8 +96,13 @@ exists_console (const device& dev)
       return cygheap && cygheap->ctty && cygheap->ctty->is_console ()
 	&& fhandler_console::exists ();
     default:
-      /* Only show my own console device (for now?) */
-      return iscons_dev (myself->ctty) && myself->ctty == devn;
+      if (dev.get_minor () < MAX_CONS_DEV)
+	{
+	  unsigned long bitmask = 0;
+	  EnumWindows (enum_cons_dev, (LPARAM) &bitmask);
+	  return bitmask & (1UL << dev.get_minor ());
+	}
+      return false;
     }
 }
 
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index 48199f46c..a467cb593 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -65,6 +65,21 @@ exists_ntdev_silent (const device& dev)
   return exists_ntdev (dev) ? -1 : false;
 }
 
+static BOOL CALLBACK
+enum_cons_dev (HWND hw, LPARAM lp)
+{
+  unsigned long *bitmask = (unsigned long *) lp;
+  HANDLE h = NULL;
+  fhandler_console::console_state *cs;
+  if ((cs = fhandler_console::open_shared_console (hw, h)))
+    {
+      *bitmask |= (1UL << cs->tty_min_state.getntty ());
+      UnmapViewOfFile ((void *) cs);
+      CloseHandle (h);
+    }
+  return TRUE;
+}
+
 static int
 exists_console (const device& dev)
 {
@@ -77,8 +92,13 @@ exists_console (const device& dev)
       return cygheap && cygheap->ctty && cygheap->ctty->is_console ()
 	&& fhandler_console::exists ();
     default:
-      /* Only show my own console device (for now?) */
-      return iscons_dev (myself->ctty) && myself->ctty == devn;
+      if (dev.get_minor () < MAX_CONS_DEV)
+	{
+	  unsigned long bitmask = 0;
+	  EnumWindows (enum_cons_dev, (LPARAM) &bitmask);
+	  return bitmask & (1UL << dev.get_minor ());
+	}
+      return false;
     }
 }
 
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index ee07c84f8..ee392fda2 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -41,19 +41,20 @@ details. */
 #define ALT_PRESSED (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED)
 #define CTRL_PRESSED (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED)
 
-#define con (shared_console_info->con)
+#define con (shared_console_info[unit]->con)
 #define srTop (con.b.srWindow.Top + con.scroll_region.Top)
 #define srBottom ((con.scroll_region.Bottom < 0) ? \
 		  con.b.srWindow.Bottom : \
 		  con.b.srWindow.Top + con.scroll_region.Bottom)
-#define con_is_legacy (shared_console_info && con.is_legacy)
+#define con_is_legacy (shared_console_info[unit] && con.is_legacy)
 
 #define CONS_THREAD_SYNC "cygcons.thread_sync"
 static bool NO_COPY master_thread_started = false;
 
 const unsigned fhandler_console::MAX_WRITE_CHARS = 16384;
 
-fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
+fhandler_console::console_state NO_COPY
+  *fhandler_console::shared_console_info[MAX_CONS_DEV + 1];
 
 bool NO_COPY fhandler_console::invisible_console;
 
@@ -65,6 +66,56 @@ static struct fhandler_base::rabuf_t con_ra;
    in xterm compatible mode */
 static wchar_t last_char;
 
+DWORD
+fhandler_console::attach_console (pid_t owner, bool *err)
+{
+  DWORD resume_pid = (DWORD) -1;
+  pinfo p (owner);
+  if (p)
+    {
+      DWORD attached =
+	fhandler_pty_common::get_console_process_id (p->dwProcessId,
+						     true, false, false);
+      if (!attached)
+	{
+	  resume_pid =
+	    fhandler_pty_common::get_console_process_id (myself->dwProcessId,
+							 false, false, false);
+	  FreeConsole ();
+	  BOOL r = AttachConsole (p->dwProcessId);
+	  if (!r)
+	    {
+	      if (resume_pid)
+		AttachConsole (resume_pid);
+	      if (err)
+		*err = true;
+	      return (DWORD) -1;
+	    }
+	}
+    }
+  return resume_pid;
+}
+
+void
+fhandler_console::detach_console (DWORD resume_pid, pid_t owner)
+{
+  if (resume_pid == (DWORD) -1)
+    return;
+  if (resume_pid)
+    {
+      FreeConsole ();
+      AttachConsole (resume_pid);
+    }
+  else if (myself->pid != owner)
+    FreeConsole ();
+}
+
+pid_t
+fhandler_console::get_owner ()
+{
+  return con.owner;
+}
+
 /* simple helper class to accumulate output in a buffer
    and send that to the console on request: */
 static class write_pending_buffer
@@ -73,21 +124,19 @@ private:
   static const size_t WPBUF_LEN = 256u;
   char buf[WPBUF_LEN];
   size_t ixput;
-  HANDLE output_handle;
 public:
-  void init (HANDLE &handle)
+  void init ()
   {
-    output_handle = handle;
     empty ();
   }
-  inline void put (char x)
+  inline void put (HANDLE output_handle, pid_t owner, char x)
   {
     if (ixput == WPBUF_LEN)
-      send ();
+      send (output_handle, owner);
     buf[ixput++] = x;
   }
   inline void empty () { ixput = 0u; }
-  inline void send ()
+  inline void send (HANDLE output_handle, pid_t owner)
   {
     if (!output_handle)
       {
@@ -125,11 +174,25 @@ public:
 	  }
       }
     acquire_attach_mutex (mutex_timeout);
+    DWORD resume_pid = fhandler_console::attach_console (owner);
     WriteConsoleW (output_handle, bufw, len, NULL, 0);
+    fhandler_console::detach_console (resume_pid, owner);
     release_attach_mutex ();
   }
 } wpbuf;
 
+void
+fhandler_console::wpbuf_put (char c)
+{
+  wpbuf.put (get_output_handle (), con.owner, c);
+}
+
+void
+fhandler_console::wpbuf_send ()
+{
+  wpbuf.send (get_output_handle (), con.owner);
+}
+
 static void
 beep ()
 {
@@ -155,7 +218,7 @@ fhandler_console::open_shared_console (HWND hw, HANDLE& h, bool& create)
 
   shared_locations m = create ? SH_SHARED_CONSOLE : SH_JUSTOPEN;
   console_state *res = (console_state *)
-    open_shared (namebuf, 0, h, sizeof (*shared_console_info), &m);
+    open_shared (namebuf, 0, h, sizeof (console_state), &m);
   create = m != SH_JUSTOPEN;
   return res;
 }
@@ -182,7 +245,7 @@ enum_windows (HWND hw, LPARAM lp)
   fhandler_console::console_state *cs;
   if ((cs = fhandler_console::open_shared_console (hw, h)))
     {
-      this1->bitmask ^= 1 << cs->tty_min_state.getntty ();
+      this1->bitmask ^= 1UL << cs->tty_min_state.getntty ();
       UnmapViewOfFile ((void *) cs);
       CloseHandle (h);
     }
@@ -190,12 +253,12 @@ enum_windows (HWND hw, LPARAM lp)
 }
 
 console_unit::console_unit (HWND me0):
-  bitmask (0xffffffff), me (me0)
+  bitmask (~0UL), me (me0)
 {
   EnumWindows (enum_windows, (LPARAM) this);
   n = (_minor_t) ffs (bitmask) - 1;
   if (n < 0)
-    api_fatal ("console device allocation failure - too many consoles in use, max consoles is 32");
+    api_fatal ("console device allocation failure - too many consoles in use, max consoles is 64");
 }
 
 static DWORD
@@ -286,6 +349,7 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 void
 fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 {
+  const _minor_t unit = p->unit;
   const int additional_space = 128; /* Possible max number of incoming events
 				       during the process. Additional space
 				       should be left for writeback fix. */
@@ -436,7 +500,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		  con.scroll_region.Bottom = -1;
 		  if (wincap.has_con_24bit_colors () && !con_is_legacy
 		      && wincap.has_con_broken_tabs ())
-		    fix_tab_position (p->output_handle);
+		    fix_tab_position (p->output_handle, con.owner);
 		  ttyp->kill_pgrp (SIGWINCH);
 		}
 	      processed = true;
@@ -562,49 +626,95 @@ skip_writeback:
   free (input_tmp);
 }
 
+struct scan_console_args_t
+{
+  _minor_t unit;
+  fhandler_console::console_state **shared_console_info;
+};
+
+BOOL CALLBACK
+scan_console (HWND hw, LPARAM lp)
+{
+  scan_console_args_t *p = (scan_console_args_t *) lp;
+  HANDLE h = NULL;
+  fhandler_console::console_state *cs;
+  if ((cs = fhandler_console::open_shared_console (hw, h)))
+    {
+     if (p->unit == minor (cs->tty_min_state.getntty ()))
+       {
+	 *p->shared_console_info = cs;
+	 CloseHandle (h);
+	 return TRUE;
+       }
+      UnmapViewOfFile ((void *) cs);
+      CloseHandle (h);
+    }
+  return TRUE;
+}
+
 bool
 fhandler_console::set_unit ()
 {
-  bool created;
+  bool created = false;
   fh_devices devset;
   lock_ttys here;
   HWND me;
   fh_devices this_unit = dev ();
-  bool generic_console = this_unit == FH_CONIN || this_unit == FH_CONOUT;
-  if (shared_console_info)
-    {
-      fh_devices shared_unit =
-	(fh_devices) shared_console_info->tty_min_state.getntty ();
-      devset = (shared_unit == this_unit || this_unit == FH_CONSOLE
-		|| generic_console
-		|| this_unit == FH_TTY) ?
-		shared_unit : FH_ERROR;
-      created = false;
-    }
-  else if ((!generic_console &&
-	    (myself->ctty != -1 && !iscons_dev (myself->ctty)))
-	   || !(me = GetConsoleWindow ()))
+  bool generic_console =
+    this_unit == FH_CONSOLE || this_unit == FH_CONIN || this_unit == FH_CONOUT;
+  if (!generic_console && this_unit != FH_TTY)
+    unit = get_minor ();
+  else if (myself->ctty != -1)
+    unit = device::minor (myself->ctty);
+
+  if (shared_console_info[unit])
+    ; /* Do nothing */
+  else if (generic_console && myself->ctty != -1 && !iscons_dev (myself->ctty))
     devset = FH_ERROR;
   else
     {
-      created = true;
-      shared_console_info =
-	open_shared_console (me, cygheap->console_h, created);
-      ProtectHandleINH (cygheap->console_h);
-      if (created)
-	shared_console_info->
-	  tty_min_state.setntty (DEV_CONS_MAJOR, console_unit (me));
-      devset = (fh_devices) shared_console_info->tty_min_state.getntty ();
-      if (created)
-	con.owner = myself->pid;
+      if (!generic_console && (dev_t) myself->ctty != get_device ())
+	{
+	  /* Scan for existing shared console info */
+	  scan_console_args_t arg = { unit,  &shared_console_info[unit] };
+	  EnumWindows (scan_console, (LPARAM) &arg);
+	}
+      if (generic_console || !shared_console_info[unit])
+	{
+	  me = GetConsoleWindow ();
+	  if (!me)
+	    devset = FH_ERROR;
+	  else
+	    {
+	      created = true;
+	      fhandler_console::console_state *cs =
+		open_shared_console (me, cygheap->console_h, created);
+	      ProtectHandleINH (cygheap->console_h);
+	      if (created)
+		{
+		  unit = console_unit (me);
+		  cs->tty_min_state.setntty (DEV_CONS_MAJOR, unit);
+		}
+	      else
+		unit = device::minor (cs->tty_min_state.ntty);
+	      shared_console_info[unit] = cs;
+	      if (created)
+		con.owner = myself->pid;
+	    }
+	}
     }
-  if (!created && shared_console_info)
+  if (shared_console_info[unit])
     {
-      while (con.owner > MAX_PID)
-	Sleep (1);
-      pinfo p (con.owner);
-      if (!p)
-	con.owner = myself->pid;
+      devset = (fh_devices) shared_console_info[unit]->tty_min_state.getntty ();
+      _tc = &(shared_console_info[unit]->tty_min_state);
+      if (!created)
+	{
+	  while (con.owner > MAX_PID)
+	    Sleep (1);
+	  pinfo p (con.owner);
+	  if (!p)
+	    con.owner = myself->pid;
+	}
     }
 
   dev ().parse (devset);
@@ -651,7 +761,7 @@ fhandler_console::setup ()
       con.set_default_attr ();
       con.backspace_keycode = CERASE;
       con.cons_rapoi = NULL;
-      shared_console_info->tty_min_state.is_console = true;
+      shared_console_info[unit]->tty_min_state.is_console = true;
       con.cursor_key_app_mode = false;
       con.disable_master_thread = true;
       con.master_thread_suspended = false;
@@ -695,9 +805,11 @@ void
 fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 				  const handle_set_t *p)
 {
+  const _minor_t unit = p->unit;
   DWORD oflags;
   WaitForSingleObject (p->input_mutex, mutex_timeout);
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   GetConsoleMode (p->input_handle, &oflags);
   DWORD flags = oflags
     & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE | ENABLE_QUICK_EDIT_MODE);
@@ -736,6 +848,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       set_output_mode (tty::cygwin, t, p);
       WriteConsoleW (p->output_handle, L"\033[?1h", 5, NULL, 0);
     }
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   ReleaseMutex (p->input_mutex);
 }
@@ -744,6 +857,7 @@ void
 fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
 				   const handle_set_t *p)
 {
+  const _minor_t unit = p->unit;
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
   if (con.orig_virtual_terminal_processing_mode)
     flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
@@ -763,7 +877,9 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
       break;
     }
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   SetConsoleMode (p->output_handle, flags);
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   ReleaseMutex (p->output_mutex);
 }
@@ -786,9 +902,10 @@ fhandler_console::setup_for_non_cygwin_app ()
 void
 fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
 {
+  const _minor_t unit = p->unit;
   termios dummy = {0, };
-  termios *ti =
-    shared_console_info ? &(shared_console_info->tty_min_state.ti) : &dummy;
+  termios *ti = shared_console_info[unit] ?
+    &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
   /* Cleaning-up console mode for non-cygwin app. */
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
@@ -805,11 +922,12 @@ tty_min *
 tty_list::get_cttyp ()
 {
   dev_t n = myself->ctty;
+  const _minor_t unit = device::minor (n);
   if (iscons_dev (n))
-    return fhandler_console::shared_console_info ?
-      &fhandler_console::shared_console_info->tty_min_state : NULL;
+    return fhandler_console::shared_console_info[unit] ?
+      &fhandler_console::shared_console_info[unit]->tty_min_state : NULL;
   else if (istty_slave_dev (n))
-    return &ttys[device::minor (n)];
+    return &ttys[unit];
   else
     return NULL;
 }
@@ -851,6 +969,10 @@ fhandler_console::setup_io_mutex (void)
     }
   if (res == WAIT_OBJECT_0)
     release_output_mutex ();
+
+  extern HANDLE attach_mutex;
+  if (!attach_mutex)
+    attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
 }
 
 inline DWORD
@@ -893,7 +1015,9 @@ fhandler_console::set_cursor_maybe ()
       con.dwLastCursorPosition.Y != con.b.dwCursorPosition.Y)
     {
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = attach_console (con.owner);
       SetConsoleCursorPosition (get_output_handle (), con.b.dwCursorPosition);
+      detach_console (resume_pid, con.owner);
       release_attach_mutex ();
       con.dwLastCursorPosition = con.b.dwCursorPosition;
     }
@@ -902,15 +1026,17 @@ fhandler_console::set_cursor_maybe ()
 /* Workaround for a bug of windows xterm compatible mode. */
 /* The horizontal tab positions are broken after resize. */
 void
-fhandler_console::fix_tab_position (HANDLE h)
+fhandler_console::fix_tab_position (HANDLE h, pid_t owner)
 {
   /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
      fixes the tab position. */
   DWORD mode;
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (owner);
   GetConsoleMode (h, &mode);
   SetConsoleMode (h, mode & ~ENABLE_VIRTUAL_TERMINAL_PROCESSING);
   SetConsoleMode (h, mode);
+  detach_console (resume_pid, owner);
   release_attach_mutex ();
 }
 
@@ -927,7 +1053,7 @@ fhandler_console::send_winch_maybe ()
       con.scroll_region.Bottom = -1;
       if (wincap.has_con_24bit_colors () && !con_is_legacy
 	  && wincap.has_con_broken_tabs ())
-	fix_tab_position (get_output_handle ());
+	fix_tab_position (get_output_handle (), con.owner);
       /* longjmp() may be called in the signal handler like less,
 	 so release input_mutex temporarily before kill_pgrp(). */
       release_input_mutex ();
@@ -949,7 +1075,9 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
      and remember adjusted position in state for use by read() */
   CONSOLE_SCREEN_BUFFER_INFO now;
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   BOOL r = GetConsoleScreenBufferInfo (get_output_handle (), &now);
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   if (!r)
     /* Cannot adjust position by window scroll buffer offset */
@@ -1028,7 +1156,9 @@ wait_retry:
 	    { /* Confirm the handle is still valid */
 	      DWORD mode;
 	      acquire_attach_mutex (mutex_timeout);
+	      DWORD resume_pid = attach_console (con.owner);
 	      BOOL res = GetConsoleMode (get_handle (), &mode);
+	      detach_console (resume_pid, con.owner);
 	      release_attach_mutex ();
 	      if (res)
 		goto wait_retry;
@@ -1098,7 +1228,7 @@ fhandler_console::process_input_message (void)
 {
   char tmp[60];
 
-  if (!shared_console_info)
+  if (!shared_console_info[unit])
     return input_error;
 
   termios *ti = &(get_ttyp ()->ti);
@@ -1108,8 +1238,10 @@ fhandler_console::process_input_message (void)
   INPUT_RECORD input_rec[INREC_SIZE];
 
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   BOOL r =
     PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   if (!r)
     {
@@ -1498,7 +1630,9 @@ out:
     {
       DWORD discarded;
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = attach_console (con.owner);
       ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
+      detach_console (resume_pid, con.owner);
       release_attach_mutex ();
       con.num_processed -= min (con.num_processed, discarded);
     }
@@ -1509,7 +1643,9 @@ bool
 dev_console::fillin (HANDLE h)
 {
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = fhandler_console::attach_console (owner);
   bool ret = GetConsoleScreenBufferInfo (h, &b);
+  fhandler_console::detach_console (resume_pid, owner);
   release_attach_mutex ();
 
   if (ret)
@@ -1564,7 +1700,9 @@ dev_console::scroll_buffer (HANDLE h, int x1, int y1, int x2, int y2,
   dest.X = xn >= 0 ? xn : dwWinSize.X - 1;
   dest.Y = yn >= 0 ? yn : b.srWindow.Bottom;
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = fhandler_console::attach_console (owner);
   ScrollConsoleScreenBufferW (h, &sr1, &sr2, dest, &fill);
+  fhandler_console::detach_console (resume_pid, owner);
   release_attach_mutex ();
 }
 
@@ -1616,9 +1754,17 @@ fhandler_console::open (int flags, mode_t)
   set_output_handle (NULL);
 
   /* Open the input handle as handle_ */
+  bool err = false;
+  DWORD resume_pid = attach_console (con.owner, &err);
+  if (err)
+    {
+      set_errno (EACCES);
+      return 0;
+    }
   h = CreateFileW (L"CONIN$", GENERIC_READ | GENERIC_WRITE,
 		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
 		  OPEN_EXISTING, 0, 0);
+  detach_console (resume_pid, con.owner);
 
   if (h == INVALID_HANDLE_VALUE)
     {
@@ -1628,9 +1774,16 @@ fhandler_console::open (int flags, mode_t)
   set_handle (h);
   handle_set.input_handle = h;
 
+  resume_pid = attach_console (con.owner, &err);
+  if (err)
+    {
+      set_errno (EACCES);
+      return 0;
+    }
   h = CreateFileW (L"CONOUT$", GENERIC_READ | GENERIC_WRITE,
 		  FILE_SHARE_READ | FILE_SHARE_WRITE, &sec_none,
 		  OPEN_EXISTING, 0, 0);
+  detach_console (resume_pid, con.owner);
 
   if (h == INVALID_HANDLE_VALUE)
     {
@@ -1639,12 +1792,14 @@ fhandler_console::open (int flags, mode_t)
     }
   set_output_handle (h);
   handle_set.output_handle = h;
-  wpbuf.init (get_output_handle ());
+  wpbuf.init ();
 
   setup_io_mutex ();
   handle_set.input_mutex = input_mutex;
   handle_set.output_mutex = output_mutex;
 
+  handle_set.unit = unit;
+
   if (con.fillin (get_output_handle ()))
     {
       con.current_win32_attr = con.b.wAttributes;
@@ -1661,6 +1816,7 @@ fhandler_console::open (int flags, mode_t)
       DWORD dwMode;
       /* Check xterm compatible mode in output */
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = attach_console (con.owner);
       GetConsoleMode (get_output_handle (), &dwMode);
       con.orig_virtual_terminal_processing_mode =
 	!!(dwMode & ENABLE_VIRTUAL_TERMINAL_PROCESSING);
@@ -1674,6 +1830,7 @@ fhandler_console::open (int flags, mode_t)
 			   dwMode | ENABLE_VIRTUAL_TERMINAL_INPUT))
 	is_legacy = true;
       SetConsoleMode (get_handle (), dwMode);
+      detach_console (resume_pid, con.owner);
       release_attach_mutex ();
       con.is_legacy = is_legacy;
       extern int sawTERM;
@@ -1729,14 +1886,15 @@ fhandler_console::close ()
 
   acquire_output_mutex (mutex_timeout);
 
-  if (shared_console_info)
+  if (shared_console_info[unit])
     {
       /* Restore console mode if this is the last closure. */
       OBJECT_BASIC_INFORMATION obi;
       NTSTATUS status;
       status = NtQueryObject (get_handle (), ObjectBasicInformation,
 			      &obi, sizeof obi, NULL);
-      if ((NT_SUCCESS (status) && obi.HandleCount == 1)
+      if ((NT_SUCCESS (status) && obi.HandleCount == 1
+	   && (dev_t) myself->ctty == get_device ())
 	  || myself->pid == con.owner)
 	{
 	  /* Cleaning-up console mode for cygwin apps. */
@@ -1748,7 +1906,7 @@ fhandler_console::close ()
 
   release_output_mutex ();
 
-  if (shared_console_info && con.owner == myself->pid
+  if (shared_console_info[unit] && con.owner == myself->pid
       && master_thread_started)
     {
       char name[MAX_PATH];
@@ -1770,9 +1928,16 @@ fhandler_console::close ()
 
   if (con_ra.rabuf)
     free (con_ra.rabuf);
+  memset (&con_ra, 0, sizeof (con_ra));
 
-  if (!have_execed && !invisible_console)
+  if (!have_execed && !invisible_console
+      && (myself->ctty <= 0 || get_device () == (dev_t) myself->ctty))
     free_console ();
+
+  if (shared_console_info[unit])
+    UnmapViewOfFile ((void *) shared_console_info[unit]);
+  shared_console_info[unit] = NULL;
+
   return 0;
 }
 
@@ -1847,7 +2012,9 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  int ret = 0;
 	  INPUT_RECORD inp[INREC_SIZE];
 	  acquire_attach_mutex (mutex_timeout);
+	  DWORD resume_pid = attach_console (con.owner);
 	  BOOL r = PeekConsoleInputW (get_handle (), inp, INREC_SIZE, &n);
+	  detach_console (resume_pid, con.owner);
 	  release_attach_mutex ();
 	  if (!r)
 	    {
@@ -1906,7 +2073,9 @@ fhandler_console::tcflush (int queue)
       || queue == TCIOFLUSH)
     {
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = attach_console (con.owner);
       BOOL r = FlushConsoleInputBuffer (get_handle ());
+      detach_console (resume_pid, con.owner);
       release_attach_mutex ();
       if (!r)
 	{
@@ -1933,15 +2102,14 @@ fhandler_console::tcgetattr (struct termios *t)
   return 0;
 }
 
-fhandler_console::fhandler_console (fh_devices unit) :
+fhandler_console::fhandler_console (fh_devices devunit) :
   fhandler_termios (), input_ready (false), thread_sync_event (NULL),
-  input_mutex (NULL), output_mutex (NULL)
+  input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV)
 {
-  if (unit > 0)
-    dev ().parse (unit);
+  if (devunit > 0)
+    dev ().parse (devunit);
   setup ();
   trunc_buf.len = 0;
-  _tc = &(shared_console_info->tty_min_state);
 }
 
 void
@@ -1982,7 +2150,9 @@ dev_console::set_color (HANDLE h)
   if (h)
     {
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = fhandler_console::attach_console (owner);
       SetConsoleTextAttribute (h, current_win32_attr);
+      fhandler_console::detach_console (resume_pid, owner);
       release_attach_mutex ();
     }
 }
@@ -2039,6 +2209,7 @@ dev_console::scroll_window (HANDLE h, int x1, int y1, int x2, int y2)
   sr.Left = sr.Right = dwEnd.X = 0;
 
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = fhandler_console::attach_console (owner);
   if (b.srWindow.Bottom + toscroll >= b.dwSize.Y)
     {
       /* So we're at the end of the buffer and scrolling the console window
@@ -2093,6 +2264,7 @@ dev_console::scroll_window (HANDLE h, int x1, int y1, int x2, int y2)
   /* Eventually set cursor to new end position at the top of the window. */
   dwEnd.Y++;
   SetConsoleCursorPosition (h, dwEnd);
+  fhandler_console::detach_console (resume_pid, owner);
   release_attach_mutex ();
   /* Fix up console buffer info. */
   fillin (h);
@@ -2151,8 +2323,10 @@ dev_console::clear_screen (HANDLE h, int x1, int y1, int x2, int y2)
       tlc.Y = y2;
     }
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = fhandler_console::attach_console (owner);
   FillConsoleOutputCharacterW (h, L' ', num, tlc, &done);
   FillConsoleOutputAttribute (h, current_win32_attr, num, tlc, &done);
+  fhandler_console::detach_console (resume_pid, owner);
   release_attach_mutex ();
 }
 
@@ -2187,7 +2361,9 @@ fhandler_console::cursor_set (bool rel_to_top, int x, int y)
   pos.X = x;
   pos.Y = y;
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   SetConsoleCursorPosition (get_output_handle (), pos);
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
 }
 
@@ -2261,7 +2437,9 @@ fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
     {
       DWORD nbytes = len > MAX_WRITE_CHARS ? MAX_WRITE_CHARS : len;
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = attach_console (con.owner);
       BOOL r = WriteConsoleW (get_output_handle (), buf, nbytes, &done, 0);
+      detach_console (resume_pid, con.owner);
       release_attach_mutex ();
       if (!r)
 	{
@@ -2313,9 +2491,7 @@ ReadConsoleOutputWrapper (HANDLE h, PCHAR_INFO buf, COORD bufsiz,
   if ((width == 0) || (height == 0))
     return TRUE;
 
-  acquire_attach_mutex (mutex_timeout);
   BOOL success = ReadConsoleOutputW (h, buf, bufsiz, coord, &region);
-  release_attach_mutex ();
   if (success)
     /* it worked */;
   else if (GetLastError () == ERROR_NOT_ENOUGH_MEMORY && (width * height) > 1)
@@ -2351,14 +2527,20 @@ dev_console::save_restore (HANDLE h, char c)
       SMALL_RECT now = {};		/* Read the whole buffer */
       now.Bottom = save_bufsize.Y - 1;
       now.Right = save_bufsize.X - 1;
+      acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = fhandler_console::attach_console (owner);
       if (!ReadConsoleOutputWrapper (h, save_buf, save_bufsize, now))
 	debug_printf ("ReadConsoleOutputWrapper(h, ...) failed during save, %E");
+      fhandler_console::detach_console (resume_pid, owner);
+      release_attach_mutex ();
 
       /* Position at top of buffer */
       COORD cob = {};
       acquire_attach_mutex (mutex_timeout);
+      resume_pid = fhandler_console::attach_console (owner);
       if (!SetConsoleCursorPosition (h, cob))
 	debug_printf ("SetConsoleCursorInfo(%p, ...) failed during save, %E", h);
+      fhandler_console::detach_console (resume_pid, owner);
       release_attach_mutex ();
 
       /* Clear entire buffer */
@@ -2374,7 +2556,9 @@ dev_console::save_restore (HANDLE h, char c)
       /* Restore whole buffer */
       clear_screen (h, 0, 0, b.dwSize.X - 1, b.dwSize.Y - 1);
       acquire_attach_mutex (mutex_timeout);
+      DWORD resume_pid = fhandler_console::attach_console (owner);
       BOOL res = WriteConsoleOutputW (h, save_buf, save_bufsize, cob, &now);
+      fhandler_console::detach_console (resume_pid, owner);
       release_attach_mutex ();
       if (!res)
 	debug_printf ("WriteConsoleOutputW failed, %E");
@@ -2387,11 +2571,13 @@ dev_console::save_restore (HANDLE h, char c)
       /* CGF: NOOP?  Doesn't seem to position screen as expected */
       /* Temporarily position at top of screen */
       acquire_attach_mutex (mutex_timeout);
+      resume_pid = fhandler_console::attach_console (owner);
       if (!SetConsoleCursorPosition (h, cob))
 	debug_printf ("SetConsoleCursorInfo(%p, cob) failed during restore, %E", h);
       /* Position where we were previously */
       if (!SetConsoleCursorPosition (h, save_cursor))
 	debug_printf ("SetConsoleCursorInfo(%p, save_cursor) failed during restore, %E", h);
+      fhandler_console::detach_console (resume_pid, owner);
       release_attach_mutex ();
       /* Get back correct version of buffer information */
       dwEnd.X = dwEnd.Y = 0;
@@ -2507,24 +2693,26 @@ fhandler_console::char_command (char c)
 	  break;
 #endif
 	case 'b': /* REP */
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  if (wincap.has_con_esc_rep ())
 	    /* Just send the sequence */
-	    wpbuf.send ();
+	    wpbuf_send ();
 	  else if (last_char && last_char != L'\n')
 	    {
 	      acquire_attach_mutex (mutex_timeout);
+	      DWORD resume_pid = attach_console (con.owner);
 	      for (int i = 0; i < con.args[0]; i++)
 		WriteConsoleW (get_output_handle (), &last_char, 1, 0, 0);
+	      detach_console (resume_pid, con.owner);
 	      release_attach_mutex ();
 	    }
 	  break;
 	case 'r': /* DECSTBM */
 	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
 	  con.scroll_region.Bottom = con.args[1] ? con.args[1] - 1 : -1;
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  /* Just send the sequence */
-	  wpbuf.send ();
+	  wpbuf_send ();
 	  break;
 	case 'L': /* IL */
 	  if (wincap.has_con_broken_il_dl ())
@@ -2536,11 +2724,14 @@ fhandler_console::char_command (char c)
 	      if (y == con.b.srWindow.Bottom)
 		{
 		  acquire_attach_mutex (mutex_timeout);
+		  DWORD resume_pid = attach_console (con.owner);
 		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
+		  detach_console (resume_pid, con.owner);
 		  release_attach_mutex ();
 		  break;
 		}
 	      acquire_attach_mutex (mutex_timeout);
+	      DWORD resume_pid = attach_console (con.owner);
 	      if (y == con.b.srWindow.Top
 		  && srBottom == con.b.srWindow.Bottom)
 		{
@@ -2556,8 +2747,8 @@ fhandler_console::char_command (char c)
 				y + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
-	      wpbuf.put ('T');
-	      wpbuf.send ();
+	      wpbuf_put ('T');
+	      wpbuf_send ();
 	      __small_swprintf (bufw, L"\033[%d;%dr",
 				srTop + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
@@ -2565,13 +2756,14 @@ fhandler_console::char_command (char c)
 	      __small_swprintf (bufw, L"\033[%d;%dH",
 				y + 1 - con.b.srWindow.Top, x + 1);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
+	      detach_console (resume_pid, con.owner);
 	      release_attach_mutex ();
 	    }
 	  else
 	    {
-	      wpbuf.put (c);
+	      wpbuf_put (c);
 	      /* Just send the sequence */
-	      wpbuf.send ();
+	      wpbuf_send ();
 	    }
 	  break;
 	case 'M': /* DL */
@@ -2584,7 +2776,9 @@ fhandler_console::char_command (char c)
 	      if (y == con.b.srWindow.Bottom)
 		{
 		  acquire_attach_mutex (mutex_timeout);
+		  DWORD resume_pid = attach_console (con.owner);
 		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
+		  detach_console (resume_pid, con.owner);
 		  release_attach_mutex ();
 		  break;
 		}
@@ -2592,9 +2786,10 @@ fhandler_console::char_command (char c)
 				y + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
 	      acquire_attach_mutex (mutex_timeout);
+	      DWORD resume_pid = attach_console (con.owner);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
-	      wpbuf.put ('S');
-	      wpbuf.send ();
+	      wpbuf_put ('S');
+	      wpbuf_send ();
 	      __small_swprintf (bufw, L"\033[%d;%dr",
 				srTop + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
@@ -2602,17 +2797,18 @@ fhandler_console::char_command (char c)
 	      __small_swprintf (bufw, L"\033[%d;%dH",
 				y + 1 - con.b.srWindow.Top, x + 1);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
+	      detach_console (resume_pid, con.owner);
 	      release_attach_mutex ();
 	    }
 	  else
 	    {
-	      wpbuf.put (c);
+	      wpbuf_put (c);
 	      /* Just send the sequence */
-	      wpbuf.send ();
+	      wpbuf_send ();
 	    }
 	  break;
 	case 'J': /* ED */
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  if (con.args[0] == 3 && con.savey >= 0)
 	    {
 	      con.fillin (get_output_handle ());
@@ -2622,6 +2818,7 @@ fhandler_console::char_command (char c)
 	    { /* Workaround for broken CSI3J in Win10 1809 */
 	      CONSOLE_SCREEN_BUFFER_INFO sbi;
 	      acquire_attach_mutex (mutex_timeout);
+	      DWORD resume_pid = attach_console (con.owner);
 	      GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
 	      SMALL_RECT r = {0, sbi.srWindow.Top,
 		(SHORT) (sbi.dwSize.X - 1), (SHORT) (sbi.dwSize.Y - 1)};
@@ -2633,17 +2830,18 @@ fhandler_console::char_command (char c)
 	      d = sbi.dwCursorPosition;
 	      d.Y -= sbi.srWindow.Top;
 	      SetConsoleCursorPosition (get_output_handle (), d);
+	      detach_console (resume_pid, con.owner);
 	      release_attach_mutex ();
 	    }
 	  else
 	    /* Just send the sequence */
-	    wpbuf.send ();
+	    wpbuf_send ();
 	  break;
 	case 'h': /* DECSET */
 	case 'l': /* DECRST */
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  /* Just send the sequence */
-	  wpbuf.send ();
+	  wpbuf_send ();
 	  if (con.saw_question_mark)
 	    {
 	      bool need_fix_tab_position = false;
@@ -2659,7 +2857,7 @@ fhandler_console::char_command (char c)
 		}
 	      /* Call fix_tab_position() if screen has been alternated. */
 	      if (need_fix_tab_position)
-		fix_tab_position (get_output_handle ());
+		fix_tab_position (get_output_handle (), con.owner);
 	    }
 	  break;
 	case 'p':
@@ -2670,23 +2868,23 @@ fhandler_console::char_command (char c)
 	      con.savex = con.savey = -1;
 	      con.cursor_key_app_mode = false;
 	    }
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  /* Just send the sequence */
-	  wpbuf.send ();
+	  wpbuf_send ();
 	  break;
 	case 'm':
 	  if (con.saw_greater_than_sign)
 	    break; /* Ignore unsupported CSI > Pm m */
 	  /* Text attribute settings */
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  /* Just send the sequence */
-	  wpbuf.send ();
+	  wpbuf_send ();
 	  break;
 	default:
 	  /* Other escape sequences */
-	  wpbuf.put (c);
+	  wpbuf_put (c);
 	  /* Just send the sequence */
-	  wpbuf.send ();
+	  wpbuf_send ();
 	  break;
 	}
       return;
@@ -2871,6 +3069,7 @@ fhandler_console::char_command (char c)
 	{
 	    CONSOLE_CURSOR_INFO console_cursor_info;
 	    acquire_attach_mutex (mutex_timeout);
+	    DWORD resume_pid = attach_console (con.owner);
 	    GetConsoleCursorInfo (get_output_handle (), &console_cursor_info);
 	    switch (con.args[0])
 	      {
@@ -2893,6 +3092,7 @@ fhandler_console::char_command (char c)
 					&console_cursor_info);
 		  break;
 	      }
+	    detach_console (resume_pid, con.owner);
 	    release_attach_mutex ();
 	}
       break;
@@ -2916,12 +3116,14 @@ fhandler_console::char_command (char c)
 	  {
 	    CONSOLE_CURSOR_INFO console_cursor_info;
 	    acquire_attach_mutex (mutex_timeout);
+	    DWORD resume_pid = attach_console (con.owner);
 	    GetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
 	    if (c == 'h')
 	      console_cursor_info.bVisible = TRUE;
 	    else
 	      console_cursor_info.bVisible = FALSE;
 	    SetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+	    detach_console (resume_pid, con.owner);
 	    release_attach_mutex ();
 	    break;
 	  }
@@ -3168,14 +3370,16 @@ enum_proc (const LOGFONTW *lf, const TEXTMETRICW *tm,
 }
 
 static void
-check_font (HANDLE hdl)
+check_font (HANDLE hdl, pid_t owner)
 {
   CONSOLE_FONT_INFOEX cfi;
   LOGFONTW lf;
 
   cfi.cbSize = sizeof cfi;
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = fhandler_console::attach_console (owner);
   BOOL r = GetCurrentConsoleFontEx (hdl, 0, &cfi);
+  fhandler_console::detach_console (resume_pid, owner);
   release_attach_mutex ();
   if (!r)
     return;
@@ -3246,11 +3450,13 @@ check_font (HANDLE hdl)
 inline void
 fhandler_console::write_replacement_char ()
 {
-  check_font (get_output_handle ());
+  check_font (get_output_handle (), unit);
 
   DWORD done;
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   WriteConsoleW (get_output_handle (), &rp_char, 1, &done, 0);
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
 }
 
@@ -3401,7 +3607,7 @@ do_print:
 	  break;
 	case ESC:
 	  con.state = gotesc;
-	  wpbuf.put (*found);
+	  wpbuf_put (*found);
 	  break;
 	case DWN:
 	  cursor_get (&x, &y);
@@ -3410,7 +3616,9 @@ do_print:
 	      if (y >= con.b.srWindow.Bottom && !con.scroll_region.Top)
 		{
 		  acquire_attach_mutex (mutex_timeout);
+		  DWORD resume_pid = attach_console (con.owner);
 		  WriteConsoleW (get_output_handle (), L"\n", 1, &done, 0);
+		  detach_console (resume_pid, con.owner);
 		  release_attach_mutex ();
 		}
 	      else
@@ -3448,12 +3656,14 @@ do_print:
 		  if (ret != -1)
 		    {
 		      acquire_attach_mutex (mutex_timeout);
+		      DWORD resume_pid = attach_console (con.owner);
 		      while (ret-- > 0)
 			{
 			  WCHAR w = *(found + 1);
 			  WriteConsoleW (get_output_handle (), &w, 1, &done, 0);
 			  found++;
 			}
+		      detach_console (resume_pid, con.owner);
 		      release_attach_mutex ();
 		    }
 		}
@@ -3521,7 +3731,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	case gotesc:
 	  if (*src == '[')		/* CSI Control Sequence Introducer */
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      con.state = gotsquare;
 	      memset (con.args, 0, sizeof con.args);
 	      con.nargs = 0;
@@ -3536,8 +3746,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 		{
 		  /* For xterm mode only */
 		  /* Just send the sequence */
-		  wpbuf.put (*src);
-		  wpbuf.send ();
+		  wpbuf_put (*src);
+		  wpbuf_send ();
 		}
 	      else if (con.savex >= 0 && con.savey >= 0)
 		cursor_set (false, con.savex, con.savey);
@@ -3550,8 +3760,8 @@ fhandler_console::write (const void *vsrc, size_t len)
 		{
 		  /* For xterm mode only */
 		  /* Just send the sequence */
-		  wpbuf.put (*src);
-		  wpbuf.send ();
+		  wpbuf_put (*src);
+		  wpbuf_send ();
 		}
 	      else
 		cursor_get (&con.savex, &con.savey);
@@ -3574,23 +3784,25 @@ fhandler_console::write (const void *vsrc, size_t len)
 					srBottom - con.b.srWindow.Top + 1,
 					y + 1 - con.b.srWindow.Top, x + 1);
 		      acquire_attach_mutex (mutex_timeout);
+		      DWORD resume_pid = attach_console (con.owner);
 		      WriteConsoleW (get_output_handle (),
 				     buf, wcslen (buf), 0, 0);
+		      detach_console (resume_pid, con.owner);
 		      release_attach_mutex ();
 		    }
 		  /* Substitute "CSI Ps T" */
-		  wpbuf.put ('[');
-		  wpbuf.put ('T');
+		  wpbuf_put ('[');
+		  wpbuf_put ('T');
 		}
 	      else
-		wpbuf.put (*src);
-	      wpbuf.send ();
+		wpbuf_put (*src);
+	      wpbuf_send ();
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
 	  else if (*src == ']')		/* OSC Operating System Command */
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      con.rarg = 0;
 	      con.my_title_buf[0] = '\0';
 	      con.state = gotrsquare;
@@ -3607,20 +3819,20 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      /* ESC sequences below (e.g. OSC, etc) are left to xterm
 		 emulation in xterm compatible mode, therefore, are not
 		 handled and just sent them. */
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      /* Just send the sequence */
-	      wpbuf.send ();
+	      wpbuf_send ();
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
 	  else if (*src == '(')		/* Designate G0 character set */
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      con.state = gotparen;
 	    }
 	  else if (*src == ')')		/* Designate G1 character set */
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      con.state = gotrparen;
 	    }
 	  else if (*src == 'M')		/* Reverse Index (scroll down) */
@@ -3658,19 +3870,19 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    {
 	      if (con.nargs < MAXARGS)
 		con.args[con.nargs] = con.args[con.nargs] * 10 + *src - '0';
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      src++;
 	    }
 	  else if (*src == ';')
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      src++;
 	      if (con.nargs < MAXARGS)
 		con.nargs++;
 	    }
 	  else if (*src == ' ')
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      src++;
 	      con.saw_space = true;
 	      con.state = gotcommand;
@@ -3704,26 +3916,26 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    con.state = endpalette;
 	  else if (*src == '\007')
 	    {
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      if (wincap.has_con_24bit_colors () && !con_is_legacy)
-		wpbuf.send ();
+		wpbuf_send ();
 	      wpbuf.empty ();
 	      con.state = normal;
 	      src++;
 	      break;
 	    }
-	  wpbuf.put (*src);
+	  wpbuf_put (*src);
 	  src++;
 	  break;
 	case eattitle:
 	case gettitle:
 	  {
-	    wpbuf.put (*src);
+	    wpbuf_put (*src);
 	    int n = strlen (con.my_title_buf);
 	    if (*src < ' ')
 	      {
 		if (wincap.has_con_24bit_colors () && !con_is_legacy)
-		  wpbuf.send ();
+		  wpbuf_send ();
 		else if (*src == '\007' && con.state == gettitle)
 		  set_console_title (con.my_title_buf);
 		con.state = normal;
@@ -3738,7 +3950,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	    break;
 	  }
 	case eatpalette:
-	  wpbuf.put (*src);
+	  wpbuf_put (*src);
 	  if (*src == '?')
 	    con.saw_question_mark = true;
 	  else if (*src == '\033')
@@ -3748,20 +3960,20 @@ fhandler_console::write (const void *vsrc, size_t len)
 	      /* Send OSC Ps; Pt BEL other than OSC Ps; ? BEL */
 	      if (wincap.has_con_24bit_colors () && !con_is_legacy
 		  && !con.saw_question_mark)
-		wpbuf.send ();
+		wpbuf_send ();
 	      con.state = normal;
 	      wpbuf.empty();
 	    }
 	  src++;
 	  break;
 	case endpalette:
-	  wpbuf.put (*src);
+	  wpbuf_put (*src);
 	  if (*src == '\\')
 	    {
 	      /* Send OSC Ps; Pt ST other than OSC Ps; ? ST */
 	      if (wincap.has_con_24bit_colors () && !con_is_legacy
 		  && !con.saw_question_mark)
-		wpbuf.send ();
+		wpbuf_send ();
 	      con.state = normal;
 	    }
 	  else
@@ -3774,7 +3986,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 	  if (*src == ';')
 	    {
 	      con.state = gotarg1;
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      if (con.nargs < MAXARGS)
 		con.nargs++;
 	      src++;
@@ -3789,7 +4001,7 @@ fhandler_console::write (const void *vsrc, size_t len)
 		con.saw_greater_than_sign = true;
 	      else if (*src == '!')
 		con.saw_exclamation_mark = true;
-	      wpbuf.put (*src);
+	      wpbuf_put (*src);
 	      /* ignore any extra chars between [ and first arg or command */
 	      src++;
 	    }
@@ -3940,13 +4152,15 @@ fhandler_console::set_close_on_exec (bool val)
 }
 
 void
-set_console_title (char *title)
+fhandler_console::set_console_title (char *title)
 {
   wchar_t buf[TITLESIZE + 1];
   sys_mbstowcs (buf, TITLESIZE + 1, title);
   lock_ttys here (15000);
   acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   SetConsoleTitleW (buf);
+  detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   debug_printf ("title '%W'", buf);
 }
@@ -4035,7 +4249,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 {
   set_unit ();
   setup_io_mutex ();
-  wpbuf.init (get_output_handle ());
+  wpbuf.init ();
 
   if (!execing)
     return;
@@ -4285,6 +4499,7 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
   DuplicateHandle (GetCurrentProcess (), output_mutex,
 		   GetCurrentProcess (), &p->output_mutex,
 		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  p->unit = unit;
 }
 
 /* The function close_handle_set() should be static so that they can
@@ -4311,6 +4526,7 @@ fhandler_console::need_console_handler ()
 void
 fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 {
+  const _minor_t unit = cons->get_minor ();
   if (con.disable_master_thread == x)
     return;
   if (cons == NULL)
@@ -4324,3 +4540,17 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
   con.disable_master_thread = x;
   cons->release_input_mutex ();
 }
+
+int
+fhandler_console::fstat (struct stat *st)
+{
+  fhandler_base::fstat (st);
+  st->st_mode = S_IFCHR | S_IRUSR | S_IWUSR;
+  pinfo p (get_ttyp ()->getsid ());
+  if (p)
+    {
+      st->st_uid = p->uid;
+      st->st_gid = p->gid;
+    }
+  return 0;
+}
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c9b05e3d7..718709580 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -58,7 +58,7 @@ struct pipe_reply {
   DWORD error;
 };
 
-HANDLE attach_mutex;
+HANDLE NO_COPY attach_mutex;
 
 DWORD acquire_attach_mutex (DWORD t)
 {
@@ -2993,7 +2993,7 @@ fhandler_pty_master::setup ()
     goto err;
 
   if (!attach_mutex)
-    attach_mutex = CreateMutex (&sa, FALSE, NULL);
+    attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
 
   /* Create master control pipe which allows the master to duplicate
      the pty pipe handles to processes which deserve it. */
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8c320421b..8406dff64 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2001,6 +2001,7 @@ class fhandler_termios: public fhandler_base
     HANDLE output_handle;
     HANDLE input_mutex;
     HANDLE output_mutex;
+    _minor_t unit;
   };
   class spawn_worker
   {
@@ -2147,6 +2148,8 @@ class dev_console
   friend class fhandler_console;
 };
 
+#define MAX_CONS_DEV (sizeof (unsigned long) * 8)
+
 /* This is a input and output console handle */
 class fhandler_console: public fhandler_termios
 {
@@ -2169,10 +2172,11 @@ public:
   HANDLE thread_sync_event;
 private:
   static const unsigned MAX_WRITE_CHARS;
-  static console_state *shared_console_info;
+  static console_state *shared_console_info[MAX_CONS_DEV + 1];
   static bool invisible_console;
   HANDLE input_mutex, output_mutex;
   handle_set_t handle_set;
+  _minor_t unit;
 
   /* Used when we encounter a truncated multi-byte sequence.  The
      lead bytes are stored here and revisited in the next write call. */
@@ -2196,13 +2200,14 @@ private:
   const unsigned char *write_normal (unsigned const char*, unsigned const char *);
   void char_command (char);
   bool set_raw_win32_keyboard_mode (bool);
+  void set_console_title (char *);
 
 /* Input calls */
   int igncr_enabled ();
   void set_cursor_maybe ();
   static bool create_invisible_console_workaround (bool force);
   static console_state *open_shared_console (HWND, HANDLE&, bool&);
-  static void fix_tab_position (HANDLE h);
+  static void fix_tab_position (HANDLE h, pid_t owner);
 
 /* console mode calls */
   const handle_set_t *get_handle_set (void) {return &handle_set;}
@@ -2214,8 +2219,8 @@ private:
  public:
   pid_t tc_getpgid ()
   {
-    return shared_console_info ?
-      shared_console_info->tty_min_state.getpgid () : 0;
+    return shared_console_info[unit] ?
+      shared_console_info[unit]->tty_min_state.getpgid () : 0;
   }
   fhandler_console (fh_devices);
   static console_state *open_shared_console (HWND hw, HANDLE& h)
@@ -2252,12 +2257,12 @@ private:
   int ioctl (unsigned int cmd, void *);
   int init (HANDLE, DWORD, mode_t);
   bool mouse_aware (MOUSE_EVENT_RECORD& mouse_event);
-  bool focus_aware () {return shared_console_info->con.use_focus;}
+  bool focus_aware () {return shared_console_info[unit]->con.use_focus;}
   bool get_cons_readahead_valid ()
   {
     acquire_input_mutex (INFINITE);
-    bool ret = shared_console_info->con.cons_rapoi != NULL &&
-      *shared_console_info->con.cons_rapoi;
+    bool ret = shared_console_info[unit]->con.cons_rapoi != NULL &&
+      *shared_console_info[unit]->con.cons_rapoi;
     release_input_mutex ();
     return ret;
   }
@@ -2302,11 +2307,9 @@ private:
   void acquire_input_mutex_if_necessary (DWORD ms)
   {
     acquire_input_mutex (ms);
-    acquire_attach_mutex (ms);
   }
   void release_input_mutex_if_necessary (void)
   {
-    release_attach_mutex ();
     release_input_mutex ();
   }
 
@@ -2325,6 +2328,12 @@ private:
   static void set_console_mode_to_native ();
   bool need_console_handler ();
   static void set_disable_master_thread (bool x, fhandler_console *cons = NULL);
+  static DWORD attach_console (pid_t, bool *err = NULL);
+  static void detach_console (DWORD, pid_t);
+  pid_t get_owner ();
+  void wpbuf_put (char c);
+  void wpbuf_send ();
+  int fstat (struct stat *buf);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
index 44c7f08f8..c54440fa8 100644
--- a/winsup/cygwin/local_includes/winsup.h
+++ b/winsup/cygwin/local_includes/winsup.h
@@ -202,7 +202,6 @@ void timespec_to_filetime (const struct timespec *, PLARGE_INTEGER);
 bool timeval_to_ms (const struct timeval *, DWORD &);
 
 /* Console related */
-void set_console_title (char *);
 void init_console_handler (bool);
 
 extern bool wsock_started;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 2fd7b72b6..bad4c37f3 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1141,7 +1141,9 @@ peek_console (select_record *me, bool)
       else
 	{
 	  acquire_attach_mutex (mutex_timeout);
+	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
 	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
+	  fh->detach_console (resume_pid, fh->get_owner ());
 	  release_attach_mutex ();
 	  if (!r || !events_read)
 	    break;
-- 
2.39.0

