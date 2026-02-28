Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 3A7204BA23F6
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:02:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A7204BA23F6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A7204BA23F6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269360; cv=none;
	b=i0E2p44xpLBoEu0WGqPP7DWuhnCSUZSmVd1/2pDv7b4xZPW639fZVWU+46/FXZLRo0zI2WuXq6oAEEeHppPoQu8MkqVnBYQW4GvZUj6QWdDRwLkp1McEH37sysEuHBxTrEy5Pr6JHPFQjPeMlMWXXiToYbvnrLxiBj/zOJKhqYU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269360; c=relaxed/simple;
	bh=zz4mIDNoRBojOg1ioIlfrc8sIbTJDQzTyPUXvBe+CTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hWgZqQzkxpKp5ih4Mc45JPYYE6gigEPhvWgz6lpByDYzFi+OgWME9gw0CoxnGrod/Ti1krXXcTF+kewTchgaI10IMo126fymnXvruRnmBhnOAVWBrWifhy+K0kr5MF2vIdw4jdD73fTVJBrhs0+c4jRcAoQlwf29d2oLbpV5LtM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3A7204BA23F6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lNy5YycV
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260228090236581.QBJK.58584.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:02:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB
Date: Sat, 28 Feb 2026 18:02:11 +0900
Message-ID: <20260228090219.2551-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
References: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269356;
 bh=uvjbbdBkCc/jZAYM5d5WG6JvJS7NXUWGloKqFOr3xYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lNy5YycVpuDYrqFeo7Ewh9NZ5zcbbChzNHptkF+kuTGRbV2IXXS8e0fPnh0BHSYYCSZgGEnT
 DFT8thqlsiX8OMinlWo5nNZcsZMlZQUr/JAFoPoODgdA/3ieq7je29g1YSAq0bn8LHVkx7mb96
 q4LqZXXb1wQ3AzeOmFwrQMRdWq5o11LWwUp7xrH0Kg5m1XL8iq+UgwNHlJGfeoH+J5fO/fJv10
 QWS5knFfk/dKCz7ppPmOMWUcubCmHISyrPGRGxiViNFCjVW+3C8WND9EOMOsLfkO/Q83ELCGGS
 gzwbTc9BxcG/cgOTzGPmOYV8U3hAf7hDWa0nmTzBZFd4LCDQ==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

At some point in the past, GDB sets its own pgid to inferior pid
when the inferior is running. Due to this behaviour, Ctrl-C does
not work if the inferior is a non-cygwin app. This is because,
the current code sends Ctrl-C to GDB only when GDB's pgid equeals
to terminal pgid. This patch omit checking pgid when recognizing
GDB process whose inferior is non-cygwin app.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/termios.cc | 18 +++++++++---------
 winsup/cygwin/tty.cc              |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 694a5c20f..00700aed8 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -346,11 +346,11 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 		     a marker for GDB with non-cygwin inferior in pty code.
 	 !PID_CYGPARENT: check this for GDB with cygwin inferior or
 			 cygwin apps started from non-cygwin shell. */
-      if (c == '\003' && p && p->ctty == ttyp->ntty && p->pgid == pgid
-	  && ((p->process_state & PID_NOTCYGWIN)
+      if (c == '\003' && p && p->ctty == ttyp->ntty
+	  && ((p->pgid == pgid && ((p->process_state & PID_NOTCYGWIN)
+				   || !(p->process_state & PID_CYGPARENT)))
 	      || ((p->exec_dwProcessId == p->dwProcessId)
-		  && ttyp->pty_input_state_eq (tty::to_nat))
-	      || !(p->process_state & PID_CYGPARENT)))
+		  && ttyp->pty_input_state_eq (tty::to_nat))))
 	{
 	  /* Ctrl-C event will be sent only to the processes attaching
 	     to the same console. Therefore, attach to the console to
@@ -403,12 +403,12 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  if (!p->cygstarted && !(p->process_state & PID_NOTCYGWIN)
 	      && (p->process_state & PID_DEBUGGED))
 	    with_debugger = true; /* inferior is cygwin app */
-	  if (!(p->process_state & PID_NOTCYGWIN)
-	      && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
-	      && ttyp->pty_input_state_eq (tty::to_nat)
-	      && p->pid == pgid)
-	    with_debugger_nat = true; /* inferior is non-cygwin app */
 	}
+      if (p &&  p->ctty == ttyp->ntty
+	  && !(p->process_state & PID_NOTCYGWIN)
+	  && (p->exec_dwProcessId == p->dwProcessId) /* Check marker */
+	  && ttyp->pty_input_state_eq (tty::to_nat))
+	with_debugger_nat = true; /* inferior is non-cygwin app */
     }
   if ((with_debugger || with_debugger_nat) && need_discard_input)
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 0c49dc2bd..3ab30c0a7 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -340,8 +340,8 @@ tty::nat_fg (pid_t pgid)
   for (unsigned i = 0; i < pids.npids; i++)
     {
       _pinfo *p = pids[i];
-      if (p->ctty == ntty && p->pgid == pgid
-	  && ((p->process_state & PID_NOTCYGWIN)
+      if (p->ctty == ntty
+	  && (((p->process_state & PID_NOTCYGWIN) && p->pgid == pgid)
 	      /* Below is true for GDB with non-cygwin inferior */
 	      || p->exec_dwProcessId == p->dwProcessId))
 	return true;
-- 
2.51.0

