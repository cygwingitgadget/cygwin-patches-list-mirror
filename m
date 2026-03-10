Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:29])
	by sourceware.org (Postfix) with ESMTPS id 09B344BA2E13
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 08:50:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09B344BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09B344BA2E13
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773132652; cv=none;
	b=xMLlXkjyoepLgLaY6lAFJgxcm5/2eCfpi+kLEckxhCbb/gMKMyCo+o9ag2WVZofKDUqd/wCbeK6ILjKVehnQxoOmXTDKj8ycBHmZk4LFhHPXAoYVT2rCMT4FUI29aJJzjRUOId+yLNLft4zrhXZ0KcNftVBb7KbZO8V7MGNnlFY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773132652; c=relaxed/simple;
	bh=SP1AHF0N7zNLnkbVTobX/jgStgIG2stZFcVY1cH0SWI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=U9F7PGMWpvEzeXm5qz/LWL4bvG3sh+aE8sRsXdIX4BzbpTIPIp7suejMalpcnQQP7TinQ2zDmoOfFuY5gTiXFmytuO4j7g1jRWmNO1x6snrL2FvFf80zaV/ovfTp+x/4rVE5QVdfLXD0Oc2eCyzSUqkAVoUjZBpl3bqMJZRHwKw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 09B344BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kXb2fAZj
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260310085049106.MMAB.116672.HP-Z230@nifty.com>;
          Tue, 10 Mar 2026 17:50:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/3] A few fixes for signal
Date: Tue, 10 Mar 2026 17:50:06 +0900
Message-ID: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773132649;
 bh=/CI2dnHcoQ/QfBm7HU7UIrctaXYQs7fnvNhQDfhq1hg=;
 h=From:To:Cc:Subject:Date;
 b=kXb2fAZjUYxNmwNZD+xHzgfJnbFj+yzker2eiVARiFXFR56/CAQlc2kqNA6Rj2hngDDAaM6Z
 pBnTFyilKJJZ/XdvpH5Qs0iuaJxulMMYDFcN2G+KMZFLDkeTMvOcl8JZtDJHDtrzeAE9hKkWzs
 XgEgrxYn6lDnayVBNQ//WpfMesJAxRwSudOlpdh8ertpcpwXqvy39fXU8lmBZsSmsv9qTeFo35
 /hcQKsPnyXp4QvELDre+Fns+dJR3R9KoTvRKAfSOoJzZ1qVAojHwuGS+gsd7s4fUaYxTWS5hcV
 fIPw6fRNSIKgqnsc2E+0DwDY6sKkfjAyDLc+Ly5gQoojP2ew==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: signal: Wait for `sendsig` for a sufficient amount of time
  Cygwin: signal: Do not wait for sendsig for non-cygwin process
  Cygwin: signal: Implement fake stop/cont for non-cygwin process

 winsup/cygwin/exceptions.cc | 19 ++++++++++++++++++-
 winsup/cygwin/sigproc.cc    |  8 ++++++--
 winsup/cygwin/spawn.cc      |  2 +-
 3 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.51.0

