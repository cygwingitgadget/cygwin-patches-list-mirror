Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 52D2F4A9F1C2
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:25:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 52D2F4A9F1C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 52D2F4A9F1C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750347; cv=none;
	b=skw9Mk8x7LliTOycZ9SIlMNDIdzNzh68JqwjA61iCh830YsMA2/piSr4mcT65Jw0rzjFIa0V0E3ZWFNVbDETwvPKrQHtpx3FCVoszjH+kt8VTLf3JGb5HL5RnT+rEpstEgZ8SQ1LFkvgJpTcNWl4/HhwZMIkUeglfPz8xCMfOjI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750347; c=relaxed/simple;
	bh=gw3tTkI95Bp1hM/qE8wzLwl9SHf/B9YuFGp8gCKOTok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jnfmoaAT3VyZNXJY6TlqkQ71BJXeIWxj3Chg4EV8W82qtdfenlWEHwEaGQTaAOQ2MV80E+dZourjeQPju5UoImsZL5oC7jnbtB/6UmW0SX1muBnhemveBjGHno5s1G3FAKcRZtQF7KGKK4pwVng6KfNmHP8gTtUqvwW1W9oB7No=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 52D2F4A9F1C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FBH6Ky5R
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122545387.NPUO.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:25:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 6/6] Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
Date: Tue, 17 Mar 2026 21:23:10 +0900
Message-ID: <20260317122433.721-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
 <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750345;
 bh=8VyrPI7AwXzxb41zEO7B9VPSULCA2QKjLUEEeizZXJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FBH6Ky5RrwDVJOq22S8ngLSCIp+4aOggX6wWB7ZwGfEGz4fxRF55eV83k5KXVsRorYF/UNke
 p1vgvmwYiIRGX3YDhy6y5FZO4YvNedy8F3plTn1sxpIAKNofCbg1FO6XU+R9MT1VZTM60JWPZz
 jFGl9O9g6rAnS3SWNe/VXocPcJQDCza1FjPshGAe+UfqlUFUtcL6bNRuC7gsistBHZ1AsXaVIG
 omGhsTcK9MWZGn6VKsCGsmURqc4b6LWRW8txf4Qy1K9f9Mdjg4aFB9O6CkN3x/D10V+C0Rs3kj
 jsnDOHiKX0P09E8SjuHXm64zb0GsYAbODlkjWEUPnsb0W7vQ==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If to_be_read_from_nat_pipe() is called during pipe switching between
cygwin pipe and nat pipe, the return value mignt not as expected due
to incomplete state change. With this patch, to_be_read_from_nat_pipe()
is guarded by pipe_sw_mutex to avoid that. In addition, duration of
the acquiring the pipe_sw_mutex is reduced to avoid deadlock.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 149e8e2cd..766df1b4f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1301,22 +1301,34 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 bool
 fhandler_pty_common::to_be_read_from_nat_pipe (void)
 {
+  WaitForSingleObject (pipe_sw_mutex, mutex_timeout);
+  bool ret = false;
   if (!get_ttyp ()->switch_to_nat_pipe)
-    return false;
+    goto out;
 
-  char name[MAX_PATH];
-  shared_name (name, TTY_SLAVE_READING, get_minor ());
-  HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
-  CloseHandle (masked);
+  do
+    {
+      char name[MAX_PATH];
+      shared_name (name, TTY_SLAVE_READING, get_minor ());
+      HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+      CloseHandle (masked);
 
-  if (masked) /* The foreground process is cygwin process */
-    return false;
+      if (masked) /* The foreground process is cygwin process */
+	goto out;
+    }
+  while (false);
 
   if (!pinfo (get_ttyp ()->getpgid ()))
     /* GDB may set invalid process group for non-cygwin process. */
-    return true;
+    {
+      ret = true;
+      goto out;
+    }
 
-  return get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
+  ret = get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
+out:
+  ReleaseMutex (pipe_sw_mutex);
+  return ret;
 }
 
 void
@@ -3943,7 +3955,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     goto maybe_dumb;
 
   /* Check if terminal has CSI6n */
-  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle_nat rather than io_handle. */
@@ -3979,7 +3990,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   while (len);
   get_ttyp ()->pcon_activated = false;
   get_ttyp ()->nat_pipe_owner_pid = 0;
-  ReleaseMutex (pipe_sw_mutex);
   if (len == 0)
     goto not_has_csi6n;
 
@@ -3995,7 +4005,6 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
-  ReleaseMutex (pipe_sw_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
@@ -4320,7 +4329,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
@@ -4335,6 +4343,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 	  ReleaseMutex (p->input_mutex);
 	}
     }
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
@@ -4353,6 +4362,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
+      ReleaseMutex (pipe_sw_mutex);
       WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
@@ -4363,6 +4373,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
 	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     {
+      ReleaseMutex (pipe_sw_mutex);
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
@@ -4389,7 +4400,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	release_attach_mutex ();
       ReleaseMutex (input_mutex);
     }
-  ReleaseMutex (pipe_sw_mutex);
+  else
+    ReleaseMutex (pipe_sw_mutex);
 }
 
 bool
-- 
2.51.0

