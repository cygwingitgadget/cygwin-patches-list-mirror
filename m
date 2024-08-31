Return-Path: <SRS0=i6B1=P6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id DD2603858D28
	for <cygwin-patches@cygwin.com>; Sat, 31 Aug 2024 19:47:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD2603858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD2603858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725133637; cv=none;
	b=p3hSf+E8xQhwNDMZtbTvgvbYQ7g4GIm3JpwmSAspxzt600qJbsTp2m6gzqZitlHjS5aW8nkvPsJTAJ3/rCn6Sa6YrohchTtdARSbNJ6dqXvqq7omWbupEwu+7iie+HDFnlwlBBskrjsJd4mcdoE2ck3PKM3Yrx5irmfh8TxSlZw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725133637; c=relaxed/simple;
	bh=8u4ROzQEH3QpEFV+xAvefMykKwWd+Sll5Vpx57NKR9I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ODPD+rABAKANlGr+Pw+GCA9Lds6lL+Qd1EGB7ohGrPRP5jobj+UxgtHPnsH9BL8KFW+C/iZLusHDtMWjkCBovwp/zVaUGWtHEOQpF3/0hKU8NfU5P0IVRGt7R494qcFbqZ07lcIZoaC4ERqMXRhbwfdv3rMryAZccDwPP9S8l+E=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20240831194712848.QOPV.13595.localhost.localdomain@nifty.com>;
          Sun, 1 Sep 2024 04:47:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Jim Reisert AD1C <jjreisert@alum.mit.edu>
Subject: [PATCH] Cygwin: pipe: Fix a regression that raw_write() slows down
Date: Sun,  1 Sep 2024 04:46:44 +0900
Message-ID: <20240831194655.1555-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1725133632;
 bh=9599HgtZkYQGFlEEW7kOdLU7NE4xLBl2PJZNt/E5Skc=;
 h=From:To:Cc:Subject:Date;
 b=D38XpgmwBa0XEKbOOHbwsSDbUwTToUT4X6kEkwNqo132K5WlXShUCpLb7JYpRtCeetsNmdda
 vHNGRxVvWqykpWZYPm1EVE9sTK2jUCwBBhgnkqbWoumd/eiXCPkG3xIWcfHSlioXfxNxjGgO6N
 LRX6JQw2X3fF8EfMKI2z1mz5xeuJgyCG8wfHk20pvZAAchMqI5JNLHoeyUk+i4lyaZ0sdbpySN
 0jUvV2LDjE5wpYfHHU/yCjUBpny+fe07WU5A4snLjdfgAv8LCqZGqZiEzVKMwUpjv836vFo8Xj
 C9laiRTpFJUrKgKNQQLKsXlx2hNGlMjLabO3Og9Nm48iL0BA==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit 7f3c22532577, writing to pipe extremely slows down.
This is because cygwait(select_sem, 10, cw_cancel) is called even
when write operation is already completed. With this patch, the
cygwait() is called only if the write operation is not completed.

Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256398.html
Fixes: 7f3c22532577 ("Cygwin: pipe: handle signals explicitely in raw_write")
Reported-by: Jim Reisert AD1C <jjreisert@alum.mit.edu>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 6 ++++--
 winsup/cygwin/release/3.5.5    | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 852076ccc..c686df650 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -518,8 +518,9 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 		      raise (SIGPIPE);
 		      goto out;
 		    }
-		  else
-		    cygwait (select_sem, 10, cw_cancel);
+		  /* Break out on completion */
+		  if (waitret == WAIT_OBJECT_0)
+		    break;
 		  /* If we got a timeout in the blocking case, and we already
 		     did a short write, we got a signal in the previous loop. */
 		  if (waitret == WAIT_TIMEOUT && short_write_once)
@@ -527,6 +528,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
 		      waitret = WAIT_SIGNALED;
 		      break;
 		    }
+		  cygwait (select_sem, 10, cw_cancel);
 		}
 	      /* Loop in case of blocking write or SA_RESTART */
 	      while (waitret == WAIT_TIMEOUT || waitret == WAIT_SIGNALED);
diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index a98687c26..904119a38 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -4,3 +4,6 @@ Fixes:
 - Fix undesired behaviour of console master thread in win32-input-mode
   which is supported by Windows Termainal.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256380.html
+
+- Fix a regression in 3.5.4 that writing to pipe extremely slows down.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256398.html
-- 
2.45.1

