Return-Path: <SRS0=MmMu=R3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 230FF3857722
	for <cygwin-patches@cygwin.com>; Thu, 31 Oct 2024 08:36:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 230FF3857722
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 230FF3857722
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730363786; cv=none;
	b=pGaidjt4aZoIsOi2v9/jCM5ISxmmhRvA2EZIVdOaL8WxLSwXzMBXmgfC/xw7oj6DZ00GZExVQgEUZzWR+kgYGIm2vvBaipJPprkFshr5YJjJvD/fSSkvWyDdX9uCJryZp6C6cvWmxJOVnAU1FmvQWaBDZWdvq/2s/QDtfk1CjRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730363786; c=relaxed/simple;
	bh=P0U5ggUCp80/aQT8IRzgg6dK5fpLfWiLF3ZpR5e5BuM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=mKfS2sA4n036JNm2cAeBwj5a9ozTsrrKJeEsNVTntVxEJMbt0xq8VAfg9CE3McjS+PqHu5wdILcIuyNwhVamLZU2jk+vKEqODQMHzn6/99AkCiIl8sxmOKPSc0BW/+vLwX8d0nzxtwydKYN/DFtSow7HgHl/6A/bhcyg6SDRXIE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20241031083612933.RTTI.76911.localhost.localdomain@nifty.com>;
          Thu, 31 Oct 2024 17:36:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	lmari Lauhakangas <ilmari.lauhakangas@libreoffice.org>
Subject: [PATCH] Cygwin: console: Inherit pcon hand over from parent pty
Date: Thu, 31 Oct 2024 17:08:55 +0900
Message-ID: <20241031080908.937-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730363773;
 bh=ulGRw1LideOjp89gdxqRkN74X6mNWUDtr8Sol5gWYlE=;
 h=From:To:Cc:Subject:Date;
 b=jRc1aEfIL36S7K2MNDRCO7A9wSO+BUM95FHxqsZCm6EaYIiGJuIe7i9Hp79FEJ4NyEXQyEy8
 4+potmmUKtLYFsSMiItu05K3zPQQWz4l0f5VcIcVEJ2jRpGaiNRAvydA/XbDbX0VEBpdZFBhcC
 Zkh7QjrRN9wWGmdvkh1TPWtH+QP8XKvMBy+sHHD2c3zKS63PF1KoiCPf6uVZ03ov1TUIOe6Vus
 KdwLGfcYFicYNfTobaLvVnhvMbp0sP7Hv83nZ9OHC0baSviCBPgFvvOak/oUk8UNgEU06zmsle
 /iVBXYTRZmJhja6K98Y9EoJwJon1vPOGpsP4ZiwReWc1zpGQ==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

There was a long-standing issue that pseudo console ownership could
not hand over from the process whose ctty is /dev/cons* rather than
/dev/pty*. This problem happens when a cygwin app starts non-cygwin
app in a pty, then the non-cygwin app starts multiple cygwin apps,
and the non-cygwin app ends before the second cygwin apps end.
In this case, the stub process of the non-cygwin app hands over the
ownership of pcon to one of the second cygwin apps, however, this
app does not hand over the ownership of pcon to another second
cygwin app. This is due to the fact that the hand-over feature is
implemented only in fhandler_pty_slave but not in fhandler_console.

With this patch, the second cygwin apps check if their console device
is inside a pseudo console, and if so, it tries to hand over the
ownership of the pseudo console to anther process that is attached
to the same pseudo console.

Addresses: https://cygwin.com/pipermail/cygwin/2024-February/255388.html
Fixes: 253352e796ff ("Cygwin: pty: Allow multiple apps to enable pseudo console simultaneously.")
Reported-by: lmari Lauhakangas <ilmari.lauhakangas@libreoffice.org>, Hossein Nourikhah <hossein@libreoffice.org>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc       | 64 ++++++++++++++++++++++++-
 winsup/cygwin/fhandler/pty.cc           | 13 ++++-
 winsup/cygwin/fhandler/termios.cc       |  6 +++
 winsup/cygwin/local_includes/fhandler.h |  4 ++
 winsup/cygwin/local_includes/tty.h      |  1 +
 winsup/cygwin/spawn.cc                  |  1 +
 6 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index dc43cd9f5..9cdc13dd2 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -60,6 +60,10 @@ const unsigned fhandler_console::MAX_WRITE_CHARS = 16384;
 fhandler_console::console_state NO_COPY
   *fhandler_console::shared_console_info[MAX_CONS_DEV + 1];
 
