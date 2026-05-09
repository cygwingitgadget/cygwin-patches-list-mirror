Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by sourceware.org (Postfix) with ESMTPS id 66A314BA543C
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66A314BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66A314BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290116; cv=none;
	b=IPek0xZF4T03sD8d0zmaSD4zTTIBUPg/vDeM0zqsG4xzXBnFBbH8gNfThXqqFEcAY5l8FCYsde5HO0BfDA7Xge79BvfFbCc+ME+jLgGrugBTNO1EDHhNF8X8rkwYK1xi3WuodM30LuQKqfdZD5lV8ZwnkrIwpuBVXCfXV/202uE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290116; c=relaxed/simple;
	bh=AghU0GZ31XlbtbgZ8LfHgjNke1d/UFp5CGhzG8JMJ5Y=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=KW8ElLt7yRrrdTuJaJtEUuK27xGrRWlUFGfMWp1Mf4eoQWDq/Ol+fjw2lbKOAvU1veIS0gQDfobmRmMc6voAAuKLH5clYd0tM6aOwr9eXtZgWiyLyaEpwNfxZpOuDJ7ki3nhOHUC27AvDnKkA//Gk0hIWoRZ1tE+Hm2PEeagJr4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EGL3p4R+
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66A314BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EGL3p4R+
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-7bd6f65c781so24601887b3.1
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290115; x=1778894915; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVHolz4VqTjQ6Yom+kZ86kkVbqkRn69Tz9QyRRF66JY=;
        b=EGL3p4R+gNnmIX3d0pFi6aaYVDgYyv7m8LM/lwQ0dzb8TJKomEWrlXWILJDctW+jUR
         /IYUJIv16NJDhSrlUhWxaD+vdWu8xxRKTuSt4M3wWHYwH64mayVCiuun9JhAGl19Sp0f
         jDifvwZ9xV01n/hyai7ddIulxtn+AZ3MXlA+K9kADZwCOsoqdAl+NzT+9ECjJJxXR2tW
         B6F+nGUDyIAsTElh7PHYJySu0Cwq6mdslIv685qFwCm1telvl4jwr/ss/fe96Id9F7yn
         xJ6GlUr8cMbCWD16tO06Fv86syo6+KlAxeDEsTvWAGoUw6P7Je+NH+8DQqcdLgwv/IcA
         mLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290115; x=1778894915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVHolz4VqTjQ6Yom+kZ86kkVbqkRn69Tz9QyRRF66JY=;
        b=bUlDT2WQ5Jah5CREYMKpGmvbbmQia4NFI8IDMdX4GH6RyW5waH8YDOjM24W20s8OC8
         P9RZc8tGUvQfFQZbUvJWCMheaV1IT3/N+tuv/IZhEiEfLwT72Akyb6rV8hl6JYZ/kJqY
         1sXPMj9db0jRtUVozc6pJIGkUm8ihbGeJ4mbrNTkqQ9btap7yAdLMk3e57SK+TjcGJG6
         /ss9dcH70lXTvjdotLFGcYSRPXqbCQmLbpltgogqIMXt1+4YZkuqdQdGSnYiSf2N1foq
         8eLPLVN/BMXV6SshIs2LbW1zlauclqRl1uOC68Alj/kZpTn/hcvS2OxBR4DfwQGovT8t
         CTPQ==
X-Gm-Message-State: AOJu0Ywzi4RrKY82g2bvv8glZx+tCnM4c7vp7jEAMvOTCNJAfCEvvSR9
	ZIf8td60EfKXFwmgYEs1iwx/tOGsJvOi6zCNBgQ7VwUOIoxL3A2ZnzkOuU6zUQ==
X-Gm-Gg: Acq92OFvI15SSY3OE+7m+BU8a+2cFdoZHE8XzSOA8TLidfOlQMzgXRbCEn4rqjQOBpu
	KscJyR4dk4LiDPHwQ9n+QX0qNxYnv8H+/Ip17ltpr6GhvVyc2AkWBXQGQ6oAsR6wSNR3PSPRIx+
	VVKgBrzv8i8F5txo1IVPB64mdaO8+G05jMd93iM6/sMKplELpFUo2CkQiiRiv5hwwvsgnykE2jH
	BGPh/Dih18dMnHg8SjYYT+U+h2GEu29ZY+2eZXDyE+NpQITPIKZwC3rznZ7bj7dL6TppZNsTfJe
	yHOo0kgnPf6Kzk/gwbe+PqVP/EPbdSTchSKpDKfwHeY1OjUzB+QiXjq1uedY+KKyp81Wc+dItr0
	RXuYmBb+ScfcO41IorRSNOIA3lPJWkxAlhlrWhizvc02q0P04DbvciLYeR2Q6MAmtflNDNOk/mX
	JKU26NBcS/GC9R3LfvRgT47PRNo2/F7wlPtWnFIPDYp78IMCwM6q0KxGFOKv4VEsSekOMENBxHd
	QT/Ax3dsNIeJyMFqeAwmqyIW9U=
