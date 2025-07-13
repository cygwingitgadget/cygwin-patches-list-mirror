Return-Path: <SRS0=CAkv=Z2=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by sourceware.org (Postfix) with ESMTPS id 150C03858408
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 05:29:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 150C03858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 150C03858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752384577; cv=none;
	b=M7dTGpCeqVjm7I9SofHBZhegpvrwaEW/4P5ImFKXHNgxRIxDvXllTnlrqLxAPyipFvOPSOxTY8z5sAIIAnrn6mI1TmKejeY4I3xaRHObPZ3kD2IewzUnG5UKpnur6pK16SAfpn8PCabn1hoBXoJiDTaVjrB3HcoHrqsRvnCLjcY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752384577; c=relaxed/simple;
	bh=OZTwEMfR2BkJQHfuQ3bRAwmijV2LiiG4jdeQLBreyas=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=s6oz4DWCYycUHm24SpchuiMu933iZw9aPd2dbIbExiOBaGuqBtwqHtxSxkIHcUuL44vLzSs6S596UUpF4ePOjngW9n6FNl1dnaoredgotDmEWNvWu896IYbYXT9dwTuTQ1ea8X0MCrgMF5wOGNb5tCRd/LhR3z1wYi3XxrzzQdA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 150C03858408
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=CTpfeBgl
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-70e1d8c2dc2so30523047b3.3
        for <cygwin-patches@cygwin.com>; Sat, 12 Jul 2025 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752384576; x=1752989376; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePI7CToP62o2d2qhvaOTgQND6zCcbby/Jwk0IZYs0rE=;
        b=CTpfeBgl0uRrAe1xQJvzOX0BXaPw4fhqEezpoQFTO9ElNKlUI/nPN8F851HFy7DqYu
         P1SaP71yPwiY9vhYRLiZouxno80V4W2Qb4mtFe1baxlfSnelujtOGVd18j+Qi3M07mLD
         OEh53Y/opytNOrkTi6G0OzakfJls6TVIPBXE/1WobO6ddfdAopkeQEefVQc9NUQ/4mzd
         PpBpqV9C7gnc+w6ABEdaW8FGPVhDYfUtRde0OGFuIZoB9xa8iXiItfzq79KkBWsFjWu0
         aAnS0kwxmsH959JxoFC/mVVUAy9alqiW9YWt6SoXD4T7uL/Nu5hkWYMdR7yx7X7dTDmB
         LreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752384576; x=1752989376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ePI7CToP62o2d2qhvaOTgQND6zCcbby/Jwk0IZYs0rE=;
        b=cs32bZ4xVJ4CZvY9Pu5A0vmlSomCwEWA4XS8QOQw8Plm7AoE/ycXHxOU9F5ewJTBdM
         61qMonnAqs0fYAuhhD//+rcC0tX3eSJ4eygfkzDkW0NWhekB0lY9FJqrDmVzLV8epsxq
         l00VOUIQKz1j86FOWyvwP0CSxAfC2ZoZXTUD3eKFole+46Lvdu4DzdLZysQDtq2QC5tn
         z1S6TryHis3GKbKFA8uTemq1TWLmaq2RRUS9rlBF3UkOE+nA1OTZjdLn7Wyo981ZNLfi
         3gvrGNwaypjZ87lXERJHxLN1hogS2+/Li1L5Uk0QsLVdl3TI9sznG6qnrBQZbQUZ9oSn
         uB6g==
X-Gm-Message-State: AOJu0YwM+FeeKRC50sDexbikPz8ydV5PQzA22xb1OIBCPJ2Lx6l6j1h9
	i+Q4/bPGsbG4KJMBDPEpSg3K0D+29qRrr/Y3R/m3g9hMwm6x2QXc1iwQaGxaDg==
