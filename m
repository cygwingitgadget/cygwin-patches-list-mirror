Return-Path: <SRS0=7Ga2=FM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id C9AF74BA2E11
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 15:58:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C9AF74BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C9AF74BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784390321; cv=none;
	b=cIbBjbL+yryNGWHntJawk7ObIZLVc4NFlvSRlBt5Cr3icx5T8fU+0YS+Qp28NJRkIEZmqt/AMHxSbclcFoIQVIV8PpthiRsvsjXTPArnsoceJusFoHK7hvVUU7riokuGVK4fzL3dbft3fleyIfIcJBzpT/fcRFSwtHjMwjRf+6E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784390321; c=relaxed/simple;
	bh=IKFIpPAYZjQOOn1nz5jMiX37taUdFTffPkHs1z0WCwo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=i3/Fs9b0Nrxw1rIVeAnUIkV25UN98xsRyFNGIEWTAK2rIaDUIKr4DAACp6sJCdNG9UPSyZ57ZNhU+6XFuukZxxQLkxEtNlpHXvWcH4h4VZwICrN97eLzt055ezuj6DIkDrN6NBWnKobzKRq6JZFsV6gDVRvgDnUYKUNAXxjhr1M=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EqRGyXSk
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C9AF74BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EqRGyXSk
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260718155836555.VMQT.44671.HP-Z230@nifty.com>;
          Sun, 19 Jul 2026 00:58:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Date: Sun, 19 Jul 2026 00:58:19 +0900
Message-ID: <20260718155829.12280-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784390316;
 bh=oHvr0ERstEeiwOMW/JYzuhuA70CuXevkKn9N72bk2fw=;
 h=From:To:Cc:Subject:Date;
 b=EqRGyXSkXbydOVa+zfBrEzl3wz6BIkR4t2+dqFM5GgA97A4iMxBg9N45GxZWfVR6ThSlDu9/
 IosDFaYwqaTYychZK74vJrUTR20Cs1opL0ElZFeUXz12p6LC2dvj61rm2gVCqtczqWnSXEHLMw
 PwpDkEhqCIJysy6/emgHYBTsNV+vsVuqV8YMMFizdi+zhLhAIGSxAFzmV01BRSyPV3qoIZHSwz
 qHbsirNE1XQ3g26cThlE5SozRePzM7QgmeN/DFnuuP87MinfK6IDYeRdvbkFmNj9/3fzkXfkp9
 PUHqhKYkx9/61sKkNPjgOwFo6frsj9MTMB3yOZ9sr3Odcu9A==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/console.cc       | 145 ++++++++++++++++++++++--
 winsup/cygwin/fhandler/termios.cc       |  10 ++
 winsup/cygwin/local_includes/fhandler.h |   6 +
 winsup/cygwin/spawn.cc                  |   8 ++
 4 files changed, 159 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c87f29f..a4480a5fc 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -841,6 +841,7 @@ fhandler_console::setup ()
       con.num_processed = 0;
       con.curr_input_mode = tty::restore;
       con.curr_output_mode = tty::restore;
+      con.non_cygwin_app_setup_ongoing_cnt = 0;
     }
 }
 
@@ -977,16 +978,91 @@ fhandler_console::setup_for_non_cygwin_app ()
      console mode. */
   if (get_ttyp ()->getpgid () == myself->pgid)
     {
+      set_non_cygwin_app_setup_ongoing (true, &handle_set);
+      WaitForSingleObject (cons_mode_mutex, INFINITE);
       set_disable_master_thread (true, this);
       set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
       set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
+      ReleaseMutex (cons_mode_mutex);
     }
 }
 
+void
+fhandler_console::set_non_cygwin_app_setup_ongoing (bool x, handle_set_t *p)
+{
+  const _minor_t unit = p->unit;
+  pid_t pgid = shared_console_info[unit] ?
+    shared_console_info[unit]->tty_min_state.getpgid () : 0;
+  if (pgid != myself->pgid)
+    return;
+  if (x)
+    InterlockedIncrement (&con.non_cygwin_app_setup_ongoing_cnt);
+  else
+    InterlockedDecrement (&con.non_cygwin_app_setup_ongoing_cnt);
+}
+
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
+  if (pgid != myself->pgid)
+    return;
+  if (con.non_cygwin_app_setup_ongoing_cnt)
+    return;
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
@@ -999,6 +1075,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
+  ReleaseMutex (p->cons_mode_mutex);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1055,6 +1132,10 @@ fhandler_console::setup_io_mutex (void)
   if (res == WAIT_OBJECT_0)
     release_output_mutex ();
 
+  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
+  if (!cons_mode_mutex)
+    cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
+
   extern HANDLE attach_mutex;
   if (!attach_mutex)
     attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
@@ -1189,6 +1270,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   /* Setting-up console mode for cygwin app. This is necessary if the
      cygwin app and other non-cygwin apps are started simultaneously
      in the same process group. */
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
       set_disable_master_thread (false, this);
@@ -1196,6 +1278,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+  ReleaseMutex (cons_mode_mutex);
 
   return fhandler_termios::bg_check (sig, dontsignal);
 }
