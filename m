Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 7F37C3857C50
 for <cygwin-patches@cygwin.com>; Tue, 16 Feb 2021 10:33:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7F37C3857C50
Received: from localhost.localdomain (y085178.dynamic.ppp.asahi-net.or.jp
 [118.243.85.178]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 11GAX5eO003162;
 Tue, 16 Feb 2021 19:33:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 11GAX5eO003162
X-Nifty-SrcIP: [118.243.85.178]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Introduce new thread which handles input
 signal.
Date: Tue, 16 Feb 2021 19:32:56 +0900
Message-Id: <20210216103256.666-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Tue, 16 Feb 2021 10:33:31 -0000

- Currently, Ctrl-Z, Ctrl-\ and SIGWINCH does not work in console
  if the process does not call read() or select(). This is because
  these are processed in process_input_message() which is called
  from read() or select(). This is a long standing issue of console.
  Addresses:
    https://cygwin.com/pipermail/cygwin/2020-May/244898.html
    https://cygwin.com/pipermail/cygwin/2021-February/247779.html

  With this patch, new thread which handles only input signals is
  introduced so that Crtl-Z, etc. work without calling read() or
  select(). Ctrl-S and Ctrl-Q are also handled in this thread.
---
 winsup/cygwin/exceptions.cc       |   1 +
 winsup/cygwin/fhandler.h          |   4 +
 winsup/cygwin/fhandler_console.cc | 168 +++++++++++++++++++++++++++++-
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 3a6823325..a914110fe 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1163,6 +1163,7 @@ ctrl_c_handler (DWORD type)
 	sig = SIGQUIT;
       t->last_ctrl_c = GetTickCount64 ();
       t->kill_pgrp (sig);
+      t->output_stopped = false;
       t->last_ctrl_c = GetTickCount64 ();
       return TRUE;
     }
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 166ade414..9f60672ae 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2111,6 +2111,7 @@ private:
   static bool invisible_console;
   HANDLE input_mutex, output_mutex;
   handle_set_t handle_set;
+  HANDLE thread_sync_event;
 
   /* Used when we encounter a truncated multi-byte sequence.  The
      lead bytes are stored here and revisited in the next write call. */
@@ -2247,6 +2248,9 @@ private:
   static void request_xterm_mode_input (bool, const handle_set_t *p);
   static void request_xterm_mode_output (bool, const handle_set_t *p);
 
+  static DWORD WINAPI start_master_thread (void *arg);
+  static void cons_master_thread (handle_set_t *p, tty *ttyp);
+
   friend tty_min * tty_list::get_cttyp ();
 };
 
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 78af6cf2b..b5fcd3a0a 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -47,6 +47,8 @@ details. */
 		  con.b.srWindow.Top + con.scroll_region.Bottom)
 #define con_is_legacy (shared_console_info && con.is_legacy)
 
+#define CONS_THREAD_SYNC "cygcons.thread_sync"
+
 const unsigned fhandler_console::MAX_WRITE_CHARS = 16384;
 
 fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
@@ -170,6 +172,143 @@ console_unit::console_unit (HWND me0):
     api_fatal ("console device allocation failure - too many consoles in use, max consoles is 32");
 }
 
