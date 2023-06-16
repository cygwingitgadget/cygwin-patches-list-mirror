Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 626053858D35
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 17:19:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 626053858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id AA85q6Z2SLAoIAD6Qq9V3c; Fri, 16 Jun 2023 17:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686935954; bh=9suQp9+h/zX121JTt9RkPjHTXbTxQUoafzdSB/XQQ6I=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=eAD2MnffCo25MH9sixlmNkg6SEchHcVP/4Hr1EjuLlU8jspNnObvlfg1S09o7PQeF
	 U/hezH7s3BvebVra76emX5qmoY2kPL6h3HYzCz3DXD1/6xAm8NAFcrmO7XAKxU1pDA
	 Fmdx9wrYgMtfOY/udzGzBamoy42LjN74mGqEl1E3acbiGor97tgoxpOK5aEr4R+LdX
	 BvtyVZUucJoOOtY4gSkHe8Woq54a4gJH7GveSqB4fH9gdrGVKIWqnJ00t6wi9uMSXk
	 pJgYpGUOp53/dvcltqlbWZZUBBmkNU4d3xemKjhmt1AKExXi/dmHTg9DTZvsqtSnrJ
	 YNxYH1Bj7lYmQ==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id AD6PqcokYcyvuAD6PqPXJz; Fri, 16 Jun 2023 17:19:14 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=648c9992
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=msQzIvg6e3CktenIoIkA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 2/3] wincap.cc: set wincap member has_user_shstk true for 2004+
Date: Fri, 16 Jun 2023 11:17:09 -0600
Message-Id: <8ccddf94ba491ec8e455d827b3b790986dd2355f.1686934097.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGju+sdaEFhdMZ7OAoKJHC174iCKkPA+Vx6K8xg/hVuJHif9dbhligRw0rXhAgk9YXbC9h2ciE6fzazVYwYdGFnlHGarmaAJEPcfEZBBclBxgnTOJB67
 ZCmJCQuAALsHy2CVX9+L4N649QYl7SFYM0hTPn2TREnm0JW9NUEmfWTXutco9DxpXxH532S0SxpsBt73VMrymaPROFbBFzQm8Fnpzy25KKdLy818mCaAsu0A
 CKuOagDaal6C7jXlIauIwTxcA22ZTLBPJyQS6sai1Tg=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
---
 winsup/cygwin/wincap.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 91d5d9df8889..30d9c14e8d3b 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -31,6 +31,7 @@ static const wincaps wincap_8_1 = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:false,
     has_con_broken_tabs:false,
+    has_user_shstk:false,
   },
 };
 
@@ -52,6 +53,7 @@ static const wincaps  wincap_10_1507 = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:false,
     has_con_broken_tabs:false,
+    has_user_shstk:false,
   },
 };
 
@@ -73,6 +75,7 @@ static const wincaps  wincap_10_1607 = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:false,
+    has_user_shstk:false,
   },
 };
 
@@ -94,6 +97,7 @@ static const wincaps wincap_10_1703 = {
     has_linux_tcp_keepalive_sockopts:false,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
+    has_user_shstk:false,
   },
 };
 
@@ -115,6 +119,7 @@ static const wincaps wincap_10_1709 = {
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
+    has_user_shstk:false,
   },
 };
 
@@ -136,6 +141,7 @@ static const wincaps wincap_10_1803 = {
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
+    has_user_shstk:false,
   },
 };
 
@@ -157,6 +163,7 @@ static const wincaps wincap_10_1809 = {
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
+    has_user_shstk:false,
   },
 };
 
@@ -178,6 +185,7 @@ static const wincaps wincap_10_1903 = {
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
+    has_user_shstk:false,
   },
 };
 
@@ -199,6 +207,7 @@ static const wincaps wincap_10_2004 = {
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:true,
+    has_user_shstk:true,
   },
 };
 
@@ -220,6 +229,7 @@ static const wincaps wincap_11 = {
     has_linux_tcp_keepalive_sockopts:true,
     has_tcp_maxrtms:true,
     has_con_broken_tabs:false,
+    has_user_shstk:true,
   },
 };
 
-- 
2.39.0

