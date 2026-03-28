Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 299B54BA23D1
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:56:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 299B54BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 299B54BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695404; cv=none;
	b=I0gzlt//byBhIk7uSFIrEVOpnhU79mzK1O6+V3tCxuDcafQwunRNHQtZRLOaAH7NHjSbkpBdXL2V4MIYm5cdI+EYy/+2FbDNukVsSMyBSfUVRQ5kjM4B40gCM/K0od1jG033FAaXRaaFwsjUAIa2CdfOTF9RbdBh046Bifp+hwY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695404; c=relaxed/simple;
	bh=bolixIfXGbvlUfRAZohqVFNNMbXDNaUU9TJ4LJJ22C4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=oU4ZN5KRKrLRw6/xqUc8DvqlrEVP9n5HS9z4lUHxIrL2mPoYJCFNdrs7hUrSeXT88g3UY1xRjVkT5CIZk+SZnXewmwBYCjdQquCIi0aDjaX5aT+9H5xu7OEw4jGZAgBlCzJqPR0XyYCPKrBJccdK140Q5pgyAp3cL+gwrFcInTw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 299B54BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KcWbOhdr
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105640581.LCZI.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:56:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v8 0/7] Fix out-of-order keystrokes
Date: Sat, 28 Mar 2026 19:55:44 +0900
Message-ID: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695400;
 bh=XO1M8T7pc/ND3H8iacX5+/WQs3mSidYAkuShCsVONls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KcWbOhdrjuTb6eYyOoV50H2G5Bi1tEE5zlM/Y5PSg6V7AD0dsgQy0pvniSEjJkOQGOFkCszo
 E6cn2JQKwy5wY7jks/u2PbxQqTtrmg6yGLCTsl/gMfjaJUBRId+Ob2LNg9ynUIIFbqGVawfb63
 fnQ7D07Iocq8NmZMbz58iP2RSJCspHny2PMXSS+q94sclAS86u6DqRhibBxcMGQv8q1Bpx+dVp
 NcoHUdGyHeiwjC9e5lR48+XgcHPJbytRCzt2O60DHHLH1bCae3Q+u8Xqbwrx355MfIhWAbXfXa
 tE/WCu1MfwwaSLekJ4f4oPJ1nE76aZJ3QZKjQ/Wp80C3tYaA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The reproducer that uses AutoHotKey provided by Johannes:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
uncovered several issues regarding input transfer between nat-
pipe and cyg-pipe. Most of the issues happen when non-cygwin
shell start cygwin-app. This patch series addresses these issues.

v8: (changes from v7)
  PATCH 1/7: Replace the commit message.
  PATCH 2/7: Replace the commit message.
             The handle h_pcon_in to retrieve console mode is
             cached now to prevent calling OpenProcess() everytime.
  PATCH 3/7: Replace the commit message.
             Add NULL check for parent_pty_input_mutex.
  PATCH 4/7: Replace the commit message.
             Use tmp_pathbuf for the buffer to applying line_edit().
  PATCH 5/7: Replace the commit message. Add short comment as suggested.
  PATCH 6/7: Replace the commit message.
  PATCH 7/7: Replace the commit message.

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
  Cygwin: console: Use input_mutex in the parent PTY in master thread
  Cygwin: pty: Apply line_edit() for transferred input to to_cyg
  Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
  Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
  Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()

 winsup/cygwin/fhandler/console.cc       |  32 ++-
 winsup/cygwin/fhandler/pty.cc           | 280 ++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  12 +-
 winsup/cygwin/local_includes/tty.h      |   2 +
 4 files changed, 256 insertions(+), 70 deletions(-)

-- 
2.51.0

