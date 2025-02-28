Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 34FD03858D1E
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 23:34:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 34FD03858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 34FD03858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740785665; cv=none;
	b=O1tP7/fm7oqhO3BrT1wdmqjO9uqpEiFRfua/FU/xuM997DpJ9Xl8Rd9uzCQkC3bmBFv6WyGots6oLaOVXXPSmqCyoB9KnqpUlJ9vSEbkCV8oWYPGM3992tDbIt8PLFDBG8Gp7ChC+OmncVwZeKm58BcByMi4rWl+GfcUjXifwvk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740785665; c=relaxed/simple;
	bh=EPzCbOc3WNFdicAe06n0vTdtWmC0ZF3f+awnUwXRNek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=HUtlUlAG92qbzUedIbufIYKUiJLPdBAo7fx8Oi16VWaY2xYfpIF/n1Pv4sUCS+LM9hx6W4xLT4qHVkRtNHdaFvXuh/Plk6yLqy1YI7spnboaAtlzsKebVwa4XES1g+N/0qOVGUJ5hP0Z2VyY6tVfYs6TuKgLiOYIj2P3x6Zqhy4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 34FD03858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XMzFfpg/
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250228233423060.JZTH.33121.localhost.localdomain@nifty.com>;
          Sat, 1 Mar 2025 08:34:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/3] Three fixes for signal handling
Date: Sat,  1 Mar 2025 08:33:45 +0900
Message-ID: <20250228233406.950-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740785663;
 bh=84+TnnEcZkIyWk5nlcWbEmNK6F+tO6ZJm2YJZBz8uqk=;
 h=From:To:Cc:Subject:Date;
 b=XMzFfpg/X85IrjO6Cs+shvBDztCQosjRjE6IUkvWEioQLzq2k2dq8QAnWBJ7BtbV7giupIyP
 jgFsbz1s6zxIL/GoLao7MKOEoNiZsgkNjVgbxkIwzkTx3FiMRSh2q70545paCsCjDC46wPFD3Z
 1CLagxJmzHSe9W1WFVfOzjbpbjVUV/dxyP2PEJFXoczEHbCl6PzLLl1k/WAki3yHAU83CVb6ao
 JxXOtWgsbW4xWvl1Hi/YIzRT6T+0JxAarco3QtMBoiHpV/V3kobOeEV3Oqt6ZIg9+3jQXVBeQk
 gxKJrQHfaMpL2eRXKraJIhwc0cAZ47/FOzr+vatP5L3RK7tg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: signal: Fix deadlock on SIGCONT
  Cygwin: signal: Fix a race issue on modifying _pinfo::process_state
  Cygwin: signal: Fix a problem that process hangs on exit [<= revised]

 winsup/cygwin/exceptions.cc          | 31 ++++++++++++++++------------
 winsup/cygwin/fork.cc                |  5 +++--
 winsup/cygwin/local_includes/pinfo.h |  4 ++--
 winsup/cygwin/pinfo.cc               | 11 +++++-----
 winsup/cygwin/signal.cc              |  6 ++++--
 winsup/cygwin/sigproc.cc             |  2 +-
 winsup/cygwin/spawn.cc               |  6 +++---
 7 files changed, 37 insertions(+), 28 deletions(-)

-- 
2.45.1

