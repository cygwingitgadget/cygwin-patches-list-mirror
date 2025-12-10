Return-Path: <SRS0=1nHs=6Q=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 1CCC64BA540C
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 01:52:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1CCC64BA540C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1CCC64BA540C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765331562; cv=none;
	b=XtFoBt914/pBy89e85ga/4BJsSOwgaLDWTPEasAsYC8sESsZUPUuQQu1cwtBNRrKEDO+5mklbiKdxU72zm7w/KCcXw3yX3EN1ze2pTT5PU82ttuFGqy7CEou1uNEN+YqgLS4eIUh3+q9CvF3IKGC/eHBIwCk/RXPzOEIxFJIAYA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765331562; c=relaxed/simple;
	bh=6VluV7NWYJzfUUBCcm+UEA4LhreCGpqz9JyMjO5xgUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Wl37jM9Ke70NLZssuSFnczr5QFeyzVfzauAVczOPI2ZvqjnCpuCZ3UKX5pDR7Lsy9A2LvMdt0chg2HpEMlzXM+UgHY6otJxbLQzXjIkUwzmd+9EthlKy+8vYBPnNiB0uS3TFR9LFyd8dYgwpcrjns15LElDXyAFLwA5dw2vBD3E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1CCC64BA540C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YYk5WTcn
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251210015240059.EXLT.127398.HP-Z230@nifty.com>;
          Wed, 10 Dec 2025 10:52:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Fix a few pseudo console issues
Date: Wed, 10 Dec 2025 10:52:21 +0900
Message-ID: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765331560;
 bh=PHjlYUxg9UyamN4cghEDRebzaaDyfh2pmX/m179umck=;
 h=From:To:Cc:Subject:Date;
 b=YYk5WTcn0rVNw2owbTnb1YVj3A7AbmTZBjnpiJ44CIpeKn3OhJvvAfX7QnXnxM4qvghqKhCm
 E6DcwcFhU2id54YKxdtFDOnki7A1Bd/ca3zA/+zw9iBwBecUd7EEuC22S+PzMRLVl1xLxztRLq
 jSTznT5HMfQaBoa8fveVHVszNYDOQYBtJVrmvQqZTVtIduvyGWmqYv4tOM/hT6LEoFXT9Ca03h
 w6AyRgfplJhNAAZheAK5hAhHqldG2I8xVCsN/B8fE3hUIzbN/vkHL7mtTdKhCW6wSTz/7pOhol
 X2J0lRusy7e29OqJwa8yHVmxIeEycjVb6BbDGJrPMFom4Wuw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: pty: Fix ESC sequence parsing in pty_master_fwd_thread
  Cygwin: pty: Add new workaround for rlwrap in pcon enabled mode

 winsup/cygwin/fhandler/pty.cc | 47 ++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

-- 
2.51.0

