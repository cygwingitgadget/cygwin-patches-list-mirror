Return-Path: <cygwin-patches-return-9758-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78994 invoked by alias); 16 Oct 2019 12:34:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78985 invoked by uid 89); 16 Oct 2019 12:34:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=emacs, screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Oct 2019 12:34:46 +0000
Received: from localhost.localdomain (ntsitm283243.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.151.243]) (authenticated)	by conuserg-02.nifty.com with ESMTP id x9GCYLi2017325;	Wed, 16 Oct 2019 21:34:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com x9GCYLi2017325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571229275;	bh=q3ypogmP/lNFhzWKaqodY1MD3zLyEFYO/Q5J37/0CGE=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=gIxs7daHd7BonRkFc/ZcYjvJYg756JJ0i90IjEk6fZBgR64Ihp4HbH8P5Wam/djS6	 zF8NVEkgtJwQSCXqtj8ugFsRM7uH8Mdhp2WwLuMEK96Kvcbs4s6bNhIgNWeDZNdctM	 /WKm003U8pMRV6K5+I1cgSORSN9PEPio8LjsbVtOmxlNXY9EwLUPajHJjTdhKnkgeZ	 Zcc2hMCOURFXW/PwQBTIVqYB0r+ExHLBtMwI05BKemGKrXaaT1tjRgygstvW+bKt1Y	 O9mPUwHqMcm/ZxgiSoDsgRvaDJ9vRBqryO2EuAay2x25+97r1qWdNcPbq8AGXNVppB	 gbfpdblMlhxpA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Change the timing of clear screen.
Date: Wed, 16 Oct 2019 12:34:00 -0000
Message-Id: <20191016123409.457-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20191016123409.457-1-takashi.yano@nifty.ne.jp>
References: <20191016123409.457-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00029.txt.bz2

---
 winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1095c82eb..baf3c9794 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2714,6 +2714,19 @@ fhandler_pty_slave::fixup_after_fork (HANDLE parent)
   // fork_fixup (parent, inuse, "inuse");
   // fhandler_pty_common::fixup_after_fork (parent);
   report_tty_counts (this, "inherited", "");
+
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
 }
 
 void
@@ -2757,19 +2770,6 @@ fhandler_pty_slave::fixup_after_exec ()
 	}
     }
 
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
   /* Set locale */
   setup_locale ();
 
-- 
2.21.0
