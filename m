Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id B47CB3857B90
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 11:42:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B47CB3857B90
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B47CB3857B90
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750851739; cv=none;
	b=e/Jeo2+B8MQDK7J4kqHb5Kx9n5logDpjC50eF/BgcZPthzBvJoSNuGip/o58lo0JwUi4kME1IqErpsMatpm4aWt2fv6vkdwFB1cL/ovm2Y0oKO+3+x/+3b9ptcS8W9ly8S5UcEuSjJTNEU3cY/vtvABMWpwNNjP5ATu2ywN/jOI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750851739; c=relaxed/simple;
	bh=JrxTKtsZk8luQAHsK+VphSkn++z266RLmF9kABwOJLc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Sipa5CbUR5w8FHsRcBig0zbRZeJRUvzMWUO9PKiJWn/o9kqvkipgpnZ678B2M8l/xMdSVgsqCDuGCStsh53fIAthXp+OtDoh0pgVHt5CyZZF2Kwz/U/U0SSglH4y8geoLSBy/EIOCPgBPDvmBGs42WYVN/BPipAV/B7Jf3ZH4V8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B47CB3857B90
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SuelDQw2
Received: from localhost.localdomain by mta-snd-w04.mail.nifty.com
          with ESMTP
          id <20250625114216823.OLIZ.52630.localhost.localdomain@nifty.com>;
          Wed, 25 Jun 2025 20:42:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (stop to use chunk)
Date: Wed, 25 Jun 2025 20:41:55 +0900
Message-ID: <20250625114202.927-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750851736;
 bh=f8gOLGpSNKFzLPvUV82uiXvzhVUGDEjev8JaCQeNovY=;
 h=From:To:Cc:Subject:Date;
 b=SuelDQw2rZ8xW3kKtoKCyfvRLzVDYYmfkNoKmcdtjaF2YdbT++LLm4/DoSok6UN8UwOHHS7h
 BIX4ulKoz+KP7KZbTH7hCn6h3QUapbQAGtAoGLdiXyBkcbfCWgCxNCDTZ9tZePZHDgANQs9s6/
 cNn4sq8t3kRuMtN5lkkLB6HL2Ja20+7Xt88i/ikT5GHdS4KsCPIz63LCNrl5p8LfnDxr3FzT90
 LL4CsoLyF84wficuLKjV4XUICk3bccPTW09w5xVF/mlcYSPqzlJVJxviLO/pTInVuQLrTTwvMt
 7QyRJJvwJeA/nOSHMSY/vAe0k0CN04ZU3Yi4Zu8TPLwrxdYQ==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index e35d523bb..c35411abf 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -443,7 +443,6 @@ ssize_t
 fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 {
   size_t nbytes = 0;
-  ULONG chunk;
   NTSTATUS status = STATUS_SUCCESS;
   IO_STATUS_BLOCK io;
   HANDLE evt;
@@ -540,11 +539,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	}
     }
 
-  if (len <= (size_t) avail)
-    chunk = len;
-  else
-    chunk = avail;
-
   if (!(evt = CreateEvent (NULL, false, false, NULL)))
     {
       __seterrno ();
@@ -561,8 +555,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       ULONG len1;
       DWORD waitret = WAIT_OBJECT_0;
 
-      if (left > chunk && !is_nonblocking ())
-	len1 = chunk;
+      if (left > (size_t) avail && !is_nonblocking ())
+	len1 = (ULONG) avail;
       else
 	len1 = (ULONG) left;
 
-- 
2.45.1

