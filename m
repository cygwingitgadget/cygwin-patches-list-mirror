Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by sourceware.org (Postfix) with ESMTPS id B580A4AADCC0
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B580A4AADCC0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B580A4AADCC0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576442; cv=none;
	b=Zl4BBwGQ6pyD6mqazJijLE4eCCJ5NCcSBZMTnV1e5bpDLuZ6PgRfegGMrpUZ181xo7LpB1Z1WPlkFv8uDFtOx9/81lle6QBjJweTtpXLQGnkTk1J5Iaq3/SWq23PSdwjzA/IgV3w2I9EaOvGo+EMaoCm8v8TyNfpxBlClOmGQPE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576442; c=relaxed/simple;
	bh=QNHqivOcAkrGUVXU2sKHwV3tPo+qi2T4xLcu6VQWbcw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=vDwdAScXdMtDNGM6kYUWSom+NqEd76tZuZorNCgx5sPAAtJMzk8mgMqH395iIQ37qN7Veitcr8Gyb4moYSsbeRSHco1zE9VPswaHycdJ/ylrO5hlCd3bxcPV68eDfrTerv/f70KdYDTPew8sc0Ml3CSGcK4Ecy6un4FK60FRXUQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B580A4AADCC0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZrhiQAzP
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7b41fdf9de2so13486007b3.0
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576441; x=1777181241; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMCRmgj0B2o068qnLnXRNw4d3UZfg9xFBg+sXhciNgg=;
        b=ZrhiQAzPXuCBajaL6EYZRhklHTVbCmKKmKxjnrSZfxlm9PmPl/b5+/Zif4yA6vxrSn
         M/2MfmORl0V6RmMeZrGLL7uHAYb4IjvraOr1G9rH0jQUvJHEJ+deIYU4KyBpBFljl+x3
         rv3RGhjY+iQfSqmMN4KS0qLvUWJXJGzODurkWA+nNPK0Urlwhv5uLZEgACYqnpOAAhBU
         NRjMHX1/loYprSjQi0awt4MDCMXuyFAuPgdrjSbjXtDxMZcq0qLhuR2Rg0XUOZPx1Giy
         TiDPkt1g8zIFIfgoQGfMQ92Gl/rcYCk5DN8bRBGteUuy8pUI8zLOLWSrg+ABlKWFtZhn
         cWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576441; x=1777181241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMCRmgj0B2o068qnLnXRNw4d3UZfg9xFBg+sXhciNgg=;
        b=G00cx7IT+ZhRv1SqH4TMjSgmmgiQ/Im6qDV2yfz754JxuaYr52j+7lB8HU+O3QOpol
         XnZv5P6c6nkV0fsHYG1BPAxBj/5HJfo7X6thikYlC8e3Ee/jJ1eAnkuG6mBvXS2zFE/I
         VktQawlxDUx4Frz3gxkwrtIrHo9gOwNdglKISEE6/Af02nJlU6RriMLikJT7Dj9lAS/Y
         cUpCNBNvXNozygH+sITtnthCgi0oSDapCcZ80ITFPQCXQMH+svhycCNcleLh+f6CnJmV
         Wecle6NMw0TvCv31Q0FlMKvZkfV6PwZrWKIp6OcNp4l56C+sZve+3WljManavjHTdMN7
         XAUQ==
X-Gm-Message-State: AOJu0YzIv8auNP6/5T1hlC5iAAMVa8DEW/adj3ODXOZxR1iCcIqlSGLM
	oZ2h9T5U1gEWRgRdUf037UvpZus8FDN6+aWdf7cQhqa9SkgXmFxpMYtxuiLZbA==
X-Gm-Gg: AeBDievvEk6jVSaSW+W4f1QWSBXKfx+WFcU4GAScwdDdRi5o35WaW34AAh3g3VV1MHH
	Vb2zZnNsdzDSS0aV3r2jigDiQ+upuzpaWm5avlt1zAZL295uZCMtreqWRlXm4Bq31ZzATTDyNew
	AhwLtIr6vJv2dc7C1XiLlxPJmfIZR6bCjnIUL96zhTcbK7bQWhVV1qCQJwAgPf2NuoMCZvHFnV1
	1aNfHgUih17AG2oyIZQk96L0DGDJDTwmNJRNvFd6MwV3zLe8h+pYMkpb2ggHpWeMQddF7MK5m73
	+onPfzMEFYdY6OJM608tS0Ajev5MDRLE0F17PwAILuouo/0zi7oQYoNfBimM5XMqwhR30OL2RWJ
	5jP9NHQ7ZZViYANtzT/7D0Vp/RCiDMQ2AA8LX5diTu/kAknG37CTX0Hqyd/nX1209QjakfH4G9e
	2pOqHf7bWMT7ipG+CsMOuiecV5t4DFx2rMztP+7pXBaI0IVlnNenBTxDQfuNPlZO//bSV8JTDWn
	kIwLmAogNOl7LfteJoB9a97Md4VS7OkIu1pLggqD/2Ul4fo
X-Received: by 2002:a05:690c:39c:b0:79a:40fb:9346 with SMTP id 00721157ae682-7b9ecece3f1mr92072867b3.20.1776576441658;
        Sat, 18 Apr 2026 22:27:21 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:21 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 05/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:53 -0400
Message-ID: <20260419052701.513-6-johnhaugabook@gmail.com>
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
 style.css | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/style.css b/style.css
index 5e815292..9e680681 100644
--- a/style.css
+++ b/style.css
@@ -62,7 +62,12 @@ font-family: sans-serif;
 
 #navbar a.gold
 {
-color:gold;
+  color:gold;
+}
+
+#navbar a.gold:before
+{
+  content: "\2B50"; /* medium star */
 }
 
 #navbar ul ul
-- 
2.46.0.windows.1

