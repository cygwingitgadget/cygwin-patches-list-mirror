Return-Path: <SRS0=6K+s=EY=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 2E0403858D35
	for <cygwin-patches@cygwin.com>; Fri,  8 Sep 2023 05:36:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2E0403858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3885atI0017148;
	Thu, 7 Sep 2023 22:36:55 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdGEsAa4; Thu Sep  7 22:36:50 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Marco Mason <marco.mason@gmail.com>
Subject: [PATCH] Cygwin: Fix __cpuset_zero_s prototype
Date: Thu,  7 Sep 2023 22:36:39 -0700
Message-Id: <20230908053639.5689-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add a missing "void" to the prototype for __cpuset_zero_s().

Reported-by: Marco Mason <marco.mason@gmail.com>
Addresses: https://cygwin.com/pipermail/cygwin/2023-September/254423.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: c6cfc99648d6 (Cygwin: sys/cpuset.h: add cpuset-specific external functions)

---
 winsup/cygwin/include/sys/cpuset.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index a5a8fa81e..3d0874880 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -48,7 +48,7 @@ void __cpuset_free (cpu_set_t *);
 
 /* These _S macros operate on dynamically-sized cpu sets of size 'siz' bytes */
 #define CPU_ZERO_S(siz, set) __cpuset_zero_s (siz, set)
-static __inline
+static __inline void
 __cpuset_zero_s (__size_t siz, cpu_set_t *set)
 {
 #if __GNUC_PREREQ (2, 91)
-- 
2.39.0

