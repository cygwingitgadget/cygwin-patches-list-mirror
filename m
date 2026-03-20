Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 1E1F34B358A0
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 14:29:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1E1F34B358A0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1E1F34B358A0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774016982; cv=none;
	b=OCwm1qXTaspvDY6S2H88xvOOG6hwWyfM+oARFER5bnSXUHHGf1DqdUJvyMY4nQ9R+5YtukNKkM83rNZKWQx32LQy1qwj4WQyFzksFg23QK+RWC2bXYcnVo1KzGdwgjYfTdN1jHTQHBUiV5N/g8bm6+UOM4QruZ2xwAoMd+cpy/g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774016982; c=relaxed/simple;
	bh=9FBdQJqw8cMYHIIYeZVtyI6znSSysrCgDuXB1vYgWqk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=GwGc48ddHpExBKROZcMkGqa8iN038g+JsJd6phLVPcLieYOW8wFF2biBUale8gWALp4w5yy18fkcwTaGJ7u6XqZqR+rCWJU7zhlk4NNaynAxfl8o5/yFCkhLYbsUU5ugPIxIroRMw2WRDG2YQtZ4hTJF+BuVEGN7Zb4yUyrRPBE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E1F34B358A0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pQRkPeGN
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260320142937037.CYYB.19957.HP-Z230@nifty.com>;
          Fri, 20 Mar 2026 23:29:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/6] Fix out-of-order keystrokes
Date: Fri, 20 Mar 2026 23:28:49 +0900
Message-ID: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
References: <20260319105608.597-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774016977;
 bh=f4c6J5tNPG921LwfMtU3UxHEmaXj0jObBgbStI0gJX4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pQRkPeGN94swfbDI/J3OQLXKjCW3bpvpzQAkbqjqAp7eJMZGdz4V+IDuIEeT+OYlNpfXlejz
 Is3MIRV/BFExqUiMuQwt6UIyaSuoVQQbCyfDv1Xje2NUIL1M3DjavfNfSD+e8FHm3ximW6ARON
 KA9y/ZA1OmYx+azEwzbFNQpW501rysg1+V/uQfl9CiL1DMb5NVpPJteZ4KFjA78lVXSFMEQd3j
 7HW1JusklBskmEdCOmoHNVzUtQWA71ndd57gKaI9xxigejONOWG18ZBjgooWvs/rpXPIOVaK6G
 +hmU79Wpeumr8MrBA2el2CrNAHbfKYG7VUbu1qGbuWFllWWA==
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The reproducer that uses AutoHotKey provided by Johannes:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
uncovered several issues regarding input transfer between nat-
pipe and cyg-pipe. Most of the issues happen when non-cygwin
shell start cygwin-app. This patch series addresses these issues.

v4: (changes from v1, v2, v3)
  PATCH 1/6: The patch reworked from the first step completely, because
             understanding of the root cause was incorrect
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

 winsup/cygwin/fhandler/console.cc       |  92 +++++----
 winsup/cygwin/fhandler/pty.cc           | 256 ++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  10 +-
 winsup/cygwin/local_includes/tty.h      |   2 +
 4 files changed, 254 insertions(+), 106 deletions(-)

-- 
2.51.0

