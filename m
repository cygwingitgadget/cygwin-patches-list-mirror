Return-Path: <SRS0=i6B1=P6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id C4BB83858420
	for <cygwin-patches@cygwin.com>; Sat, 31 Aug 2024 09:53:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C4BB83858420
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C4BB83858420
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725098035; cv=none;
	b=Rk1LzYyxsv0TnLK0P6BZ2cGarOoL1HjIasuCZXLWSU/MhARgpyXArPcP7wI7vABSlX8uXhOvWBv7H2xSpYa18Qp0XgpnLnJ5oMtdwzAGrk0oi8op13RrTNwZATMM1QdXJhkjWwXlTBnqEuE14BP8TNiUbDMSV3MX22f0Jt3mZx0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725098035; c=relaxed/simple;
	bh=fdwX+Wa8SFR2HAXI7GkzNOLslk8TDQNqwF1UoJV80fY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rjiOa0HwxWNsAFRJxK624Gi2nF06tx7W/z9zIIyVvOm28DpW7xl7uJ/hF52M8W8n7pUTudp94rRi3CL8Oz5R+ywK9kPWL0uJ1PDXvXxPV2R5AdcAnMgSRwYEOPwm4MmUBMmJYLfnw0lRlURCgWsQTMcgcfY5CZygf58A9wiCsnM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20240831095349770.QMXG.116458.localhost.localdomain@nifty.com>;
          Sat, 31 Aug 2024 18:53:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Adamyg Mob <adamyg.mob@gmail.com>
Subject: [PATCH] Cygwin: console: Disable cons_master_thread in win32-input-mode
Date: Sat, 31 Aug 2024 18:53:01 +0900
Message-ID: <20240831095334.1819-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725098029;
 bh=R4gDp+koCo9PNmzY/ap7qokvX+t9tsZA4j97DP4s01o=;
 h=From:To:Cc:Subject:Date;
 b=iHsw+g56uLnMb85/rZFyGY7CniTM3XP29GN5L6pTtJkkbEU9jpV4y+tD/q7pRzdjO7spz1TW
 1VJ9m4T5Vgs/Ct6cN7uAJg0eTN00FnT3FyfVNsq4xg1TLztfxbW1ntxdazv/O/zzIysJjoWTDI
 21yQv3Q0pU5F4dPQgX6lE5cZKLC/7Yi0WuHO6nl4vCFCjtyrlcR9ZRcNcDQd94MZ7o1sop8PQj
 QUak2haLs2bEn04bYvTQRUYNc1gotNIYxKthEQHpmfu6CHyABnSJj70Zhf0ahN+/VsfEdRDi6G
 PF2YuZqmKZi9UgJwMYYMe2HDBnVxAzFdz1X3rZaA/qFApabQ==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When win32-input-mode (which is supported by Windows Termainal) is
set by "\033[?9001h", cons_master_thread does not work properly and
consumes larger and larger memory space. This is because sending
event by WriteConsoleInput() is translated into the sequence that
is used by win32-input-mode. Due to this behaviour, write-back
of the INPUT_RECORDs does not work as expected. With this patch,
cons_master_thread is disabled on win32-input-mode where the signal
keys such as Ctrl-C, Ctrl-Z etc. never comes.

Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256380.html
Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handles input signal.")
Reported-by: Adamyg Mob <adamyg.mob@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc       | 8 ++++++--
 winsup/cygwin/local_includes/fhandler.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c3f1020..dc43cd9f5 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -818,6 +818,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
   GetConsoleMode (p->input_handle, &oflags);
   DWORD flags = oflags
     & (ENABLE_EXTENDED_FLAGS | ENABLE_INSERT_MODE | ENABLE_QUICK_EDIT_MODE);
+  con.curr_input_mode = m;
   switch (m)
     {
     case tty::restore:
@@ -867,6 +868,7 @@ fhandler_console::set_output_mode (tty::cons_mode m, const termios *t,
   if (con.orig_virtual_terminal_processing_mode)
     flags |= ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   WaitForSingleObject (p->output_mutex, mutex_timeout);
+  con.curr_output_mode = m;
   switch (m)
     {
     case tty::restore:
@@ -1109,12 +1111,12 @@ fhandler_console::bg_check (int sig, bool dontsignal)
   /* Setting-up console mode for cygwin app. This is necessary if the
      cygwin app and other non-cygwin apps are started simultaneously
      in the same process group. */
-  if (sig == SIGTTIN)
+  if (sig == SIGTTIN && con.curr_input_mode != tty::cygwin)
     {
       set_input_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
       set_disable_master_thread (false, this);
     }
-  if (sig == SIGTTOU)
+  if (sig == SIGTTOU && con.curr_output_mode != tty::cygwin)
     set_output_mode (tty::cygwin, &tc ()->ti, get_handle_set ());
 
   return fhandler_termios::bg_check (sig, dontsignal);
@@ -2921,6 +2923,8 @@ fhandler_console::char_command (char c)
 		    }
 		  if (con.args[i] == 1) /* DECCKM */
 		    con.cursor_key_app_mode = (c == 'h');
+		  if (con.args[i] == 9001) /* win32-input-mode (https://github.com/microsoft/terminal/blob/main/doc/specs/%234999%20-%20Improved%20keyboard%20handling%20in%20Conpty.md) */
+		    set_disable_master_thread (c == 'h', this);
 		}
 	      /* Call fix_tab_position() if screen has been alternated. */
 	      if (need_fix_tab_position)
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 16c39b55b..4a8fefaea 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2172,6 +2172,8 @@ class dev_console
   char *cons_rapoi;
   bool cursor_key_app_mode;
   bool disable_master_thread;
+  tty::cons_mode curr_input_mode;
+  tty::cons_mode curr_output_mode;
   bool master_thread_suspended;
   int num_processed; /* Number of input events in the current input buffer
 			already processed by cons_master_thread(). */
-- 
2.45.1

