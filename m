Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by sourceware.org (Postfix) with ESMTPS id 52FC94BC0577
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 52FC94BC0577
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 52FC94BC0577
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1132
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576451; cv=none;
	b=W+sbL0m4Kum2sZzJ5au0wrKNg0FZNLF8FyuM9XUwD/FXmoF3ES3D+xOkcuLfi2qEvedoSbbr2WUdx5FEDtGFWDmpCDuhrRxE535CTjRfjrGs9b5q0apVZX7MGlxLVVdlNqJI06OZ+aL+YG1pYbFnN7kN7b83X1Nu6XMk4qfaxpc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576451; c=relaxed/simple;
	bh=cL1q38sjC8xm7g/vcHK5JAWsq60VhK77Fx4bdYKBFU4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=CZlhWnR4mM9Wh7rxmBiWA1jwc/TZo4oYD5FZyZcaRoOS0oCpALMk2He0vqjErUX4s98YzDmQAzADpc2Slhv/C89zRypo0M4Ccj15yB/Du1allF4mVmM1D2tQ1Y8h0NyViIAizE7V7TLjsdki6QqKJIabJuxQS4TCbEcH8DWttXc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 52FC94BC0577
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VOY+3BBO
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-79a7109f568so21332837b3.1
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576450; x=1777181250; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD7gmdayBg0xce5+HaE7HlBRxk7R9LPSnYJCDvSFXcQ=;
        b=VOY+3BBOa4IVFZ/atx3eo7OZdSFxizqET979taN3RjRiwFa56R1wZZhJTu0aEhq+4b
         CzPT7eVXergI1pHXPmaC4k/zO+s3p6RcbUSW3dCTU0GoZxzynycH3W2dvRS/Sht+tVzb
         XK4eu8eOJdeBr9isaSaUxaRfMhrdoByf1CAn2lRgMIyDt3qQkvIz4GurINamav1lKqQ0
         sF5R7P/P3dgjqLQ05HiTbMr6xOyVN7S1lDvTXQg8wdLWLPaW/kPJ/TgwK8SFthBY5Op3
         1t9pQB/eo0WphTKkOmZMnnm1fFHOK2sx3T5S97yoqVkMRkK2c/8LutbuCnWDbTHwZDR8
         aGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576450; x=1777181250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fD7gmdayBg0xce5+HaE7HlBRxk7R9LPSnYJCDvSFXcQ=;
        b=TquWdpmih67zaD+E6nx/VSkAEuChgAasqa0wtmPXj0f6pS+ASc9fQxrKkxfhrXEONi
         eQTSQgC2ymwxaWSewsUwcQs9o7hOeryTAJQIxmSFuVEsdcS5EHBX5PKiVxX20EzMh364
         IC7pOeao2LtCNmVQ28CPF8J0lQTFhna+b/0kCLyB1236PuEiEDt1DcZjcaavQtlkDnM0
         jDn3utQaEqLdufpj3pFHzdVAE71sbIlLSh2Nik+hEHixyvQH/doO17gXjuWsEXCFVRo+
         DFe0jBJUh6Vss+VrRbbKwNObM4H48D/LYEWlmtLYKFfHof3nEGxyFDDhZt8B1h1bwhCR
         kXOg==
X-Gm-Message-State: AOJu0Yxu7baEy551AiV/UK+Fek6+pg5a6DqJdFjkOUBI92ZuTWHmrUqe
	P2uFGLJ47j8k9hj6f39P63kvZ8MIBbS079GlcqkR02Y6Ps/u8Sb7PNrcVVBpOg==
X-Gm-Gg: AeBDievu6KHBYjlO2GdLeBaXr+nH5WTJrZR1rJXGlNMOH2sCJxQqpuzxSNUHx7223c5
	udH2qcGcBiD9HcQ2BVGTuJrUelriRoNYoTnS/NtvDHPI0vzbvJ0QfnngMkdJhw6O8Qe9Dj3WYaC
	99KH6Nf23xbAPNL9T9tZvN+wYKQZy/s4Jlo6MfPRhfvSy8oFgrj3NXIqZ5lxzTPWCLf56qneEVL
	I84Mt2+zlIJavj19EvBR13PTjTBhnIlAkeJ+IdqtyXpSEUpxriAtzZhK9x9IYTAafxbBvuHPez0
	Hu+p4B0w2FG4CK4qdhPlFKPgMJbbK7gUQx0bKM7mzAnM1M+xfkWQ9t9ueGwv6dECgUEwZRzuxmQ
	sgtLqFp+WA3DLOo/U8QUeT78fZENbiJM0bzNpjnvP5quH+c1UgIfQLdc+GCWa30ZutAR1tysJWx
	I6/5hZYHZCK7uV7RnmLHSUjTQ65S8mnt0P6KtYaxROo/Op6xACcb6bqjfkSPAoe1J8t6MusA4KM
	Wdg14SjkW8A2ybBgS1WfZpS5/WQOcEt3RLcKg==
X-Received: by 2002:a05:690c:498f:b0:7a2:842a:db7e with SMTP id 00721157ae682-7b9ecfea444mr93046247b3.35.1776576450006;
        Sat, 18 Apr 2026 22:27:30 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:28 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 10/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:58 -0400
