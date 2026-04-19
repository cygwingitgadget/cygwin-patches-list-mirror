Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by sourceware.org (Postfix) with ESMTPS id 2A2534AADCF8
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2A2534AADCF8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2A2534AADCF8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576444; cv=none;
	b=LbHpnvq/CxPpsp+SYwERvEPVm85Cqi4gCEXm/Af5OTSvnU7MCidDJNRHUiRTBFzCTCOGGPvOQihJcPeJ56j+cDsdB2/aJdK/+P7mywI+NkALDaU+pjgWW91i5ZKtVdwkbbx6ToACwvXf8FyuXZTY6LrcdsEvROUL/Pt+yE32v3w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576444; c=relaxed/simple;
	bh=HxRcN7J3Z98Qv1OQ13sBQyfhg6Fot2KZP7nuKc6VAkg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=KSwyHFiU0vfBK93ZCYgGum2fjcxs6KTkHzisXmv7lLEEgR45nnwZacvdx0MNISD80x0Uw5uX5rZ9v4kFLrcU+wmZpPVbUDchIlfU4tybymuo8sp22D9VfZRcC96uCEF6CBU+5SL/ymMjPm7GJIm8VveMA9qPfjRmH7xvjv3/0ro=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2A2534AADCF8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PtBRQpWW
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-79a46260385so18311967b3.3
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576443; x=1777181243; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NoX6N5cPxH65Xn6PFEF9/MIuGwYZAGcMnarZoPQ4Ps=;
        b=PtBRQpWWocFfcTvylFGCUk15ngakGimQKHKMXmYEp5+Av6qHQ+uHkCL2EttqEooHY5
         7nnEv65ICoBXDrQhhT8r+/bBAjqP1B5yF7qWjr/ghp/YouGhJZUNjDqD4Kzxb+a93+vE
         GHCFf4UAQh3d8lKRtwB/qnPA2Ajq1s8gbaXGwr1yco2xWhY+romz/g22Ky1ur2SuC56s
         E5jkA5u18uz2H4AKu4n4d8UTzw2CB4Los0vQnokGg4b8kMvtcYMuwWbXWnVFKqTTwzii
         B63YeGYeFvsZj8OWK4OsRZY3dHgd7jjrDPfMGZHreHvlFErSFP+559WdOHPosEDL5JDJ
         0w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576443; x=1777181243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8NoX6N5cPxH65Xn6PFEF9/MIuGwYZAGcMnarZoPQ4Ps=;
        b=iRkWtZ7JhTj1KaB6KYH0m0kHiaKn8n/qZKB6DddKrY46NWKVMds18F86sakEEF2tUW
         HdhzmyZ3O0q1IdrnK+7cQ9ZZVcDmGLb5x/8fE8HuaFgniJWM1jX7pu2ArXK5BKEBrIwe
         IndnMeTZ8tCqWjvPRhoc5NxjyRdUYlQHvRkueI3mFgxBQOqi4vA55cuZSzQ/HiN90bQ1
         MktWqg/P3QaPd0xVLhpdRQJXGJhkRhyyUz4KaJvDDHjobYr533sYv+lnI+U6q4heqdv1
         kjJNW9ycMp+mDJCxfwd4UvVWUkMeR+cVtk96JsyjG8AVik0KI1YLltS/Cdu6LlF4a0vB
         uOJg==
X-Gm-Message-State: AOJu0YzNEOndA4islyXQRlwZaHCqSn0BZyv4v8fCFXKx9j/laSxvcgVI
	2XpKlW53l/HN8FqOKgN2Gmva4Wa4BcNYCP9WnmAOCLCh+xpJ8uKDHIuS5QpHqw==
X-Gm-Gg: AeBDies/fQ2xJm/k6J9J86hiuQgoUgffjJ8KQnDXDLDe5tY9lkPCQueuCdxT+aT/pxu
	7QqmFk6G9P5tfSWnUvN1Bx0Hk9bf+kWp8tg6QXIkz15Ip6UzXndAoyyNpCJM1tqf4oa8jkYLeoe
	m1XMAgL3uaW6KwYoT8jD5MhYmJC/91VXRnEma9VjqJ2/6JFe6gpdrZta3ghAKjDkMtKJ8mEv8eS
	eKlEmlj6wAQ81Tq341zrbWK08UxkAzOg2g6CW7tTFXhChrsnM7fECHoTZ4gGdTkEWB/xgLgcbTl
	gvse7REPDu5CtRbR21XUaB9icOQO9cMD31KB8a0TiZYgnWE3SLNX2UISywfZIqxKxnikCK664HT
	CFs5c75p3RjGoqRRf8mUwneST+tCXFFcEOQhbMut98m9NPgIyA22XiOkx4fZMClNIMNBRQhpjTB
	2jOPmIJcH78B5blmbF9Vim4/L2jMY1qXeEXtyYa7INVeklbK2k+zJ3bQ+fOX/HTBIgIH+7mU6Te
	dz/u45lm1qEfCmTB49MmxajrH0t23UFj2UGwN+y/L84jYXU
X-Received: by 2002:a05:690c:81:b0:79d:fca8:f7e0 with SMTP id 00721157ae682-7b9ecf7aa4emr85150187b3.31.1776576443207;
        Sat, 18 Apr 2026 22:27:23 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:22 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 06/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:54 -0400
Message-ID: <20260419052701.513-7-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/style.css b/style.css
index 5e815292..1eb7eb98 100644
--- a/style.css
+++ b/style.css
@@ -130,9 +130,10 @@ min-width: 45em;
 
 #main h1
 {
-font-size: 2em;
-font-weight: bold;
-color: #99003f;
+  font-family: sans-serif;
+  font-size: 2em;
+  font-weight: bold;
+  color: #99003f;
 }
 
 #main h2
-- 
2.46.0.windows.1

