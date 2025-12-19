Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 1D1FF4BA2E24
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D1FF4BA2E24
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D1FF4BA2E24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111235; cv=none;
	b=uvKtfk8OL6ZmPCDgf9eBmefIoAibU/cGgucCRbFX1kF+nepeUxAY2LEoATrUwUihKR2pALE4PysP+wir7d8KKKM6Atk9VHOEQVNtPrz1mkS4765HmLu2UAN7YKAmO70EoosZiDivauYUPZIJwXMpqnHF7k+Vn2TRcWuaAV31Dyg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111235; c=relaxed/simple;
	bh=0iQJXvQ050zDFofqnvDl4JIF7RWs6nsCXzXkDkoJY4A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YwJxbpvMXcacH6YTVnM8rsSVKf+4Ox5O2LKmXF36x2JRFWNXYfeAIT4HRooGEwOirXCBjkPU4ey/u8KgUMOvkOaq0vKbWI/ij9W7fU7cyyM8BTuBUt8LzK/wbgPGp6vkw2D7ita3Q1+W91B1M+eS/mfKnJznycsCkbRhwwBUVuM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D1FF4BA2E24
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PPuuOi1A
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022713234.VHTJ.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:27:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 2/6] Cygwin: is_console_app(): do handle errors
Date: Fri, 19 Dec 2025 11:26:35 +0900
Message-ID: <20251219022650.2239-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111233;
 bh=iBsbl0K/S8Uwxj+bPGPU/xu96L8XjjCRAuy9tkHgQHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PPuuOi1AUyV2iy3LUvqngLDeGORcRTDLsPD9gWN2v7HJgi4CXveJweJSNiHZypVMQlA4wfZq
 IOB35rw3nt9oXHnrVdonrV1jhEuP0p2B+gkQUS370JzABiM0GVF3UifhDGBpw+ZBKctYY3L9Tf
 YTtp0QV5pwgvmeqqYuVE2sCnliDyjz6Padk4RYvLhcOEL4PglHCUAwD3AehLkr2sRH81aBtpZc
 9HcNA54r0xH5Vt3gVxP2BX7/XzbeULsGLvoNN+moxKkUkPMLfD/948PxyJECeHiTxfQj1lizg9
 5O/gJ8lD3JMYSwDkTSq9iODsaDF0owV5J6DcSS3WfECzK2HA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

