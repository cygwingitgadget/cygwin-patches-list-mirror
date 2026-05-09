Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by sourceware.org (Postfix) with ESMTPS id E395E4BA2E08
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E395E4BA2E08
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E395E4BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290112; cv=none;
	b=mYv1GYoHCp/isWSX/91tCUbcg1iLXuQETsQkPcNlnu3Ydq9DsnMsPmVkzZlNwLgx7bNeRVX85LffwAzIlxJ2tltLmkQCihrlA+H69y6obKLeBMGE/vIcuWTFUUiFxXvQhVFiM1yCx/5RXNaPF74El2MHBMH3yux6D0D2woFGWRY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290112; c=relaxed/simple;
	bh=6IKENYHe4WZMddP2Zbvia+xobLmIVneKqfmncYVIhBs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=LVVVOLOwrYMBkQJ0DGW+UUcBvfdnz6ghhz7CxL8DXVI8bc3LYJwxLiruM8EhertVKTchSEDGMOrSUT/RFXirCWwVaE2RpyVwyOqalgWcpF2r486Vo6SKgXFY6kF2PNiJ414EPSDHaH54icjliLl77qhy/J4Vr2YS110hDMRocbw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cr1ttRRN
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E395E4BA2E08
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cr1ttRRN
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-7c0de780bf1so2624967b3.2
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290111; x=1778894911; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVGv4Wp/kvm0v5eKJ6SRKU/MnPVz8by7DZVn0bx45d0=;
        b=cr1ttRRNdn67IqWDOrqJrQ02cxrNRgQh8jR3GBIEKZHxyV5sxgRThBhTD3ibce8nsK
         /Z9n9ZiAHTfJ2Fh/LhDkTu8HPUdlwfFRdc9IfDEDVEPKs1KTEDDdMVxaJAN2mfQT9GQ1
         9tNWvBL5qLMdQ7EwFArKpKAv9sjmsPbpkfoMysorlrSYoUXlkzrSSK2F3+lk0xwdwXfp
         s7bSHjXB2XarGyv7WtVFTc35Kr1RkRXOM1JyZyWPz0UT6BFqfeV+QX+AKIcp0RDcTLMa
         kwPl81a7+2jGMeybMeRJXnBAEH161/QgbyWI7af4Qu5udSBDWl5hc6jvUutMPAYpwyNg
         sWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290111; x=1778894911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVGv4Wp/kvm0v5eKJ6SRKU/MnPVz8by7DZVn0bx45d0=;
        b=St0oSllo47Hru2C8o3LkhHKuLoBiBRbkNikIQSQ4QkoR2ZemURj4/+w29sykS7RRaZ
         SHaQBadMDnXJce+rDmKkxv9u75e6SiPB/Yj8MDX/3JBiW+SM68SCpNtiTqQgH/O/1BN6
         LsoZCSmuOjyZl/xoF8oPyntY7BUoBMJfor6jpXnSwNs7ynfFEACBM9K7TJs3Spo+Wf2s
         Lk9fsrQFE6ri3IhA2VYz9dz21jb+tFExbxvdUrK5zo98cMwV3+FgAUtjTwIc3HZbrxts
         itNifTXZQOWawFmf/JCmwOA3Lpz1ErsWfKLTyHA29LbwVOak2SaYtQTraRGA0AT81a5N
         1cmg==
X-Gm-Message-State: AOJu0Yzx+FsQGBRVaarBeZQnFi1BS+uGhyoQNcntY5swxlVZlB8HKvMw
	BkEGVrzlZCiwUXZ/wVbxWP6Jlrs1ZEIjOU5KRONX9RoBX/Fl6LXH5qU7drKQNQ==
X-Gm-Gg: Acq92OE8ZLvPYCG5UfoVVPdIjz8FVbD+OWgGvusamm6MUQrwneLvIVDs4bxxSb5hMuh
	KHQB7slXIVEYpOm36tO/qMOYOAhnT34Hmr2DqV3SrML7hgnVtR64UpSeIg8j9nBixsOTnEHEXR3
	wJ0AkUPmX5Rv/jMjL8DI0PMOa38uSeuxicQdqAs4GC25/AiGZ/o8UUmee8XDuul9EP3GuipeaqN
	SG+ZUU5Ed5LH8m+QnBiHfYzvfmacRL/bhQ/aC9FuEwh4M+rZb9VYTGiY1lbUQdAjWcVdYhcMtay
	VMOw0WHp+b2ExBtDS9L6yn8qaUWcKZo9EsOtusLuxukQBdiQa7IzsAaOxDBUx84kvWmTuoONkOo
	aHLcDsplVZjGs6f26UXLD4ykHnppWZyVVSeRtjxGXtvVOTvI43nqyL/7iesOD6lGvotCcaNdUmN
	XWhcMy1aJelY2p5dliiCuYgITYEoEyQ3K/GCT8g5T23VxMezmgrFy/kzUHyq0w7bbcMm5oIxte3
	3Hrb/+sc42nQAA1/gN1lsnwcjrcKdUpS5HdNA==
X-Received: by 2002:a05:690c:b08:b0:7bd:8782:bb63 with SMTP id 00721157ae682-7bdf5dc7ccamr153431907b3.19.1778290110745;
        Fri, 08 May 2026 18:28:30 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:30 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 3/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:45 -0400
Message-ID: <20260509012815.1157-4-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

style.css: apply font-family sans-serif to all but pre and code

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/style.css b/style.css
index 1c5a1733..78baef51 100644
--- a/style.css
+++ b/style.css
@@ -5,6 +5,12 @@
   line-height: 1.35; /* this is a bit more accessible reading       */
 }
 
+/* apply font-family to all but pre and code tag */
+:not(pre,code)
+{
+  font-family: sans-serif !important; /* all but not pre or code tag */
+}
+
 body
 {
   color: black;
@@ -72,7 +78,6 @@ a:visited
   font-weight: 500;
   color: white;
   text-decoration: none;
-  font-family: sans-serif;
 }
 
 #navbar a.gold
@@ -204,7 +209,6 @@ div#main
   margin-bottom: 1ex;
   margin-top: 1ex;
   text-align: center;
-  font-family: monospace;
 }
 
 #main li
@@ -224,7 +228,6 @@ div#main
 
 #big-title
 {
-  font-family: sans-serif;
   font-size: 5em;
   color: #990033;
   margin-top: 0em;
@@ -236,7 +239,6 @@ div#main
 
 #medium-title
 {
-  font-family: sans-serif;
   font-size: 3em;
   margin-bottom: 0.2em;
 }
-- 
2.49.0.windows.1

