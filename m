Return-Path: <SRS0=YwmS=XX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.113])
	by sourceware.org (Postfix) with ESMTPS id 5E3123858C98
	for <cygwin-patches@cygwin.com>; Wed,  7 May 2025 07:31:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5E3123858C98
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5E3123858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.113
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746603096; cv=none;
	b=qeRxilwr3lwBmYetTRW/JJvw1xgRvCILnDCj8KF98ZqHnu3pfs810BVuhHsOjZftYm1/8QeXZFEYMNxFECt+KPHOi9qJxqrzbPlzW8z6+KtufEeVt8JLks85I3mWbu2ungCvh9DmzYE/98bmAfnRijjabofLGx3X1sajDSyu5o4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746603096; c=relaxed/simple;
	bh=Xp0W/1JYK712dT9DzA9DQluJ/xE2873wKhKDd4E3HAI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=LJDjXnwUSSecsnFZqsX1bZun5k9Kfyz7o/jkrb3f63FdCmo0yM/5kkLXp17jChhNJrW7+1q6jzH6unQXslZ7BVCGMXIbMv3hweBG1WJ3oj0HYAOjUclpecAAhC6FDYWTk2iENtX2/CC0FfH8SiJcxrECp/hse2NQX0ltGTmyi2w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5E3123858C98
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hWcjmw8V
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250507073131617.CEVV.48098.localhost.localdomain@nifty.com>;
          Wed, 7 May 2025 16:31:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Store console mode only when console is opened
Date: Wed,  7 May 2025 16:31:03 +0900
Message-ID: <20250507073114.12640-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746603091;
 bh=exDNXaOwYpsQ/HFCDB04A/4Th84axUkqVVNEvyqlqQ0=;
 h=From:To:Cc:Subject:Date;
 b=hWcjmw8ViM2K470ctAe5GUmZaRZDIP7TN5qr7/XKP8gEUN23OHnDbMA0uqsNyzurW8g+odWj
 JOdA80UjQeO+P8KCezLlNbkBoSyjacBbsmf5pRPMnSJ8vqa57qlKu06tNWSKFrobvaHVyeA/EN
 eW8jdfbkN/rIb81ObBh4xS/S517M/0wGWuCrr3fcTv0uTQu5BM/pZzR6G+7hZfZmZjE6cEvMcQ
 FYoCD9qGWOfPTXnkT6/962o3Xr/41ybJoEBdoxvTHwxObyvL3hpNHBO2KtmFvhpCDCpgQ905Sd
 WsNlm4ug7t8r4jDng4B+qr2LPPcRWKAb1gJGbBGGTz6ripdg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

... and restore it when app exits. The commit 0bfd91d57863 has a bug
that the console mode is stored into the shared memory when both:
  (1) cygwin process is started from non-cygwin process.
  (2) cygwin process started from non-cygwin process exits.
(1) is intended, but (2) is not. Due to (2), the stored console mode
is unexpectedly broken when the cygwin process exits. Then the mode
restored will be not as expected. This causes undesired console mode
in the use case that cygwin and non-cygwin apps are mixed.

With this patch, the console mode will stored only in the case (1).
This is done by putting the code, which stores the console mode, into
fhandler_console::open() rather than fhandler_console::set_input_mode()
and fhandler_console::set_output_mode().

Fixes: 0bfd91d57863 ("Cygwin: console: tty::restore really restores the previous mode")
Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 33 ++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 2e19e0dd7..16352d04d 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -771,6 +771,8 @@ fhandler_console::setup ()
       con.disable_master_thread = true;
       con.master_thread_suspended = false;
       con.num_processed = 0;
+      con.curr_input_mode = tty::restore;
+      con.curr_output_mode = tty::restore;
     }
 }
 
@@ -849,11 +851,6 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
 	flags |= ENABLE_PROCESSED_INPUT;
       break;
     }
-  if (con.curr_input_mode != tty::cygwin && m == tty::cygwin)
-    {
-      prev_input_mode_backup = con.prev_input_mode;
-      con.prev_input_mode = oflags;
-    }
   con.curr_input_mode = m;
   SetConsoleMode (p->input_handle, flags);
   if (!(oflags & ENABLE_VIRTUAL_TERMINAL_INPUT)
@@ -893,11 +890,6 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
 	flags |= DISABLE_NEWLINE_AUTO_RETURN;
       break;
     }
-  if (con.curr_output_mode != tty::cygwin && m == tty::cygwin)
-    {
-      prev_output_mode_backup = con.prev_output_mode;
-      GetConsoleMode (p->output_handle, &con.prev_output_mode);
-    }
   con.curr_output_mode = m;
   acquire_attach_mutex (mutex_timeout);
   DWORD resume_pid = attach_console (con.owner);
@@ -1845,6 +1837,12 @@ fhandler_console::open (int flags, mode_t)
   handle_set.output_handle = h;
   release_output_mutex ();
 
+  if (con.owner == GetCurrentProcessId ())
+    {
+      GetConsoleMode (get_handle (), &con.prev_input_mode);
+      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
+    }
+
   wpbuf.init ();
 
   handle_set.input_mutex = input_mutex;
@@ -1890,6 +1888,19 @@ fhandler_console::open (int flags, mode_t)
 	setenv ("TERM", "cygwin", 1);
     }
 
+  if (con.curr_input_mode != tty::cygwin)
+    {
+      prev_input_mode_backup = con.prev_input_mode;
+      GetConsoleMode (get_handle (), &con.prev_input_mode);
+      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+    }
+  if (con.curr_output_mode != tty::cygwin)
+    {
+      prev_output_mode_backup = con.prev_output_mode;
+      GetConsoleMode (get_output_handle (), &con.prev_output_mode);
+      set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
+    }
+
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
 
@@ -4738,7 +4749,7 @@ fhandler_console::cons_mode_on_close (handle_set_t *p)
   NTSTATUS status =
     NtQueryInformationProcess (GetCurrentProcess (), ProcessBasicInformation,
 			       &pbi, sizeof (pbi), NULL);
-  if (NT_SUCCESS (status)
+  if (NT_SUCCESS (status) && cygwin_pid (con.owner)
       && !process_alive ((DWORD) pbi.InheritedFromUniqueProcessId))
     /* Execed from normal cygwin process and the parent has been exited. */
     return tty::cygwin;
-- 
2.45.1

