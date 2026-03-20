Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 120EF4B9DB5D
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 16:01:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 120EF4B9DB5D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 120EF4B9DB5D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774022512; cv=none;
	b=ohfGz7oSlt42ouZeIF87fQNeRZL53LVeXABWpV1Ivae7pN3si4IsW5T9+b3b4WgutlX4Tm9mS69PR1XpNdX3vVrNoT0cpQUHavG4tBymuVvbYvSCq/ZN6W8+6oDhQL2F6Ky9etVf88kj66zh1L6/Wf/0tnlOK+1T/FrJpdfmFkA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774022512; c=relaxed/simple;
	bh=oNHiRNFn+b2GmArWQvrkr4xpxXGXlyp84pAGEUu86fg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=tlo8Y+GYtsR3qsbTxL9lrUqZmNgjgdNAmAF4wymZEujsvq3TgKbOapRTm+z4IN7sZvG0pHbNPq9mvEIZmWfjGCh3ZZv977z9Ks+edkCvO5d4XCE4hBLu4Go1hQlcO3+guZwxhNNZHzoYiSn/zG+tJt4jGVsz59Kw66lJOKxKFaQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 120EF4B9DB5D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BXG7BYaM
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260320160149100.HLQL.14880.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 01:01:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 0/6] Fix out-of-order keystrokes
Date: Sat, 21 Mar 2026 01:01:04 +0900
Message-ID: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
References: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774022509;
 bh=2fJynIDFuHlp9+tHg3tM2iCEd6FJYfn7gEUic9Hj55Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BXG7BYaMqFV7Qftq4Oge1DIiOErOe85l7L+SYANlWdliqxjgJxgVdn0BL9xPTeL3d1r05D1N
 wSFporJSYM+fmOBwpgPib/bq1GviLUwRx7sDiWkDgbdMUHpkEDSsIL5xUw9+hv43BAAB7Kzall
 mRTWTx+pV/y2Ektpx8uSstSeBRHVwVqtoq3Ilo0ohgYZRn+FUkx0VYczRiSKz576SoDPfO7lhZ
 ojfFdFOCkSyYUMSE6JSPBjRTzIbSjhx++JGMiqvBpaXxzTOiJrNSsUzBMIvEN1Dp0RDkusD1Pc
 qD5TlMF9eSllu3WKK5exIa3uS/9M2QjUIl5iQkV2dD+ktpRA==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The reproducer that uses AutoHotKey provided by Johannes:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
uncovered several issues regarding input transfer between nat-
pipe and cyg-pipe. Most of the issues happen when non-cygwin
shell start cygwin-app. This patch series addresses these issues.

v5: (changes from v4)
  PATCH 1/6: I was wrong in v4. The first attempt to reorder (fix)
             is necessary after all to avoid incorrect fix.

v4: (changes from v3)
  PATCH 1/6: The patch reworked from the first step completely, because
             understanding of the root cause was incorrect

v4: (changes from v1, v2)
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
  Cygwin: console: Fix master thread
  Cygwin: pty: Add workaround for handling of backspace when pcon
    enabled
  Cygwin: console Use input_mutex in the parent PTY in master thread
  Cygwin: pty: Apply line_edit() for transferred input to to_cyg
  Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
  Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex

 winsup/cygwin/fhandler/console.cc       |  31 ++-
 winsup/cygwin/fhandler/pty.cc           | 256 ++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  10 +-
 winsup/cygwin/local_includes/tty.h      |   2 +
 4 files changed, 232 insertions(+), 67 deletions(-)

-- 
2.51.0

