Return-Path: <SRS0=lA2L=CH=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id D76ED3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2023 18:17:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D76ED3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id BEBPq40Eo6NwhBJRKq6jYs; Mon, 19 Jun 2023 18:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687198642; bh=9qjyk3C1vnHIUq1AqjUKGAawzmcZ+8H1xS74963NuAw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=IYgpPrNrTp2Dxb+pKDaEDxNVxPRe4LafA2XD8V5dr+061/wMiFyQP1xGvxDIq34W8
	 pccGa3CPGH3igzL6rQKeW7sfZwM2HxIRwe1TAaIhuBxLde0BPTDdlFrZel7vzj/Dpv
	 /Ldjgp6fen+qJe2u2pn8VpJIp8XIMR4GhDBbkQ4GRco9wGAq7vKisXL5OYT864lHQ8
	 xVs/oiJtLhcfxkPqa98Wmvn1tusa/fuZ4i/axp0hctE462JUV5sJPFz7bS0p5zDGEY
	 DHFtcJwyEHk82gCWFf4RYiEpeKK0mQA8XleKtwqj9lVHmh97k4nk6Y5iqC2tHx0K4N
	 PiRKKr4cGdDcw==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id BJRJqwIXNcyvuBJRKqVd0A; Mon, 19 Jun 2023 18:17:22 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64909bb2
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=msQzIvg6e3CktenIoIkA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 2/3] wincap.cc: set wincap member has_user_shstk true for 2004+
Date: Mon, 19 Jun 2023 12:15:18 -0600
Message-Id: <8ccddf94ba491ec8e455d827b3b790986dd2355f.1687198150.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEtBwVUd2mcC4tgfsSzbWDAWUYszvQyV8R4Am5Bz1BPbUG/XmlWrwEdjsnMFVYBle1YZMH2V4kh+1iNu59fX2VikQ3YMzMYqbH8+BZrUnOtVAUP7Ye+I
 YzpFbyOYsiGPjlA9LwDpGKeEB9ELGHXhXiDK2HjX68PhUaazA6cC8bbNZ5uPMg+Ky8CvuSMVgjz7gLUAV6jhE84O2lOR60kmGzuDf2h55TcA552id9BMUYdJ
 c9xit7580T5hKf2EAg1J5J+R6suLWXdLzjmmcdxYUNU=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
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

