Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 6A0BE3858D37
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:16:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A0BE3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A0BE3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537010; cv=none;
	b=aVehOtMIdLimj4fIE3EPEE+OBEU7Xq1BW8TZ3rPp37EeY2X+gN5TK4Wg/xBCD8pSGVqXpNg7ZzD/kaMLIAaXBoUuwvYHm8nctfAszVreJZrbSsNTJejVZ1D4Xvl2sZxTWlwJ3fReiTzauthmGlHosRHJF0xTmye9DejHTl8x7PY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537010; c=relaxed/simple;
	bh=nDcnJw2d2Pq6trS6ht7ymShHgYmj8YLTvyVFjWRfYfI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=IvSijtFwGoxn+EJPrCN/ieVyVQTdDnBwotQfLC+Wr9OE5GcTWuUr9OLmsohIb47vQnpn9situx2XLny2z4fnM8W6LmSOPoig/g0thKU2lHiNnVoGF8ptg9En87QpXjkLGJRUUYLBtlTd4MmuOjGzyV7dhN46vGuoC1BkndMQhJA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A0BE3858D37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gR4jnTtW
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121647137.KEJT.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:16:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/6] Fix issues when too many signals arrive rapidly
Date: Mon, 25 Nov 2024 21:16:16 +0900
Message-ID: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537007;
 bh=bXP3tyckc/Vnr+uPy5+7wx61IW3iyWyMxJvGMqPNRLs=;
 h=From:To:Cc:Subject:Date;
 b=gR4jnTtW3XCiKeLQHrjCqgwg76ZyHaKtl4m3f2RWzG02YuPiFxxwxVkZVjt3gHtK/Q0NXS56
 WRxg57mLSpDlBjYHHp/u0pMkDlppv7wHDBbYU63keoNsgrv+FISggpcrW6vzLIPPFB8O9oZ6Dh
 +6uKbJgTFU5e48xlsILKwDCuA3w2aysnpCVycjMd8wKztoTnZo2Z6qOg2pJSVE0kQOKOUoAOWW
 TZMegd+3I9bX00tZstRYBUhv6cq9iOyAuSbLFfbQ6WiT69xw4gDyBC42RZsU1gjO20ihJHp09q
 0DGJrXI9QL66esGIiCSYI5bdqhRvAksqBgHgdGSRM7Ba2WCA==
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (6):
  Cygwin: signal: Fix deadlock between main thread and sig thread
  Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
  Cygwin: signal: Cleanup signal queue after processing it
  Cygwin: signal: Optimize the priority of the sig thread
  Cygwin: signal: Drop unnecessary queue flush
  Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()

 winsup/cygwin/scripts/gendef |  4 +++-
 winsup/cygwin/sigproc.cc     | 26 ++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.45.1

