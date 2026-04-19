Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by sourceware.org (Postfix) with ESMTPS id 333D24BA9015
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 333D24BA9015
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 333D24BA9015
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576437; cv=none;
	b=dvyZWgw1JI5mCIKIjrkGqW1DSjSVch/S90w+lX3KcPVXoXCRfSJzbZK4wkpiZMddb+mNcnU8BHdJmYBrdwUd+Wtt4ySJwV51F0iu4K4vCM1SMZcR1Rw4wc91Imhpj2OjMjAQFkMr+SwSZOtCL9XlWvf9o6dZ9MSenaFOjzMBLJk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576437; c=relaxed/simple;
	bh=mqeMLYbJTSmxpQZ8o0lLQJXqcflpZudPOc/wzTwZydU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=hZfbStAKtKmM8Y/IJdrUcqgRra+k0YZd1fQvTr66vwgU9x6DOizMl8j6uNGDoWRis/I1fn/wbvoKW8uJiRqItJ8MBkjPyvddQgaf5QaFe3a4Keshpgn8LUzVQeeNVShpunEgiWv7QYYtl8IcCWSQniDojP32wRI3B05pOJE4gHc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 333D24BA9015
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e9898V/J
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-797ab169454so26721277b3.3
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576436; x=1777181236; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BatVNSPeEa3gCBbJekzL9+uZQ1yl5YvAg/c1z57m9Y=;
        b=e9898V/JszrBsrMvcsNZGAweM3zOE9juLMbfd1ACZktbyjKV991tfvN3HVQMl28PN4
         8gxX3LuGusL6nJsRiH/nEMPBZoHMHJEnZonyu94M5t6hb9/6dA0pdI8IHzVcQzNnLR6Y
         bzug9Q+Jm8R50vYFKnNVOoYGu8gOIyQ343+rxmlmjDlJxQK66EfNDht/ax2R2RHXJpmi
         ia8NDrnloczdfSkwlw2X6zIjvsv0JSWQnPdT4iW+0Z1gkW9me67N6W5QFAGvYNOmXB1N
         NmgDlaOt9zRXuUHIEBMS5TZWc93uSAmGg9+8Azx0oZja9YsjTyIoGgiW6s2loMRMwDtf
         wnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576436; x=1777181236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8BatVNSPeEa3gCBbJekzL9+uZQ1yl5YvAg/c1z57m9Y=;
        b=lAVvu2Srf6aTyuCe2xS1u0TwcQaV1WzIOw+VjEEB8MSiGOYbhkOPK/3aWU6FTJWqt0
         ScYBTg8oIWGIJxlS0kKe1fRfkW0n7Xz8U4d2+1fflM57wmhrYp3pb5KJBpVzaVW8U45w
         UzZi3RZeOBd7AJgqYX4a1jGe6tE8msJO2zWcVoW+srHy3f4mng7nX9KfZukbsj3rFUQd
         OKKgMSuig8AkJB7Y1R8BHc4ExD0UR1ukwZXqWK9IbOl4gQUgSlrpoOAwbGG4Vq9OEh7E
         w3qJpasKl6awBIn0nGbFB8l5NShIyTzdCcFDQykSNnZ3lJgY5ZxUhdEl2KpBIZkei5P9
         ZbSA==
X-Gm-Message-State: AOJu0YxZIQVUVBm5q+x4whmjYXoG6U+AC14QYdOb4jQDKJC31RNCCx9+
	JDho+JBsskk0aIRskYLOGY/ciyO8OvrQSP3OAFzdKsIBA9vGS1L92Bkb0OiGLQ==
