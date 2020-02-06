Return-Path: <cygwin-patches-return-10042-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109581 invoked by alias); 6 Feb 2020 10:49:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109562 invoked by uid 89); 6 Feb 2020 10:49:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 06 Feb 2020 10:48:42 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-03.nifty.com with ESMTP id 016AmHaV030535;	Thu, 6 Feb 2020 19:48:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com 016AmHaV030535
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1580986102;	bh=k6oSG/2tJGIFbCERpBcecgL8r7crNSi44HloOrLKg5o=;	h=From:To:Cc:Subject:Date:From;	b=BJUP70VAwlN2TK+YOTiyNhwD9I7+aBadjbSIX+2pN60bAj76Ia6YdAxfwrtjWAzUR	 BKZUiSS4WanD7XehGAjrcBzfCtI6E+OVDdlkwVVN53ZzCaEfKfh2Aq8IxStkd0tKgs	 VN98MrD53+TNmuSvlgCsilrFOxp6yItBGWdtCi5GOVSx1bynTad79yDdybwuPtrr1Z	 HHUC5EzsgVXRi22B5DF4ns6mgXUJgngLQktw5H3pwT+OxI4GZv3x0eR/+13GxUpBN/	 J0iUvPaQYiMC+HWxexF/3R5Lq6hnrD+M7YoKtlK3LZv7vXKihLfcJyuVk79lQez9i0	 kGFOJOZx8WTzw==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Use pinfo() rather than kill() with signal 0.
Date: Thu, 06 Feb 2020 10:49:00 -0000
Message-Id: <20200206104817.1116-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00148.txt

- PTY code has a problem that tcsh is terminated if the following
  command is executed.
    true; chcp &
  This seems to be caused by invalid pointer access which occurs
  when the process exits during the kill() code is execuetd. This
  patch avoids the issue by not using kill().
---
 winsup/cygwin/fhandler.h      |  2 +-
 winsup/cygwin/fhandler_tty.cc | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 9270c837c..82527eca3 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2211,7 +2211,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   {
     if (!mask && get_ttyp ()->pcon_pid &&
 	get_ttyp ()->pcon_pid != myself->pid &&
-	kill (get_ttyp ()->pcon_pid, 0) == 0)
+	!!pinfo (get_ttyp ()->pcon_pid))
       return;
     get_ttyp ()->mask_switch_to_pcon_in = mask;
   }
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 1dd57b369..181bed5a9 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1103,7 +1103,7 @@ fhandler_pty_slave::set_switch_to_pcon (int fd_set)
 skip_console_setting:
       restore_reattach_pcon ();
       if (get_ttyp ()->pcon_pid == 0 ||
-	  kill (get_ttyp ()->pcon_pid, 0) != 0)
+	  !pinfo (get_ttyp ()->pcon_pid))
 	get_ttyp ()->pcon_pid = myself->pid;
       get_ttyp ()->switch_to_pcon_in = true;
     }
@@ -1111,7 +1111,7 @@ skip_console_setting:
     {
       wait_pcon_fwd ();
       if (get_ttyp ()->pcon_pid == 0 ||
-	  kill (get_ttyp ()->pcon_pid, 0) != 0)
+	  !pinfo (get_ttyp ()->pcon_pid))
 	get_ttyp ()->pcon_pid = myself->pid;
       get_ttyp ()->switch_to_pcon_out = true;
     }
@@ -1124,7 +1124,7 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     this->set_switch_to_pcon (fd);
   if (get_ttyp ()->pcon_pid &&
       get_ttyp ()->pcon_pid != myself->pid &&
-      kill (get_ttyp ()->pcon_pid, 0) == 0)
+      !!pinfo (get_ttyp ()->pcon_pid))
     /* There is a process which is grabbing pseudo console. */
     return;
   if (isHybrid)
@@ -2728,7 +2728,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 		ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
 	      SetConsoleMode (get_handle (), mode);
 	      if (get_ttyp ()->pcon_pid == 0 ||
-		  kill (get_ttyp ()->pcon_pid, 0) != 0)
+		  !pinfo (get_ttyp ()->pcon_pid))
 		get_ttyp ()->pcon_pid = myself->pid;
 	      get_ttyp ()->switch_to_pcon_in = true;
 	    }
@@ -2739,7 +2739,7 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe, int fd_set)
 	      if (!get_ttyp ()->switch_to_pcon_out)
 		wait_pcon_fwd ();
 	      if (get_ttyp ()->pcon_pid == 0 ||
-		  kill (get_ttyp ()->pcon_pid, 0) != 0)
+		  !pinfo (get_ttyp ()->pcon_pid))
 		get_ttyp ()->pcon_pid = myself->pid;
 	      get_ttyp ()->switch_to_pcon_out = true;
 
-- 
2.21.0
