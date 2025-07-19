Return-Path: <SRS0=jPCG=2A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [106.153.227.33])
	by sourceware.org (Postfix) with ESMTPS id 422E13858C53
	for <cygwin-patches@cygwin.com>; Sat, 19 Jul 2025 15:16:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 422E13858C53
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 422E13858C53
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752938178; cv=none;
	b=R4wORh7ssRrwe38se9TvQ5Q/NKQb5K/XbEMmbFqY5iZBt2w+qX8ga0Y+sA9xgIaEE7cYRxMENojVBFZz8SbUrOwKHFgePguP2neoLjOpWuhiTY+7QBcyLpnpmSoZya/515d6QuGNjtSxe7zIjqDxcp9XW09R8JmgTkGnBtf1q4w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752938178; c=relaxed/simple;
	bh=Ku1ebBJ48vkClqFix9eBir4sAULlI1U4L981e3YnjGo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=uuBwG0u+yONpgOtooG3fo/9YbZKPwGkxhTc1c1fg9ZY/0Tzu6sUWILw6mYz/2OIfu/e/M9S6LU9tvTXSNeYOWYVSPa6RFJzq5FIpyhRKrb9DzyGaiaRYor3wmhbXJqIYavo9iGGw7Gh8ZoHc8fp+72LrVphDS04IoG1KCom+FSs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 422E13858C53
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qiTJ/syz
Received: from localhost.localdomain by mta-snd-w01.mail.nifty.com
          with ESMTP
          id <20250719151614399.GEEL.69071.localhost.localdomain@nifty.com>;
          Sun, 20 Jul 2025 00:16:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Make system() thread-safe
Date: Sun, 20 Jul 2025 00:15:41 +0900
Message-ID: <20250719151557.340849-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752938174;
 bh=ncfcPV9rzNtdsibN8813BP0iIpA9JdFCuntyYpW8DBo=;
 h=From:To:Cc:Subject:Date;
 b=qiTJ/syzzZUxRPTzUEzPlGzEIkP582FSWlgMX6ihrErWcR+h0W8L87eZRNI6VQA9XObtaBYz
 OI8UFlymTtbaxudKW98Qo7vQt/zybsa+D44vE415qinFPQfRaMarDxnuinLHjhhOZVgbupAG3E
 NsqKMEIcmcVQeM/duWqymZAa2zxa0b/0DlXHM04jqXhNaqFXOLyp5X9MRmgkA6xTWmzgexBpJh
 RYI0kMJBsnyr6Il58JibskVMI0yhbU6BvYEFN4oLGUwnw3EkLebVOXu0YqhEcTDG7yFcPEf4Lk
 /denN7uqU5EktHAajeKhFfOtFqvd3AWAZ7sd4jJuQr5e7BkA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/mm/cygheap.cc | 2 +-
 winsup/cygwin/spawn.cc      | 8 ++++++--
 winsup/cygwin/syscalls.cc   | 5 +++--
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.45.1

