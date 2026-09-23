Return-Path: <SRS0=ANL/=HP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 05B024BB24C7
	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2026 22:32:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05B024BB24C7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05B024BB24C7
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790202760; cv=none;
	b=hh7A22ozGnVH4LFKyyfuxfG2ieoV1N6STwQKnLNjTbyjPQtUb5ClzJ2FA/S+VGqYtuhYKW33n29aD0QVMkuku1o9OhfV2hCNmWrnFU2e78pm6MhSd5kM8n/CD/4mtZluF/0JloF9F3fyKm8BM4+H2mKbm3Tu808FrvU4s7HC6Ys=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790202760; c=relaxed/simple;
	bh=glds3Z40lc5sKsG8CwHXokjxkUmzhhzVh1CfSZ/1ULA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hAr8Mqe8pJ40Tm2LEEQMsh7OhmUv4snPXZwaoNxoDbyj8O8MOlJ4SIKFkRVWfxN/J6SXDhj9guRtp4YyTj5Dcn3yU52fsCsv+C2okUViL8dccbufh182Tm1+c0wlS5zHJj9PIuKK73GdrUn7iOFBWnqwYEoIKLmW9lciw4EwVHg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nuISqJDv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 05B024BB24C7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nuISqJDv
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260923223237086.VCYA.44671.HP-Z230@nifty.com>;
          Thu, 24 Sep 2026 07:32:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay Libove Alzina <libove@felines.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5] Cygwin: console: Abort setting disable_master_thread when no con.owner
Date: Thu, 24 Sep 2026 07:32:22 +0900
Message-ID: <20260923223230.3504-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790202757;
 bh=lmXDVvjOUu28Xma5l+URjQJGCKU+VLaK40yr3MYDUWQ=;
 h=From:To:Cc:Subject:Date;
 b=nuISqJDvuvtzWCcXR88R4c7iEA7RCeJf+WJvCbcp87UNdSGnz4NLjtakOQRuko+uM2xt7FqK
 LL09U2LyNWGGCMrrC7VNHwFGprImvKgu/nkbK0Swch/Krd3di7+AeKFpdYujsI7YiaVUIcBQcT
 x33rskGW7FUy4BSenjNAob06Fah2Rw7q36DceVDg+Nl6cSAO+B1oof8czZkbd2+kOpIx+9JWvr
 YZqyeO6C2fGzaYzqen7c4HXyEMnihMkVuqG/PQbwCRf/mdcnNDPNHvZMZY776NnyFv1uQnGg1x
 JIFyyOFcolGB3nkSz7c2Mf7RAcnZIwyJKUeRCE9v9LpnYJ7Q==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
thread runs only when it is supposed to"), the process which calls
set_disable_master_thread() hangs if the con.owner already exited,
because set_disable_master_thread() waits for cons_master_thread
accepting the status change and reflecting the current status to
master_thread_suspended. With this patch, set_disable_master_thread()
is aborted if the owner process no longer exists to avoid this
hang.

Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
Reported-by: Jay Libove Alzina <libove@felines.org>
Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Treat the absence of the master thread the same as suspension.
v3: Handle the crash of owner process.
v4: Put my concept together based on Johannes's.
v5: Abort waiting for master_thread when quering owner process fails.
    need_console_handler() simply returns need_console_handler.
    Rename master_thread_exited() to master_thread_unavailable().
    Set con.is_processed_input before asserting ENABLE_PROCESS_INPUT,
    and unset it after clearing ENABLE_PROCESS_INPUT.

 winsup/cygwin/fhandler/console.cc       | 57 +++++++++++++++++++++----
 winsup/cygwin/local_includes/fhandler.h |  3 +-
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 2d5382c0d..d72bb39e0 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
     }
   bool need_processed_input =
     con.master_thread_suspended || con.disable_master_thread
