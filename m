Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 692813858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 10:22:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 692813858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 222ALXHQ002905;
 Wed, 2 Mar 2022 19:21:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 222ALXHQ002905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646216501;
 bh=Hs2I3VNQlpWCHRl+9pzx/tmWFuMkRHXv4s5/SsQtu98=;
 h=From:To:Cc:Subject:Date:From;
 b=Q+Z0JY4YHTgnBVdGMMaVwYB/yWZgfEawyf4bfYgoXyNzJ2L4KVIuMQ1lwt3PNG5e4
 oyn0hSEfNCUR41VpGCGk3cyUjCxdophWWhvVglQH16C7Y/D3W3VkHbFUa+dRwx+v2f
 sKUP/Qmlz7cRT9e97fxrpJ8Vm5OM3CrJjsUD8+beXxY9l/J8/OroY/+l6stUqeFppN
 DtElPlSGooW4F7VHdrHspJZRi/C+VdCvgnuBpFO5PoIuEXB8wSnI4/PIV7JRKp6T/B
 UtPXO76hfQJk6VsuclQWCyeGvdgp+4KrOz3hblnSGG+oZdeFUEUKGNnxE1rl77rkhu
 K7KUUpDtPShvA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console,
 pty: Revamp the acquire/release_attach_mutex timing.
Date: Wed,  2 Mar 2022 19:21:24 +0900
Message-Id: <20220302102124.39353-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, KAM_SOMETLD_ARE_BAD_TLD,
 PDS_OTHER_BAD_TLD, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 02 Mar 2022 10:22:06 -0000

- This patch revises the acquiring/releasing timing for attach_mutex
  to make the period in which it is being acquired shorter. Further,
  acquiring/releasing are added to where they are missing but needed.
---
 winsup/cygwin/fhandler.h          |   9 +-
 winsup/cygwin/fhandler_console.cc | 138 +++++++++++++++++++++++-------
 winsup/cygwin/fhandler_termios.cc |   2 +
 winsup/cygwin/fhandler_tty.cc     |  36 ++++++--
 winsup/cygwin/select.cc           |  14 +--
 5 files changed, 155 insertions(+), 44 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index c5eb62136..fbe7135b1 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1882,6 +1882,7 @@ class fhandler_serial: public fhandler_base
 #define release_output_mutex() \
   __release_output_mutex (__PRETTY_FUNCTION__, __LINE__)
 
+extern DWORD mutex_timeout;
 DWORD acquire_attach_mutex (DWORD t);
 void release_attach_mutex (void);
 
@@ -2181,7 +2182,13 @@ private:
   ssize_t __stdcall write (const void *ptr, size_t len);
   void doecho (const void *str, DWORD len);
   int close ();
-  static bool exists () {return !!GetConsoleCP ();}
+  static bool exists ()
+    {
+      acquire_attach_mutex (mutex_timeout);
+      UINT cp = GetConsoleCP ();
+      release_attach_mutex ();
+      return !!cp;
+    }
 
   int tcflush (int);
   int tcsetattr (int a, const struct termios *t);
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 7693ab8e4..241ca48ea 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -57,8 +57,6 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 
 bool NO_COPY fhandler_console::invisible_console;
 
-extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
-
 /* con_ra is shared in the same process.
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
@@ -86,7 +84,9 @@ public:
   {
     wchar_t bufw[WPBUF_LEN];
     DWORD len = sys_mbstowcs (bufw, WPBUF_LEN, buf, ixput);
+    acquire_attach_mutex (mutex_timeout);
     WriteConsoleW (handle, bufw, len, NULL, 0);
+    release_attach_mutex ();
   }
 } wpbuf;
 
@@ -217,6 +217,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       switch (cygwait (p->input_handle, (DWORD) 0))
 	{
 	case WAIT_OBJECT_0:
+	  acquire_attach_mutex (mutex_timeout);
 	  ReadConsoleInputW (p->input_handle,
 			     input_rec, INREC_SIZE, &total_read);
 	  if (total_read == INREC_SIZE /* Working space full */
@@ -230,6 +231,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      con.num_processed -= n;
 	      nowait = true;
 	    }
