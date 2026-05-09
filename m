Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com [IPv6:2607:f8b0:4864:20::b132])
	by sourceware.org (Postfix) with ESMTPS id 3150C4BA543C
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 02:24:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3150C4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3150C4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b132
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778293461; cv=none;
	b=xeCi1nGtrzfxHqAfN8ArHfz5uNWL+iVBD5ayEjgoZ0joqNM0kb8Lh15WJQh9yTURVkgCi3bq9UnG2Uq1NYIotJO552kjUdinIoJlEwgH2EJRJ1mtAO2KINCnpHAwMi/4UvIjcarP8Dr+g0AaPeFGjVQOf9xU2wj7hcXw820BQHc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778293461; c=relaxed/simple;
	bh=DUdwDQRw/WnLdPGd6L4tIgJaf8jYXMewBzsxXriDcac=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=V4lB20PmuHxRX+68etZRBSHKnPu93aHvATNcqQjwCW6Iu0UVANxRdsBm+FVGuu9WOfID7YNLzUU5bVxduYwd0OavZATEhjE8PMnJD0tOLM0Ifh9Htq9hbw46DAatyFlDQizhAYRlO0lb1RkE4EObukAVz2F5UXMDIgJ5fgFMKB8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZOSqTFc+
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3150C4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZOSqTFc+
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-651c7ddf514so2933831d50.1
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 19:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293460; x=1778898260; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4zYvAtwTsy9YbJwx8Bqz10WnLby+4SvH2Ulop4D4LA=;
        b=ZOSqTFc+Q7DDH4Q71a4ZFS3Gwx+HA6kcsWzP93GRGEO2s1FOLooxop2orz65HeoNCL
         0j7u9g1qFRu0ZN0hNWJ7AKHU+IbJDhPSDD2DJV+c2gOzr5S6/mnrLOtpGaEPOqbZ2h6b
         VjqDKpIapuvgxRQQqvQwH48CLAs+rTki5C355YIs2KWe6cCuMDv/J3hjnM4zHx21clx6
         zv3C5CNBvS4tbMSOEuaT7kEWW+aWhngNOnq5TFn9R5A7/g/t7LxQB0hC38osDALTYzp6
         Aw8thfg3iuB5j7uNGHr2Kk+LFGeRgPaDfjsEYiQV1as7m+BzRFubSooRtONk0GuAhOo/
         zDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293460; x=1778898260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4zYvAtwTsy9YbJwx8Bqz10WnLby+4SvH2Ulop4D4LA=;
        b=bAXOAb3eLYmebgE3SXpZP3ee57ZxQzS88UbyHs4T1cOXbTQufE7b75aaATRp+kt7Nd
         7k9Z3bhiWdAoqOUxtOnK9aUakKH58zpLYCe4NpbieNQIxYrYYjjPsqP9UdW3lQ5MD7mg
         jUQJT1JPQzxvB5OM+hIJiwFhGug6N8Dq2f6pCbixf/0sqlnlVXSA/jH1JofEyh0OlvwR
         wqMqjkZ+g6+vEBqOAgYBZzxg8l7Sc3f3RlHVTuWcworWocli9AJbI7Zd3msjyqyX9x2D
         u5VomcMTsvEI3ffUjhRwoYiE4B2OdSCRQPAAmLsX2wd6ikQ0LkWAxIjN9QBMfOrVnMol
         XKZg==
X-Gm-Message-State: AOJu0YyztqfH8mL1GtG56eMMlJik2FNSif1FZdNujcvrdbTdkxcFe2sa
	oDlKr4fSULdaMog0i18bfNTLO1MotNJpyIYUcNOaXe/QdwH3KP3JaUdsbnn67A==
