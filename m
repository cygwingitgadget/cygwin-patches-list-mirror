Return-Path: <cygwin-patches-return-10049-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98488 invoked by alias); 9 Feb 2020 14:46:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98341 invoked by uid 89); 9 Feb 2020 14:46:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=rect, Nothing, H*Ad:D*jp, UD:Y
X-HELO: conuserg-04.nifty.com
Received: from conuserg-04.nifty.com (HELO conuserg-04.nifty.com) (210.131.2.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 09 Feb 2020 14:46:28 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-04.nifty.com with ESMTP id 019Ek4RZ005877;	Sun, 9 Feb 2020 23:46:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-04.nifty.com 019Ek4RZ005877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581259573;	bh=5HXgQWKyr8IR4atzzetxgb+lt9x7tqO0rcolX6lUzNw=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=MCdAbbrHknHCmwHmTO1NUYLZ+DPRJLdqas4r1FmTdNUY/iYvsOYRNi+mNRWAyyzgW	 YJBrYXN3CSVk2tq/3/FC9Jwo3jnZ1Oh5fUsPrtQ7f7ymPIiXxQbP73lgHWCgmBFyw1	 0oDmNAlvEH369NkUbxegoEXBW//r3WdNpdU3YfiwZy+hJgy4++BRB6oFL3HVDhBHIy	 sPvbPEQjOFbkIcYtHURz76CNaYtYm8TyXxa25k9UF3PzoXo6KMyhOwcxhKuIcSl6co	 +N3mNDHbaNACCaEo5SAPy8/V0V1YLy9ZVsMFcyOcW1NiJ1Sj9uVOooZSDJAWGQIhH7	 2smz2o/mrsi9g==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/4] Cygwin: pty: Avoid screen distortion on slave read.
Date: Sun, 09 Feb 2020 14:46:00 -0000
Message-Id: <20200209144603.389-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
References: <20200209144603.389-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00155.txt

- Echo back print is distorted when the cygwin program which calls
  Win32 console API directly calls slave read(). This patch fixes
  the issue.
---
 winsup/cygwin/fhandler.h      |  3 ++-
 winsup/cygwin/fhandler_tty.cc | 51 ++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 53b6c2c45..a22f3a136 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2206,7 +2206,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   void set_switch_to_pcon (int fd);
   void reset_switch_to_pcon (void);
-  void push_to_pcon_screenbuffer (const char *ptr, size_t len);
+  void push_to_pcon_screenbuffer (const char *ptr, size_t len, bool is_echo);
   void mask_switch_to_pcon_in (bool mask);
   void fixup_after_attach (bool native_maybe, int fd);
   bool is_line_input (void)
@@ -2215,6 +2215,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   }
   void setup_locale (void);
   void set_freeconsole_on_close (bool val);
+  void trigger_redraw_screen (void);
   void wait_pcon_fwd (void);
 };
 
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a92bcfc40..f88382752 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -80,7 +80,13 @@ set_switch_to_pcon (void)
 	fhandler_base *fh = cfd;
 	fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
 	if (ptys->get_pseudo_console ())
-	  ptys->set_switch_to_pcon (fd);
+	  {
+	    ptys->set_switch_to_pcon (fd);
+	    ptys->trigger_redraw_screen ();
+	    DWORD mode =
+	      ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+	    SetConsoleMode (ptys->get_handle (), mode);
+	  }
       }
 }
 
@@ -1097,9 +1103,6 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
 	if (!try_reattach_pcon ())
 	  goto skip_console_setting;
       FlushConsoleInputBuffer (get_handle ());
-      DWORD mode;
-      mode = ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
-      SetConsoleMode (get_handle (), mode);
 skip_console_setting:
       restore_reattach_pcon ();
       if (get_ttyp ()->pcon_pid == 0 ||
@@ -1160,7 +1163,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
 }
 
 void
-fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
+fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len,
+					       bool is_echo)
 {
   bool attached =
     !!fhandler_console::get_console_process_id (get_helper_process_id (), true);
@@ -1231,7 +1235,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
     }
   if (!nlen) /* Nothing to be synchronized */
     goto cleanup;
-  if (get_ttyp ()->switch_to_pcon_out)
+  if (get_ttyp ()->switch_to_pcon_out && !is_echo)
     goto cleanup;
   /* Remove ESC sequence which returns results to console
      input buffer. Without this, cursor position report
@@ -1388,7 +1392,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   if (get_pseudo_console ())
     {
       acquire_output_mutex (INFINITE);
-      push_to_pcon_screenbuffer ((char *)ptr, len);
+      push_to_pcon_screenbuffer ((char *)ptr, len, false);
       release_output_mutex ();
     }
 
@@ -1716,7 +1720,9 @@ out:
   if (get_pseudo_console () && ptr0 && (get_ttyp ()->ti.c_lflag & ECHO))
     {
       acquire_output_mutex (INFINITE);
-      push_to_pcon_screenbuffer (ptr0, len);
+      push_to_pcon_screenbuffer (ptr0, len, true);
+      if (get_ttyp ()->switch_to_pcon_out)
+	trigger_redraw_screen ();
       release_output_mutex ();
     }
   mask_switch_to_pcon_in (false);
@@ -2700,6 +2706,21 @@ fhandler_pty_slave::wait_pcon_fwd (void)
   cygwait (get_ttyp ()->fwd_done, INFINITE);
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
+  get_ttyp ()->need_redraw_screen = false;
+}
+
 void
 fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 {
@@ -2754,19 +2775,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      get_ttyp ()->switch_to_pcon_out = true;
 
 	      if (get_ttyp ()->need_redraw_screen)
-		{
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
-		  get_ttyp ()->need_redraw_screen = false;
-		}
+		trigger_redraw_screen ();
 	    }
 	  init_console_handler (false);
 	}
-- 
2.21.0
