Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by sourceware.org (Postfix) with ESMTPS id 3E4894AADCFD
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E4894AADCFD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E4894AADCFD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576452; cv=none;
	b=evJtrgxxFF7mrIvswThQ97Fjr6JB1ZZi8CkNzvBt1fbDagHkzX3fvelimbXGZHREKFobPCZ7gYgD112gVcTY/ds3ZkJ9ZrCN0cjHzkjjauUiWRUtxKnX3VD1RQvyJd7T4GehUt+HgYLZ9W/EBA0r5U8+6fj+4Aq0SqqtUIi+qKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576452; c=relaxed/simple;
	bh=s00BVXK9quaCIP1KOA3V8mx25o/8J37S0lE7FxZvUiA=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=dK4lgrLqhvpTt0XWkJYKmrmmktCbAQpV++RUZCKa4hosqtPUzyR4xaXSMjXetkPo7WbBh0ffZFNrSrYTGQtacTzAp9snGWE9dKHLKDD3jRjv4D6Kd0V1sEqUe08pqL51nGbcDxJcuoE6lhv4EM3pZQb8t+jsUQun8wNP72Um1Zk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E4894AADCFD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zu3ysLub
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-79827d28fc4so17681987b3.1
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576451; x=1777181251; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VINaVzLTVx7x4Zelb+znWcbXYdjeCxIJD4+ZfAx0kJI=;
        b=Zu3ysLubEHWMJbOTxCGk+ek79nCPP5i5RynVEUR6Fg+g2VYT5toOaMDc/iDUD5qt2b
         Cl2UF7B/Cm832P8leJGEevLCmeLauuomkBnstOIhlcQEgIGInvO057DbSYpT8Fk+Z4Hu
         nZqg/SlPp6MNA5IIswea92lILSOd6Bifm/sl0zis4TibgqUj7gGonSPf87D9zqJNgbN5
         D5seybX61ijFHSZWtEgvVp9+JBtm2kLu6h8rijjgDUnBGIjk0FaGUY2KxZjw9WbUmtB8
         TJpkD/4PylHj25cx/2wE5S3gr9aSp78TRf9NTssKG1XMHh9Ut/P0x9Qksi4BSztfw96R
         hxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576451; x=1777181251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VINaVzLTVx7x4Zelb+znWcbXYdjeCxIJD4+ZfAx0kJI=;
        b=cwOqYxECbb9vmSdrxn1DvbXleAt7GkIvCVVzKNYBAkJvwfqczSFLqfuWXr1Qv88ks7
         //mSC/XerPjW7YCos9FSyYyYRU+ZP6ugqxkXSS9tG4dUFxv0stl9rLsuBhvnBK+suas5
         qzabl7Hyjld39QOCNA6elB4iHt5eh5OdvcGqZs5241zM1vDIfoZDYKgLSTQjZz+sCAqg
         cZGETAQftMxQ2AgEgOKHGQC6idntaMd4JjjQr5ZmKBBYhDx5HcEqWaXgY3oURa8WX35u
         ilSz/Q6G7Uxn6i3BW1Ws0r0l4KvyJ/4zr+/ZHZQtCosEB/wzWsIjAs1UA5YZy6jPMyKg
         ieyA==
X-Gm-Message-State: AOJu0YxOhf8P2m9F12v4PY58xuyty0LmCrk3IQP0oP+aQCD1qtbP4lkx
	dYtiDJgV7MYvFlNeHSxwnQrfnNPqj7hmwzhPxO+SXhpCgbblyugP6oXVPyamjQ==
X-Gm-Gg: AeBDiesYPAzZvXEbSfQHiZKOQpaqouCRXQdmBlZjdvFVZepuwD/SZA84xu3yYaB3RVM
	nOXskmKSnK8AK0KW4yiBjsmiq3TzCwfbVs6bqweF1vMn0dKziyuH87UB3NjGg+D7GTd7fQ+UGJd
	nSAUc/WMaWD7Q62JBewhSS2IJOwnA4YMVS6RFen34iUDd+WZFulXinrT7EHEnFqIUEf185N5/XM
	ZWXZ7MDnFhvvE/R1zS/UufNpZupxu9qMD4Sxd3o4yyMIwWqcmUzZybwG7yFcSknr6O4S7k9NOaT
	u4n/NMVxzSxgL5Q4Wqyl364l6ClZzwqqBbul9Zm6+8xQ0YjzKLvLTDgGkw9f8QQvpBGd1rvqoHR
	JYp88e1BGSfO65Q1p3i4bL+coaayz24ZVx5ILJOTfv/Xlxxhd6SdkiXOzRO/kDb7Wtuqdivxzb5
	fL2xAG851CiW78PEJ/3DD+JdxvFjJ85fakC34uoe/UKDZG/qng/VWaztm/z+IxvBPWd1uOBvLOo
	8KO7wXZvsSsQVAXeYZV6uKE0Q+k944weCnACUC5jGJgaa9H
X-Received: by 2002:a05:690c:660d:b0:7b3:7f30:af69 with SMTP id 00721157ae682-7b9ece6958dmr89459277b3.9.1776576450782;
        Sat, 18 Apr 2026 22:27:30 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:30 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 11/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:59 -0400
Message-ID: <20260419052701.513-12-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,PROLO_LEO1,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

