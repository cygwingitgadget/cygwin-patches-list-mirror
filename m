Return-Path: <SRS0=GbLz=SL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 05D053857C68
	for <cygwin-patches@cygwin.com>; Sat, 16 Nov 2024 04:42:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05D053857C68
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05D053857C68
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731732125; cv=none;
	b=jb2u2dkohV2nl/dCU3RKx2ip3kRN8mW0+oVIHL8A9mZHPJ7Q6u8CwWhOapd29ZJ7D57COZsadxov6Iy0W6di4RJgiaAMcvJqeK0JDdlaLu4jxj6Kmc33NAEU3o5jZFvrigMPWsHJPFaOE8VW1/OU/TNq5k+D7aLA5tJUksqNXhI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731732125; c=relaxed/simple;
	bh=6SyTG2m4ZyZnKUwEKBcD6m6w+g+3PldG2qKWukiG4po=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BsAuWoyql40WiYBZrOdgxTBQi2tVS2I5by4R0+7HOKmtvOgGDWUzAUP74K1cGAMt1KPN4Sw2onAbJcsSXAZ5yGgbMzIMqEWOVtCAICVuRNkGd9tVQuAf7GK74QVCUmd4CjglQmD8T8QkjSVuQjcPmQn4jy0EY93QxGeX4bPpxhQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 05D053857C68
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KJXDFVf1
Received: from localhost.localdomain by mta-snd-w07.mail.nifty.com
          with ESMTP
          id <20241116044202806.RZXR.93209.localhost.localdomain@nifty.com>;
          Sat, 16 Nov 2024 13:42:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Sebastian Feld <sebastian.n.feld@gmail.com>
Subject: [PATCH v2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
Date: Sat, 16 Nov 2024 13:41:36 +0900
Message-ID: <20241116044145.442-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1731732122;
 bh=zpXia3vTQEhzUmsYjnlabme9eVoD/U50LPzVCPe0tzI=;
 h=From:To:Cc:Subject:Date;
 b=KJXDFVf1uD3eamcjW+tpGv0AuO/6085xK3FzgvWON8PBAboiECvREd7OEG82DJUdnfoAOBvY
 pALnM8Slz5lz4Ky4n0443yHIyteUAFWHyIduVFx6ol6vnFDd76axMjJugWoIWAqdg/mxJCBFHg
 fMn16yFuTWE1YYbfNx+Eeb6r/y+3FXr/2lPNNM1arj312NAKCaAtXpj/m0UCaa0OmL309oTna3
 5E78mptHDBC4smDIwcbIVRAkD2yU9G+gfMlD8O6FSYT9x3MfZ144C12astaqip3gMe94Iw5ka+
 0AErGXGF8DJ4yV6mt9OdLfBoxjCKlGphqglynzosOL7O84OA==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/flock.cc      | 16 +++++-----------
 winsup/cygwin/release/3.5.5 |  3 +++
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/flock.cc b/winsup/cygwin/flock.cc
index 794e66bd7..7a4c16313 100644
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
@@ -1562,12 +1561,6 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
 
       switch (ovcase)
 	{
-	case 1: /* overlap == lock */
-	  *prev = overlap->lf_next;
-	  overlap->lf_next = *clean;
-	  *clean = overlap;
-	  break;
-
 	case 2: /* overlap contains lock: split it */
 	  if (overlap->lf_start == unlock->lf_start)
 	    {
@@ -1582,6 +1575,7 @@ lf_clearlock (lockf_t *unlock, lockf_t **clean, HANDLE fhdl)
 	    overlap->lf_next->create_lock_obj ();
 	  break;
 
+	case 1: /* overlap == lock */
 	case 3: /* lock contains overlap */
 	  *prev = overlap->lf_next;
 	  lf = overlap->lf_next;
diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index a4817df46..115496c18 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -36,3 +36,6 @@ Fixes:
 
 - Fix access violation in lf_clearlock() called from flock().
   Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
+
+-Fix NtCreateEvent() error in create_lock_ob() called from flock().
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256750.html
-- 
2.45.1

