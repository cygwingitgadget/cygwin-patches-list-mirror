Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id E7E0F4B99F58
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:06:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E7E0F4B99F58
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E7E0F4B99F58
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359602; cv=none;
	b=UKHEnoyaAUBL782mPpkEURic3dxN3x0lckwFWWDvQ727FZKwfVmmNNBz4Ct5RzsGNSoQsloD2Pg3V+nxDiniDLkajH083QQIYCvmx5KefCd5ZIP1Tu64D1kyaHhlTxpqAja97DbIJv4o0uO3i+jf0SXAb6llCm4eldXejFD7D78=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359602; c=relaxed/simple;
	bh=ryeomBli8cL2bxPUaMgKGY1x0+qsiFrHa0k8/5GqERA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=enISVJKxs9RPpAD6Szm3BOx/q2NQp3oQPRrvH5rfnfMAl0r5a6cMAejn3q5huwraCj8ofVEUrxVjyABpDKbGAtf0zmNsf37HjehrCl0TydBm4B0ibW+l7F3hr3DH8pnl4VbWKe55dQB3DpKpL6p3RItRiTukuy5r1HRTYJURGEY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Gu5mCyjv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E7E0F4B99F58
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Gu5mCyjv
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260613140639075.UYOV.44671.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:06:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/2] Prevent unintended conversion for cursor position report
Date: Sat, 13 Jun 2026 23:06:18 +0900
Message-ID: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359599;
 bh=1kVWe/+jSTwbadGegQtZW4igwE1DsAbquGguFrlu9NU=;
 h=From:To:Cc:Subject:Date;
 b=Gu5mCyjv0UgUZOWpyNAzBC6hA6dJQ1vRPTP4qx/fwpJo2fWlF4NWYJu3kY6WqswHFHhRbL9K
 0t+43RivjWdbV8yvbCnoxSVCQlEacAhWyoQNfwJByclgCZFT4Rsm/fNlMoLm8BjBv+41rY58rK
 dnE6JVBaOCiscAgGpCFmABQi9B/n99xc2tOlk2WcpIFzcVmsht2VRsPSauKC/7sZYftX1loBUX
 iSTCVfu2Iyr7m3ntuXSClZwlj0PoBVJFmp7Vx/2okquVhV5xWHdbrZMM84YXn2LCUwQAzs6ww3
 zBJsrt0obIAySsDE3p6+QbZIztb9nGmYNvEiKJglS61ZgBfg==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2: Close pcon_handle_ready_event when the first (not the last) pcon owner
    is closed.
v3: Do not wait for pcon_handle_ready_event when req_xfer_input case

Takashi Yano (2):
  Cygwin: pty: Introduce a helper function get_handle_from_process()
  Cygwin: pty: Prevent unintended conversion for cursor position report

 winsup/cygwin/fhandler/pty.cc      | 119 ++++++++++++++++++++---------
 winsup/cygwin/local_includes/tty.h |   1 +
 2 files changed, 86 insertions(+), 34 deletions(-)

-- 
2.51.0