css variables for colors to keep DRY

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 85 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/style.css b/style.css
index 5e815292..25035bba 100644
--- a/style.css
+++ b/style.css
@@ -1,6 +1,21 @@
+/* CSS variables --------------------------------------------------------- */
+
+:root
+{
+  --black: black;
+  --white: white;
+  --big-title: #990033;
+  --nav-background: #80a0a0;
+  --heading: #99003f;
+  --code: #80a0a020;
+  --cartouche: #e8e8e8;
+  --table: #f2f2f2;
+  --table-hover: #fdd9b5;
+}
+
 body
 {
-color: black;
+color: var(--black);
 }
 
 a:link {
@@ -20,8 +35,8 @@ text-decoration: underline;
 position: absolute;
 left: 0.5em;
 max-width: 11em;
-background-color: #80a0a0;
-color: white;
+background-color: var(--nav-background);
+color: var(--white);
 text-align: left;
 }
 
@@ -55,7 +70,7 @@ padding-right: 0.5em;
 overflow: hidden;
 font-size: small;
 font-weight: 500;
-color: white;
+color: var(--white);
 text-decoration: none;
 font-family: sans-serif;
 }
@@ -99,7 +114,7 @@ margin-right: 0;
 #rightwhat
 {
 margin-left: 50%;
-border-left: 2px solid #e8e8e8;
+border-left: 2px solid var(--cartouche);
 padding: 0.1px; /* rounds down to 0, but prevents margin collapse */
 padding-left: 1.5em;
 }
@@ -115,7 +130,7 @@ font-size: .9em;
 #endwrap
 {
     clear: both;
-    border-top: 2px solid #e8e8e8;
+    border-top: 2px solid var(--cartouche);
 }
 
 /* main ------------------------------------------------------------------ */
@@ -132,26 +147,26 @@ min-width: 45em;
 {
 font-size: 2em;
 font-weight: bold;
-color: #99003f;
+color: var(--heading);
 }
 
 #main h2
 {
 font-size: 1.3em;
-color: #99003f;
+color: var(--heading);
 }
 
 #main h3
 {
 font-size: 1.1em;
-color: #99003f;
+color: var(--heading);
 margin-bottom: 0ex;
 }
 
 #main h4
 {
 font-size: 1em;
-color: #99003f;
+color: var(--heading);
 }
 
 #main .catchphrase
@@ -189,7 +204,7 @@ overflow: visible;
 {
 font-family: sans-serif;
 font-size: 5em;
-color: #990033;
+color: var(--big-title);
 margin-top: 0em;
 margin-bottom: 0em;
 margin-left: 6px;
@@ -210,7 +225,7 @@ margin-bottom: 0.2em;
 {
 position: relative;
 font-size: 0.7em;
-border-top: 2px solid #e8e8e8;
+border-top: 2px solid var(--cartouche);
 text-align: center;
 }
 
@@ -218,7 +233,7 @@ text-align: center;
 
 .cartouche
 {
-background: #e8e8e8;
+background: var(--cartouche);
 border-radius: 8px;
 padding: 4px;
 }
@@ -230,7 +245,7 @@ table#mirroradmin
   width:90%;
   margin-left:5%;
   margin-right:5%;
-  border:2px solid black;
+  border:2px solid var(--black);
 }
 
 table.deben
@@ -238,7 +253,7 @@ table.deben
   width:85%;
   margin-left: 7.5%;
   margin-right: 7.5%;
-  border:1px solid black;
+  border:1px solid var(--black);
   border-collapse: collapse;
 }
 
@@ -250,16 +265,16 @@ table.deben th
 }
 
 table.deben th {
-    color: #99003f;
-    border-color: black;
+    color: var(--heading);
+    border-color: var(--black);
 }
 
 table.deben tr:nth-child(odd) {
-    background-color: #f2f2f2;
+    background-color: var(--table);
 }
 
 table.deben tr:hover {
-    background-color: #fdd9b5;
+    background-color: var(--table-hover);
 }
 
 div#main .indent
@@ -356,7 +371,7 @@ table.pkglist {
 }
 
 .pkglist tr:hover {
-  background-color: #e8e8e8;
+  background-color: var(--cartouche);
 }
 
 .pkglist a {
@@ -371,20 +386,20 @@ table.pkglist {
 
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
@@ -396,11 +411,11 @@ table.pkgtable td
 }
 
 table.pkgtable tr:nth-child(even) {
-    background-color: #f2f2f2;
+    background-color: var(--table);
 }
 
 table.pkgtable tr:hover {
-    background-color: #fdd9b5;
+    background-color: var(--table-hover);
 }
 
 table.pkgdetails p {
@@ -424,7 +439,7 @@ table.pkgdetails tr td:first-child {
     -webkit-column-width: 15em;
     column-width: 15em;
     column-rule-style: double;
-    column-rule-color: #99003f;
+    column-rule-color: var(--heading);
     width: 90%;
     margin: auto;
 }
@@ -475,21 +490,21 @@ table.grid {
     width: 95%;
     margin-left:auto;
     margin-right:auto;
-    border: 1px solid black;
+    border: 1px solid var(--black);
     border-collapse: collapse;
 }
 
 table.grid th {
     text-align: left;
-    border: 1px solid black;
+    border: 1px solid var(--black);
     border-collapse: collapse;
-    background-color: black;
-    color: white;
+    background-color: var(--black);
+    color: var(--white);
     padding: 0.3em;
 }
 
 table.grid tr:nth-child(even) {
-    background-color: #f2f2f2;
+    background-color: var(--table);
 }
 
 table.grid tr.highlight {
@@ -497,13 +512,13 @@ table.grid tr.highlight {
 }
 
 table.grid td {
-    border: 1px solid black;
+    border: 1px solid var(--black);
     border-collapse: collapse;
     padding: 0.3em;
 }
 
 table.grid tr:hover {
-    background-color: #fdd9b5;
+    background-color: var(--table-hover);
 }
 
 table.grid td.succeeded, table.grid td.deployed {
-- 
2.46.0.windows.1

