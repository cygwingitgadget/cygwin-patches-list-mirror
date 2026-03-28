Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 75F644BA23D5
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:57:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75F644BA23D5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75F644BA23D5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695448; cv=none;
	b=N7nNmGxSyXN2rVoputivXU11IINX/gNMOooHNjSKIcrfxgwPTbQ17hgre07ol3OCZNN5G0zg15yLXy+Ff0TYCgs7x+ZcwSQrtRzd5kaFWa4lXstdnU2sV2XtuGcfSH1UlfZeLhAqA29Q2m0+8oRTHqJVGle3jwlf71AJYWA14po=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695448; c=relaxed/simple;
	bh=rRPtTqZUPL3Z/o8owGKUrdrl/PM15ovdtBUsJGPBWxo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UutF3H97VqQXDhfwVnzcrZu4BsVvxPOjD2ZeyMyvu5Q5StOgeHtFi+yXvU7EcR5HIvBdpQTh60oEbJ7KXAmnrNQwxv1bdFzI7JV7cU4wcQOQlXYaC2UC0sXiX/I0ssZBzpLfwkkmMD1EmYiQsU7t8lBB7XsZX8bFvTmxSnL6E9o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75F644BA23D5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q5bbXAkz
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105725672.LDEK.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:57:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 6/7] Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
Date: Sat, 28 Mar 2026 19:55:50 +0900
Message-ID: <20260328105632.1916-7-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
 <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695445;
 bh=enzvH0rTL47Od1nUwra2ZsydEEcpM2IdihAn58d7+x8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=q5bbXAkziSWEWIy7i9+5LDp2nbL/CnvBt1hgqdSLbKr75aL725ecC4OMu46y/KtRP/0IOYnY
 4XT+3m20Ypv5gQ6gGfuUz0WDTLvvzCup86SNsPWfS+Kcd2U4XO3tOqwSXroqRlTB0/CDXA+JTb
 2CpGz+ZrXLzmdPkvDUm26P68U1InMj1t0jfb+zB+Szna+TM+NY+RjUscM5oDhz+B9BZVNTEtkL
 k/mkSwNk6hJ9EhzuWXo3Q4kqydXs2S5p07TntKWUIa58K/U79NMB91WyK70a2Y9gjZ1W+I1aFi
 ozvHb5jn09pr+ZYvFWbcyDxOUSDYsILrdOwYAEDL27Ryz1ig==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

`to_be_read_from_nat_pipe()` reads several shared-memory fields
(`switch_to_nat_pipe`, `pcon_activated`, `pty_input_state`) to
decide whether keystrokes should go to the nat pipe. It is called
from `master::write()` on every keystroke. Without synchronization,
the slave can be in the middle of a pipe switch (changing these
fields in `setup_for_non_cygwin_app()`, `cleanup_for_non_cygwin_app()`,
or `setpgid_aux()`) while the master reads a half-updated snapshot,
making an inconsistent routing decision that sends keystrokes to the
wrong pipe.

Guard `to_be_read_from_nat_pipe()` with `pipe_sw_mutex` so it
always reads a consistent state. The spin-wait at entry handles the
pseudo console initialization case: when `pipe_sw_mutex` is held by
the slave during `setup_pseudoconsole()` and `pcon_start` is set,
the function returns false immediately, routing keystrokes to the
cyg pipe through `line_edit()` where the CSI6n response handler
expects them.

Acquiring `pipe_sw_mutex` inside `to_be_read_from_nat_pipe()`
creates a lock ordering constraint: `master::write()` holds
`input_mutex` before calling `to_be_read_from_nat_pipe()`, so the
master's lock order is `input_mutex` then `pipe_sw_mutex`.
Previously, `cleanup_for_non_cygwin_app()` and `setpgid_aux()`
acquired `pipe_sw_mutex` first and then `input_mutex` (for
`transfer_input()`), which is the reverse order and would deadlock.
Restructure both functions to release `pipe_sw_mutex` before
acquiring `input_mutex`, maintaining a consistent lock order
throughout.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 48 +++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index f1d459414..6a36075f1 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1284,22 +1284,42 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
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
+  {
+    char name[MAX_PATH];
+    shared_name (name, TTY_SLAVE_READING, get_minor ());
+    HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+    CloseHandle (masked);
 
-  if (masked) /* The foreground process is cygwin process */
-    return false;
+    if (masked) /* The foreground process is cygwin process */
+      goto out;
+  }
 
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
@@ -3937,7 +3957,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
     goto maybe_dumb;
 
   /* Check if terminal has CSI6n */
-  WaitForSingleObject (pipe_sw_mutex, INFINITE);
   WaitForSingleObject (input_mutex, mutex_timeout);
   /* Set pcon_activated and pcon_start so that the response
      will sent to io_handle_nat rather than io_handle. */
@@ -3973,7 +3992,6 @@ fhandler_pty_slave::term_has_pcon_cap (const WCHAR *env)
   while (len);
   get_ttyp ()->pcon_activated = false;
   get_ttyp ()->nat_pipe_owner_pid = 0;
-  ReleaseMutex (pipe_sw_mutex);
   if (len == 0)
     goto not_has_csi6n;
 
@@ -3989,7 +4007,6 @@ not_has_csi6n:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_activated = false;
   ReleaseMutex (input_mutex);
-  ReleaseMutex (pipe_sw_mutex);
 maybe_dumb:
   get_ttyp ()->pcon_cap_checked = true;
   return false;
@@ -4310,7 +4327,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
       DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
@@ -4326,6 +4342,7 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 	  ReleaseMutex (p->input_mutex);
 	}
     }
+  WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
   else
@@ -4344,6 +4361,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   if (!was_nat_fg && nat_fg && get_ttyp ()->switch_to_nat_pipe
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
+      ReleaseMutex (pipe_sw_mutex);
       WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
@@ -4354,6 +4372,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
 	   && get_ttyp ()->pty_input_state_eq (tty::to_nat))
     {
+      ReleaseMutex (pipe_sw_mutex);
       bool attach_restore = false;
       HANDLE from = get_handle_nat ();
       DWORD resume_pid = 0;
@@ -4381,7 +4400,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
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

