Return-Path: <SRS0=aWaS=7M=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0005.auone-net.jp (snd00010.auone-net.jp [111.86.247.10])
	by sourceware.org (Postfix) with ESMTPS id 46BFD3858C2C
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 11:51:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 46BFD3858C2C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from DELL-39.sekkei.local by dmta0005.auone-net.jp with ESMTP
          id <20230320115119795.GZXI.37033.DELL-39.sekkei.local@dmta0005.auone-net.jp>;
          Mon, 20 Mar 2023 20:51:19 +0900
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: Yoshinao <ysno@ac.auone-net.jp>
Subject: [PATCH 0/3] fix unlink/rename failure in hyper-v container(regenerate)
Date: Mon, 20 Mar 2023 20:50:59 +0900
Message-Id: <20230320115102.1692-1-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
References: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Yoshinao <ysno@ac.auone-net.jp>

use real name and add `Signed-Off-By:' field, as suggested by Corinna.
code is untouched.

Yoshinao Muramatsu (3):
  fix unlink in container
  fix rename in container
  log disabling posix semantics

 winsup/cygwin/syscalls.cc | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.37.3.windows.1

