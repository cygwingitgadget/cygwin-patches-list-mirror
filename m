Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 29ED54BA2E13
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 08:51:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 29ED54BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 29ED54BA2E13
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773132714; cv=none;
	b=Cbq47pToGeQzHuXUda1sc8rlAwGKTU6xfZos3SgFdzAcRNvBCWEBDtYDdS2SZgsH0HKDQhdGvQveGmtkoWoarq/j3EOHoqufUNCRr9M5KRxMTqBKf5DEb/CAJRXL3r0cNpz89U7jNm9+8kJNoIBFuNTkT369ZCDVLBW4jj9D+9A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773132714; c=relaxed/simple;
	bh=gL3W3jAcaDcHkdDac+miEHdFh0ZUAMaVbKzuaR88U2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jj+v+pUCPm4D4JAiPTXaQnDQqGlcU2Ceo/LxUmy+aEizGvdD3e8oB+mybMLSkk78tNkVgNy2LUUgkso/jIXsar0rFgxBl9knJnUk7EjUgRNINpLIJGbzswd5In7Y6YNkC8ZQDijoD9mCyulSWjPRn9Hhy8+F9Iu4814S3oenM54=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 29ED54BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QhK0/imU
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260310085146205.SNOY.19957.HP-Z230@nifty.com>;
          Tue, 10 Mar 2026 17:51:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist
Date: Tue, 10 Mar 2026 17:51:28 +0900
Message-ID: <20260310085139.113-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773132706;
 bh=GC0FvG7ndd9Tti1zUoRy7qFFF1Og5vB0bowng8ujtIk=;
 h=From:To:Cc:Subject:Date;
 b=QhK0/imU32/+AGFnRhiNS+Pd/lGwiKsQxBgFuTFlNz+BmoPq4xX1qm+TU2rzPPaYTvhmGCQ6
 My9LUUUx8J2c+1bIazsYyuqEWCwrTDnJK4hypsslFpx40sgHbjy2SxHzPv36dytXjQtRSgyZ4e
 2zh89BdE13dhQPP3f2LyJyWk74eAiqCuMDJYNpNmmeRq9LEpYUHayFOwtuIAypmIajOQ0KlaPF
 Ph+jnjdvyebY9tcSvrqE+QVUI23deFpW6A5IoM8R4bTIrv5kKRPQ8aJKC76wjmueXeFn7MZAyk
 oDEh7/A1KojkM+vUFYYl8GnYa3/mnjPdsFQTTa4VL6tdZX4g==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, if two non-cygwin process exist, one is nat pipe owner
and the other is not, and if the second process (not a nat pipe
owner) is terminated first, the first process (the nat pipe owner)
looses the input. This is because transfer_input() is wrongly called
in cleanup_for_non_cygwin_app().

With this patch, in cleanup_for_non_cygwin_app(), transfer_input()
is called only when the current process is a nat pipe owner to
solve this problem.

Fixes: f9542a2e8e75 ("Cygwin: pty: Re-fix the last bug regarding nat-pipe.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 56b573c8d..aaad47ca9 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4575,16 +4575,19 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
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