Message-ID: <20260419052701.513-11-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 acronyms/index.html                           |  3 +--
 contrib.html                                  |  3 +--
 contrib/dll.html                              |  3 +--
 cygwin-api.html                               |  3 +--
 cygwin-api/index.html                         |  3 +--
 cygwin-ug-net.html                            |  3 +--
 docs.html                                     |  3 +--
 donations.html                                |  3 +--
 faq.html                                      |  3 +--
 git.html                                      |  3 +--
 goldstars/index.html                          |  3 +--
 goldstars/src/index.html.tpl                  |  3 +--
 head.html                                     |  3 +++
 index.html                                    |  3 +--
 install.html                                  |  3 +--
 irc.html                                      |  3 +--
 licensing.html                                |  3 +--
 links.html                                    |  3 +--
 lists.html                                    |  3 +--
 mirrors-report.html                           |  7 +++----
 mirrors.html                                  |  5 ++---
 news.html                                     |  3 +--
 package-server.html                           |  5 ++---
 package-upload.html                           |  5 ++---
 packages.html                                 |  3 +--
 packages/index.html                           |  3 +--
 packages/package_docs.html                    |  3 +--
 packages/package_list.html                    |  3 +--
 packages/src_package_list.html                |  3 +--
 packaging-contributors-guide.html             |  3 +--
 packaging-hint-files.html                     |  3 +--
 packaging-package-files.html                  |  3 +--
 packaging/build.html                          |  3 +--
 packaging/cygport_tips.html                   |  3 +--
 packaging/key.html                            |  3 +--
 packaging/repos.html                          |  3 +--
 .../trusted-maintainer-policy-manual.html     |  3 +--
 problems.html                                 |  3 +--
 profiling/index.html                          |  1 +
 setup-packaging-historical.html               |  3 +--
 snapshots/index.html                          |  3 +--
 style.css                                     | 19 +++++++++++++++++++
 who.html                                      |  3 +--
 43 files changed, 68 insertions(+), 85 deletions(-)
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
index 00000000..64828ce1
--- /dev/null
+++ b/head.html
@@ -0,0 +1,3 @@
+<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- needed for reponsive display to work -->  
+<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
+<link rel="stylesheet" type="text/css" href="/style.css" />
diff --git a/index.html b/index.html
index 0238a9c0..e543b1e8 100755
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
index 1a8f678a..abc45448 100755
--- a/mirrors-report.html
+++ b/mirrors-report.html
@@ -1,16 +1,15 @@
 <!DOCTYPE html>
 <html lang="en">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Mirror Report</title>
     <script src="packages/reports/sorttable.js"></script>
   </head>
 
 <body>
-<!--#include virtual="navbar.html"-->
+<!--#include virtual="navbar.html" -->
 <div id="main">
-<!--#include virtual="top.html"-->
+<!--#include virtual="top.html" -->
 
 <h1>Cygwin Mirror Report</h1>
 
diff --git a/mirrors.html b/mirrors.html
index 18fdade1..82f70d73 100755
--- a/mirrors.html
+++ b/mirrors.html
@@ -1,13 +1,12 @@
 <!DOCTYPE html>
 <html lang="en-US" xml:lang="en-US">
   <head>
-    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-    <link rel="stylesheet" type="text/css" href="style.css" />
+    <!--#include virtual="head.html" -->
     <title>Cygwin Mirror Sites</title>
   </head>
 
 <body>
-<!--#include virtual="navbar.html"-->
+<!--#include virtual="navbar.html" -->
 <div id="main">
 <!--#include virtual="top.html"-->
 
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
index 04f1708b..498b2a4c 100755
--- a/package-server.html
+++ b/package-server.html
@@ -1,9 +1,8 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-  <link rel="stylesheet" type="text/css" href="style.css" />
-<title>Cygwin Package Server</title>
+  <!--#include virtual="head.html" -->
+  <title>Cygwin Package Server</title>
 </head>
 <body>
 
diff --git a/package-upload.html b/package-upload.html
index 4bb5a54c..a81891a8 100755
--- a/package-upload.html
+++ b/package-upload.html
@@ -1,9 +1,8 @@
 <!DOCTYPE html>
 <html lang="en">
 <head>
-<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
-<link rel="stylesheet" type="text/css" href="style.css" />
-<title>Uploading Packages to cygwin.com</title>
+  <!--#include virtual="head.html" -->
+  <title>Uploading Packages to cygwin.com</title>
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
index 5e815292..6e541a3a 100644
--- a/style.css
+++ b/style.css
@@ -519,3 +519,22 @@ table.grid td.failed {
     margin-left:auto;
     margin-right:auto;
 }
+
+/* responsive styling ---------------------------------------------------- */
+
+@media (max-width: 800px) /* tablet display */
+{
+  div#main
+  {
+    min-width: 20em;
+    width: 85%;
+  }
+}
+@media (max-width: 450px) /* phone display */
+{
+  div#main
+  {
+    width: 100%;
+    padding-right: 10px;
+  }
+}
\ No newline at end of file
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

