Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-w02.mail.nifty.com (mta-sp-w02.mail.nifty.com [106.153.228.34])
	by sourceware.org (Postfix) with ESMTPS id 82A113858D38
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 12:27:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 82A113858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 82A113858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.228.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733401627; cv=none;
	b=rdiiThWvGkTW7iAjcaOSR7Kit2R3xiw3guuTdQZ8qSZrkvyoLCg66p9puLaqaRggWha/ExsvNgYuKPxxwXKdB3nFLqBJD6kTpgs+UbDENv5DJwNrIKLsV8n0ZvgD1kW3s8XKWmHLjscPRvTbEV+9LY6HxP9y3/PnhBUDBFUcdpk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733401627; c=relaxed/simple;
	bh=QjtKosRssfD60jKX3HJ8FFjGwSqPEe4KOV8MS78RI5M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=hUu2cGvTGN+tybhne2+TfL/84EFpcI+TRfaylaWDWVoUlF4U5X0yvl9cRjlTAtvD8TK+FFT7x/YopzvJhiL3Zttjm/CGij/ZZmhU0z1FUtg3xupSwQXQ+H5RT4IzHvOiN/fiulIphFc5flf7ppthRCuJOoBZxKeeCJW6svOVvjQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 82A113858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S7B2/g0B
Received: from mta-snd-w02.mail.nifty.com by mta-sp-w02.mail.nifty.com
          with ESMTP
          id <20241205122704847.RWJE.9348.mta-snd-w02.mail.nifty.com@nifty.com>;
          Thu, 5 Dec 2024 21:27:04 +0900
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241205122704696.PQGO.12429.localhost.localdomain@nifty.com>;
          Thu, 5 Dec 2024 21:27:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/3] Cygwin: Document several fixes for signal handling in release note
Date: Thu,  5 Dec 2024 21:25:43 +0900
Message-ID: <20241205122604.939-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
References: <20241205122604.939-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733401624;
 bh=s+8Dnhl9VicCE6VFXyr7yk3MBeBdY05zHsIlL5cgMhY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S7B2/g0Bgu1J211Awin0QB4LIX0XJcm5RAg2+RBY6J+LMetuZAvF4Q+/H3GBPXC1yAlbyLGw
 QCFUDTUwkw8Rh6jLHxEONnPZo1nta1Nx/daY4zdnv7hYvEiFgzVvDMIejAsakE6EHNpntFiaxJ
 UuiFFNo+Eg2cqlOE9f+KuIrKvByjBCvT8f4TFNN7Q9JheLvgwSxDCl5xtYVl4CoVisDwQjwgSA
 raRSyLs8qCom7NuC0eobb7snmH7dfXrslAgAceHrh5W+LrLyK4IeYj9HQj203n0FuLMFhr27WZ
 AlhF6JxGoTPoYdpAST/URH/o8NvTYQQU+2XWGSJeMYgXGx6Q==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/release/3.5.5 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index 7ccf28abf..3d0287c97 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -51,3 +51,7 @@ Fixes:
 
 - Fix frequent page fault caused in Windows Terminal.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256841.html
+
+- Fix several problems triggered when a lot of SIGSTOP/SIGCONT signals
+  are received rapidly.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
-- 
2.45.1

