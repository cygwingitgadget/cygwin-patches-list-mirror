Return-Path: <SRS0=l0P4=FO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 9A5004BA2E13
	for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2026 20:08:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9A5004BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9A5004BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784578092; cv=none;
	b=wMN4g8R6gFykWgoML6cOw4vKDJ/Bfl0r6pREYVncgnB+8m0gEZtG+WOoLVLhjhpIrjEbOaDL5FQTjGccXp+BLW2ySoKsJMW4aJQUNiwFcBaO30fsLbtg+k/3goZ2yuURPp2Bw8ZtD3Pkj5hmvm1gfwQRUUjL+UylWocTXtLsyk0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784578092; c=relaxed/simple;
	bh=mYL+GT4wlDpbE49V98gy5SVva9WpgGXYcBpos2EYeoE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=D/S2/0TJ3aX8Pew4rcBuaJ350Waqkx9yyhTvonrjvYoActdkpFG7IX0hSHMgmW8p4K9zyTZKudV6Wjw840BoxiLlZQUtdcPaInQB8bIVxjTK/claf52wE9WCl8nG3RttqD1J4+m7Y8IQBUqcEXzHGgLt07I+T0v+tdzRPJVCXGw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b5ZYCJmG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A5004BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b5ZYCJmG
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260720200809858.BVFK.44671.HP-Z230@nifty.com>;
          Tue, 21 Jul 2026 05:08:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix cursor position on new nat app in existing pcon
Date: Tue, 21 Jul 2026 05:07:52 +0900
Message-ID: <20260720200802.436-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784578089;
 bh=45Wu9XhK6n9XqP0idjzADMajg8DwjgytQ9ecea/3HHc=;
 h=From:To:Cc:Subject:Date;
 b=b5ZYCJmGyu6tqfkFKlQ5oh2GcB9JDON3hjsJmNaFgiZbKH8EfmEbzhew0kM7TG4B8ZFRTFro
 4/3Td1a0ZOuQh0BVlr6TqNXojTX6Dowo4UVNwkI5uNx01wjioMnrFvLlnEYUQCccbK/h1N55uc
 Q2D6veRosiQWEx4dwg9TN/q/TLvxexiseVrXAcqV5TaB6g4ZWXVP57SQrd+Rka01dMeXqjVteY
 TADmk7kcVPtyprETh6P2kyGyMIZZJwm+WWXCB+rLFgf+JsMFJJIFmrhZhbIhxt9+xjJczOL7Dm
 Gnd08CoxBUshAb2svLRmkFkeobH9d6M/XPZS4+SJpUlx1TmQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the steps: cmd.exe -> bash -> cmd.exe exhibit broken
cursor position even with the commit b34394d456b6 ("Cygwin: pty:
Fixup pty state after a cygwin app exits").

This patch sets req_fixup_pcon_cur_pos also when reusing existing
pseudo console as well as req_xfer_input.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index f3df55f34..a100c868e 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3850,6 +3850,7 @@ fhandler_pty_slave::setup_pseudoconsole ()
 	  WaitForSingleObject (input_mutex, mutex_timeout);
 	  get_ttyp ()->req_xfer_input = true; /* indicates that this "ESC[6n"
 						 is just for transfer input */
+	  get_ttyp ()->req_fixup_pcon_cur_pos = true;
 	  get_ttyp ()->pcon_start = true;
 	  get_ttyp ()->pcon_start_pid = myself->pid;
 	  WriteFile (get_output_handle (), "\033[6n", 4, &n, NULL);
-- 
2.51.0

