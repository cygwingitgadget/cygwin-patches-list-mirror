Return-Path: <SRS0=SJZz=SU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id 89D483858283
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 12:17:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 89D483858283
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 89D483858283
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732537028; cv=none;
	b=g2AAqHRPOdzezkZ8WMoar0TiKuJIqQkdYf+vdjaCbz/5AnG+CP5n3NSOlcEp0rg9EbaW5SCsr1F3mn39CnDzyTJnKcKBLoFIYvlEFAh5ZTIvzaphWX6C/vHhQG7vvh/Roa9qPzH4FhxUOwE7xhdGPABjlxO9j6sac3SgkEjZqdk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732537028; c=relaxed/simple;
	bh=uHrTta6o1G580U6WBvVdCfRTPfQnJa+4ONfhgjFixZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TbQZLvAh7ewLutjfNHgftKXZiN0Wh6XaQT7lpzjAw0Mv+KBZii96sFN8wefSNZ2GSNj2dW21jTcXIkJKZjxLenyLuXMm//0++jEBBdqN0vs9mNztDr3X7FQBjQsziI5euE0v8aYfzYDI3KrhodjxPsj0QnKxYcch2Qp+Y2dZ6fk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 89D483858283
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PTXA6HRx
Received: from localhost.localdomain by mta-snd-w02.mail.nifty.com
          with ESMTP
          id <20241125121704972.KEKW.47547.localhost.localdomain@nifty.com>;
          Mon, 25 Nov 2024 21:17:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 2/6] Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
Date: Mon, 25 Nov 2024 21:16:18 +0900
Message-ID: <20241125121632.1822-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
References: <20241125121632.1822-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732537025;
 bh=7u5ivfiicreKGsZzqmDsZ6twJI1t7AkuoOEybmibkjw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PTXA6HRxYHQzOESu/GBMmBAyDuQAXuqXhvfIBcwCz9ByNAIlJQU6IEEyOQ9kDdkNsB9AsjLi
 wQkpNE4DLVMGF8C8trRKxuByMJvE5SaVxy1sPJWN/OKbF+J9FL81b83yxvT6b96gNMhVi8GkIu
 f4S50o99y4w37AudtLiJdTm/J2/5kETmOdgzj2kC9K3IxQ4B84cwM/jHisYyMYaqSb2A6ah59A
 rf9vOf4tkozj4xj4y80Rhu9VNNt0SwLIcA3h8zi9WciZitZxF50BK6LtUeXVX2EW+Nw2v9UDOA
 gjrFmk9PB8u8EDeoLtIMCGSJ+D4swCihQL8QRNbGDk6g5FPg==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

With previous code, queued signal is tried to resend only when a
new signal is arrived or pending_signals::pending() is called.
With this patch, if signal is queued and retry flag is not set
and new signal is not received yet, sig thread tries to handle
the queued signal again. Without this patch, the chance to handle
the queue would be delayed.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
Fixes: 5e31c80e4e8d ("(pending_signals::pending): Force an additional loop through wait_sig by setting retry whenever this function is called.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/sigproc.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
index 66ffef8f1..34e459070 100644
--- a/winsup/cygwin/sigproc.cc
+++ b/winsup/cygwin/sigproc.cc
@@ -1329,6 +1329,9 @@ wait_sig (VOID *)
       sigpacket pack = {};
       if (sigq.retry)
 	pack.si.si_signo = __SIGFLUSH;
+      else if (sigq.start.next
+	       && PeekNamedPipe (my_readsig, NULL, 0, NULL, &nb, NULL) && !nb)
+	pack.si.si_signo = __SIGFLUSH;
       else if (!ReadFile (my_readsig, &pack, sizeof (pack), &nb, NULL))
 	Sleep (INFINITE);	/* Assume were exiting.  Never exit this thread */
       else if (nb != sizeof (pack) || !pack.si.si_signo)
-- 
2.45.1

