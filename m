Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id C2C8F4BA2E33
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:28:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C2C8F4BA2E33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C2C8F4BA2E33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042911; cv=none;
	b=MpAgz80FqGF4w5f6dqjigvaYLsKwW/MwryrN9CBEdYdJQ7lLhPP7sOEuCixN8Qf3E5GykJZoHzQZxwN08Kik7dPuysBX2W/Z2hnndlg8LD4P+ZdhobnTySAqlsjcPYFXfYC8q/Ar8K7IBGnx4ruTWYb+TTWbdPzJD71wPJ1MTbc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042911; c=relaxed/simple;
	bh=J6QddyqM+5RrHqBa/LmIim71YczW6m899K2TssPMp1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AvkBCpgLo2jBIZKFzP40KMv7SbWcddsfCCHsmHUzHijU7IrS3lckAMV1SeF87StpXIFk4vMOIktdqU88v/9cXT6HBiKZhXYlfOIXiFMKqSTZsGUAN76Ir79f2swMmYuu32+pzOPnoo2FSj9LF36RSTNp4K2qUoP9Poyet4HqL50=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C2C8F4BA2E33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OOC/ML17
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251218072828631.LNWW.36235.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:28:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 1/5] Cygwin: termios: Make is_console_app() return true for unknown
Date: Thu, 18 Dec 2025 16:27:55 +0900
Message-ID: <20251218072813.1644-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042908;
 bh=79KhM1/4ojpogTKP/JE8/chyzN6AxCELz7gU5x56cmU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OOC/ML17beNzVC2NQKEkBtqph2jtVeZlk65Mynn95gaIhehJTxBL+f+wCYYN+M6gLvsopI8Y
 d+jQET2B/1QZCMGsWP3V44fQEovgOy+lNooFo8TODfw1Vp+D/g1H7WSc8EtkuaOpByZKdehWQl
 nWoPeTVPPde+hrETz9k5UQPZ2ealtiG5UMALH0E+9mE7oU/K27NV3Hw1Zjx0dYteGxqR5mot1t
 jOqpjQnp/X4OuLHclsJCcTTbWYLUVYr41T+k5pDUgjnQ17fPCNOTJwF5NDqojkZumJj8tZREUb
 JKAbx1Fmnt/ffZZ272BdhNyhT34DscjHGJZ4bmh7tA4+vghw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If is_console_app() returns false, it means the app is GUI. In this case,
standard handles would not be setup for non-cygwin app. Therefore, it is
safer to return true for unknown case. Setting-up standard handles for
GUI apps is poinless indeed, but not unsafe.

Fixes: bb4285206207 ("Cygwin: pty: Implement new pseudo console support.")
Reviewed-by:
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