X-Gm-Gg: AeBDieubCJpoVTpnp/XiWXZGtfF1OCq4bEkYI+eR328fMGVYYmI5tcWl19CF6H9AlIr
	0FqvUhhG8GohvXLQRsZyQTQBEi9qUyWtkVAjW1FXaFVU63h6sXVXMAH2K9KdZPstP74G96dyE3N
	gmXRDx2NCRa+u8nhP2bJ3bVdCXpKLDK/GsYgaeIntRhb29IiZ6iNVhpTZgrUPNRVQSDSrPI0Cl0
	6cVRXLcwai//LgxcRh8DB1p2PLcc6usTZh0g91QR9qZDNZtRU5+WV6FTQADBrv+cZG7RhglOsqj
	C8buMLD8g/vCV4Wp9/YeCzIb5Anc+lxLKDforr/+59IgyChjkkOpUzAQlpcSRPkwig5nfesSsRb
	A3MeNdKpBtEVa9DaG4xgUoxC4w0RIxaF1opDiBpAmuA89lP7Qd1fHZqqfbklZTpqbZKq5Ewy5Yn
	d8zgfbH/OxKEHuNZuAVL7F84Lh8JlC0f7fCN42rtJJGG2ZcSWWCbSgtNROIgMypCoxCHffKoRpm
	oKYjpYlSOxWzD5Bu3rWS+9+n7/vJgqPW/yyIA==
X-Received: by 2002:a05:690c:87:b0:79a:b46c:e61b with SMTP id 00721157ae682-7b9ece7ab24mr100390057b3.2.1776576436031;
        Sat, 18 Apr 2026 22:27:16 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:15 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 01/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:49 -0400
Message-ID: <20260419052701.513-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 410 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 213 insertions(+), 197 deletions(-)

diff --git a/style.css b/style.css
index 5e815292..e9772d9f 100644
--- a/style.css
+++ b/style.css
@@ -1,68 +1,70 @@
 body
 {
-color: black;
+  color: black;
 }
 
