Return-Path: <SRS0=Mojb=ZO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 3A0C0385772F
	for <cygwin-patches@cygwin.com>; Tue,  1 Jul 2025 08:37:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A0C0385772F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A0C0385772F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751359080; cv=none;
	b=LoeDRokK5SoBElJ7I6pqfRiL9za9dG32LpAxXYP8J8VRp9xAVjkclZNwMfTlr5lS+nPpMXQQGJ5zsX7uD61WMZ0ZQbX6R4T5qz61XEMg2zYgl79RhlSclHLxIc4N4099ojWMPKyR+BHdq/rPmn3dCYRL6Hr/pWW67Tatp8lVJf0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751359080; c=relaxed/simple;
	bh=FVihvUXZwz8saR4/qPc/ZIQ8P42JFbbIzeF6Nqfpg+s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JFBh7xPGR6yhxTV7xTzTLO3Mq+TmrWLXKl20LhLQoICyMvYLKmoJVRpx199iWL0MPIKYv3yrFk92CuIr3SvAYKY81ksq99tpDmvCVVtUikxiEliePAB72FPRaudHLIJLQVsG3WeuB225zWa6OrX1FFrrMV9arT5vxQ4IMW6+z84=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3A0C0385772F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PdD7zyr5
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20250701083757016.DQGT.14880.localhost.localdomain@nifty.com>;
          Tue, 1 Jul 2025 17:37:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when disable_master_thread
Date: Tue,  1 Jul 2025 17:37:35 +0900
Message-ID: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751359077;
 bh=WPADFU7dZydUGm/uOhP6om6+1pQ3dBBcdOyZ5Yd4j/w=;
 h=From:To:Cc:Subject:Date;
 b=PdD7zyr5fX+b+LcHYo5I0sA1RZnym0wGvlPuvC4OFjVqZ6YoP7/31xyAWliqNKffKmt6p8NS
 8mci/daH3QzbJawvvv8dwiIb/6197wT9RAPaJXHwc7Geqi08BilPzfcUG/sOiWLvR7isOwm6vY
 fEHUruv77/bklLQuILWp5+16XCNg/7awNU4OBFztsQy7RZH5afWDZbJL52pwSvOwdTrPJTM48h
 +p6mwyKh0hCVB8mvVWmdu/ha/ZcRnv33vUfj1RYdgvhS0ELIxHsELeF1XEmF8nrNianftjkPac
 5ePWFjGfBu3Ca/+E6Lh6q6VRRIALCkDIsFAiNpRi68qHZpEw==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, ENABLE_PROCESSED_INPUT is set in set_input_mode() if
master_thread_suspended is true. This enables Ctrl-C handling when
cons_master_thread is suspended, since Ctrl-C is normally handled
by cons_master_thread.
However, when disable_master_thread is true, ENABLE_PROCESSED_INPUT
is not set, even though this also disables Ctrl-C handling in
cons_master_thread. Due to this bug, the command
  C:\cygwin64\bin\sleep 10 < NUL
in the Command Prompt cannot be terminated with Ctrl-C.

This patch addresses the issue by setting ENABLE_PROCESSED_INPUT
when either disable_master_thread or master_thread_suspended is true.

This bug also affects cases where non-Cygwin Git (Git for Windows)
launches Cygwin SSH. In such cases, SSH also cannot be terminated
with Ctrl-C.

Addresses: https://github.com/git-for-windows/git/issues/5682#issuecomment-2995983695
Fixes: 746c8116dd4f ("Cygwin: console: Allow pasting very long text input.")
Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 5a55d122e..1ae4c639a 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -831,7 +831,7 @@ fhandler_console::set_input_mode (tty::cons_mode m, const termios *t,
       break;
     case tty::cygwin:
       flags |= ENABLE_WINDOW_INPUT;
-      if (con.master_thread_suspended)
+      if (con.master_thread_suspended || con.disable_master_thread)
 	flags |= ENABLE_PROCESSED_INPUT;
       if (wincap.has_con_24bit_colors () && !con_is_legacy)
 	flags |= ENABLE_VIRTUAL_TERMINAL_INPUT;
-- 
2.45.1