X-Gm-Gg: Acq92OGnb0BzNq6Xm8gvtGCktIh/nqsou54yoSnlvv+vtDrjgrLAMkzusyfjB4XKNYW
	vBLiL67vWjy8n2U3Tpse9PlZ+FVRvC4fiab7u8q7HNqrsLb/eEA57/oUkhpw+x2L62CRSnrJ1gw
	58B3Rm/otJO/scmiFASXis4Sfhoyr5Q0inM2pgkvdGWzjr2GHVsIJrqMqOlzKlSc0i+QzOaniwH
	r/jPVJu24/B8W1MKOFgRQ3sFq1+eL7ggQpKP5GEsCrfR9rcmIWIDZBzgKmtT8O/4y6XPg7rbIBc
	BsaXbtAf+IlCfI9CKthddZ1hfFJ6G8OmLNZ37lh8DE2F1Id4o5LApw0xsXcYlmwqy594nl6O3+B
	vWXLOM6qCRgaYoyhbkxIeanIZ160xoBk42NykQPJ7koScJGj3WN4DT0wXPNoqXZgMnFE/KC6N8x
	OpMrlnrsA6h2xuX43vsi5ZLdqrNEH3geVS9jsio12UD+vRQqeOa2cn3te3+FkkOwepRV6f6luW1
	gV0c710AcFuHU5DYaREMPugSnVFqj+2nJXsJg==
X-Received: by 2002:a53:ea8e:0:b0:65c:60e1:3eba with SMTP id 956f58d0204a3-65c79d9dcf4mr11530170d50.28.1778293459625;
        Fri, 08 May 2026 19:24:19 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96c5719dsm1672767d50.21.2026.05.08.19.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:18 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 1/1] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 22:24:06 -0400
Message-ID: <20260509022406.1037-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509022406.1037-1-johnhaugabook@gmail.com>
References: <20260509022406.1037-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,KAM_SHORT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

responsive: add responsive style section, update html to `head.html` template

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 acronyms/index.html                           |   3 +-
 contrib.html                                  |   3 +-
 contrib/dll.html                              |   3 +-
 cygwin-api.html                               |   3 +-
 cygwin-api/index.html                         |   3 +-
 cygwin-ug-net.html                            |   3 +-
 docs.html                                     |   3 +-
 donations.html                                |   3 +-
 faq.html                                      |   3 +-
 git.html                                      |   3 +-
 goldstars/index.html                          |   3 +-
 goldstars/src/index.html.tpl                  |   3 +-
 head.html                                     |   3 +
 index.html                                    |   3 +-
 install.html                                  |   3 +-
 irc.html                                      |   3 +-
 licensing.html                                |   3 +-
 links.html                                    |   3 +-
 lists.html                                    |   3 +-
 mirrors-report.html                           |   3 +-
 mirrors.html                                  |   3 +-
 navbar.html                                   |   7 +
 news.html                                     |   3 +-
 package-server.html                           |   3 +-
 package-upload.html                           |   3 +-
 packages.html                                 |   3 +-
 packages/index.html                           |   3 +-
 packages/package_docs.html                    |   3 +-
 packages/package_list.html                    |   3 +-
 packages/src_package_list.html                |   3 +-
 packaging-contributors-guide.html             |   3 +-
 packaging-hint-files.html                     |   3 +-
 packaging-package-files.html                  |   3 +-
 packaging/build.html                          |   3 +-
 packaging/cygport_tips.html                   |   3 +-
 packaging/key.html                            |   3 +-
 packaging/repos.html                          |   3 +-
 .../trusted-maintainer-policy-manual.html     |   3 +-
 problems.html                                 |   3 +-
 profiling/index.html                          |   1 +
 setup-packaging-historical.html               |   3 +-
 snapshots/index.html                          |   3 +-
 style.css                                     | 249 ++++++++++++++++++
 who.html                                      |   3 +-
 44 files changed, 300 insertions(+), 80 deletions(-)
 create mode 100644 head.html

diff --git a/acronyms/index.html b/acronyms/index.html
index e0fbad71..392755c4 100755
--- a/acronyms/index.html
+++ b/acronyms/index.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="../style.css" />
+    <!--#include virtual="../head.html" -->
     <title>Cygwin Acronyms</title>
   </head>
 
diff --git a/contrib.html b/contrib.html
index 0f441474..cec6b301 100755
--- a/contrib.html
+++ b/contrib.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Contribution</title>
   </head>
 <body>
diff --git a/contrib/dll.html b/contrib/dll.html
index c6eeb6e6..742984fc 100755
--- a/contrib/dll.html
+++ b/contrib/dll.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="/style.css" />
+    <!--#include virtual="/head.html" -->
     <title>Cygwin Contribution</title>
   </head>
 <body>
diff --git a/cygwin-api.html b/cygwin-api.html
index 604973db..d6ef641d 100644
--- a/cygwin-api.html
+++ b/cygwin-api.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin API Reference</title>
   </head>
 