-a:link {
-color: #5555cc;
-text-decoration: underline;
+a:link
+{
+  color: #5555cc;
+  text-decoration: underline;
 }
 
-a:visited {
-color: #000066;
-text-decoration: underline;
+a:visited
+{
+  color: #000066;
+  text-decoration: underline;
 }
 
 /* Navbar related -------------------------------------------------------- */
 
 #navbar
 {
-position: absolute;
-left: 0.5em;
-max-width: 11em;
-background-color: #80a0a0;
-color: white;
-text-align: left;
+  position: absolute;
+  left: 0.5em;
+  max-width: 11em;
+  background-color: #80a0a0;
+  color: white;
+  text-align: left;
 }
 
 #navbar li
 {
-overflow: hidden;
+  overflow: hidden;
 }
 
 #navbar li:hover:not(.nohover)
 {
-overflow: hidden;
-background-color: #608080;
+  overflow: hidden;
+  background-color: #608080;
 }
 
 #navbar ul
 {
-list-style-type: none;
-margin-top: .5em;
-margin-bottom: .8em;
+  list-style-type: none;
+  margin-top: .5em;
+  margin-bottom: .8em;
 /*
   It's browser dependent which one of margin-left: and padding-left: we need to
   cancel the default list indentation.
 */
-margin-left: 0em;
-padding-left: 0.5em;
-padding-right: 0.5em;
+  margin-left: 0em;
+  padding-left: 0.5em;
+  padding-right: 0.5em;
 }
 
 #navbar a
 {
-overflow: hidden;
-font-size: small;
-font-weight: 500;
-color: white;
-text-decoration: none;
-font-family: sans-serif;
+  overflow: hidden;
+  font-size: small;
+  font-weight: 500;
+  color: white;
+  text-decoration: none;
+  font-family: sans-serif;
 }
 
 #navbar a.gold
 {
-color:gold;
+  color:gold;
 }
 
 #navbar ul ul
@@ -72,12 +74,6 @@ color:gold;
   padding-left: 0.75em;
 }
 
-/* ----------------------------------------------------------------------- */
-
-#top
-{
-}
-
 /* Two-column what is/isn't it layout ------------------------------------ */
 
 .no-vert-margins
@@ -88,139 +84,135 @@ color:gold;
 
 #leftwhat
 {
-float: left;
-width: 50%;
-padding: 0.1px; /* rounds down to 0, but prevents margin collapse */
-padding-left: 1.5em;
-padding-right: 0;
-margin-right: 0;
+  float: left;
+  width: 50%;
+  padding: 0.1px; /* rounds down to 0, but prevents margin collapse */
+  padding-left: 1.5em;
+  padding-right: 0;
+  margin-right: 0;
 }
 
 #rightwhat
 {
-margin-left: 50%;
-border-left: 2px solid #e8e8e8;
-padding: 0.1px; /* rounds down to 0, but prevents margin collapse */
-padding-left: 1.5em;
+  margin-left: 50%;
+  border-left: 2px solid #e8e8e8;
+  padding: 0.1px; /* rounds down to 0, but prevents margin collapse */
+  padding-left: 1.5em;
 }
 
 #wrap
 {
-position: relative;
-width: 100%;
-margin:0 auto;
-font-size: .9em;
+  position: relative;
+  width: 100%;
+  margin:0 auto;
+  font-size: .9em;
 }
 
 #endwrap
 {
-    clear: both;
-    border-top: 2px solid #e8e8e8;
+  clear: both;
+  border-top: 2px solid #e8e8e8;
 }
 
 /* main ------------------------------------------------------------------ */
 
 #main
 {
-position: relative;
-left: 12em;
-margin-right: 22em;
-min-width: 45em;
+  position: relative;
+  left: 12em;
+  margin-right: 22em;
+  min-width: 45em;
 }
 
 #main h1
 {
-font-size: 2em;
-font-weight: bold;
-color: #99003f;
+  font-size: 2em;
+  font-weight: bold;
+  color: #99003f;
 }
 
 #main h2
 {
-font-size: 1.3em;
-color: #99003f;
+  font-size: 1.3em;
+  color: #99003f;
 }
 
 #main h3
 {
-font-size: 1.1em;
-color: #99003f;
-margin-bottom: 0ex;
+  font-size: 1.1em;
+  color: #99003f;
+  margin-bottom: 0ex;
 }
 
 #main h4
 {
-font-size: 1em;
-color: #99003f;
+  font-size: 1em;
+  color: #99003f;
 }
 
 #main .catchphrase
 {
-margin-top: 1ex;
-margin-left: 6px;
-margin-right: 6px;
-text-align: left;
-font-style: italic;
-padding-left: 6px;
-}
-
-#main ul
-{
+  margin-top: 1ex;
+  margin-left: 6px;
+  margin-right: 6px;
+  text-align: left;
+  font-style: italic;
+  padding-left: 6px;
 }
 
 #main .command
 {
-margin-bottom: 1ex;
-margin-top: 1ex;
-text-align: center;
-font-family: monospace;
+  margin-bottom: 1ex;
+  margin-top: 1ex;
+  text-align: center;
+  font-family: monospace;
 }
 
 #main li
 {
-position: relative;
-left: -1.5em;
-overflow: visible;
+  position: relative;
+  left: -1.5em;
+  overflow: visible;
 }
 
 /* Header/footer styles -------------------------------------------------- */
 
 #big-title
 {
-font-family: sans-serif;
-font-size: 5em;
-color: #990033;
-margin-top: 0em;
-margin-bottom: 0em;
-margin-left: 6px;
-margin-right: 6px;
-padding-left: 4px;
+  font-family: sans-serif;
+  font-size: 5em;
+  color: #990033;
+  margin-top: 0em;
+  margin-bottom: 0em;
+  margin-left: 6px;
+  margin-right: 6px;
+  padding-left: 4px;
 }
 
 #medium-title
 {
-font-family: sans-serif;
-font-size: 3em;
-margin-bottom: 0.2em;
+  font-family: sans-serif;
+  font-size: 3em;
+  margin-bottom: 0.2em;
 }
 
 /* Footer */
 
 #footer
 {
-position: relative;
-font-size: 0.7em;
-border-top: 2px solid #e8e8e8;
-text-align: center;
+  position: relative;
+  font-size: 0.7em;
+  border-top: 2px solid #e8e8e8;
+  text-align: center;
 }
 
 /* rounded cartouche ----------------------------------------------------- */
 
 .cartouche
 {
-background: #e8e8e8;
-border-radius: 8px;
-padding: 4px;
+  background: #e8e8e8;
+  border-radius: 8px;
+  padding: 4px;
 }
 
 /* miscellaneous styles -------------------------------------------------- */
@@ -249,23 +241,26 @@ table.deben th
   border-style: solid;
 }
 
