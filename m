Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by sourceware.org (Postfix) with ESMTPS id 9955A4BA2E1F
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 17:06:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9955A4BA2E1F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9955A4BA2E1F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765818399; cv=none;
	b=NoSFDVSzTBaqSHFslT/N/6ZKaEEJuyv+WQ/ALcoG1mxZv6nsPDYwNt/ObqqyQCAggLQg5X/AqZBh78mTmUtgfGMiyNccYksot+oR+THbg2VK4BYK9scfQGGUwJavDpyN7eaghXq2xmsLsrbBqRM9UqgYFoGO17rgYRqHaRP88eg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765818399; c=relaxed/simple;
	bh=XiEpIoO15QWNTibuXsCJC49Q5/RoxwsBaGOLZUIwJmg=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=lMXAe7TIqIymur93wGWodPwnZwFDeYjjJXro5Ni7d82ycd0aL+xGIrFjNydIMgFltF+PVVO2P4ykGyJgFoHIpd8t8+pOiWtaKcIRo2cg2OPTbkK69cxTzdit9VFn+DYUs1vAssuL1+ituexZAtlJ8xhudP+zLDCefiEGdXm5l7o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9955A4BA2E1F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CQEe3Gd7
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0c09bb78cso11192735ad.0
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 09:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765818398; x=1766423198; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df2sfSSXj3w5b2CaU5rCdPtDsfbAe73hN+l1iV3wDXI=;
        b=CQEe3Gd71Ac2G1HMr4cDqJ57xjD4GZRskc8VAw+Ysde5A3FxPqrvH/osb8REJak5Qo
         na+7lGr4H2wnWV+0/aJ2TrGo5LA0cgec+d2sAhBRE5E5DswckSTJycSD8UisDnVwsgYr
         ZFka5DNd5ekyKpRA24/xF+0TgZZE85zXDOvnke4sRhdrB8yJRJSyyk7bcG6m6PA3EHmO
         IAj6E06vtqCNsopdyBMOoDqp7wmIuM1LdQSd7KyrKCJlTZUJQRS+csTBNroQ5FkyOX81
         Xz/XMAbEHz2PFDkcRorOm5dwa6EnTj3keoRyaltog65onvp8XNMUNflcQJgJTIT7NFzb
         ItEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765818398; x=1766423198;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=df2sfSSXj3w5b2CaU5rCdPtDsfbAe73hN+l1iV3wDXI=;
        b=SiFbdKaHO7PpI4Lof1jolz1dSufWsVNx9oYgKaxIBvh3a+ypHK2xFvspbpdZ8tMrp4
         Q5Z7GZxtCCZYusvsyCNSPMkv1hgr03T+08gU0DJZpoaXhhg36IHrrPJHfVze21X6G9oA
         XTWvcxxBp9Ktmn3W55922rPKnDqh0TpEZbVnokR4BxLgtgrXrxH6IJlqLnHtF70wQNSS
         9lljJBdKHVIDbhT20G/aWBBYK95SD8eT2Crf4AatY61vJuzgZaFCVNii5MRwpoFgox4V
         8dlB/B4j3Eqna8XQ5Me6QNXHjE3RKBNebTubfJ+oMVnjAzyYyBu9uMsedKCM+ZYOt+Pq
         jKYA==
X-Gm-Message-State: AOJu0YypEwmxF/1V8qdu3dLAzZP3bAPuZWkQVe+hiAKHu1G7PcgwA9eU
	hUY4CI/Wzg2vCmkKHghtwUU/f0CnFcvoHc5WnIu2aATYe+Dwu6c39gIy/s7kzQ==
X-Gm-Gg: AY/fxX6EIxKBUqMnRF95oVSyf1Sktoql1RHisCrphYQ/ZlU8UvLQxr4Drq7nC5HfXuf
	NR8KxEeOFDgAhDpgMgpqGn89XAMrd1WXXVD4UKG0XVkoPoULmcfn/8AyzkkoLjY5J2i2pNlZg/l
	xVs2mAhPvN1BZbnbuHMkVeWvk8nc5exZUWVQdA94+Z4QHf8ZNjBeTr4Kd3JrUdz++nm/wxRMiBS
	5gg0CrOeEie5Tv8B47b6f4VZNx4DmN5tgOyepYCqjzwxo0SHv77OpY51CAIDisIXTMfyKDbM/Da
	iApsRjfH4OOh030hdcM7Xyh+T7Hbqqfu0eNDQcdLnxKOobkpH+cThctiOGLr9zijnpUS62wTwR9
	X++QcSRnsnTB6czeBDLAGcB0wbsy5CG1aOd/j9Hh3XOPDdhrGupLNFZeQtaRnA7NkrSLAsu6ISb
	CQFhe1vc+WTA8=
X-Google-Smtp-Source: AGHT+IFJvDp7Ros+GaZ0yf/43NIHIpb5cNXGDH+ky3qNtujqUIjCNzuwD7O9ufqc/WkQkj8qbMksgw==
X-Received: by 2002:a17:903:2a90:b0:295:99f0:6c65 with SMTP id d9443c01a7336-29eeec38ae8mr156518075ad.30.1765818398029;
        Mon, 15 Dec 2025 09:06:38 -0800 (PST)
Received: from [127.0.0.1] ([52.225.25.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0f58d7c27sm34816375ad.24.2025.12.15.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:06:37 -0800 (PST)
Message-Id: <af87bd1d47958a6d183dbfb56fb61462b4390ec1.1765818395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
	<pull.5.v2.cygwin.1765818395.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 17:06:33 +0000
Subject: [PATCH v2 1/3] Cygwin: is_console_app(): do handle errors
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
X-Spam-Status: No, score=-12.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Fixed: bb4285206207 (Cygwin: pty: Implement new pseudo console support., 2020-08-19)
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

