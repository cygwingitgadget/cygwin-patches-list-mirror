Return-Path: <SRS0=dMBQ=EG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 942004152C9F
	for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2026 16:35:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 942004152C9F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 942004152C9F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781109342; cv=none;
	b=UTNOGGn0L1nVmWyWypOSj2lhWCdY9fWzWKszl0T+q1EwqDreKhYxWidE9ABUtVvpj8WR9h3IY1JpUonsQI7QMhKGOf8jv0GrC+m1O6266lEm/IAImq3mQZRF7Q2cRL3/NVthd6C96mf0xNQg0xTnwywpP7Uf5PPCtEDpqAulD+I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781109342; c=relaxed/simple;
	bh=LIxTtJcoulhnbB35cHkucil0ZyDjfxse8CJIb/r1pdo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qKKu1dcIlgVA8uD0xEO+Bc6Hmm5y3VcTvoKFvnz+jdBlOq3xw03Q5w2doaH5bVbnYFyrWVjZ1hBtu20xNUrS3nlrDE8pBoehXEaRnSw9fYqzoaW8p1AAeWgBM7+RNeZ+2qWV5D7vV97Ewk78Lmvbv1cFjRHMTRoSdYwi9h8TY7g=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ScD5IdR6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 942004152C9F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ScD5IdR6
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260610163539946.KSXJ.3198.HP-Z230@nifty.com>;
          Thu, 11 Jun 2026 01:35:39 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/3] A few fixes for console input
Date: Thu, 11 Jun 2026 01:35:11 +0900
Message-ID: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781109340;
 bh=Wb9Kmm49DbexcgJu1dbfJ23Aj1HzowfM4iApSti6gQA=;
 h=From:To:Cc:Subject:Date;
 b=ScD5IdR6sSil9r/aeBmFpVuc6V4ucCcF5IEIlPhOGLfy2Y8NQFxaQy+8VpO4SStGTLRU2Ubf
 U5FsAKSlSQAYgmnsu7+rGOeAE15lyTy9ObF1ZuPMCwaE2yfGxi6iLlBYaNScyxBXfAs1jqf0XR
 eeIvW1d4uz7a9xQRg/XfKwrXolPcnamRg/uHzsQ06WOLumz8iy/Sw15QOYf+VbCwWqL8OYSeO/
 uR1KFTA2N9Cck2aYT6wVHWgctHtsAbfQGWDKZQq9cLhTHa9L/cUrIwnJNE69zUwfSAElBx29VJ
 vsjr2LYolFNaRrQu/1f//zPODOQeiMv1ZMSgUw8awCo0gEOw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: console: Ensure the master thread runs only when it is
    supposed to
  Cygwin: console: Fix NOFLSH mode a little
  Cygwin: console: Fix typeahead input for bash

 winsup/cygwin/fhandler/console.cc       | 50 +++++++++++++++++++------
 winsup/cygwin/fhandler/termios.cc       | 10 +++--
 winsup/cygwin/local_includes/fhandler.h |  4 +-
 winsup/cygwin/select.cc                 |  2 +-
 4 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.51.0

