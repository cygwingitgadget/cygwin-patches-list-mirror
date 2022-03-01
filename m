Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 by sourceware.org (Postfix) with ESMTPS id 6FD853858D20
 for <cygwin-patches@cygwin.com>; Tue,  1 Mar 2022 00:54:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6FD853858D20
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gentoo.org
Received: by smtp.gentoo.org (Postfix, from userid 559)
 id 1B8783432C9; Tue,  1 Mar 2022 00:54:38 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup: enable maintainer mode support
Date: Mon, 28 Feb 2022 19:54:39 -0500
Message-Id: <20220301005439.23139-1-vapier@gentoo.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_PASS, SPF_PASS, TXREP,
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
X-List-Received-Date: Tue, 01 Mar 2022 00:54:44 -0000

We do this in newlib & libgloss, so enable in winsup too for consistency.
---
 winsup/configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index b8d2100dbe90..6c6e1cb0893a 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -13,6 +13,7 @@ AC_INIT([Cygwin],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_AUX_DIR(..)
 AC_CANONICAL_TARGET
 AM_INIT_AUTOMAKE([dejagnu foreign no-define no-dist subdir-objects -Wall -Wno-portability -Wno-extra-portability])
+AM_MAINTAINER_MODE
 AM_SILENT_RULES([yes])
 
 realdirpath() {
-- 
2.34.1

