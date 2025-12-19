Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 4CD244BA2E05
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4CD244BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4CD244BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111229; cv=none;
	b=KULssBshV4uNAGcCbAU59v77ZVVbz2wxkl/hX3j6UqFVPwNeEvfjQ5WSx7yuxpLdoSRfzJzNnyqq8w7fsYCjLvTa3T7ZzWE+wy5YGCJaBvroJxRKzpgzUCEZt1creKYR5u3RWlka8P09OS+Bns+JECPfIvUXsEyKePZj5p4WiO8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111229; c=relaxed/simple;
	bh=oxS7Lg6Vlp6YOyz3BDr8LD1IL5groJMuGKi71PVyXT8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DLsZiRsBwEmkzeEoEbtai+LgdQXWXfsmrwLcJTlL10Zpiq5fLwiPgvnzh4DapfrH1hK5LGkhg2VOb9e3D52KFCdFRbOQThA9hw8X0nBS19MrxtOJp8S7Hiu5uxuQwVChAP1ymWJ2BuMEg4TqGRY68x3AaRMLPvF3dgZFKuWIbGA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4CD244BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=l6NQZn0L
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022706417.VHTA.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:27:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 1/6] Cygwin: termios: Make is_console_app() return true for unknown
Date: Fri, 19 Dec 2025 11:26:34 +0900
Message-ID: <20251219022650.2239-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111226;
 bh=4tpP6efjWKQniFr4dZl0s5Sp4/t93JLrEtaHkwYJCNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l6NQZn0LK6zcZ1+na91Eg2pgnFprXgbEA8wYL3BaeSPFv0OTUqTRex2TSUptPCDRHneuMmhc
 NjynLIaHm42dVH0xLjevH+3K8nfvUqK6rspE0Nxa1gaVWNiKyMeWQMsFenD7S9DmWETEgMIzd1
 8zgX46WDh1i5lxYcwiVNajFZp6RvXRo+jyDmkzZfnlIz50PZeaqgABQcKjzUCBtAsrYpTsH1nk
 4Cq/Imp1VHbX5aijDNDX26fBpXFh6bUJSvB/vzQfxa6wjuw0fnl8s0S6VNlpUYhHl7vfNSEp7N
 61ZBu2vog796mjMobMXNjt4DBt2Cqw0J35Vc/TwCDwO3K58w==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If is_console_app() returns false, it means the app is GUI. In this case,
standard handles would not be setup for non-cygwin app. Therefore, it is
safer to return true for unknown case. Setting-up standard handles for
GUI apps is poinless indeed, but not unsafe.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 19d6220bc..d5eb98fc5 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -719,7 +719,9 @@ is_console_app (const WCHAR *filename)
   wchar_t *e = wcsrchr (filename, L'.');
   if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
     return true;
-  return false;
+  /* Return true for unknown to avoid standard handles from being unset.
+     Setting-up standard handles for GUI apps is pointless, but not unsafe. */
+  return true;
 }
 
 int
-- 
2.51.0

