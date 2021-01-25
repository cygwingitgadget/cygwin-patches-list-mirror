Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id AD8823858034
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 09:18:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AD8823858034
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 10P9IL6d002406;
 Mon, 25 Jan 2021 18:18:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 10P9IL6d002406
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Add missing guard regarding attach_mutex.
Date: Mon, 25 Jan 2021 18:18:11 +0900
Message-Id: <20210125091812.1765-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 25 Jan 2021 09:18:49 -0000

- The commit a5333345 did not fix the problem enough. This patch
  provides additional guard for the issue.
---
 winsup/cygwin/fhandler_console.cc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 49963e719..02d0ac052 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -439,14 +439,18 @@ fhandler_console::set_raw_win32_keyboard_mode (bool new_mode)
 void
 fhandler_console::set_cursor_maybe ()
 {
+  acquire_attach_mutex (INFINITE);
   con.fillin (get_output_handle ());
+  release_attach_mutex ();
   /* Nothing to do for xterm compatible mode. */
   if (wincap.has_con_24bit_colors () && !con_is_legacy)
     return;
   if (con.dwLastCursorPosition.X != con.b.dwCursorPosition.X ||
       con.dwLastCursorPosition.Y != con.b.dwCursorPosition.Y)
     {
+      acquire_attach_mutex (INFINITE);
       SetConsoleCursorPosition (get_output_handle (), con.b.dwCursorPosition);
+      release_attach_mutex ();
       con.dwLastCursorPosition = con.b.dwCursorPosition;
     }
 }
@@ -536,6 +540,7 @@ fhandler_console::read (void *pv, size_t& buflen)
 	}
 
       set_cursor_maybe (); /* to make cursor appear on the screen immediately */
+wait_retry:
       switch (cygwait (get_handle (), timeout))
 	{
 	case WAIT_OBJECT_0:
@@ -551,6 +556,15 @@ fhandler_console::read (void *pv, size_t& buflen)
 	  buflen = (size_t) -1;
 	  return;
 	default:
+	  if (GetLastError () == ERROR_INVALID_HANDLE)
+	    { /* Confirm the handle is still valid */
+	      DWORD mode;
+	      acquire_attach_mutex (INFINITE);
+	      BOOL res = GetConsoleMode (get_handle (), &mode);
+	      release_attach_mutex ();
+	      if (res)
+		goto wait_retry;
+	    }
 	  goto err;
 	}
 
@@ -1243,7 +1257,9 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
       case TIOCGWINSZ:
 	int st;
 
+	acquire_attach_mutex (INFINITE);
 	st = con.fillin (get_output_handle ());
+	release_attach_mutex ();
 	if (st)
 	  {
 	    /* *not* the buffer size, the actual screen size... */
@@ -1301,12 +1317,15 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  DWORD n;
 	  int ret = 0;
 	  INPUT_RECORD inp[INREC_SIZE];
+	  acquire_attach_mutex (INFINITE);
 	  if (!PeekConsoleInputW (get_handle (), inp, INREC_SIZE, &n))
 	    {
 	      set_errno (EINVAL);
+	      release_attach_mutex ();
 	      release_output_mutex ();
 	      return -1;
 	    }
+	  release_attach_mutex ();
 	  bool saw_eol = false;
 	  for (DWORD i=0; i<n; i++)
 	    if (inp[i].EventType == KEY_EVENT &&
@@ -1357,11 +1376,13 @@ fhandler_console::tcflush (int queue)
   if (queue == TCIFLUSH
       || queue == TCIOFLUSH)
     {
+      acquire_attach_mutex (INFINITE);
       if (!FlushConsoleInputBuffer (get_handle ()))
 	{
 	  __seterrno ();
 	  res = -1;
 	}
+      release_attach_mutex ();
     }
   return res;
 }
@@ -1375,12 +1396,14 @@ fhandler_console::output_tcsetattr (int, struct termios const *t)
   DWORD flags = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 
   DWORD oflags;
+  acquire_attach_mutex (INFINITE);
   GetConsoleMode (get_output_handle (), &oflags);
   if (wincap.has_con_24bit_colors () && !con_is_legacy
       && (oflags & ENABLE_VIRTUAL_TERMINAL_PROCESSING))
     flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
 
   int res = SetConsoleMode (get_output_handle (), flags) ? 0 : -1;
+  release_attach_mutex ();
   if (res)
     __seterrno_from_win_error (GetLastError ());
   release_output_mutex ();
@@ -1398,6 +1421,7 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
 
   DWORD oflags;
 
+  acquire_attach_mutex (INFINITE);
   if (!GetConsoleMode (get_handle (), &oflags))
     oflags = 0;
   DWORD flags = 0;
@@ -1456,6 +1480,7 @@ fhandler_console::input_tcsetattr (int, struct termios const *t)
       syscall_printf ("%d = tcsetattr(,%p) enable flags %y, c_lflag %y iflag %y",
 		      res, t, flags, t->c_lflag, t->c_iflag);
     }
+  release_attach_mutex ();
 
   get_ttyp ()->rstcons (false);
   release_input_mutex ();
@@ -1481,6 +1506,7 @@ fhandler_console::tcgetattr (struct termios *t)
 
   DWORD flags;
 
+  acquire_attach_mutex (INFINITE);
   if (!GetConsoleMode (get_handle (), &flags))
     {
       __seterrno ();
@@ -1505,6 +1531,7 @@ fhandler_console::tcgetattr (struct termios *t)
       /* All the output bits we can ignore */
       res = 0;
     }
+  release_attach_mutex ();
   syscall_printf ("%d = tcgetattr(%p) enable flags %y, t->lflag %y, t->iflag %y",
 		 res, t, flags, t->c_lflag, t->c_iflag);
   return res;
-- 
2.30.0

