Return-Path: <SRS0=l0P4=FO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 340F24BA23EF
	for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2026 08:58:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 340F24BA23EF
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 340F24BA23EF
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784537918; cv=none;
	b=CMGAF7+N0shu5dISHIRvmx4em+IBuMhHY8DDBjPcjua1J6NyUlrIbuDOuy4dZjgk/qp/MpAMX5JU4sdn011nW8tftoyorLksDXJHuRVPqORNyba+4Lp3XpyFhJEWSBz0SI/InZSjG8mBRq1q4y5orpYOUhniSrxDl2rjBVk8CD0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784537918; c=relaxed/simple;
	bh=8MXuPb9eEfMASZdFFKYJS2gjjkqESdBN9kzQc58IRds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Dk+jF0TjJ4/l02nW5YdqjiFkeG9DBhJHmPpARIQUnzSR0BYC5/7mK+Tsum+Fs+BhxcUHDsQN+P4s8ZLEqRBt0lVCJTbqtXNSMwByt6ypvvGLT9TBlL0CUvHf4Tsq5ADF20hmg1W6uKm9rHew7DaHeR/3bZVkYthUFwdZs4WUe/0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=C92aJYzi
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 340F24BA23EF
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=C92aJYzi
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260720085834263.DZOR.17441.HP-Z230@nifty.com>;
          Mon, 20 Jul 2026 17:58:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v10] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Date: Mon, 20 Jul 2026 17:58:16 +0900
Message-ID: <20260720085826.61425-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784537914;
 bh=uw4Lfch5V5utVXQvW1+6Szorpl17EOIx9LH8T4sf90I=;
 h=From:To:Cc:Subject:Date;
 b=C92aJYziK6eU7VhVHspUwWqEqQzVer/Uub9C+yiLjkVN3oowvl0vcgYl3kGeAq1mcmiOmhi5
 y4JLaL2irf3JiOrxxMIW6uL8b5hxWWf4LFWEnbTHV3rnj35CI5NPDkgpRGWVtm7k8EaUzZZDjP
 dVG/loSyVSqVaBg9PPlnVGqraa3on3IICZ3n+p0vKvYxm2E6jo/GK3rZkLZujR60ndV8ptVmhS
 Ji5GNgGK6clcdEeVAZGxg2bPPn5NiW74s9xmT3OunoXpQPf3Y30sVrKTzsCq2vqD3V4xt0sdzz
 FDKmjT8+3Q127QJtdCmedTRw4XkaJ5q5cFgOYGEakwxzSs1Q==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, if two non-cygwin apps are started and one of them
exits first, the other one loosed appropriate console mode, since
the first one restored it to tty::cygwin. This patch counts the
active console process whose pgid is pgid of the tty and if the
result is zero (means the last non-cygwin foreground process),
restore console mode. To avoid race issue between apps modifying
console mode simultaneously, this patch also introduce a mutex
named `cons_mode_mutex`.

Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Stop counting up/down the counter by itself.
    Use num_active_non_cygwin_apps() instead.
v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.
v4: Guard all mode changes in console by cons_mode_mutex.
v5: Fix the issue of mutex acquisition order.
    Fix the race window around the process creation.
    Improve latency of checking existence of non-cygwin apps.
    Handle errors in checking existence of non-cygwin apps.
v6: Match the conditions for incrementing and decrementing the counter.
v7: Decrement the counter only if it was incremented by myself.
v8: Symlify the conditions for incrementing and decrementing the counter
    a bit.
v9: Minimize the argument of set_non_cygwin_app_setup_ongoing().
v10: Set process_state before calling spawn_worker::setup() rather than
     using the counter. In addition, resume non-cygwin app before
	 modifying process table. These make things much simpler.
     Narrowing the period of acquiring input_mutex in peek_console()
     in select.cc.

 winsup/cygwin/fhandler/console.cc       | 131 ++++++++++++++++++++++--
 winsup/cygwin/fhandler/termios.cc       |  29 ++++--
 winsup/cygwin/local_includes/fhandler.h |   5 +-
 winsup/cygwin/select.cc                 |  14 +--
 winsup/cygwin/spawn.cc                  |  46 +++++----
 5 files changed, 176 insertions(+), 49 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c87f29f..199ea1614 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -977,16 +977,78 @@ fhandler_console::setup_for_non_cygwin_app ()
      console mode. */
   if (get_ttyp ()->getpgid () == myself->pgid)
     {
+      WaitForSingleObject (cons_mode_mutex, INFINITE);
       set_disable_master_thread (true, this);
       set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
       set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
+      ReleaseMutex (cons_mode_mutex);
     }
 }
 
