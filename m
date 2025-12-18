Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id B2ACC4BA2E26
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:28:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B2ACC4BA2E26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B2ACC4BA2E26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042917; cv=none;
	b=nTk/4ZZaicrZ1Z0bx0Mk1upnVCnbKSzAgZ+cnyy6IAN50O3IX1L3N5sUxTtfCy+BH2Kuw14U0zRJQEOo7MOAsLUAzOnm/CP9+TGdekIkB2lMTm9FZxYlvT0SU5s0bEi+gkARNQ/gzUn3COpGD7unRgWY18cuKlDRMqLjhvTTbHw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042917; c=relaxed/simple;
	bh=0iQJXvQ050zDFofqnvDl4JIF7RWs6nsCXzXkDkoJY4A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=MjmygNQJh2lysotQ501QjoyrGYcU8P8uRFIHvZcAV24jLSVvzb690EhVwe5Ub4geSK8m0CWaJooyt5nozclLTykh20FMD8bmSrEyO15FzPaNmVKHWS+pOo78oSfAu+VU4HNSQTnkb4hUWJXF8Ypw3idc9v8LUJ/C/DQsg/365Vg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B2ACC4BA2E26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KnplSjLm
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251218072834777.LNXB.36235.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:28:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 2/5] Cygwin: is_console_app(): do handle errors
Date: Thu, 18 Dec 2025 16:27:56 +0900
Message-ID: <20251218072813.1644-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042914;
 bh=iBsbl0K/S8Uwxj+bPGPU/xu96L8XjjCRAuy9tkHgQHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KnplSjLmosnqq3LxWU76Q7rQ71t7G61BOV3NRQyuMqPUD9MJzvXifUlPqzKhD7wpksFJQKnb
 RQMwrS5115LRLey5u0cLW8tCU0Hlv8akaR2zp02aJW14D1Kke3hKorxpYyGtdaFZIlYLEIIvhl
 XzqQzjGzxAJp1S6oK/PP3mKkonmfWrtSPFBRVxfkXPDYfWXUChaYNq7OCsozPmq1Pt/X8CHMZ0
 lGKltvsBWmCb3BqR0VFWYIlgnVVGic5S2iJB2tubxYYvOuC8sgqVCq8RiHEk50UfxONBtWA0jO
 2uhbF7nym8inHyZnAADSX30P22Dlts+znmhkpUphtEn2054g==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When that function was introduced in bb4285206207 (Cygwin: pty: Implement
new pseudo console support., 2020-08-19) (back then, it was added to
`spawn.cc`, later it was moved to `fhandler/termios.cc` in 32d6a6cb5f1e
(Cygwin: pty, console: Encapsulate spawn.cc code related to
pty/console., 2022-11-19)), it was implemented with strong assumptions
that neither creating the file handle nor reading 1024 bytes from said
handle could fail.

This assumption, however, is incorrect. Concretely, I encountered the
case where `is_console_app()` needed to open an app execution alias,
failed to do so, and still tried to read from the invalid handle.

Let's add some error handling to that function.

Fixes: bb4285206207 (Cygwin: pty: Implement new pseudo console support., 2020-08-19)
Co-authored-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index d5eb98fc5..54f3bb5dc 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -707,10 +707,14 @@ is_console_app (const WCHAR *filename)
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
+  if (h == INVALID_HANDLE_VALUE)
+    return true;
   char buf[1024];
   DWORD n;
-  ReadFile (h, buf, sizeof (buf), &n, 0);
+  BOOL res = ReadFile (h, buf, sizeof (buf), &n, 0);
   CloseHandle (h);
+  if (!res)
+    return true;
   /* The offset of Subsystem is the same for both IMAGE_NT_HEADERS32 and
      IMAGE_NT_HEADERS64, so only IMAGE_NT_HEADERS32 is used here. */
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
-- 
2.51.0