X-Received: by 2002:a05:690c:e3cf:b0:7bd:5c77:1aa5 with SMTP id 00721157ae682-7bf04b1c83dmr81683557b3.3.1778290115085;
        Fri, 08 May 2026 18:28:35 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:33 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 7/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:49 -0400
Message-ID: <20260509012815.1157-8-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,PROLO_LEO1,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

style.css: css variables for colors to keep DRY

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 114 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 48 deletions(-)

diff --git a/style.css b/style.css
index 654d4551..1c0908f2 100644
--- a/style.css
+++ b/style.css
@@ -1,3 +1,21 @@
+/* CSS variables --------------------------------------------------------- */
+
+:root
+{
+  --black: black;
+  --white: white;
+  --big-title: #990033;
+  --heading: #99003f;
+  --nav-background: #80a0a0;
+  --nav-hover: #608080;
+  --cartouche: #e8e8e8;
+  --table: #f2f2f2;
+  --table-hover: #fdd9b5;
+  --code: #80a0a020;
+  --green: green;
+  --red: red;
+}
+
 /* Better reading for accessibliity */
 *
 {
@@ -13,7 +31,7 @@
 
 body
 {
-  color: black;
+  color: var(--black);
 }
 
 a:link
@@ -35,8 +53,8 @@ a:visited
   position: fixed;
   left: 0.5em;
   max-width: 12em;
-  background-color: #80a0a0;
-  color: white;
+  background-color: var(--nav-background);
+  color: var(--white);
   text-align: left;
 }
 
@@ -54,7 +72,7 @@ a:visited
 #navbar li:hover:not(.nohover)
 {
   overflow: hidden;
-  background-color: #608080;
+  background-color: var(--nav-hover);
 }
 
 #navbar ul
@@ -76,7 +94,7 @@ a:visited
   overflow: hidden;
   font-size: small;
   font-weight: 500;
-  color: white;
+  color: var(--white);
   text-decoration: none;
 }
 
@@ -134,7 +152,7 @@ div#main
 #rightwhat
 {
   margin-left: 50%;
-  border-left: 2px solid #e8e8e8;
+  border-left: 2px solid var(--cartouche);
   padding: 0.1px; /* rounds down to 0, but prevents margin collapse */
   padding-left: 1.5em;
 }
@@ -150,7 +168,7 @@ div#main
 #endwrap
 {
   clear: both;
-  border-top: 2px solid #e8e8e8;
+  border-top: 2px solid var(--cartouche);
 }
 
 /* main ------------------------------------------------------------------ */
@@ -167,26 +185,26 @@ div#main
 {
   font-size: 2em;
   font-weight: bold;
-  color: #99003f;
+  color: var(--heading);
 }
 
 #main h2
 {
   font-size: 1.3em;
-  color: #99003f;
+  color: var(--heading);
 }
 
 #main h3
 {
   font-size: 1.1em;
-  color: #99003f;
+  color: var(--heading);
   margin-bottom: 0ex;
 }
 
 #main h4
 {
   font-size: 1em;
-  color: #99003f;
+  color: var(--heading);
 }
 
 #main .catchphrase
@@ -224,7 +242,7 @@ div#main
 #big-title
 {
   font-size: 5em;
-  color: #990033;
+  color: var(--big-title);
   margin-top: 0em;
   margin-bottom: 0em;
   margin-left: 6px;
@@ -244,7 +262,7 @@ div#main
 {
   position: relative;
   font-size: 0.7em;
-  border-top: 2px solid #e8e8e8;
+  border-top: 2px solid var(--cartouche);
   text-align: center;
 }
 
@@ -252,7 +270,7 @@ div#main
 
 .cartouche
 {
-  background: #e8e8e8;
+  background: var(--cartouche);
   border-radius: 8px;
   padding: 4px;
 }
@@ -264,7 +282,7 @@ table#mirroradmin
   width:90%;
   margin-left:5%;
   margin-right:5%;
-  border:2px solid black;
+  border:2px solid var(--black);
 }
 
 table.deben
@@ -272,7 +290,7 @@ table.deben
   width:85%;
   margin-left: 7.5%;
   margin-right: 7.5%;
-  border:1px solid black;
+  border:1px solid var(--black);
   border-collapse: collapse;
 }
 
@@ -285,18 +303,18 @@ table.deben th
 
 table.deben th
 {
-  color: #99003f;
-  border-color: black;
+  color: var(--heading);
+  border-color: var(--black);
 }
 
 table.deben tr:nth-child(odd)
 {
-  background-color: #f2f2f2;
+  background-color: var(--table);
 }
 
 table.deben tr:hover
 {
-  background-color: #fdd9b5;
+  background-color: var(--table-hover);
 }
 
 div#main .indent
@@ -365,12 +383,12 @@ ul.compact li
 
 .green
 {
-  color: green;
+  color: var(--green);
 }
 
 .red
 {
-  color: red;
+  color: var(--red);
 }
 
 .amber
