Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by sourceware.org (Postfix) with ESMTPS id 0E4344BC0577
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0E4344BC0577
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0E4344BC0577
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1132
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576447; cv=none;
	b=kAWQ7+yDDxUcqklK453+TlSmGa536P53k9mjwbKjSaisGOvisqyN9y80UVsWlBoZqs0+gykISZPJel7+l4GyhWpmL2J/gPRdX+QXsPZW0JG6i+za6dI2SxzRkkBMwWb39JivQ3GZTRmTfFq9NfbEyZtNfsFIWDtTJsvZSQEX6jo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576447; c=relaxed/simple;
	bh=MKPFraOu8Hzr0fy2VvgXZG0AuYgeVal4kT5c/xvWeNk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=MBcGJcopiuOFkNEh3J8s9+OW2USwtGUKu5UmGxDAU8FsEwc59oIhqQ6J02cGo55uuu2WfyDKDOL/xZ0kG77O7QsbZoLNKRGnYfqyrlZmwqT31FcuaYCVd+2YgwrMCUN8VhT66TZf+6vB4dDNN0m/VNAtiGLE7FY3pV1hWvtHOb4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0E4344BC0577
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RnVqGC/0
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-79827d28fc4so17681657b3.1
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576446; x=1777181246; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzj4qRWRso8jn1dS25SIQqQyCFR00My0Z7tr8grq2UQ=;
        b=RnVqGC/0YjNSoKoPXF1q7G+RzXyn/Q+iA7FIWFGOronvkn4UoBG8rTb9oIpzGpM5n8
         rqeUwhaCLiqxSHcEgtp47RxVqpqy73QC36T9fWseWpUfazqZ61hDRemdEOwyFhCXmp8Q
         v+2qZ98W7qTxU+KcbeEAtaLuIh1O7ZSvR4MDHM0qFIXth4p1TEnvOt//JwQG7gSiYQDl
         /h9HZF1d7mzbNfZAXyjuRf841K6W0DfwpfgTLNRGTcBis0BF7xp2mLk8lID2Tm1FjNkE
         9Xi0zbp7hJJRdczHjzicPogo0pmyHZfa20YU20FjPJYJ0GJ8sa5TJGE+2kjzZlXCBGVU
         sNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576446; x=1777181246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nzj4qRWRso8jn1dS25SIQqQyCFR00My0Z7tr8grq2UQ=;
        b=Uz6xTQaRZ/jByTYQTztJRoUMa4/RlEFGsmzZgAwhwWIXku1AVAopxjJjlxzy8Y4tya
         NYOJTLrKFgOCQ9sTFrD49sVZGrArZQHSswUyIFShuYaWQh6TOt/Vkiwaa2o4wGOSegnY
         FD57W+nIy3k2+xQxG2mCuIGu0p0cB0YaWjOen9PIrM8ZGWqkXw39fCHoo8M4FTv2XbJd
         3fumtU5LhFVDMshhHqJvU5qlO5jyHlqVuGLalT0VsK/V0ByVe+S5y16EkQmZ/1Q3sw8h
         qdtA20M/QsjSbhCIiQ/NBZqOF1F+OG45kjtA+0P+FUGppLOPlMjThfPYhBgQ+OBYEooP
         v0bA==
X-Gm-Message-State: AOJu0YylJXOj1sjrDxhN5SbMRlnWcNZ7aVZGd4Bu7aZ9E8tGY1SXM0Hh
	TT1lGZr2jhZAoiISxYX8eb3rzzJu3fWT8KmiwqUn1ttScRZVj01m0QBdKcCe+A==
X-Gm-Gg: AeBDievONA7AgIbcm/vuSAAPVhgS46JOsROar6grlfiJJn3e1c43dAkWSbH+O/j2DQP
	apH0O7KpS7JMhyNQODxDvrOBZ033qELQeczZNx3X/I5+ZRZzQ78AdaBujqWoniuGo83SzVRGr0j
	m7rMPFeSe/KGKI0iCrHmRJlVTeqMJw8Y1kV12mWQ0w9hcaAOJDTMBd+dUIZ2pQmrF8Pp92F8Ve5
	OMncBqYLvQX6P7mEM1gEsyqu4vy6PNZGuvdQx4CnOPjpMAu+lsiwsWFrL8XCMP+rBg50wnQ+o2d
	VasTnsliMsvH+NlCXqWTJz4XAD/ssfbrOXkXX8YneImDybHXcUXvXT62/8PvuTu+OvJo4K5D7k3
	pbepowXGh1W9wiGqT6B4WBpCgzAy2kKq1MkvQBWEcYCYqdGKDbp95zDHZVJzFzZYYQWwzZ85q4x
	jE3lC2FSK7d9U5iz5LiHhLmDvVX2MgAiv+p+EERjs1+SkDepu2f0ZGW1iixuy3c425tKz1Wmssw
	xZJGMecHTIg/RzyMTTzzPFuUBYvzeG9VtKiUFW5FUZKxUC0
X-Received: by 2002:a05:690c:f13:b0:79b:cf31:978f with SMTP id 00721157ae682-7b9ecec4c9fmr92898657b3.15.1776576446059;
        Sat, 18 Apr 2026 22:27:26 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:25 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 08/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:56 -0400
Message-ID: <20260419052701.513-9-johnhaugabook@gmail.com>
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
 style.css | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/style.css b/style.css
index 5e815292..efb0ee69 100644
--- a/style.css
+++ b/style.css
@@ -338,6 +338,16 @@ ul.compact li
     color: goldenrod;
 }
 
+/* code-block style ------------------------------------------------------ */
+
+pre
+{
+  width: 100%;
+  background-color: #80a0a020; /* same color as menu with 20% opacity */
+  border-radius: 4px;
+  padding: 10px;
+}
+
 /* pkglist related ------------------------------------------------------- */
 
 /*
-- 
2.46.0.windows.1

