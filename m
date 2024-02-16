Return-Path: <SRS0=PwhG=JZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1017.nifty.com (mta-snd01012.nifty.com [106.153.227.44])
	by sourceware.org (Postfix) with ESMTPS id 187063858C54
	for <cygwin-patches@cygwin.com>; Fri, 16 Feb 2024 09:27:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 187063858C54
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 187063858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.44
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708075665; cv=none;
	b=TGJaCcrwmUEQ1ouVgiSm2KYF0g+NALykvFER4nOr2tUuzgrWMuvDCXnRe8WrOzX3Og+qLePmnJVavJK1cROpKBYWJJX4yVSGjLF51vQE1M03GTvuDABFakfvSHKrUAKi8VyTSWut/hooNeQpOA2DKU01DFwuDe+mVUbjA0j5hHk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708075665; c=relaxed/simple;
	bh=Tphf2lDSpFVJGFbyME+V7NIvl+njqTwE4ZJfELvdu2c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G7L8tocYciwQfC9Kjmk3PekUb9eHpTu1EGruAymL1P6OFGwCwtx3TamfW/zhpMBw6pMkdjwzCYAYfeyYD4QY8/RTG+MPi3jQUODo/7Xb69DrpCEkgnYUgB2N79i10kwoLI/a6etmzzsUfJR0bHddz/x+sUBJybKLkbNp+4KqOd0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1017.nifty.com with ESMTP
          id <20240216092739808.FIUF.70310.localhost.localdomain@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 16 Feb 2024 18:27:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Re-fix the last bug regarding nat-pipe.
Date: Fri, 16 Feb 2024 18:27:13 +0900
Message-ID: <20240216092722.1585-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: f907b5f405a3 ("Cygwin: pty: Fix failure to revert from nat-pipe in disable_pcon.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 27a2c774a..9d7ef3c9d 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -4103,11 +4103,8 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
 						DWORD force_switch_to)
 {
   ttyp->wait_fwd ();
-  DWORD current_pid = myself->exec_dwProcessId ?: myself->dwProcessId;
-  DWORD switch_to = force_switch_to;
   WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
-  if (!switch_to)
-    switch_to = get_console_process_id (current_pid, false, true, true);
+  DWORD switch_to = get_winpid_to_hand_over (ttyp, force_switch_to);
   if ((!switch_to && (ttyp->pcon_activated || stdin_is_ptys))
       && ttyp->pty_input_state_eq (tty::to_nat))
     {
-- 
2.43.0

