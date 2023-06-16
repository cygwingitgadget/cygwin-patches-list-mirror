Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id B77F93858D35
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 17:18:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B77F93858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id AC08qzbbO6NwhAD5RqzCH7; Fri, 16 Jun 2023 17:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686935893; bh=/Ogl7s+5jjog0Qz1EIqC8jWqSXQ4QezhqPzKs3Vfom8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=clo6qevOs2aBmtEzBCtv7wiubLFjbD6eVv/rDs5mb1jzh8YJlaa8vAn1tvSG3SpDS
	 I0YTlcTXmLubjZvOmYjFfBD2WQX1ejG1kCugOqk0xh3LXqTlMTzn5Wmj4pjSE8o4vm
	 JTc4mEWZKpbhljINRDfGVupIkZ4EOZStInYMp7QxWsKmYLLvaPMPcQSErLhy6zaE2b
	 bQ51ImJQkMP4SEXdpkxRUDekJEq1ZVfurRCdwW9iVO0yCKJHl5DtpVLyq+UUsGkdmG
	 iPhIAigsWKBRBYnZiHjyv+/L6msoXSoPp8Gr6zE0KU0f+C6hrd4ohYGDxMMI6nYQYi
	 GdhghBUAernjg==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id AD5QqcoNKcyvuAD5QqPX97; Fri, 16 Jun 2023 17:18:13 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=648c9955
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=QuwAe7yFclR52_RR2psA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 1/3] wincap.h: add wincap member has_user_shstk
Date: Fri, 16 Jun 2023 11:17:08 -0600
Message-Id: <91439aaa378c5ed38b236ddb16b99644284b7fe1.1686934096.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKEKUKKlg3IaDmW4OTO1c8ETc1WhxucCBLq6pWI3kWgwKq3XRStzLSwl03SelPYUvFKcV0LOSq1t1o90bD/IX2wiPl6r7SEvIcnqIek1DISokn+njEJi
 M8XHZV9cVSvX0gY3G5c6X5XTDRTbBCdP+uj0BafzHXDM1hjWlgnEPCQsb0WkwreAT+ifa1H7oysLA0zVJe6SRYc2Ywl45OuKG7I24NhReXlue7hw2PiojZOu
 gjeUSusHNBo+8+tbcHpFzdTlfY1wDIxGGdMZwJlsxGY=
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
---
 winsup/cygwin/local_includes/wincap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/local_includes/wincap.h b/winsup/cygwin/local_includes/wincap.h
index 29a7a63de7f6..c14872787ca2 100644
--- a/winsup/cygwin/local_includes/wincap.h
+++ b/winsup/cygwin/local_includes/wincap.h
@@ -32,6 +32,7 @@ struct wincaps
     unsigned has_linux_tcp_keepalive_sockopts			: 1;
     unsigned has_tcp_maxrtms					: 1;
     unsigned has_con_broken_tabs				: 1;
+    unsigned has_user_shstk					: 1;
   };
 };
 
@@ -84,6 +85,7 @@ public:
   bool	IMPLEMENT (has_linux_tcp_keepalive_sockopts)
   bool	IMPLEMENT (has_tcp_maxrtms)
   bool	IMPLEMENT (has_con_broken_tabs)
+  bool	IMPLEMENT (has_user_shstk)
 
   void disable_case_sensitive_dirs ()
   {
-- 
2.39.0

