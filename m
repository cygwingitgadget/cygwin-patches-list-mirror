Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 06F453858D39
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 23:09:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 06F453858D39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 06F453858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740784153; cv=none;
	b=QKWXJw0eUWfaRQVRm5PpoqaakvGlbNRE2JBjVh9iBfzV3Xud4tj2jqcrwVJf8k83zufQfr7UYyFQo0GbCl+IDz+XqMauZcaOPJoV1TYQP/ufshcqcmyOfq0OjNj0XNkjAcwzcahoZL2T6OHSVpiCLCeldoct3NPxhNOImFjxStw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740784153; c=relaxed/simple;
	bh=CAQA8mk2Dn2ZXhLMu0aIcF+3pKyv7+Z3r7A8cF5sErY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DP9ELl+zwhqr2cT3VOaq3zRlo3AS9UpvfAMZuhZ8DoEo1hXgH+r2U90jeggbNR2ObRgIg9RLxnTEd45NDxyUCe10xppU17SVLlQ/xbQ85UlUb4RKxILNvs4qTyQ1hoRHLAYeNp0Rcd1RGaLEzYa+LF3kAXGktCQ2+JouvbhkUKU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 06F453858D39
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=e6f3yzdD
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20250228230909692.FSWW.48684.localhost.localdomain@nifty.com>;
          Sat, 1 Mar 2025 08:09:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/3] Three fixes for signal handling
Date: Sat,  1 Mar 2025 08:08:41 +0900
Message-ID: <20250228230853.671-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740784149;
 bh=q/o4TaB+nflBQUXa8iSGKMKnSxoAHxBhfmHooXnX0mo=;
 h=From:To:Cc:Subject:Date;
 b=e6f3yzdDBSGSlr0AcWrNpH/na+jXGEkEA1g5f+OrYkLHG5oSgwFVXNwVXmW4A08AyQxNhGO8
 eFp8UzrNVaJCM7F0RaqLxpYdpHcGlxdV4dERzsTKuEBFaf0nWTVNYZoOWOFk3AmCNVPOeAPdcF
 fvH9J7AFA3ATm60HGHvfOiTT+hY2NLFx06Y1n31KYJGMs0nXqQPSpryQJPf+5Iy3b6LJ0pCxCe
 PmOFl/doyv18IHUbE0sshWqOfuDgNpztOKBPpbjxQscNQfIytEwEiMy1smedeTAIwbqq/dE80K
 yFQtokGYWYXJDf4L8QqzVUjbRBpGbhVhjb688woBO0VpPUhQ==
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: signal: Fix deadlock on SIGCONT
  Cygwin: signal: Fix a race issue on modifying _pinfo::process_state
  Cygwin: signal: Fix a problem that process hangs on exit [<= revised]

 winsup/cygwin/exceptions.cc          | 29 ++++++++++++++++------------
 winsup/cygwin/fork.cc                |  5 +++--
 winsup/cygwin/local_includes/pinfo.h |  4 ++--
 winsup/cygwin/pinfo.cc               | 11 ++++++-----
 winsup/cygwin/signal.cc              |  6 ++++--
 winsup/cygwin/sigproc.cc             |  8 ++++++--
 winsup/cygwin/spawn.cc               |  6 +++---
 7 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.45.1