diff --git a/cygwin-api/index.html b/cygwin-api/index.html
index 1d9c5d1c..17008f72 100755
--- a/cygwin-api/index.html
+++ b/cygwin-api/index.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="../style.css" />
+    <!--#include virtual="../head.html" -->
     <title>Cygwin API Reference</title>
   </head>
 
diff --git a/cygwin-ug-net.html b/cygwin-ug-net.html
index 19aba90d..71f4b8b8 100755
--- a/cygwin-ug-net.html
+++ b/cygwin-ug-net.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin User's Guide</title>
   </head>
 
diff --git a/docs.html b/docs.html
index ca50b178..ce9e4eb8 100755
--- a/docs.html
+++ b/docs.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Documentation</title>
   </head>
 
diff --git a/donations.html b/donations.html
index f8a83a58..464fb79d 100755
--- a/donations.html
+++ b/donations.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Donations</title>
     <meta name="robots" content="nofollow"/>
   </head>
diff --git a/faq.html b/faq.html
index b8550a37..d066ffc4 100755
--- a/faq.html
+++ b/faq.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin FAQ</title>
   </head>
 
diff --git a/git.html b/git.html
index e5ad2902..d9ae5105 100755
--- a/git.html
+++ b/git.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin in Git</title>
   </head>
 
diff --git a/goldstars/index.html b/goldstars/index.html
index df32925b..66c58bcc 100755
--- a/goldstars/index.html
+++ b/goldstars/index.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-  <link rel="stylesheet" type="text/css" href="../style.css" />
+  <!--#include virtual="../head.html" -->
   <link rel="stylesheet" type="text/css" href="style.css" />
   <title>Cygwin Gold Stars</title>
 </head>
diff --git a/goldstars/src/index.html.tpl b/goldstars/src/index.html.tpl
index 19542fd0..a71e6d6f 100644
--- a/goldstars/src/index.html.tpl
+++ b/goldstars/src/index.html.tpl
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-  <link rel="stylesheet" type="text/css" href="../style.css" />
+  <!--#include virtual="../head.html" -->
   <link rel="stylesheet" type="text/css" href="style.css" />
   <title>Cygwin Gold Stars</title>
 </head>
diff --git a/head.html b/head.html
new file mode 100644
index 00000000..3332439c
--- /dev/null
+++ b/head.html
@@ -0,0 +1,3 @@
+<meta name="viewport" content="width=device-width, initial-scale=1.0">
+<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
+<link rel="stylesheet" type="text/css" href="/style.css" />
diff --git a/index.html b/index.html
index 27c6fd68..21206ccc 100755
--- a/index.html
+++ b/index.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin</title>
   </head>
 
diff --git a/install.html b/install.html
index 3a4d9a91..55a070de 100755
--- a/install.html
+++ b/install.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Installation</title>
   </head>
 
diff --git a/irc.html b/irc.html
index 82a577a7..7574c44a 100755
--- a/irc.html
+++ b/irc.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Mailing Lists</title>
   </head>
 
diff --git a/licensing.html b/licensing.html
index 9e614a87..4d80d553 100755
--- a/licensing.html
+++ b/licensing.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Licensing Terms</title>
   </head>
 
diff --git a/links.html b/links.html
index 154e684c..a8e9114e 100755
--- a/links.html
+++ b/links.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Related Sites</title>
   </head>
 
diff --git a/lists.html b/lists.html
index 836207e3..f5e5c5e9 100755
--- a/lists.html
+++ b/lists.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Mailing Lists</title>
   </head>
 
diff --git a/mirrors-report.html b/mirrors-report.html
index 1a8f678a..d4a3daa1 100755
--- a/mirrors-report.html
+++ b/mirrors-report.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Mirror Report</title>
     <script src="packages/reports/sorttable.js"></script>
   </head>
diff --git a/mirrors.html b/mirrors.html
index 18fdade1..99ca09e5 100755
--- a/mirrors.html
+++ b/mirrors.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en-US" xml:lang="en-US">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Mirror Sites</title>
   </head>
 
