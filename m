Return-Path: <SRS0=ktEJ=DH=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 2D1FE4BA2E30
	for <cygwin-patches@cygwin.com>; Sun, 10 May 2026 07:35:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2D1FE4BA2E30
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2D1FE4BA2E30
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778398515; cv=none;
	b=JPs/PWvevdLCw/znpSQvUngTp7zpG+D/f6wS7tTZISSIZ3zF6NYek/PHa851uMy7Po+YhsJvM3cmCsQCNXGWU6RaUdSGS20biSWxvHwi0c4IacTzeu/kdjliq3y9T6Z8bOgyl+RvlFiI4tJ/XR2cHupLTIbaJV0/ke1O9OMqQao=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778398515; c=relaxed/simple;
	bh=tuoHYD1ofQMqBBKd4Y/65eLxX3bxtLwGaJOrRTzJXzs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YCUesJJTGvfEnnuzrh7n3BRdo+8TW80QnyT1ea4irfuMkCZ5aYGCi70gx+gWwQZF3xLfIMdKyBIoT7qmftQsi+wiT908IEBimjTNodKzXQiKke9NeBAvOBfwoKrmhm18cYLGyO5qiO8YdQYr4olotOHKhLT8H/AC6zIwq+iZKts=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2D1FE4BA2E30
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 64A7onRp085698;
	Sun, 10 May 2026 00:50:49 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdFeSDka; Sun May 10 00:50:44 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH] Cygwin: Ensure unused handle available for open()
Date: Sun, 10 May 2026 00:34:50 -0700
Message-ID: <20260510073511.1346-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The existing logic for open() assumes a handle is always available in
the fdtable for a created file.  This leads to a situation where, if
there is no handle available, the file is created but cannot be
referenced by a Cygwin fd.

Update the code to check for an available handle before creating a file.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)

---
 winsup/cygwin/fhandler/base.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/fhandler/base.cc b/winsup/cygwin/fhandler/base.cc
index 5321ad7ff..d38669d5d 100644
--- a/winsup/cygwin/fhandler/base.cc
+++ b/winsup/cygwin/fhandler/base.cc
@@ -539,6 +539,12 @@ fhandler_base::open (int flags, mode_t mode)
   syscall_printf ("(%S, %y)%s", pc.get_nt_native_path (), flags,
 				get_handle () ? " by handle" : "");
 
+  /* If no handle is supplied, ensure an unused one is available */
+  if (!get_handle () && cygheap->fdtab.find_unused_handle () == -1)
+    {
+      /* errno has been set to EMFILE */
+      return res;
+    }
   if (flags & O_PATH)
     query_open (query_read_attributes);
 
-- 
2.51.0

