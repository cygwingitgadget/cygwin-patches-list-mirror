Return-Path: <SRS0=d4VT=B3=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id CA6C23858C54
	for <cygwin-patches@cygwin.com>; Wed,  7 Jun 2023 16:38:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA6C23858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id 6sIhqkynf6Nwh6wBOqWe8F; Wed, 07 Jun 2023 16:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686155930; bh=foMMz2ewfJx9KC5Sykxbh9g+HsTonLziIou579kt+fo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=kqhtXMprTRZ5LdDOZKl9eJkNTm62dQUO3QbLqqzKij8Ga2CJqeOGnOGr3/ZG/X4z4
	 Sb1XRGO88qGe+fZI4lL/y4JznN+PnaCw2cchQwiHtNBbLE1P28gYbBF0WXsD858Jqe
	 2UNj1+/oyGOAhIuN4VW1i5z3zJ74GtGphu+mKxO8eYaXNbU4PpZWKHtBrujqn3GJ4w
	 CzVjhYNHDH1i0kemqLNSUTAUxyBXCwvDZ11jnXw0LH/dQqqVaT9IgJppYM89F8HkM0
	 b9+rprXXYueTf9iXgo/4l2wgdo2C/i0chh0leloJZq0+cuUfwCPNNiDDqDRkGsxCOW
	 zRLi9SlasC0jg==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id 6wBNquEYR3fOS6wBNqdMjZ; Wed, 07 Jun 2023 16:38:50 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=6480b29a
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=QuwAe7yFclR52_RR2psA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/3] wincap.h: add wincap member has_user_shstk
Date: Wed,  7 Jun 2023 10:37:45 -0600
Message-Id: <91439aaa378c5ed38b236ddb16b99644284b7fe1.1686095734.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfErn9OuA07fL8PY+NLfkDkbeauRpeKXjcZH2tmEeJ8zv8zqG65uvVIN7h8ZaHI7Th70azELdxbAQgybVrPyukh4E+H50w8hyZ7lp0wvMCAFSJHW+a6Gp
 8IqsIGwoLdFg2o+M2Oes8MpZXrbmh0gqNhIChtY6pOgIrRpPCCmzoSyY13JPZGSe+TVGDKBevP+tb02dW5Hu/WT/jDWx7Cz5w9fLzQhLHTV5iitrQ2ZgBouj
 MzpsE9TlhIBxn3Q3FBA5qZ6Fljr+3p2U5aNs0DPrO1Q=
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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