+	  release_attach_mutex ();
 	  break;
 	case WAIT_TIMEOUT:
 	  con.num_processed = 0;
@@ -318,9 +320,11 @@ remove_record:
 	    {
 	      INPUT_RECORD tmp[inrec_size];
 	      /* Writeback input records other than interrupt. */
+	      acquire_attach_mutex (mutex_timeout);
 	      WriteConsoleInputW (p->input_handle, input_rec, total_read, &n);
 	      /* Check if writeback was successfull. */
 	      PeekConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+	      release_attach_mutex ();
 	      if (n < total_read)
 		break; /* Someone has read input without acquiring
 			  input_mutex. ConEmu cygwin-connector? */
@@ -332,7 +336,9 @@ remove_record:
 	      for (ofst = 1; ofst <= incr; ofst++)
 		if (memcmp (input_rec, tmp + ofst, m::bytes (total_read)) == 0)
 		  {
+		    acquire_attach_mutex (mutex_timeout);
 		    ReadConsoleInputW (p->input_handle, tmp, inrec_size, &n);
+		    release_attach_mutex ();
 		    memcpy (input_rec, tmp + ofst, m::bytes (total_read));
 		    memcpy (input_rec + total_read, tmp, m::bytes (ofst));
 		    if (n > ofst + total_read)
@@ -490,6 +496,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 {
   DWORD oflags;
   WaitForSingleObject (p->input_mutex, mutex_timeout);
+  acquire_attach_mutex (mutex_timeout);
   GetConsoleMode (p->input_handle, &oflags);
   DWORD flags = oflags
     & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE | ENABLE_QUICK_EDIT_MODE);
@@ -526,6 +533,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       set_output_mode (tty::cygwin, t, p);
       WriteConsoleW (p->output_handle, L"\033[?1h", 5, NULL, 0);
     }
+  release_attach_mutex ();
   ReleaseMutex (p->input_mutex);
 }
 
@@ -549,7 +557,9 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
 	flags |= DISABLE_NEWLINE_AUTO_RETURN;
       break;
     }
+  acquire_attach_mutex (mutex_timeout);
   SetConsoleMode (p->output_handle, flags);
+  release_attach_mutex ();
   ReleaseMutex (p->output_mutex);
 }
 
@@ -670,9 +680,7 @@ fhandler_console::set_raw_win32_keyboard_mode (bool new_mode)
 void
 fhandler_console::set_cursor_maybe ()
 {
-  acquire_attach_mutex (mutex_timeout);
   con.fillin (get_output_handle ());
-  release_attach_mutex ();
   /* Nothing to do for xterm compatible mode. */
   if (wincap.has_con_24bit_colors () && !con_is_legacy)
     return;
@@ -694,9 +702,11 @@ fhandler_console::fix_tab_position (HANDLE h)
   /* Re-setting ENABLE_VIRTUAL_TERMINAL_PROCESSING
      fixes the tab position. */
   DWORD mode;
+  acquire_attach_mutex (mutex_timeout);
   GetConsoleMode (h, &mode);
   SetConsoleMode (h, mode & ~ENABLE_VIRTUAL_TERMINAL_PROCESSING);
   SetConsoleMode (h, mode);
+  release_attach_mutex ();
 }
 
 bool
@@ -729,7 +739,10 @@ fhandler_console::mouse_aware (MOUSE_EVENT_RECORD& mouse_event)
   /* Adjust mouse position by window scroll buffer offset
      and remember adjusted position in state for use by read() */
   CONSOLE_SCREEN_BUFFER_INFO now;
-  if (!GetConsoleScreenBufferInfo (get_output_handle (), &now))
+  acquire_attach_mutex (mutex_timeout);
+  BOOL r = GetConsoleScreenBufferInfo (get_output_handle (), &now);
+  release_attach_mutex ();
+  if (!r)
     /* Cannot adjust position by window scroll buffer offset */
     return 0;
 
@@ -818,9 +831,7 @@ wait_retry:
 
       int ret;
       acquire_input_mutex (mutex_timeout);
-      acquire_attach_mutex (mutex_timeout);
       ret = process_input_message ();