@@ -382,7 +400,7 @@ ul.compact li
 
 code
 {
-  background-color: #80a0a020; /* same color as menu with 20% opacity */
+  background-color: var(--code); /* same color as menu with 20% opacity */
   border-radius: 2px;
   padding: 0px 3px;
 }
@@ -396,7 +414,7 @@ pre.example, pre.screen
 
 pre.example, pre.screen
 {
-  background-color: #80a0a020; /* same color as menu with 20% opacity */
+  background-color: var(--code); /* same color as menu with 20% opacity */
 }
 
 /* link in code */
@@ -409,7 +427,7 @@ a > code
 /* code elements in dark table background */
 table tr:nth-of-type(odd) td p code
 {
-  background-color: white;
+  background-color: var(--white);
 }
 
 /* code-block style ------------------------------------------------------ */
@@ -417,7 +435,7 @@ table tr:nth-of-type(odd) td p code
 pre
 {
   width: 100%;
-  background-color: #80a0a020; /* same color as menu with 20% opacity */
+  background-color: var(--code); /* same color as menu with 20% opacity */
   border-radius: 4px;
   padding: 10px;
 }
@@ -449,7 +467,7 @@ table.pkglist
 
 .pkglist tr:hover
 {
-  background-color: #e8e8e8;
+  background-color: var(--cartouche);
 }
 
 .pkglist a
@@ -465,20 +483,20 @@ table.pkglist
 
 .detail
 {
-  color: #99003f;
+  color: var(--heading);
 }
 
 table.pkgtable
 {
   border-collapse: collapse;
-  border:1px solid black;
+  border:1px solid var(--black);
 }
 
 table.pkgtable th
 {
-  background-color: #80a0a0;
-  color: white;
-  border-color: black;
+  background-color: var(--nav-background);
+  color: var(--white);
+  border-color: var(--black);
   border-width: 1px;
   border-style: solid;
 }
@@ -491,12 +509,12 @@ table.pkgtable td
 
 table.pkgtable tr:nth-child(even)
 {
-  background-color: #f2f2f2;
+  background-color: var(--table);
 }
 
 table.pkgtable tr:hover
 {
-  background-color: #fdd9b5;
+  background-color: var(--table-hover);
 }
 
 table.pkgdetails p
@@ -523,7 +541,7 @@ table.pkgdetails tr td:first-child
   -webkit-column-width: 15em;
   column-width: 15em;
   column-rule-style: double;
-  column-rule-color: #99003f;
+  column-rule-color: var(--heading);
   width: 90%;
   margin: auto;
 }
@@ -575,23 +593,23 @@ table.grid
   width: 95%;
   margin-left:auto;
   margin-right:auto;
-  border: 1px solid black;
+  border: 1px solid var(--black);
   border-collapse: collapse;
 }
 
 table.grid th
 {
   text-align: left;
-  border: 1px solid black;
+  border: 1px solid var(--black);
   border-collapse: collapse;
-  background-color: black;
-  color: white;
+  background-color: var(--black);
+  color: var(--white);
   padding: 0.3em;
 }
 
 table.grid tr:nth-child(even)
 {
-  background-color: #f2f2f2;
+  background-color: var(--table);
 }
 
 table.grid tr.highlight
@@ -601,14 +619,14 @@ table.grid tr.highlight
 
 table.grid td
 {
-  border: 1px solid black;
+  border: 1px solid var(--black);
   border-collapse: collapse;
   padding: 0.3em;
 }
 
 table.grid tr:hover
 {
-  background-color: #fdd9b5;
+  background-color: var(--table-hover);
 }
 
 table.grid td.succeeded, table.grid td.deployed
@@ -647,7 +665,7 @@ div#hamburger-background
   position: fixed;
   z-index: 1001; /* ensure it stays over navbar and can close */
   right: 11px;
-  background-color: #80a0a0;
+  background-color: var(--nav-background);
   border-radius: 8px;
   width: 50px;
   height: 50px;
@@ -658,14 +676,14 @@ div#hamburger-background
 {
   display: none; /* shown via media query below */
   position: fixed;
-  background-color: white;
+  background-color: var(--white);
   top: 0.85em;
   right: 16px;
   width: 2.5em;
   height: 2.5em;
   padding: 0.5em;
   box-sizing: border-box;
-  border: 1px solid #80a0a0;
+  border: 1px solid var(--nav-background);
   border-radius: 4px;
   cursor: pointer;
   user-select: none;
@@ -677,20 +695,20 @@ div#hamburger-background
   width: 100%;
   height: 3px;
   margin: 3px 0;
-  background-color: #80a0a0;
+  background-color: var(--nav-background);
   border-radius: 2px;
   transition: transform 0.25s ease, opacity 0.2s ease;
 }
 
 .hamburger-icon:hover
 {
-  background-color: #608080;
+  background-color: var(--nav-hover);
 }
 
 /* keyboard focus ring for accessibility */
 .navbar-toggle:focus-visible + .hamburger-icon
 {
-  outline: 2px solid white;
+  outline: 2px solid var(--white);
   outline-offset: 2px;
 }
 
-- 
2.49.0.windows.1

