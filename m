Return-Path: <SRS0=t9Gj=7J=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0007.auone-net.jp (snd00006.auone-net.jp [111.86.247.6])
	by sourceware.org (Postfix) with ESMTPS id 34C273850841
	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2023 14:44:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 34C273850841
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from localhost.localdomain by dmta0007.auone-net.jp with ESMTP
          id <20230317144439179.DWWY.36104.localhost.localdomain@dmta0007.auone-net.jp>;
          Fri, 17 Mar 2023 23:44:39 +0900
From: YO4 <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: YO4 <ysno@ac.auone-net.jp>
Subject: [PATCH 3/3] log disabling posix semantics
Date: Fri, 17 Mar 2023 23:43:46 +0900
Message-Id: <20230317144346.871-4-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <20230317144346.871-1-ysno@ac.auone-net.jp>
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/syscalls.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 69699c8aa..ca40681cd 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -736,6 +736,9 @@ _unlink_nt (path_conv &pc, bool shareable)
       if (status != STATUS_CANNOT_DELETE
           && status != STATUS_INVALID_PARAMETER)
 	goto out;
+      debug_printf ("NtSetInformationFile (%S, FileDispositionInformationEx)"
+                    " returns %y with posix semantics. Disable it and retry.",
+                    pc.get_nt_native_path (), status);
     }
 
   /* If the R/O attribute is set, we have to open the file with
@@ -2689,6 +2692,11 @@ skip_pre_W10_checks:
              on a bind mounted file system in hyper-v container
              with FILE_RENAME_POSIX_SEMANTICS.
              Disable the use_posix semntics flag and retry. */
+          debug_printf ("NtSetInformationFile "
+                        "(%S, %S, FileRenameInformationEx) failed "
+                        "with posix semantics. Disable it and retry.",
+                        oldpc.get_nt_native_path (),
+                        newpc.get_nt_native_path ());
           use_posix_semantics = 0;
           goto ignore_posix_semantics_retry;
         }
-- 
2.40.0.windows.1