-      release_attach_mutex ();
       switch (ret)
 	{
 	case input_error:
@@ -887,7 +898,11 @@ fhandler_console::process_input_message (void)
   DWORD total_read, i;
   INPUT_RECORD input_rec[INREC_SIZE];
 
-  if (!PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read))
+  acquire_attach_mutex (mutex_timeout);
+  BOOL r =
+    PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
+  release_attach_mutex ();
+  if (!r)
     {
       termios_printf ("PeekConsoleInput failed, %E");
       return input_error;
@@ -1273,7 +1288,9 @@ out:
   if (discard_len)
     {
       DWORD discarded;
+      acquire_attach_mutex (mutex_timeout);
       ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
+      release_attach_mutex ();
       con.num_processed -= min (con.num_processed, discarded);
     }
   return stat;
@@ -1282,9 +1299,11 @@ out:
 bool
 dev_console::fillin (HANDLE h)
 {
-  bool ret;
+  acquire_attach_mutex (mutex_timeout);
+  bool ret = GetConsoleScreenBufferInfo (h, &b);
+  release_attach_mutex ();
 
-  if ((ret = GetConsoleScreenBufferInfo (h, &b)))
+  if (ret)
     {
       dwWinSize.Y = 1 + b.srWindow.Bottom - b.srWindow.Top;
       dwWinSize.X = 1 + b.srWindow.Right - b.srWindow.Left;
@@ -1335,7 +1354,9 @@ dev_console::scroll_buffer (HANDLE h, int x1, int y1, int x2, int y2,
     sr1.Bottom = sr2.Bottom;
   dest.X = xn >= 0 ? xn : dwWinSize.X - 1;
   dest.Y = yn >= 0 ? yn : b.srWindow.Bottom;
+  acquire_attach_mutex (mutex_timeout);
   ScrollConsoleScreenBufferW (h, &sr1, &sr2, dest, &fill);
+  release_attach_mutex ();
 }
 
 inline void
@@ -1427,6 +1448,7 @@ fhandler_console::open (int flags, mode_t)
       bool is_legacy = false;
       DWORD dwMode;
       /* Check xterm compatible mode in output */
+      acquire_attach_mutex (mutex_timeout);
       GetConsoleMode (get_output_handle (), &dwMode);
       if (!SetConsoleMode (get_output_handle (),
 			   dwMode | ENABLE_VIRTUAL_TERMINAL_PROCESSING))
@@ -1438,6 +1460,7 @@ fhandler_console::open (int flags, mode_t)
 			   dwMode | ENABLE_VIRTUAL_TERMINAL_INPUT))
 	is_legacy = true;
       SetConsoleMode (get_handle (), dwMode);
+      release_attach_mutex ();
       con.is_legacy = is_legacy;
       extern int sawTERM;
       if (con_is_legacy && !sawTERM)
@@ -1549,9 +1572,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
       case TIOCGWINSZ:
 	int st;
 
-	acquire_attach_mutex (mutex_timeout);
 	st = con.fillin (get_output_handle ());
-	release_attach_mutex ();
 	if (st)
 	  {
 	    /* *not* the buffer size, the actual screen size... */
@@ -1610,14 +1631,14 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  int ret = 0;
 	  INPUT_RECORD inp[INREC_SIZE];
 	  acquire_attach_mutex (mutex_timeout);
-	  if (!PeekConsoleInputW (get_handle (), inp, INREC_SIZE, &n))
+	  BOOL r = PeekConsoleInputW (get_handle (), inp, INREC_SIZE, &n);
+	  release_attach_mutex ();
+	  if (!r)
 	    {
 	      set_errno (EINVAL);
-	      release_attach_mutex ();
 	      release_output_mutex ();
 	      return -1;
 	    }
-	  release_attach_mutex ();
 	  bool saw_eol = false;
 	  for (DWORD i=0; i<n; i++)
 	    if (inp[i].EventType == KEY_EVENT &&
@@ -1669,13 +1690,14 @@ fhandler_console::tcflush (int queue)
       || queue == TCIOFLUSH)
     {
       acquire_attach_mutex (mutex_timeout);
-      if (!FlushConsoleInputBuffer (get_handle ()))
+      BOOL r = FlushConsoleInputBuffer (get_handle ());
+      release_attach_mutex ();
+      if (!r)
 	{
 	  __seterrno ();
 	  res = -1;
 	}
       con.num_processed = 0;
-      release_attach_mutex ();
     }
   return res;
 }
@@ -1742,7 +1764,11 @@ dev_console::set_color (HANDLE h)
 
   current_win32_attr = win_fg | win_bg;
   if (h)
-    SetConsoleTextAttribute (h, current_win32_attr);
+    {
+      acquire_attach_mutex (mutex_timeout);
+      SetConsoleTextAttribute (h, current_win32_attr);
+      release_attach_mutex ();
+    }
 }
 
 #define FOREGROUND_ATTR_MASK (FOREGROUND_RED | FOREGROUND_GREEN | \
