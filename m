Return-Path: <SRS0=29bO=C7=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 622673858C74
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 05:37:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 622673858C74
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 36D5cMjN047151;
	Wed, 12 Jul 2023 22:38:22 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd8RxMc0; Wed Jul 12 22:38:18 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Update release/3.4.8 for latest <sys/cpuset.h> commit
Date: Wed, 12 Jul 2023 22:36:59 -0700
Message-Id: <20230713053659.379-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/release/3.4.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.4.8 b/winsup/cygwin/release/3.4.8
index d1e34ce3c..3113be8cb 100644
--- a/winsup/cygwin/release/3.4.8
+++ b/winsup/cygwin/release/3.4.8
@@ -3,3 +3,6 @@ Bug Fixes
 
 - Make <sys/cpuset.h> safe for c89 compilations.
   Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
+
+- Make gcc-specific code in <sys/cpuset.h> compiler-agnostic.
+  Addresses: https://cygwin.com/pipermail/cygwin/2023-July/253927.html
-- 
2.39.0