diff --git a/navbar.html b/navbar.html
index cf87aeb3..90b14966 100644
--- a/navbar.html
+++ b/navbar.html
@@ -1,3 +1,10 @@
+<!-- Responsive menu toggler -->
+<input type="checkbox" id="navbar-toggle" class="navbar-toggle" aria-hidden="true">
+<div id="hamburger-background">
+ <label for="navbar-toggle" class="hamburger-icon" role="button" aria-label="Toggle navigation menu" tabindex="0">
+   <span></span><span></span><span></span>
+ </label>
+</div>
 <div class="cartouche" id="navbar">
 <ul>
   <li><a href="/index.html">Cygwin</a></li>
diff --git a/news.html b/news.html
index c4e7da3e..9eb3152a 100755
--- a/news.html
+++ b/news.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Newsgroups</title>
   </head>
 
diff --git a/package-server.html b/package-server.html
index 04f1708b..c37d5b40 100755
--- a/package-server.html
+++ b/package-server.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-  <link rel="stylesheet" type="text/css" href="style.css" />
+  <!--#include virtual="head.html" -->
 <title>Cygwin Package Server</title>
 </head>
 <body>
diff --git a/package-upload.html b/package-upload.html
index 4bb5a54c..c5953ef9 100755
--- a/package-upload.html
+++ b/package-upload.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-<link rel="stylesheet" type="text/css" href="style.css" />
+<!--#include virtual="head.html" -->
 <title>Uploading Packages to cygwin.com</title>
 </head>
 <body>
diff --git a/packages.html b/packages.html
index 95b3857d..ca9e2fe4 100755
--- a/packages.html
+++ b/packages.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Packages</title>
   </head>
 
diff --git a/packages/index.html b/packages/index.html
index ed7bc6bc..de46fe59 100755
--- a/packages/index.html
+++ b/packages/index.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="/style.css" />
+    <!--#include virtual="/head.html" -->
     <title>Cygwin Packages</title>
   </head>
 
diff --git a/packages/package_docs.html b/packages/package_docs.html
index 632bb484..3f36659e 100755
--- a/packages/package_docs.html
+++ b/packages/package_docs.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="../style.css" />
+    <!--#include virtual="/head.html" -->
     <title>Cygwin-Specific Package Documentation</title>
   </head>
 
diff --git a/packages/package_list.html b/packages/package_list.html
index aa73dea7..e0446329 100755
--- a/packages/package_list.html
+++ b/packages/package_list.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="../style.css" />
+    <!--#include virtual="../head.html" -->
     <title>Cygwin Package List</title>
   </head>
 
diff --git a/packages/src_package_list.html b/packages/src_package_list.html
index bc007a45..c3ce73d2 100755
--- a/packages/src_package_list.html
+++ b/packages/src_package_list.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="/style.css" />
+    <!--#include virtual="/head.html" -->
     <title>Cygwin Source Package List</title>
   </head>
 
diff --git a/packaging-contributors-guide.html b/packaging-contributors-guide.html
index 226b321e..c67afcd3 100755
--- a/packaging-contributors-guide.html
+++ b/packaging-contributors-guide.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Package Contributor's Guide</title>
   </head>
 
diff --git a/packaging-hint-files.html b/packaging-hint-files.html
index 291f9ddc..42fbdba0 100755
--- a/packaging-hint-files.html
+++ b/packaging-hint-files.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin package .hint files</title>
   </head>
 
diff --git a/packaging-package-files.html b/packaging-package-files.html
index 6e084da7..08e2f95c 100755
--- a/packaging-package-files.html
+++ b/packaging-package-files.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin package files</title>
   </head>
 
diff --git a/packaging/build.html b/packaging/build.html
index aad1afc9..d6971eb2 100755
--- a/packaging/build.html
+++ b/packaging/build.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-<link rel="stylesheet" type="text/css" href="../style.css" />
+<!--#include virtual="/head.html" -->
 <title>Package build service</title>
 </head>
 <body>
diff --git a/packaging/cygport_tips.html b/packaging/cygport_tips.html
index 4bd5713d..b674b239 100755
--- a/packaging/cygport_tips.html
+++ b/packaging/cygport_tips.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="/style.css" />
+    <!--#include virtual="/head.html" -->
     <title>Tips for writing a .cygport file</title>
   </head>
 
diff --git a/packaging/key.html b/packaging/key.html
index 0cfd006f..5ff45c5a 100755
--- a/packaging/key.html
+++ b/packaging/key.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-<link rel="stylesheet" type="text/css" href="../style.css" />
+<!--#include virtual="/head.html" -->
 <title>Providing an SSH key</title>
 </head>
 <body>