@@ -1796,6 +1822,7 @@ dev_console::scroll_window (HANDLE h, int x1, int y1, int x2, int y2)
   int toscroll = dwEnd.Y - b.srWindow.Top + 1;
   sr.Left = sr.Right = dwEnd.X = 0;
 
+  acquire_attach_mutex (mutex_timeout);
   if (b.srWindow.Bottom + toscroll >= b.dwSize.Y)
     {
       /* So we're at the end of the buffer and scrolling the console window
@@ -1850,6 +1877,7 @@ dev_console::scroll_window (HANDLE h, int x1, int y1, int x2, int y2)
   /* Eventually set cursor to new end position at the top of the window. */
   dwEnd.Y++;
   SetConsoleCursorPosition (h, dwEnd);
+  release_attach_mutex ();
   /* Fix up console buffer info. */
   fillin (h);
   return true;
@@ -1906,8 +1934,10 @@ dev_console::clear_screen (HANDLE h, int x1, int y1, int x2, int y2)
       tlc.X = x2;
       tlc.Y = y2;
     }
+  acquire_attach_mutex (mutex_timeout);
   FillConsoleOutputCharacterW (h, L' ', num, tlc, &done);
   FillConsoleOutputAttribute (h, current_win32_attr, num, tlc, &done);
+  release_attach_mutex ();
 }
 
 void __reg3
@@ -1940,7 +1970,9 @@ fhandler_console::cursor_set (bool rel_to_top, int x, int y)
 
   pos.X = x;
   pos.Y = y;
+  acquire_attach_mutex (mutex_timeout);
   SetConsoleCursorPosition (get_output_handle (), pos);
+  release_attach_mutex ();
 }
 
 void __reg3
