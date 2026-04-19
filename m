Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by sourceware.org (Postfix) with ESMTPS id 54DDC4BA9023
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54DDC4BA9023
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54DDC4BA9023
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1132
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576438; cv=none;
	b=f/7sOBHFb01+T9lGGShsrslj5MrE0X7bVAKy2YbB70+3X5tdo3No3udfKSnyJ6F+mp4hJcOQttaGmTkQPaoJJZmk4gOgQE06qAOkTEgzsvHR0Iazdd+Nkbi+EFsfvs89saVAhizEEcqbnSEjgo+fEIzQra/aGCGNkPYjl3Q5eeA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576438; c=relaxed/simple;
	bh=BISfXUT6qOMParaquM4RYirDc4j8DRcLZ6awa1XJNW4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=NNiCmz2o/Dm8eGFV4cG6V1/5/+Wi4VPHRooqMmMXde3Q3OlxfHHWMT3y/hPRybp3XUsRppQzgxsx/3qLdWtYFehMbmMUte3lJPyrcocvmhOU7zRzBcFbAalUmKztsKT+IFDdd2yUb1LFnOKPhAmq5QCMBWK4p3Va/RVjDK+B+J0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54DDC4BA9023
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LeVjgnFE
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-79ab3e26cceso15879857b3.3
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576437; x=1777181237; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfnB/0uZ10Sq383xQwOkF9ikxapaQeRlOv+cLXx/bkI=;
        b=LeVjgnFEyZ+ubqc67w448X0byvjxsz2kp6xVsgJH7mR0tCRdPiL8i7oixY1xB44P2c
         StMDwNXDiWksYrLbtrH/nhLN3pm7h8w+Zqpann3fk+iqUi7r2WCYoGz9avo6NEx8650B
         h7CZ30sY1HLtHaSMCrjvKPLb6yctLSSw1Tirx+i6x8uJ1GPf0JdAspc/xb0y7N1KouQi
         MXQDL2vOOaT/bGlyXVRCv/3GU3oDYYkVobKxOZJi/oxBaC6jO57jPyowvK5Sms7momNn
         xPuVjvRcKMD4CoZXUAsKXxDr29tTf+UxRFH5gs6d4ru8wiFxLJrtzM9sq+NzKM7aJYPU
         9adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576437; x=1777181237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfnB/0uZ10Sq383xQwOkF9ikxapaQeRlOv+cLXx/bkI=;
        b=jZes921B3XfndM2BkHRlHY4lInidw7yJuM1AXkdnNuATgFDBUHe4uRgBevL5x5WZ0n
         x7doVtSk5URP5JTAqhf8G0sNXyy+nzW4OHRMFA/9TJ4zxa8bAinHVvBIF67foeW2Pkvo
         uukCTM0ZEke4mHWEI+p9NnxwRxSb6vSgvUWgBWRF0SZIpc/Y8QddSPAsP6S2z2KX6fjL
         rPRV1pv/khZEx458/Ss4sKF1hW+hDMR9oAPIEihPSrqep/Wgw3TMXKkT7stWOeuejENo
         858NK9Un9VFpAPHFytb7WJ6VdIcndgAk2D28xvKy8ilaXfrYPpA2PF2L/3pB6t+eNE46
         Cn4Q==
X-Gm-Message-State: AOJu0YzYe9BxPtBQuXv4ViJ6FgQjzSrQFANEoxCn+Z1RazoIQElEPBEW
	IwMXFiD7inQIHeFU3HqLzVZvNH9XM4txYAw1pxdJO8lBSRkGEhpvDBK2Z9tnEQ==
X-Gm-Gg: AeBDievINB4kYXMOHGk+8z3ILBiimPsbmKhu2Mq/ZgBxWKRmW/+G5WE2HShdS9Ty3U2
	PWk1D9f/e4qi3+tJf/j6h6phEebkyJWI0kTDxYmmsLe8vj94hJSH4M1YF0Mfu/IZiGn/3yIaNbk
	ZeErB8M8b1Uy3BsnrAnJdf0Mf4I5FaezifPPC1s7mf6uFRQ+M/9vFgKyaLi4YpIhNsm8dZhAsY4
	7627FVUZdpVw71lUI/AqFD81B7GCsElVp28YQIMSdsZjqSSbJloZzXMElxb+aoNyoiDMbIvhvND
	X6v63OOqMEZr1W/IMJv9Zi+diTAWB9p1Bplm0g+BVaptLmn3Q1S4eftiGUouVR2kkArSOydCs4u
	4jxZj5R7P6XKgsD/6s6iik/O1DiTKn++Zo72Ya8EZTf0UqZFKLeeVNUyVVUJKonvbsTUsbU+dB6
	5ffLtiU2iwG4g8UlW5KpNPnRY5iBr1/AH9E+y56UEglQnF0Vuy4yYG3IXRYiBiYWTeCwgDdp5Af
	E9JM3/CiMVVn9MY9P9x0YKcX1/xu+ms+IEdlA==
X-Received: by 2002:a05:690c:6e87:b0:7a2:80a9:93d1 with SMTP id 00721157ae682-7b9ecf98abbmr90050157b3.25.1776576437249;
        Sat, 18 Apr 2026 22:27:17 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:16 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 02/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:50 -0400
Message-ID: <20260419052701.513-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/style.css b/style.css
index 5e815292..3b3647d5 100644
--- a/style.css
+++ b/style.css
@@ -17,12 +17,12 @@ text-decoration: underline;
 
 #navbar
 {
-position: absolute;
-left: 0.5em;
-max-width: 11em;
-background-color: #80a0a0;
-color: white;
-text-align: left;
+  position: fixed;
+  left: 0.5em;
+  max-width: 11em;
+  background-color: #80a0a0;
+  color: white;
+  text-align: left;
 }
 
 #navbar li
-- 
2.46.0.windows.1

