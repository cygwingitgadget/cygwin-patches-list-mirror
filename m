Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id DF8564BBCDBC
	for <cygwin-patches@cygwin.com>; Sat, 21 Mar 2026 11:37:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF8564BBCDBC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF8564BBCDBC
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774093023; cv=none;
	b=JDBY+KMDyWRzwsrwqbI3CsEhHS64oL/DZlFMrASNJlA9GT320xJvMC3EaKjhmVRjs/NZzuZAFTJtDkQCs9W9yx2pe5l8R/URnF+w4tLsuA67ZcPNnSXKvJHKIzbyqAdvbTp4d+9g7mNlgV72YmZ8YByW5PYmq11TloisONzeI5A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774093023; c=relaxed/simple;
	bh=uDY05pOXQCbf1voe5FLnPdMSvmftRt3NNeuxHxtEVf4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=T1bNy61lr3/ctJm5owRThc29Im744E8jjnZbm4jXZxhfWEUao4rgoM/QTXBkVtE2XBcyp9MKuko97P5jxo5ez0leYOho+0ZZxgmw3Ow79cHo8O+IQLN3vLn/zBkwL0PZPytZ8Y5sMniCHQMujp6yMs7/FGw/4F1F+z+CgAIuEqE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF8564BBCDBC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=poriOZso
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260321113700981.VNUO.36235.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 20:37:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 6/6] Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
Date: Sat, 21 Mar 2026 20:35:31 +0900
Message-ID: <20260321113613.9443-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
References: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
 <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774093021;
 bh=tVipCZxskMCHH30J13KzOAPcXc7oxbejRcRxsyI9rFk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=poriOZsoUWAZ2ydFQGXmttjMzGGNmHNI7BmhMiTbbfRBm3vC/Fe5/bK06gdlUPGGUULqd6s8
 hbkFrLRa2eXUpaV8Y9nOx9Xq7g6Z4j/1N5ZKIkNJIb1XdOtIXL7CmL18jBhTYeapw9bazXzgic
 uD1djfoJO1Jz8PXvlFi8Wm50glJ7Ypaj1vaEFnP+m+YY3fDmi8j6B4uiW1gI/EbevexiUfQGh5
 0NClZrLz7hPJklAokojjr9JSNPccW/76nwnqrhnzh+RnO0NHKz1H1b7m+Eb2uYG+g0G/ukfWlW
 l8fpdzD/3zVLBcJqScu5JOfoRy8GgC6dZFyPydY8Ji5XXARA==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/pty.cc | 50 +++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 0de6ec007..0c50e50f5 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1311,22 +1311,44 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 bool
 fhandler_pty_common::to_be_read_from_nat_pipe (void)
 {
+  /* If the slave is in setup_pseudoconsole(), pipe_sw_mutex cannot
+     be acquired because the slave has it. In this case pcon_start
+     will be asserted. During pcon_start, other input than response
+     to CSI6n should be go to cyg-pipe. So, wait for pcon_start and
+     return false. */
+  while (WaitForSingleObject (pipe_sw_mutex, 0) == WAIT_TIMEOUT)
+    if (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_pid)
+      return false;
+    else
+      yield ();
+
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
@@ -3948,7 +3970,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     goto maybe_dumb;
 
   /* Check if terminal has CSI6n */
-  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle_nat rather than io_handle. */
@@ -3984,7 +4005,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   while (len);
   get_ttyp ()->pcon_activated = false;
   get_ttyp ()->nat_pipe_owner_pid = 0;
-  ReleaseMutex (pipe_sw_mutex);
   if (len == 0)
     goto not_has_csi6n;
 
@@ -4000,7 +4020,6 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
-  ReleaseMutex (pipe_sw_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
@@ -4318,7 +4337,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
@@ -4334,6 +4352,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 	  ReleaseMutex (p->input_mutex);
 	}
     }
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
@@ -4352,6 +4371,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
+      ReleaseMutex (pipe_sw_mutex);
       WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
@@ -4362,6 +4382,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
 	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     {
+      ReleaseMutex (pipe_sw_mutex);
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
@@ -4389,7 +4410,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
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

