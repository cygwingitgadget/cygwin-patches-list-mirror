Return-Path: <cygwin-patches-return-9603-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 88365 invoked by alias); 4 Sep 2019 01:46:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 88352 invoked by uid 89); 4 Sep 2019 01:46:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 01:46:55 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x841kPmZ024773;	Wed, 4 Sep 2019 10:46:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x841kPmZ024773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567561599;	bh=HN/lBCrMxRVIZvFgeOcJCk9qdKd21IDM/ZyNhUorLrw=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=0LUDugE1NfCe6aA9kwS5AH3kvAa2hbQPXRvyQ9TkCMLzsnBN3/XaNn7im2YCVncvx	 qF7dXiUz5XZlcuwxWTlkVx8Y0RWMjn3bTDw8vGuXSM/IeMo9DO414p58piXINCoNJL	 qqwPDgZrFWSawVpG1+oEKjI7lbogIwtL43MN1i9jobaVl8fOdKclunwXo6dfcLEfiT	 QXY8DTlUEvdpOvhzRNHPD26yGIyKa6ubxJ48CdKn+mtkTPStW4FdMqFFHh7apSnrEZ	 oZDbV2EpvEViuIrneIL0eVk+8n0FFUppQBmW7T/B0OLfAczftRcDdQ94yUeVIJPNpZ	 6zDrEPRWm9bHQ==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Date: Wed, 04 Sep 2019 01:46:00 -0000
Message-Id: <20190904014618.1372-3-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00123.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
  some of emacs screens. These screens do not handle ANSI escape
  sequences. Therefore, clear screen is disabled on these screens.
---
 winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++++++++-------
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 283558985..a74c3eecf 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -972,6 +972,19 @@ skip_console_setting:
 void
 fhandler_pty_slave::reset_switch_to_pcon (void)
 {
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
   if (ALWAYS_USE_PCON)
     return;
   if (isHybrid)
@@ -2808,14 +2821,13 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 	      /* Clear screen to synchronize pseudo console screen buffer
 		 with real terminal. This is necessary because pseudo
 		 console screen buffer is empty at start. */
-	      /* FIXME: Clearing sequence may not be "^[[H^[[J"
-		 depending on the terminal type. */
-	      DWORD n;
-	      if (get_ttyp ()->num_pcon_attached_slaves == 0
-		  && !ALWAYS_USE_PCON)
+	      const char *term = getenv ("TERM");
+	      if (get_ttyp ()->num_pcon_attached_slaves == 0 &&
+		  term && strcmp (term, "dumb") &&
+		  term && !strstr (term, "emacs") &&
+		  !ALWAYS_USE_PCON)
 		/* Assume this is the first process using this pty slave. */
-		WriteFile (get_output_handle_cyg (),
-			   "\033[H\033[J", 6, &n, NULL);
+		get_ttyp ()->need_clear_screen = true;
 
 	      get_ttyp ()->num_pcon_attached_slaves ++;
 	    }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 9244267c0..c94aee3ba 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -243,6 +243,7 @@ tty::init ()
   pcon_pid = 0;
   num_pcon_attached_slaves = 0;
   TermCodePage = 20127; /* ASCII */
+  need_clear_screen = false;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index d59b2027d..c2b0490d0 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -104,6 +104,7 @@ private:
   pid_t pcon_pid;
   int num_pcon_attached_slaves;
   UINT TermCodePage;
+  bool need_clear_screen;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.21.0
