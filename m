Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 73247385782D
 for <cygwin-patches@cygwin.com>; Thu, 17 Mar 2022 03:02:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 73247385782D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 22H32MK8080365;
 Wed, 16 Mar 2022 20:02:22 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdnAuGPV; Wed Mar 16 19:02:18 2022
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: document recent gmondump formatting fix
Date: Wed, 16 Mar 2022 20:02:07 -0700
Message-Id: <20220317030207.16529-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2022q1/011849.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2022q1/011849.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 17 Mar 2022 03:02:29 -0000

---
 winsup/cygwin/release/3.3.5 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/winsup/cygwin/release/3.3.5 b/winsup/cygwin/release/3.3.5
index 752d65703..d2a7f772a 100644
--- a/winsup/cygwin/release/3.3.5
+++ b/winsup/cygwin/release/3.3.5
@@ -40,3 +40,6 @@ Bug Fixes
 - Fix a problem that fsync() flushes the console input buffer unlike
   linux. fsync() should return EINVAL for special files such as tty.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251022.html
+
+- Fix a formatting problem in gmondump where all displayed addresses are
+  mistakenly prefixed with "0x0x".
-- 
2.35.1

