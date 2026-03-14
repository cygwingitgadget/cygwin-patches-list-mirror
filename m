Return-Path: <SRS0=giYG=BO=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 5D9E74BC7EC4
	for <cygwin-patches@cygwin.com>; Sat, 14 Mar 2026 05:02:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D9E74BC7EC4
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D9E74BC7EC4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773464544; cv=none;
	b=FTyxWsop98WcIoLVttQA5v43Hw1S0xVZB9/VPoWFhD6toF5zFyCjYtz2yDd9UcVzvL39NMPUup76sGVWQuLnSTb813qYLY4MT5WYUpgWihWIde80yIBR8tKB9qkNRhE7Cge1xijwyuC+5RZ1xKR9jV07Pi/TswiZqOA+fjvFT/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773464544; c=relaxed/simple;
	bh=h/MLwjdbGnEJ7ksDHGGAmGA4gklT1ARvVMM0khSNwrI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=As35MpIFPavOyKdZOzDYBrTIbskXBa3U20AZ6wfvquRgeUhli7B2F5UKjRCQcf9EWV/LyU1YbKmmD3i3J32i9cf0zDTNktStQHWA25surwxvjNGDgKvSyo0OfhoVFQx82bCUx3cgmH8+0gZT5deBxiOSb9s3bVY+bsvFkcV1u9c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D9E74BC7EC4
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 62E5IkO9015103;
	Fri, 13 Mar 2026 22:18:46 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdac5ie2; Fri Mar 13 21:18:38 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Fix typo in 3.7.0 release note
Date: Fri, 13 Mar 2026 22:01:58 -0700
Message-ID: <20260314050219.1382-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 74594f33e030 (Cygwin: add resource limit changes to release notes)
Signed-off-by: Mark Geisert <mark@maxrnd.com>

---
 winsup/cygwin/release/3.7.0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
index bf76448fc..4736fd17c 100644
--- a/winsup/cygwin/release/3.7.0
+++ b/winsup/cygwin/release/3.7.0
@@ -8,6 +8,6 @@ What's new:
 - Support for cross-module overriding of additional new/delete overloads
   introduced in C++14 and C++17.
 
-- Improved support for sort and hard limits in setrlimit(2), support
+- Improved support for soft and hard limits in setrlimit(2), support
   RLIMIT_NPROC.
 
-- 
2.51.0

