Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 4B0D14B99F46
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:06:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4B0D14B99F46
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4B0D14B99F46
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359616; cv=none;
	b=bB3jnGvcqbQXqTuCaTqljn1xaxJgXj5XJbrtpw+Eh8Xlf23dMGzllS2nHcT1PsnxFq4shXvla+7oX+T6YjiisLdYXSI+fpZg68HdEmvjiR5HRsQtdNKLohLsHfHaS8C8Yxw5r2Pt2O6BP2e1+SzKeS/EM0X7iGiKJCpKnvI2DdU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359616; c=relaxed/simple;
	bh=AZ39C57n1ZWn3EUC1a1ayB9DT3IGxpht6nahEAYObio=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=K/TUGBzPTIk0HBmv+ua1Gx5fZrz7TswEcnS6uN3W2K1MaY0ew9fko+tE2e1K8FYAXMmEsfifoFcE5EALY2tdH2ei1/ikR5sBO5gWtx0GBC7NM1WHxbRrSohCmQaeOmArS8S8qRVtpPQFzHQumZdgj8fl8fTIijt14N2tkJtIq58=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fPorKzF8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4B0D14B99F46
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fPorKzF8
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260613140654565.UYQS.44671.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:06:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Koichi Murase <myoga.murase@gmail.com>
Subject: [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report
Date: Sat, 13 Jun 2026 23:06:20 +0900
Message-ID: <20260613140630.24451-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
References: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359614;
 bh=xbuGBEs0ajtp68VA2z9g/XFd6yoSN+Yji2Pp3lMwZTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fPorKzF8cyKElnFTZh3jSzBWHMAlR75Na7gRidkALhDNe/lt4iMISc1nUXGTu6dlx+5ODucf
 LV/tIVrYVDJpIRNDS72Svx8IEf0vWI6L5jU8TNAb52hFi9dD68RFt1oy4il4QZ0ok2Jjo0BrNn
 n2hhw7pijDpLZ3ia81VfJkPwJqfMo603BmA3qjux+vhDXpm0LFx+AnDA92X8tpckvuBDa1Hp0k
 oQ5VENZRjEoxsBMVNvDY03IEM6m5DQFsI3PO0C2hsOs/iUqjxAdCqfeFxADNle0kro8EFVSbEE
 EFYlqRe+FFY3lottW+2bGgQEwaemOknzxiJWkHHIh4YXnwWw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/pty.cc      | 53 +++++++++++++++++++++++++++++-
 winsup/cygwin/local_includes/tty.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e60e30230..e0fc67ae1 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2445,7 +2445,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      ixput = 0;
 	      state = 0;
 	      wp_tid = 0;
-	      get_ttyp ()->req_xfer_input = false;
 	      if (!get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
 		break;
 	    }
@@ -2460,6 +2459,20 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      && pp && pp->pgid == get_ttyp ()->getpgid ()
 	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
 	    {
+	      if (!get_ttyp ()->req_xfer_input)
+		{
+		  HANDLE pcon_handle_ready_event =
+		    get_ttyp ()->pcon_handle_ready_event;
+		  get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
+					   pcon_handle_ready_event);
+		  if (pcon_handle_ready_event)
+		    {
+		      cygwait (pcon_handle_ready_event, INFINITE);
+		      ResetEvent (pcon_handle_ready_event);
+		      CloseHandle (pcon_handle_ready_event);
+		    }
+		}
+
 	      /* This accept_input() call is needed in order to transfer input
 		 which is not accepted yet to non-cygwin pipe. */
 	      WaitForSingleObject (input_mutex, mutex_timeout);
@@ -2473,6 +2486,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      release_attach_mutex ();
 	      ReleaseMutex (input_mutex);
 	    }
+	  get_ttyp ()->req_xfer_input = false;
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
       if (len == 0)
@@ -3767,6 +3781,8 @@ fhandler_pty_slave::setup_pseudoconsole ()
       si.StartupInfo.hStdOutput = NULL;
       si.StartupInfo.hStdError = NULL;
 
+      get_ttyp ()->pcon_handle_ready_event =
+	CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
       get_ttyp ()->pcon_activated = true;
       get_ttyp ()->pcon_start = true;
       get_ttyp ()->pcon_start_pid = myself->pid;
@@ -3853,6 +3869,7 @@ skip_create:
       /* Discard the pseudo console handler container here.
 	 Reconstruct it temporary when it is needed. */
       HeapFree (GetProcessHeap (), 0, hp);
+      SetEvent (get_ttyp ()->pcon_handle_ready_event);
     }
 
   acquire_attach_mutex (mutex_timeout);
@@ -4060,6 +4077,11 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
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
@@ -4308,6 +4330,26 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 
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
@@ -4422,6 +4464,15 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
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

