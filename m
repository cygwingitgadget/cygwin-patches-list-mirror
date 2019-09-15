Return-Path: <cygwin-patches-return-9678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2024 invoked by alias); 15 Sep 2019 04:06:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1901 invoked by uid 89); 15 Sep 2019 04:06:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:jp, screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Sep 2019 04:06:16 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-01.nifty.com with ESMTP id x8F45sLt026084;	Sun, 15 Sep 2019 13:06:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com x8F45sLt026084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1568520368;	bh=x7yVx8GJmweXiMuxpS25oaBxVT1BJsTiNusZlTg13T0=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=SRMdHAaNerQonyRE3eED1ZcmsGSDWEqWUZRESdFNum+BR7MloK031uQbpSNFxdx5v	 AEGpWigmXpiVMNVESoOguehAjP/CMzW2NfcsOEy6dTFzd/W9zgP+66LXYLQj4KZUTz	 Fao9iQ2Wd62sJUbNN/XEyFBp5eOHPhvRkcOJO2LBfxUaC9XrDwCWWoTSzg3no0Rcdn	 l9Xj/YejIf6MUvSl/xKOPk3SFpg0+5GRdyKcToCteIvC0ZxIhnXbA4U5L9k8pAe/wp	 osa9hCCA16T6X+kIGUBKAKrnTlCpEbODn9C+jYoL9dPik8IdC3iKjPAKJc6Iv3Fa+r	 5kkM6dCLwOt4w==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/3] Cygwin: pty: Change the timing of clearing screen.
Date: Sun, 15 Sep 2019 04:06:00 -0000
Message-Id: <20190915040553.849-4-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
References: <20190915040553.849-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00198.txt.bz2

- The code which clears screen is moved from reset_switch_to_pcon()
  to fixup_after_exec() because it seems not too early even at this
  timing.
---
 winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 3bf8d0b75..5c27510be 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1041,19 +1041,6 @@ skip_console_setting:
 void
 fhandler_pty_slave::reset_switch_to_pcon (void)
 {
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
-
   if (isHybrid)
     this->set_switch_to_pcon (fd);
   if (get_ttyp ()->pcon_pid &&
@@ -2742,6 +2729,19 @@ fhandler_pty_slave::fixup_after_exec ()
 	}
     }
 
+  if (get_ttyp ()->need_clear_screen)
+    {
+      const char *term = getenv ("TERM");
+      if (term && strcmp (term, "dumb") && !strstr (term, "emacs"))
+	{
+	  /* FIXME: Clearing sequence may not be "^[[H^[[J"
+	     depending on the terminal type. */
+	  DWORD n;
+	  WriteFile (get_output_handle_cyg (), "\033[H\033[J", 6, &n, NULL);
+	}
+      get_ttyp ()->need_clear_screen = false;
+    }
+
   /* Set locale */
   setup_locale ();
 
-- 
2.21.0
