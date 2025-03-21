Return-Path: <SRS0=qcgm=WI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 3E68E3858D35
	for <cygwin-patches@cygwin.com>; Fri, 21 Mar 2025 04:58:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E68E3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E68E3858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742533136; cv=none;
	b=qCUr0P+JkpGb5hnU+2Ry3RpIDUUr1RaSnUieENkRIra7b+yODkOzt17jPSv4IIQgAAmWy33kNguqUmer46+lIwthzkfKd5e8eEvF9xjiqA4y/TzwCpywpdUsL4Z8Ap1ZLNVktlgv8Kzw0Fhtkv8ohvYOLTzxP3D/B9NgKmqLXT0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742533136; c=relaxed/simple;
	bh=TnSMP88g2LuuePGtTljnvsSK34X4oN7cZm/jpKpQyMM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TjS0wCMeNlDaPZjqal4upnmJnpaXbqaaZMrcooZbNVKCrmNhLSHkQRbl6ew6hYhaEtv4gXkTGR6LqqgRlnubrpBSji4nrqaKAzQax2y0Ri3UiTvMcbYWXqw1R81wxXWlfIB00Xs1BbA9VX9WmpQK9WIcKjPd/SJafKBsyxbbfxc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E68E3858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MYDNhN5Q
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250321045852402.VUXV.91923.localhost.localdomain@nifty.com>;
          Fri, 21 Mar 2025 13:58:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Eu,
	Pin,
	Tien,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: console: tty::restore really restores the previous mode
Date: Fri, 21 Mar 2025 13:58:23 +0900
Message-ID: <20250321045834.177-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1742533132;
 bh=UpBoJ0Ma3bMTfHb8BdTkzzqIbW/v2sncIfwDZ6Skz6M=;
 h=From:To:Cc:Subject:Date;
 b=MYDNhN5QXDN+A/n76ko/Vsr9ie5Z6tbBQIJeJVtwe+LT/AqisLMjJQW/Xdj6+65ZltKctUsQ
 y7ZWS7Gu6i+Ge7zcUb939DBt+K9kwR6gC802TzhLxb9NryAP02EnLJ1tpT+0cCFHh83pugBjZ1
 wrF9YCx8XTAW8ScdkdDtJPUlowtFW5lqm2BnKQhD328UpZh7Xovt9RYNCyTRyYiwzcAtaQyp4/
 urRkml7DOHTULBFgnvlv2/RAnnwcDuCyLbzEWsX80bY300XT2aO1HuZ8Yh9R5HjsRIZpUcaKyI
 W01dVpQNiBOeAOMCjiKakJZ6V8/as6EQWctr0Sp9b4r54FVw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, tty::restore sets the console mode to a predetermined
console mode that is widely common for many non-cygwin console apps.
So, if a non-cygwin app that is started from cygwin process changes
the console mode and executes cygwin sub-process, the console mode
is changed to the predetermined mode rather than being restored the
original mode that is set by the non-cygwin app.
With this patch, the console mode is stored when a cygwin process is
started from non-cygwin app, then tty::restore restores the previous
console mode that is used by the previous non-cygwin app when the
cygwin app exits.

Addresses: https://github.com/msys2/msys2-runtime/issues/268
Fixes: 3312f2d21f13 ("Cygwin: console: Redesign mode set strategy on close().")
Reported-by: Eu Pin Tien, Jeremy Drake <cygwin@jdrake.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc       | 49 ++++++++++++-------------
 winsup/cygwin/local_includes/fhandler.h |  4 +-
 winsup/cygwin/release/3.6.1             |  5 +++
 3 files changed, 32 insertions(+), 26 deletions(-)
 create mode 100644 winsup/cygwin/release/3.6.1

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index da335b3e3..f162698a8 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -804,6 +804,9 @@ fhandler_console::rabuflen ()
   return con_ra.rabuflen;
 }
 
+static DWORD prev_input_mode_backup;
+static DWORD prev_output_mode_backup;
+
 /* The function set_{in,out}put_mode() should be static so that they
    can be called even after the fhandler_console instance is deleted. */
 void
@@ -818,11 +821,11 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
   GetConsoleMode (p->input_handle, &oflags);
   DWORD flags = oflags
     & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE | ENABLE_QUICK_EDIT_MODE);
-  con.curr_input_mode = m;
   switch (m)
     {
     case tty::restore:
-      flags |= ENABLE_ECHO_INPUT | ENABLE_LINE_INPUT | ENABLE_PROCESSED_INPUT;
+      flags = con.prev_input_mode;
+      con.prev_input_mode = prev_input_mode_backup;
       break;
     case tty::cygwin:
       flags |= ENABLE_WINDOW_INPUT;
@@ -846,6 +849,12 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	flags |= ENABLE_PROCESSED_INPUT;
       break;
     }
