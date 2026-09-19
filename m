Return-Path: <SRS0=6u+c=HL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id E86954B9DB50
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 15:16:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E86954B9DB50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E86954B9DB50
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789831013; cv=none;
	b=uTgrGR2WKj7yOKxoEqt3AZ4yYEYb/tNyBaN0CaLWh62+PC25/28VTJ/On//D1Pj9stx/sZD182/BBGAvTUEzalFyHFPij/J1DkljmZ0LBQVJaI2WOcbQH88GhAGDkVwx+jPuvPbHTkdrj0IaKVDcRsP4rGInH/TZb/eN2J17r8w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789831013; c=relaxed/simple;
	bh=++uLj9KlN5mhK4iF3ivF70poKYXfBijVMr+Qeyy/uA4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IqM14QXrrQbaIGn+Hne+RtyEjdAXPHGasDHeSZPKa5OHuc71hNbtCsOhhvzs5YjzYsx4gdcoK2ZpHS4C32+VdsrroeNxaMA6TzgiQe3ksUdMbJxBGCGk4oR9kMzUbeDgZhadhYhXjZYfhsE9NvJrUBMnE4Kh3rXzpZ4nyCZ9v3A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OeIfcAEF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E86954B9DB50
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OeIfcAEF
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260919151649982.ZDFR.117312.HP-Z230@nifty.com>;
          Sun, 20 Sep 2026 00:16:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jay Libove Alzina <libove@felines.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4] Cygwin: console: Abort setting disable_master_thread when no con.owner
Date: Sun, 20 Sep 2026 00:16:32 +0900
Message-ID: <20260919151641.57452-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789831010;
 bh=uQ7lPWaLJuHsXKs7+ymMirdno/63lcN93Ontk1oR7M0=;
 h=From:To:Cc:Subject:Date;
 b=OeIfcAEFSscU/iMidk4A2RxMJwgTMGZTdI/YQDHVDOJCKmTsKdWkV+S6aSS2uSCiERAGNwaQ
 A82dB4eptQZ7+upFfF0b80M8Hivf89uoyULbud1bLg2az5/MUu+EZGw1unLOQeckv5Mt3olXVn
 qhy4sK9zeHlsCJDIBmEjLyk4AtGglyh02VO54v0Xi1pElu3z5lr9fXqK0HGTOIsMydGNUp9k+I
 8CicdtdiveXToU+yI90M9HODYgOHhr9gQ5kOjdDodS8KzwChDEmtvvXjO5rqg7pUQ4bR9eeZM+
 iPdyGWbEfiAq15hsL+CSXGObBj98Ct8DXHS/CAqgnTQv3B8g==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/console.cc       | 40 +++++++++++++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |  1 +
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 2d5382c0d..140837add 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -900,7 +900,7 @@ fhandler_console::fix_input_mode_if_necessary ()
     }
   bool need_processed_input =
     con.master_thread_suspended || con.disable_master_thread
-    || con.need_win32_input_mode_fix;
+    || con.need_win32_input_mode_fix || master_thread_exited (unit);
   if (need_processed_input == con.is_processed_input)
     {
       ReleaseMutex (cons_mode_mutex);
@@ -947,7 +947,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       flags |= ENABLE_WINDOW_INPUT;
       con.is_processed_input =
 	con.master_thread_suspended || con.disable_master_thread
-	|| con.need_win32_input_mode_fix;
+	|| con.need_win32_input_mode_fix || master_thread_exited (unit);
       if (con.is_processed_input)
 	flags |= ENABLE_PROCESSED_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
@@ -5011,6 +5011,36 @@ fhandler_console::need_console_handler ()
   return con.disable_master_thread || con.master_thread_suspended;
 }
 
+bool
+fhandler_console::master_thread_exited (_minor_t unit)
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
+      exited = (error = ERROR_INVALID_PARAMETER);
+    }
+  if (error && !exited)
+    system_printf ("Cannot query console owner %u, error %u", owner, error);
+
+  return exited;
+}
+
 void
 fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
 {
@@ -5026,7 +5056,11 @@ fhandler_console::set_disable_master_thread (bool x, fhandler_console *cons)
   con.disable_master_thread = x;
   cons->release_input_mutex ();
   while (con.master_thread_suspended != x)
-    Sleep (1);
+    { /* Wait for the responce from the cons_master_thread. */
+      if (master_thread_exited (unit))
+	return; /* Abort */
+      Sleep (1);
+    }
 }
 
 int
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index e00212f57..e05156737 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2364,6 +2364,7 @@ private:
   static void cleanup_for_non_cygwin_app (handle_set_t *p);
   static void set_console_mode_to_native ();
   bool need_console_handler ();
+  static bool master_thread_exited (_minor_t unit);
   static void set_disable_master_thread (bool x, fhandler_console *cons = NULL);
   static DWORD attach_console (DWORD, bool *err = NULL);
   static void detach_console (DWORD, DWORD);
-- 
2.51.0