X-Gm-Gg: ASbGncuZVQdypy+NEK1GxqhKItK+VdWFig24zoXVRQCTzkUYaHAfVjp5+MGcf2rsKHA
	WDZY/UPmVIno5nMBUsusYMfGE4a/4N+QaQ01Q10rpt+ydTBY6ECGnYI4kTmSdr/eUwqEY+mtzHi
	x6aZXMSzLwYKVHlI5dX7bFlAatuMT7Az62GzC8Wiy0hmyliDPV1A5gDY9T3qwwxb65z2zBsj1oK
	0zFn4ClNuJVkFPB8rjMUa3yrQd3SYqLeBK3q768XCiKCeSKd7i/+AjqFLXEKuROlv9LUQ/PdzSZ
	9IwXEZ6AXS5h2QRJFswhuSMnPi4ZZN/eVupCm/iFTldlgnLkTUSipZZGg5kwvM/1yWNT6GFe2YV
	SkgOYq8Ue60f5lpBmGq5u1VvqHF2tHJatwF7QfanSnq26M2q7FD86LrDfxcHaSQUljnej3ywSXB
	kO06nMdzJRVaDxsYAFrpOSxvqe9EIv
X-Google-Smtp-Source: AGHT+IHQ/pxnSPHfMiceYRBE+vFenouav/qRoWVGQsd8+kDPoPTEwKYBjEaIKncVuB3xQ7fXZ05uQQ==
X-Received: by 2002:a05:690c:6707:b0:715:2081:f2f8 with SMTP id 00721157ae682-717d7a6183cmr126913947b3.27.1752384575658;
        Sat, 12 Jul 2025 22:29:35 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7aff2a4bsm2169924276.57.2025.07.12.22.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:29:34 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 3/4] cygwin: faq-resources-3.4 reproduce site docs
Date: Sun, 13 Jul 2025 01:29:12 -0400
Message-ID: <20250713052913.2011-4-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250713052913.2011-1-johnhaugabook@gmail.com>
References: <20250713052913.2011-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

This patch covers the steps to build the html files that are excluded from 
htdocs. It points to the instructions on building newlib-cygwin, and steps 
to extract copies of the built html files to the cloned htdocs repo. The 
sandbox tool in the support repo includes these steps on extracting the 
newlib html docs to the htdocs cloned repo. Visit 
https://github.com/jhauga/patch-newlib-cygwin-faq/tree/reproduce-local-site/sandbox#readme 
for more details on the process.

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 winsup/doc/faq-resources.xml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/winsup/doc/faq-resources.xml b/winsup/doc/faq-resources.xml
index 4ef6f70bd..abe3f50f3 100644
--- a/winsup/doc/faq-resources.xml
+++ b/winsup/doc/faq-resources.xml
@@ -96,5 +96,18 @@ and configure the default <filename>httpd.conf</filename> accordingly.
 	CustomLog "[path_for]/cygwin-htdocs/access.log" common
 </screen>
 </para>
+
+<para>To edit the documentation pages for the site clone <literal>newlib-cygwin</literal>,
+and edit the relevant file(s) in <filename>winsup\doc</filename>. After
+editing see <ulink url="https://cygwin.com/faq.html#faq.programming.building-cygwin">newlib-cygwin install</ulink>,
+and follow the instructions there. After building the docs, return to the
+root of the cloned site and run:
+<screen>
+	$ mkdir -p "doc/preview/cygwin-api" "doc/preview/cygwin-ug-net" "doc/preview/faq"
+	$ cp -r [path_for]/newlib-cygwin/build/x86_64-pc-cygwin/winsup/doc/cygwin-api/*html doc/preview/cygwin-api
+	$ cp -r [path_for]/newlib-cygwin/build/x86_64-pc-cygwin/winsup/doc/cygwin-ug-net/*html doc/preview/cygwin-ug-net
+	$ cp -r [path_for]/newlib-cygwin/build/x86_64-pc-cygwin/winsup/doc/faq/*html doc/preview/faq
+</screen>
+</para>
 </answer></qandaentry>
 </qandadiv>
-- 
2.49.0.windows.1

