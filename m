Return-Path: <SRS0=CAkv=Z2=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by sourceware.org (Postfix) with ESMTPS id ECDD53858C51
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 05:29:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ECDD53858C51
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ECDD53858C51
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752384574; cv=none;
	b=gIA7Bud8zbAx/sTKhAr4KtLd2cthE5IGrCUbmiaRcf1D5/h3CW8pRMtbyrzXyHQI2Ii9ZR39d28CkgBXQd8yJwKS5gm3skKejcQXyvs1JdPMpaCDXtX71YvVswmpgPiCBFwD5uYV6fxd1BOlYuquMG2hP8Bx+gebZILlXqs+BzY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752384574; c=relaxed/simple;
	bh=5Lq6IJJIyzFp5n1tfdWzgr8051uSw0ibQ5INuchEG8o=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Q7khK3iZXiS6LcLGAsr1qPwYW5MvjvowJuqwJttYi9bWPQwA/Tiy3vXXeMI5/ayAMAxdOOSuHcdlnhi8kfnmZ5IEuoRbsxBV88Q/e02h9InxKdV4Y4tG2MKqoE1CZvsZELCTX17hvBsFB5tIXWbEJUCDP8dr27GShY8ZwKMaY+0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ECDD53858C51
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R+7982gh
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e898de36cfbso2697864276.1
        for <cygwin-patches@cygwin.com>; Sat, 12 Jul 2025 22:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752384573; x=1752989373; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAHc9y+vTeDbsM2WL4P+wJxkj0Qp9UclEoV/sLGrO6w=;
        b=R+7982gh3/wNKN+cM9rfwng1YRpIGWJYTBMe7N0fCC8TO/7F8QoVjHnyhx7/bZ/SIx
         6sk9qLzlWQd+gCN/GKFKm2j6TUUy2PaXROfxeWU+PtWy7rzOgxmDBPf6nt+CfPl2mFgN
         GKHQho2z0V6TdLQQSnbq9Ofp2EdUH6qBwv+pePQM66+lIfiEEWF0yaM9DFy/CWZi/K86
         yQsJoHUBr32yxG3Xxx8M8c9Xhu6pZ5zhQWRtb0cku2v+SFnQtM1tGcEFpFX/vPVacJvj
         j0hvhvaHFyfV8oa1meVK130/K3uu3PxexT08VBKyybFoiYLKhV/ZcMDYp9x6+cvUf+O7
         wgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752384573; x=1752989373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAHc9y+vTeDbsM2WL4P+wJxkj0Qp9UclEoV/sLGrO6w=;
        b=gvgudwqV7NPiYGS7VYDB3zxpO9jUxzhL9PijXQwkq2JE7HCEcUR4l45R0y+5jeF9nR
         qTcob29n+PDvPQgsHThVJIdhWzhf6eF9aep+qCbjUiqc2GMKF02kX4MrBzF133PlWMG7
         89Gyjatv46zzzIJLN/39lGU/d2S98fkZl30Yp37Mkj4x6rahup6UO8fN7f/ZSRuPPyVy
         PsWIfx1xDuEXJDT5yWhS/CVkXhVC9x3CxFd8FwJO+vi3n56z1UhfKtHxlJRw3OhXMFyn
         4mQj71YcXiThhQ5h3WVIS1N3854D3S4U8K4bGwaTFPGzQdcdrGemWEaA2Ko8D42e/ZcX
         QxgQ==
X-Gm-Message-State: AOJu0YyUmrPrZbPEUNY3juu3zUD/BvhQqCvWzBr8DxOngHs4MX4BEwBi
	XT5JlkuxAXPnR5TW3esr6EkEs7hVmFlupbeO3CVjJdTEHooTQ5jZYNq0kMvM4g==
X-Gm-Gg: ASbGncsjlIY7sir1aknFQWvdK1dZLXm6o0XDxlJonyWyHrWT8w2BX3/KT3Tr8K7nqCu
	hl91VxBh0WhZO+zJkLtEJbJFnlCUJUqWWFf4FZMNXWP7+SEjtT3e2hglIS++Irz2W1BVyeXVHQP
	Uxm+ykx+psi3TKcy41QcGCLKuiTJlNrLpR+bytCEOxaeFsLcazBFX6lzRY6LUsaSyUHxrsWTGu5
	deTu+iJwt3YZ5wkoUL0Fxc+PWFslOC7vAsW8vVLD+imE0ph96UnQRN1Ml3duo0fPSLL3RnFYgZT
	Gk0iKncVJrTi5xJ7P5dGuJ4xpsHZVw1FjmSyMrzsNL6ua3/gNU6dOQvqpYeySvCGGtaxI18fyg0
	hK024E0iqKeAoy0g/ldvuCdAW9kFTqCHQvDBt2B5b3YT4sb+ULiQJOjVQrwaFDyGfoVbbQ2mKDF
	X7SVY2D3gNQ1tJgq83yHw8VaRpYqS9
X-Google-Smtp-Source: AGHT+IG0vAcO1UZbZQgNqvbgZUHjD5XQKWCwNmcEy+pBpVxlSRX2iDRZJtme5tI5IIPn/5PNk016Wg==
X-Received: by 2002:a05:6902:6b1a:b0:e7d:c9f4:ed81 with SMTP id 3f1490d57ef6-e8b85b1fa55mr8123147276.34.1752384572799;
        Sat, 12 Jul 2025 22:29:32 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7aff2a4bsm2169924276.57.2025.07.12.22.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:29:31 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 1/4] cygwin: faq-resources add 3.4 reproduce local site
Date: Sun, 13 Jul 2025 01:29:10 -0400
Message-ID: <20250713052913.2011-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250713052913.2011-1-johnhaugabook@gmail.com>
References: <20250713052913.2011-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

This patch adds the section about reproducing the site locally in section 3 as 
this seems most relevant to the resource section of the faq. The question is 
"What if I want to contribute to the website; how do I reproduce the site locally?", 
and the answer is a brief outline of the essentials on running the site locally, 
but with no expansion on the details, or how to get the doc/preview html files.

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 winsup/doc/faq-resources.xml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/winsup/doc/faq-resources.xml b/winsup/doc/faq-resources.xml
index 35cb68976..9b8439b4c 100644
--- a/winsup/doc/faq-resources.xml
+++ b/winsup/doc/faq-resources.xml
@@ -52,4 +52,21 @@ and an API Reference at
 <para>Comprehensive information about reporting problems with Cygwin can be found at <ulink url="https://cygwin.com/problems.html"/>.
 </para>
 </answer></qandaentry>
+
+<qandaentry id="faq.reproduce.local.site">
+<question><para>What if I want to contribute to the website; how do I reproduce the site locally?</para></question>
+<answer>
+<para>First, clone the <literal>cygwin-htdocs</literal> website repository.
+</para>
+
+<para>Next, ensure you have a server program capable of creating a local
+host using a <filename>httpd.conf</filename> file e.g.
+<literal>httpd</literal>. If you're on Windows, you can install
+<literal>httpd</literal> using <command>winget install ApacheLounge.httpd</command>,
+which works well for this purpose, then create and configure the
+<filename>httpd.conf</filename> file in the site root. You can also
+use software like <literal>XAMPP</literal> or <literal>AMPPS</literal>,
+and configure the default <filename>httpd.conf</filename> accordingly.
+</para>
+</answer></qandaentry>
 </qandadiv>
-- 
2.49.0.windows.1

