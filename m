Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 06E934BA2E09
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 14:31:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06E934BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06E934BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783521080; cv=none;
	b=Z6/krd1Blk6LFZpQguKBgJYpRXLiJ+QVK6gkZZiNOy6rdZKmxe3pORFRYSr57ZITjBUSX4DFy+PuGLCekcKC3ENDRnZ7vD+r5PsxnTVJy1irJ3NM7pPtd4H8UwDETd9ZP9EuVUqC52O9Kall6Bnb/zAOmS2CH2Z5vnxnLYHCJ/w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783521080; c=relaxed/simple;
	bh=CcszMUFTsOmbrM9/bBNBeV83yhyFikxckerirGOULlc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=PTz33/fQmg6gevWmSDzTsr4x93pVMx3elecS4CLbmum7kWUxpJRScG6XBDA0YL1UjO/xWa3c97ifMcuwmoLLO8QVNobqPN2Y/WFwOF4RHVu5FrqZU/Umq3xw51DsNnNff6YFX95/j6227OL1VJ7qtmx0qEgmo2KUCGj/IM5YCmQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RBLYmgzu
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06E934BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RBLYmgzu
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260708143116404.YHUH.3198.HP-Z230@nifty.com>;
          Wed, 8 Jul 2026 23:31:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Fix nat_pipe_owner_pid when gdb runs non-cygwin app
Date: Wed,  8 Jul 2026 23:30:06 +0900
Message-ID: <20260708143017.1073-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783521076;
 bh=TUrj5nvUYk2CgP7sGZofMkqucbQMJlqTIqI4Tkj/4eU=;
 h=From:To:Cc:Subject:Date;
 b=RBLYmgzusa1JDGdpaPDhKJjhCxc342yoUcAnO0Xz893PZE1ZwDgGh3l8TQ0+H3tuiGg1GT6+
 /hQY5jtqpipqkIBZXUD8HEPRtweHwnLRjJsMHDwaXy3R5IlbtkXExQ6PrS2KZunfLgqnbW5DoM
 h2cDtygIHPkdNy6iLMhvF6HuUPaohIvbRoHm/5Y40Uq76GDbwaNQbyxRcq6GCQGZQNdgAyJwsH
 Ter6GYE4AQvVTckbP445SOpZF0p52JZfZyoUqoC3cGQnVrNbUzYZJXVhvWZfVcysasY+cXGWer
 xfSADZTU3O/gHLZkPvDO2GZjlpHcjhE1bQGPxQcS7vOVI73Q==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, nat_pipe_owner_pid was incorrectly set to 0 when the
inferior of gdb was a non-cygwin app. Due to this bug, repeatedly
running a non-cygwin app under gdb could lead to an unexpected crash.

This occurred because the previous code in setup_for_non_cygwin_app()
set nat_pipe_owner_pid to exec_dwProcessId, which is correct when the
caller is the stub process of the non-cygwin app. However, when the
caller is gdb, the owner should be gdb itself, so nat_pipe_owner_pid
must be set to myself->dwProcessId.

With this fix, attach_console_temporarily() can be called with target
pid equal to the process's own pid, in which case the attach operation
is skipped.

Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting up and closing pcon.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
v2: Skip attaching operation when attaching to myself is requested.

 winsup/cygwin/fhandler/pty.cc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 1b453a499..6ef4fa506 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4734,7 +4734,11 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon,
       fhandler_pty_slave *ptys = (fhandler_pty_slave *) fh;
       ptys->get_ttyp ()->switch_to_nat_pipe = true;
       if (!process_alive (ptys->get_ttyp ()->nat_pipe_owner_pid))
-	ptys->get_ttyp ()->nat_pipe_owner_pid = myself->exec_dwProcessId;
+	/* In normal case where the current process is the stub process for
+	   non-cygwin app, set owner to exec_dwProcessId (non-cygwin app).
+	   However, in gdb case, gdb itself should be the owner. */
+	ptys->get_ttyp ()->nat_pipe_owner_pid =
+	  myself->exec_dwProcessId ? : myself->dwProcessId;
     }
   bool pcon_enabled = false;
   if (!nopcon)
@@ -4862,6 +4866,8 @@ fhandler_pty_common::attach_console_temporarily (DWORD target_pid)
 {
   DWORD resume_pid = 0;
   acquire_attach_mutex (mutex_timeout);
+  if (target_pid == GetCurrentProcessId ())
+    return target_pid;
   pinfo pinfo_resume (myself->ppid);
   if (pinfo_resume)
     resume_pid = pinfo_resume->dwProcessId;
@@ -4880,6 +4886,11 @@ fhandler_pty_common::attach_console_temporarily (DWORD target_pid)
 void
 fhandler_pty_common::resume_from_temporarily_attach (DWORD resume_pid)
 {
+  if (resume_pid == GetCurrentProcessId ())
+    {
+      release_attach_mutex ();
+      return;
+    }
   bool console_exists = (resume_pid != (DWORD) -1);
   if (!console_exists || resume_pid)
     {
-- 
2.51.0

