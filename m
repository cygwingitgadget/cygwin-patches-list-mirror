Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	by sourceware.org (Postfix) with ESMTPS id 1E5BA4BA2E1F
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 14:37:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1E5BA4BA2E1F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1E5BA4BA2E1F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765809445; cv=none;
	b=SUgs5mlJYZhxw+ezQDrzYi6RurLu1CuV4aK8S47KijZzTekTVlg4C3uN9P8MPU54YZziiLUs7imYY9Sw+F1XGNRGo1fW9Bt6J+vm7/LNt++5u2HqqbM+L15aX+x/tnbbwNq9Ee5ku5slb228LPmFiGTzwVdy0ib6K4dYhy7zDvc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765809445; c=relaxed/simple;
	bh=mjq+GRVveKBRTfHvclUKtRtk2eOsUvhPbkj8jFmmZtg=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=MIigcMNfaAqbOHwZlEjdc9mUD0gdS0WbMUHyI+qSNiibact+HJNePv1X2GeDP8ymoencI1ClGGwKeRKY1llds87/NDISI55naRWyMxsnk1LmlRJpRUFC4XWfop1CieMfMH3IHmWdK1WB9Myg57hNrLHZIBBnEiahgkTs0pvSOKo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1E5BA4BA2E1F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=KVaVCLgA
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8887f43b224so44665416d6.1
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809444; x=1766414244; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnzSDkDJbiCSunJ0bnPNJCRfChHaqtwH4ey8PGWaPCw=;
        b=KVaVCLgAd2Nr2uMKLo61eFK+fSwCgCykE85iLiA7v6TnU9B+voC9VHqH8jq9coOfwm
         0WJRQoYd+QMicy9OdudYFTxuwnHxzMFVKx1D9XQGSP1db6y5HULXsXXtxu/UqFn8w0Jf
         vblbStVGf8DdYzLW+KTmwDl07Dx7z8G8Oysu/f71YR5RlSSGkG0ByVX8E8aXvE1OfAhI
         S49cY+qxcmfl3twppMuu5Es8MYmMV31SEo5d3u1rPDa2lB5pDWF3WvAHenQFLbxf84eI
         n43sKy6g9aFOkioH2ew7NwoF9wc10wORbjB5Tp0KJ8HgqnVMSTqDnB0q1sxOeAmLgkue
         i+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809444; x=1766414244;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hnzSDkDJbiCSunJ0bnPNJCRfChHaqtwH4ey8PGWaPCw=;
        b=RiaW/7rYVEszJ7VBnZehasyEcDhtplK2ePWoY27G+Ij42xj2Ngh6loLuwa/rlp+xbu
         jVFB83uHujbP/7DXO2qN5UrvmMK+7Y/hc6pPAXeipBDepf1eQqAt2tpkgFuLTH/5BBEo
         g9jj/Q9xx6Xrj18XVkdpJmtNOZcyZcQrt1CAE5xVKR5bLbqF6GB9VCCbMhz7tDRyXxZQ
         L8XExQZEFlIfUHlsRpau9GZq5UT0S9DtefhEm0+u6uEu1Ma11/+BpAlMxRJix6fy2dMY
         gfiFUx1An6dFu5U7lv7dxZBZqjVKU+0zwGH6NojqGLxbIuTqb9/1+hNs+u+dnNDLnN+S
         Pd6Q==
X-Gm-Message-State: AOJu0YwsBXUbWaOaqGBauulBWalNE5jQc3hAMqG/JwGrmizohSAPTwhy
	KOKvqsYc0m92mWzCq06za/ckPH/LuCuNBZBf/2nWqzXHhh9FA+3nEJyKCQWy6RR3
X-Gm-Gg: AY/fxX6YoQEU6saNOMHESl76QYVJi2zCX1/mSQLcRvFDzUqLoYIz3Cuy51u0VOjRald
	uRwxAF4PAgjcfUz+sNz48dYhKYrH6djfLTWYk6MxvixjDaXX5TdjcPXIE4roO+o5M7m8JwoIBNs
	sKjXodxFLFzGVowVUVGMDoFM7W1QJFo+zsPCt15qtIXSVU4t7GQXbvq+/Ir/E9pTakGZ9015KXL
	RzZFxPQWLqHgr7XivTqGrfUt4W7qSlR4ELXT1LadKel4BhcUUhxBuP2C8nGMqEVyo6njLZmJjAT
	5//WOTDQRPYKBX16KhqYomD1R9I5RFIJ7jJvINAtSBfhsjkzBo1q5N2kHzVOd9w3/LMfx5sNscP
	E2oXkLitvlovNSpxKv9bXQN06BZA6oBngiSak1YX7jGu2iZYySNINiC/5ophVH80BLitfTr3Uh7
	aUZiFtYMKQXkkgDoddjYAI2yd33Q==
X-Google-Smtp-Source: AGHT+IEBA5UNAH5aX2fl3RsrU/NRnpRknvYK0XfgG7t8gtCZexPggg/4co0QY6iAn67Xf9H7o1oIBw==
X-Received: by 2002:a05:6214:f6b:b0:7d4:e416:ac05 with SMTP id 6a1803df08f44-8887dff21b0mr151833656d6.0.1765809444148;
        Mon, 15 Dec 2025 06:37:24 -0800 (PST)
Received: from [127.0.0.1] ([172.208.126.104])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bc36fcc7e2sm251109785a.7.2025.12.15.06.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:37:23 -0800 (PST)
Message-Id: <535cc52d4d93a8dd80e35e1a7da30599810298c2.1765809440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 14:37:19 +0000
Subject: [PATCH 2/3] Cygwin: is_console_app(): deal with the `.bat`/`.cmd`
 file extensions first
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function contains special handling of these file extensions,
treating them as console applications always, even if the first 1024
bytes do not contain a PE header with the console bits set.

However, Batch and Command files are never expected to have such a
header, therefore opening them and reading their first bytes is a waste
of time.

Let's honor the best practice to deal with easy conditions that allow
early returns first.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 808d0d435..5505bf416 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -704,6 +704,9 @@ fhandler_termios::fstat (struct stat *buf)
 static bool
 is_console_app (const WCHAR *filename)
 {
+  wchar_t *e = wcsrchr (filename, L'.');
+  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
+    return true;
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
@@ -720,9 +723,6 @@ is_console_app (const WCHAR *filename)
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
   if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
     return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
-  wchar_t *e = wcsrchr (filename, L'.');
-  if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
-    return true;
   return false;
 }
 
-- 
cygwingitgadget

