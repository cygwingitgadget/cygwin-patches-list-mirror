Return-Path: <SRS0=e08y=SK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 390C93858423
	for <cygwin-patches@cygwin.com>; Fri, 15 Nov 2024 13:14:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 390C93858423
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 390C93858423
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731676497; cv=none;
	b=Fp4cl55lE2PThnvzy21sbTNe8Rb7QMwwmhePTnsQRXVKObPfGnInh5YyL3C2Rj/XA9aLFtv2NAofLKsinoG+D75wRe/Zykm1LK+OJnHgx9A/xq7Il6kta4yvVvz/tz/xWjvYuJUe5mN7aX5tfmOu+ljkrtzjBJx9ycOQeRvCes4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731676497; c=relaxed/simple;
	bh=xv9VUPrg9wxHMVroMP1VjtxYMXZr0DGeTGawSHebUFM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qqECGaSBtvoFlM7QYJZA3Rbir8xsLkPMbAAlCZ+Ym3yJv8KIZUk5pt5KOKUQ0L0nFtvrM0oTjFKC7/MR3AlsUW5fb38FF4RSp4QkOypsNdGTGQKSrdO/VOq64JQVXMnmGvuoV+yr1HVKTda7gbGi+7U8l2SLDTp9sqM61AWcUMk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 390C93858423
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=UOx/7IHM
Received: from localhost.localdomain by mta-snd-e09.mail.nifty.com
          with ESMTP
          id <20241115131455457.NHQD.67063.localhost.localdomain@nifty.com>;
          Fri, 15 Nov 2024 22:14:55 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Sebastian Feld <sebastian.n.feld@gmail.com>
Subject: [PATCH 2/2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
Date: Fri, 15 Nov 2024 22:14:11 +0900
Message-ID: <20241115131422.2066-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731676495;
 bh=MyTlkgtrIfV+r7GY3OwifUshmyGuZsDt/iesLpMm0cw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UOx/7IHM8DULiHwz8eghaoSOtO9KhBAJq3zO+uF92vy3m1f0TOX5W557wTuLPffVKdo8P46O
 /k8slXXisfEJ4Bfgu6L/Rut1SNJFXCqVM4qQapMX9jIeOOp4IkiSQTZfj1IjwvbZ2giiXRR5Ci
 jGrPb56UKr8zesf4FCqwOmriHZy3Mix2JBuH1hd/wxeOAhF3mwv6ywMr7sdk0cA2sEyh6tcETi
 uHwOUVR9BAW2X22WL/B6YhbYw3jUU+6aliTH0ECBvhDKwyTuyYMVZltC9POGfIzvhHKrpTNBwi
 NBgU26uop9opGQhv+CH2+3d2CungbfAcr05SayqV73TGJjTA==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, create_lock_obj() can create multiple locks with the same
lock range that have different version number. However, lf_setlock()
and lf_clearlock() cannot handle this case appropriately. With this
patch, make lf_setlock() and lf_clearlock() find overlap again even
when ovcase = 1 (lock and overlap have the same lock range).

Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
Fixes: 2e560a092c1c ("* flock.cc (LOCK_OBJ_NAME_LEN): Change to accommodate extra lf_ver field.")
Reported-by: Sebastian Feld <sebastian.n.feld@gmail.com>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/flock.cc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 794e66bd7..5f703ad0e 100644
--- a/winsup/cygwin/flock.cc
+++ b/winsup/cygwin/flock.cc
@@ -1411,11 +1411,10 @@ lf_setlock (lockf_t *lock, inode_t *node, lockf_t **clean, HANDLE fhdl)
 	  if (lock_cnt > MAX_LOCKF_CNT - room_for_clearlock)
 	    return ENOLCK;
 	  lf_wakelock (overlap, fhdl);
-	  overlap->lf_type = lock->lf_type;
-	  overlap->create_lock_obj ();
-	  lock->lf_next = *clean;
-	  *clean = lock;
-	  break;
+	  *prev = overlap->lf_next;
+	  overlap->lf_next = *clean;
+	  *clean = overlap;
+	  continue;
 
 	case 2: /* overlap contains lock */
 	  /*
@@ -1564,9 +1563,11 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
 	{
 	case 1: /* overlap == lock */
 	  *prev = overlap->lf_next;
+	  lf = overlap->lf_next;
 	  overlap->lf_next = *clean;
 	  *clean = overlap;
-	  break;
+	  first_loop = false;
+	  continue;
 
 	case 2: /* overlap contains lock: split it */
 	  if (overlap->lf_start == unlock->lf_start)
-- 
2.45.1

