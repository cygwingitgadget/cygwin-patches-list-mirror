Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id E8F084BA23D1
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 11:01:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8F084BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8F084BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695661; cv=none;
	b=KZk/dgkNcwli/BDTewV8/KHxIZ570vQAo+Oj7Y/aQkW2fPRnpKyp3OTxWPFMq0qlytbQhIj7dOlJZDmORomHrYj7iC74B0NDhB/tJ3mK+UdNrn7xOSkgUekA+WGknPJH730fVo5PTOcAuqVa6gNtdIAtUBzqhefiZzG0VZwmTAc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695661; c=relaxed/simple;
	bh=462Ji2NW7TcvowpWfU8JJq1j1YmRZaXCnOAK0Uoq/Fs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=EEQ+JVshLWfxmi+uY3oe+dVxKe7xwscOPuXhAFrFyYvOe6TBAELWXTMijAmgBksUFkUmATrIG1QUsUApzHHXKMgLJvVhHQJMBz5kybt8EgIjhyADRSERe0gRsl7cIMfig92eoB/MrQpyM/0cVuAg9IIOMD83q/vwec4Rx5F9OBw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8F084BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=eRj7OWrZ
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260328110058952.VWMD.14880.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 20:00:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist
Date: Sat, 28 Mar 2026 19:59:29 +0900
Message-ID: <20260328110050.1928-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310085139.113-1-takashi.yano@nifty.ne.jp>
References: <20260310085139.113-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695659;
 bh=wZHezo5dMG2ZaRjm4f2ZL2d6KVpwx1KeNJstlXge/Yo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eRj7OWrZh3xQGwy+0HmGaj47ClhKNyn0GnWLJ2YB/Wc53Ab0bFonu1FQakC6r/Onk1I0PMAu
 aWM5FUqa6Js9nWun0i1J2O63sKLOhE13JmAV4Glx84NgKXfdMGRrUmn4xRk9SR3pcAlykGmWv0
 Uzu7EUqMm8CVEV1+0m08UWRgmXv1QzrtsSyADL4MkI7j5KYemsOp6DGvucH9bMKSiaQ08rO0gM
 Sga99s4huL0ssoMfZWGD0KtfAQMOn7Nggn0qEApYsh/zasG8vFpe55cAzcmTItP81DPrO8MuYQ
 UJTRtQVhoO/IUdmpIHnzUs+b2nxHwXrDN2VvHUTG3XBvfN4g==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Cygwin maintains POSIX line discipline for its own processes:
input goes through `line_edit()` before reaching the reading process.
Native (non-Cygwin) processes must not receive line-edited input;
they expect raw console input instead. To support both, the PTY keeps
two independent pipe pairs for input: a "cyg" pipe for Cygwin processes
and a "nat" pipe for native ones. The runtime switches between the two
as the foreground process changes.

The PTY tracks which process "owns" the nat pipe session via the
shared-memory field `nat_pipe_owner_pid`. Only one process is the
owner at any time. When `setup_for_non_cygwin_app()` finds that the
current owner is still alive, it leaves ownership with that process
rather than claiming it for the new one.

This means that a Cygwin-spawned native process can go through
`cleanup_for_non_cygwin_app()` without being the nat pipe owner.
Before this fix, that cleanup called `transfer_input(to_cyg)`
unconditionally, draining the pseudo console's input buffer even
though another process still owned the session. Keystrokes that the
user had typed were moved to the cyg pipe prematurely, so the actual
owner found an empty console input buffer and appeared to lose all
input.

When looking for the next owner of the console in
`cleanup_for_non_cygwin_app()` (via `get_winpid_to_hand_over()`),
and when transferring the input back to the cyg pipe, guard both with
a `nat_pipe_owner_self()` check so that only the actual owner performs
these operations. Non-owner processes skip straight to detaching from
the pseudo console without disturbing the input buffer.

Fixes: f9542a2e8e75 ("Cygwin: pty: Re-fix the last bug regarding nat-pipe.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 8c290eb59..fbc6152e5 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4180,16 +4180,19 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 {
   ttyp->wait_fwd ();
   WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
-  DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
-  if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
-      && ttyp->pty_input_state_eq (tty::to_nat))
+  if (nat_pipe_owner_self (ttyp->nat_pipe_owner_pid))
     {
-      WaitForSingleObject (p->input_mutex, mutex_timeout);
-      acquire_attach_mutex (mutex_timeout);
-      transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
-		      p->input_available_event);
-      release_attach_mutex ();
-      ReleaseMutex (p->input_mutex);
+      DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
+      if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
+	  && ttyp->pty_input_state_eq (tty::to_nat))
+	{
+	  WaitForSingleObject (p->input_mutex, mutex_timeout);
+	  acquire_attach_mutex (mutex_timeout);
+	  transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
+			  p->input_available_event);
+	  release_attach_mutex ();
+	  ReleaseMutex (p->input_mutex);
+	}
     }
   if (ttyp->pcon_activated)
     close_pseudoconsole (ttyp, force_switch_to);
-- 
2.51.0