@@ -2012,7 +2044,10 @@ fhandler_console::write_console (PWCHAR buf, DWORD len, DWORD& done)
   while (len > 0)
     {
       DWORD nbytes = len > MAX_WRITE_CHARS ? MAX_WRITE_CHARS : len;
-      if (!WriteConsoleW (get_output_handle (), buf, nbytes, &done, 0))
+      acquire_attach_mutex (mutex_timeout);
+      BOOL r = WriteConsoleW (get_output_handle (), buf, nbytes, &done, 0);
+      release_attach_mutex ();
+      if (!r)
 	{
 	  __seterrno ();
 	  return false;
@@ -2062,7 +2097,9 @@ ReadConsoleOutputWrapper (HANDLE h, PCHAR_INFO buf, COORD bufsiz,
   if ((width == 0) || (height == 0))
     return TRUE;
 
+  acquire_attach_mutex (mutex_timeout);
   BOOL success = ReadConsoleOutputW (h, buf, bufsiz, coord, &region);
+  release_attach_mutex ();
   if (success)
     /* it worked */;
   else if (GetLastError () == ERROR_NOT_ENOUGH_MEMORY && (width * height) > 1)
@@ -2103,8 +2140,10 @@ dev_console::save_restore (HANDLE h, char c)
 
       /* Position at top of buffer */
       COORD cob = {};
+      acquire_attach_mutex (mutex_timeout);
       if (!SetConsoleCursorPosition (h, cob))
 	debug_printf ("SetConsoleCursorInfo(%p, ...) failed during save, %E", h);
+      release_attach_mutex ();
 
       /* Clear entire buffer */
       clear_screen (h, 0, 0, now.Right, now.Bottom);
@@ -2118,7 +2157,9 @@ dev_console::save_restore (HANDLE h, char c)
       now.Right = save_bufsize.X - 1;
       /* Restore whole buffer */
       clear_screen (h, 0, 0, b.dwSize.X - 1, b.dwSize.Y - 1);
+      acquire_attach_mutex (mutex_timeout);
       BOOL res = WriteConsoleOutputW (h, save_buf, save_bufsize, cob, &now);
+      release_attach_mutex ();
       if (!res)
 	debug_printf ("WriteConsoleOutputW failed, %E");
 
@@ -2129,11 +2170,13 @@ dev_console::save_restore (HANDLE h, char c)
       cob.Y = save_top;
       /* CGF: NOOP?  Doesn't seem to position screen as expected */
       /* Temporarily position at top of screen */
+      acquire_attach_mutex (mutex_timeout);
       if (!SetConsoleCursorPosition (h, cob))
 	debug_printf ("SetConsoleCursorInfo(%p, cob) failed during restore, %E", h);
       /* Position where we were previously */
       if (!SetConsoleCursorPosition (h, save_cursor))
 	debug_printf ("SetConsoleCursorInfo(%p, save_cursor) failed during restore, %E", h);
+      release_attach_mutex ();
       /* Get back correct version of buffer information */
       dwEnd.X = dwEnd.Y = 0;
       fillin (h);
@@ -2253,8 +2296,12 @@ fhandler_console::char_command (char c)
 	    /* Just send the sequence */
 	    wpbuf.send (get_output_handle ());
 	  else if (last_char && last_char != L'\n')
-	    for (int i = 0; i < con.args[0]; i++)
-	      WriteConsoleW (get_output_handle (), &last_char, 1, 0, 0);
+	    {
+	      acquire_attach_mutex (mutex_timeout);
+	      for (int i = 0; i < con.args[0]; i++)
+		WriteConsoleW (get_output_handle (), &last_char, 1, 0, 0);
+	      release_attach_mutex ();
+	    }
 	  break;
 	case 'r': /* DECSTBM */
 	  con.scroll_region.Top = con.args[0] ? con.args[0] - 1 : 0;
@@ -2272,9 +2319,12 @@ fhandler_console::char_command (char c)
 		break;
 	      if (y == con.b.srWindow.Bottom)
 		{
+		  acquire_attach_mutex (mutex_timeout);
 		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
+		  release_attach_mutex ();
 		  break;
 		}
+	      acquire_attach_mutex (mutex_timeout);
 	      if (y == con.b.srWindow.Top
 		  && srBottom == con.b.srWindow.Bottom)
 		{
@@ -2299,6 +2349,7 @@ fhandler_console::char_command (char c)
 	      __small_swprintf (bufw, L"\033[%d;%dH",
 				y + 1 - con.b.srWindow.Top, x + 1);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
+	      release_attach_mutex ();
 	    }
 	  else
 	    {
@@ -2316,12 +2367,15 @@ fhandler_console::char_command (char c)
 		break;
 	      if (y == con.b.srWindow.Bottom)
 		{
+		  acquire_attach_mutex (mutex_timeout);
 		  WriteConsoleW (get_output_handle (), L"\033[2K", 4, 0, 0);
+		  release_attach_mutex ();
 		  break;
 		}
 	      __small_swprintf (bufw, L"\033[%d;%dr",
 				y + 1 - con.b.srWindow.Top,
 				srBottom + 1 - con.b.srWindow.Top);
+	      acquire_attach_mutex (mutex_timeout);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
 	      wpbuf.put ('S');
 	      wpbuf.send (get_output_handle ());
@@ -2332,6 +2386,7 @@ fhandler_console::char_command (char c)
 	      __small_swprintf (bufw, L"\033[%d;%dH",
 				y + 1 - con.b.srWindow.Top, x + 1);
 	      WriteConsoleW (get_output_handle (), bufw, wcslen (bufw), 0, 0);
+	      release_attach_mutex ();
 	    }
 	  else
 	    {
@@ -2350,6 +2405,7 @@ fhandler_console::char_command (char c)
 	  if (con.args[0] == 3 && wincap.has_con_broken_csi3j ())
 	    { /* Workaround for broken CSI3J in Win10 1809 */
 	      CONSOLE_SCREEN_BUFFER_INFO sbi;
+	      acquire_attach_mutex (mutex_timeout);
 	      GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
 	      SMALL_RECT r = {0, sbi.srWindow.Top,
 		(SHORT) (sbi.dwSize.X - 1), (SHORT) (sbi.dwSize.Y - 1)};
@@ -2361,6 +2417,7 @@ fhandler_console::char_command (char c)
 	      d = sbi.dwCursorPosition;
 	      d.Y -= sbi.srWindow.Top;
 	      SetConsoleCursorPosition (get_output_handle (), d);
+	      release_attach_mutex ();
 	    }
 	  else
 	    /* Just send the sequence */
@@ -2597,6 +2654,7 @@ fhandler_console::char_command (char c)
       if (con.saw_space)
 	{
 	    CONSOLE_CURSOR_INFO console_cursor_info;
+	    acquire_attach_mutex (mutex_timeout);
 	    GetConsoleCursorInfo (get_output_handle (), &console_cursor_info);
 	    switch (con.args[0])
 	      {
@@ -2619,6 +2677,7 @@ fhandler_console::char_command (char c)
 					&console_cursor_info);
 		  break;
 	      }
+	    release_attach_mutex ();
 	}
       break;
     case 'h':
@@ -2640,12 +2699,14 @@ fhandler_console::char_command (char c)
 	case 25: /* Show/Hide Cursor (DECTCEM) */
 	  {
 	    CONSOLE_CURSOR_INFO console_cursor_info;
+	    acquire_attach_mutex (mutex_timeout);
 	    GetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
 	    if (c == 'h')
 	      console_cursor_info.bVisible = TRUE;
 	    else
 	      console_cursor_info.bVisible = FALSE;
 	    SetConsoleCursorInfo (get_output_handle (), & console_cursor_info);
+	    release_attach_mutex ();
 	    break;
 	  }
 	case 47:   /* Save/Restore screen */
@@ -2897,7 +2958,10 @@ check_font (HANDLE hdl)
   LOGFONTW lf;
 
   cfi.cbSize = sizeof cfi;
-  if (!GetCurrentConsoleFontEx (hdl, 0, &cfi))
+  acquire_attach_mutex (mutex_timeout);
+  BOOL r = GetCurrentConsoleFontEx (hdl, 0, &cfi);
+  release_attach_mutex ();
+  if (!r)
     return;
   /* Switched font? */
   if (wcscmp (cons_facename, cfi.FaceName) == 0)
@@ -2969,7 +3033,9 @@ fhandler_console::write_replacement_char ()
   check_font (get_output_handle ());
 
   DWORD done;
+  acquire_attach_mutex (mutex_timeout);
   WriteConsoleW (get_output_handle (), &rp_char, 1, &done, 0);
+  release_attach_mutex ();
 }
 
 const unsigned char *
@@ -3126,7 +3192,11 @@ do_print:
 	  if (y >= srBottom)
 	    {
 	      if (y >= con.b.srWindow.Bottom && !con.scroll_region.Top)
-		WriteConsoleW (get_output_handle (), L"\n", 1, &done, 0);
+		{
+		  acquire_attach_mutex (mutex_timeout);
+		  WriteConsoleW (get_output_handle (), L"\n", 1, &done, 0);
+		  release_attach_mutex ();
+		}
 	      else
 		{
 		  scroll_buffer (0, srTop + 1, -1, srBottom, 0, srTop);
@@ -3160,12 +3230,16 @@ do_print:
 		  ret = __utf8_mbtowc (_REENT, NULL, (const char *) found + 1,
 				       end - found - 1, &ps);
 		  if (ret != -1)
-		    while (ret-- > 0)
-		      {
-			WCHAR w = *(found + 1);
-			WriteConsoleW (get_output_handle (), &w, 1, &done, 0);
-			found++;
-		      }
+		    {
+		      acquire_attach_mutex (mutex_timeout);
+		      while (ret-- > 0)
+			{
+			  WCHAR w = *(found + 1);
+			  WriteConsoleW (get_output_handle (), &w, 1, &done, 0);
+			  found++;
+			}
+		      release_attach_mutex ();
+		    }
 		}
 	    }
 	  break;
@@ -3200,7 +3274,6 @@ fhandler_console::write (const void *vsrc, size_t len)
   while (get_ttyp ()->output_stopped)
     cygwait (10);
 
-  acquire_attach_mutex (mutex_timeout);
   push_process_state process_state (PID_TTYOU);
 
   acquire_output_mutex (mutex_timeout);
@@ -3284,8 +3357,10 @@ fhandler_console::write (const void *vsrc, size_t len)
 		      __small_swprintf (buf, L"\033[%d;1H\033[J\033[%d;%dH",
 					srBottom - con.b.srWindow.Top + 1,
 					y + 1 - con.b.srWindow.Top, x + 1);
+		      acquire_attach_mutex (mutex_timeout);
 		      WriteConsoleW (get_output_handle (),
 				     buf, wcslen (buf), 0, 0);
+		      release_attach_mutex ();
 		    }
 		  /* Substitute "CSI Ps T" */
 		  wpbuf.put ('[');
@@ -3529,7 +3604,6 @@ fhandler_console::write (const void *vsrc, size_t len)
 
   syscall_printf ("%ld = fhandler_console::write(...)", len);
 
-  release_attach_mutex ();
   return len;
 }
 
