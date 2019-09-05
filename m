Return-Path: <cygwin-patches-return-9630-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80165 invoked by alias); 5 Sep 2019 00:25:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79776 invoked by uid 89); 5 Sep 2019 00:24:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: conuserg-06.nifty.com
Received: from conuserg-06.nifty.com (HELO conuserg-06.nifty.com) (210.131.2.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Sep 2019 00:24:55 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-06.nifty.com with ESMTP id x850OYlM003102;	Thu, 5 Sep 2019 09:24:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-06.nifty.com x850OYlM003102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567643087;	bh=Y+5uAVrUkYr0kKKFEaBGlysgu62coabxnbQ8BnK4p4k=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=sf0UvfsMo++lnb96CE3Ndx83SwgQg5pmhNuF/u13qwbHxj+VIhc4skUNLmyVQGn7l	 8Yc+U8+bb2vxfT82Zi5ZlQSDub28DBOaNOl1FxtfwzEhPR0M41tzhmocIUGgNIy4iF	 O6gSs3iF/xeTaw2+HN/leSkcU6/MM+IHtHd4OCHhL2irJs9Pcuast3rGd2rT0b53XP	 dMpgLwjvpJgOvt6y7DTmetYrna5RK4PGe2srIO/4A9p2rtQatL95q5zg73AmBXHPTl	 zMhuB+Dgj5vgD04K7iyhq9+RYI0prjuY11YlGjLFimFT0OKfDE1SJ6QnI3rEQsnpv5	 um2zPMdVS4o0Q==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 1/1] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Date: Thu, 05 Sep 2019 00:25:00 -0000
Message-Id: <20190905002426.362-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190905002426.362-1-takashi.yano@nifty.ne.jp>
References: <20190905002426.362-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00150.txt.bz2

- Pseudo console support introduced by commit
  169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
  some of emacs screens. These screens do not handle ANSI escape
  sequences. Therefore, clear screen is disabled on these screens.
---
 winsup/cygwin/fhandler_tty.cc | 19 ++++++++++++++-----
 winsup/cygwin/tty.cc          |  1 +
 winsup/cygwin/tty.h           |  1 +
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index fadff59a3..a6844832b 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -962,6 +962,19 @@ skip_console_setting:
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
@@ -2798,14 +2811,10 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
 	      /* Clear screen to synchronize pseudo console screen buffer
 		 with real terminal. This is necessary because pseudo
 		 console screen buffer is empty at start. */
-	      /* FIXME: Clearing sequence may not be "^[[H^[[J"
-		 depending on the terminal type. */
-	      DWORD n;
 	      if (get_ttyp ()->num_pcon_attached_slaves == 0
 		  && !ALWAYS_USE_PCON)
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
