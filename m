Return-Path: <SRS0=k5uY=VS=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 886B23858D26
	for <cygwin-patches@cygwin.com>; Thu, 27 Feb 2025 06:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 886B23858D26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 886B23858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740638192; cv=none;
	b=QgTXDbTv1nSCA3GPQA6Bzi4SryTweEZNrizAvPEDu2G6b+lC3lXvg7dv9kIwbbohaxtWRX2Sc9l/ar97vBiQhBm7OxL0CFgucY1H/EQYpU/mcw6IKj5E6zAWFYHXSLXGIG75VslbZnx4K9RiJGvUA+ZZTh+xqwThxOgFeIvLllY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740638192; c=relaxed/simple;
	bh=5iGc3IqHm65POJb18UCbI2TscsSmhT1r6C6KynLNgSo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d7eori8vMW6PTyUwXWlhJObFyjo2GBSEXJsK58HI+M/a91/FW7a8nYLn3UsWd7K1412k89qIGy5GqURvCGB5UU4nCWXUv7yO80IHf2ySNAXpxPgYcGgUQdAqSiqIJMbuXKp5Vg0L0/ynZF5xMCWfEXCH4O9XNhYVoP4Z9YydoOw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 886B23858D26
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 51R6g8NT096764;
	Wed, 26 Feb 2025 22:42:08 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdiLPbZp; Wed Feb 26 22:42:02 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3] Cygwin: Add spawn family of functions to docs
Date: Wed, 26 Feb 2025 22:35:38 -0800
Message-ID: <20250227063608.53165-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013425.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013425.html>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In the doc tree, add a new section "Other system interfaces[...]" that
lists the spawn family of functions, most of the exposed cygwin internal
functions that a user might have use for, and some other functions
duplicating Windows or DOS interfaces that might have some utility.

---
 winsup/doc/posix.xml | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 43e860b0d..748f243f6 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1762,6 +1762,38 @@ ISO®/IEC DIS 9945 Information technology
 
 </sect1>
 
+<sect1 id="std-other"><title>Other system interfaces, some from Windows:</title>
+
+<screen>
+    _get_osfhandle             (Windows)
+    _setmode                   (Windows)
+    cwait                      (Windows)
+    cygwin_attach_handle_to_fd
+    cygwin_conv_path
+    cygwin_conv_path_list
+    cygwin_create_path
+    cygwin_detach_dll
+    cygwin_dll_init
+    cygwin_internal
+    cygwin_logon_user
+    cygwin_posix_path_list_p
+    cygwin_set_impersonation_token
+    cygwin_split_path
+    cygwin_stackdump
+    cygwin_umount
+    cygwin_winpid_to_pid
+    spawnl                     (Windows)
+    spawnle                    (Windows)
+    spawnlp                    (Windows)
+    spawnlpe                   (Windows)
+    spawnv                     (Windows)
+    spawnve                    (Windows)
+    spawnvp                    (Windows)
+    spawnvpe                   (Windows)
+</screen>
+
+</sect1>
+
 <sect1 id="std-notes"><title>Implementation Notes</title>
 
 <para><function>chroot</function> only emulates a chroot function call
-- 
2.45.1

