Return-Path: <SRS0=MpmZ=CZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0013.nifty.com (mta-snd00009.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 5AAAF3858D38
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 03:35:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5AAAF3858D38
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0013.nifty.com with ESMTP
          id <20230707033514478.WELL.104052.localhost.localdomain@nifty.com>;
          Fri, 7 Jul 2023 12:35:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/2] Fix issues of stat()/fstat() for /dev/tty.
Date: Fri,  7 Jul 2023 12:34:56 +0900
Message-Id: <20230707033458.1034-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Takashi Yano (2):
  Cygwin: stat(): Fix "Bad address" error on stat() for /dev/tty.
  Cygwin: fstat(): Fix st_rdev returned by fstat() for /dev/tty.

 winsup/cygwin/dtable.cc                 | 13 ++++++++++---
 winsup/cygwin/fhandler/console.cc       | 12 +++++++++++-
 winsup/cygwin/fhandler/pty.cc           |  8 +++++---
 winsup/cygwin/fhandler/termios.cc       |  9 +++++++++
 winsup/cygwin/local_includes/fhandler.h | 12 ++++++++++--
 5 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.39.0

