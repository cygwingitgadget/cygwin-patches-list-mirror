Return-Path: <SRS0=EpSC=SV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 1DFA63857B9B
	for <cygwin-patches@cygwin.com>; Tue, 26 Nov 2024 08:56:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1DFA63857B9B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1DFA63857B9B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732611397; cv=none;
	b=lAr2WkWU/f8oi8iplG09v12dQbvePedAmzKHqE/e4vsPXj8LVldaQt+84iflCm6B9j/WBjJPAXlYe1w3UYF3N9vzcNzJpEtpL4ARR5GRC5xsaVWtsBz98Hf9/SspEOdd5vEBYUKNwHUhRP5j7IXVg6Noo+olaOGXEc2Gcf9ILXU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732611397; c=relaxed/simple;
	bh=pVN1X9UVJYw47c/qIhZD4JsAdtB6E02dT9QKi+UX6iE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=e7ZpxVT+irP5SDLdlFfh291Xmw7d0wUajJZmylWRmxiONw5owG72s1nxSdwG58x8hFcIYx6EU2WsSI+TWgUmyX7mWdO65bvijo+/tomw3UdM5/BECEvl5C1DAO1FtJrl/bMXXi9Sy8sTpVayZdGSEaNgBvWUOJ54FrFoQqYeYgA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1DFA63857B9B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=S7qcDwXO
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20241126085635429.NQWQ.90249.localhost.localdomain@nifty.com>;
          Tue, 26 Nov 2024 17:56:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2 5/7] Cygwin: signal: Drop unnecessary queue flush
Date: Tue, 26 Nov 2024 17:55:02 +0900
Message-ID: <20241126085521.49604-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732611395;
 bh=hkZ4xNCHhws3WwVqzgk0ORIrodZmZoAEJp3Dt17Dfss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S7qcDwXOJvyv/4rf7Fr/STx3feGqoYMGbIKPq0K7jZlXF4BNi86GbzjphXbJiQD8HJdFGtRg
 zxIj09NEtgrGQNfcDijL4+Qr21WbE3i3sXEC7oQAaIANaeWg/UA0/ojD4KGT1gpmFDwBQlFM0f
 3prwgo4UDN1ChdvRacJVSvCN0Vq5HOTBYAqHtFGOL3UpcIrz2CeqvDaox1sWlE9G1qSdn6apmx
 UvglVRkzxpbTWyNv2n6N1mW2j4SK0lwTFxU+hK4BbJ45RKGgygm7/hx1WazSKrfC9UxRP1vNnE
 jS/uz6dxguym2A/pGrgDxz4HOY/F/d1nBnP6I0yORRIc+IWQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the retry flag was always set when pending_signal::pending()
was called. However, if the queue is empty sig thread tries to flush
the queue even though it is not necessary. With this patch, the retry
flag is set only if the queue is not empty.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 5e31c80e4e8d ("(pending_signals::pending): Force an additional loop through wait_sig by setting retry whenever this function is called.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index fc4360951..c46b1492a 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -110,7 +110,7 @@ class pending_signals
 
 public:
   void add (sigpacket&);
-  bool pending () {retry = true; return !!start.next;}
+  bool pending () {retry = !!start.next; return retry;}
   void clear (int sig) {sigs[sig].si.si_signo = 0;}
   void clear (_cygtls *tls);
   friend void sig_dispatch_pending (bool);
-- 
2.45.1

