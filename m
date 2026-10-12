Return-Path: <SRS0=Fa+Q=IC=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4C7BA4BA23D1
	for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2026 09:04:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4C7BA4BA23D1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4C7BA4BA23D1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791795890; cv=none;
	b=w+7tcvH8yZLCxFOWKnhwDJSItBgyoIn578ccAmC047PNWVu4Ohp2E6eUNqwa5vyf7QEBoqxhaKySVQkUv8URx5PjrpbXqJdyuKAJKi28zVJbPnpHbsGoNvsVtwag9OqYPiQnibdCzmYWCOy5lDBDjlf2fSxE2WmONt0i/7DrquM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791795890; c=relaxed/simple;
	bh=vlkLgwZWJUXmik4qT7NcjZZ0qWWSAbaFvqokn9cS/eo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WybtyorTZTuxJrA+/2ebgs1UY8Nnl8t9ViijKafEGyeNHUQk0VH0jgsgfSLzVJHlpIBE+/Dlu32pyJSc4frESatMvgNTf8sPH5fghpCeIesAW4L2VG2x+6uQh+yOvsxzR8tMoAv+srpRyUmRui5bPhhCMyJL24DhIvwNFH/YuXU=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4C7BA4BA23D1
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69C9IKna064754;
	Mon, 12 Oct 2026 02:18:20 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdoP4BKe; Mon Oct 12 02:18:16 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Rename orphan __progname variable
Date: Mon, 12 Oct 2026 02:04:28 -0700
Message-ID: <20261012090437.1672-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The last remaining occurrence of '__progname' in dcrt0.cc was missed
when they were being renamed to 'program_invocation_short_name'.  I
discovered this when doing my first "#define DEBUGGING" Cygwin build.

Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: b2476bc (Cygwin: globals: make __progname an alias of
program_invocation_short_name)

---
 winsup/cygwin/dcrt0.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index e7a837673..7fe8f26ac 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -968,7 +968,7 @@ dll_crt0_1 (void *)
   /* Disable case-insensitive globbing */
   ignore_case_with_glob = false;
 
-  cygbench (__progname);
+  cygbench (program_invocation_short_name);
 
   ld_preload ();
   /* Per POSIX set the default application locale back to "C". */
-- 
2.51.0

