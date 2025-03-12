Return-Path: <SRS0=oSj3=V7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id F2C813858D21
	for <cygwin-patches@cygwin.com>; Wed, 12 Mar 2025 03:28:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F2C813858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F2C813858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741750093; cv=none;
	b=XweNfKacFmoQ3HXsCXM5geg4mR0sfbUhPk1Zo2UO/xeM1j6a4dXeLDvXnf9Vx7NRLO7GhdNa0UnQnz+2mdbOC8qM57GZ8QTyYFb418UhAqZlXBhgWtcmP/YQuS2w7UUo1eRfTLx9IoZDGMGPJKiaw1AYa7dcpfZvp6WRjXjkT+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741750093; c=relaxed/simple;
	bh=xIv1eEaQ5Bz+hDrVndsUQKUtNKztXJYFChcgt1uXYlM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=K+1yLbuD2PnAxBecMsQz6lUyfNy3gN14+EqxCB0f7oLxWCo9odX97ikQl787WdFub5Tn8D0P8JU3B86OXhf7d05n6HhyGQdAIy/ikra16fRxhn1wK1Z1O84R8UdiiSY5wwwG7UBYdQsW3j2CuSlqk4aXejuaY1aahtPG10WTdlA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F2C813858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I8874V6a
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20250312032808029.XTRH.17135.localhost.localdomain@nifty.com>;
          Wed, 12 Mar 2025 12:28:08 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/6] Several fixes for signal handling
Date: Wed, 12 Mar 2025 12:27:26 +0900
Message-ID: <20250312032748.233077-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1741750088;
 bh=vC2XjJWotq4bD3RymtBE8PFMPbdjseQTQR+bXyFJ4I0=;
 h=From:To:Cc:Subject:Date;
 b=I8874V6aHw2yTx0P/PsnBYVpYNiKvpkc+1MnKpthXYMpfUwWMUOIgi14A3MHy6+BhH+jPMbR
 3K3muXQp/aQVT/qbUc6JeYlTxzA/WRwFl5O69eZS0hSwGk+ZZ08NZqhP07NHAaZWODbZPiTUBt
 dk3cUMO063bWF0AcjyNgBeBPMe3DvHiEgZKsq55REXFte2fTqiMfSTHx48tYLpAvlDgaZNoSjX
 26ERsW9vik6QPuFJxkcXV1uceNJyS2j0n68i/q7J0ZJb3Civ3LcDLbIStW3UCBznF8LsXsVm08
 xH2/wIcjSPIiZdOhrEzedvKTwsGVnrrj4AAc18K8NS3DzU2g==
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Split the v2 patch into smaller parts and add two additional patches

Takashi Yano (6):
  Cygwin: signal: Redesign signal queue handling
  Cygwin: signal: Do not clear signals in the queue
  Cygwin: signal: Ignore SIGSTOP while process is already stopping
  Cygwin: signal: Do not send __SIGFLUSHFAST if the pipe/queue is full
  Cygwin: signal: Use context locally copied in call_signal_handler()
  Cygwin: signal: Remove context_copy in call_signal_handler()

 winsup/cygwin/exceptions.cc |  63 ++++++-------
 winsup/cygwin/sigproc.cc    | 174 +++++++++++++++++++++++++++++++-----
 2 files changed, 179 insertions(+), 58 deletions(-)

-- 
2.45.1

