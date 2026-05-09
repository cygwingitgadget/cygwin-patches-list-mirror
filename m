Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by sourceware.org (Postfix) with ESMTPS id 5D2214BA2E2A
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D2214BA2E2A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D2214BA2E2A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290114; cv=none;
	b=bOjHDtlTQnahJMeaIMwhbt6fbAs0Dl1kDyZN+OTP/CHFoKONj0QuWdftIffGQfpJBdqDDFg851CnrbpJZDr3R6DEk4KonIUjIaQ9KZbEbc9QjY4fAbBpyI0y8MEa8cmR558jnD+Oh7IqV1w2h1TH+OULtKGRs0bAiUX960LeKxs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290114; c=relaxed/simple;
	bh=rnncKLOx3yGv6WNbcZpbdR11JfYGIVaoQA3jEV3a5y4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=dphKRCu1hfoKbwC+Dfr4PFNPMjL0ErQDkje3Y51b7zkMdgRhNF779Jtn+tL9KQThescb0MfPHha9IjzBUE+NKZ5Gi0Z++Ax1GLGyRWqaaLLypsOR0qkt0gDWwtD2q9VNZpT7NBgX/sQ9DxEt6DgzThhs2kPViLhbxTC7E7q/mmY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GDPSn6cB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D2214BA2E2A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GDPSn6cB
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-7bd9f61458eso20555777b3.0
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290113; x=1778894913; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPXI9appgkkvXEvoMH0o+UkF8xDaE25Vf677uwPiyRA=;
        b=GDPSn6cBNZ46DaZPZidI/8omdmSHLb4Mdm8Dn2wckA4o2o6EzHRJgXwhsEg+OMo9z6
         kzsQqpgrjM1TV++wkBoMSnWXmucUzQYfrhzzoXBdoRXiSG1ojxbGPH5hfMoyK6kouYCX
         llF/KIVLUroNGYWi7Ev05HaKJddO0csSzTFU3iXpIZyFSEKzGRtVTvC8foh1ZV7h02aq
         kpNT+OtrAsQoNjczsDNMbt4UF9bZiTU6ucx9L58Tyf9FSuNMKwbYrg9VV8Rfm+Qb3oFp
         Hdp5XMPFnOkyIBduZJZAAKW4YKXsMyMm1Gwwv96MqOu1KvdySWc1WC3addO9RNLnjtBT
         80mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290113; x=1778894913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RPXI9appgkkvXEvoMH0o+UkF8xDaE25Vf677uwPiyRA=;
        b=jNbkBCkB+KWJ8nLh8kK5drT+B20A9UYjGtpvC2ujXF/kWAfnZKtlh12osviHLwRjLY
         uw2kf8noB5TfTbZhv5s3H8bnjsDzYGxxasLRIYJixXIHazq0QpsIc2b5NfZFxShJkEjf
         iEuKAaqDbLIGwXmjDLFu8vfqd/n4ZPoRSWHOIT09l5JZrt9mmxqHPhx8nqp7fBo9Qen7
         PhDgmQRuYMbvmjqVrAVnOC9FbZpjzdxBfnO5hifnxPnghooEgYFyY/mkHfpCLLIKfCjg
         HEAnBxhEY+e/dB1Ji5P5R57SzU3wuzuMb+BRRs3XsmFj/jOcNW13h3S6UGiUpCvZKzIa
         zd8g==
X-Gm-Message-State: AOJu0Yzbbs/JvRdB2PCSLEhpU/XlECya9tK+ul6YslIZuRhd66whENai
	oMx1x7CjeFJTn2E8r4NWbQtneCbKad10G9frrOWHYJnorxa46PeJL5HXyBWPAg==
