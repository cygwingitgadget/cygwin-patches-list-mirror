Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id AE2E54BB58E0
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:05:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AE2E54BB58E0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AE2E54BB58E0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774443905; cv=none;
	b=jHiNbProNvKmUUMvnqTe+O68RHNp/SiX5/HOjiKqnV8LaefVKhKCxd0UjadlRBwN/0TK86vSfRZ4AoWkbDA2rxObo+797CSg+E73/U+mXwoufmtlt3kLg3ZRqBhbnrOR5DIFIIt1cmdacyRI2nXUKL2oVhT9fGMkUqkz1c1TzS4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774443905; c=relaxed/simple;
	bh=D+0K2wHd1i1/K+a1OWDrb32me07UBRcnzjFSta9g3DY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OJPCnnR7r6B2syHvF5KENo4Jk97zRsiwWY8tcvWoM6GvVFd3RQWWyOB+7nZUBdnBoe5h8/OxJKDf+nywxFuAWjq7G+xiAzLe+hrehiC3w9miXed7fTbUesjtVtRBsD0nR1o508qU8+VIFWfzIz7HtzQHfhTYFNln0o/OoIqzKqU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE2E54BB58E0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Dte4zCr7
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325130502807.TUAX.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:05:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v7 0/7] Fix out-of-order keystrokes
Date: Wed, 25 Mar 2026 22:04:06 +0900
Message-ID: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774443902;
 bh=Y36Ns7ddDvTduv33GzTniJHSX/XkEA1InIkibCzt03w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dte4zCr7QHB6qNnIiYjmzeHxyMj/XI5fovhKDyKlIfHc00jPSFEJN9kPuTQe7xKVIUX7oNYD
 n5OwxPUOBpNZtYP3cHXNL80yk1FjIlbpaDJN5y0BoBvOmSZrvVq9kqdlmdV+74wkCyvwm6QIAl
 4lpa99G7O/fVEsr+KvK0NEnPz1CoYassQCq3zhAATjPHfsIurUH7FQdKnqXWDV2HyyO+6N1oyq
 va5/pZ7QhMSjAasJH12y6Kw7f4o/l/A1Q3JKEWOLughXtILEQV4GPOy4DO0u2GVM5Q6eDIWIp8
 1hEFjHNroo21cfiLVQfxa96AuwgRTgMsdd1/exNS/s4LzAtA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The reproducer that uses AutoHotKey provided by Johannes:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
uncovered several issues regarding input transfer between nat-
pipe and cyg-pipe. Most of the issues happen when non-cygwin
shell start cygwin-app. This patch series addresses these issues.

v7: (changes from v6)
  Add 7th patch: Fix another bug causes out-of-order keystroke

v6: (changes from v5)
  PATCH 6/6: Wait for pcon_start_pid as well as pcon_start in
             to_be_read_from_nat_pipe() because accept_input(),
             called from master::write(), also calls
             to_be_read_from_nat_pipe() after pcon_start is cleared.

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


Takashi Yano (7):
  Cygwin: console: Fix master thread
  Cygwin: pty: Add workaround for handling of backspace when pcon
    enabled
  Cygwin: console Use input_mutex in the parent PTY in master thread
  Cygwin: pty: Apply line_edit() for transferred input to to_cyg
  Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
  Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
  Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()

 winsup/cygwin/fhandler/console.cc       |  31 ++-
 winsup/cygwin/fhandler/pty.cc           | 255 ++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  10 +-
 winsup/cygwin/local_includes/tty.h      |   2 +
 4 files changed, 229 insertions(+), 69 deletions(-)

-- 
2.51.0

