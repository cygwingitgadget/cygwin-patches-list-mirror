Return-Path: <SRS0=N3FD=EE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id F2DF051A4308
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 13:50:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F2DF051A4308
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F2DF051A4308
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780926618; cv=none;
	b=kiX71aQeW0K9BiJgSKIFZfwx2K31vhoSb94+kjssO0gBPmTv3jiSnzv3gUPfflLEjDfnVXF009sdbtT8OVVHvcjtMWjp6mwICUVG6ABRtgbaw+mdf1S3WItaGa6JbFWIXTz6/hy93Eg50TsekfxnkVU6ZSLrI4JxXKiVBPYeOKM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780926618; c=relaxed/simple;
	bh=+vhjueXdPTIN0WVxzpCKspHIH0bwSNB3EoQiLncfpyc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Xhdf63dXGTREorN5c1wKu4KMCQ+9u5GRqrkdT/oyWq0ci3Pyr6Svtgroypu2xh2Hbs9UofwOoSjj6zUAIPjc2XCO0rL96oAAPTWh/Q5c0fa3/UqPBWxa4hOKvnUZQO4LRSsr3X1zpJ4OgzxIYqx0QirdIe3qVHmQkwyRAcoGnu0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q3gN/YMl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F2DF051A4308
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q3gN/YMl
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260608135011033.PIPK.17441.HP-Z230@nifty.com>;
          Mon, 8 Jun 2026 22:50:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Koichi Murase <myoga.murase@gmail.com>
Subject: [PATCH v2 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report
Date: Mon,  8 Jun 2026 22:49:35 +0900
Message-ID: <20260608134943.2095-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608134943.2095-1-takashi.yano@nifty.ne.jp>
References: <20260608134943.2095-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780926611;
 bh=31xRMECruSeACuaY8aw06hsJ/+JrcFlinOwwGbms2ig=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=q3gN/YMlQ/5fzf2SItBAkDsSPyiHLhK19Ca0G0pnZPTtDRfZQBiFFKm/i5WLD+xz+k0uyc/V
 IHwFoA/ZB+GdFWJEZQI7DNWs9WA/UbUW5necgS0rbJMjERJQwRw80MtiE/9SizA4lEBUQ+bV8+
 ZFLL/GAhfLF6auJNFt0erKENV2AD1GsPJvRRZm0h470zjvx/g4iU5qXbnvfD9ll2+lo95t7J0f
 iECiC+GUI5p24TKUfzEMDZ3+woTuytwa92LDyhRT9yboO0E/V6SFlpnW44BHlk+7Nm0mzrI+JP
 wmbowcP40HE7ltabWM6XPrbgGeUBVSHYcHpaOGjOIPcTVqWA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When the cursor position report ("CSI m;n R") is transferred from
cyg-pipe to nat-pipe, it is undesirably converted into Fn3 key by
pseudo console. This patch adds a workaround to prevent this
unintended conversion for cursor position report by enabling
ENABLE_VIRTUAL_TERMINAL_INPUT flag temporarily.

Addresses: https://cygwin.com/pipermail/cygwin/2026-June/259776.html
Reported-by: Koichi Murase <myoga.murase@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc      | 47 ++++++++++++++++++++++++++++++
 winsup/cygwin/local_includes/tty.h |  1 +
 2 files changed, 48 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e60e30230..a8557bf3c 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2460,6 +2460,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      && pp && pp->pgid == get_ttyp ()->getpgid ()
 	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	    {
+	      HANDLE pcon_handle_ready_event =
+		get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
+					 get_ttyp ()->pcon_handle_ready_event);
+	      if (pcon_handle_ready_event)
+		{
+		  cygwait (pcon_handle_ready_event, INFINITE);
+		  ResetEvent (pcon_handle_ready_event);
+		  CloseHandle (pcon_handle_ready_event);
+		}
+
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
 	      WaitForSingleObject (input_mutex, mutex_timeout);
@@ -3767,6 +3777,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
       si.StartupInfo.hStdOutput = NULL;
       si.StartupInfo.hStdError = NULL;
 
+      get_ttyp ()->pcon_handle_ready_event =
+	CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
       get_ttyp ()->pcon_activated = true;
       get_ttyp ()->pcon_start = true;
       get_ttyp ()->pcon_start_pid = myself->pid;
@@ -3853,6 +3865,7 @@ skip_create:
       /* Discard the pseudo console handler container here.
 	 Reconstruct it temporary when it is needed. */
       HeapFree (GetProcessHeap (), 0, hp);
+      SetEvent (get_ttyp ()->pcon_handle_ready_event);
     }
 
   acquire_attach_mutex (mutex_timeout);
@@ -4060,6 +4073,11 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ttyp->pcon_start = false;
 	  ttyp->pcon_start_pid = 0;
 	}
+      if (ttyp->pcon_handle_ready_event)
+	{
+	  CloseHandle (ttyp->pcon_handle_ready_event);
+	  ttyp->pcon_handle_ready_event = NULL;
+	}
     }
   else
     { /* Just detach from the pseudo console if I am not owner. */
@@ -4308,6 +4326,26 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 
   UINT cp_from = 0, cp_to = 0;
 
+  HANDLE h_pcon_in = NULL;
+  DWORD con_mode = 0;
+  if (ttyp->pcon_activated && dir == tty::to_nat)
+    {
+      /* Escape sequences such as the cursor position report ("CSI m;n R")
+	 are undesirably converted into an Fn3 key by pseudo console.
+	 To privent this unintended conversion, temporarily enable
+	 ENABLE_VIRTUAL_TERMINAL_INPUT flag. */
+      h_pcon_in =
+	get_handle_from_process (ttyp->nat_pipe_owner_pid, ttyp->h_pcon_in);
+      if (h_pcon_in)
+	{
+	  DWORD target_pid = ttyp->nat_pipe_owner_pid;
+	  DWORD resume_pid = attach_console_temporarily (target_pid);
+	  GetConsoleMode (h_pcon_in, &con_mode);
+	  SetConsoleMode (h_pcon_in, con_mode | ENABLE_VIRTUAL_TERMINAL_INPUT);
+	  resume_from_temporarily_attach (resume_pid);
+	}
+    }
+
   if (dir == tty::to_nat)
     {
       cp_from = ttyp->term_code_page;
@@ -4422,6 +4460,15 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
     }
   CloseHandle (to);
 
+  if (h_pcon_in)
+    {
+      DWORD target_pid = ttyp->nat_pipe_owner_pid;
+      DWORD resume_pid = attach_console_temporarily (target_pid);
+      SetConsoleMode (h_pcon_in, con_mode);
+      resume_from_temporarily_attach (resume_pid);
+      CloseHandle (h_pcon_in);
+    }
+
   ttyp->pty_input_state = dir;
   /* Fix input_available_event which indicates availability in cyg pipe. */
   if (dir == tty::to_nat) /* all data is transfered to nat pipe,
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 4fbebd820..0adad03e6 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -125,6 +125,7 @@ private:
   bool pcon_start_csi_c;
   bool switch_to_nat_pipe;
   DWORD nat_pipe_owner_pid;
+  HANDLE pcon_handle_ready_event;
   UINT term_code_page;
   ULONGLONG fwd_last_time;
   bool fwd_not_empty;
-- 
2.51.0

