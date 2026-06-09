Return-Path: <SRS0=EfWH=EF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 47E274BA2E25
	for <cygwin-patches@cygwin.com>; Tue,  9 Jun 2026 00:21:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 47E274BA2E25
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 47E274BA2E25
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780964470; cv=none;
	b=HOqQvZzoj39HQzA2qLOJPa8lY248d33wRU5jn8nP3jhTRLKFmJgq1eRgCrlP3wEY9JDvpOXNglCE9eVe7EQzHUNJjfO2RGvUIcz5vvBNL1sryzrMi7BNUtyLfAQVdt1vT949ThimvT1pf00RbPoTZZcAvqPgdoU5HExMQy55p9A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780964470; c=relaxed/simple;
	bh=qtpQTHJS+VHEYSbTAVBgeaoh7EhDsnAeP/pNoPbIe08=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=I2u5dekm7gZjJeoPrONQZCYzjFnqztpVl7ZSaK0pqY2tNxtCRmDkKuxYrLpcuDUqamfupw4P170fG6w9UXXR2/RvCgcyY5BYG9+d+CLnPMPjE8Zz8W2lmC3a6Q5kD25UjJeGmr4HQhT/zLnBTiDOosaK6DzVYS+1Ls/syudyLeI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sPOIHEtr
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 47E274BA2E25
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sPOIHEtr
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260609002107179.UJRI.102121.HP-Z230@nifty.com>;
          Tue, 9 Jun 2026 09:21:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN
Date: Tue,  9 Jun 2026 09:20:51 +0900
Message-ID: <20260609002100.615-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780964467;
 bh=Bm2ulwsRG3717Mwk/jgUFjHVbJb/Gy1EJx9Sy7tomtM=;
 h=From:To:Cc:Subject:Date;
 b=sPOIHEtr7gKdDMsq6JfcpWEpUyP9BXaHAUmb+EfD+1mdtC8Z8pqb6kEjOtsmr7b0GvfpYht+
 1TK50KRk4hUmZcl32bve17Axblkdq2tqKp8aTtHYbenRqNtuz/Wvkub9B5PXuAqinZ/6qVadAV
 ptBWrccUJy5JTLk0ExPhfPM4FJ7+/tCiyQQ8jascIz7C0adq6hflNMus/DQtbgvPkyI05z7uSo
 KVCvsTVwcrx+NZnVF9Uwujchdid8lUuFJJPnWIeoTRckKiNMqNWwntoL19KU1Ztt1x1PpnY6TY
 COUZR0KXZs58rNrtEKotNdnWUDdMJgzBBmvQJqe4owYJ5yXw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SetClipboard/Data() and GetClipboardData() occasionally fail with
ERROR_CLIPBOARD_NOT_OPEN, even though OpenClipboard() succeeded if
NULL HWND is used. Retry until GetClipboardData() does not return
ERROR_CLIPBOARD_NOT_OPEN.

Addresses: https://cygwin.com/pipermail/cygwin/2026-February/259438.html
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Mark Geisert <mark@maxrnd.com>
---
 winsup/cygwin/fhandler/clipboard.cc | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
index 12691c7c1..db33d839f 100644
--- a/winsup/cygwin/fhandler/clipboard.cc
+++ b/winsup/cygwin/fhandler/clipboard.cc
@@ -25,11 +25,21 @@ details. */
 static inline bool
 open_clipboard ()
 {
-  const int max_retry = 10;
+  const int max_retry = 20;
   for (int i = 0; i < max_retry; i++)
     {
+      /* No appropriate HWND exists here. */
       if (OpenClipboard (NULL))
-	return true;
+	{
+	  /* SetClipboard/Data() and GetClipboardData() occasionally
+	     fail with ERROR_CLIPBOARD_NOT_OPEN, even though
+	     OpenClipboard() succeeded if NULL HWND is used.
+	     Retry until GetClipboardData() does not return
+	     ERROR_CLIPBOARD_NOT_OPEN. */
+	  if (GetClipboardData (CF_UNICODETEXT)
+	      || GetLastError () != ERROR_CLIPBOARD_NOT_OPEN)
+	    return true;
+	}
       Sleep (1);
     }
   return false;
-- 
2.51.0

