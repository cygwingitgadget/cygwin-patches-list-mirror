Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id DF63A4BBCDD1
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 10:56:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DF63A4BBCDD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DF63A4BBCDD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773917784; cv=none;
	b=Hd8s0OeZKlKX05T00nbvJKk0QuNoAlAAtjnFXRW5EruDG2MKFROjMk4JeauTQJmX5KCAp5vo0q5yfOBcN053YUGfMnG4Gj4XdJ88gJkVjff/T/unLbRTPrCPf1N38Nu/ZFojp40oVIh3+iezlL9Fcj1P8GjaOqiFKj5VQvLd9DI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773917784; c=relaxed/simple;
	bh=9Os0F6yuBdJt3mute752hKPMMG1uNW4f2VesnfYT8c4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=EcI8rCJH8QNrWEu8Yefc2lO/lZz/XI25/4PiD3AXvyfVimKMA+f2ubBkUzaM3UiDg9ktq34b6GklbmEIAwqGQqF3xvQdKS/4pV9xXedPUnJzgtj+mHITm696l+etkypFcqeg7sWYVnL7WIR2yjxbeqgcGmUGZPoKe9GpdbpvccI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF63A4BBCDD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=U7SmHMTN
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260319105621964.LPUX.19957.HP-Z230@nifty.com>;
          Thu, 19 Mar 2026 19:56:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/6] Fix out-of-order keystrokes
Date: Thu, 19 Mar 2026 19:55:14 +0900
Message-ID: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
References: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773917782;
 bh=569DnHAcTuY9GfOryCJvI2syBEY+VnfIdi4cHsLmXzI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U7SmHMTNwGP8KQfc2Ddhz2kJbfxrDR3qEMKdJ1Zu/KyUJJKtR3F4l6HSqLhtALIQnqh7um6P
 2jXaOWAO0rMymWPKOmtx4Vz2WHwxG8Aj86YXPI89q8rHOYC5LfWPQBVbi8NWiR6zTn4vQoILBc
 ZBQng5ePPmHQ+xXQ+NBIh9rYPlkQ65F1dJb2RlxPI52+HRrctBR4ORMCOtY40XX19Az4PT2xkI
 e8EvJ4o7W8mD9pXDBKWE9btAc2YAwWYjnF1NMUWxqUW3OU5rXFkaJg+JWB9P9rIfLk1mK4Hs2v
 Ztp0VGJDesnNdB0WCPu0s51MbrDJwquLs9apVvbdsQ1BaUpw==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v3: (changes from v1, v2)
  PATCH 1/6: Give-up input event nandling when input event sequence seems
             corrupted to avoid infinite loop
  PATCH 2/6: Drop pushing input event of backspace by WriteConsoleInput()
             and adopt another workaround
  PATCH 4/6: Use WFMO instead of busy loop waiting for flags in
             master_fwd_thread
  PATCH 6/6: Check WAIT_TIMEOUT rather than WAIT_OBJECT_0 in
             to_be_read_from_nat_pipe() because mutex can be
             acquired if the return value of WFSO is not WAIT_OBJECT_0,
             e.g. WAIT_ABANDONED


Takashi Yano (6):
  Cygwin: console: Fix master thread for a pseudo console
  Cygwin: pty: Add workaround for handling of backspace when pcon
    enabled
  Cygwin: console Use input_mutex in the parent PTY in master thread
  Cygwin: pty: Apply line_edit() for transferred input to to_cyg
  Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
  Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex

 winsup/cygwin/fhandler/console.cc       | 128 +++++-------
 winsup/cygwin/fhandler/pty.cc           | 256 ++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  10 +-
 winsup/cygwin/local_includes/tty.h      |   2 +
 4 files changed, 256 insertions(+), 140 deletions(-)

-- 
2.51.0