diff --git a/packaging/repos.html b/packaging/repos.html
index 0def9973..a9f27612 100755
--- a/packaging/repos.html
+++ b/packaging/repos.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-<link rel="stylesheet" type="text/css" href="../style.css" />
+<!--#include virtual="/head.html" -->
 <title>git repositories for Cygwin packaging</title>
 </head>
 <body>
diff --git a/packaging/trusted-maintainer-policy-manual.html b/packaging/trusted-maintainer-policy-manual.html
index 81a8ea41..6129c88b 100755
--- a/packaging/trusted-maintainer-policy-manual.html
+++ b/packaging/trusted-maintainer-policy-manual.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="../style.css" />
+    <!--#include virtual="/head.html" -->
     <title>Trusted Maintainer Policy Guidelines</title>
   </head>
 
diff --git a/problems.html b/problems.html
index 11f73bbc..714c3f0a 100755
--- a/problems.html
+++ b/problems.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Reporting Cygwin Problems</title>
   </head>
 
diff --git a/profiling/index.html b/profiling/index.html
index f7c12c5a..095b3c4a 100644
--- a/profiling/index.html
+++ b/profiling/index.html
@@ -1,6 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
+ <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" type="text/css" href="/style.css" />
  <title>Profiling Cygwin</title>
diff --git a/setup-packaging-historical.html b/setup-packaging-historical.html
index 344fdac3..2cbc7c0f 100755
--- a/setup-packaging-historical.html
+++ b/setup-packaging-historical.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Historical Cygwin Packaging</title>
   </head>
 
diff --git a/snapshots/index.html b/snapshots/index.html
index 927640d2..2b34964a 100755
--- a/snapshots/index.html
+++ b/snapshots/index.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="../style.css" />
+    <!--#include virtual="../head.html" -->
     <title>Cygwin Snapshots</title>
   </head>
 
diff --git a/style.css b/style.css
index 0777fd0e..2cfea9cf 100644
--- a/style.css
+++ b/style.css
@@ -612,3 +612,252 @@ table.grid td.failed
   margin-left:auto;
   margin-right:auto;
 }