+DWORD WINAPI
+fhandler_console::start_master_thread (VOID *arg)
+{
+  fhandler_console *fh = (fhandler_console *) arg;
+  tty *ttyp = (tty *) fh->tc ();
+  fhandler_console::handle_set_t handle_set;
+  fh->get_duplicated_handle_set (&handle_set);
+  HANDLE thread_sync_event;
+  DuplicateHandle (GetCurrentProcess (), fh->thread_sync_event,
+		   GetCurrentProcess (), &thread_sync_event,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  SetEvent (thread_sync_event);
+  /* Do not touch class members after here because the class instance
+     may have been destroyed. */
+  cons_master_thread (&handle_set, ttyp);
+  close_handle_set (&handle_set);
+  SetEvent (thread_sync_event);
+  CloseHandle (thread_sync_event);
+  return 0;
+}
+
+/* This thread processes signals derived from input messages.
+   Without this thread, those signals can be handled only when
+   the process calls read() or select(). This thread reads input
+   records, processes signals and removes corresponding record.
+   The other input records are kept back for read() or select(). */
+void
+fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
+{
+  DWORD output_stopped_at = 0;
+  while (con.owner == myself->pid)
+    {
+      DWORD total_read, n, i, j;
+      INPUT_RECORD input_rec[INREC_SIZE];
+
+      WaitForSingleObject (p->input_mutex, INFINITE);
+      total_read = 0;
+      switch (cygwait (p->input_handle, (DWORD) 0))
+	{
+	case WAIT_OBJECT_0:
+	  ReadConsoleInputA (p->input_handle,
+			     input_rec, INREC_SIZE, &total_read);
+	  break;
+	case WAIT_TIMEOUT:
+	case WAIT_SIGNALED:
+	case WAIT_CANCELED:
+	  break;
+	default: /* Error */
+	  ReleaseMutex (p->input_mutex);
+	  return;
+	}
+      for (i = 0; i < total_read; i++)
+	{
+	  const char c = input_rec[i].Event.KeyEvent.uChar.AsciiChar;
+	  bool processed = false;
+	  termios &ti = ttyp->ti;
+	  switch (input_rec[i].EventType)
+	    {
+	    case KEY_EVENT:
+	      if (ti.c_lflag & ISIG)
+		{
+		  int sig = 0;
+		  if (CCEQ (ti.c_cc[VINTR], c))
+		    sig = SIGINT;
+		  else if (CCEQ (ti.c_cc[VQUIT], c))
+		    sig = SIGQUIT;
+		  else if (CCEQ (ti.c_cc[VSUSP], c))
+		    sig = SIGTSTP;
+		  if (sig && input_rec[i].Event.KeyEvent.bKeyDown)
+		    {
+		      ttyp->kill_pgrp (sig);
+		      ttyp->output_stopped = false;
+		      /* Discard type ahead input */
+		      goto skip_writeback;
+		    }
+		}
+	      if (ti.c_iflag & IXON)
+		{
+		  if (CCEQ (ti.c_cc[VSTOP], c))
+		    {
+		      if (!ttyp->output_stopped
+			  && input_rec[i].Event.KeyEvent.bKeyDown)
+			{
+			  ttyp->output_stopped = true;
+			  output_stopped_at = i;
+			}
+		      processed = true;
+		    }
+		  else if (CCEQ (ti.c_cc[VSTART], c))
+		    {
+		restart_output:
+		      if (input_rec[i].Event.KeyEvent.bKeyDown)
+			ttyp->output_stopped = false;
+		      processed = true;
+		    }
+		  else if ((ti.c_iflag & IXANY) && ttyp->output_stopped
+			   && c && i >= output_stopped_at)
+		    goto restart_output;
+		}
+	      break;
+	    case WINDOW_BUFFER_SIZE_EVENT:
+	      SHORT y = con.dwWinSize.Y;
+	      SHORT x = con.dwWinSize.X;
+	      con.fillin (p->output_handle);
+	      if (y != con.dwWinSize.Y || x != con.dwWinSize.X)
+		{
+		  con.scroll_region.Top = 0;
+		  con.scroll_region.Bottom = -1;
+		  if (wincap.has_con_24bit_colors () && !con_is_legacy)
+		    { /* Fix tab position */
+		      /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
+			 fixes the tab position. */
+		      request_xterm_mode_output (false, p);
+		      request_xterm_mode_output (true, p);
+		    }
+		  ttyp->kill_pgrp (SIGWINCH);
+		}
+	      processed = true;
+	      break;
+	    }
+	  if (processed)
+	    { /* Remove corresponding record. */
+	      for (j = i; j < total_read - 1; j++)
+		input_rec[j] = input_rec[j + 1];
+	      total_read--;
+	      i--;
+	    }
+	}
+      if (total_read)
+	/* Write back input records other than interrupt. */
+	WriteConsoleInput (p->input_handle, input_rec, total_read, &n);
+skip_writeback:
+      ReleaseMutex (p->input_mutex);
+      cygwait (40);
+    }
+}
+
 bool
 fhandler_console::set_unit ()
 {
@@ -1194,6 +1333,15 @@ fhandler_console::open (int flags, mode_t)
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
 
+  if (myself->pid == con.owner)
+    {
+      char name[MAX_PATH];
+      shared_name (name, CONS_THREAD_SYNC, get_minor ());
+      thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
+      new cygthread (start_master_thread, this, "consm");
+      WaitForSingleObject (thread_sync_event, INFINITE);
+      CloseHandle (thread_sync_event);
+    }
   return 1;
 }
 
@@ -1230,6 +1378,16 @@ fhandler_console::close ()
 
   release_output_mutex ();
 
+  if (con.owner == myself->pid)
+    {
+      char name[MAX_PATH];
+      shared_name (name, CONS_THREAD_SYNC, get_minor ());
+      thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
+      con.owner = 0;
+      WaitForSingleObject (thread_sync_event, INFINITE);
+      CloseHandle (thread_sync_event);
+    }
+
   CloseHandle (input_mutex);
   input_mutex = NULL;
   CloseHandle (output_mutex);
@@ -1540,7 +1698,7 @@ fhandler_console::tcgetattr (struct termios *t)
 
 fhandler_console::fhandler_console (fh_devices unit) :
   fhandler_termios (), input_ready (false),
-  input_mutex (NULL), output_mutex (NULL)
+  input_mutex (NULL), output_mutex (NULL), thread_sync_event (NULL)
 {
   if (unit > 0)
     dev ().parse (unit);
@@ -3022,6 +3180,14 @@ fhandler_console::write (const void *vsrc, size_t len)
   if (bg <= bg_eof)
     return (ssize_t) bg;
 
+  if (get_ttyp ()->output_stopped && is_nonblocking ())
+    {
+      set_errno (EAGAIN);
+      return -1;
+    }
+  while (get_ttyp ()->output_stopped)
+    cygwait (10);
+
   acquire_attach_mutex (INFINITE);
   push_process_state process_state (PID_TTYOU);
   acquire_output_mutex (INFINITE);
-- 
2.30.0

