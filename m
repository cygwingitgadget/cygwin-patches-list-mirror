Return-Path: <SRS0=t9Gj=7J=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0007.auone-net.jp (snd00007.auone-net.jp [111.86.247.7])
	by sourceware.org (Postfix) with ESMTPS id CFE5F3851142
	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2023 14:44:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CFE5F3851142
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from localhost.localdomain by dmta0007.auone-net.jp with ESMTP
          id <20230317144433531.DWWX.36104.localhost.localdomain@dmta0007.auone-net.jp>;
          Fri, 17 Mar 2023 23:44:33 +0900
From: YO4 <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: YO4 <ysno@ac.auone-net.jp>
Subject: [PATCH 2/3] fix rename in container
Date: Fri, 17 Mar 2023 23:43:45 +0900
Message-Id: <20230317144346.871-3-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.40.0.windows.1
In-Reply-To: <20230317144346.871-1-ysno@ac.auone-net.jp>
References: <20230317144346.871-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Renaming files returns STATUS_INVALID_PARAMETE on a bind mounted file system in hyper-v container with FILE_RENAME_POSIX_SEMANTICS.

Disable the use_posix_semantics flag and retry.
---
 winsup/cygwin/syscalls.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index ac89888ce..69699c8aa 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2438,6 +2438,7 @@ rename2 (const char *oldpath, const char *newpath, unsigned int at2flags)
 			    && !oldpc.isremote ()
 			    && oldpc.fs_is_ntfs ();
 
+ignore_posix_semantics_retry:
       /* Opening the file must be part of the transaction.  It's not sufficient
 	 to call only NtSetInformationFile under the transaction.  Therefore we
 	 have to start the transaction here, if necessary.  Don't start
@@ -2682,6 +2683,15 @@ skip_pre_W10_checks:
 	    unlink_nt (*removepc);
 	  res = 0;
 	}
+      else if (use_posix_semantics && status == STATUS_INVALID_PARAMETER)
+        {
+          /* NtSetInformationFile returns STATUS_INVALID_PARAMETER
+             on a bind mounted file system in hyper-v container
+             with FILE_RENAME_POSIX_SEMANTICS.
+             Disable the use_posix semntics flag and retry. */
+          use_posix_semantics = 0;
+          goto ignore_posix_semantics_retry;
+        }
       else
 	__seterrno_from_nt_status (status);
     }
-- 
2.40.0.windows.1

