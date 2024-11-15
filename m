Return-Path: <SRS0=e08y=SK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id 225AA385840B
	for <cygwin-patches@cygwin.com>; Fri, 15 Nov 2024 13:14:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 225AA385840B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 225AA385840B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731676491; cv=none;
	b=v177REcxvSomu+nQtK+5Ki7F0vbRJy3TkC1/2H0pj+7r6iAkwErldI1Uc5Ib+Vawyc8rLzU9dVa+K43eEyrj3BdeveJZHDjMq3o1Tkfe31Mb/j32TJTakQu/bplJ8sj5eg/4afopYXBWibnEbdQZjBaUL2brC2XqPkIJq0an4bk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731676491; c=relaxed/simple;
	bh=THIKpOr3f0xH/tg/x4Gw0EF+BYVvkIHIDFAxD6pyzIo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UbDOL6VUOEJIjQaf3hstgkKaSACft9Ein+nCUa9cuxYMFsHQ3wacGmdQ4NFSpMQJxiwQfQ1FQau8bnAQDeJ3Sb9HzHocOd4fViabXA9KLorA7uHXhLs/36s55qW6cvUXYQSBQEjXiEfBfttTcqZCDqLZD46HTF1HbfVHtSV14nE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 225AA385840B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=J+qxfCZL
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20241115131449554.NHPZ.67063.localhost.localdomain@nifty.com>;
          Fri, 15 Nov 2024 22:14:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Sebastian Feld <sebastian.n.feld@gmail.com>
Subject: [PATCH 1/2] Cygwin: lockf: Fix access violation in lf_clearlock().
Date: Fri, 15 Nov 2024 22:14:10 +0900
Message-ID: <20241115131422.2066-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731676489;
 bh=ekpLQ0B/7cchMhM0UZJcVeETdwQeHkV68L0X8rt5dr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J+qxfCZLmCKBvFCaTaTdJbfzr6WuvwzfTsy43HMgKnuChjs354MMbPRW3AU+QXO/+i6Swrp2
 151NX0913NKnI1KO/waSuueYFFGiAXwfCNAQ+ycU1tT0tarat+MDgHrbSCCbu07hoWKXtuJznv
 zn1g2etzcokXX4BdB0U6h3LlZq1KjC/sxugIEINAzEbI/4jhU7wefdwshfY9c6pXFh15XRnoXQ
 8ojJk7LIN9s+gSaZBz2w0gMhPJanx6rrdT5iqd8aNx/Uy+Fcsr0r/bImjDQ5E2zaBuvlI2njqm
 myPr/Jc2u1hBVGTvQ9Rc7aLLpphNpSmNqJ6BCjvF+EWsKp2A==
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_PSBL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit ae181b0ff122 has a bug that the pointer is referred bofore
NULL check in the function lf_clearlock(). This patch fixes that.

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
Fixes: ae181b0ff122 ("Cygwin: lockf: Make lockf() return ENOLCK when too many locks")
Reported-by: Sebastian Feld <sebastian.n.feld@gmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 3821bddd6..794e66bd7 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -1524,6 +1524,10 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
   lockf_t *lf = *head;
   lockf_t *overlap, **prev;
   int ovcase;
+
+  if (lf == NOLOCKF)
+    return 0;
+
   inode_t *node = lf->lf_inode;
   tmp_pathbuf tp;
   node->i_all_lf = (lockf_t *) tp.w_get ();
@@ -1531,8 +1535,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
   uint32_t lock_cnt = node->get_lock_count ();
   bool first_loop = true;
 
-  if (lf == NOLOCKF)
-    return 0;
   prev = head;
   while ((ovcase = lf_findoverlap (lf, unlock, SELF, &prev, &overlap)))
     {
-- 
2.45.1

