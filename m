Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 14E0C4BA2E04
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:27:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14E0C4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14E0C4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042853; cv=none;
	b=cti9cNtxDd0GPfT+yIbl0heP+GhFIBkLE9VFrzNLFP7PIWq2IbplVfs9mfcQ6p0seaoxG/eI+NV10vMxf6h2TiLz6bPGcL47ibab60bNBDSLkT7yAUFejw8+moCCs0vHtb4oluQ47KO/HxrsPE1pDMk7CPsGhI2c7XVnI+kN2Hw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042853; c=relaxed/simple;
	bh=HPPlHb/KG6AmbKP/IzJYPssDO1WdCWSXhjwic6P4XtE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=uEr+2w72iJTSTOkN4fRUtAAgxxuv/1Om6HLWeGhNyj6BZdgr3OCjoJpcpo26o/U7TjCyrRV8pYaq3m2KR5dK5cxL6Poi8rE/a22BqKYY0E1gp5AagwWfOGQy93I/5OqkfHD86e8oq/1BA/2L3GcvzO+3segMLF7oMgSg2HIXnxI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14E0C4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Cy+oBVas
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20251218072730866.HHFA.4197.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:27:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/2] Fix a few pseudo console issues
Date: Thu, 18 Dec 2025 16:27:01 +0900
Message-ID: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042850;
 bh=lHTY/ZMzyyHninFd6qoTRgL2Ji1scvOWDqeMdqP/k6o=;
 h=From:To:Cc:Subject:Date;
 b=Cy+oBVasD6smgNDSDoYIr3rTJG2GPEN8TcITku1ocPhYz5tx4JollvBL+VC3XNUHtQvMW6HQ
 Jsgrrp+xO+r/7XhR6msyYa3Ij0Okwx/EYjGRaJLcR9JeOXPxBTcqEIx71oY9btYpq74ZsadvRL
 1xMt73yBVig5JcPvQ0vSGOCM/wylOHhqsKy+AANS+wkTcHmcH8+GNvWyZhHzHE7ZNAdocMaxdM
 gHtpiF8FfodvsLE9Z/vPxSYh1Dhw7XYF5TWCAhBurNpvWzHXMxSDo42uTq8T4o68o7ARtOSxUi
 L4wyj0a7PpMjDiwlls5Nmyw1k+zNJxWwekwNEdui34AWJS4w==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Changes from v1:
- Enable new workaround for rlwrap only when the OS is Win11.

Takashi Yano (2):
  Cygwin: pty: Fix ESC sequence parsing in pty_master_fwd_thread
  Cygwin: pty: Add new workaround for rlwrap in pcon enabled mode

 winsup/cygwin/fhandler/pty.cc         | 57 +++++++++++++++++++++++++--
 winsup/cygwin/local_includes/wincap.h |  2 +
 winsup/cygwin/wincap.cc               | 11 ++++++
 3 files changed, 66 insertions(+), 4 deletions(-)

-- 
2.51.0

