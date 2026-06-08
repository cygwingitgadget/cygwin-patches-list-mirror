Return-Path: <SRS0=Aeas=EE=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 18F424BA2E25
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 22:11:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 18F424BA2E25
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 18F424BA2E25
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780956666; cv=none;
	b=cO8u5hNZU1BePrpwGVb3qDYH2Bc/q5AwLD6XpyVTbFRLTSTgZkcohL4BMT28zTxPDCQgW/qCtJo0pIvEQPUTuoh0ZubiGd7QcLm1/fi+mFlEtcs6wyFTUaZ5cd2NTinuxzYPu2lKPPOMZbTu/ssDHlIE21pAoycKvGBVER6+JQU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780956666; c=relaxed/simple;
	bh=3/nlA0ap7WxgPX7/Nriw+UIfnmoZOqwwoIBHH7fZrWk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l8msMDO4km3YvXsfRyfcojHubHFFhOoWLX38wG+jcAcZMUU5U6QZYhIhWTjizloQ8ZymScjJR8uZKu78L2sYsWUiz5FbAgsoxLuL8NL0JEul2RCaGOPt9QtIK9h7SqU3XdrWSVQTDLxwmbDIPV3NCbRvGQW0D+OeT7UeIB7gpXc=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18F424BA2E25
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 658MQHSF084741;
	Mon, 8 Jun 2026 15:26:17 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdZK5JDC; Mon Jun  8 15:26:13 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Lionel Cons <lionelcons1972@gmail.com>
Subject: [PATCH] Cygwin: Fix chown commands in cygserver-config
Date: Mon,  8 Jun 2026 15:10:09 -0700
Message-ID: <20260608221103.958-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin/2026-June/259787.html>
References: <https://cygwin.com/pipermail/cygwin/2026-June/259787.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Change "chown 18.544" to "18:544" in two locations.

Reported-by: Lionel Cons <lionelcons1972@gmail.com>
Addresses: <https://cygwin.com/pipermail/cygwin/2026-June/259786.html>
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: b5a7cb02cd9d (* cygserver-config: Use numeric id 18 instead of "system" in chown.)

---
 winsup/cygserver/cygserver-config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygserver/cygserver-config b/winsup/cygserver/cygserver-config
index abda18644..3130de7bc 100755
--- a/winsup/cygserver/cygserver-config
+++ b/winsup/cygserver/cygserver-config
@@ -162,7 +162,7 @@ then
     exit 1
   fi
   chmod 664 "${SYSCONFDIR}/cygserver.conf"
-  chown 18.544 "${SYSCONFDIR}/cygserver.conf"
+  chown 18:544 "${SYSCONFDIR}/cygserver.conf"
 fi
 
 # On NT ask if cygserver should be installed as service
@@ -194,7 +194,7 @@ then
       echo "To start it, call \`net start ${service_name}' or \`cygrunsrv -S ${service_name}'."
     fi
     touch "${LOCALSTATEDIR}/log/cygserver.log"
-    chown 18.544 "${LOCALSTATEDIR}/log/cygserver.log"
+    chown 18:544 "${LOCALSTATEDIR}/log/cygserver.log"
   fi
 fi
 
-- 
2.51.0