+/* Return values
+   0: not exist
+   1: exist
+  -1: error */
+int
+fhandler_console::active_non_cygwin_apps_exist (pid_t pgid)
+{
+  tmp_pathbuf tp;
+  DWORD *list = (DWORD *) tp.c_get ();
+  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
+
+  DWORD buf_size1 = 1;
+  DWORD num;
+  /* The buffer of too large size does not seem to be expected by new condrv.
+     https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448548
+     Use the minimum buffer size in the loop. */
+  while ((num = GetConsoleProcessList (list, buf_size1)) > buf_size1)
+    {
+      if (num > buf_size)
+	return -1;
+      buf_size1 = num;
+    }
+  if (num == 0)
+    return -1;
+
+  /* Last one is the oldest. */
+  /* https://github.com/microsoft/terminal/issues/95 */
+  /* Assuming that newer processes are more likely to be non-cygwin. */
+  for (DWORD i = 0; i < num; i++)
+    {
+      DWORD my_pid = myself->exec_dwProcessId ? : myself->dwProcessId;
+      if (list[i] == my_pid)
+	continue;
+      pid_t pid = cygwin_pid (list[i]);
+      if (pid == 0)
+	continue;
+      pinfo p (cygwin_pid (list[i]));
+      if (!!p && p->pgid == pgid && ISSTATE (p, PID_NOTCYGWIN))
+	return 1;
+    }
+  return 0;
+}
+
 void
 fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
 {
   const _minor_t unit = p->unit;
+  pid_t pgid = shared_console_info[unit] ?
+    shared_console_info[unit]->tty_min_state.getpgid () : 0;
+
+  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
+  switch (active_non_cygwin_apps_exist (pgid))
+    {
+    case 1: /* Exist */
+      ReleaseMutex (p->cons_mode_mutex);
+      return;
+    case 0: /* Not exist */
+      break;
+    case -1: /* Error */
+    default:
+      system_printf("Checking for existence of non-cygwin app failed.");
+      break;
+    }
+
   termios dummy = {0, };
   termios *ti = shared_console_info[unit] ?
     &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
@@ -999,6 +1061,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
+  ReleaseMutex (p->cons_mode_mutex);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1055,6 +1118,10 @@ fhandler_console::setup_io_mutex (void)
   if (res == WAIT_OBJECT_0)
     release_output_mutex ();
 
+  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
+  if (!cons_mode_mutex)
+    cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
+
   extern HANDLE attach_mutex;
   if (!attach_mutex)
     attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
@@ -1189,6 +1256,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   /* Setting-up console mode for cygwin app. This is necessary if the
      cygwin app and other non-cygwin apps are started simultaneously
      in the same process group. */
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
       set_disable_master_thread (false, this);
@@ -1196,6 +1264,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+  ReleaseMutex (cons_mode_mutex);
 
   return fhandler_termios::bg_check (sig, dontsignal);
 }
@@ -2010,6 +2079,7 @@ fhandler_console::open (int flags, mode_t)
   if (in_is_console)
     CloseHandle (h_in);
 
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (in_is_console && con.curr_input_mode != tty::cygwin)
     {
       prev_input_mode_backup = con.prev_input_mode;
@@ -2022,6 +2092,7 @@ fhandler_console::open (int flags, mode_t)
       GetConsoleMode (get_output_handle (), &con.prev_output_mode);
       set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
+  ReleaseMutex (cons_mode_mutex);
 
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
@@ -2105,6 +2176,7 @@ fhandler_console::open_setup (int flags)
       handle_set.output_handle = get_output_handle ();
       handle_set.input_mutex = input_mutex;
       handle_set.output_mutex = output_mutex;
+      handle_set.cons_mode_mutex = cons_mode_mutex;
       handle_set.unit = unit;
     }
   return fhandler_base::open_setup (flags);
