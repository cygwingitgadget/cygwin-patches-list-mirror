Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id E66CC3858C50
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:55:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E66CC3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E66CC3858C50
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611340; cv=none;
	b=RZ7YGupoO8o9KOXzpDJPUrn66Wx5LwOjpipOK5n5WOcr0j9WS0eO67xsafR5ZujlRnfwPjqmzdTgQVeEqJxhX8Eq5c6BrW//HlvX0gaCNfR5m3BudaUFsMJ5cNXT+20Q45Wz6XcTHZtPAOpZZegaonUseTqpnVbwWLoUA13cEq0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611340; c=relaxed/simple;
	bh=lsY7r3DYkdrPFFPxAkCzq1WoBCvkALZtsHZ1Zo15vF0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JzcrawEpWXvB62CoieswDgaqc4nkP4iqjntGD8StOBYdQQvV0WyrrPQHlQWm13JpNpwLOIp28KvtlM88A2rOG+OO83QuI+9+pt7xSRTD/znO8U3RMzJIzAwVHYyirrCWT4COm+hIg8vJS8gayohpoZMRgMMHPM1qvERYn+1Oz0U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E66CC3858C50
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qM+2PBp4
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085537053.NQUY.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:55:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/7] Fix issues when too many signals arrive rapidly
Date: Tue, 26 Nov 2024 17:54:57 +0900
Message-ID: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611337;
 bh=EdMN5qroJqCNuU/JVe9jKleMHyU4XSyBnrcBsskVyrU=;
 h=From:To:Cc:Subject:Date;
 b=qM+2PBp40GrQmGNMFTmABYnHM8lPhllXzCAv8pYH52S5s0/jBhjd04YTohzwSb7z24ftZlX9
 p/UKRvmLBgzt3PwGSV0SPcYQt44tXegMHs5HSoMGVLGUvLMSHBoehkkzCdEdnospGMZcSBZoND
 G57Adf6wD+WJJaRE5SHivLaHIJKy16iYXe8RUWtvFfJ6w7qBGJC0zvhH31BcIH0EbaLHkpNPUV
 a6XhYjz3MIzjgEY6SJeaCx/v4hceK/jc6uTWjIrmI+3tSy9W2SAAaRL0IiZ400xH998lxgVRaf
 jmPkd8Av8N1jFbCnPAdJa2KY2p/8C7YfclClObC2bceJf8cQ==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (7):
  Cygwin: signal: Fix deadlock between main thread and sig thread
  Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
  Cygwin: signal: Cleanup signal queue after processing it
  Cygwin: signal: Optimize the priority of the sig thread
  Cygwin: signal: Drop unnecessary queue flush
  Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
  Cygwin: Document several fixes for signal handling in release note

 winsup/cygwin/local_includes/cygtls.h | 13 ++++++--
 winsup/cygwin/release/3.5.5           |  4 +++
 winsup/cygwin/scripts/gendef          | 36 ----------------------
 winsup/cygwin/sigproc.cc              | 44 +++++++++++++++++++++++++--
 4 files changed, 56 insertions(+), 41 deletions(-)

-- 
2.45.1

