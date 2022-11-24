Return-Path: <SRS0=VkZR=3Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
	by sourceware.org (Postfix) with ESMTPS id C9F2F3852C45
	for <cygwin-patches@cygwin.com>; Thu, 24 Nov 2022 10:57:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C9F2F3852C45
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (w165151.dynamic.ppp.asahi-net.or.jp [121.1.165.151]) (authenticated)
	by conuserg-09.nifty.com with ESMTP id 2AOAvMDh029593;
	Thu, 24 Nov 2022 19:57:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 2AOAvMDh029593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1669287447;
	bh=4mVvnX1o8yk+3grGGu9ZZF06XOmmV2eXxaAJ14GDd1w=;
	h=From:To:Cc:Subject:Date:From;
	b=PgPOqbcaCw76c0y9WmYiV547d9OdtC+TcE27V8pQsS5VfI+81G7AqQ5/7a/e6VHOQ
	 QL6hTYCKbwMyvG+FfD7SlOUKETDEoXU6PiBKN2mv2iXgsPYObMmdJBAK42KUFjs+T/
	 +Pab6WOfbwkuTOgMYK7U6oTlOrQcixR/gXqhrSP4GBcH1q5bKCNyh9oY9DDFJZ7Apo
	 fb3Loi84ri7hBgAt5RBQIcmrYVNC7z+2SkhXDxonLjtl5yDxkN1y5vWCPLcEkdUPKP
	 A1IfHkhBWh42ca/YW6nABJlLPcJeu3n4XOMk8BkkVkn9DLLe9COZe99DNaHQaj49M1
	 s4op7c10r0qZQ==
X-Nifty-SrcIP: [121.1.165.151]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Rename fhandler/tty.cc to fhandler/pty.cc.
Date: Thu, 24 Nov 2022 19:57:12 +0900
Message-Id: <20221124105712.2296-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

- Previously, we have two tty.cc, one is winsup/cygwin/tty.cc and
  the other is winsup/cygwin/fhandler/tty.cc. This is somewhat
  confusing. This patch renames fhandler/tty.cc to fhandler/pty.cc.
---
 winsup/cygwin/Makefile.am                 | 2 +-
 winsup/cygwin/fhandler/{tty.cc => pty.cc} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename winsup/cygwin/fhandler/{tty.cc => pty.cc} (100%)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index c321a38fe..1d57e8492 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -108,7 +108,7 @@ FHANDLER_FILES= \
 	fhandler/tape.cc \
 	fhandler/termios.cc \
 	fhandler/timerfd.cc \
-	fhandler/tty.cc \
+	fhandler/pty.cc \
 	fhandler/virtual.cc \
 	fhandler/windows.cc \
 	fhandler/zero.cc
diff --git a/winsup/cygwin/fhandler/tty.cc b/winsup/cygwin/fhandler/pty.cc
similarity index 100%
rename from winsup/cygwin/fhandler/tty.cc
rename to winsup/cygwin/fhandler/pty.cc
-- 
2.38.1

