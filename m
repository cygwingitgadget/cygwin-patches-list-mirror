Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com [IPv6:2607:f8b0:4864:20::b12b])
	by sourceware.org (Postfix) with ESMTPS id 181ED4BA2E06
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 181ED4BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 181ED4BA2E06
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b12b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290110; cv=none;
	b=DjIhGDicSR3olvFO2e6M1yQAbvoyUeoMu+vCsCrJz49/dsVVvgsPwG1e3V9iA3z/5wQ+Ra8PV3LQKm7dYPEnzeW49++eC+CF01W4MBbRVSg7yGG69q7AkaVu5VAEotQIxrMbwEfr32h3EXO/ME5rO+E53xTUEv1tQZILQWv5ctI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290110; c=relaxed/simple;
	bh=b9tAjoudqrk+1AI8Ore0/J32fHXvE8yjccJM4OEp2l4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=mTVreyUklE37LRo5D3RagKtj9A91uuyHCsmbSRd/J6jlfRFoEl+jXSkI47FVcC/aIoUQyUxZG1pXU5qOs9Y35MnCRU918+EM5YzdHPzxnyiuyYm3nw+9ENe3gkKS5Bqov8u/zlDqVZ8hchqlauSsVX9QxdETcCZ7Y5uKxiN47Jk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX8MaRBt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 181ED4BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AX8MaRBt
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-65c21049dafso2607685d50.2
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290109; x=1778894909; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C7QemC1CFx/HKHZUq/MuCQG5hoTKx2DLPiM3EoWJz4=;
        b=AX8MaRBtdUIT09P15UNpC/VDHlmdaVM7LuflAzdDtMKvu1NpqogBU3H1pldX3l1SYj
         SVWeDuML3iStSYRRVIxEiIOv4gggjL52JfnCy9+BOEgrmIgp8/caxWPa9bbQse/dbybp
         9LNRvkT9raLE8SQfOYLKkY9E/Izd37lMIQzFhru5c3HRkjGWk/b7jiPDCeIP43aH2Bz9
         xWBFNW1uJ4nHbNcnjN8ml5LbXDxzEvMo33hQxj8Y33ozDRkMLWPxZCuoUjEu4kgL27gm
         KJd9kWbZByNtCp4ADVQz8pLffbH1n/8TzW7goIl8DbsVIZ74xjZbMhJFCzfv6Vd4YJ0d
         yn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290109; x=1778894909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/C7QemC1CFx/HKHZUq/MuCQG5hoTKx2DLPiM3EoWJz4=;
        b=FNUKCN1QTekeeAKI2QFoEGnWjIA3SoM1Wj4BJE9qIXS/1T/HBEEl8SH3zqGOw9Bt1g
         DQuVLeoI9KjbhUToNqNTIwHvDIyuBCzTpIkHfFHdz+Sn5YVi7oGufnR0sGRIQtMcXaXJ
         uSj3xgI/rEW4sOMr+1P43OVms9q7e45CdV2+feYsK3Wtgtc2D71vPYDox3T/FAxe2JkS
         O8inFSt2a5GlaJSyL9/GbHxz1BF6RIE+MI185KsckcBG41PfWH3rRHlYIfEHgLqbOmo1
         lhLvPhR4my4yt2/qK1r5umk9xlrWiGspoeJ6O9yPgghgWxyqRgKqu7UcAQ8CTyTskR3/
         l6pw==
X-Gm-Message-State: AOJu0YzwrFSwbFJuTfTyWJE1wIA1PpnkNmEeXhfGuxmxNmtNk9FzFew5
	O1QQBM8BXPHBvJ21ouGRx8NgMV+Q2X/tdCzlsYrtBQSRO4vaGVgsQrCq7tXg4Q==
X-Gm-Gg: Acq92OF9Nkpai0Ie42Gnu6YkjUiz+xQmRL1oT1ckz9+UitRh/1U0KF9OLLy67yhnnYG
	SV1jcCBegJ057hG33jSNwDdrc9MVT0o/23TsQahovcF6Z6bVwWK9DeDspQgeHhOYDLCPHeyH0X3
	trg0K9vt1BP1IBR3SbjxHlUVe5xwVhioBelZeLEJl683tEiF0q1XqeYx9AAxFSXrsQXLVJVaWiZ
	a8TUjCWwP8vazwVnwLKlNf+/ut062rgo7JwkEY6dGCS8XuIJ+QJNgfwBBGpScB5gDjft5OASd50
	muheEnnmam+npn/E5wKVR84Hk0iWvkcPEH0cHHP54aFRcC7bL8qNV3fvR5zgz5Fa5lM6F2QMUEc
	YzrQDT9mbRBuFE3eqYUyXU34fh8Ie1+C0QKpJSt0ncdJLMPElK8HJLdoY/C6+K3t0f04ZzHFURt
	mXq4EIv4rJmpgOF9p6gsGWwrYVSVQNSY3v8XUydejYVE23FCHrY6Fhe53gqIHT+gBbDy2pc60cx
	m/f3sbGYSgYaK3GxZ6gyyuPwWI=
X-Received: by 2002:a05:690c:6e83:b0:79e:8299:7505 with SMTP id 00721157ae682-7bfb71f574emr47173407b3.6.1778290108799;
        Fri, 08 May 2026 18:28:28 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:27 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 1/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:43 -0400
Message-ID: <20260509012815.1157-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

style.css: apply global font size and line-height, better accessibility

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/style.css b/style.css
index 0777fd0e..1c5a1733 100644
--- a/style.css
+++ b/style.css
@@ -1,3 +1,10 @@
+/* Better reading for accessibliity */
+*
+{
+  font-size: 1em; /* essentiall 12pt but preseves pre and code size */
+  line-height: 1.35; /* this is a bit more accessible reading       */
+}
+
 body
 {
   color: black;
@@ -27,6 +34,12 @@ a:visited
   text-align: left;
 }
 
+/* Accessibilty override for navbar */
+#navbar *
+{
+  line-height: 1.1 !important; /* override the global line-height */
+}
+
 #navbar li
 {
   overflow: hidden;
@@ -93,7 +106,6 @@ a:visited
 #navbar ul li.nohover li
 {
   margin-top: 5px;
-  line-height: 1.1;
 }
 
 div#main
@@ -202,6 +214,12 @@ div#main
   overflow: visible;
 }
 
+/* Accessibility override for nested ul. */
+#main ul li ul *, #main ul li ul
+{
+  line-height: 1.25 !important; /* override accessible, looks organized  */
+}
+
 /* Header/footer styles -------------------------------------------------- */
 
 #big-title
-- 
2.49.0.windows.1