@@ -3655,7 +3729,9 @@ set_console_title (char *title)
   wchar_t buf[TITLESIZE + 1];
   sys_mbstowcs (buf, TITLESIZE + 1, title);
   lock_ttys here (15000);
+  acquire_attach_mutex (mutex_timeout);
   SetConsoleTitleW (buf);
+  release_attach_mutex ();
   debug_printf ("title '%W'", buf);
 }
 
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index a29129486..3767c6405 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -365,6 +365,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  else
 	    resume_pid = fhandler_pty_common::get_console_process_id
 	      (myself->dwProcessId, false);
+	  acquire_attach_mutex (mutex_timeout);
 	  if ((!console_exists || resume_pid) && fh && !fh->is_console ())
 	    {
 	      FreeConsole ();
@@ -404,6 +405,7 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	      init_console_handler (::cygheap->ctty
 				    && ::cygheap->ctty->is_console ());
 	    }
+	  release_attach_mutex ();
 	  need_discard_input = true;
 	}
       if (p && p->ctty == ttyp->ntty && p->pgid == pgid)
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 673f4167a..a2a9eab99 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -33,8 +33,6 @@ details. */
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
 #endif /* PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE */
 
-extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
-
 extern "C" int sscanf (const char *, const char *, ...);
 
 #define close_maybe(h) \
