Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	by sourceware.org (Postfix) with ESMTPS id 1B2F14BA2E1D
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 14:37:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B2F14BA2E1D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B2F14BA2E1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765809444; cv=none;
	b=fQLlbODOObG0Xe+qaPpNDWMAPSe/Xzj1AFczc0OJG3mU+Echyr/K4ZGtdUkWs7ESr7MQYH9jq3Iw8OZNIgTl5o5HyHuJ241l3Qyf+rgzQNWXxRtwNZKS09XHroY1axnC7QxX7Ny0BB9fljl/G0X85dPRuDapwpzlPspx8juBnTA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765809444; c=relaxed/simple;
	bh=ZiX5MTYx6ruQWyE/vWsuGJLoKumscqmyNEfliTzsEfE=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=Ab9G3TiMvfq0kYaSQa/cq4EPGnQYoPppJpofnQkBWoQo/L1YFsUh5tuQESXoY4Jvn+CtwHyWctHmiGgAe7IYQVF9mqii4nv7y/QGQEoBteC4wHq50XmRxAg1JcUF3lhpew6pmo7DBUQnB/Ij5wT5z97GZ6QDx0T8SAXr6ucMHhE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1B2F14BA2E1D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dVILj9xH
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eda057f3c0so32773771cf.2
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809443; x=1766414243; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpant/JE5EO9csFwygp1p24d0Ph1LfJfr8xkgqTuGnU=;
        b=dVILj9xHkadB+USGK4QQXzWQcKuX2a86alEy58zLRUhOpUM2lh5iZJmoUM0mxCxWsd
         EFYBw7w2rtiJC4uwr7YLEfMHoIevoqJI0FthnpPepotCeEYXQkdhiNGUwmsRI1A/Y06Y
         6t+Hd0RtLBaI+OcsR86kAnIRU5TTcLi7sQnAs5ZcKDiqkxQxnHaValEGRiQ1oNwYNcJk
         MMlzEmCi1t98dLfRJvryLmRx1b8YMAyp7j7L+GvOy+ZIilQ3ZTgr8RNQL9BTnQi0xAVe
         WrKF7tK6V8lz740HjEyiNuabeHiuwfbzggUEUrV5ByBJd2e8YRDLMwLjQrU3hbjAyf9B
         Yj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809443; x=1766414243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cpant/JE5EO9csFwygp1p24d0Ph1LfJfr8xkgqTuGnU=;
        b=c/aK/9lZi/YMA6DKtXFjoo3jwgEUTNOWKy9+Nlpfw7DFsfT21OPspBdKlWXXGPfYVe
         FouMDyJbvz7Cts76+YKL2UdRuerr6b2ZG2eM5EfeF0rXidB0+Egiw15xOpE2fNaHj13K
         ANPAW/UYivDaVk7UXVFLFN7YJ39d6Rt3kQ/3xK7K2hyAPrvcq+kwm8A8qgEHDcmKbC8Y
         d/qdXkZ/KpHb1TF6Gu/otZphV0AZLnC2fm+uHMFnyyy69RQtWQWeQTMrs/ipOJ2F+loI
         bgS63qQBhKDd2+U9SPVQB0Jb6A1q9PARIZrpNrYfekdfQDCAO2F5SYoOGt6D2itD8ViO
         70/g==
X-Gm-Message-State: AOJu0YzVDGv/qhRO3QJIZH2XjbT2TA5XtJGomF6/O1MrDkfOO9MD+P17
	hmiaxrpmr1k0yJqelfU4/LXYzLPx2twDHYpdwQoWQpR8B8iPj+38Z3Ygz33dQRIt
X-Gm-Gg: AY/fxX5HUzWCr/xiKSwkmMCHneFwT9pFVAeiw0p9ukRaHMh2WJgpGg1HbSaJA3ZVHjm
	dtUWmnlinlk2Y/gzb+z+/b+AxFX1grZAFzhDdunQZiby2P3w5SalB1qk7NZmaPnaR9o3vMuvP+z
	kFv90WCp+WqfXjjw+WU0uRaDzfL97hmvEvQP5G5YAHpqCRr7omYsSXuT9udUi9OCQkSpkKl9Ops
	/WVT2F1Kgsd6ju/jkKhCmwnByzSbjKxTSczyiSVeQnxKcNR+GQR0FBco7ldoSxY75wQxhMrvDGO
	JiUNq1AMOkDdNZbrWy6vARKDIgVQp19KXIlk1q3YLOl030urvmrnGl/Bg+QXxTGCED+r8xr5kHn
	pl7fK5pcaHdR6COqdc0/knL1vFhDRhV5hW+0bs0/ZzydK20fsMe3Iw1g40x7B2BC5rVh1fpRwRi
	ICx/Z4RCzFVT7gw5A=
X-Google-Smtp-Source: AGHT+IFstLFVl5NJjmcCU/SYafKhN4+5djKWD7DK7AMproCWBjTK8NJS4R798s83L8DC40CuhGkqOQ==
X-Received: by 2002:a05:622a:244a:b0:4ee:49b8:fb4c with SMTP id d75a77b69052e-4f1d05f5a48mr153289201cf.70.1765809443003;
        Mon, 15 Dec 2025 06:37:23 -0800 (PST)
Received: from [127.0.0.1] ([172.208.126.104])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f1bd70a020sm97431561cf.30.2025.12.15.06.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:37:22 -0800 (PST)
Message-Id: <7edad15ac37571d0ddb2bd4716625feb03875e5a.1765809440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 14:37:18 +0000
Subject: [PATCH 1/3] Cygwin: is_console_app(): do handle errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When that function was introduced in bb42852062 (Cygwin: pty: Implement
new pseudo console support., 2020-08-19) (back then, it was added to
`spawn.cc`, later it was moved to `fhandler/termios.cc` in 32d6a6cb5f
(Cygwin: pty, console: Encapsulate spawn.cc code related to
pty/console., 2022-11-19)), it was implemented with strong assumptions
that neither creating the file handle nor reading 1024 bytes from said
handle could fail.

This assumption, however, is incorrect. Concretely, I encountered the
case where `is_console_app()` needed to open an app execution alias,
failed to do so, and still tried to read from the invalid handle.

Let's add some error handling to that function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index a3cecdb6f..808d0d435 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -707,10 +707,14 @@ is_console_app (const WCHAR *filename)
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
+  if (h == INVALID_HANDLE_VALUE)
+    return false;
   char buf[1024];
   DWORD n;
-  ReadFile (h, buf, sizeof (buf), &n, 0);
+  BOOL res = ReadFile (h, buf, sizeof (buf), &n, 0);
   CloseHandle (h);
+  if (!res)
+    return false;
   /* The offset of Subsystem is the same for both IMAGE_NT_HEADERS32 and
      IMAGE_NT_HEADERS64, so only IMAGE_NT_HEADERS32 is used here. */
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
-- 
cygwingitgadget

