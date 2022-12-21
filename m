Return-Path: <SRS0=tR/4=4T=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
	by sourceware.org (Postfix) with ESMTPS id C342F3858D1E
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 10:26:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C342F3858D1E
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-08.nifty.com with ESMTP id 2BLAPmbB014662;
	Wed, 21 Dec 2022 19:25:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2BLAPmbB014662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1671618353;
	bh=Y5P+GqDsGd/QkVVlaZhcNtpjEuDEcSYqTW+gpd4fQsc=;
	h=From:To:Cc:Subject:Date:From;
	b=an3scp3ILgB7GbRL2ZZjolwd5+Lfol4znXu694sFQ4RToPkzpToP1l5k24LUwLhzy
	 L+0Ul+dbZYJOKxFsCy88OOQi11NDWVfClEEkDhiN+Afa7C/sdHOHtWz1iGrv/VRX6i
	 +ZXatLPojw48c1dHiWVkYWhG9yjMbULX1h+BJoN8DfwZV1JO+5thVrU2P7O/7nK6Xj
	 Cw9vJ24SVEpWowfLbWoboIzx/CdTtpobVce6WTnsBbB8RHX2/zu+6fNNuKTntosn85
	 WbIyTu30FXOZlDvdQStgcr+QdwEr3QeaOssX4gNxKJFDsLXzuHHc5AP119bYHtTtKQ
	 zeCOVuVhJRBIw==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: devices: Make generic console devices invisible from pty.
Date: Wed, 21 Dec 2022 19:25:39 +0900
Message-Id: <20221221102539.1926-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The devices /dev/conin,conout,console were wrongly visible from ptys,
though they are inaccessible. This is because fhandler_console::exists()
returns true due to existing invisible console. This patch makes these
devices invisible from ptys.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/devices.cc | 5 ++++-
 winsup/cygwin/devices.in | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index a0762f292..9f6e80acb 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -9,6 +9,8 @@
 #include "path.h"
 #include "fhandler.h"
 #include "ntdll.h"
+#include "dtable.h"
+#include "cygheap.h"
 
 typedef const _device *KR_device_t;
 
@@ -76,7 +78,8 @@ exists_console (const device& dev)
     case FH_CONSOLE:
     case FH_CONIN:
     case FH_CONOUT:
-      return fhandler_console::exists ();
+      return cygheap && cygheap->ctty && cygheap->ctty->is_console ()
+	&& fhandler_console::exists ();
     default:
       /* Only show my own console device (for now?) */
       return iscons_dev (myself->ctty) && myself->ctty == devn;
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index 7506dfe9c..48199f46c 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -8,6 +8,8 @@
 #include "path.h"
 #include "fhandler.h"
 #include "ntdll.h"
+#include "dtable.h"
+#include "cygheap.h"
 
 typedef const _device *KR_device_t;
 }
@@ -72,7 +74,8 @@ exists_console (const device& dev)
     case FH_CONSOLE:
     case FH_CONIN:
     case FH_CONOUT:
-      return fhandler_console::exists ();
+      return cygheap && cygheap->ctty && cygheap->ctty->is_console ()
+	&& fhandler_console::exists ();
     default:
       /* Only show my own console device (for now?) */
       return iscons_dev (myself->ctty) && myself->ctty == devn;
-- 
2.39.0

