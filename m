Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 279A43840C23
 for <cygwin-patches@cygwin.com>; Wed, 20 Jan 2021 09:16:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 279A43840C23
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10K9GHGC016168;
 Wed, 20 Jan 2021 18:16:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10K9GHGC016168
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Fix "Bad file descriptor" error in script
 command.
Date: Wed, 20 Jan 2021 18:16:20 +0900
Message-Id: <20210120091620.814-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 20 Jan 2021 09:16:43 -0000

- After the commit 72770148, script command exits occasionally with
  the error "Bad file descriptor" if it is started in console on Win7
  and non-cygwin process is executed. This patch fixes the issue.
---
 winsup/cygwin/fhandler_console.cc | 10 ++--
 winsup/cygwin/select.cc           | 95 ++++++++++++++++++++++++++++++-
 winsup/cygwin/select.h            |  7 +++
 3 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index dd00079fa..49963e719 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -557,9 +557,11 @@ fhandler_console::read (void *pv, size_t& buflen)
 #define buf ((char *) pv)
 
       int ret;
+      acquire_attach_mutex (INFINITE);
       acquire_input_mutex (INFINITE);
       ret = process_input_message ();
       release_input_mutex ();
+      release_attach_mutex ();
       switch (ret)
 	{
 	case input_error:
@@ -616,8 +618,6 @@ fhandler_console::process_input_message (void)
   if (!shared_console_info)
     return input_error;
 
-  acquire_attach_mutex (INFINITE);
-
   termios *ti = &(get_ttyp ()->ti);
 
   fhandler_console::input_states stat = input_processing;
@@ -627,7 +627,6 @@ fhandler_console::process_input_message (void)
   if (!PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read))
     {
       termios_printf ("PeekConsoleInput failed, %E");
-      release_attach_mutex ();
       return input_error;
     }
 
@@ -991,8 +990,9 @@ fhandler_console::process_input_message (void)
 out:
   /* Discard processed recored. */
   DWORD dummy;
-  ReadConsoleInputW (get_handle (), input_rec, min (total_read, i+1), &dummy);
-  release_attach_mutex ();
+  DWORD discard_len = min (total_read, i + 1);
+  if (discard_len)
+    ReadConsoleInputW (get_handle (), input_rec, discard_len, &dummy);
   return stat;
 }
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index dcb9b2d6e..d6c13241e 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1032,6 +1032,22 @@ fhandler_fifo::select_except (select_stuff *ss)
   return s;
 }
 
+extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
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
 static int
 peek_console (select_record *me, bool)
 {
@@ -1057,10 +1073,14 @@ peek_console (select_record *me, bool)
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
+  acquire_attach_mutex (INFINITE);
   while (!fh->input_ready && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
-	return me->read_ready = true;
+	{
+	  release_attach_mutex ();
+	  return me->read_ready = true;
+	}
       else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
 	break;
       fh->acquire_input_mutex (INFINITE);
@@ -1070,10 +1090,12 @@ peek_console (select_record *me, bool)
 	{
 	  set_sig_errno (EINTR);
 	  fh->release_input_mutex ();
+	  release_attach_mutex ();
 	  return -1;
 	}
       fh->release_input_mutex ();
     }
+  release_attach_mutex ();
   if (fh->input_ready || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
@@ -1087,18 +1109,87 @@ verify_console (select_record *me, fd_set *rfds, fd_set *wfds,
   return peek_console (me, true);
 }
 
+static int console_startup (select_record *me, select_stuff *stuff);
+
+static DWORD WINAPI
+thread_console (void *arg)
+{
+  select_console_info *ci = (select_console_info *) arg;
+  DWORD sleep_time = 0;
+  bool looping = true;
+
+  while (looping)
+    {
+      for (select_record *s = ci->start; (s = s->next); )
+	if (s->startup == console_startup)
+	  {
+	    if (peek_console (s, true))
+	      looping = false;
+	    if (ci->stop_thread)
+	      {
+		select_printf ("stopping");
+		looping = false;
+		break;
+	      }
+	  }
+      if (!looping)
+	break;
+      cygwait (ci->bye, sleep_time >> 3);
+      if (sleep_time < 80)
+	++sleep_time;
+      if (ci->stop_thread)
+	break;
+    }
+  return 0;
+}
+
 static int
 console_startup (select_record *me, select_stuff *stuff)
 {
   fhandler_console *fh = (fhandler_console *) me->fh;
   if (wincap.has_con_24bit_colors ())
     fhandler_console::request_xterm_mode_input (true, fh->get_handle_set ());
+
+  select_console_info *ci = stuff->device_specific_console;
+  if (ci->start)
+    me->h = *(stuff->device_specific_console)->thread;
+  else
+    {
+      ci->start = &stuff->start;
+      ci->stop_thread = false;
+      ci->bye = CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
+      ci->thread = new cygthread (thread_console, ci, "conssel");
+      me->h = *ci->thread;
+      if (!me->h)
+	return 0;
+    }
   return 1;
 }
 
+static void
+console_cleanup (select_record *me, select_stuff *stuff)
+{
+  select_console_info *ci = stuff->device_specific_console;
+  if (!ci)
+    return;
+  if (ci->thread)
+    {
+      ci->stop_thread = true;
+      SetEvent (ci->bye);
+      ci->thread->detach ();
+      CloseHandle (ci->bye);
+    }
+  delete ci;
+  stuff->device_specific_console = NULL;
+}
+
 select_record *
 fhandler_console::select_read (select_stuff *ss)
 {
+  if (!ss->device_specific_console
+      && (ss->device_specific_console = new select_console_info) == NULL)
+    return NULL;
+
   select_record *s = ss->start.next;
   if (!s->startup)
     {
@@ -1108,9 +1199,9 @@ fhandler_console::select_read (select_stuff *ss)
     }
 
   s->peek = peek_console;
-  s->h = get_handle ();
   s->read_selected = true;
   s->read_ready = input_ready || get_cons_readahead_valid ();
+  s->cleanup = console_cleanup;
   return s;
 }
 
diff --git a/winsup/cygwin/select.h b/winsup/cygwin/select.h
index 083c3c4d3..b794690b6 100644
--- a/winsup/cygwin/select.h
+++ b/winsup/cygwin/select.h
@@ -64,6 +64,11 @@ struct select_info
   select_info (): thread (NULL), stop_thread (0), start (NULL) {}
 };
 
+struct select_console_info: public select_info
+{
+  select_console_info (): select_info () {}
+};
+
 struct select_pipe_info: public select_info
 {
   select_pipe_info (): select_info () {}
@@ -102,6 +107,7 @@ public:
      its objects in the descriptor lists, here's the place to be.  This is
      mainly used to maintain a single thread for all fhandlers of a single
      type in the descriptor lists. */
+  select_console_info *device_specific_console;
   select_pipe_info *device_specific_pipe;
   select_pipe_info *device_specific_ptys;
   select_fifo_info *device_specific_fifo;
@@ -115,6 +121,7 @@ public:
 
   select_stuff (): return_on_signal (false), always_ready (false),
 		   windows_used (false), start (),
+		   device_specific_console (NULL),
 		   device_specific_pipe (NULL),
 		   device_specific_ptys (NULL),
 		   device_specific_fifo (NULL),
-- 
2.30.0

