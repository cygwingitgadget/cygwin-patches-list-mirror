Return-Path: <SRS0=TpG6=WV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 4D90A384A450
	for <cygwin-patches@cygwin.com>; Thu,  3 Apr 2025 08:38:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4D90A384A450
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4D90A384A450
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743669496; cv=none;
	b=a9LAB57jG7TXIrPlirezqOIymZyPG9Ldv4AIwVWa6R2+L7x4KafhzfIaTyYjtzXK/+EmIS27+1ktthUd3HDhgUQQQxiHQFpVzTN7Sqrq4C/3PdY2J5f4k6xvu12ysWoX67RsRF2nsaxgglk234anjtqQoFP8ummaAc2uoOseBLI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743669496; c=relaxed/simple;
	bh=dyH91try09plPc5eAB6jxqKA6qSucTYu/098iWwuiic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=swPBzClQ3cjm4Ur0v5Z8oDH5LHZsg/Aiw00/lH9h3Jb3FBhKHoZVqIq2Sj0gYV6w6Q1lv1vo6MEFQnJ1zpWDXs48vt9G/us4VcyXlXWaqwMRyuU2zQpvpvq0PPqstLb3JzX2oW0CGZiNU0E96POmAr2doTjZp5GjTyXaFe1A4Jg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D90A384A450
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bdjcXZ3S
Received: from localhost.localdomain by mta-snd-w09.mail.nifty.com
          with ESMTP
          id <20250403083813071.HRUE.98325.localhost.localdomain@nifty.com>;
          Thu, 3 Apr 2025 17:38:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Christoph Reiter <reiter.christoph@gmail.com>,
	Jeremy Drake <cygwin@jdrake.com>
Subject: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other initializations
Date: Thu,  3 Apr 2025 17:37:44 +0900
Message-ID: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743669493;
 bh=a0YhbyziRWc4NfTVKgBOD0IOPZKw9knWbvGXwBdkuag=;
 h=From:To:Cc:Subject:Date;
 b=bdjcXZ3S8GcmgqvQo0g9ALUbYsKj57aLFs4HYzZHe0S/SE8aRTLXEzQnGHzENKRhsUIEiLWq
 07K/DJV13qrWJbQha2R24LUZX3mvnITuOUnXeF2Hwl737DMAOFAI08pcza2jWkCuxbWoKrGDpP
 j4hJmxIAFI+/10BiXhY6zkNnAXm5yr+1ppakmuVGo6M5NLKuzx2DrdW7mo8zMZ9JOapb05jp8U
 /FcD0iUzCIS1DfCYRu4l3celrmdWDksxbM1gtOTOjWVM/zJa/NVk4PsC9WB5vmtGVbVTV9DqEw
 YTAWMNiMB525zvswjmHRmBd466MyV9Yd/u/d+bBynkPpiZYQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the callback registered by pthread_atfork() is called
before _my_tls.fixup_after_fork(). This causes misbehaviour if the
callback uses tls related functions. Due to this problem, subprocess
of cmake (> 3.29.x) sometimes fails after the commit 7ed9adb356df.
The commit 7ed9adb356df triggers this issue, but it is not the issue
of that patch. This patch moves the pthread::atforkchild() at the
end of the fork::child().

Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
Addresses: https://github.com/msys2/msys2-runtime/issues/272
Fixes: f02b22dcee17 ("* fork.cc (frok::child): Change order of cleanup prior to return.")
Reported-by: Christoph Reiter <reiter.christoph@gmail.com>
Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fork.cc       | 2 +-
 winsup/cygwin/release/3.6.1 | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 783971b76..f88acdbbf 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -187,7 +187,6 @@ frok::child (volatile char * volatile here)
 
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
 
-  pthread::atforkchild ();
   cygbench ("fork-child");
   ld_preload ();
   fixup_hooks_after_fork ();
@@ -199,6 +198,7 @@ frok::child (volatile char * volatile here)
   CloseHandle (hParent);
   hParent = NULL;
   cygwin_finished_initializing = true;
+  pthread::atforkchild ();
   return 0;
 }
 
diff --git a/winsup/cygwin/release/3.6.1 b/winsup/cygwin/release/3.6.1
index 07a29ecce..5a15642b8 100644
--- a/winsup/cygwin/release/3.6.1
+++ b/winsup/cygwin/release/3.6.1
@@ -31,3 +31,7 @@ Fixes:
 
 - Return EMFILE when opening /dev/ptmx too many times.
   Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257786.html
+
+- Move pthread::atforkchild() at the end of fork::child().
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257800.html
+  Addresses: https://github.com/msys2/msys2-runtime/issues/272
-- 
2.45.1