@@ -979,7 +977,11 @@ fhandler_pty_slave::open (int flags, mode_t)
        CTRL_C_EVENTs between ptys. */
     get_ttyp ()->need_invisible_console = true;
   else
-    fhandler_console::need_invisible ();
+    {
+      acquire_attach_mutex (mutex_timeout);
+      fhandler_console::need_invisible ();
+      release_attach_mutex ();
+    }
 
   set_open_status ();
   return 1;
@@ -1157,7 +1159,11 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	      bool need_restore_handles = get_ttyp ()->pcon_activated;
 	      WaitForSingleObject (pipe_sw_mutex, INFINITE);
 	      if (get_ttyp ()->pcon_activated)
-		close_pseudoconsole (get_ttyp ());
+		{
+		  acquire_attach_mutex (mutex_timeout);
+		  close_pseudoconsole (get_ttyp ());
+		  release_attach_mutex ();
+		}
 	      else
 		hand_over_only (get_ttyp ());
 	      ReleaseMutex (pipe_sw_mutex);
@@ -1238,6 +1244,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
 				       GetCurrentProcess (), &h_pcon_in,
 				       0, TRUE, DUPLICATE_SAME_ACCESS);
+		      acquire_attach_mutex (mutex_timeout);
 		      FreeConsole ();
 		      AttachConsole (get_ttyp ()->nat_pipe_owner_pid);
 		      init_console_handler (false);
@@ -1248,6 +1255,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		      FreeConsole ();
 		      AttachConsole (resume_pid);
 		      init_console_handler (false);
+		      release_attach_mutex ();
 		      CloseHandle (h_pcon_in);
 		    }
 		  CloseHandle (pcon_owner);
