Return-Path: <cygwin-patches-return-9832-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77074 invoked by alias); 12 Nov 2019 13:00:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76975 invoked by uid 89); 12 Nov 2019 13:00:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:Y, H*Ad:D*jp, UD:X, sbi
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 13:00:37 +0000
Received: from localhost.localdomain (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conuserg-06.nifty.com with ESMTP id xACD0O6L005023;	Tue, 12 Nov 2019 22:00:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com xACD0O6L005023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573563629;	bh=ulXfVSmQwFrWczVLAmkOOJWbJIh6rLIE1fuaRH0D33c=;	h=From:To:Cc:Subject:Date:From;	b=v5podWwRmu4F1lN4Y+gBy1LbUZwzPXSCPxNsY0aVUm1FLIM4dg2EacNjmPyH5AED4	 L0JdXRxZ1vYFaBydvBYcL801C+xJe8K/tRqOGJJU4905m04hNfSWPGBkSjSIhTM+FY	 HkLMTm3V1eUqKMZslmW/Jq3VdwMynAbalJ4QuBu18MdjLSgu3a/n26AzGSN68lOlzB	 DFW8ZECx6okDACE7CCBAWn678h75hiy6Ef3fupsPhTkzcbbSFOToiiILfEX5Yc4xyo	 C4IMmlyeK4Nz/BcU3GNYMf3qPBd2w0bsTWwuzryvXQgWKEJ9pLBOwsngV+w39Ingpi	 uSQ2k5KD7D9Pg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Use redraw screen instead of clear screen.
Date: Tue, 12 Nov 2019 13:00:00 -0000
Message-Id: <20191112130023.1730-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00103.txt.bz2

- Previously, pty cleared screen at startup for synchronization
  between the real screen and console screen buffer for pseudo
  console. With this patch, instead of clearing screen, the screen
  is redrawn when the first native program is executed after pty
  is created. In other words, synchronization is deferred until
  the native app is executed. Moreover, this realizes excluding
  $TERM dependent code.
---
 winsup/cygwin/fhandler_tty.cc | 30 ++++++++++++++++--------------
 winsup/cygwin/tty.cc          |  2 +-
 winsup/cygwin/tty.h           |  2 +-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c71603068..e02a8f43b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2669,7 +2669,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	  if (get_ttyp ()->num_pcon_attached_slaves == 0
 	      && !ALWAYS_USE_PCON)
 	    /* Assume this is the first process using this pty slave. */
-	    get_ttyp ()->need_clear_screen = true;
+	    get_ttyp ()->need_redraw_screen = true;
 
 	  get_ttyp ()->num_pcon_attached_slaves ++;
 	}
@@ -2700,6 +2700,21 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 		  kill (get_ttyp ()->pcon_pid, 0) != 0)
 		get_ttyp ()->pcon_pid = myself->pid;
 	      get_ttyp ()->switch_to_pcon_out = true;
+
+	      if (get_ttyp ()->need_redraw_screen)
+		{
+		  /* Forcibly redraw screen based on console screen buffer. */
+		  /* The following code triggers redrawing the screen. */
+		  CONSOLE_SCREEN_BUFFER_INFO sbi;
+		  GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
+		  SMALL_RECT rect = {0, 0,
+		    (SHORT) (sbi.dwSize.X -1), (SHORT) (sbi.dwSize.Y - 1)};
+		  COORD dest = {0, 0};
+		  CHAR_INFO fill = {' ', 0};
+		  ScrollConsoleScreenBuffer (get_output_handle (),
+					     &rect, NULL, dest, &fill);
+		  get_ttyp ()->need_redraw_screen = false;
+		}
 	    }
 	  init_console_handler (false);
 	}
@@ -2717,19 +2732,6 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
-
-  if (get_ttyp ()->need_clear_screen)
-    {
-      const char *term = getenv ("TERM");
-      if (term && strcmp (term, "dumb") && !strstr (term, "emacs"))
-	{
-	  /* FIXME: Clearing sequence may not be "^[[H^[[J"
-	     depending on the terminal type. */
-	  DWORD n;
-	  WriteFile (get_output_handle_cyg (), "\033[H\033[J", 6, &n, NULL);
-	}
-      get_ttyp ()->need_clear_screen = false;
-    }
 }
 
 void
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 460153cdb..9c66b89d8 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -244,7 +244,7 @@ tty::init ()
   pcon_pid = 0;
   num_pcon_attached_slaves = 0;
   term_code_page = 0;
-  need_clear_screen = false;
+  need_redraw_screen = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index 927d7afd9..a6732aecc 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -105,7 +105,7 @@ private:
   pid_t pcon_pid;
   int num_pcon_attached_slaves;
   UINT term_code_page;
-  bool need_clear_screen;
+  bool need_redraw_screen;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
