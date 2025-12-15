Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by sourceware.org (Postfix) with ESMTPS id 334E64BA2E1F
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 17:06:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 334E64BA2E1F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 334E64BA2E1F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765818402; cv=none;
	b=sISD44Fx8HcmGtBk9aR55ywcl382qqNjWBccpGhJ9/qEdIfuRqYggcqMJeLthLvM5XcSqHjhvmX7aaNIkWjtnB05gVG9jLNTlqRywWovHmTEXAnP2E+9PNoIGdlvPYdy0/5RRMogFMOdZJTP08/xrpEJPNjyUNdyHpqY6qrOo0M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765818402; c=relaxed/simple;
	bh=7H1dZXODW/qH9yiUCTty/2w2NIFZ9v5pwJIT63Dc+RY=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=Kuz/UrVIlqoHUKxNqNNZrkGwL6hpayg3FkBy79GNViYzjkR5LNEUcy9CeCIqxMUCicfVhF43owvCt1EduO+jb2ehvDJu5E5H+4K5Dt3du2MPM7fmSzVK7Enxlg4TZM+8AHCWCher2hXQssCxeV1ayq/E8V7OM2U8uBnFrcrwVa8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 334E64BA2E1F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Hy7KijWY
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0c20ee83dso19220365ad.2
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765818401; x=1766423201; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9c1fGjfXQNHllgrLbYW7xGaBhE3L8gQkkoewdU6Ejw=;
        b=Hy7KijWYjf3IPkbJDWNWes5z3RXS8rSPBNqC2dJh0DkwyZ3dJ3BwLqY3cpKYExNox5
         mhph67sktGlZCgGQaMvfdYuA5DHk3BJYh6qjTFOgeGvFXMhNCiKNNWiU5/H1xmyJ9kqC
         7Prqkts2ct0/hWwodSKQuQdELT/vrg2oyn5LJoiMsvOv8LpFia9qt79ZXnhypdRGAC/v
         tlaEtppvjU1spIhu8Ywy4B73ylKU+DqLqZN0EeNdDZmmUdty6UYsY/xw0ueUQIonntmb
         /6USeBXzb/FAtTy6Sclp2zujyQsdAVSxLnjCc2k/D+Uu63BnSAJBxkYL2hyzTmXEtPB6
         SB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818401; x=1766423201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9c1fGjfXQNHllgrLbYW7xGaBhE3L8gQkkoewdU6Ejw=;
        b=lEFUB6KLXyqm1G9eq2DJb2z0Mofg6JpjmIcWT8PHNboOE2F5dxqlQbZYcuBStLf3oS
         ajHscXxchg9ihfAq12jS4zV8g+6HU0kTDqrBhhGpvO8ENC6zDp0Lgs+GAQJOZYa53RDN
         eIr4JOh1l0B15kGyUVosnskGzyW0NKSTucnm2jbx31EjjZgv+gOTkirIHKgLgEcmGeQX
         9SRSOWXngI+O95QqK43YxOkI8djMtY9OB4Wq5aAIR4bUOujVry3sEoqdocbGR2zS9sJl
         Q/e7uNGSZPGFsH0F1g/hLFavp5R4ainr1vyd+KDfM1cvLD6ODE5PjkXb7TtwP3o+A3MV
         rC4A==
X-Gm-Message-State: AOJu0YyiPLeB/YVYnx3yC1hSjISCnz5gAGQxV8n+hoM0wqAag3MNKAnK
	RE7z4m/A60qQc6QPtMgiiyvhDPn+7aUk2dDwNkIoc9De1XeseDrbEM7Rz8mVIQ==
