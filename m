Return-Path: <SRS0=7Ga2=FM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id A537A4BA2E24
	for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2026 13:12:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A537A4BA2E24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A537A4BA2E24
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784380365; cv=none;
	b=XvVEU+2uUa+Q5Lp3iOVvLJ0hYw4DtAuSqtZpdkuejrUYVYvgBDtNceLAb4w+wXm34CZXBzI6ISyqWaKoLJta4elpk1Zp3Fm8cfrfFjQfA+AKWwTZWj/L6DBZeixxLicEUL6v4kz/s1kVdBRRtYMUM2FKYCZJJ84ruAZFGRYURdc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784380365; c=relaxed/simple;
	bh=qKrXK+i5Pf9uU8Tr12d/pUkqlm/jqy2JfLUbcd1lM1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=LNs4srXK6qJa1JGQpvi7AbLX76AdtWpVZo/db8Xs7RpJuQSj57FNQR033qjjJeTz9chjmPE+qpokBBC00hmZZlY16tXrCVLudBmINdfDLRWNv3CSCE9NDvInxoFCv/ZlvejlxgPjGJ2Kg9d1cMqWejyuJwLeRD+FWcIxGgXj8W8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YmKRVnY/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A537A4BA2E24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YmKRVnY/
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260718131234580.BHXS.60338.HP-Z230@nifty.com>;
          Sat, 18 Jul 2026 22:12:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Date: Sat, 18 Jul 2026 22:12:14 +0900
Message-ID: <20260718131226.1350-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784380354;
 bh=8DojEpL5Cs70TXT3RYcYVCOgkOwcQYciiGQmTHGY0us=;
 h=From:To:Cc:Subject:Date;
 b=YmKRVnY/l4f6itwl6sCZkyXLlaGL1aIodwXjN7TU4S/wGP5F4m0BPVMmrywHWXIn3kJnqy2i
 vnXcTtEjtD2I1Ok1AbqeO32AzJwli9RO+2emR8bvhHxZ8u452QWGCSsuskrgXFuUuhPci6Q9ZC
 nCyK4WREJMm0XJcoEYHXeU7b3T4WI5ysqt6zvpExyArWdPvH45TOueNfmmTLe6zGKT7krN2Cmy
 B4EOcJ4gA5dtJj0mWtQgUyYNcP2P6EhLa6pumCEb0hDBpptpENjnSit0iqMq5e4cCL6iLtgy8j
 P6qBJVAuqvIBqvYn4HiSK8EOshQoW1Vj5R7ZOqqQlqqlfFqQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/console.cc       | 138 ++++++++++++++++++++++--
 winsup/cygwin/fhandler/termios.cc       |  11 ++
 winsup/cygwin/local_includes/fhandler.h |   6 ++
 winsup/cygwin/spawn.cc                  |   4 +
 4 files changed, 150 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c87f29f..57145d048 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -841,6 +841,7 @@ fhandler_console::setup ()
       con.num_processed = 0;
       con.curr_input_mode = tty::restore;
       con.curr_output_mode = tty::restore;
+      con.non_cygwin_app_setup_ongoing_cnt = 0;
     }
 }
 
@@ -977,15 +978,85 @@ fhandler_console::setup_for_non_cygwin_app ()
      console mode. */
   if (get_ttyp ()->getpgid () == myself->pgid)
     {
+      set_non_cygwin_app_setup_ongoing (true);
+      WaitForSingleObject (cons_mode_mutex, INFINITE);
       set_disable_master_thread (true, this);
       set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
       set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
+      ReleaseMutex (cons_mode_mutex);
     }
 }
 
+void
+fhandler_console::set_non_cygwin_app_setup_ongoing (bool x)
+{
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
+  const _minor_t unit = cygheap->ctty->get_minor ();
+  if (con.non_cygwin_app_setup_ongoing_cnt)
+    return 1;
+
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
+  if (cygheap->ctty->tc()->pgid != myself->pgid)
+    return;
+
+  WaitForSingleObject (p->cons_mode_mutex, INFINITE);
+  switch (active_non_cygwin_apps_exist (cygheap->ctty->tc()->pgid))
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
   const _minor_t unit = p->unit;
   termios dummy = {0, };
   termios *ti = shared_console_info[unit] ?
@@ -999,6 +1070,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
+  ReleaseMutex (p->cons_mode_mutex);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1055,6 +1127,10 @@ fhandler_console::setup_io_mutex (void)
   if (res == WAIT_OBJECT_0)
     release_output_mutex ();
 
+  shared_name (buf, "cygcons.cons_mode.mutex", get_minor ());
+  if (!cons_mode_mutex)
+    cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
+
   extern HANDLE attach_mutex;
   if (!attach_mutex)
     attach_mutex = CreateMutex (&sec_none_nih, FALSE, NULL);
@@ -1189,6 +1265,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   /* Setting-up console mode for cygwin app. This is necessary if the
      cygwin app and other non-cygwin apps are started simultaneously
      in the same process group. */
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
       set_disable_master_thread (false, this);
@@ -1196,6 +1273,7 @@ fhandler_console::bg_check (int sig, bool dontsignal)
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
+  ReleaseMutex (cons_mode_mutex);
 
   return fhandler_termios::bg_check (sig, dontsignal);
 }
