Return-Path: <SRS0=LDpO=F4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 50F5C4BA2E13
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 03:23:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 50F5C4BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 50F5C4BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785727393; cv=none;
	b=xO4ikBFiYTGTLs8v+1TBOE+TNkEJ+6jP0uoVStpzCAn7LDBjdW1jWmqcECklD4ZTYCGXAgklBj1rS8YBfFPhOtQGKr7J//5dcCn1PbBsKWVKv26qnHuBL2hR52vY3eVBfw2YMqk0NmHREgR/I1I3tdtw0O4GqCFDSWuaduSzqD0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785727393; c=relaxed/simple;
	bh=cIb1t1bJDnbvNQB+/o1wESMdcHRKonvZiy1zZY/Ffy4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=jSnppTifoBOtZy47dT3QjLs5WxKldZIdhXhl/tYRcQLv/V9MujrcUSkhHwbtyTJm3Am8x+nn/0ALE02RwmqTfYscPNFrM+/5YA7Q6NYp8TyFosbNF/36lvqHL+IxnTRmtIhj7bzn38aykIBPhh4Te+rkXFK5NGrZ9EKxQud1cMQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AnXaxOAf
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 50F5C4BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AnXaxOAf
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260803032311247.URHC.102121.HP-Z230@nifty.com>;
          Mon, 3 Aug 2026 12:23:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: open: Add missing unlock on error
Date: Mon,  3 Aug 2026 12:22:52 +0900
Message-ID: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1785727391;
 bh=tfO+0aU7oPzOKTxNF5uxhANqB6/OCI74TaHego+fCR8=;
 h=From:To:Cc:Subject:Date;
 b=AnXaxOAfbUsmnM4XFMOSFr/6TD8YrEVVJy0qWKycV6GMVJYMMRZpyxr7/rcSq91F7QLko0Ke
 TxEM551I84vkwriSx/6HKwue9MeXCQX5LijZFPcwtQnKPFPgth+qizONgpmET2rr+s/c1+2RR/
 FlTy01d5rkD50yUPT2h2ZE4dOMxNBCWjhvS2j31u4vRGZHQO6IvTCQnfOTPTiytYx5DlQiC3Ff
 b9mDU5Y2PJCBlpe2YDAnU1i9PuYMDEWy9N9OHfA0mRguRScyocMfqY3akA9nJj1UOBsR+dHBim
 HI+aF4uGt+ouSHR2hfJYV152dkYTlK8wmt66EfqWI5ri5C7w==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

the commit 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_
with_arch()") introduced a bug that fdtab lock was not unlocked
when new fd cannot be allocated due to an error.

This patch adds missing unlock for fdtab lock on error.

Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()")
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/syscalls.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index e3ba8c65c..8373482e9 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1554,7 +1554,10 @@ open (const char *unix_path, int flags, ...)
       cygheap->fdtab.lock();
       fd = cygheap->fdtab.find_unused_handle ();
       if (fd < 0)
-	__leave;		/* errno already set */
+	{
+	  cygheap->fdtab.unlock();
+	  __leave;		/* errno already set */
+	}
       cygheap->fdtab[fd] = fh; /* tentative setting to mark as used */
       cygheap->fdtab.unlock();
 
-- 
2.51.0

