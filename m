Return-Path: <SRS0=vCDf=52=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 7777B3857830
	for <cygwin-patches@cygwin.com>; Tue, 18 Nov 2025 14:09:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7777B3857830
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7777B3857830
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763474993; cv=none;
	b=g0S5JY+GK+pfx8fYLc5K3O9+0/qDw9SwloIw2giT3nSLyOsyTHbGYt2UDRodVziApzfUwKJOT79yL8H+qUpKIhEajPraqxeAanI+7nA1AHJL5gRasj29Uj9FKLmQmcBcZXf9xchxFxjdqTTMLsqQizzst3LWKxp6t7X//bFBjUc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763474993; c=relaxed/simple;
	bh=wWOh8j23kS+6/2eJ7V00enovqjtNNQA0IJ8ig3MP74M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=uti6GLlG87p8WkrkKACftErj9ZmtFa2XS4ATwvyFmhPxxShkiEUwTRMko8UUeYrQ3K1hO812EDDegVjzyaXsWVm7X8LaCnW3g9diGYHC3I+rgAfXxad99BfC1C/mLq+ajC2BxBYm4OL0LQdDpNF6D5siEGCZbFeXxPdVfDmMyxE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7777B3857830
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LP+N4WQt
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20251118140950267.WNYH.47226.HP-Z230@nifty.com>;
          Tue, 18 Nov 2025 23:09:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/2] Fixes for dll_init.cc
Date: Tue, 18 Nov 2025 23:09:33 +0900
Message-ID: <20251118140943.7357-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763474990;
 bh=yCdNqNLBuYaVmvqEEPRCX9olFsFL9uHFCHz/uSQPooQ=;
 h=From:To:Cc:Subject:Date;
 b=LP+N4WQtbg/6FKmSKAIRy84eCBmPtCNymjNdah8bn8ZkCKN5DBRSQyHXKm0jWU0DlvHS4uwj
 gQok8jqRD8yPvW2DAsUOI67DNQzCALb3wMhTDUPcnIV8u1DjEWmX/QTmK0ngLxLnkyK8HsHvWX
 xBZrrL1EqwL6lEYtyBQ/56CejQD6+r/Mk+2VpKwgB+or9cJ0AcpjnNdZYqEOfP9v/IKDt04iaH
 GpuURO6m+Wt3mHiOFe4X0+SHGq7Be0NtBrJBxHZLlmrKPxW7niIZ7nhxpGCLqW7Zlp+526OHaK
 TX9AgwZa90ndG0XN78W4KGRqDQmLqUh1o3j0sM5biLNJ1LiA==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: dll_init: Call __cxa_finalize() for DLL_LOAD even in
    exit_state
  Cygwin: dll_init: Don't call dll::init() twice for DLL_LOAD.

 winsup/cygwin/dll_init.cc | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.51.0

