Return-Path: <SRS0=qSGf=SB=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id EDC553858D21
	for <cygwin-patches@cygwin.com>; Wed,  6 Nov 2024 08:44:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EDC553858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EDC553858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730882649; cv=none;
	b=YhuzQJa478OOQq7WdvjiSIwYIu8gTG/yxTzDKvbmNcc2a4oljoGmgmskFDESzg1xgkMVkWihyaBMtH272xr0Sl2hy6ZOKcusrnwgw0tTImn/BqZigJ2F/glHZwQHcCbh6627f5d74I89UKZFzCS87PPy5icRtXOeCkF7BB5R8Ds=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730882649; c=relaxed/simple;
	bh=vLTCalGS4/teX+J0sHftJNHrj8XaWqLovvVzogutwT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pcJBT9k3kOykwry165+NWsNs3bGzQc/u+f+eTzd2DC+S1uOZlT/EXtU9lpK/bug9PSC5idYYjYEQgpjyWTfUY7cQ2KLfeVILTMqYcVlyl1A96cmoghO91aggC0v8mtX+TxBGG5+dgEnCQAAK29sd5KFWljNKGi4gTectHK50vnE=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20241106084403808.QSBU.102422.localhost.localdomain@nifty.com>;
          Wed, 6 Nov 2024 17:44:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pipe: Fix incorrect write length in raw_write()
Date: Wed,  6 Nov 2024 17:43:36 +0900
Message-ID: <20241106084347.17347-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730882643;
 bh=E5rYb+V/q5XJFFC0kD5BbwNGAx7dWNLUE/hCcffuTXU=;
 h=From:To:Cc:Subject:Date;
 b=KzQwGaPxsqgAtQtRCpGVUs3OCYGQ/Imy/hM4PEd/HLvcLUIxu1AYiQh3jM4IjCZcB84/jaaL
 pkmA7F/p/DU06Gt4KwrBMUpFNWuKiifIzN60b1v5c1kpuVt9zbysU17Iok6r3AFKk98toVS3+q
 Jy8S/+LvBfUXzkFM4yr4iJrjrcivPnyG2VaSSsJGMl8Bnqk4C8bH8dOownNqnz+2qIEFt6fdU3
 BGjNi2FeXR+6TqrsM//oWBQ/TeRU5iGkj2MQzW3NyEgAVHFRmUjDCwRvdEaO0p8qlzbquNSJCO
 MGq1CupCG173Q427ZKvg3SoAK/KvILjlhlF8skbzHO8WQpFg==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If the write length is more than the pipe space in non-blocking
mode, the write length is wrongly set to 65536. This causes access
violation. This patch fixes that.

Fixes: 7ed9adb356df ("Cygwin: pipe: Switch pipe mode to blocking mode by default")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index a2729a119..76af6bc05 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -532,10 +532,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 	}
     }
 
-  if (len <= (size_t) avail || pipe_buf_size == 0)
+  if (len <= (size_t) avail)
     chunk = len;
-  else if (is_nonblocking ())
-    chunk = len = pipe_buf_size;
   else
     chunk = avail;
 
@@ -555,7 +553,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
       ULONG len1;
       DWORD waitret = WAIT_OBJECT_0;
 
-      if (left > chunk)
+      if (left > chunk && !is_nonblocking ())
 	len1 = chunk;
       else
 	len1 = (ULONG) left;
-- 
2.45.1