@@ -2114,6 +2186,7 @@ void
 fhandler_console::post_open_setup (int fd)
 {
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (fd == 0)
     {
       set_disable_master_thread (false, this);
@@ -2121,6 +2194,7 @@ fhandler_console::post_open_setup (int fd)
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+  ReleaseMutex (cons_mode_mutex);
 
   fhandler_base::post_open_setup (fd);
 }
@@ -2130,18 +2204,20 @@ fhandler_console::close (int flag)
 {
   debug_printf ("closing: %p, %p", get_handle (), get_output_handle ());
 
-  acquire_output_mutex (mutex_timeout);
-
   if (shared_console_info[unit] && (dev_t) myself->ctty == get_device ()
       && cons_mode_on_close (&handle_set) == tty::restore)
     {
+      WaitForSingleObject (cons_mode_mutex, INFINITE);
       set_disable_master_thread (true, this);
       if (con.curr_output_mode != tty::restore)
 	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
       if (con.curr_input_mode != tty::restore)
 	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+      ReleaseMutex (cons_mode_mutex);
     }
 
+  acquire_output_mutex (mutex_timeout);
+
   if (shared_console_info[unit] && con.owner == GetCurrentProcessId ())
     {
       if (master_thread_started)
@@ -2196,6 +2272,8 @@ fhandler_console::close (int flag)
   input_mutex = NULL;
   CloseHandle (output_mutex);
   output_mutex = NULL;
+  CloseHandle (cons_mode_mutex);
+  cons_mode_mutex = NULL;
 
   pcon_hand_over_proc ();
 
@@ -2369,10 +2447,12 @@ int
 fhandler_console::tcsetattr (int a, struct termios const *t)
 {
   get_ttyp ()->ti = *t;
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (con.curr_input_mode == tty::cygwin)
     set_input_mode (tty::cygwin, t, &handle_set);
   if (con.curr_output_mode == tty::cygwin)
     set_output_mode (tty::cygwin, t, &handle_set);
+  ReleaseMutex (cons_mode_mutex);
   return 0;
 }
 
@@ -3140,10 +3220,24 @@ fhandler_console::char_command (char c)
 		    con.cursor_key_app_mode = (c == 'h');
 		  if (con.args[i] == 9001) /* win32-input-mode (https://github.com/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard%20handling%20in%20Conpty.md) */
 		    {
-		      set_disable_master_thread (c == 'h', this);
-		      if (con.curr_input_mode == tty::cygwin)
-			set_input_mode (tty::cygwin,
-					&tc ()->ti, get_handle_set ());
+		      /* The correnct order of acquiring mutex should be
+			 cons_mode_mutex first, then output_mutex.
+			 However, here, output_mutex is already acquired.
+			 So, to avoid deadlock, if another mode change is
+			 on going concurrently, that one takes precedence,
+			 and do not change the mode here. Even if we manage
+			 to get the mutex acquisition order right, which
+			 one ends up taking precedence is still a matter
+			 of luck. The later one overwrites the earlier one. */
+		      DWORD wret = WaitForSingleObject (cons_mode_mutex, 0);
+		      if (wret == WAIT_OBJECT_0)
+			{
+			  set_disable_master_thread (c == 'h', this);
+			  if (con.curr_input_mode == tty::cygwin)
+			    set_input_mode (tty::cygwin,
+					    &tc ()->ti, get_handle_set ());
+			  ReleaseMutex (cons_mode_mutex);
+			}
 		    }
 		}
 	      /* Call fix_tab_position() if screen has been alternated. */
@@ -4475,10 +4569,13 @@ fhandler_console::set_console_mode_to_native ()
 	fhandler_console *cons = (fhandler_console *) (fhandler_base *) cfd;
 	if (cons->get_device () == cons->tc ()->getntty ())
 	  {
+	    const fhandler_console::handle_set_t *p = cons->get_handle_set ();
+	    WaitForSingleObject (p->cons_mode_mutex, INFINITE);
 	    set_disable_master_thread (true, cons);
 	    termios *cons_ti = &cons->tc ()->ti;
-	    set_input_mode (tty::native, cons_ti, cons->get_handle_set ());
-	    set_output_mode (tty::native, cons_ti, cons->get_handle_set ());
+	    set_input_mode (tty::native, cons_ti, p);
+	    set_output_mode (tty::native, cons_ti, p);
+	    ReleaseMutex (p->cons_mode_mutex);
 	    break;
 	  }
       }
@@ -4535,8 +4632,17 @@ ContinueDebugEvent_Hooked
 static FARPROC
 GetProcAddress_Hooked (HMODULE h, LPCSTR n)
 {
-  if (strcmp(n, "RequestTermConnector") == 0)
-    fhandler_console::set_disable_master_thread (true);
+  if (cygheap->ctty && strcmp(n, "RequestTermConnector") == 0)
+    {
+      char buf[MAX_PATH];
+      const _minor_t unit = cygheap->ctty->get_minor ();
+      shared_name (buf, "cygcons.cons_mode.mutex", unit);
+      HANDLE cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
+      WaitForSingleObject (cons_mode_mutex, INFINITE);
+      fhandler_console::set_disable_master_thread (true);
+      ReleaseMutex (cons_mode_mutex);
+      CloseHandle (cons_mode_mutex);
+    }
   return GetProcAddress_Orig (h, n);
 }
 
@@ -4817,6 +4923,9 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
   DuplicateHandle (GetCurrentProcess (), output_mutex,
 		   GetCurrentProcess (), &p->output_mutex,
 		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
+		   GetCurrentProcess (), &p->cons_mode_mutex,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
   p->unit = unit;
 }
 
@@ -4833,6 +4942,8 @@ fhandler_console::close_handle_set (handle_set_t *p)
   p->input_mutex = NULL;
   CloseHandle (p->output_mutex);
   p->output_mutex = NULL;
+  CloseHandle (p->cons_mode_mutex);
+  p->cons_mode_mutex = NULL;
 }
 
 bool
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index ee576a0a8..dcd5472cc 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -830,20 +830,24 @@ void
 fhandler_termios::spawn_worker::cleanup ()
 {
   if (ptys_need_cleanup)
-    fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
-						    ptys_ttyp, stdin_is_ptys);
+    {
+      fhandler_pty_slave::cleanup_for_non_cygwin_app (&ptys_handle_set,
+						      ptys_ttyp, stdin_is_ptys);
+      fhandler_pty_slave::close_handle_set (&ptys_handle_set);
+      ptys_need_cleanup = false;
+    }
   if (cons_need_cleanup)
