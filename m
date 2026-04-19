Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by sourceware.org (Postfix) with ESMTPS id 6F92B4BAD14A
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6F92B4BAD14A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6F92B4BAD14A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576449; cv=none;
	b=mSDwiLRaVAlv7od1kAZT0Wo/AdHj2A9Eiyyh9mJekH7kGTY56yZujM1piNJCYbNl/uAFUsSFLENu6fdZ4mopkcho1w6y5EUekopuH1tbqSmsUoJ4k7NTBejDL+1m3R7fc4E8HsDu/4v2jfpODWoHGtUKl623lE1Or2aw/br0tdM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576449; c=relaxed/simple;
	bh=Zyo79ODSwuMmV+NW+Z3A2urriUIlJJKf24xo8TqzcGU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=QUrBIgFc3sa4XZPkRYTsMLlKTYT3YZt+v45MhCstrfkH2p7n3+Ww0oN7H92aPqm6BtCIAhrOb3CfUBLp3rRmIdB4/s6APSWnXVwO/COlaeKktDKGahlT42mwICo2BACbyWHGUUNB/aZXBLFppqwRgs2cucT49Jy8Xs/HpM8IFs8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6F92B4BAD14A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d4K+anmT
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-79a7109f568so21332737b3.1
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576448; x=1777181248; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Af8UZ44Rlf2CzfvFCMtXlIJRpPOyHDgzwaeMudbF1o=;
        b=d4K+anmTFwrZprYCHjtVWCe+zUS/zDJN/ARvvTuLup+eUz2AKClt5cAsyPV/fwICGC
         AU4rRQAweB7eAQ3haBQwFeC5FaCd2DmoavKl9Stmv7RkHk323W/B+8BiFu9f5UeO+x/g
         IK0M9WG69yneQcUkprxIIdw7oQWO2gPcYMAxoE4DgwKUDqgcU1XdIDOu6SWs/1fKGa16
         HxfzYhrapahRP2ovbNbUt9gr/VBcAYG+nutweGOOTpQDUU2VqCg3zVtwwgAwxcoARjyw
         x4bHD/zZq3FETANWtCrLa7lPiGONoZVXOQdg5gkdhxZToDeUCWia1RTSuEcT84pLhGrL
         hysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576448; x=1777181248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Af8UZ44Rlf2CzfvFCMtXlIJRpPOyHDgzwaeMudbF1o=;
        b=A7p+yfxBEjzyZV3SQFAcxhkT8aGYwnHYO1AyTfEnKhX3W/vKPPUf3smuiaTh0vh4MF
         UmEZqwqlovR3xDOuuNI0rFIfGhRPMReFm/AuA2dHflPTm1Y4nYVMuhu+TnuOkgYiGyIF
         nTv2KmSiMMrbqp1PV3FQfwng7iOLsIW1VKzaaiXYvj9gnkD/8w5cqMZGAsKZPGTWrSOv
         wywhqDzptFY4HbLsB+0GpqI4UeOaC76V8P4u3jRBfRjJfJh4dF/wOOoZZ48mkPJJc8b2
         n1/SpLA9hYv3g88/xtzeIVrLdUxD3IrUEDb9/yTRk/+l3e6Yh7dEDw+fGkNFaBnFiFDL
         xNWw==
X-Gm-Message-State: AOJu0YyYcANf6W8yA4AWxXU3Bdoo+siZMRm4ngFt6gBIIKoHCMIb/fVZ
	z1LAeDKs1aGPFWwhxhYSVKcwZ9x2CnMj2eXcTP0DJCKzu9ulK5YtcccqKI8XVg==
X-Gm-Gg: AeBDietPZs0iyIpm51gjrDJWE0q3bhAnOznwW+ZZmsw66RAvJW+p6QtJ1Ouno45D2OI
	ZW9BhHqqx/mBuTkJ4iumj0dONOKcjY2CLbcDyOMsOv/xzH/c0CrQmHPl4FnEme9AyNkQGMhD2xr
	nw9DomATz9QVIgmUXjMx5bpbGsoYoGZC561TLVlo8XWcqZkNN62H4G6AKNowMRnBWd6Cx00fWlz
	rzpeN/zs/POb6+aU+gbvvRYfqku1DkuH9QAhk6t7pJe76qj6jvMQjM85ZnJqC0//GuqyKVzak8A
	PJ7xDcQXPxvJGfkuow7Tvufpl1AOOczrgXJ02pPYqCG9bpIsoBmXTlyAgBkJobg8JA6NdWmHcdN
	wjRjhmDRrXplq5zy31wAxaCYR8rOIfq4IeZdwibtbQ1HKN3AavmKmZC2pkinV97RAS+Cs5xDz6E
	TiupC3JedxgeRJHewKg2N8EMXhqsDH8q6kjliXqT6i27bOVULghUrUkMF6GN6pi9B23KpyQ4ZhW
	R69rlHyNESs9ZfNot5VR4Ti04MQ1iy0M0fbWg==
X-Received: by 2002:a05:690c:4805:b0:79a:c98d:2b99 with SMTP id 00721157ae682-7b9ed06ac49mr94226547b3.50.1776576448319;
        Sat, 18 Apr 2026 22:27:28 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:27 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 09/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:57 -0400
Message-ID: <20260419052701.513-10-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/style.css b/style.css
index 5e815292..1ce610ca 100644
--- a/style.css
+++ b/style.css
@@ -338,6 +338,12 @@ ul.compact li
     color: goldenrod;
 }
 
+a:hover
+{
+  text-shadow: 1px 1px #80808050;
+  text-decoration: underline !important;
+}
+
 /* pkglist related ------------------------------------------------------- */
 
 /*
-- 
2.46.0.windows.1

