Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by sourceware.org (Postfix) with ESMTPS id 017CE4BA2E04
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 017CE4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 017CE4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290115; cv=none;
	b=acMEYqXtv6me4yobqWmTYCDuod+dgN6FGIvJHJ6tSB9kI/yd3LdEBB3N2iOPxNQFWGw0ab06RPWp58lw5CunFFQUB7ZmZ7b2JawgY93CObFxqlZuwEs31wgmd1GlvaavQ2IG4eZ+8B2sbPRdfRF23l8muXvHwkQ/lg5fsrmUykc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290115; c=relaxed/simple;
	bh=TYEpyFd2ZVn8ytGm9gqQGkciRERfvMG26IIZ3lu9C7w=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=hBKnOXr3ogebGKbAxEvTS2AUJ0YlCCyHzjplOUIYWTU5m21dS9HzNuVh3BoS4smG6EdhtnDgUMkaHXEwFfm3nwzw7fJPovrGI36yGPQJyksYLD3Py95EQJaD4JfJum38u/pCvnzHOOsuxS4m33JpPTZc6p3Oy8YVeqblecXJT5Q=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZdHjFV5
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 017CE4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BZdHjFV5
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-7bdc947aaa3so28278947b3.0
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290114; x=1778894914; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWj5ursltytuP3V2z8QD30tjKXeAKe24G88sbyAg5Pg=;
        b=BZdHjFV5ex6gPXELf4nnAZcNw0jsmUj1fPibg6JUWDnhYfk4E+1ThROSuPNavSfSfj
         HEdO+20jlwNcwTjHKv+C943OjXThb2ENitWmgYT01HQVDqKfVUxhCKoLsgoBRvNbh/Zj
         v1HB7wvTp53CKhQ+sx8mNK0LI1C0WqYKpiFAyUAG4n9WGySGGfDSmWNtNBYO94oxf9ML
         EKND1MTDdJp+KpSMntbItN93d25CvVg8v3nyp7YQbl00wYS4Bz9pJMu6pkhVAWqymTWi
         9LOiJKaTqFB8QRFh6SgfdOM8L/3Y5Vs6FHgF1IYCwKS4KwM24D7YoeN6WVzzhTuajLEf
         eDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290114; x=1778894914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yWj5ursltytuP3V2z8QD30tjKXeAKe24G88sbyAg5Pg=;
        b=SZgpw5uZQH80uA3c5pfg14D5+hO7ypYrmdEDQT2t0NIgR9fnn07T2rB9SRG1t1mkpo
         DL9FHbqqmeTaG31IQ0pfW0v+eSuIgUIikZvvW1rFLozgmFZJj+UqX8hyszxrGtu3qGNi
         dfEm3Pj0VtFisYZYwBBLbUWA2GiarZGrxOReAh21+9a+Kw8M2mztY7Y0Dio3a/lqDp5B
         dqP6f4tLIxHkjn9gPmoagSfym8tv78ADXwoVBVT2+/L7QsPPVH/Mg4XTk/nJGZz9nBAS
         TU+d+NeMg4uLAJQqL57jkcGHOp9wHphyMkm42p0qUo/WJ0mHaTrQlP4es29uMvvDVgh9
         06Gg==
X-Gm-Message-State: AOJu0Yz+tQttFZCtL3S1FJwCH0h4xb7utSz7MEudKxA385r2qtjHxMys
	kl8kWq8337lEW68Bkqy2L4GIp0Ia1+rpRkHWou/4NY5U06+C4loyj+BprlprNA==
X-Gm-Gg: Acq92OFIPJBA0g+tmA3uTpYN7vokwXYh9CZYLA0YN/gsIfrkwriqYZ0uLrnH23EUKwr
	9/tr8S204bblvHCiMxh3fubev6x8RlQxPtlW5YMYAo/hdMtv9HzsfLXyA22X2zCv1QG0aCZErgV
	Z6rkFBYED6AhyPWrSGN6I86iiPBgg70cU7AzWHCkJPPX9cfMRPRBzb0Tv3mor2xn37dU+gIjTFL
	OSthzkg6z2kQK4A+uRhKZXzwOTpagsXtH2ZsLrAMQga0cKcajwGNF5R5Rum1n2d+DJqbF+8hU+3
	Zg0O3SdhppDPRtTkj0zFCw+hvqhodrPnMOAeqFyu5bLvRjkEwtZDz33FRxVpFa6C/QpVdQdhHfC
	Sz93ld7mWeiBz3ofcU/0Usx/K8xpFBpQrgmjk/0IlXngfiE0nFW3SM9tpS19SITWJDxZMcfNYyK
	lgOUktj01PrxLSqem4tVpigasbmGH8mQFHNCHSkzA9nIuvpvgptmXf5Ekx21cZdH51PHjOTqub2
	JFeFSgIpGMyLfktmtOocmjbXxU=
X-Received: by 2002:a05:690c:c511:b0:7bd:a4dc:c25a with SMTP id 00721157ae682-7bdf5f2b7fcmr161286597b3.49.1778290113644;
        Fri, 08 May 2026 18:28:33 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:33 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 6/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:48 -0400
Message-ID: <20260509012815.1157-7-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
 style.css                                     | 248 ++++++++++++++++++
 who.html                                      |   3 +-
 44 files changed, 299 insertions(+), 80 deletions(-)
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
index b442f63a..af9456bd 100755
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
index cd05a8d1..80406b58 100755
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
index ec7a4815..0a35c1db 100755
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
index cfdadf9a..640c6e35 100755
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
index 8e656f10..318c8155 100755
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
index 9aa815d0..5765716a 100755
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
index 17900ed3..ce8a5402 100755
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
index 23efb5e5..c0014335 100755
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
index d5123ce3..cb04833f 100755
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
index 16ea5fe2..bca3c840 100755
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
index 0282cb77..11a1616a 100755
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
index 23d2cd66..1c7180a0 100644
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
index 12c8bdc0..fc01bd49 100755
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
index b7429c79..654d4551 100644
--- a/style.css
+++ b/style.css
@@ -627,3 +627,251 @@ table.grid td.failed
   margin-left:auto;
   margin-right:auto;
 }
+
+/* PATCH */
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
+  background-color: #80a0a0;
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
+  background-color: white;
+  top: 0.85em;
+  right: 16px;
+  width: 2.5em;
+  height: 2.5em;
+  padding: 0.5em;
+  box-sizing: border-box;
+  border: 1px solid #80a0a0;
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
+  background-color: #80a0a0;
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
+  outline: 2px solid white;
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
+/* PATCH */
+/* Updated: 2026-05-05 - global responsive rules for tables, media, layout */
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
+/* Long URLs / unbroken strings should wrap rather than overflow */
+p, li, dd, dt, td, th, figcaption, blockquote
+{
+  overflow-wrap: anywhere;
+  word-break: break-word;
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
+/* Cells: allow word breaking so long URLs in cells don't force the table wide */
+table td, table th
+{
+  overflow-wrap: anywhere;
+  word-break: break-word;
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