+
+/* responsive styling ---------------------------------------------------- */
+/* PATCH-reponsive */
+
+/* hamburger toggle (hidden checkbox) ------------------------------------ */
+.navbar-toggle
+{
+  position: absolute;
+  opacity: 0;
+  pointer-events: none;
+  width: 0;
+  height: 0;
+}
+
+/* Background for hamburger menu. */
+div#hamburger-background
+{
+  display: none;
+  position: fixed;
+  z-index: 1001; /* ensure it stays over navbar and can close */
+  right: 11px;
+  background-color: var(--nav-background);
+  border-radius: 8px;
+  width: 50px;
+  height: 50px;
+}
+
+/* hamburger icon (3 stacked bars) - hidden on desktop, shown on small screens */
+.hamburger-icon
+{
+  display: none; /* shown via media query below */
+  position: fixed;
+  background-color: var(--white);
+  top: 0.85em;
+  right: 16px;
+  width: 2.5em;
+  height: 2.5em;
+  padding: 0.5em;
+  box-sizing: border-box;
+  border: 1px solid var(--nav-background);
+  border-radius: 4px;
+  cursor: pointer;
+  user-select: none;
+}
+
+.hamburger-icon span
+{
+  display: block;
+  width: 100%;
+  height: 3px;
+  margin: 3px 0;
+  background-color: var(--nav-background);
+  border-radius: 2px;
+  transition: transform 0.25s ease, opacity 0.2s ease;
+}
+
+.hamburger-icon:hover
+{
+  background-color: #608080;
+}
+
+/* keyboard focus ring for accessibility */
+.navbar-toggle:focus-visible + .hamburger-icon
+{
+  outline: 2px solid var(--white);
+  outline-offset: 2px;
+}
+
+@media (max-width: 800px) /* tablet display */
+{
+  /* Fit content to screen. */
+  #main
+  {
+    left: 0em;         /* overrides current style */
+    margin-right: 0em; /* overrides current style */
+  }
+
+  div#main
+  {
+    margin-left: 0px; /* overrides current style */
+    min-width: 20em;
+    width: 85%;
+  }
+
+  pre
+  {
+    width: fit-content;
+    overflow-x: scroll;
+  }
+
+  /* Show hamburger icon on small screens */
+  .hamburger-icon
+  {
+    display: block;
+  }
+
+  /* Show hamburger background */
+  div#hamburger-background
+  {
+    display: inline-block;
+    padding: 5px;   
+  }
+
+  /* Hide #navbar by default on small screens; reveal when toggled */
+  #navbar
+  {
+    position: fixed;
+    top: 2em;       /* below the hamburger icon */
+    left: 0;
+    right: 0;
+    max-width: none;   /* override desktop max-width */
+    max-height: calc(100vh - 3.25em);
+    overflow-y: auto;
+    z-index: 1000;
+    border-radius: 0;
+    transform: translateY(-110%);
+    transition: transform 0.25s ease;
+    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
+  }
+
+  /* Reveal navbar when checkbox is checked */
+  .navbar-toggle:checked ~ #navbar
+  {
+    transform: translateY(0);
+  }
+
+  /* Animate hamburger bars into an "X" when open */
+  .navbar-toggle:checked ~ .hamburger-icon span:nth-child(1)
+  {
+    transform: translateY(6px) rotate(45deg);
+  }
+
+  .navbar-toggle:checked ~ .hamburger-icon span:nth-child(2)
+  {
+    opacity: 0;
+  }
+
+  .navbar-toggle:checked ~ .hamburger-icon span:nth-child(3)
+  {
+    transform: translateY(-6px) rotate(-45deg);
+  }
+}
+
+@media (max-width: 450px) /* phone display */
+{
+  div#main
+  {
+    width: 100%;
+    padding-right: 10px;
+  }
+}
+
+/* global responsive rules ----------------------------------------------- */
+/* PATCH-responsive */
+/* Global responsive rules for tables, media, and layout. */
+
+/* Apply border-box so widths/paddings don't blow out their container */
+*, *::before, *::after
+{
+  box-sizing: border-box;
+}
+
+/* Prevent the page itself from horizontally scrolling */
+html, body
+{
+  max-width: 100%;
+  overflow-x: hidden;
+}
+
+/* Replaced media: images, video, iframes scale to their container */
+img, video, iframe, embed, object
+{
+  max-width: 100%;
+  height: auto;
+}
+
+/* <pre> blocks: keep formatting but never overflow their container */
+pre
+{
+  max-width: 100%;
+  overflow-x: auto;
+  white-space: pre;
+}
+
+/* Tables ---------------------------------------------------------------- */
+
+/* Cap every table to its container; permit horizontal scroll if needed */
+table
+{
+  max-width: 100%;
+  /* Wrap the table in its own scroll context via display:block at narrow
+     widths (see media query below). On wide screens keep native table layout. */
+}
+
+/* On tablet and below, convert wide tables into a horizontally scrollable
+   block so the rest of the page (and the navbar) cannot be pushed off-screen.
+   This applies to ALL tables, not only the named ones. */
+@media (max-width: 800px)
+{
+  /* The table becomes a scroll container; its inner layout still renders
+     as a table because <thead>/<tbody>/<tr>/<td> keep their default display. */
+  table
+  {
+    display: block;
+    width: 100%;
+    overflow-x: auto;
+    -webkit-overflow-scrolling: touch;
+  }
+
+  /* Restore proper table semantics inside the scroll container so columns
+     still align. Wrapping the rows in an inner table-row-group keeps the
+     layout tabular while the outer block scrolls. */
+  table > caption
+  {
+    display: table-caption;
+  }
+
+  table > thead,
+  table > tbody,
+  table > tfoot
+  {
+    display: table-row-group;
+  }
+
+  table tr
+  {
+    display: table-row;
+  }
+
+  table th,
+  table td
+  {
+    display: table-cell;
+  }
+
+  /* Cells: allow word breaking so long URLs in cells don't force the table wide */
+  table td, table th
+  {
+    overflow-wrap: anywhere;
+    word-break: break-word;
+  }
+
+  /* Long URLs / unbroken strings should wrap rather than overflow */
+  p, li, dd, dt, td, th, figcaption, blockquote
+  {
+    overflow-wrap: anywhere;
+    word-break: break-word;
+  }
+}
diff --git a/who.html b/who.html
index f5c4a989..786863bb 100755
--- a/who.html
+++ b/who.html
@@ -1,8 +1,7 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Community</title>
   </head>
 
-- 
2.49.0.windows.1

