Return-Path: <SRS0=d4VT=B3=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 8560D38582BD
	for <cygwin-patches@cygwin.com>; Wed,  7 Jun 2023 16:39:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8560D38582BD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id 6vSfqsSLWLAoI6wCNqgyCH; Wed, 07 Jun 2023 16:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686155991; bh=zeSHxFLUWEPByfwUYC2U/aAMllW5NqtmLMPIGbpibno=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=rDOoackhGK7dGmhEshUjH4m7jq5TiX1Uqn2hpUJPs1vP8MqlceeKjyR8/P5a//V67
	 H0d2Nk0QUF5MdnOEAFbcB+hEEe3M6Nm+etbn9b/o9Lc7aFF/Y+88oQqF33k0wKahgc
	 qSPLJ5dTiAK1aOhouR/JlL5hOE2bRn7FpkEAQ2F2p4zwYmQs+Aij2Q1o0jRDnPjWso
	 SVLrvdXWbtYl9fku4iMJEqDwXVR3cOnEWzwgOw3JUStxXRFmgXYeuA7ihVY/yfguUv
	 p3Kcitt1kCyRyXGNh0Oxqg9JOGlZ48dTUutF9y1GkKDPCySgjc9rFrcyZz+maBzlpw
	 7zKhVEodR5UEg==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id 6wCMqh7TNcyvu6wCMq41m5; Wed, 07 Jun 2023 16:39:51 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=6480b2d7
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=msQzIvg6e3CktenIoIkA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/3] wincap.cc: set wincap member has_user_shstk for 2004+
Date: Wed,  7 Jun 2023 10:37:46 -0600
Message-Id: <8ccddf94ba491ec8e455d827b3b790986dd2355f.1686095734.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMqW2V9KBleJ+ow8hbIifGaTvJUb3ZolA/DZB5B7xyPp88R9EEibx0aWy6KLWbT/X4oia7kUKb4Btp/3TU4L+3G14Vw8ZsxLT9F21ooLfT9GmGTMSxxy
 WYygkrbmPGWfPtzlkgwTML+e7fcypDsr3rm9XXw/1uUXNh4YE7nZ+0Rk2sS2rdG1mtzMUg8UmaONUd9qGlMnbr6Uq82Kvuox29ha0FYGgkazafFpVCk7uX96
 TpO2BA0PEp/LVmkCMD8Saq0uJTmCcDujOVW8D4ADjUg=
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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

