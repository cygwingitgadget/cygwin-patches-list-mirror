Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 0308F4BA2E18
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 19:25:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0308F4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0308F4BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772306748; cv=none;
	b=F6lwf+O6d/O85C2Xxy7qrcoP/AWnZIAu/V/22/ECCL8FGnWgQQJeA0LpvZ7IMeafdzJLSwlJnkC3DJw0ZqzXc6PP7g8yyfSOjOFprSSJSnwMXftAD6oMjiyXF2a7h6Q9iEXtX7cyfM4OygIbi14dRvtmFGnDLCNF3ynwyrqO4VI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772306748; c=relaxed/simple;
	bh=S/CboLmtAWyF2PZQEJpoUEeN6kWhkk2A1d7iaPDWfJw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=HrocOgkvPd1IVRvCofnbVwUnE9iDHAqO/g7KJdHt00WRr41fDuuDLk9qG7aTNrGlS5qHAZwP6kWnGLGOCEkCQHwxYtLjqOxGR+GV9N/iOzciNgKljZLty6wuoJuZc95/TIQY34kh55wmez0Q0NOEbjIogHQlSbQyTaiUjJ/pjQg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0308F4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=T2APROZm
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260228192544816.POAU.48098.HP-Z230@nifty.com>;
          Sun, 1 Mar 2026 04:25:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Do not call empty WriteFile() to to_slave_nat
Date: Sun,  1 Mar 2026 04:25:30 +0900
Message-ID: <20260228192538.1908-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772306744;
 bh=U8XGAfGT0uRzTjlma4zFk0ZaoC7Yrq87okw345rsfpo=;
 h=From:To:Cc:Subject:Date;
 b=T2APROZmW/x7wzH/nUaN/+3dOcqKC1k8kes8N89B073EsU5x/pAtITTuT+FC2k20P11R8aS9
 kpgQy/CNgmO+DXDmdqubvV9YgOLxgfPuKweglF5r5OP7DlCol7KbKE2nLmbcSy1xMH77KDu6P7
 RNTnl5O7GCDR5vOnFieuUsk7NZUPDoLJK4ug4o6Z3Mab/3lpCc18Jj1huirFfTD6PUBjyEQRCN
 JEUQ0A0r9osplx7vPzhvZBT9pQWsXRSBH3tbZs0Q/ZlQL4X0FAmI0yhxaCbEd5jB0TcHhURmqa
 R2oHTn0QXvepOo8AvhHqM2T2gITsBA8HHF5RX0LmeZvfzkeQ==
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, it seems that conhost.exe crashes if WriteFile() of
zero-length data to to_slave_nat. This patch skip WriteFile() if
the data length is 0.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 50a1f5ffd..bacab3ad4 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2243,7 +2243,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	}
 
       DWORD n;
-      WriteFile (to_slave_nat, buf, nlen, &n, NULL);
+      if (nlen)
+	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
       ReleaseMutex (input_mutex);
 
       return len;
-- 
2.51.0

