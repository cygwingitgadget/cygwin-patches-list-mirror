Return-Path: <SRS0=Y5co=SO=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id B7CFC3858D35
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 08:11:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B7CFC3858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B7CFC3858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732003910; cv=none;
	b=G874iyOyRibL9kwszkCduxnDj4S3pHfaYWEa3nzzKRoFR2MOcVUHfzfZkDFxJGzFgd4Vysaa7yc/KCi1Q0gjzvENRkCWGFe6U2pZpLsfR4FnZ/W8XpR7DcXbbQDno80A81gXSAjZVshRw1evMLqVXxbqdYSc1KX5TLwfpuiqhD0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732003910; c=relaxed/simple;
	bh=pjVSTGRqTdWjjNneIRg+bUrBlAA+IykoEPTcWtwZ2Qk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oFCFnVk9mCDjlToWASZwis5HGpURAOs0sUC4UGhy32yU/PHM51GD0uGLtcgqDPf7F018S2vhxaVyoQnbcQdpvGg6dIIeOSMoQX++Ez56+nlZDYm0Rnj2cHtCuqW3VP7hFvMcl6ecrVFchFHvZLuQoPIJcJW1HdYA9URXGl/BtSk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B7CFC3858D35
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4AJ8EmFc026310;
	Tue, 19 Nov 2024 00:14:48 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpd6gSvSZ; Tue Nov 19 00:14:42 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Add libaio to SUBLIBS built for Cygwin
Date: Tue, 19 Nov 2024 00:11:24 -0800
Message-ID: <20241119081133.57253-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Provide libaio.a for those projects (such as stress-ng) checking for
POSIX aio support by looking for this library at configure time.
A release note is provided for Cygwin 3.6.0.

Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: N/A (new code)

---
 winsup/cygwin/Makefile.am   | 6 +++++-
 winsup/cygwin/release/3.6.0 | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 376c79fc3..50029749f 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -550,7 +550,8 @@ SUBLIBS = \
 	libresolv.a \
 	librt.a \
 	libacl.a \
-	libssp.a
+	libssp.a \
+	libaio.a
 
 noinst_LIBRARIES = \
 	libdll.a \
@@ -666,6 +667,9 @@ libacl.a: $(LIB_NAME) sec/posixacl.o
 libssp.a: $(LIB_NAME) $(wildcard $(newlib_build)/libc/ssp/*.o)
 	$(AM_V_GEN)$(speclib) $^ $(@F)
 
+libaio.a: $(LIB_NAME) aio.o
+	$(AM_V_GEN)$(speclib) $^ $(@F)
+
 #
 # all
 #
diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
index ddb303b15..468a2ab24 100644
--- a/winsup/cygwin/release/3.6.0
+++ b/winsup/cygwin/release/3.6.0
@@ -13,6 +13,9 @@ What's new:
   Windows attributes FILE_ATTRIBUTE_PINNED and FILE_ATTRIBUTE_UNPINNED.
   Add matching 'p' and 'u' mode bits in chattr(1) and lsattr(1).
 
+- New libaio.a provided for projects checking for POSIX aio support
+  by looking for this library at configure time.
+
 
 What changed:
 -------------
-- 
2.45.1

