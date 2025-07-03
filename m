Return-Path: <SRS0=8NMK=ZQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 103C6385782C
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 02:29:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 103C6385782C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 103C6385782C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751509766; cv=none;
	b=OSpGMchhgwvDxJwnpdiiQNDCAYboDR7Zt+knQGn9D8xy/HHaegSRd1AyVJKKRlM/b5rANrHiyS4Qkwj38z0i4hhNfVOLUALRKOgGnN3qvXr8uG2sJ5WEOPc7ZO95190TAboedpx6E8s87BGbqMLb0rFXgaFzcX8mB/R4Mw/zDAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751509766; c=relaxed/simple;
	bh=P8xVe8NKbJ3K4ecsD8oAcflmQkWRrt+7DVytb4zpQyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ZYWtc57aHDkPrerSwTqiXhDRuTn3KCbGq96l/Us27TuBum2qa/rpD7dZDjgeh+5JxRpqfsLVxfRarUszfLG27otOAg2cqoU6d33GnmQxHNriKVjjjjzA+e2iHRv9dfbqbh1559gqMLGBWiRLVmHO0pq0y0jc9s4AERAUWHIx62w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 103C6385782C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cfdeobmV
Received: from localhost.localdomain by mta-snd-w07.mail.nifty.com
          with ESMTP
          id <20250703022924172.PHYG.15876.localhost.localdomain@nifty.com>;
          Thu, 3 Jul 2025 11:29:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Set console mode only if std{in,out,err} is console
Date: Thu,  3 Jul 2025 11:28:57 +0900
Message-ID: <20250703022905.2658-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751509764;
 bh=RoxEZhSuneLL13DvnYKS1WjPBhw/72kGu7ayVyXPH+g=;
 h=From:To:Cc:Subject:Date;
 b=cfdeobmVCh2zH8/Gu7Vpp/MTAxsITLYxH32b6ZEuKHQiv5jsT2vtYFlAM/pcqiiDHFFnqhea
 t2F9Cv1WgvWb+nO02JSAcODgMki7RLw39AYF/CHFehd0RPJ52xthX2CT+B/fWgqVZ8JSTdUdmK
 rRBdXZsNjdI/C7ETW7zNJ2Ew4QaBB5tobuMq08k1JpSy0TA/JGnrpA4ARg+OtJwEuq4Hz1aBrO
 0Wfe0SH2ky5y6MUhiczVIob0NJgTOvnxL2k6XFDfPnhKA2OdR/OBd7q+EdISdyWHRZjPH1/VW/
 sk8ShKr433/6nqD8SKMy6FVgercjzGAUFwOiT8zqpTt3xGQA==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, when cygwin app is launched, the console input mode is
set to tty::cygwin, even if the stdin is not a console. However,
it is not necessary because the cygwin app does not use stdin.
This also applies to stdout and stderr.

With this patch, the console mode is set only when std{in,out,err}
is a console for the cygwin app for better coexistence with non-
cygwin apps.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dtable.cc           |  6 +-----
 winsup/cygwin/fhandler/console.cc | 36 ++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 7303f7eac..f1832a169 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -326,11 +326,7 @@ dtable::init_std_file_from_handle (int fd, HANDLE handle)
       if (CTTY_IS_VALID (myself->ctty))
 	dev.parse (myself->ctty);
       else
-	{
-	  dev.parse (FH_CONSOLE);
-	  CloseHandle (handle);
-	  handle = INVALID_HANDLE_VALUE;
-	}
+	dev.parse (FH_CONSOLE);
     }
   else if (GetCommState (handle, &dcb))
     /* FIXME: Not right - assumes ttyS0 */
diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index c572951b7..887e2ef72 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -927,8 +927,10 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode = cons_mode_on_close (p);
-  set_output_mode (conmode, ti, p);
-  set_input_mode (conmode, ti, p);
+  if (con.curr_output_mode != conmode)
+    set_output_mode (conmode, ti, p);
+  if (con.curr_input_mode != conmode)
+    set_input_mode (conmode, ti, p);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1889,13 +1891,24 @@ fhandler_console::open (int flags, mode_t)
 	setenv ("TERM", "cygwin", 1);
     }
 
-  if (con.curr_input_mode != tty::cygwin)
+  HANDLE h_in = GetStdHandle (STD_INPUT_HANDLE);
+  HANDLE h_out = GetStdHandle (STD_OUTPUT_HANDLE);
+  HANDLE h_err = GetStdHandle (STD_ERROR_HANDLE);
+
+  DWORD dummy;
+  bool in_is_console = GetConsoleMode (h_in, &dummy);
+  bool out_is_console =
+    GetConsoleMode (h_out, &dummy) || GetConsoleMode (h_err, &dummy);
+  if (in_is_console)
+    CloseHandle (h_in);
+
+  if (in_is_console && con.curr_input_mode != tty::cygwin)
     {
       prev_input_mode_backup = con.prev_input_mode;
       GetConsoleMode (get_handle (), &con.prev_input_mode);
       set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
-  if (con.curr_output_mode != tty::cygwin)
+  if (out_is_console && con.curr_output_mode != tty::cygwin)
     {
       prev_output_mode_backup = con.prev_output_mode;
       GetConsoleMode (get_output_handle (), &con.prev_output_mode);
@@ -2012,12 +2025,13 @@ fhandler_console::close (int flag)
 
   acquire_output_mutex (mutex_timeout);
 
-  if (shared_console_info[unit] && con.curr_input_mode != tty::restore
-      && (dev_t) myself->ctty == get_device ()
+  if (shared_console_info[unit] && (dev_t) myself->ctty == get_device ()
       && cons_mode_on_close (&handle_set) == tty::restore)
     {
-      set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
-      set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+      if (con.curr_output_mode != tty::restore)
+	set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
+      if (con.curr_input_mode != tty::restore)
+	set_input_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
       set_disable_master_thread (true, this);
     }
 
@@ -2246,8 +2260,10 @@ int
 fhandler_console::tcsetattr (int a, struct termios const *t)
 {
   get_ttyp ()->ti = *t;
-  set_input_mode (tty::cygwin, t, &handle_set);
-  set_output_mode (tty::cygwin, t, &handle_set);
+  if (con.curr_input_mode == tty::cygwin)
+    set_input_mode (tty::cygwin, t, &handle_set);
+  if (con.curr_output_mode == tty::cygwin)
+    set_output_mode (tty::cygwin, t, &handle_set);
   return 0;
 }
 
-- 
2.45.1