@@ -2010,6 +2088,7 @@ fhandler_console::open (int flags, mode_t)
   if (in_is_console)
     CloseHandle (h_in);
 
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (in_is_console && con.curr_input_mode != tty::cygwin)
     {
       prev_input_mode_backup = con.prev_input_mode;
@@ -2022,6 +2101,7 @@ fhandler_console::open (int flags, mode_t)
       GetConsoleMode (get_output_handle (), &con.prev_output_mode);
       set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
+  ReleaseMutex (cons_mode_mutex);
 
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
@@ -2105,6 +2185,7 @@ fhandler_console::open_setup (int flags)
       handle_set.output_handle = get_output_handle ();
       handle_set.input_mutex = input_mutex;
       handle_set.output_mutex = output_mutex;
+      handle_set.cons_mode_mutex = cons_mode_mutex;
       handle_set.unit = unit;
     }
   return fhandler_base::open_setup (flags);
@@ -2114,6 +2195,7 @@ void
 fhandler_console::post_open_setup (int fd)
 {
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
   if (fd == 0)
     {
       set_disable_master_thread (false, this);
@@ -2121,6 +2203,7 @@ fhandler_console::post_open_setup (int fd)
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+  ReleaseMutex (cons_mode_mutex);
 
   fhandler_base::post_open_setup (fd);
 }
@@ -2130,18 +2213,20 @@ fhandler_console::close (int flag)
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
@@ -2196,6 +2281,8 @@ fhandler_console::close (int flag)
   input_mutex = NULL;
   CloseHandle (output_mutex);
   output_mutex = NULL;
+  CloseHandle (cons_mode_mutex);
+  cons_mode_mutex = NULL;
 
   pcon_hand_over_proc ();
 
@@ -2369,10 +2456,12 @@ int
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
 
@@ -3140,10 +3229,24 @@ fhandler_console::char_command (char c)
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
@@ -4475,10 +4578,13 @@ fhandler_console::set_console_mode_to_native ()
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
@@ -4536,7 +4642,16 @@ static FARPROC
 GetProcAddress_Hooked (HMODULE h, LPCSTR n)
 {
   if (strcmp(n, "RequestTermConnector") == 0)
-    fhandler_console::set_disable_master_thread (true);
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
 
@@ -4817,6 +4932,9 @@ fhandler_console::get_duplicated_handle_set (handle_set_t *p)
   DuplicateHandle (GetCurrentProcess (), output_mutex,
 		   GetCurrentProcess (), &p->output_mutex,
 		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  DuplicateHandle (GetCurrentProcess (), cons_mode_mutex,
+		   GetCurrentProcess (), &p->cons_mode_mutex,
+		   0, FALSE, DUPLICATE_SAME_ACCESS);
   p->unit = unit;
 }
 
@@ -4833,6 +4951,8 @@ fhandler_console::close_handle_set (handle_set_t *p)
   p->input_mutex = NULL;
   CloseHandle (p->output_mutex);
   p->output_mutex = NULL;
+  CloseHandle (p->cons_mode_mutex);
+  p->cons_mode_mutex = NULL;
 }
 
 bool
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index ee576a0a8..f8269cc4f 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -826,6 +826,17 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
     }
 }
 
+void
+fhandler_termios::spawn_worker::notify_spawned (bool success)
+{
+  if (cygheap->ctty && cygheap->ctty->get_major () == DEV_CONS_MAJOR
+      && cygheap->ctty->tc ()->getpgid () == myself->pgid)
+    {
+      fhandler_console *cons = (fhandler_console *) cygheap->ctty;
+      cons->set_non_cygwin_app_setup_ongoing (false);
+    }
+}
+
 void
 fhandler_termios::spawn_worker::cleanup ()
 {
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index d11b3ec4f..d9b94b1e4 100644
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
+  void set_non_cygwin_app_setup_ongoing (bool);
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 8f976b9a0..50a924e39 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -718,6 +718,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
 	  res = -1;
 	  cygheap->unlock ();
+	  term_spawn_worker.notify_spawned (false);
 	  __leave;
 	}
 
@@ -770,6 +771,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		set_errno (EAGAIN);
 	      res = -1;
 	      cygheap->unlock ();
+	      term_spawn_worker.notify_spawned (false);
 	      __leave;
 	    }
 	  child->dwProcessId = pi.dwProcessId;
@@ -806,9 +808,11 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	      ForceCloseHandle (pi.hThread);
 	      res = -1;
 	      cygheap->unlock ();
+	      term_spawn_worker.notify_spawned (false);
 	      __leave;
 	    }
 	}
+      term_spawn_worker.notify_spawned (true);
 
       /* Start the child running */
       if (c_flags & CREATE_SUSPENDED)
-- 
2.51.0

