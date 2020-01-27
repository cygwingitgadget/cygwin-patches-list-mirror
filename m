Return-Path: <cygwin-patches-return-10007-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77818 invoked by alias); 27 Jan 2020 02:41:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77785 invoked by uid 89); 27 Jan 2020 02:41:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 02:41:34 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 00R2fGVC012408;	Mon, 27 Jan 2020 11:41:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 00R2fGVC012408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580092882;	bh=ryv8Kn3qmt7vtfAKb1KfyT1NyMklijSBfSs+2sLhQO8=;	h=From:To:Cc:Subject:Date:From;	b=bONPFwCYh1i6FdFPAg3MNfUDHO/mK5l2p+4Ox7MlkWzmBBUl+eVMj2ElcUbT3uZL1	 5hoAst+96WO94jj/mT6bR8jnUvP7MrHF+a78SDtXn0l/APCzVYLktOFqQ7ToEiSjJu	 Yg2mU6HoAfKA5EbUVPKFIBqq5vPcl5gAo5fmhjCNAt34WAM7ow6op3EiUI6ZG2SjKa	 7Kz+NC6eDyO6gKve62r5lOTwjK77Q6QdT/LmE1Ocn82jUHwgFoReNdMFSjLd90g7kJ	 leP37RoUbb/+JLPRAs4GOXMMsOe44PkRB9LFVdx9lA0451vHXR9SmgeU6ssNlynWNR	 Kbh7fxYLvxNwA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4] Cygwin: pty: Revise code waiting for forwarding again.
Date: Mon, 27 Jan 2020 02:41:00 -0000
Message-Id: <20200127024108.1648-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00113.txt

- After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
  cygwin programs which call both printf() and WriteConsole() are
  frequently distorted. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h      |  2 ++
 winsup/cygwin/fhandler_tty.cc | 46 ++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 14 deletions(-)

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
index 71a1f42ba..ea971e11f 100644
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
@@ -2680,6 +2680,34 @@ fhandler_pty_slave::set_freeconsole_on_close (bool val)
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
+  /* The transfer may be interruted once, so wait twice. */
+  /* First time */
+  ResetEvent (get_ttyp ()->fwd_done);
+  trigger_redraw_screen ();
+  cygwait (get_ttyp ()->fwd_done, INFINITE);
+  /* Second time */
+  ResetEvent (get_ttyp ()->fwd_done);
+  trigger_redraw_screen ();
+  cygwait (get_ttyp ()->fwd_done, INFINITE);
+}
+
 void
 fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
@@ -2727,7 +2755,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      DWORD mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
 	      SetConsoleMode (get_output_handle (), mode);
 	      if (!get_ttyp ()->switch_to_pcon_out)
-		cygwait (get_ttyp ()->fwd_done, INFINITE);
+		wait_pcon_fwd ();
 	      if (get_ttyp ()->pcon_pid == 0 ||
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
@@ -2735,16 +2763,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 
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
@@ -3016,7 +3035,6 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	  termios_printf ("ReadFile for forwarding failed, %E");
 	  break;
 	}
-      ResetEvent (get_ttyp ()->fwd_done);
       ssize_t wlen = rlen;
       char *ptr = outbuf;
       if (get_pseudo_console ())
-- 
2.21.0
