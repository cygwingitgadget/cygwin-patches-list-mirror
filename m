Return-Path: <SRS0=lA2L=CH=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 216003858D1E
	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2023 18:16:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 216003858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id BF8AqBCcwLAoIBJQLqH343; Mon, 19 Jun 2023 18:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687198581; bh=hX0ViAbAh0jBn/Rl9anEJL6kpnok1CkB1CbAFIzpydY=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=eOzEASbu5mrirx7RY5bX8iCpeMeSulqTXslByhxfm7tvx/gMLDQvCLiGNnbWOZqkW
	 w5IXplB470B3agk8TA6on+zxbmJlXra6fHG46YUacM0ec6jaRxgIxzM1CS6XpHMt/M
	 cE1LvCzqEmNTbZVj+e+pp+HoNR6sXqJdp5xEP3E6jAPkK4HEF6QKGqBgLjQg4oo/lR
	 UOqu2azP/7z/qZKSD/v+P9ryALqtMKcRu1thhG8Hd3XYGuU3+XPchme3kwc/n5oI6a
	 vwQDQimeHHo8wn9uwSOtjw9tunCI3RRdlllh0ou+f4RT/tLmpWrfwZ9ltwUQ2VKtxD
	 m2ALJXm1RsrlQ==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id BJQKq6f35HFsOBJQLquWQX; Mon, 19 Jun 2023 18:16:21 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=64909b75
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=QuwAe7yFclR52_RR2psA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 1/3] wincap.h: add wincap member has_user_shstk
Date: Mon, 19 Jun 2023 12:15:17 -0600
Message-Id: <91439aaa378c5ed38b236ddb16b99644284b7fe1.1687198150.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFq4EbVfwOAGwp98S+WdOFtWHwr8ZhQoplxqm2qHCBd+I5NvdffYDtrgEfn5+AENwxPLZa10IJIrZoNKKak4GRCrtReiGJM+R+tqEgaNokNSxqSdb51D
 Cgs4ztMLaAnEK4ZpV37+CaPeNV26yEE3Nb49op6uRRKe71O2C3vdGBDpuli3y3PNdVXIVHR6to8Atjmz7PZrNMyu8DgOVyud2RaUaGvXaky/zUdUUWABnCmw
 iNIlnhjZKAflK1uNu9ejhGkN0B9gVXpESV3KascpNIQ=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
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

