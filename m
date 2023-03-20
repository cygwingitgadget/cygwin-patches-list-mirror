Return-Path: <SRS0=aWaS=7M=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0005.auone-net.jp (snd00001.auone-net.jp [111.86.247.1])
	by sourceware.org (Postfix) with ESMTPS id 4E20E3851143
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 11:51:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4E20E3851143
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from DELL-39.sekkei.local by dmta0005.auone-net.jp with ESMTP
          id <20230320115135274.GZXM.37033.DELL-39.sekkei.local@dmta0005.auone-net.jp>;
          Mon, 20 Mar 2023 20:51:35 +0900
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Subject: [PATCH 1/3] fix unlink in container
Date: Mon, 20 Mar 2023 20:51:00 +0900
Message-Id: <20230320115102.1692-2-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230320115102.1692-1-ysno@ac.auone-net.jp>
References: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <20230320115102.1692-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Deleting files returns STATUS_INVALID_PARAMETE on a bind mountedfile system
in hyper-v container with FILE_DISPOSITION_POSIX_SEMANTICS.
Therefore fall back to default method.

This code is suggeted by Johannes Schindelin on github
and I change it more simple.

Signed-off-by: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
---
 winsup/cygwin/syscalls.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 8ae0397fb..7430fad65 100644
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
2.37.3.windows.1

