Return-Path: <SRS0=qSGf=SB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id B54673858D28
	for <cygwin-patches@cygwin.com>; Wed,  6 Nov 2024 13:53:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B54673858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B54673858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730901187; cv=none;
	b=RP6YGpPQhl48YbQJ/v0wjKmTTdKQcWIuwYB3QNRz+Lb4tHfaHixq8FvUNdpfDwpJbYK0NNDHKCWqy+0nQJDqC7rwnIqTCopsoPRz9Essh7uBxiUex6QFwUuNk2f8lAadtPMNcknkhEDlHfD8ORgyJJo5QfP0YQpmZOyLHodcSS4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730901187; c=relaxed/simple;
	bh=5A4JfiRbbyeWARP3zgOM/RK9xmc98tqJlsiEhELkpF4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=rsGUyLN6PIwjJ9iU18U/UWvIlKokES9yYZeUJHh2x7jveiHAC2mYiVdRRRXBI5mugA1A5nEyCW7u8wibXW2Tt1KX0CADLRyRR25T7a8Ee0ptMzu+s5lq9UFVTHXKzIpu17oW2HUyqwpPTAeiE3N954T8jeC2J+iVnx9GQ0UOTbM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20241106135300397.NEJ.13595.localhost.localdomain@nifty.com>;
          Wed, 6 Nov 2024 22:53:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Use GetCurrentProcessId() instead of myself->dwProcessId
Date: Wed,  6 Nov 2024 22:52:33 +0900
Message-ID: <20241106135242.690-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730901180;
 bh=Yf++L9pIQYeAOih+dwmqPJLg6Ob/IqCTYflpGEF4k94=;
 h=From:To:Cc:Subject:Date;
 b=bQWNCGLU7ClBfNu1VNE4QviyBihm+BN673ZHLDQO1fd4pUN+8kpeXZbehRTjFyGVhtVDnbAt
 geHlBGTyAJU52lghPnv5zuZrl1uMzPnHh18egQV6KUPI0G6OkiTrFaik6t+8cioo1t3HMMdJ+W
 1Z62bcg83h5Xv+WBgirfzfAlZ9nSTRQVtCDC8jV4+Og4VIUxbuFy6PSY1CHkSeHs5zaNhecUB+
 yksRYQD8cwK4ERU4blZX4jTSQT1WVjjGwwNfuobr0yynkmWZiV5uPceIhzkIWy6qlk6qFBzLNS
 xNe4UsM4pxsnu3Mg11Afbu6cjgcOWAiTl4c/VvlAq77m8+xA==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 90ddab98780d uses myself->dwProcessId to get windows pid.
However, it will be overridden in stub process if exec() is called.
With this patch, GetCurrentProcessId() instead of myself->dwProcessId.

Fixes: 90ddab98780d ("Cygwin: console: Re-fix open() failure on exec() by console owner")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 7ac926554..4efba61e2 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -85,7 +85,7 @@ fhandler_console::attach_console (DWORD owner, bool *err)
   if (!attached)
     {
       resume_pid =
-	get_console_process_id (myself->dwProcessId, false, false, false);
+	get_console_process_id (GetCurrentProcessId (), false, false, false);
       FreeConsole ();
       BOOL r = AttachConsole (owner);
       if (!r)
@@ -110,7 +110,7 @@ fhandler_console::detach_console (DWORD resume_pid, DWORD owner)
       FreeConsole ();
       AttachConsole (resume_pid);
     }
-  else if (myself->dwProcessId != owner)
+  else if (GetCurrentProcessId () != owner)
     FreeConsole ();
 }
 
@@ -395,7 +395,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       }
   };
   termios &ti = ttyp->ti;
-  while (con.owner == myself->dwProcessId)
+  while (con.owner == GetCurrentProcessId ())
     {
       DWORD total_read, n, i;
 
@@ -709,7 +709,7 @@ fhandler_console::set_unit ()
 		unit = device::minor (cs->tty_min_state.ntty);
 	      shared_console_info[unit] = cs;
 	      if (created)
-		con.owner = myself->dwProcessId;
+		con.owner = GetCurrentProcessId ();
 	    }
 	}
     }
@@ -917,10 +917,10 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
   /* conmode can be tty::restore when non-cygwin app is
      exec'ed from login shell. */
   tty::cons_mode conmode =
-    (con.owner == myself->dwProcessId) ? tty::restore : tty::cygwin;
+    (con.owner == GetCurrentProcessId ()) ? tty::restore : tty::cygwin;
   set_output_mode (conmode, ti, p);
   set_input_mode (conmode, ti, p);
-  set_disable_master_thread (con.owner == myself->dwProcessId);
+  set_disable_master_thread (con.owner == GetCurrentProcessId ());
 }
 
 /* Return the tty structure associated with a given tty number.  If the
@@ -1774,7 +1774,7 @@ fhandler_console::open (int flags, mode_t)
   acquire_output_mutex (mutex_timeout);
 
   if (!process_alive (con.owner))
-    con.owner = myself->dwProcessId;
+    con.owner = GetCurrentProcessId ();
 
   /* Open the input handle as handle_ */
   bool err = false;
@@ -1838,7 +1838,7 @@ fhandler_console::open (int flags, mode_t)
 
   set_open_status ();
 
-  if (myself->dwProcessId == con.owner && wincap.has_con_24bit_colors ())
+  if (GetCurrentProcessId () == con.owner && wincap.has_con_24bit_colors ())
     {
       bool is_legacy = false;
       DWORD dwMode;
@@ -1869,7 +1869,7 @@ fhandler_console::open (int flags, mode_t)
   debug_printf ("opened conin$ %p, conout$ %p", get_handle (),
 		get_output_handle ());
 
-  if (myself->dwProcessId == con.owner)
+  if (GetCurrentProcessId () == con.owner)
     {
       if (GetModuleHandle ("ConEmuHk64.dll"))
 	hook_conemu_cygwin_connector ();
@@ -1983,9 +1983,9 @@ fhandler_console::close ()
       NTSTATUS status;
       status = NtQueryObject (get_handle (), ObjectBasicInformation,
 			      &obi, sizeof obi, NULL);
-      if ((NT_SUCCESS (status) && obi.HandleCount == 1
-	   && (dev_t) myself->ctty == get_device ())
-	  || myself->dwProcessId == con.owner)
+      if (NT_SUCCESS (status)
+	  && obi.HandleCount <= (myself->cygstarted ? 2 : 3)
+	  && (dev_t) myself->ctty == get_device ())
 	{
 	  /* Cleaning-up console mode for cygwin apps. */
 	  set_output_mode (tty::restore, &get_ttyp ()->ti, &handle_set);
@@ -1994,7 +1994,7 @@ fhandler_console::close ()
 	}
     }
 
-  if (shared_console_info[unit] && con.owner == myself->dwProcessId)
+  if (shared_console_info[unit] && con.owner == GetCurrentProcessId ())
     {
       if (master_thread_started)
 	{
-- 
2.45.1