+  if (con.curr_input_mode != tty::cygwin && m == tty::cygwin)
+    {
+      prev_input_mode_backup = con.prev_input_mode;
+      con.prev_input_mode = oflags;
+    }
+  con.curr_input_mode = m;
   SetConsoleMode (p->input_handle, flags);
   if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
       && (flags & ENABLE_VIRTUAL_TERMINAL_INPUT)
@@ -868,10 +877,11 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
   if (con.orig_virtual_terminal_processing_mode)
     flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   WaitForSingleObject (p->output_mutex, mutex_timeout);
-  con.curr_output_mode = m;
   switch (m)
     {
     case tty::restore:
+      flags = con.prev_output_mode;
+      con.prev_output_mode = prev_output_mode_backup;
       break;
     case tty::cygwin:
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
@@ -883,6 +893,12 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
 	flags |= DISABLE_NEWLINE_AUTO_RETURN;
       break;
     }
+  if (con.curr_output_mode != tty::cygwin && m == tty::cygwin)
+    {
+      prev_output_mode_backup = con.prev_output_mode;
+      GetConsoleMode (p->output_handle, &con.prev_output_mode);
+    }
+  con.curr_output_mode = m;
   acquire_attach_mutex (mutex_timeout);
   DWORD resume_pid = attach_console (con.owner);
   SetConsoleMode (p->output_handle, flags);
@@ -916,7 +932,7 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   /* Cleaning-up console mode for non-cygwin app. */
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
-  tty::cons_mode conmode = cons_mode_on_close (p);
+  tty::cons_mode conmode = cons_mode_on_close ();
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
   set_disable_master_thread (con.owner == GetCurrentProcessId ());
@@ -1978,9 +1994,8 @@ fhandler_console::close (int flag)
   if (shared_console_info[unit] && myself->ppid == 1
       && (dev_t) myself->ctty == get_device ())
     {
-      tty::cons_mode conmode = cons_mode_on_close (&handle_set);
-      set_output_mode (conmode, &get_ttyp ()->ti, &handle_set);
-      set_input_mode (conmode, &get_ttyp ()->ti, &handle_set);
+      set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+      set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
       set_disable_master_thread (true, this);
     }
 
@@ -4687,26 +4702,10 @@ fhandler_console::fstat (struct stat *st)
 }
 
 tty::cons_mode
-fhandler_console::cons_mode_on_close (handle_set_t *p)
+fhandler_console::cons_mode_on_close ()
 {
-  const _minor_t unit = p->unit;
-
   if (myself->ppid != 1) /* Execed from normal cygwin process. */
     return tty::cygwin;
 
-  if (!process_alive (con.owner)) /* The Master process already died. */
-    return tty::restore;
-  if (con.owner == GetCurrentProcessId ()) /* Master process */
-    return tty::restore;
-
-  PROCESS_BASIC_INFORMATION pbi;
-  NTSTATUS status =
-    NtQueryInformationProcess (GetCurrentProcess (), ProcessBasicInformation,
-			       &pbi, sizeof (pbi), NULL);
-  if (NT_SUCCESS (status)
-      && con.owner == (DWORD) pbi.InheritedFromUniqueProcessId)
-    /* The parent is the stub process. */
-    return tty::restore;
-
-  return tty::native; /* Otherwise */
+  return tty::restore; /* otherwise, restore */
 }
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index b00a1a195..8c71d8495 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2146,6 +2146,8 @@ class dev_console
   bool disable_master_thread;
   tty::cons_mode curr_input_mode;
   tty::cons_mode curr_output_mode;
+  DWORD prev_input_mode;
+  DWORD prev_output_mode;
   bool master_thread_suspended;
   int num_processed; /* Number of input events in the current input buffer
 			already processed by cons_master_thread(). */
@@ -2366,7 +2368,7 @@ private:
 
   void setup_pcon_hand_over ();
   static void pcon_hand_over_proc ();
-  static tty::cons_mode cons_mode_on_close (handle_set_t *);
+  static tty::cons_mode cons_mode_on_close ();
 
   friend tty_min * tty_list::get_cttyp ();
 };
diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
new file mode 100644
index 000000000..0b54b5fd3
--- /dev/null
+++ b/winsup/cygwin/release/3.6.1
@@ -0,0 +1,5 @@
+Fixes:
+------
+
+- Console mode is really restored to the previous mode.
+  Addresses: https://github.com/msys2/msys2-runtime/issues/268
-- 
2.45.1

