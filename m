Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id D32404BB3BA5
	for <cygwin-patches@cygwin.com>; Sat, 21 Mar 2026 11:36:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D32404BB3BA5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D32404BB3BA5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774092984; cv=none;
	b=b/o4cZDdXesmXDobV42iaFNV2rwvdJvsARbFW4aTVW77iA+Cx4QpqlzK3owx5UlLB1jzkmGdDYugbGGHgR1J4fhrlZ/WFf5XYU+sd5s1L3bGHwVW/abD96NUhRJbshrq7QBLUBrqI0ACf4bX+ocakr1d+UzeQBTm0TcVnRbxcHg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774092984; c=relaxed/simple;
	bh=rcLHcz5qKIqn+MsF5tv+Az8fSj/rQq23t8JkK8f9xho=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=v1lMbWfY4XTVWzFDkwJOr4zzo74PLLWKyvF41CKYRC0N9/tarkEXSLH3HcwoQD346avakFBT9D22270ZCi5ms0GLCgDoB+EyQuK+uCxcxbzbCgQ/qZYIvEjbzcFZy61/AHgH8GlkxziPk9/Cd9j7wMHTe6Rg+i0TxkdWZ10r0jM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D32404BB3BA5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Fkv/My+p
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260321113621872.VNQW.36235.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 20:36:21 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 0/6] Fix out-of-order keystrokes
Date: Sat, 21 Mar 2026 20:35:25 +0900
Message-ID: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
References: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774092981;
 bh=OT80MRhoUj2D0J/zEzpYrMjxg6CoGiepBy7HD0t8m7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Fkv/My+psiQ18Br29auMb9EodMxOdjqq5iHqLuZJnnH75xLTqMm2d/QvMyHxdTLsjIYnjVS6
 OuNnUumGERQvvWtlgL1ASLzBA1KRNTxkaQueDzkd0opQWoj7XMy3P2YYGlc3C8riHOaRhdqF0Z
 RrBg1GG/bDGH57l/LXBCfVtJ+3x2JoK2hUqJeqxPboKz1+3Fk390qRM8bYN24bxzcEMwDnOJK5
 SoA8rtbF7mE+U095WY0CkfAfAg5GUYKrGeA/BUHJvH5mIBMNaorgWSVnvv+Fixe0wCNoyNY54K
 ZGtVqiL++hfkGvDMs36JjLZT0WFdBr0qJm83U5cZJBKZ0XIQ==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The reproducer that uses AutoHotKey provided by Johannes:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
uncovered several issues regarding input transfer between nat-
pipe and cyg-pipe. Most of the issues happen when non-cygwin
shell start cygwin-app. This patch series addresses these issues.

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

