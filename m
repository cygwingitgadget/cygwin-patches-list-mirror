Return-Path: <SRS0=8NMK=ZQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w05.mail.nifty.com (mta-sp-w05.mail.nifty.com [106.153.228.37])
	by sourceware.org (Postfix) with ESMTPS id 399D6385695B
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 02:02:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 399D6385695B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 399D6385695B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751508134; cv=none;
	b=k3vLQIaoQDbxlb+7lXmXUt9yKmMmG8mFSicipNu2z23A3dt9dpE8cuGQQLUTOs6xrme7DuhKiylIZLC/nPhZefL5JDsUMYoRH9dwu8+i5hOwMcCHtcVpH8xgoW9djuBOTQKEPyny/HGyAfzTHjdex2wL5rQdEuNXFYj+to+6RMo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751508134; c=relaxed/simple;
	bh=7Rm+LXjFa1zPPKEtTrpzzL0cz8Wc65ZRmzWblgFd8XQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=KU7k1YU0w+DRQuelrHE+mbkpVPYK4nuOEQ9zF5p3ab3Q6hzzVzjpHlOP8hWHn2+vN8SB517DXM0T9e2RguO+IoZLwnPK0sFwo6W8l2vVe60iVPQnytsHNtmP1xuxbveTRmwPZ4mi+UdOur0aGQ9gQ19aBRxBjPtc0IuOuEFIs4g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 399D6385695B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PZD3EXWh
Received: from mta-snd-w05.mail.nifty.com by mta-sp-w05.mail.nifty.com
          with ESMTP
          id <20250703020211077.HEEJ.3803.mta-snd-w05.mail.nifty.com@nifty.com>;
          Thu, 3 Jul 2025 11:02:11 +0900
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250703020211005.HRCO.127398.localhost.localdomain@nifty.com>;
          Thu, 3 Jul 2025 11:02:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Call set_input_mode() after changing disable_master_thread
Date: Thu,  3 Jul 2025 11:01:44 +0900
Message-ID: <20250703020153.2068-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751508131;
 bh=q7Y4RBMxREt89ecblSdV/UirHORpQynrVsC66hxIMRc=;
 h=From:To:Cc:Subject:Date;
 b=PZD3EXWhbn6LQlbiEJYeHlXHY2/QfE2di0TDbUWzyDRCfh1w1o+1drFrQ/jS22Ic3L/2mbc7
 F9n/ScrEuNX1IeA3FWlW/PQzpbNdb2mLJTvRNB+C477r8OuhFCr4LlQuQ+Pf+Ue1kKQrcOXDo4
 aqsayRWUbYRjKrHPien/mnBL5YskrzYGSJO1+hOyIJS172NQxhJQYQuCQ7LCXkItIutOhSqTHL
 YGowffvycgGUfFB7BZA0RAklDPYguQCfFa2+KgYErC/WCk4u6YX7kdIozUd9Eadx11W9BfxMh5
 QC4xqee1PEN+yr5VA38IKxiX/lWJLxVtIOyeruUGIYB5Qw/w==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

With the commit 476135a24506, set_input_mode() reffers to the flag
disable_master_thread in tty::cygwin mode. So it is necessary to call
set_input_mode() after changing disable_master_thread flag. However,
the commit 476135a24506 was missing that.

With this patch, set_input_mode() is called after changing the flag
disable_master_thread, if the console input mode is tty::cygwin.

Fixes: 476135a24506 ("Cygwin: console: Set ENABLE_PROCESSED_INPUT when disable_master_thread");
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 1ae4c639a..c572951b7 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -923,12 +923,12 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   termios *ti = shared_console_info[unit] ?
     &(shared_console_info[unit]->tty_min_state.ti) : &dummy;
   /* Cleaning-up console mode for non-cygwin app. */
+  set_disable_master_thread (con.owner == GetCurrentProcessId ());
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode = cons_mode_on_close (p);
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
-  set_disable_master_thread (con.owner == GetCurrentProcessId ());
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1121,8 +1121,8 @@ fhandler_console::bg_check (int sig, bool dontsignal)
      in the same process group. */
   if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
-      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
       set_disable_master_thread (false, this);
+      set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
     }
   if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
@@ -1996,8 +1996,8 @@ fhandler_console::post_open_setup (int fd)
   /* Setting-up console mode for cygwin app started from non-cygwin app. */
   if (fd == 0)
     {
-      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
       set_disable_master_thread (false, this);
+      set_input_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
     }
   else if (fd == 1 || fd == 2)
     set_output_mode (tty::cygwin, &get_ttyp ()->ti, &handle_set);
@@ -3013,7 +3013,12 @@ fhandler_console::char_command (char c)
 		  if (con.args[i] == 1) /* DECCKM */
 		    con.cursor_key_app_mode = (c == 'h');
 		  if (con.args[i] == 9001) /* win32-input-mode (https://github.com/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard%20handling%20in%20Conpty.md) */
-		    set_disable_master_thread (c == 'h', this);
+		    {
+		      set_disable_master_thread (c == 'h', this);
+		      if (con.curr_input_mode == tty::cygwin)
+			set_input_mode (tty::cygwin,
+					&tc ()->ti, get_handle_set ());
+		    }
 		}
 	      /* Call fix_tab_position() if screen has been alternated. */
 	      if (need_fix_tab_position)
-- 
2.45.1

