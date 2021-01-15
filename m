Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 42DCC397182D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 08:34:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 42DCC397182D
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10F8WSAf017561;
 Fri, 15 Jan 2021 17:33:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10F8WSAf017561
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 5/5] Cygwin: pty: Make master thread functions be static.
Date: Fri, 15 Jan 2021 17:32:13 +0900
Message-Id: <20210115083213.676-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
References: <20210115083213.676-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Fri, 15 Jan 2021 08:34:12 -0000

- The functions pty_master_thread() and pty_master_fwd_thread()
  should be static (i.e. should not access class member) because
  the instance is deleted if the master is dup()'ed and the first
  master is closed. In this case, because the dup()'ed instance
  still exists, these master threads are also still alive even
  though the instance has been deleted. As a result, accesing
  class members in these functions causes accessi violation.

  Addresses:
  https://cygwin.com/pipermail/cygwin-developers/2021-January/012030.html
---
 winsup/cygwin/fhandler.h      |  30 ++++++-
 winsup/cygwin/fhandler_tty.cc | 154 ++++++++++++++++++++++------------
 2 files changed, 128 insertions(+), 56 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index ffd19a590..d134b180c 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2274,8 +2274,9 @@ class fhandler_pty_common: public fhandler_termios
   void resize_pseudo_console (struct winsize *);
 
  protected:
-  BOOL process_opost_output (HANDLE h,
-			     const void *ptr, ssize_t& len, bool is_echo);
+  static BOOL process_opost_output (HANDLE h, const void *ptr, ssize_t& len,
+				    bool is_echo, tty *ttyp,
+				    bool is_nonblocking);
 };
 
 class fhandler_pty_slave: public fhandler_pty_common
@@ -2352,6 +2353,24 @@ class fhandler_pty_slave: public fhandler_pty_common
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
 class fhandler_pty_master: public fhandler_pty_common
 {
+public:
+  /* Parameter set for the static function pty_master_thread() */
+  struct master_thread_param_t {
+    HANDLE from_master;
+    HANDLE from_master_cyg;
+    HANDLE to_master;
+    HANDLE to_master_cyg;
+    HANDLE master_ctl;
+    HANDLE input_available_event;
+  };
+  /* Parameter set for the static function pty_master_fwd_thread() */
+  struct master_fwd_thread_param_t {
+    HANDLE to_master_cyg;
+    HANDLE from_slave;
+    HANDLE output_mutex;
+    tty *ttyp;
+  };
+private:
   int pktmode;			// non-zero if pty in a packet mode.
   HANDLE master_ctl;		// Control socket for handle duplication
   cygthread *master_thread;	// Master control thread
@@ -2360,14 +2379,15 @@ class fhandler_pty_master: public fhandler_pty_common
   DWORD dwProcessId;		// Owner of master handles
   HANDLE to_master_cyg, from_master_cyg;
   cygthread *master_fwd_thread;	// Master forwarding thread
+  HANDLE thread_param_copied_event;
 
 public:
   HANDLE get_echo_handle () const { return echo_r; }
   /* Constructor */
   fhandler_pty_master (int);
 
-  DWORD pty_master_thread ();
-  DWORD pty_master_fwd_thread ();
+  static DWORD pty_master_thread (const master_thread_param_t *p);
+  static DWORD pty_master_fwd_thread (const master_fwd_thread_param_t *p);
   int process_slave_output (char *buf, size_t len, int pktmode_on);
   void doecho (const void *str, DWORD len);
   int accept_input ();
@@ -2410,6 +2430,8 @@ public:
     return fh;
   }
   bool to_be_read_from_pcon (void);
+  void get_master_thread_param (master_thread_param_t *p);
+  void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 789bcdfdf..e4993bf31 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -301,7 +301,8 @@ fhandler_pty_master::doecho (const void *str, DWORD len)
 {
   ssize_t towrite = len;
   acquire_output_mutex (INFINITE);
-  if (!process_opost_output (echo_w, str, towrite, true))
+  if (!process_opost_output (echo_w, str, towrite, true,
+			     get_ttyp (), is_nonblocking ()))
     termios_printf ("Write to echo pipe failed, %E");
   release_output_mutex ();
 }
