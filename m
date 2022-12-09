Return-Path: <SRS0=TymB=4H=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
	by sourceware.org (Postfix) with ESMTPS id 0113B3858438
	for <cygwin-patches@cygwin.com>; Fri,  9 Dec 2022 01:43:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0113B3858438
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-07.nifty.com with ESMTP id 2B91gkmD013143;
	Fri, 9 Dec 2022 10:42:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 2B91gkmD013143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1670550171;
	bh=3dzTk2am0gZI+L8uvfJNN84qd54ptvJOD961B+YcASQ=;
	h=From:To:Cc:Subject:Date:From;
	b=F+4uXCWlxEYjPLUx9gNhBfEprZOm4IkPVmQPs3YXn9NP1Ip+ENgZlW+F1uLM1aTkF
	 eDcHLYpP7Ks4f2f9SY+tKMn2oWmwwDhxgl2Hvj36zUiLQRPRAaqyw8Gx7HcB+BngsO
	 yUC9wFqQDOfgYjSbQbyNAakRw0j214CsdxXjb3UwBbpp/fDUMDQF4U0IWKqFfHY6rh
	 CIMmECDmaBuXggVrMcufXzGNqyY50LxTJQjctmHZdffI6cWgwtUONEav+aGlGJfbbf
	 GghUs8vPEQSothK05I4TnWEAiylkNvv4nkyi/+EnXoFKV/hqbVMjtNJZHR6qlg7Bjg
	 0YBPBnar9w9Qw==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: pty: Use GetTickCount64() instead of GetTickCount().
Date: Fri,  9 Dec 2022 10:42:35 +0900
Message-Id: <20221209014235.611-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Suggested-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc      |  2 +-
 winsup/cygwin/local_includes/tty.h |  2 +-
 winsup/cygwin/tty.cc               | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e7106daba..c9b05e3d7 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2691,7 +2691,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
   termios_printf ("Started.");
   for (;;)
     {
-      p->ttyp->fwd_last_time = GetTickCount ();
+      p->ttyp->fwd_last_time = GetTickCount64 ();
       DWORD n;
       p->ttyp->fwd_not_empty =
 	::bytes_available (n, p->from_slave_nat) && n;
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 3d0ea0c68..cd1d6ecaa 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -119,7 +119,7 @@ private:
   bool switch_to_nat_pipe;
   DWORD nat_pipe_owner_pid;
   UINT term_code_page;
-  DWORD fwd_last_time;
+  ULONGLONG fwd_last_time;
   bool fwd_not_empty;
   HANDLE h_pcon_write_pipe;
   HANDLE h_pcon_condrv_reference;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index a862a444e..6ec8927cb 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -319,13 +319,13 @@ tty::wait_fwd ()
      16-32 msec even if it already has data to transfer.
      If the time without transfer exceeds 32 msec, the
      forwarding is supposed to be finished. fwd_last_time
-     is reset to GetTickCount() in pty master forwarding
+     is reset to GetTickCount64() in pty master forwarding
      thread when the last data is transfered. */
-  const int sleep_in_nat_pipe = 16;
-  const int time_to_wait = sleep_in_nat_pipe * 2 + 1/* margine */;
-  int elapsed;
+  const ULONGLONG sleep_in_nat_pipe = 16;
+  const ULONGLONG time_to_wait = sleep_in_nat_pipe * 2 + 1/* margine */;
+  ULONGLONG elapsed;
   while (fwd_not_empty
-	 || (elapsed = GetTickCount () - fwd_last_time) < time_to_wait)
+	 || (elapsed = GetTickCount64 () - fwd_last_time) < time_to_wait)
     {
       int tw = fwd_not_empty ? 10 : (time_to_wait - elapsed);
       cygwait (tw);
-- 
2.38.1

