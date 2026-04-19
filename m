Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by sourceware.org (Postfix) with ESMTPS id 9F9B04C9175D
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F9B04C9175D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F9B04C9175D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1132
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576445; cv=none;
	b=US3fpIamOes6koGawUw4kUnp4114f8E/GB435wsnvyzz4Je2iGqXvu3cAwqaXf44TH3K2Is1nSBUZDfoIr3iFUo33BA6o/BePeTJynMk7MnOK+471q6udUMfVyYoFtyxE6a/ieeEkn9P+5jEAo9vH8kkyEwdaMteOndbspsaJDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576445; c=relaxed/simple;
	bh=1+VisYMoSLjZkBrgySwm3zh/Nkt6uebU+g+S5rKrhtA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=vMzCMh2UmABiZJXrVZDuQFxUOm1RYGmkLFxcDLml4NfvIfKyqa+C8Pz3tVbONrcVfZC9Tz83wVmXcIoYhX/ZDJJHa8X4fREKNEEPx6xJ0fcz1eDzAUq734ninUQB7nHzhEfybZDfk5TNSa+hFZYneSrVQJnpX26LsHPz7PM//CI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F9B04C9175D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MiKnlrqi
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-79a535e7c00so19670897b3.3
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576444; x=1777181244; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGGqkdFiXn7UdGJbAge2n4P0KNwIfl2r0z9+ZKffWvQ=;
        b=MiKnlrqip59dclLGxkfcHhBdeGKH2KzsApVToVpkJtOjyssnOxvIIHENyqryS631im
         AKgxMHCnVbeMcwzuwRte/oUg9+Wx1teIuh3x6hgamiaTbd/eEIm31C+KDo/Q2j4T5iv6
         S1IhpQOvhzxxZ3q6NComwBpN25ix6xqAX0rrHpO2c+QM2In9Po0mq1ES8v7+pS4lRcNR
         XdXmhmcBlbkBBQaAvd4vJL5ea8OzmniO4f7yujo+5xZUeiq6G6xNbC98/wQvBQyn2wLo
         WvBPHrrukw/0lu9XplvkOZDcdGs65C5Dl+FiCpXpegNbz15R6sfrUt78ofgdsbHV73yc
         2Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576444; x=1777181244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGGqkdFiXn7UdGJbAge2n4P0KNwIfl2r0z9+ZKffWvQ=;
        b=A+LR0CZQiyN3RabW92FJnB+GpRYbVtHgkWu9nZdugbKVOi5lSfUIE+eM22TP51idLg
         xBFirjthYHbXR4y3TxL3ZQTSz5VW8Ik+VvlrWuvfWaNgHk76L1n1VBaH9bacrYooajCa
         ucOPJBhXWJBXEQTst6C/sT4VFeJ3jm+GqeaWSvwklkm5gkFsE4HwMKtc2ajdolHFFu66
         DNDLKuXxgXsv25l2DDgVCQ43B5OC48c9aOsHVqKtSiBobdNbz3SwZUNwLYlCgGhTPvqO
         I6ifJ87Q3bM7pv+GVFfkAQi6lB+d9oTYbt/HB4ooeK3gWUWqkeEAWkht5jMDLIsO8T0M
         9lUA==
X-Gm-Message-State: AOJu0YxUbZqw6wTOLj3/QYqpB/+pUsYRKH+iCMvpQT89TLgZ5u8gmJv/
	KaqBaq0yTxjSpB036valvYgmvtgWyp9c5u92+tJvqaoOA9clf3k/Wm7G0+Gtsg==
X-Gm-Gg: AeBDiev6oluLsfq6P21gesteke7w35WAcUFJbxKiCKlD2TxkiyPndPYqwZ3RyHg4sx3
	m1QlGTiaKysPieEZh4XlEWMeLYIhOhDih4k8nGepHcRxK8upElxIEmyMR5DYucrni4/En+/zgxH
	zQtmb68OszhjuWRFARJM6Q5LRTUkma5bb/2HgAwGQURVXXsYbw8UpPpFb02TQk8I+WhuPOssq4R
	5Eyo30alLU8YimG7VwvOdwpf5w4EQGxISM1Y/9Zx4kcFuptambGDXID+OogMWoCCP9AL1UsDAxK
	iVxJ4oiMBse3CVxzsFWCMdR20Nbgz+AhLLkCQ+xmGGB17+XWBiNyo3i2kAesgxxAb8F5AZ5cDVa
	El6goUp7w41VstOnl7QG2hAkGZz7GN17v0afQh91zDI+y9vo8BSWTImePJM9Aod6EC3q3Olb/hV
	8ewwW81cofK7utQKptlD0SRqmss8pHlxfc16oD7lRzuhSOQPTJbCulfmRyANxUD/XlkF1spfmJk
	GwVFIbVeHQIItENMMzqcKPXusZCkPMbYtyn2A==
X-Received: by 2002:a05:690c:11:b0:79b:d56a:a7c2 with SMTP id 00721157ae682-7b9ed0108ccmr92168897b3.48.1776576444659;
        Sat, 18 Apr 2026 22:27:24 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:23 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 07/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:55 -0400
Message-ID: <20260419052701.513-8-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/style.css b/style.css
index 5e815292..abf6b8bb 100644
--- a/style.css
+++ b/style.css
@@ -338,6 +338,40 @@ ul.compact li
     color: goldenrod;
 }
 
+/* code and code-block styles -------------------------------------------- */
+
+code
+{
+  background-color: #80a0a020; /* same color as menu with 20% opacity */
+  border-radius: 2px;
+  padding: 0px 3px;
+}
+
+/* quickly identify code */
+pre.example, pre.screen
+{
+  padding: 20px;
+  line-height: 1.25;
+}
+
+pre.example, pre.screen
+{
+  background-color: #80a0a020; /* same color as menu with 20% opacity */
+}
+
+/* link in code */
+a > code
+{
+  font-weight: bold;
+  font-size-adjust:.56;
+}
+
+/* code elements in dark table background */
+table tr:nth-of-type(odd) td p code 
+{
+  background-color: white;
+}
+
 /* pkglist related ------------------------------------------------------- */
 
 /*
-- 
2.46.0.windows.1

