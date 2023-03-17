Return-Path: <SRS0=t9Gj=7J=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0007.auone-net.jp (snd00012.auone-net.jp [111.86.247.12])
	by sourceware.org (Postfix) with ESMTPS id 7971538582B0
	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2023 14:44:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7971538582B0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from localhost.localdomain by dmta0007.auone-net.jp with ESMTP
          id <20230317144428101.DWWW.36104.localhost.localdomain@dmta0007.auone-net.jp>;
          Fri, 17 Mar 2023 23:44:28 +0900
From: YO4 <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: YO4 <ysno@ac.auone-net.jp>
Subject: [PATCH 1/3] fix unlink in container
Date: Fri, 17 Mar 2023 23:43:44 +0900
Message-Id: <20230317144346.871-2-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <20230317144346.871-1-ysno@ac.auone-net.jp>
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Deleting files returns STATUS_INVALID_PARAMETE on a bind mounted file system in hyper-v container with FILE_DISPOSITION_POSIX_SEMANTICS.
Therefore fall back to default method.

This code is suggeted by dscho and I change it more simple.
---
 winsup/cygwin/syscalls.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 5c7f46a99..ac89888ce 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -731,7 +731,10 @@ _unlink_nt (path_conv &pc, bool shareable)
       /* Trying to delete in-use executables and DLLs using
          FILE_DISPOSITION_POSIX_SEMANTICS returns STATUS_CANNOT_DELETE.
 	 Fall back to the default method. */
-      if (status != STATUS_CANNOT_DELETE)
+      /* Additionaly that returns STATUS_INVALID_PARAMETER
+         on a bind mounted fs in hyper-v container. Falling back too. */
+      if (status != STATUS_CANNOT_DELETE
+          && status != STATUS_INVALID_PARAMETER)
 	goto out;
     }
 
-- 
2.40.0.windows.1