@@ -2010,6 +2093,7 @@ fhandler_console::open (int flags, mode_t)
   if (in_is_console)
     CloseHandle (h_in);
 
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (in_is_console && con.curr_input_mode != tty::cygwin)
     {
       prev_input_mode_backup = con.prev_input_mode;
@@ -2022,6 +2106,7 @@ fhandler_console::open (int flags, mode_t)
       GetConsoleMode (get_output_handle (), &con.prev_output_mode);
       set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
+  ReleaseMutex (cons_mode_mutex);
 
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
@@ -2105,6 +2190,7 @@ fhandler_console::open_setup (int flags)
       handle_set.output_handle = get_output_handle ();
       handle_set.input_mutex = input_mutex;
       handle_set.output_mutex = output_mutex;
+      handle_set.cons_mode_mutex = cons_mode_mutex;
       handle_set.unit = unit;
     }
   return fhandler_base::open_setup (flags);
@@ -2114,6 +2200,7 @@ void
 fhandler_console::post_open_setup (int fd)
 {
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (fd == 0)
     {
       set_disable_master_thread (false, this);
@@ -2121,6 +2208,7 @@ fhandler_console::post_open_setup (int fd)
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+  ReleaseMutex (cons_mode_mutex);
 
   fhandler_base::post_open_setup (fd);
 }
@@ -2130,18 +2218,20 @@ fhandler_console::close (int flag)
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
@@ -2196,6 +2286,8 @@ fhandler_console::close (int flag)
   input_mutex = NULL;
   CloseHandle (output_mutex);
   output_mutex = NULL;
+  CloseHandle (cons_mode_mutex);
+  cons_mode_mutex = NULL;
 
   pcon_hand_over_proc ();
 
@@ -2369,10 +2461,12 @@ int
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
 
@@ -3140,10 +3234,24 @@ fhandler_console::char_command (char c)
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
@@ -4475,10 +4583,13 @@ fhandler_console::set_console_mode_to_native ()
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
@@ -4535,8 +4646,17 @@ ContinueDebugEvent_Hooked
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
 
@@ -4817,6 +4937,9 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
   DuplicateHandle (GetCurrentProcess (), output_mutex,
 		   GetCurrentProcess (), &p->output_mutex,
 		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
+		   GetCurrentProcess (), &p->cons_mode_mutex,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
   p->unit = unit;
 }
 
@@ -4833,6 +4956,8 @@ fhandler_console::close_handle_set (handle_set_t *p)
   p->input_mutex = NULL;
   CloseHandle (p->output_mutex);
   p->output_mutex = NULL;
+  CloseHandle (p->cons_mode_mutex);
+  p->cons_mode_mutex = NULL;
 }
 
 bool
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index ee576a0a8..9f0829d78 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -826,6 +826,16 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
     }
 }
 
+void
+fhandler_termios::spawn_worker::notify_spawned (bool success)
+{
+  if (cons_need_cleanup)
+    fhandler_console::set_non_cygwin_app_setup_ongoing (false,
+							&cons_handle_set);
+  if (!success && need_cleanup ())
+    cleanup ();
+}
+
 void
 fhandler_termios::spawn_worker::cleanup ()
 {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index d11b3ec4f..10efb7f6c 100644
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
@@ -2041,6 +2042,7 @@ class fhandler_termios: public fhandler_base
     void setup (bool iscygwin, HANDLE h_stdin, path_conv &pc,
 		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
     bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
+    void notify_spawned (bool success);
     void cleanup ();
     void close_handle_set ();
   };
@@ -2157,6 +2159,7 @@ class dev_console
   volatile bool master_thread_suspended;
   int num_processed; /* Number of input events in the current input buffer
 			already processed by cons_master_thread(). */
+  LONG non_cygwin_app_setup_ongoing_cnt;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
@@ -2199,6 +2202,7 @@ private:
   static console_state *shared_console_info[MAX_CONS_DEV + 1];
   static bool invisible_console;
   HANDLE input_mutex, output_mutex;
+  HANDLE cons_mode_mutex;
   handle_set_t handle_set;
   _minor_t unit;
   size_t num_input_events_processed;
@@ -2379,6 +2383,8 @@ private:
   void setup_pcon_hand_over ();
   static void pcon_hand_over_proc ();
   static tty::cons_mode cons_mode_on_close (handle_set_t *);
+  static int active_non_cygwin_apps_exist (pid_t pgid);
+  static void set_non_cygwin_app_setup_ongoing (bool, handle_set_t *);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8f976b9a0..ca8a69d3c 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -718,6 +718,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
 	  res = -1;
 	  cygheap->unlock ();
+	  if (!iscygwin ())
+	    term_spawn_worker.notify_spawned (false);
 	  __leave;
 	}
 
@@ -770,6 +772,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		set_errno (EAGAIN);
 	      res = -1;
 	      cygheap->unlock ();
+	      if (!iscygwin ())
+		term_spawn_worker.notify_spawned (false);
 	      __leave;
 	    }
 	  child->dwProcessId = pi.dwProcessId;
@@ -806,9 +810,13 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      ForceCloseHandle (pi.hThread);
 	      res = -1;
 	      cygheap->unlock ();
+	      if (!iscygwin ())
+		term_spawn_worker.notify_spawned (false);
 	      __leave;
 	    }
 	}
+      if (!iscygwin ())
+	term_spawn_worker.notify_spawned (true);
 
       /* Start the child running */
       if (c_flags & CREATE_SUSPENDED)
-- 
2.51.0

