Return-Path: <SRS0=L2dC=7D=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id D4D143858D1E
	for <cygwin-patches@cygwin.com>; Sat, 11 Mar 2023 23:36:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D4D143858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 32BNafTH087729;
	Sat, 11 Mar 2023 15:36:41 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 76-217-4-51.lightspeed.irvnca.sbcglobal.net(76.217.4.51), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdu6akZ8; Sat Mar 11 15:36:38 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Fix type mismatch on sys/cpuset.h -- relnote 3.4.6
Date: Sat, 11 Mar 2023 15:36:28 -0800
Message-Id: <20230311233628.18424-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,KAM_NUMSUBJECT,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/release/3.4.6 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.4.6 b/winsup/cygwin/release/3.4.6
index ccc168a95..ed124ed37 100644
--- a/winsup/cygwin/release/3.4.6
+++ b/winsup/cygwin/release/3.4.6
@@ -12,3 +12,6 @@ Addresses: https://cygwin.com/pipermail/cygwin/2023-February/253037.html
 
 Don't accidentally drop the default ACEs when chmod'ing directories.
 Addresses: https://cygwin.com/pipermail/cygwin/2023-February/253037.html
+
+Fix CPU_SET(3) macro type mismatch by making the macros type-safe.
+Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
-- 
2.39.0

