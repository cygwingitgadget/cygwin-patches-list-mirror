Return-Path: <cygwin-patches-return-10005-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 110500 invoked by alias); 26 Jan 2020 13:34:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 110488 invoked by uid 89); 26 Jan 2020 13:34:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-05.nifty.com
Received: from conuserg-05.nifty.com (HELO conuserg-05.nifty.com) (210.131.2.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 26 Jan 2020 13:34:23 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-05.nifty.com with ESMTP id 00QDXvhx013428;	Sun, 26 Jan 2020 22:34:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-05.nifty.com 00QDXvhx013428
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580045641;	bh=Hj+banIjlEDl2/zi/aoYUTn/6gAzNPYPBojPZh9AlMA=;	h=From:To:Cc:Subject:Date:From;	b=zpUi/ykXuXtJrz7Z1cn5Kl4ImCepU2W7kzjPn/2ezyf+5f7rFPJlXvhAaLY9f9xUy	 c/leEIp/V0kOSGxxSAbNB6VHD2eNqpj0EsWGVXz0orIt8xJpPiBJANHGB+PEZx8Ujn	 Dndar8gOC6TPPJ68n/47dAZFXz39YgZFzLFMQJWyT68GE7pC4ayodT7T/xurYAAaf9	 8wU9sOsg2f/YrwMBW5FSFQXRpiT3MUIx4/4sGBnXpyULvo62gDFxGsXPbLArt+DfXf	 lj6/SSlFIHbv2HF41eSclVR08pm7Rg3Bshd7WX6AFt8QaCjpMusl0BSo6XfOPIanDg	 WrS5DEKim1i9A==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3] Cygwin: pty: Revise code waiting for forwarding again.
Date: Sun, 26 Jan 2020 13:34:00 -0000
Message-Id: <20200126133355.1110-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00111.txt

- After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
  cygwin programs which call both printf() and WriteConsole() are
  frequently distorted. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h      |  2 ++
 winsup/cygwin/fhandler_tty.cc | 40 +++++++++++++++++++++++------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 35190c0fe..2c18b215a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2209,6 +2209,8 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   void setup_locale (void);
   void set_freeconsole_on_close (bool val);
+  void trigger_redraw_screen (void);
+  void wait_pcon_fwd (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 71a1f42ba..744292819 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1109,7 +1109,7 @@ skip_console_setting:
     }
   else if ((fd == 1 || fd == 2) && !get_ttyp ()->switch_to_pcon_out)
     {
-      cygwait (get_ttyp ()->fwd_done, INFINITE);
+      wait_pcon_fwd ();
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
 	get_ttyp ()->pcon_pid = myself->pid;
@@ -1152,7 +1152,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     }
   if (get_ttyp ()->switch_to_pcon_out)
     /* Wait for pty_master_fwd_thread() */
-    cygwait (get_ttyp ()->fwd_done, INFINITE);
+    wait_pcon_fwd ();
   get_ttyp ()->pcon_pid = 0;
   get_ttyp ()->switch_to_pcon_in = false;
   get_ttyp ()->switch_to_pcon_out = false;
@@ -2680,6 +2680,28 @@ fhandler_pty_slave::set_freeconsole_on_close (bool val)
   freeconsole_on_close = val;
 }
 
+void
+fhandler_pty_slave::trigger_redraw_screen (void)
+{
+  /* Forcibly redraw screen based on console screen buffer. */
+  /* The following code triggers redrawing the screen. */
+  CONSOLE_SCREEN_BUFFER_INFO sbi;
+  GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
+  SMALL_RECT rect = {0, 0,
+    (SHORT) (sbi.dwSize.X -1), (SHORT) (sbi.dwSize.Y - 1)};
+  COORD dest = {0, 0};
+  CHAR_INFO fill = {' ', 0};
+  ScrollConsoleScreenBuffer (get_output_handle (), &rect, NULL, dest, &fill);
+}
+
+void
+fhandler_pty_slave::wait_pcon_fwd (void)
+{
+  ResetEvent (get_ttyp ()->fwd_done);
+  trigger_redraw_screen ();
+  cygwait (get_ttyp ()->fwd_done, INFINITE);
+}
+
 void
 fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
@@ -2727,7 +2749,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		cygwait (get_ttyp ()->fwd_done, INFINITE);
+		wait_pcon_fwd ();
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
@@ -2735,16 +2757,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 
 	      if (get_ttyp ()->need_redraw_screen)
 		{
-		  /* Forcibly redraw screen based on console screen buffer. */
-		  /* The following code triggers redrawing the screen. */
-		  CONSOLE_SCREEN_BUFFER_INFO sbi;
-		  GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
-		  SMALL_RECT rect = {0, 0,
-		    (SHORT) (sbi.dwSize.X -1), (SHORT) (sbi.dwSize.Y - 1)};
-		  COORD dest = {0, 0};
-		  CHAR_INFO fill = {' ', 0};
-		  ScrollConsoleScreenBuffer (get_output_handle (),
-					     &rect, NULL, dest, &fill);
+		  trigger_redraw_screen ();
 		  get_ttyp ()->need_redraw_screen = false;
 		}
 	    }
@@ -3016,7 +3029,6 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
-      ResetEvent (get_ttyp ()->fwd_done);
       ssize_t wlen = rlen;
       char *ptr = outbuf;
       if (get_pseudo_console ())
-- 
2.21.0
