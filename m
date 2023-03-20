Return-Path: <SRS0=aWaS=7M=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0005.auone-net.jp (snd00010.auone-net.jp [111.86.247.10])
	by sourceware.org (Postfix) with ESMTPS id 99438385020B
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 11:51:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 99438385020B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from DELL-39.sekkei.local by dmta0005.auone-net.jp with ESMTP
          id <20230320115145026.GZXQ.37033.DELL-39.sekkei.local@dmta0005.auone-net.jp>;
          Mon, 20 Mar 2023 20:51:45 +0900
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Subject: [PATCH 3/3] log disabling posix semantics
Date: Mon, 20 Mar 2023 20:51:02 +0900
Message-Id: <20230320115102.1692-4-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230320115102.1692-1-ysno@ac.auone-net.jp>
References: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <20230320115102.1692-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add log when workaround occurs

Signed-off-by: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
---
 winsup/cygwin/syscalls.cc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 57bfab9d3..bc93c16d8 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -735,7 +735,11 @@ _unlink_nt (path_conv &pc, bool shareable)
          on a bind mounted fs in hyper-v container. Falling back too. */
       if (status != STATUS_CANNOT_DELETE
           && status != STATUS_INVALID_PARAMETER)
-	goto out;
+        {
+          debug_printf ("NtSetInformationFile returns %y "
+                        "with posix semantics. Disable it and retry.", status);
+          goto out;
+        }
     }
 
   /* If the R/O attribute is set, we have to open the file with
@@ -2678,6 +2682,8 @@ skip_pre_W10_checks:
              on a bind mounted file system in hyper-v container
              with FILE_RENAME_POSIX_SEMANTICS.
              Disable the use_posix semntics flag and retry. */
+          debug_printf ("NtSetInformationFile failed with posix semantics. "
+                        "Disable it and retry.");
           use_posix_semantics = 0;
           goto ignore_posix_semantics_retry;
         }
-- 
2.37.3.windows.1

