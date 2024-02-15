Return-Path: <SRS0=lcoE=JY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1017.nifty.com (mta-snd01005.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id AA2F4384CB97
	for <cygwin-patches@cygwin.com>; Thu, 15 Feb 2024 17:42:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA2F4384CB97
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA2F4384CB97
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1708018941; cv=none;
	b=lnqhJcYCaBkZ2I1xDPnX4tBIL372PFPnAL6hEJtGLnPW/JtfHeTQP/5hj8CntS6NzcPlfLq/Y6sbR3kcMfF/t7p6BWEglI/mJXidsuDmb5pDdr+mEvEhJq5w8JNGKycQe3vMSLd12DYeH+Ff+08hXaxn59FF4zdIpvvW84xa/Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1708018941; c=relaxed/simple;
	bh=PpW1Qpxfjzz5sa4fZarmFauDkbzqv7mH5xCx+hfQGvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BfFvJB/axQ/ecwBRhIYzULsgzq7HvtwhWzM7ch3J4K30h5FDDrmeZNV190iELX9SbhIznGS+9/jIJWX0k1lMCbkAhzwrxkNexjn5tBalNxdZo4gyIOaDrLf/nVz8Al21rqhpEG3wEAWNUGuRwGTlcFETv286ab8he2fZ0G+lrzQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1017.nifty.com with ESMTP
          id <20240215174214868.EHLH.70310.localhost.localdomain@nifty.com>;
          Fri, 16 Feb 2024 02:42:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix a bug that cannot handle consoles more than 32.
Date: Fri, 16 Feb 2024 02:41:49 +0900
Message-ID: <20240215174200.1164-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/devices.cc    | 2 +-
 winsup/cygwin/devices.in    | 2 +-
 winsup/cygwin/release/3.5.1 | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index b14613bc7..5b67fd1da 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -84,7 +84,7 @@ exists_console (const device& dev)
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
 	  unsigned long bitmask = fhandler_console::console_unit (-1);
-	  return bitmask & (1UL << dev.get_minor ());
+	  return !!(bitmask & (1UL << dev.get_minor ()));
 	}
       return false;
     }
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index e15a35f25..be54346fb 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -80,7 +80,7 @@ exists_console (const device& dev)
       if (dev.get_minor () < MAX_CONS_DEV)
 	{
 	  unsigned long bitmask = fhandler_console::console_unit (-1);
-	  return bitmask & (1UL << dev.get_minor ());
+	  return !!(bitmask & (1UL << dev.get_minor ()));
 	}
       return false;
     }
diff --git a/winsup/cygwin/release/3.5.1 b/winsup/cygwin/release/3.5.1
index e041f98f3..96d2ad32f 100644
--- a/winsup/cygwin/release/3.5.1
+++ b/winsup/cygwin/release/3.5.1
@@ -18,3 +18,5 @@ Fixes:
   Addresses: https://github.com/msys2/msys2-runtime/issues/198
 
 - Fix the problem that VMIN and VTIME does not work at all in console.
+
+- Fix a bug that cannot handle consoles more than 32, rather than 64.
-- 
2.43.0

