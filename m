Return-Path: <SRS0=md63=RQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id C1A5A3858C78
	for <cygwin-patches@cygwin.com>; Sun, 20 Oct 2024 09:27:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C1A5A3858C78
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C1A5A3858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1729416443; cv=none;
	b=b46bQqobqji4fEYmKNY2PJFB43QjesagWItWRVwqAadR9WDRQlh7cjDZuDiHflOaaAYMwuiGIYURBq11yFgYCpRbVgffKXsrLOzROcoJGOKA1GI8Tb9mv3lfenc7hSDfs6FMY5YLXaRJNfK7IG+HUb2un4kEvjVm5vgE7paxjWM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1729416443; c=relaxed/simple;
	bh=x0tiLYlhlrThj5AcSTqA+/JsRNXMakgq9JXmgT/rXPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Av0929SCYc64pLv9DueYPhaiIVcNzwXGugZd/Ru7jlocWgImKzLLm8tA8E/sv4rEde38OuVJ8XuRNd7kiZWY1csffNB/icRoIukiL0mQ0JKBRFYJY/pndkBCbA/Z2me1dF/2Kdr35UjCeZjo4ZRDTfrMRmNjsfuSLGmpwbJlyjY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e05.mail.nifty.com
          with ESMTP
          id <20241020092719895.WKSS.81160.localhost.localdomain@nifty.com>;
          Sun, 20 Oct 2024 18:27:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH 1/2] Cygwin: lockf: Fix adding a new lock over multiple locks
Date: Sun, 20 Oct 2024 18:26:36 +0900
Message-ID: <20241020092650.835-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
References: <20241020092650.835-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1729416440;
 bh=Cf8gQAgzdu9xEwBAt9pc09hYJRv8AX72kPSUGEmb9Hc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nmm1ZSbRI5KPoFIWEGaFL4R+ihAhecfuYr6Qk93qi00a5ZgnzjOhw7iYaAiCKym4rLuiYscj
 RKyC4rt8YN6vGJbdW/cpcheEIAX2QEvYF46Zl949jpHSyDCrTFh8WRRPrR3jK/sDpBClbhwoFm
 +jtvxLJKP6nw8UXfr3XWNXURiGpKJgToz8qSjW22IoPtvJXmdb3/QJKYmT4WYc29YId0o9+4DT
 snZTPTOorqIGgxhTVbvTAk8JGyQNj7mgetwXmtQlmyTXV4ME/Ye6RXBbxsHkqqwQh7ZzeNCu5y
 vUQy1R95yz8GGtdRI6iUxaUgZG4rwed4qYn6xvoSNWUDQglQ==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, adding a new lock by lockf() over multiple existing locks
failed. This is due to a bug that lf_setlock() tries to create a lock
that has already been created. This patch fixes the issue.

Addresses: https://cygwin.com/pipermail/cygwin/2024-October/256528.html
Fixes: a998dd705576 ("* flock.cc: Implement all advisory file locking here.")
Reported-by: Christian Franke <Christian.Franke@t-online.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 0f1efa01d..5550b3a5b 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -1454,13 +1454,14 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  /*
 	   * Add the new lock before overlap.
 	   */
-	  if (needtolink) {
+	  if (needtolink)
+	    {
 	      *prev = lock;
 	      lock->lf_next = overlap;
-	  }
+	      lock->create_lock_obj ();
+	    }
 	  overlap->lf_start = lock->lf_end + 1;
 	  lf_wakelock (overlap, fhdl);
-	  lock->create_lock_obj ();
 	  overlap->create_lock_obj ();
 	  break;
 	}
-- 
2.45.1

