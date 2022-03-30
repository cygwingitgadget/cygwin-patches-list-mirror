Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 3A7673858C54
 for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2022 03:57:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3A7673858C54
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 22U3v0Vb019433;
 Wed, 30 Mar 2022 12:57:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 22U3v0Vb019433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1648612625;
 bh=qiaJ2fpiEfKf5ys8U+ahdzn64M0FGnJjZY7mDyud29A=;
 h=From:To:Cc:Subject:Date:From;
 b=W6yAOTegiWOaIgrjTQFL5/h+q01d394O5R4fYPFfc3L66WLcTKT+Ii5zjezP4X++d
 qK8vRUsXlbW0pFzMLaqciiw6DJcIuZG6rS8kjA6t5GPOWFtF4bzb9XZ7YOMrD4qU9r
 x8d6Ppw3X8jCI8smjaohqK5x/KZrjJtbb9yjFUGsVq9L3tKv5d8TiEB4kS0YQfcU6H
 Wy1LJsoPnLJ+rfnaMS2TMrOk9bGPCoAyuXmcsR6uIes3Js3chYw0x1XSEtkNVXSjpV
 CBNnnqT2+oe9zl7a7QpgweB1eW1Q2HrGerT9fxfqw8LivtrzmVr8rGkstEjQ/0t/6p
 PGhwkUf4LIpAQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix crash on master close in Windows 7.
Date: Wed, 30 Mar 2022 12:56:57 +0900
Message-Id: <20220330035657.9779-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 30 Mar 2022 03:57:25 -0000

- The 4th parameter of WriteFile() cannot be NULL especially in
  Windows 7 as mentioned in Microsoft documentation. This patch
  fixes that.

Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251162.html
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 winsup/cygwin/release/3.3.5   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e29b93ceb..4cb5f1411 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2106,7 +2106,7 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  get_ttyp ()->stop_fwd_thread = true;
-	  WriteFile (to_master_nat, "", 0, NULL, NULL);
+	  WriteFile (to_master_nat, "", 0, &len, NULL);
 	  master_fwd_thread->detach ();
 	}
     }
diff --git a/winsup/cygwin/release/3.3.5 b/winsup/cygwin/release/3.3.5
index d2a7f772a..9d44c1b79 100644
--- a/winsup/cygwin/release/3.3.5
+++ b/winsup/cygwin/release/3.3.5
@@ -43,3 +43,6 @@ Bug Fixes
 
 - Fix a formatting problem in gmondump where all displayed addresses are
   mistakenly prefixed with "0x0x".
+
+- Fix crash on pty master close in Windows 7.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251162.html
-- 
2.35.1

