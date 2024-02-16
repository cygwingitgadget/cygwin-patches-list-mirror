Return-Path: <SRS0=PwhG=JZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0013.nifty.com (mta-snd00004.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 867D53858431
	for <cygwin-patches@cygwin.com>; Fri, 16 Feb 2024 08:24:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 867D53858431
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 867D53858431
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708071906; cv=none;
	b=Iv7oIeyzf/MdIA+Rrv+e9Qf07ZNoqo0dzipdhhGGIleuHsEGhyosh8mNL5KFJh2SQ5hJaHY/dhet0zlLjUFxiwb6hw+H3HywfHrSPBumHtR4V0W8Oc0kwhh8CNjcsNwZbzD6nSKVy5I7cnMlDcC3HCxfQj/uXWrT6KAGqF+wpqs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708071906; c=relaxed/simple;
	bh=Wc9izChawxWlaQEFR/B0nLed9UhgnGugAxpiWCxTk4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lQrUSbfkDl4xr5BM/MJGW4hvpD4eoomi2ofcA2bgTLf9uOi7Ue2U5HrWuHtb2zlpsgas+5TjjvA+68wXSVIPXGp3tKDTO/CMAnfeQJUKsZDuhAfEtlyfEOp7cY58iviJzlH22lkgknYWp9MVXh4oyAzQjMfJVCq8xBuZqcDqkB8=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0013.nifty.com with ESMTP
          id <20240216082442030.FGKB.43072.localhost.localdomain@nifty.com>;
          Fri, 16 Feb 2024 17:24:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix failure to revert from nat-pipe in disable_pcon.
Date: Fri, 16 Feb 2024 17:24:17 +0900
Message-ID: <20240216082426.194-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: a9038789488e ("Cygwin: pty: Additional fix for transferring input at exit.");
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index e52590c9d..27a2c774a 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4108,8 +4108,6 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
   WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
   if (!switch_to)
     switch_to = get_console_process_id (current_pid, false, true, true);
-  if (!switch_to)
-    switch_to = get_console_process_id (current_pid, false, true, false);
   if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
       && ttyp->pty_input_state_eq (tty::to_nat))
     {
-- 
2.43.0