X-Gm-Gg: AY/fxX7oM3drTQpSzWKl6nEExtIzBmaOaJVdsyFj/1B8DABSSShCVkt6l8hB4Qb1gwu
	XzheyXaNZw8xsLH1KeZ/V1NFJlQmnNGfKTSIuKalI2JwxccE+AgAmyEsDr7oUJdNMTl0m0sYeaQ
	gmhnM0Eix0lAZUVlF6DpFV025qxUwznCB3ooe1blzZKlBbv6GabfpsiNSY7SitgB/yrEz17q8Cn
	rRXxTeKaznb4ras8OSCUIaA/VEjBb/zfoT/XmmIp+7kHKZExppkYWddTQHrgi81/j/48cKJodyu
	2+nJKQnnHUxKaxjuOfUXmDBhMyq4jEhAn8ZFJj0JdzK6fKyGUCO92khv2dAegcVIe5vTNwtbFoR
	6Wy+McNetI2YLD19Y8Kb5qeRXu2XjcBNVPCTknUwpvPeX6Hl6C0FOT4XiiDB1YDAp3U8lEkVlCU
	lFdYzxJl5uTDM=
X-Google-Smtp-Source: AGHT+IEsvn2qIuOGwfuy2BRkvYhXWBBXY+Vvvyi52Vw1JyNvI/OZb8v1CwI9Os9bJCSVdX0YqpFWZg==
X-Received: by 2002:a17:903:38d0:b0:295:9db1:ff32 with SMTP id d9443c01a7336-29f23cc4083mr118533415ad.48.1765818400430;
        Mon, 15 Dec 2025 09:06:40 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d38ad1sm137705125ad.29.2025.12.15.09.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:06:39 -0800 (PST)
Message-Id: <e6101afa7e6cf8c7d60e56cdf076f22671021af7.1765818395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 17:06:35 +0000
Subject: [PATCH v2 3/3] Cygwin: is_console_app(): handle app execution aliases
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Corinna Vinschen <corinna-cygwin@cygwin.com>,
    Takashi Yano <takashi.yano@nifty.ne.jp>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 2533912fc76c (Allow executing Windows Store's "app execution aliases",
2021-03-12), I introduced support for calling Microsoft Store
applications.

However, it was reported several times (first in
https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com
and then also in
https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078)
that there is something amiss: The standard handles are not working as
expected, as they are not connected to the terminal at all (and hence
the application seems to "hang").

The culprit is the `is_console_app()` function which assumes that it can
simply open the first few bytes of the `.exe` file to read the PE header
in order to determine whether it is a console application or not.

For app execution aliases, already creating a regular file handle
for reading will fail. Let's introduce some special handling for the
exact error code returned in those instances, and try to read the
symlink target instead (taking advantage of the code I introduced in
0631c6644e63 (Cygwin: Treat Windows Store's "app execution aliases" as
symbolic links, 2021-03-22) to treat app execution aliases like symbolic
links).

Fixes: 2533912fc76c (Allow executing Windows Store's "app execution aliases", 2021-03-12)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 5505bf416..7751b6357 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -710,6 +710,25 @@ is_console_app (const WCHAR *filename)
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
+  /* The "app execution aliases", i.e. the reparse points installed into
+     `%LOCALAPPDATA%\Microsoft\WindowsApps` for Microsoft Store apps cannot be
+     opened for reading via `CreateFile(..,. GENERIC_READ, ...)`, failing with
+     ERROR_CANT_ACCESS_FILE. Therefore, whenever that error is encountered,
+     let's see whether it is a reparse point and if it is, open the target
+     file instead. */
+  if (h == INVALID_HANDLE_VALUE && GetLastError () == ERROR_CANT_ACCESS_FILE)
+    {
+      UNICODE_STRING ustr;
+      RtlInitUnicodeString (&ustr, filename);
+      path_conv pc (&ustr, PC_SYM_FOLLOW);
+      if (!pc.error && pc.exists ())
+	{
+	  tmp_pathbuf tp;
+	  PWCHAR path = tp.w_get ();
+	  h = CreateFileW (pc.get_wide_win32_path (path), GENERIC_READ,
+		           FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
+	}
+    }
   if (h == INVALID_HANDLE_VALUE)
     return false;
   char buf[1024];
-- 
cygwingitgadget