-    fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
-  close_handle_set ();
+    {
+      fhandler_console::cleanup_for_non_cygwin_app (&cons_handle_set);
+      fhandler_console::close_handle_set (&cons_handle_set);
+      cons_need_cleanup = false;
+    }
 }
 
-void
-fhandler_termios::spawn_worker::close_handle_set ()
+bool
+fhandler_termios::spawn_worker::is_attaching (DWORD pid)
 {
-  if (ptys_need_cleanup)
-    fhandler_pty_slave::close_handle_set (&ptys_handle_set);
-  if (cons_need_cleanup)
-    fhandler_console::close_handle_set (&cons_handle_set);
+  return !!fhandler_termios::get_console_process_id (pid, true);
 }
 
 void
@@ -916,7 +920,10 @@ fhandler_termios::get_console_process_id (DWORD pid, bool match,
 	  }
 	else
 	  {
-	    pinfo p (cygwin_pid (list[i]));
+	    pid_t cygpid = cygwin_pid (list[i]);
+	    if (cygpid == 0)
+	      continue;
+	    pinfo p (cygpid);
 	    if (nat && !!p && !ISSTATE(p, PID_NOTCYGWIN))
 	      continue;
 	    if (!!p && p->exec_dwProcessId)
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index d11b3ec4f..eb96435bd 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2023,6 +2023,7 @@ class fhandler_termios: public fhandler_base
     HANDLE output_handle;
     HANDLE input_mutex;
     HANDLE output_mutex;
+    HANDLE cons_mode_mutex;
     _minor_t unit;
   };
   class spawn_worker
@@ -2042,7 +2043,7 @@ class fhandler_termios: public fhandler_base
 		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
     bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
     void cleanup ();
-    void close_handle_set ();
+    bool is_attaching (DWORD pid);
   };
 };
 
@@ -2199,6 +2200,7 @@ private:
   static console_state *shared_console_info[MAX_CONS_DEV + 1];
   static bool invisible_console;
   HANDLE input_mutex, output_mutex;
+  HANDLE cons_mode_mutex;
   handle_set_t handle_set;
   _minor_t unit;
   size_t num_input_events_processed;
@@ -2379,6 +2381,7 @@ private:
   void setup_pcon_hand_over ();
   static void pcon_hand_over_proc ();
   static tty::cons_mode cons_mode_on_close (handle_set_t *);