+static bool NO_COPY inside_pcon_checked = false;
+static bool NO_COPY inside_pcon = false;
+static int NO_COPY parent_pty;
+
 bool NO_COPY fhandler_console::invisible_console;
 
 /* con_ra is shared in the same process.
@@ -1894,12 +1898,69 @@ fhandler_console::open (int flags, mode_t)
   return 1;
 }
 
+void
+fhandler_console::setup_pcon_hand_over ()
+{
+  /* Prepare for pcon hand over */
+  if (!inside_pcon_checked)
+    for (int i = 0; i < NTTYS; i++)
+      {
+	if (!cygwin_shared->tty[i]->pcon_activated)
+	  continue;
+	DWORD owner = cygwin_shared->tty[i]->nat_pipe_owner_pid;
+	if (fhandler_pty_common::get_console_process_id
+					(owner, true, false, false, false))
+	  {
+	    inside_pcon = true;
+	    atexit (fhandler_console::pcon_hand_over_proc);
+	    parent_pty = i;
+	    break;
+	  }
+      }
+  inside_pcon_checked = true;
+}
+
+void
+fhandler_console::pcon_hand_over_proc (void)
+{
+  if (!inside_pcon)
+    return;
+  tty *ttyp = cygwin_shared->tty[parent_pty];
+  char buf[MAX_PATH];
+  shared_name (buf, PIPE_SW_MUTEX, parent_pty);
+  HANDLE mtx = OpenMutex (MAXIMUM_ALLOWED, FALSE, buf);
+  WaitForSingleObject (mtx, INFINITE);
+  ReleaseMutex (mtx);
+  DWORD res = WaitForSingleObject (mtx, INFINITE);
+  if (res == WAIT_OBJECT_0 || res == WAIT_ABANDONED)
+    {
+      DWORD owner = ttyp->nat_pipe_owner_pid;
+      if (owner == GetCurrentProcessId ()
+	  || owner == (myself->exec_dwProcessId ?: myself->dwProcessId))
+	fhandler_pty_slave::close_pseudoconsole (ttyp, 0);
+    }
+  else
+    system_printf("Acquiring pcon_ho_mutex failed.");
+  /* Do not release the mutex.
+     Hold onto the mutex until this process completes. */
+}
+
 bool
 fhandler_console::open_setup (int flags)
 {
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   if (myself->set_ctty (this, flags) && !myself->cygstarted)
-    init_console_handler (true);
+    {
+      init_console_handler (true);
+      setup_pcon_hand_over ();
+
+      /* Initialize handle_set */
+      handle_set.input_handle = get_handle ();
+      handle_set.output_handle = get_output_handle ();
+      handle_set.input_mutex = input_mutex;
+      handle_set.output_mutex = output_mutex;
+      handle_set.unit = unit;
+    }
   return fhandler_base::open_setup (flags);
 }
 
@@ -4327,6 +4388,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
       cygheap->ctty = NULL;
       return;
     }
+  setup_pcon_hand_over ();
 
   if (!execing)
     return;
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index fa6bf1096..c40adc289 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -102,6 +102,8 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
   for (int i = (int) num - 1; i >= 0; i--)
     if ((match && list[i] == pid) || (!match && list[i] != pid))
       {
+	if (!process_alive (list[i]))
+	  continue;
 	if (!cygwin)
 	  {
 	    res_pri = list[i];
@@ -117,7 +119,7 @@ fhandler_pty_common::get_console_process_id (DWORD pid, bool match,
 		res_pri = stub_only ? p->exec_dwProcessId : list[i];
 		break;
 	      }
-	    if (!p && !res && process_alive (list[i]) && stub_only)
+	    if (!p && !res && stub_only)
 	      res = list[i];
 	    if (!!p && !res && !stub_only)
 	      res = list[i];
@@ -1134,6 +1136,8 @@ process_alive (DWORD pid)
 inline static bool
 nat_pipe_owner_self (DWORD pid)
 {
+  if (pid == GetCurrentProcessId ())
+    return true;
   return (pid == (myself->exec_dwProcessId ?: myself->dwProcessId));
 }
 
@@ -3541,11 +3545,16 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
     {
       /* Search another native process which attaches to the same console */
       DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
+      if (ttyp->nat_pipe_owner_pid == GetCurrentProcessId ())
+	current_pid = GetCurrentProcessId ();
       switch_to = get_console_process_id (current_pid,
 					  false, true, true, true);
       if (!switch_to)
 	switch_to = get_console_process_id (current_pid,
 					    false, true, false, true);
+      if (!switch_to)
+	switch_to = get_console_process_id (current_pid,
+					    false, false, false, false);
     }
   return switch_to;
 }
@@ -3573,13 +3582,13 @@ fhandler_pty_slave::hand_over_only (tty *ttyp, DWORD force_switch_to)
 void
 fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 {
-  DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
   acquire_attach_mutex (mutex_timeout);
   ttyp->previous_code_page = GetConsoleCP ();
   ttyp->previous_output_code_page = GetConsoleOutputCP ();
   release_attach_mutex ();
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     { /* I am owner of the nat pipe. */
+      DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
       if (switch_to)
 	{
 	  /* Change pseudo console owner to another process (switch_to). */
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index d106955dc..2acb0e01f 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -827,3 +827,9 @@ fhandler_termios::spawn_worker::close_handle_set ()
   if (cons_need_cleanup)
     fhandler_console::close_handle_set (&cons_handle_set);
 }
+
+void
+fhandler_termios::atexit_func ()
+{
+  fhandler_console::pcon_hand_over_proc ();
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 24f355e41..4e274d854 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -1990,6 +1990,7 @@ class fhandler_termios: public fhandler_base
   virtual void setpgid_aux (pid_t pid) {}
   virtual bool need_console_handler () { return false; }
   virtual bool need_send_ctrl_c_event () { return true; }
+  static void atexit_func ();
 
   struct ptys_handle_set_t
   {
@@ -2351,6 +2352,9 @@ private:
     console_unit (int, HANDLE *input_mutex = NULL);
   };
 
+  void setup_pcon_hand_over ();
+  static void pcon_hand_over_proc ();
+
   friend tty_min * tty_list::get_cttyp ();
 };
 
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 53fa26b44..2a047d73f 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -178,6 +178,7 @@ public:
   friend class fhandler_pty_master;
   friend class fhandler_pty_slave;
   friend class tty_min;
+  friend class fhandler_console;
 };
 
 class tty_list
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 89404c464..60a82991a 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -876,6 +876,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	     ctrl_c_handler(). This insures that setting sigExeced
 	     on Ctrl-C key has been completed. */
 	  init_console_handler (false);
+	  fhandler_termios::atexit_func ();
 	  myself.exit (EXITCODE_NOSET);
 	  break;
 	case _P_WAIT:
-- 
2.45.1

