Return-Path: <SRS0=4MnB=TB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.121])
	by sourceware.org (Postfix) with ESMTPS id 730FD3858CDB
	for <cygwin-patches@cygwin.com>; Sun,  8 Dec 2024 07:44:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 730FD3858CDB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 730FD3858CDB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.121
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733643870; cv=none;
	b=osHR7ZkHXsCFnVejHhp6hpSYfblL+Vwp0sB+QyjANjJFX1dNk95c39Z9p/363nuiCCFvHfoJsGPhUSHr6iEeGiyNonRJq/WuqN1yS8yhT5SMqkVb+OueJ2o8pTU0NtWAVXkAYYiRTCVTuBCsIA8n6Yvt0bmBo5UqDk9040FDqg0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733643870; c=relaxed/simple;
	bh=K6O6Ie/5Y+luv+xBy9cs9leXTchpvQGUBcLutBA8ijo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=mvd5dNukueLUufz0b/reoBittYnh6O18T8JmWBKaIgU6bh0yzkjkBzhB3ycsVBZo2pVsvOZRbZqpkyHpsGWgnW9rUln8wNIgt2hI3xf3Xbgn6BYZNkZ02HzHbYoBaCqXnBqtTIY1xAvsDfcv51SzqXbi2sycO8UzbBuyZGHJaEE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 730FD3858CDB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G3oN3uyC
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20241208074427259.TRNZ.67063.localhost.localdomain@nifty.com>;
          Sun, 8 Dec 2024 16:44:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: disk_file: Add error handling to fhandler_base::fstat_helper
Date: Sun,  8 Dec 2024 16:43:51 +0900
Message-ID: <20241208074410.1772-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733643867;
 bh=ybDwkGRZ8ZCS01PP6xgJPmyx0/YGaGggmazzQAfTN/g=;
 h=From:To:Cc:Subject:Date;
 b=G3oN3uyCBozMjdeFzzk1wKjvue99YlDSSkFseiEHw3kwJ0KjReoBekrOfvmYJZQIqrJsElVa
 6W+oFEe2g/0M30kg/ONGgTX9ti42DxR8nJXWH+01NStg31CBrckZOFhtSczBNT5rqErTD8TOmY
 VdbBw067FezSTAKZyaC5xSh38F6C+6B1GV/s8IqAwy3Dj635FsaI6bPqKlk+/tfcpdmrBrU2+u
 4W+SPWnn5qfXOT46BQ5WyFN35xuw58FJS4+eorSKySa7NiW8m10aiuvT7HlGgEwm6F8GZoxw+u
 uD1SLohAlUmA7QPt/vejS+CO3l6E3uW5w1TXSC+Z13nQ04KQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previous fhandler_base::fstat_helper() does not assume get_stat_handle()
returns NULL. Due to this, access() for network share which has not been
authenticated returns 0 (success). This patch add error handling to
fhandler_base::fstat_helper() for get_stat_handle() failure.

Fixed: 5a0d1edba4b3 ("(fhandler_base::fstat_helper): Use handle returned by get_stat_handle.")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/disk_file.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler/disk_file.cc b/winsup/cygwin/fhandler/disk_file.cc
index 2008fb61b..7c3c805fd 100644
--- a/winsup/cygwin/fhandler/disk_file.cc
+++ b/winsup/cygwin/fhandler/disk_file.cc
@@ -400,6 +400,11 @@ fhandler_base::fstat_helper (struct stat *buf)
   IO_STATUS_BLOCK st;
   FILE_COMPRESSION_INFORMATION fci;
   HANDLE h = get_stat_handle ();
+  if (h == NULL)
+    {
+      __seterrno ();
+      return -1;
+    }
   PFILE_ALL_INFORMATION pfai = pc.fai ();
   ULONG attributes = pc.file_attributes ();
 
-- 
2.45.1