-table.deben th {
-    color: #99003f;
-    border-color: black;
+table.deben th
+{
+  color: #99003f;
+  border-color: black;
 }
 
-table.deben tr:nth-child(odd) {
-    background-color: #f2f2f2;
+table.deben tr:nth-child(odd)
+{
+  background-color: #f2f2f2;
 }
 
-table.deben tr:hover {
-    background-color: #fdd9b5;
+table.deben tr:hover
+{
+  background-color: #fdd9b5;
 }
 
 div#main .indent
 {
-    position: relative;
-    margin-left: 2.5em;
+  position: relative;
+  margin-left: 2.5em;
 }
 
 ul.spaced li
@@ -280,62 +275,65 @@ ul.compact li
 
 .nodisplay
 {
-    display: none;
+  display: none;
 }
 
 .smaller
 {
-    font-size: smaller;
+  font-size: smaller;
 }
 
 .floatleft
 {
-    float: left;
+  float: left;
 }
 
 .center
 {
-    text-align: center;
+  text-align: center;
 }
 
 .right
 {
-    text-align: right;
+  text-align: right;
 }
 
 .prewrap
 {
-    white-space: pre-wrap;
-    margin-top: 0em;
-    margin-bottom: 0em;
+  white-space: pre-wrap;
+  margin-top: 0em;
+  margin-bottom: 0em;
 }
 
 .underline
 {
-    text-decoration: underline;
+  text-decoration: underline;
 }
 
 .container
 {
-    display: flex;
-    justify-content: space-between;
+  display: flex;
+  justify-content: space-between;
 }
 
 .container span
 {
-    flex-basis: 100%;
+  flex-basis: 100%;
 }
 
-.green {
-    color: green;
+.green
+{
+  color: green;
 }
 
-.red {
-    color: red;
+.red
+{
+  color: red;
 }
 
-.amber {
-    color: goldenrod;
+.amber
+{
+  color: goldenrod;
 }
 
 /* pkglist related ------------------------------------------------------- */
@@ -346,25 +344,29 @@ ul.compact li
   column widths.
 */
 
-table.pkglist {
+table.pkglist
+{
   table-layout: fixed;
   width: 100%;
 }
 
-.pkglist td.pkgname {
+.pkglist td.pkgname
+{
   width: 22.5em;
 }
 
-.pkglist tr:hover {
+.pkglist tr:hover
+{
   background-color: #e8e8e8;
 }
 
-.pkglist a {
-    background: url('/icons/ball.gray.gif')
-                no-repeat;
-    background-size: 10px 10px;
-    background-position: left center;
-    padding-left: 10px;
+.pkglist a
+{
+  background: url('/icons/ball.gray.gif')
+              no-repeat;
+  background-size: 10px 10px;
+  background-position: left center;
+  padding-left: 10px;
 }
 
 /* pkg summary related --------------------------------------------------- */
@@ -395,127 +397,141 @@ table.pkgtable td
   border-style: solid;
 }
 
-table.pkgtable tr:nth-child(even) {
-    background-color: #f2f2f2;
+table.pkgtable tr:nth-child(even)
+{
+  background-color: #f2f2f2;
 }
 
-table.pkgtable tr:hover {
-    background-color: #fdd9b5;
+table.pkgtable tr:hover
+{
+  background-color: #fdd9b5;
 }
 
-table.pkgdetails p {
-    margin-top: 0.25em;
-    margin-bottom: 0.25em;
+table.pkgdetails p
+{
+  margin-top: 0.25em;
+  margin-bottom: 0.25em;
 }
 
-table.pkgdetails td {
-    vertical-align: top;
+table.pkgdetails td
+{
+  vertical-align: top;
 }
 
-table.pkgdetails tr td:first-child {
-    white-space: nowrap;
+table.pkgdetails tr td:first-child
+{
+  white-space: nowrap;
 }
 
 /* multicolumn list ------------------------------------------------------ */
 
 .multicolumn-list
 {
-    -moz-column-width: 15em;
-    -webkit-column-width: 15em;
-    column-width: 15em;
-    column-rule-style: double;
-    column-rule-color: #99003f;
-    width: 90%;
-    margin: auto;
+  -moz-column-width: 15em;
+  -webkit-column-width: 15em;
+  column-width: 15em;
+  column-rule-style: double;
+  column-rule-color: #99003f;
+  width: 90%;
+  margin: auto;
 }
 
 .multicolumn-list p
 {
-    margin: 0;
+  margin: 0;
 }
 
 /* packaging related ----------------------------------------------------- */
 
 .sample-email
 {
-    font-family: monospace;
-    border-width: 1px;
-    border-style: solid;
-    margin-left:5%;
-    margin-right:5%;
+  font-family: monospace;
+  border-width: 1px;
+  border-style: solid;
+  margin-left:5%;
+  margin-right:5%;
 }
 
 .sample-preformat
 {
-    margin-left:5%;
-    margin-right:5%;
+  margin-left:5%;
+  margin-right:5%;
 }
 
 /* acronyms related ------------------------------------------------------ */
 
 .valigntop td, .valigntop th
 {
-    padding-left: 8px;
-    padding-right: 8px;
+  padding-left: 8px;
+  padding-right: 8px;
 }
 
 .valigntop tr
 {
-    vertical-align:top;
+  vertical-align:top;
 }
 
 .valigntop p
 {
-    margin-top: 0px;
+  margin-top: 0px;
 }
 
 /* grid table style used for reports-------------------------------------- */
 
-table.grid {
-    width: 95%;
-    margin-left:auto;
-    margin-right:auto;
-    border: 1px solid black;
-    border-collapse: collapse;
+table.grid
+{
+  width: 95%;
+  margin-left:auto;
+  margin-right:auto;
+  border: 1px solid black;
+  border-collapse: collapse;
 }
 
-table.grid th {
-    text-align: left;
-    border: 1px solid black;
-    border-collapse: collapse;
-    background-color: black;
-    color: white;
-    padding: 0.3em;
+table.grid th
+{
+  text-align: left;
+  border: 1px solid black;
+  border-collapse: collapse;
+  background-color: black;
+  color: white;
+  padding: 0.3em;
 }
 
-table.grid tr:nth-child(even) {
-    background-color: #f2f2f2;
+table.grid tr:nth-child(even)
+{
+  background-color: #f2f2f2;
 }
 
-table.grid tr.highlight {
-    background-color: #daa520;
+table.grid tr.highlight
+{
+  background-color: #daa520;
 }
 
-table.grid td {
-    border: 1px solid black;
-    border-collapse: collapse;
-    padding: 0.3em;
+table.grid td
+{
+  border: 1px solid black;
+  border-collapse: collapse;
+  padding: 0.3em;
 }
 
-table.grid tr:hover {
-    background-color: #fdd9b5;
+table.grid tr:hover
+{
+  background-color: #fdd9b5;
 }
 
-table.grid td.succeeded, table.grid td.deployed {
-    background-color: #33a25c;
+table.grid td.succeeded, table.grid td.deployed
+{
+  background-color: #33a25c;
 }
 
-table.grid td.failed {
-    background-color: #a23336;
+table.grid td.failed
+{
+  background-color: #a23336;
 }
 
-.gridfooter {
-    width: 95%;
-    margin-left:auto;
-    margin-right:auto;
+.gridfooter
+{
+  width: 95%;
+  margin-left:auto;
+  margin-right:auto;
 }
-- 
2.46.0.windows.1