@@ -874,7 +875,8 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   reset_switch_to_pcon ();
 
   acquire_output_mutex (INFINITE);
-  if (!process_opost_output (get_output_handle_cyg (), ptr, towrite, false))
+  if (!process_opost_output (get_output_handle_cyg (), ptr, towrite, false,
+			     get_ttyp (), is_nonblocking ()))
     {
       DWORD err = GetLastError ();
       termios_printf ("WriteFile failed, %E");
@@ -1955,8 +1957,15 @@ fhandler_pty_slave::fixup_after_exec ()
    calls to CallNamedPipe should have a big enough timeout value.  For now this
    is 500ms.  Hope that's enough. */
 
+/* The function pty_master_thread() should be static because the instance
+   is deleted if the master is dup()'ed and the original is closed. In
+   this case, dup()'ed instance still exists, therefore, master thread
+   is also still alive even though the instance has been deleted. As a
+   result, accesing member variables in this function causes access
+   violation. */
+
 DWORD
-fhandler_pty_master::pty_master_thread ()
+fhandler_pty_master::pty_master_thread (const master_thread_param_t *p)
 {
   bool exit = false;
   GENERIC_MAPPING map = { EVENT_QUERY_STATE, EVENT_MODIFY_STATE, 0,
@@ -1970,7 +1979,7 @@ fhandler_pty_master::pty_master_thread ()
   NTSTATUS status;
 
   termios_printf ("Entered");
-  while (!exit && (ConnectNamedPipe (master_ctl, NULL)
+  while (!exit && (ConnectNamedPipe (p->master_ctl, NULL)
 		   || GetLastError () == ERROR_PIPE_CONNECTED))
     {
       pipe_reply repl = { NULL, NULL, NULL, NULL, 0 };
@@ -1979,21 +1988,21 @@ fhandler_pty_master::pty_master_thread ()
       ACCESS_MASK access = EVENT_MODIFY_STATE;
       HANDLE client = NULL;
 
-      if (!ReadFile (master_ctl, &req, sizeof req, &len, NULL))
+      if (!ReadFile (p->master_ctl, &req, sizeof req, &len, NULL))
 	{
 	  termios_printf ("ReadFile, %E");
 	  goto reply;
 	}
-      if (!GetNamedPipeClientProcessId (master_ctl, &pid))
+      if (!GetNamedPipeClientProcessId (p->master_ctl, &pid))
 	pid = req.pid;
-      if (get_object_sd (input_available_event, sd))
+      if (get_object_sd (p->input_available_event, sd))
 	{
 	  termios_printf ("get_object_sd, %E");
 	  goto reply;
 	}
       cygheap->user.deimpersonate ();
       deimp = true;
-      if (!ImpersonateNamedPipeClient (master_ctl))
+      if (!ImpersonateNamedPipeClient (p->master_ctl))
 	{
 	  termios_printf ("ImpersonateNamedPipeClient, %E");
 	  goto reply;
@@ -2036,28 +2045,28 @@ fhandler_pty_master::pty_master_thread ()
 	      termios_printf ("OpenProcess, %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), from_master,
+	  if (!DuplicateHandle (GetCurrentProcess (), p->from_master,
 			       client, &repl.from_master,
 			       0, TRUE, DUPLICATE_SAME_ACCESS))
 	    {
 	      termios_printf ("DuplicateHandle (from_master), %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), from_master_cyg,
+	  if (!DuplicateHandle (GetCurrentProcess (), p->from_master_cyg,
 			       client, &repl.from_master_cyg,
 			       0, TRUE, DUPLICATE_SAME_ACCESS))
 	    {
 	      termios_printf ("DuplicateHandle (from_master_cyg), %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), to_master,
+	  if (!DuplicateHandle (GetCurrentProcess (), p->to_master,
 				client, &repl.to_master,
 				0, TRUE, DUPLICATE_SAME_ACCESS))
 	    {
 	      termios_printf ("DuplicateHandle (to_master), %E");
 	      goto reply;
 	    }
-	  if (!DuplicateHandle (GetCurrentProcess (), to_master_cyg,
+	  if (!DuplicateHandle (GetCurrentProcess (), p->to_master_cyg,
 				client, &repl.to_master_cyg,
 				0, TRUE, DUPLICATE_SAME_ACCESS))
 	    {
@@ -2074,9 +2083,9 @@ reply:
       sd.free ();
       termios_printf ("Reply: from %p, to %p, error %u",
 		      repl.from_master, repl.to_master, repl.error );
-      if (!WriteFile (master_ctl, &repl, sizeof repl, &len, NULL))
+      if (!WriteFile (p->master_ctl, &repl, sizeof repl, &len, NULL))
 	termios_printf ("WriteFile, %E");
-      if (!DisconnectNamedPipe (master_ctl))
+      if (!DisconnectNamedPipe (p->master_ctl))
 	termios_printf ("DisconnectNamedPipe, %E");
     }
   termios_printf ("Leaving");
@@ -2086,11 +2095,20 @@ reply:
 static DWORD WINAPI
 pty_master_thread (VOID *arg)
 {
-  return ((fhandler_pty_master *) arg)->pty_master_thread ();
+  fhandler_pty_master::master_thread_param_t p;
+  ((fhandler_pty_master *) arg)->get_master_thread_param (&p);
+  return fhandler_pty_master::pty_master_thread (&p);
 }
 
+/* The function pty_master_fwd_thread() should be static because the
+   instance is deleted if the master is dup()'ed and the original is
+   closed. In this case, dup()'ed instance still exists, therefore,
+   master forwarding thread is also still alive even though the instance
+   has been deleted. As a result, accesing member variables in this
+   function causes access violation. */
+
 DWORD
-fhandler_pty_master::pty_master_fwd_thread ()
+fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 {
   DWORD rlen;
   tmp_pathbuf tp;
@@ -2101,17 +2119,17 @@ fhandler_pty_master::pty_master_fwd_thread ()
   termios_printf ("Started.");
   for (;;)
     {
-      get_ttyp ()->pcon_last_time = GetTickCount ();
-      if (!ReadFile (from_slave, outbuf, NT_MAX_PATH, &rlen, NULL))
+      p->ttyp->pcon_last_time = GetTickCount ();
+      if (!ReadFile (p->from_slave, outbuf, NT_MAX_PATH, &rlen, NULL))
 	{
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
       ssize_t wlen = rlen;
       char *ptr = outbuf;
-      if (get_ttyp ()->h_pseudo_console)
+      if (p->ttyp->h_pseudo_console)
 	{
-	  if (!get_ttyp ()->has_set_title)
+	  if (!p->ttyp->has_set_title)
 	    {
 	      /* Remove Set title sequence */
 	      char *p0, *p1;
@@ -2183,10 +2201,10 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	    else
 	      state = 0;
 
-	  if (get_ttyp ()->term_code_page != CP_UTF8)
+	  if (p->ttyp->term_code_page != CP_UTF8)
 	    {
 	      size_t nlen = NT_MAX_PATH;
-	      convert_mb_str (get_ttyp ()->term_code_page, mbbuf, &nlen,
+	      convert_mb_str (p->ttyp->term_code_page, mbbuf, &nlen,
 			      CP_UTF8, ptr, wlen, &mbp);
 
 	      ptr = mbbuf;
@@ -2198,7 +2216,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  DWORD written;
 	  while (rlen>0)
 	    {
-	      if (!WriteFile (to_master_cyg, ptr, wlen, &written, NULL))
+	      if (!WriteFile (p->to_master_cyg, ptr, wlen, &written, NULL))
 		{
 		  termios_printf ("WriteFile for forwarding failed, %E");
 		  break;
@@ -2210,7 +2228,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	}
 
       UINT cp_from;
-      pinfo pinfo_target = pinfo (get_ttyp ()->invisible_console_pid);
+      pinfo pinfo_target = pinfo (p->ttyp->invisible_console_pid);
       DWORD target_pid = 0;
       if (pinfo_target)
 	target_pid = pinfo_target->dwProcessId;
@@ -2235,20 +2253,21 @@ fhandler_pty_master::pty_master_fwd_thread ()
       else
 	cp_from = GetConsoleOutputCP ();
 
-      if (get_ttyp ()->term_code_page != cp_from)
+      if (p->ttyp->term_code_page != cp_from)
 	{
 	  size_t nlen = NT_MAX_PATH;
-	  convert_mb_str (get_ttyp ()->term_code_page, mbbuf, &nlen,
+	  convert_mb_str (p->ttyp->term_code_page, mbbuf, &nlen,
 			  cp_from, ptr, wlen, &mbp);
 
 	  ptr = mbbuf;
 	  wlen = rlen = nlen;
 	}
 
-      acquire_output_mutex (INFINITE);
+      WaitForSingleObject (p->output_mutex, INFINITE);
       while (rlen>0)
 	{
-	  if (!process_opost_output (to_master_cyg, ptr, wlen, false))
+	  if (!process_opost_output (p->to_master_cyg, ptr, wlen, false,
+				     p->ttyp, false))
 	    {
 	      termios_printf ("WriteFile for forwarding failed, %E");
 	      break;
@@ -2256,7 +2275,7 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  ptr += wlen;
 	  wlen = (rlen -= wlen);
 	}
-      release_output_mutex ();
+      ReleaseMutex (p->output_mutex);
     }
   return 0;
 }
@@ -2264,7 +2283,9 @@ fhandler_pty_master::pty_master_fwd_thread ()
 static DWORD WINAPI
 pty_master_fwd_thread (VOID *arg)
 {
-  return ((fhandler_pty_master *) arg)->pty_master_fwd_thread ();
+  fhandler_pty_master::master_fwd_thread_param_t p;
+  ((fhandler_pty_master *) arg)->get_master_fwd_thread_param (&p);
+  return fhandler_pty_master::pty_master_fwd_thread (&p);
 }
 
 bool
@@ -2312,6 +2333,15 @@ fhandler_pty_master::setup ()
       goto err;
     }
 
+  __small_sprintf (pipename, "pty%d-to-slave", unit);
+  res = fhandler_pipe::create (&sec_none, &from_master, &to_slave,
+			       fhandler_pty_common::pipesize, pipename, 0);
+  if (res)
+    {
+      errstr = "input pipe";
+      goto err;
+    }
+
   ProtectHandle1 (from_slave, from_pty);
 
   __small_sprintf (pipename, "pty%d-echoloop", unit);
@@ -2366,27 +2396,23 @@ fhandler_pty_master::setup ()
       errstr = "pty master control pipe";
       goto err;
     }
+
+  thread_param_copied_event = CreateEvent(NULL, FALSE, FALSE, NULL);
   master_thread = new cygthread (::pty_master_thread, this, "ptym");
   if (!master_thread)
     {
       errstr = "pty master control thread";
       goto err;
     }
+  WaitForSingleObject (thread_param_copied_event, INFINITE);
   master_fwd_thread = new cygthread (::pty_master_fwd_thread, this, "ptymf");
   if (!master_fwd_thread)
     {
       errstr = "pty master forwarding thread";
       goto err;
     }
-
-  __small_sprintf (pipename, "pty%d-to-slave", unit);
-  res = fhandler_pipe::create (&sec_none, &from_master, &to_slave,
-			       fhandler_pty_common::pipesize, pipename, 0);
-  if (res)
-    {
-      errstr = "input pipe";
-      goto err;
-    }
+  WaitForSingleObject (thread_param_copied_event, INFINITE);
+  CloseHandle (thread_param_copied_event);
 
   t.set_from_master (from_master);
   t.set_from_master_cyg (from_master_cyg);
@@ -2463,7 +2489,9 @@ fhandler_pty_master::fixup_after_exec ()
 }
 
 BOOL
-fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr, ssize_t& len, bool is_echo)
+fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr,
+					   ssize_t& len, bool is_echo,
+					   tty *ttyp, bool is_nonblocking)
 {
   ssize_t towrite = len;
   BOOL res = TRUE;
@@ -2471,7 +2499,7 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr, ssize_t& l
     {
       if (!is_echo)
 	{
-	  if (tc ()->output_stopped && is_nonblocking ())
+	  if (ttyp->output_stopped && is_nonblocking)
 	    {
 	      if (towrite < len)
 		break;
@@ -2482,11 +2510,11 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr, ssize_t& l
 		  return TRUE;
 		}
 	    }
-	  while (tc ()->output_stopped)
+	  while (ttyp->output_stopped)
 	    cygwait (10);
 	}
 
-      if (!(get_ttyp ()->ti.c_oflag & OPOST))	// raw output mode
+      if (!(ttyp->ti.c_oflag & OPOST))	// raw output mode
 	{
 	  DWORD n = MIN (OUT_BUFFER_SIZE, towrite);
 	  res = WriteFile (h, ptr, n, &n, NULL);
@@ -2506,13 +2534,13 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr, ssize_t& l
 	      switch (buf[rc])
 		{
 		case '\r':
-		  if ((get_ttyp ()->ti.c_oflag & ONOCR)
-		      && get_ttyp ()->column == 0)
+		  if ((ttyp->ti.c_oflag & ONOCR)
+		      && ttyp->column == 0)
 		    {
 		      rc++;
 		      continue;
 		    }
-		  if (get_ttyp ()->ti.c_oflag & OCRNL)
+		  if (ttyp->ti.c_oflag & OCRNL)
 		    {
 		      outbuf[n++] = '\n';
 		      rc++;
@@ -2520,22 +2548,22 @@ fhandler_pty_common::process_opost_output (HANDLE h, const void *ptr, ssize_t& l
 		  else
 		    {
 		      outbuf[n++] = buf[rc++];
-		      get_ttyp ()->column = 0;
+		      ttyp->column = 0;
 		    }
 		  break;
 		case '\n':
-		  if (get_ttyp ()->ti.c_oflag & ONLCR)
+		  if (ttyp->ti.c_oflag & ONLCR)
 		    {
 		      outbuf[n++] = '\r';
-		      get_ttyp ()->column = 0;
+		      ttyp->column = 0;
 		    }
-		  if (get_ttyp ()->ti.c_oflag & ONLRET)
-		    get_ttyp ()->column = 0;
+		  if (ttyp->ti.c_oflag & ONLRET)
+		    ttyp->column = 0;
 		  outbuf[n++] = buf[rc++];
 		  break;
 		default:
 		  outbuf[n++] = buf[rc++];
-		  get_ttyp ()->column++;
+		  ttyp->column++;
 		  break;
 		}
 	    }
@@ -2877,3 +2905,25 @@ fhandler_pty_slave::create_invisible_console ()
        this process becomes the primary. */
     get_ttyp ()->invisible_console_pid = myself->pid;
 }
+
+void
+fhandler_pty_master::get_master_thread_param (master_thread_param_t *p)
+{
+  p->from_master = from_master;
+  p->from_master_cyg = from_master_cyg;
+  p->to_master = to_master;
+  p->to_master_cyg = to_master_cyg;
+  p->master_ctl = master_ctl;
+  p->input_available_event = input_available_event;
+  SetEvent (thread_param_copied_event);
+}
+
+void
+fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
+{
+  p->to_master_cyg = to_master_cyg;
+  p->from_slave = from_slave;
+  p->output_mutex = output_mutex;
+  p->ttyp = get_ttyp ();
+  SetEvent (thread_param_copied_event);
+}
-- 
2.30.0