@@ -2096,7 +2104,9 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
   DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
 		   GetCurrentProcess (), &hpcon_local.hWritePipe,
 		   0, TRUE, DUPLICATE_SAME_ACCESS);
+  acquire_attach_mutex (mutex_timeout);
   ResizePseudoConsole ((HPCON) &hpcon_local, size);
+  release_attach_mutex ();
   CloseHandle (pcon_owner);
   CloseHandle (hpcon_local.hWritePipe);
 }
@@ -2473,8 +2483,10 @@ fhandler_pty_slave::setup_locale (void)
   if (!get_ttyp ()->term_code_page)
     {
       get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
+      acquire_attach_mutex (mutex_timeout);
       SetConsoleCP (get_ttyp ()->term_code_page);
       SetConsoleOutputCP (get_ttyp ()->term_code_page);
+      release_attach_mutex ();
     }
 }
 
@@ -3794,9 +3806,11 @@ fhandler_pty_slave::create_invisible_console ()
   if (get_ttyp ()->need_invisible_console)
     {
       /* Detach from console device and create new invisible console. */
+      acquire_attach_mutex (mutex_timeout);
       FreeConsole();
       fhandler_console::need_invisible (true);
       init_console_handler (false);
+      release_attach_mutex ();
       get_ttyp ()->need_invisible_console = false;
       get_ttyp ()->invisible_console_pid = myself->pid;
     }
@@ -4054,7 +4068,11 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
     }
   bool pcon_enabled = false;
   if (!nopcon)
-    pcon_enabled = setup_pseudoconsole ();
+    {
+      acquire_attach_mutex (mutex_timeout);
+      pcon_enabled = setup_pseudoconsole ();
+      release_attach_mutex ();
+    }
   ReleaseMutex (pipe_sw_mutex);
   /* For pcon enabled case, transfer_input() is called in master::write() */
   if (!pcon_enabled && get_ttyp ()->getpgid () == myself->pgid
@@ -4083,7 +4101,11 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
     }
   WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
-    close_pseudoconsole (ttyp, force_switch_to);
+    {
+      acquire_attach_mutex (mutex_timeout);
+      close_pseudoconsole (ttyp, force_switch_to);
+      release_attach_mutex ();
+    }
   else
     hand_over_only (ttyp, force_switch_to);
   ReleaseMutex (p->pipe_sw_mutex);
@@ -4157,6 +4179,8 @@ fhandler_pty_slave::release_ownership_of_nat_pipe (tty *ttyp,
       fhandler_pty_master *ptym = (fhandler_pty_master *) fh;
       WaitForSingleObject (ptym->pipe_sw_mutex, INFINITE);
       if (ttyp->pcon_activated)
+	/* Do not acquire/release_attach_mutex() here because
+	   it has done in fhandler_termios::process_sigs(). */
 	close_pseudoconsole (ttyp);
       else
 	hand_over_only (ttyp);
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 80a9527dc..64e35cf12 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1095,8 +1095,6 @@ fhandler_fifo::select_except (select_stuff *ss)
   return s;
 }
 
-extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
-
 static int
 peek_console (select_record *me, bool)
 {
@@ -1123,7 +1121,6 @@ peek_console (select_record *me, bool)
   set_handle_or_return_if_not_open (h, me);
 
   fh->acquire_input_mutex (mutex_timeout);
-  acquire_attach_mutex (mutex_timeout);
   while (!fh->input_ready && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
@@ -1132,8 +1129,14 @@ peek_console (select_record *me, bool)
 	  fh->release_input_mutex ();
 	  return me->read_ready = true;
 	}
-      else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
-	break;
+      else
+	{
+	  acquire_attach_mutex (mutex_timeout);
+	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
+	  release_attach_mutex ();
+	  if (!r || !events_read)
+	    break;
+	}
       if (fhandler_console::input_winch == fh->process_input_message ()
 	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
 	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
@@ -1144,7 +1147,6 @@ peek_console (select_record *me, bool)
 	  return -1;
 	}
     }
-  release_attach_mutex ();
   fh->release_input_mutex ();
   if (fh->input_ready || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
-- 
2.35.1