+  static int active_non_cygwin_apps_exist (pid_t pgid);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index b72083447..592f6d14d 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1154,23 +1154,23 @@ peek_console (select_record *me, bool)
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
-  fh->acquire_input_mutex (mutex_timeout);
   while (!fh->input_ready && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
-	{
-	  fh->release_input_mutex ();
-	  return me->read_ready = true;
-	}
+	return me->read_ready = true;
       else
 	{
+	  fh->acquire_input_mutex (mutex_timeout);
 	  acquire_attach_mutex (mutex_timeout);
 	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
 	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
 	  fh->detach_console (resume_pid, fh->get_owner ());
 	  release_attach_mutex ();
 	  if (!r || !events_read)
-	    break;
+	    {
+	      fh->release_input_mutex ();
+	      break;
+	    }
 	}
       if (fhandler_console::input_winch == fh->process_input_message (0)
 	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
@@ -1180,8 +1180,8 @@ peek_console (select_record *me, bool)
 	  fh->release_input_mutex ();
 	  return -1;
 	}
+      fh->release_input_mutex ();
     }
-  fh->release_input_mutex ();
   if (fh->input_ready || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8f976b9a0..c4daffe97 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -559,6 +559,14 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			 PROCESS_QUERY_LIMITED_INFORMATION))
 	sa = &sec_none_nih;
 
+      if (!real_path.iscygexec () && mode == _P_OVERLAY)
+	{
+	  LONG pidflags = PID_NOTCYGWIN;
+	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
+	    pidflags |= PID_NEW_PG;
+	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
+	}
+
       int fileno_stdin = in__stdin < 0 ? 0 : in__stdin;
       int fileno_stdout = in__stdout < 0 ? 1 : in__stdout;
       int fileno_stderr = 2;
@@ -586,14 +594,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 up on ruid. The new process will have ruid == euid. */
       ::cygheap->user.deimpersonate ();
 
-      if (!real_path.iscygexec () && mode == _P_OVERLAY)
-	{
-	  LONG pidflags = PID_NOTCYGWIN;
-	  if (c_flags & CREATE_NEW_PROCESS_GROUP)
-	    pidflags |= PID_NEW_PG;
-	  InterlockedOr ((LONG *) &myself->process_state, pidflags);
-	}
-
       cygpid = (mode != _P_OVERLAY) ? create_cygwin_pid () : myself->pid;
 
       cygheap->lock ();
@@ -737,6 +737,20 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       /* Name the handle similarly to proc_subproc. */
       ProtectHandle1 (pi.hProcess, childhProc);
 
+      /* Start the child running for non-cygwin process*/
+      if (!iscygwin () && (c_flags & CREATE_SUSPENDED))
+	{
+	  /* Inject a non-inheritable wr_proc_pipe handle into child so that we
+	     can accurately track when the child exits without keeping this
+	     process waiting around for it to exit.  */
+	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
+			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
+	  ResumeThread (pi.hThread);
+	  if (term_spawn_worker.is_attaching (myself->dwProcessId))
+	    while (!term_spawn_worker.is_attaching (pi.dwProcessId)
+		   && WaitForSingleObject (pi.hProcess, 0) == WAIT_TIMEOUT);
+	}
+
       if (mode == _P_OVERLAY)
 	{
 	  myself->dwProcessId = pi.dwProcessId;
@@ -810,18 +824,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
-      /* Start the child running */
-      if (c_flags & CREATE_SUSPENDED)
+      /* Start the child running for cygwin process*/
+      if (iscygwin () && (c_flags & CREATE_SUSPENDED))
 	{
-	  /* Inject a non-inheritable wr_proc_pipe handle into child so that we
-	     can accurately track when the child exits without keeping this
-	     process waiting around for it to exit.  */
-	  if (!iscygwin ())
-	    DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess, NULL,
-			     0, false, DUPLICATE_SAME_ACCESS);
 	  ResumeThread (pi.hThread);
-	  if (iscygwin ())
-	    strace.write_childpid (pi.dwProcessId);
+	  strace.write_childpid (pi.dwProcessId);
 	}
       ForceCloseHandle (pi.hThread);
 
@@ -868,7 +875,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		prev_sigExeced =
 		  InterlockedCompareExchange (&sigExeced, 0, prev_sigExeced);
 	      term_spawn_worker.cleanup ();
-	      term_spawn_worker.close_handle_set ();
 	    }
 	  /* Make sure that ctrl_c_handler() is not on going. Calling
 	     init_console_handler(false) locks until returning from
@@ -906,7 +912,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       res = -1;
     }
   __endtry
-  term_spawn_worker.close_handle_set ();
+  term_spawn_worker.cleanup ();
   this->cleanup ();
   if (envblock)
     free (envblock);
-- 
2.51.0

