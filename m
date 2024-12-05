Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id D75E63858D21
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 12:26:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D75E63858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D75E63858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733401590; cv=none;
	b=gPk3QoJxAmxfuXPm+UojcOSxNopTYIz7HZzfyntB1LQmpXgoBh635fkUGhfwCUGN+Xpb+OgcztMqO2vrz5XjZGA6AsNZSy8TfhM0OAZmn78wAfIexWYADBstsvMVHPbXvNEbGalTbJ165eBmXz7+Mby1kI/Ud8f7u62BkImZ6HY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733401590; c=relaxed/simple;
	bh=iFLs0ZoFJF5bLqbbfWMi2WGivhxnlQV3YrZ9zYnb4is=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=QmC3HO61xXRf7813LUF+VG5xIzG+2u5Dg5wZs2trGKI0g2e3ccrc3rP2uQF8vj8xVkzd1rPRvI0iUm/j8RwOwxYKJKQrajPMNyIUs60OaCpJ9DT6eoaVNzOvgjIpY9LTz20si6aTtWgGaSoseXt/niSnkxE3F/vo2GOOASGoO6E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D75E63858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QPw7kh+y
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241205122627768.PQFD.12429.localhost.localdomain@nifty.com>;
          Thu, 5 Dec 2024 21:26:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/3] Signal patches still necessary
Date: Thu,  5 Dec 2024 21:25:40 +0900
Message-ID: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733401587;
 bh=YStSuaZv4p6usHq/L6Y4xWEx3w+mN6CJf3tkLtcCmVw=;
 h=From:To:Cc:Subject:Date;
 b=QPw7kh+y60BJHDAo1NhRn9xVLrfxkFLsi/yK2UbXNlPmWRhANBKzRXLX1dnEz/oAeOSd8F6z
 lRcOJFQDDouQkBa0EUEfgEhfwsxr+cYF191a0Irh9/9a7wt75bDcXARq9+KEiZDKLuUhzbttKc
 ZgzXSbYs1RpNiau/xcCA7XRi9A0EZof+wtAcJ6RoYAhQE07zr3q5IpG4cozE4Daa5uBtGDSCw3
 ui7Q/ICyf9cDT3nJ3z67bEpwUQc63ZMGIu811b7DNZN0cFDQNXF9USU8lZos2HXUMgxmymWCAi
 AG+Va7kcPfsaBl8UhVqJgnb8lxn2T4KZnXGIadfBHtQULfqw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: signal: Remove queue entry from the queue chain when cleared
  Cygwin: signal: Introduce a lock for the signal queue
  Cygwin: Document several fixes for signal handling in release note

 winsup/cygwin/exceptions.cc            | 12 ++---
 winsup/cygwin/local_includes/sigproc.h |  5 +-
 winsup/cygwin/release/3.5.5            |  4 ++
 winsup/cygwin/signal.cc                |  4 +-
 winsup/cygwin/sigproc.cc               | 72 +++++++++++++++++++-------
 5 files changed, 68 insertions(+), 29 deletions(-)

-- 
2.45.1