X-Gm-Gg: Acq92OFnd1y2p0EpjsikLyytpRstTNw/HZWaj+BEwm0+8dm79kzriEfzmoHTIxf6E+y
	ah9u3jDJ2sRE9uKVkjxhf5gQGa94kpExmBLWIjLMbq5wi3KbeAdlLre+6y+Q2DELDio2qKsFdL/
	+F1ZE98gOrytmXb50zWNh/fc1vi+UzQxRtX92lWJ3QChaNTiibW3xy5IqEwBRaiTe+Z9a3GjOLc
	3q5iso6HsLRf74rWwXM2ob5kn9d+mZBnHmQHwFUdSPCxwVXRJQTsfZPNDHECyEkrtAjYr6y9jMo
	cdtDn9lVtLHnTzp46bhmAbjfpUOSwNJTJzi5cutY1AP16ItCzOiKOxD07/3Df1tYppti5UMKZ2p
	YfuDoezl6kcI3cQDcOrhT339Hoyg5OcqPmyoRBrSg9hOCM3EkqD+5o+l/SPz+CTEgyS4SzhcfBO
	lhJyERRwimxOvX5r728mScbfYMAyn4BFu4zFCNTqGCxVeoUaijXbDBGGuf2EjqTPXQezF4YBkxv
	JlFtPlETjtyHFCqJOnfxsQDztE=
X-Received: by 2002:a05:690c:e4d5:b0:7bd:7c16:170e with SMTP id 00721157ae682-7c10361e899mr7846487b3.22.1778290112848;
        Fri, 08 May 2026 18:28:32 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:32 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 5/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:47 -0400
Message-ID: <20260509012815.1157-6-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

logo.svg: use only svg elements, add to top.html

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 logo.svg | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 top.html |   3 +
 2 files changed, 173 insertions(+)
 create mode 100644 logo.svg

