Return-Path: <SRS0=K8Mg=EZ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 31F163858D1E
	for <cygwin-patches@cygwin.com>; Sat,  9 Sep 2023 06:49:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 31F163858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3896n7e9090513;
	Fri, 8 Sep 2023 23:49:07 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdrUlAMh; Fri Sep  8 23:49:05 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Add relnote to 3.4.10 release file
Date: Fri,  8 Sep 2023 23:48:30 -0700
Message-Id: <20230909064830.5774-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Document the most recent update to include/sys/cpuset.h.

---
 winsup/cygwin/release/3.4.10 | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 winsup/cygwin/release/3.4.10

diff --git a/winsup/cygwin/release/3.4.10 b/winsup/cygwin/release/3.4.10
new file mode 100644
index 000000000..f34b131b3
--- /dev/null
+++ b/winsup/cygwin/release/3.4.10
@@ -0,0 +1,5 @@
+Bug Fixes
+---------
+
+- Fix missing term in __cpuset_zero_s() prototoype in sys/cpuset.h.
+  Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
-- 
2.39.0

