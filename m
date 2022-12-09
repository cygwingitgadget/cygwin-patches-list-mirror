Return-Path: <SRS0=TymB=4H=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
	by sourceware.org (Postfix) with ESMTPS id 5AB7138B0BF1
	for <cygwin-patches@cygwin.com>; Fri,  9 Dec 2022 00:50:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5AB7138B0BF1
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj135041.dynamic.ppp.asahi-net.or.jp [220.150.135.41]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 2B90ncwK005574;
	Fri, 9 Dec 2022 09:49:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 2B90ncwK005574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1670546983;
	bh=BmXCR+YwM9XnjECnQiyK/OqrIaL+FoDOJbPIlflJJoM=;
	h=From:To:Cc:Subject:Date:From;
	b=xH0CwzdDys4oD/SYg3V2b3s8RgutfQiZcTG6esFHmLMliWxN7YS8+2g99yLR/0Vua
	 z4qFdm56LheVlkX5S8ng2ikJbh37TmAwUKD0QWjCp0UYPU7gOJUWEZtCYa1GkTKSKQ
	 r4A/UCBfkyIH5aeTjqt2Nt3TMSU/SS8oLlszujLBjvzRya8wyy/zBT6buaDJpSikHU
	 Wm3OhvpxQ7pQB3w3W8zDrY31B6w+44cphAXjFiWZ0dNuuL/HzUvSgMAtZHxAYrmkVn
	 N4iZN7qnCQcKQFr8ypgMKAWv0MGOmIL3XEZNONKeIT7qA8fYkMv81wp1BXZB2v4CBJ
	 a53z/nB5rVoKg==
X-Nifty-SrcIP: [220.150.135.41]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>, tryandbuy <tryandbuy@proton.me>,
        Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH] Cygwin: pipe: Fix performance degradation for non-cygwin pipe.
Date: Fri,  9 Dec 2022 09:49:27 +0900
Message-Id: <20221209004927.614-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

https://cygwin.com/pipermail/cygwin/2022-December/252628.html

After the commit 9e4d308cd592, the performance of read from non-cygwin
pipe has been degraded. This is because select_sem mechanism does not
work for non-cygwin pipe. This patch fixes the issue.

Fixes: 9e4d308cd592 ("Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT
flag for read pipe.")
Reported-by: tryandbuy <tryandbuy@proton.me>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 16 +++++++++++++++-
 winsup/cygwin/release/3.4.1    |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 720e4efd3..e23131668 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -281,6 +281,8 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
   size_t nbytes = 0;
   NTSTATUS status = STATUS_SUCCESS;
   IO_STATUS_BLOCK io;
+  ULONGLONG t0 = GetTickCount64 (); /* Init timer */
+  const ULONGLONG t0_threshold = 20;
 
   if (!len)
     return;
@@ -312,6 +314,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
     {
       ULONG_PTR nbytes_now = 0;
       ULONG len1 = (ULONG) (len - nbytes);
+      DWORD select_sem_timeout = 0;
 
       FILE_PIPE_LOCAL_INFORMATION fpli;
       status = NtQueryInformationFile (get_handle (), &io,
@@ -358,7 +361,18 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
 		  nbytes = (size_t) -1;
 		  break;
 		}
-	      waitret = cygwait (select_sem, 1);
+	      /* If the pipe is a non-cygwin pipe, select_sem trick
+		 does not work. As a result, the following cygwait()
+		 will return only after timeout occurs. This causes
+		 performance degradation. However, setting timeout
+		 to zero causes high CPU load. So, set timeout to
+		 non-zero only when select_sem is valid or pipe is
+		 not ready to read for more than t0_threshold.
+		 This prevents both the performance degradation and
+		 the high CPU load. */
+	      if (select_sem || GetTickCount64 () - t0 > t0_threshold)
+		select_sem_timeout = 1;
+	      waitret = cygwait (select_sem, select_sem_timeout);
 	      if (waitret == WAIT_CANCELED)
 		pthread::static_cancel_self ();
 	      else if (waitret == WAIT_SIGNALED)
diff --git a/winsup/cygwin/release/3.4.1 b/winsup/cygwin/release/3.4.1
index 432113a55..afe7e86f9 100644
--- a/winsup/cygwin/release/3.4.1
+++ b/winsup/cygwin/release/3.4.1
@@ -8,3 +8,6 @@ Bug Fixes
 - Fix a backward incompatibility problem in the definition of the
   base type of the stdio type FILE.
   Addresses: https://savannah.gnu.org/bugs/index.php?63480
+
+- Fix performance degradation of non-cygwin pipe.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-December/252628.html
-- 
2.38.1

