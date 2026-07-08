Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 85C934BA2E04
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 13:16:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 85C934BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 85C934BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783516590; cv=none;
	b=Zo9AJMlVpwwina1SUTIn+XwSU69qd8wHPZhF0w/vjFkS+iiy4dI4nZZ4s4chcTx/PiIqOGg66gj16qubzVuGL5sxqvp5lLCxoqH1BGPih2x4rB39hp42WEsZZgY9ijYLRqhQOkAe78cwzsRGiy7LDV0ZSOsAG31iiklc95fzmjQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783516590; c=relaxed/simple;
	bh=X5Ynq8xa7iDVNnUXsaYycRx1nEaygvEAfcYGwzhDAbU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vcYSuLVHbL2PRq29eSFtu4MgBzHY6+rMQ2JC9r0eKxnNtlQMDAnqCWgquWWoqJw1UE9k85Ewaf9NQQwAKOT7N+02qg6YimVfR4OQ1fkno1yW5EwsOlF84Ci0KdIzx+CozqJRyTBntcvvDA9z6U+x8sPrGd2L56N++b1zH5383qo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VM+E07Mn
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 85C934BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=VM+E07Mn
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260708131627552.IXHD.117312.HP-Z230@nifty.com>;
          Wed, 8 Jul 2026 22:16:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix nat_pipe_owner_pid when gdb runs non-cygwin app
Date: Wed,  8 Jul 2026 22:16:06 +0900
Message-ID: <20260708131618.2259-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783516587;
 bh=LGchjp173sK1DbEjRMlvHi9cOy0Q2LgJcqjn/38Aw/I=;
 h=From:To:Cc:Subject:Date;
 b=VM+E07MnI3zIljoKHwJ7di37DDuQo1rBLzty6z68dOZYxHH/09DZ7AiqfBRvazEZKHXhhM+l
 r5kvNGELGstsaaDxR/bwDrjcZY1/SgbMcdQNdx3nsVRxYEbLVDlhLjzhA4PvQ06s8gxtrP5tf9
 nZQfFnp81EMHsg3gQqP23zcWcf+A6xIN6F5p+VWMD7mxhppad3fnN6acG4v95puuMDp4F2ed5o
 Ls0zjQv2qmL4voCkPvFLOpMhtWcSMMsEuzg1EJwObcJvAES8EarpeID1d+u0qd9LYRjUS9daAC
 WkfGIBWfiUG+AOelp4Ded2LhI9+dKqCqCfp/F7LGeyolOjPQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, nat_pipe_owner_pid was wrongly set to 0 when the inferior
of gdb is a non-cygwin app. Due to this bug, running non-cygwin app
repeatedly in gdb causes unexpected crash.

This happens because previsou code in setup_for_non_cygwin_app() set
nat_pipe_owner_pid to exec_dwProcessId which is correct for the case
that the caller is the stub process of non-cygwin app. However, if the
caller is gdb, since the owner should be gdb itself, nat_pipe_owner_pid
should be set to myself->dwProcessId.

Fixes: 1e6c51d74136 ("Cygwin: pty: Reorganize the code path of setting up and closing pcon.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 1b453a499..37266d8dd 100644
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
-- 
2.51.0