-    || con.need_win32_input_mode_fix;
+    || con.need_win32_input_mode_fix || master_thread_unavailable (unit);
   if (need_processed_input == con.is_processed_input)
     {
       ReleaseMutex (cons_mode_mutex);
@@ -915,8 +915,11 @@ fhandler_console::fix_input_mode_if_necessary ()
     flags |= ENABLE_PROCESSED_INPUT;
   else
     flags &= ~ENABLE_PROCESSED_INPUT;
-  con.is_processed_input = need_processed_input;
+  if (need_processed_input)
+    con.is_processed_input = true;
   SetConsoleMode (get_handle (), flags);
+  if (!need_processed_input)
+    con.is_processed_input = false;
   detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   ReleaseMutex (input_mutex);
@@ -931,6 +934,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 {
   const _minor_t unit = p->unit;
   DWORD oflags;
+  bool need_processed_input = false;
   WaitForSingleObject (p->input_mutex, mutex_timeout);
   acquire_attach_mutex (mutex_timeout);
   DWORD resume_pid = attach_console (con.owner);
@@ -945,10 +949,10 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       break;
     case tty::cygwin:
       flags |= ENABLE_WINDOW_INPUT;
-      con.is_processed_input =
+      need_processed_input =
 	con.master_thread_suspended || con.disable_master_thread
-	|| con.need_win32_input_mode_fix;
-      if (con.is_processed_input)
+	|| con.need_win32_input_mode_fix || master_thread_unavailable (unit);
+      if (need_processed_input)
 	flags |= ENABLE_PROCESSED_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
@@ -969,8 +973,11 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       break;
     }
   con.curr_input_mode = m;
+  if (flags & ENABLE_PROCESSED_INPUT)
+    con.is_processed_input = true;
   SetConsoleMode (p->input_handle, flags);
-  con.is_processed_input = (flags & ENABLE_PROCESSED_INPUT) != 0;
+  if (!(flags & ENABLE_PROCESSED_INPUT))
+    con.is_processed_input = false;
   if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
       && (flags & ENABLE_VIRTUAL_TERMINAL_INPUT)
       && con.cursor_key_app_mode)
@@ -5008,7 +5015,37 @@ fhandler_console::close_handle_set (handle_set_t *p)
 bool
 fhandler_console::need_console_handler ()
 {
-  return con.disable_master_thread || con.master_thread_suspended;
+  return con.is_processed_input;
+}
+
+bool
+fhandler_console::master_thread_unavailable (_minor_t unit)
+{
+  DWORD owner = con.owner;
+  if (owner == (DWORD) -1) /* About to exit, however still alive */
+    return false;
+  if (owner == 0)
+    return true;
+  bool exited = false;
+  DWORD error = ERROR_SUCCESS;
+  HANDLE process = OpenProcess (SYNCHRONIZE, FALSE, owner);
+  if (process)
+    {
+      DWORD res = WaitForSingleObject (process, 0);
+      if (res == WAIT_FAILED)
+	error = GetLastError ();
+      exited = (res == WAIT_OBJECT_0);
+      CloseHandle (process);
+    }
+  else
+    {
+      error = GetLastError ();
+      exited = (error == ERROR_INVALID_PARAMETER);
+    }
+  if (error && !exited)
+    system_printf ("Cannot query console owner %u, error %u", owner, error);
+
+  return (exited || error) && con.owner == owner;
 }
 
 void
@@ -5026,7 +5063,11 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
   con.disable_master_thread = x;
   cons->release_input_mutex ();
   while (con.master_thread_suspended != x)
-    Sleep (1);
+    { /* Wait for the responce from the cons_master_thread. */
+      if (master_thread_unavailable (unit))
+	return; /* Abort */
+      Sleep (1);
+    }
 }
 
 int
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index e00212f57..438b02bf0 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2160,7 +2160,7 @@ class dev_console
   int num_processed; /* Number of input events in the current input buffer
 			already processed by cons_master_thread(). */
   bool need_win32_input_mode_fix;
-  bool is_processed_input;
+  volatile bool is_processed_input;
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
@@ -2364,6 +2364,7 @@ private:
   static void cleanup_for_non_cygwin_app (handle_set_t *p);
   static void set_console_mode_to_native ();
   bool need_console_handler ();
+  static bool master_thread_unavailable (_minor_t unit);
   static void set_disable_master_thread (bool x, fhandler_console *cons = NULL);
   static DWORD attach_console (DWORD, bool *err = NULL);
   static void detach_console (DWORD, DWORD);
-- 
2.51.0

