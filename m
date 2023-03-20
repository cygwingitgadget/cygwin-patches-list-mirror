Return-Path: <SRS0=aWaS=7M=ac.auone-net.jp=ysno@sourceware.org>
Received: from dmta0005.auone-net.jp (snd00007.auone-net.jp [111.86.247.7])
	by sourceware.org (Postfix) with ESMTPS id 333EE3854830
	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2023 11:51:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 333EE3854830
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=ac.auone-net.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ac.auone-net.jp
Received: from DELL-39.sekkei.local by dmta0005.auone-net.jp with ESMTP
          id <20230320115140279.GZXO.37033.DELL-39.sekkei.local@dmta0005.auone-net.jp>;
          Mon, 20 Mar 2023 20:51:40 +0900
From: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
To: cygwin-patches@cygwin.com
Cc: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
Subject: [PATCH 2/3] fix rename in container
Date: Mon, 20 Mar 2023 20:51:01 +0900
Message-Id: <20230320115102.1692-3-ysno@ac.auone-net.jp>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230320115102.1692-1-ysno@ac.auone-net.jp>
References: <ZBS8aRN0HDdm3yZM@calimero.vinschen.de>
 <20230320115102.1692-1-ysno@ac.auone-net.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Renaming files returns STATUS_INVALID_PARAMETE on a bind mounted file system
in hyper-v container with FILE_RENAME_POSIX_SEMANTICS.

Disable the use_posix_semantics flag and retry.

Signed-off-by: Yoshinao Muramatsu <ysno@ac.auone-net.jp>
---
 winsup/cygwin/syscalls.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 7430fad65..57bfab9d3 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2427,6 +2427,7 @@ rename2 (const char *oldpath, const char *newpath, unsigned int at2flags)
 			    && !oldpc.isremote ()
 			    && oldpc.fs_is_ntfs ();
 
+ignore_posix_semantics_retry:
       /* Opening the file must be part of the transaction.  It's not sufficient
 	 to call only NtSetInformationFile under the transaction.  Therefore we
 	 have to start the transaction here, if necessary.  Don't start
@@ -2671,6 +2672,15 @@ skip_pre_W10_checks:
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
2.37.3.windows.1