diff --git a/logo.svg b/logo.svg
new file mode 100644
index 00000000..6d77698f
--- /dev/null
+++ b/logo.svg
@@ -0,0 +1,170 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!-- logo.svg -->
+<!-- SVG graphic created in Adobe Illustrator. -->
+<svg id="logo"
+ xmlns="http://www.w3.org/2000/svg"
+ xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 143.97 148.22">
+ <!-- Set SVG styles, and define gradients used. -->
+ <defs>
+  <!-- Style tag similar to embedded style tag of HTML. -->
+  <style>.cls-1{fill:url(#Sharp-C_Inner-Gradient-2);}.cls-2{fill:url(#Green-Arrow_Linear-gradient-2);}.cls-3{fill:url(#Green-Arrow_Linear-gradient-5);opacity:.7;}.cls-4{fill:url(#Sharp-C_Main-Feather-2);}.cls-4,.cls-5{opacity:.5;}.cls-6,.cls-7,.cls-8{fill:none;}.cls-9{fill:url(#Green-Arrow_Linear-gradient-4);}.cls-10{fill:#06bb13;}.cls-10,.cls-7,.cls-11,.cls-8{isolation:isolate;}.cls-7{opacity:.05;stroke:#666;stroke-width:3px;}.cls-7,.cls-8{stroke-miterlimit:10;}.cls-12{fill:url(#Green-Arrow_Linear-gradient-3);}.cls-13{clip-path:url(#clippath-1);}.cls-14{fill:url(#Green-Arrow_Left-Edge-Gradient);}.cls-15{fill:url(#Highlight);}.cls-16{fill:url(#Green-Arrow_Bottom-Gradient);}.cls-5{fill:url(#Highlight_2);}.cls-17{fill:url(#Green-Arrow_Linear-gradient);}.cls-18{clip-path:url(#clippath);}.cls-8{stroke:#1a1a1a;stroke-linecap:round;stroke-width:2px;}</style>
+  <!-- Shape for "C", clipping all elements nested in layers starting with Sharp-C for C#. -->
+  <clipPath id="clippath">
+   <!-- Clip with shape so nothing extends past "C" outline -->
+   <path id="Sharp-C_Main-Outline" class="cls-6" d="M39.5,113.43c-.05,0-.1-.04-.1-.1V34.89c0-.05.04-.1.1-.1h64.62s34.49-15.12,34.49-15.64-34.49-13.75-34.49-13.75H35.6c-16.7,0-30.24,13.16-30.24,29.39v78.64c0,16.23,13.54,29.39,30.24,29.39h68.52s34.49-14.15,34.49-14.67-34.49-14.72-34.49-14.72H39.5Z"/>
+  </clipPath>
+  <!-- Define gradients for "C" shape. -->
+  <!-- Inner-most gradient applied to majority of "C" shape. -->
+  <linearGradient id="Sharp-C_Inner-Gradient-2" x1="16.01" y1="128.92" x2="125.94" y2="18.98" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#1a1a1a"/>
+   <stop offset=".26" stop-color="#333"/>
+   <stop offset=".39" stop-color="#333" stop-opacity=".9"/>
+   <stop offset=".56" stop-color="#333" stop-opacity=".9"/>
+   <stop offset=".79" stop-color="#333" stop-opacity=".5"/>
+   <stop offset="1" stop-color="#000" stop-opacity=".5"/>
+  </linearGradient>
+  <!-- Cover the "C" shape to mimic a feather effect so th edges are softened. -->
+  <linearGradient id="Sharp-C_Main-Feather-2" x1="13.75" y1="133.75" x2="133.48" y2="14.01" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#1a1a1a" stop-opacity=".9"/>
+   <stop offset=".26" stop-color="#333" stop-opacity=".9"/>
+   <stop offset=".39" stop-color="#333" stop-opacity=".9"/>
+   <stop offset=".56" stop-color="#333" stop-opacity=".9"/>
+   <stop offset=".79" stop-color="#333" stop-opacity=".9"/>
+   <stop offset="1" stop-color="#4d4d4d"/>
+  </linearGradient>
+  <!-- Top left highlight of "C" shape. This is what really tricks the eye into seeing a 3D effect. -->
+  <linearGradient id="Highlight" x1="11.57" y1="18.81" x2="33.35" y2="18.81" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#fff" stop-opacity=".1"/>
+   <stop offset=".49" stop-color="#fff" stop-opacity=".5"/>
+   <stop offset="1" stop-color="#f2f2f2" stop-opacity=".1"/>
+  </linearGradient>
+  <!-- Shape for ">", clipping all elements nested in layers starting with Green-Arrow. -->
+  <clipPath id="clippath-1">
+   <!-- Clip with shape so nothing extends past ">" outline -->
+   <path id="Green-Arrow_Main-Outline-2" class="cls-6" d="M45.05,97.26l18.45-22.84c.15-.18.15-.44,0-.62l-18.45-22.84c-.3-.37.04-.9.5-.78l94.37,23.46c.5.12.5.83,0,.95l-94.37,23.46c-.46.11-.79-.42-.5-.78Z"/>
+  </clipPath>
+  <!-- Define gradients for ">" shape. -->
+  <!-- This is inner-most gradient, taking up most of the space. -->
+  <linearGradient id="Green-Arrow_Linear-gradient" x1="52.09" y1="74.11" x2="129.4" y2="74.11" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#08fb1a"/>
+   <stop offset=".49" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset="1" stop-color="#08fb1a"/>
+  </linearGradient>
+  <!-- This is top-most gradient along the edge. -->
+  <linearGradient id="Green-Arrow_Linear-gradient-2" x1="129.84" y1="98.31" x2="49.98" y2="19.89" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset=".49" stop-color="#9cfda3" stop-opacity=".9"/>
+   <stop offset="1" stop-color="#08fb1a"/>
+  </linearGradient>
+  <!-- Left most gradient on end portion for 3D effect. -->
+  <linearGradient id="Green-Arrow_Left-Edge-Gradient" x1="34.01" y1="66.12" x2="58.1" y2="82.99" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#047b0d" stop-opacity=".9"/>
+   <stop offset=".25" stop-color="#06bb13" stop-opacity=".9"/>
+   <stop offset=".5" stop-color="#08fb1a" stop-opacity=".2"/>
+   <stop offset=".58" stop-color="#08fb1a" stop-opacity=".23"/>
+   <stop offset=".7" stop-color="#08fb1a" stop-opacity=".3"/>
+   <stop offset=".85" stop-color="#08fb1a" stop-opacity=".43"/>
+   <stop offset="1" stop-color="#08fb1a" stop-opacity=".6"/>
+  </linearGradient>
+  <!-- Left edge but closer to the top-most gradient. -->
+  <linearGradient id="Green-Arrow_Linear-gradient-3" x1="34.71" y1="85.95" x2="60.2" y2="64.56" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#9cfda3" stop-opacity=".9"/>
+   <stop offset=".25" stop-color="#08fb1a"/>
+   <stop offset=".6" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset=".73" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset=".81" stop-color="#07f919" stop-opacity=".89"/>
+   <stop offset=".85" stop-color="#07f519" stop-opacity=".87"/>
+   <stop offset=".89" stop-color="#07ee18" stop-opacity=".82"/>
+   <stop offset=".92" stop-color="#07e417" stop-opacity=".76"/>
+   <stop offset=".95" stop-color="#06d816" stop-opacity=".68"/>
+   <stop offset=".98" stop-color="#06c814" stop-opacity=".59"/>
+   <stop offset="1" stop-color="#06bb13" stop-opacity=".5"/>
+  </linearGradient>
+  <!-- Bottom-most gradient of ">" shape at edge of bottom surface. -->
+  <linearGradient id="Green-Arrow_Linear-gradient-4" x1="92.21" y1="84.48" x2="92.93" y2="87.18" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#06bb13" stop-opacity=".9"/>
+   <stop offset=".25" stop-color="#06bb13" stop-opacity=".9"/>
+   <stop offset=".32" stop-color="#05b712" stop-opacity=".9"/>
+   <stop offset=".38" stop-color="#05ac11" stop-opacity=".9"/>
+   <stop offset=".43" stop-color="#049a0f" stop-opacity=".9"/>
+   <stop offset=".48" stop-color="#04810d" stop-opacity=".9"/>
+   <stop offset=".49" stop-color="#047b0d" stop-opacity=".9"/>
+   <stop offset="1" stop-color="#047b0d" stop-opacity=".9"/>
+  </linearGradient>
+  <!-- Upper gradient of the bottom edge of ">" shape. -->
+  <linearGradient id="Green-Arrow_Bottom-Gradient" x1="91.73" y1="83.44" x2="92.22" y2="85.41" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#9cfda3" stop-opacity=".9"/>
+   <stop offset=".1" stop-color="#08fb1a"/>
+   <stop offset=".14" stop-color="#08fb1a" stop-opacity=".94"/>
+   <stop offset=".18" stop-color="#08fb1a" stop-opacity=".91"/>
+   <stop offset=".25" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset=".46" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset=".49" stop-color="#08fb1a" stop-opacity=".9"/>
+   <stop offset="1" stop-color="#06bb13" stop-opacity=".9"/>
+  </linearGradient>
+  <!-- Gradient to apply a feather effect on left edge to soften the edges. -->
+  <linearGradient id="Green-Arrow_Linear-gradient-5" x1="33.58" y1="64.01" x2="58.88" y2="85.23" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#08fb1a" stop-opacity=".5"/>
+   <stop offset=".5" stop-color="#08fb1a"/>
+   <stop offset=".8" stop-color="#9cfda3"/>
+   <stop offset=".95" stop-color="#9cfda3" stop-opacity=".8"/>
+   <stop offset="1" stop-color="#08fb1a" stop-opacity=".8"/>
+  </linearGradient>
+  <!-- Highlight at the top-left portion of the ">" shape. -->
+  <linearGradient id="Highlight_2" x1="46.14" y1="52.93" x2="52.53" y2="52.93" gradientTransform="translate(3.33 -2.89) rotate(3.52)" gradientUnits="userSpaceOnUse">
+   <stop offset="0" stop-color="#fff" stop-opacity=".5"/>
+   <stop offset=".49" stop-color="#fff"/>
+   <stop offset="1" stop-color="#f2f2f2" stop-opacity=".5"/>
+  </linearGradient>
+ </defs>
+ <!-- One group for the "C" and ">" shape. -->
+ <g id="Logo-Icon">
+  <!-- Elements for the "C" shape. -->
+  <g id="Sharp-C">
+   <g class="cls-18">
+    <g id="Sharp-C_Elements">
+     <!-- At the very back of rendered SVG; ensures shape is solid color. -->
+     <path id="Sharp-C_Main-Background" class="cls-11" d="M39.5,113.43c-.05,0-.1-.04-.1-.1V34.89c0-.05.04-.1.1-.1h64.62s34.49-15.12,34.49-15.64-34.49-13.75-34.49-13.75H35.6c-16.7,0-30.24,13.16-30.24,29.39v78.64c0,16.23,13.54,29.39,30.24,29.39h68.52s34.49-14.15,34.49-14.67-34.49-14.72-34.49-14.72H39.5Z"/>
+     <!-- The edges around the "C" are a solid color -->
+     <path id="Sharp-C_Outer-Edge_BackGround" class="cls-11" d="M103.38,9.4c9.2,3.53,19,7.35,25.56,9.97-7.12,3.24-17.84,7.99-25.66,11.42h-63.78c-2.26,0-4.1,1.84-4.1,4.1v78.44c0,2.26,1.84,4.1,4.1,4.1h63.83c7.79,3.21,18.48,7.66,25.62,10.71-7.13,3.04-17.83,7.48-25.62,10.68H35.6c-14.47,0-26.24-11.39-26.24-25.39V34.79c0-14,11.77-25.39,26.24-25.39h67.78M104.12,5.4H35.6c-16.7,0-30.24,13.16-30.24,29.39v78.64c0,16.23,13.54,29.39,30.24,29.39h68.52s34.49-14.15,34.49-14.67-34.49-14.72-34.49-14.72H39.5c-.05,0-.1-.04-.1-.1V34.89c0-.05.04-.1.1-.1h64.62s34.49-15.12,34.49-15.64-34.49-13.75-34.49-13.75h0Z"/>
+     <!-- Edge of "C" ensuring solid color is applied when gradients are not 100% opacity. -->
+     <path id="Sharp-C_Inner-Background" class="cls-8" d="M35.6,137.82c-13.92,0-25.24-10.94-25.24-24.39V34.79c0-13.45,11.32-24.39,25.24-24.39h67.59c8.16,3.13,16.8,6.49,23.2,9.03-6.39,2.89-15.09,6.75-23.32,10.36h-63.57c-2.81,0-5.1,2.29-5.1,5.1v78.44c0,2.81,2.29,5.1,5.1,5.1h63.63c8.2,3.38,16.87,7,23.26,9.71-6.39,2.71-15.06,6.31-23.26,9.68H35.6Z"/>
+     <!-- Overlap outer edge so it blends with the gradients. -->
+     <path id="Sharp-C_Outer-Edge-Feather" class="cls-7" d="M103.43,139.32H35.6c-14.75,0-26.74-11.61-26.74-25.89V34.79c0-14.28,12-25.89,26.74-25.89h67.87l.26.1c8.58,3.29,17.04,6.59,23.21,9.04l3.29,1.3-3.22,1.46c-6.17,2.79-14.67,6.57-23.33,10.37l-.29.13h-63.89c-1.98,0-3.6,1.61-3.6,3.6v78.44c0,1.98,1.61,3.6,3.6,3.6h63.93l.27.11c8.68,3.58,17.17,7.12,23.28,9.72l3.25,1.38-3.25,1.38c-6.13,2.6-14.61,6.12-23.27,9.68l-.27.11ZM35.6,11.9c-13.09,0-23.74,10.27-23.74,22.89v78.63c0,12.62,10.65,22.89,23.74,22.89h67.24c7.11-2.92,14.08-5.81,19.7-8.18-5.62-2.37-12.59-5.27-19.71-8.21h-63.33c-3.64,0-6.6-2.96-6.6-6.6V34.89c0-3.64,2.96-6.6,6.6-6.6h63.26c7.12-3.13,14.12-6.23,19.78-8.77-5.64-2.22-12.58-4.92-19.62-7.62H35.6Z"/>
+     <!-- Inner-most portion of "C" shape, taking up majority of the element. -->
+     <path id="Sharp-C_Inner-Gradient" class="cls-1 cls-11" d="M35.6,137.82c-13.92,0-25.24-10.94-25.24-24.39V34.79c0-13.45,11.32-24.39,25.24-24.39h67.59c8.16,3.13,16.8,6.49,23.2,9.03-6.39,2.89-15.09,6.75-23.32,10.36h-63.57c-2.81,0-5.1,2.29-5.1,5.1v78.44c0,2.81,2.29,5.1,5.1,5.1h63.63c8.2,3.38,16.87,7,23.26,9.71-6.39,2.71-15.06,6.31-23.26,9.68H35.6Z"/>
+     <!-- Transparent element to soften all the edges of the "C" shape. -->
+     <path id="Sharp-C_Main-Feather" class="cls-4 cls-11" d="M39.5,113.43c-.05,0-.1-.04-.1-.1V34.89c0-.05.04-.1.1-.1h64.62s34.49-15.12,34.49-15.64-34.49-13.75-34.49-13.75H35.6c-16.7,0-30.24,13.16-30.24,29.39v78.64c0,16.23,13.54,29.39,30.24,29.39h68.52s34.49-14.15,34.49-14.67-34.49-14.72-34.49-14.72H39.5Z"/>
+     <!-- Top-left hightlight, selling 3D effect. -->
+     <path id="Highlight-2" class="cls-15" d="M33.35,10.47c-.94.12-1.89.32-2.84.57-6.65,1.74-12.36,5.98-16.31,11.6-1.06,1.51-2.01,3.07-2.61,4.49-.32-.96,4.02-16.75,21.76-16.66Z"/>
+    </g>
+   </g>
+  </g>
+  <!-- Clip for ">" shape elements. -->
+  <g id="Green-Arrow_Main-Outline">
+   <g class="cls-13">
+    <!-- Group for ">" shape elements. -->
+    <g id="Green-Arrow_Elements">
+     <!-- Solid background for ">" ensuring solid color. -->
+     <path id="Green-Arrow_Main-Background" class="cls-10" d="M45.05,97.26l18.45-22.84c.15-.18.15-.44,0-.62l-18.45-22.84c-.3-.37.04-.9.5-.78l94.37,23.46c.5.12.5.83,0,.95l-94.37,23.46c-.46.11-.79-.42-.5-.78Z"/>
+     <!-- Inner-most element, taking up moafority of ">" shape. -->
+     <path id="Green-Arrow_Inner-Background" class="cls-17" d="M65.84,76.3c1.02-1.27,1.02-3.11,0-4.38l-13.76-17.03,77.31,19.22-77.31,19.22,13.75-17.03Z"/>
+     <!-- Top element of ">" shape with gradient to mimic 3D edge. -->
+     <path id="Green-Arrow_Top-Edge-Gradient" class="cls-2" d="M45.5,50.16l6.59,4.73,77.31,19.22,10.9-.04s-.02-.11-.07-.2c-.08-.15-.22-.2-.26-.22s-94.48-23.49-94.48-23.49Z"/>
+     <!-- Outside element of the left edge for ">" shape with fradient to mimic 3D edge. -->
+     <path id="Green-Arrow_Left-Edge-Gradient-2" class="cls-14" d="M49.17,52.79s-3.56-2.63-3.67-2.63-.35.04-.45.19-.12.4-.06.5,18.35,22.75,18.41,22.82.14.15.17.23.04.08.04.2-.03.18-.06.23-.05.07-.07.1l-.06.07-17.79,22.03s-.52.64-.57.71-.17.32-.09.49.09.15.09.15c0,0,.07-.13.09-.17s.28-.38.32-.43,18.74-23.09,18.78-23.14c.02-.02.08-.1.16-.2.05-.06.1-.12.14-.18.05-.09.09-.18.1-.26.01-.06,0-.13,0-.19,0-.23-.07-.44-.12-.57-.02-.03-.04-.06-.05-.09-.07-.12-.12-.17-.16-.22-.04-.06-13.19-17.08-13.3-17.22s-.68-.79-.83-.95-1.27-1.25-1.32-1.36c-.08-.11-.15-.23-.15-.23l-.17-.32s.3.22.33.24.26.19.26.19Z"/>
+     <!-- Upper portion of the ">" shape's left edge with gradient. -->
+     <path id="Green-Arrow_Left-Gradient" class="cls-12" d="M45.01,98.23l7.08-4.9,13.75-17.03s.7-.72.76-1.99c.06-1.27-.36-1.77-.4-1.85s-.23-.38-.33-.5-13.78-17.06-13.78-17.06l-3.15-2.26-.36-.27s.19.36.26.48c.2.32,1.71,1.72,1.96,2.06s13.43,17.36,13.65,17.68c.04.04.08.12.12.21.03.08.06.16.08.26.05.25.06.55-.07.73-.22.32-19.25,23.72-19.25,23.72,0,0-.42.55-.31.74Z"/>
+     <!-- Botom-most element of ">" shape at bottom of the edge.-->
+     <path id="Green-Arrow_Bottom-Edge-Gradient" class="cls-9" d="M45.01,98.23l2.41-1.67c.14-.1,1.67-.54,1.95-.6s86.07-21.57,86.32-21.62,1.36-.24,1.36-.24l3.27-.04s0,.23-.12.36c-.01.01-.07.1-.18.13-.87.29-4.54,1.14-4.54,1.14,0,0-89.44,22.61-89.57,22.64s-.59.1-.68.07-.2-.18-.2-.18Z"/>
+     <!-- Still bottom edge of ">" shape, but the upper portion of the bottom surface. -->
+     <path id="Green-Arrow_Bottom-Gradient-2" class="cls-16" d="M52.09,93.33l-4.72,3.27s.08-.06.35-.15.71-.22.76-.24.55-.16.73-.21,1.35-.33,1.35-.33c0,0,84.61-21.2,84.77-21.23s.77-.16.89-.18.69-.14.81-.14v-.03s-7.64.03-7.64.03l-77.31,19.22Z"/>
+     <!-- Covers the entire left edge with low opacity to soften the outlines so they blend better. -->
+     <path id="Green-Arrow_Left-Feather" class="cls-3" d="M66.6,74.31c-.06,1.27-.77,1.99-.77,1.99l-13.75,17.03-7.08,4.9c-.04-.07,0-.21.06-.34-.01,0-.03-.01-.09-.15-.08-.17,0-.37.09-.49.05-.08.57-.71.57-.71l17.79-22.03s.04-.04.06-.07c.02-.03.05-.06.07-.1.03-.05.06-.11.06-.23s0-.11-.04-.2c-.03-.08-.11-.16-.17-.23-.06-.08-18.35-22.72-18.41-22.82-.07-.11-.05-.36.05-.51.11-.14.35-.19.46-.19.09,0,2.64,1.88,3.43,2.47l.05.03s.02.01.03.03l.06.03h0s.04.04.05.05c.01,0,.02.01.03.01,0,.01.01.01.01.01l2.92,2.1s13.69,16.95,13.78,17.06c.1.12.29.42.33.51.05.08.47.58.41,1.85Z"/>
+     <!-- Top-left hightlight for the ">" shape. -->
+     <path id="Highlight-3" class="cls-5" d="M52.03,55.25c-.06,0-.11-.02-.16-.06l-5.55-4.34c-.14-.1-.03-.23.1-.14l5.88,3.84c.14.1.16.37,0,.58-.07.08-.17.13-.27.12Z"/>
+    </g>
+   </g>
+  </g>
+ </g>
+</svg>
diff --git a/top.html b/top.html
index 8d31a56d..08543164 100644
--- a/top.html
+++ b/top.html
@@ -1,4 +1,7 @@
 <div id="top">
+  <div class="logo">
+   <a href="/index.html"><img src="/logo.svg"></a>
+  </div>
   <div class="cartouche">
    <h1 id="big-title">Cygwin</h1>
    <p class="catchphrase">Get that <a href="https://www.linuxfoundation.org/">Linux</a> feeling - on Windows</p>
-- 
2.49.0.windows.1

