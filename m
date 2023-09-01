Return-Path: <SRS0=rmRH=ER=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id A52493858D37
	for <cygwin-patches@cygwin.com>; Fri,  1 Sep 2023 17:42:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A52493858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id bzfvqMFUMLAoIc89tqOPHh; Fri, 01 Sep 2023 17:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1693590133; bh=MiGtbXf/vQtifH815JOsMgPP16Yp97dyzroBjTJzloc=;
	h=From:To:Subject:Date;
	b=XMID8EV50QfJ33AxQpKptILBUJSniz5icauyWdwdiB3tr/L99wzFTtS1v6i0mdciG
	 Aa/y8S5mmGNED8QaQ0/htlQnakVg8fubHrjXLNTcyOgM/7oe/NXkvZgACwQ0VZOFAV
	 8GqszYKRWCOi7zWHIFvnlIUrobUbHRkfAxnNKvgbMqG/V69xUD8XC0lO5b9z1g6pmr
	 uFY0jbbV0d72q+4iePFn9X4Vgw2bj49mFlP15rIF+cBaQhYtVycXBjn+98MJ5eG65o
	 lduHfR0PtOvDm46hSzad3gVXVU6jbw/+dzMY4QbO8riL2BpVVz85t/5Ld9SPWCU47F
	 1R95censujEoQ==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id c89sqjHZ33fOSc89sqYhuW; Fri, 01 Sep 2023 17:42:13 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=64f22275
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=W52JyncupOHRXg-QgnkA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: cpuinfo: Linux 6.5 additions
Date: Fri,  1 Sep 2023 11:42:10 -0600
Message-Id: <eee1b0143719407f8db6cb2767d093bc12efd738.1693589725.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAyZ0P0jfzUbKmb4GgIsJqkzHITKDK/nGJ7pG6JAdLA1u4kDUD08vHFbyRkCcJsD2v/13XBOXGtk24R0FP7P+zoGunjpcpOHFoqe/vrejCmw10HDi+Ay
 YEREKY0sfr3u6w07PMvFZbIWhx4HVeXdbCTPiOJXpFvGap2QirD3Me6fzziXSsiCXB2iqDoki41SaL4XkghDKe1ShkAgb02ZGMagHAI1R73qYUQue8wSB0AL
 k2mvrky6fnKFf/I8zuN+Ud8M5MCiCWMQVe3mkP0Gmq8=
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

add AMD 0x8000001f EAX 14 debug_swap SEV-ES full debug state swap

Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
---
 winsup/cygwin/fhandler/proc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index cbc49a12a417..be107cb8eacc 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1652,7 +1652,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features2, 11, "sev_64b");*//* SEV 64 bit host guest only */
 /*	  ftcprint (features2, 12, "sev_rest_inj");   *//* SEV restricted injection */
 /*	  ftcprint (features2, 13, "sev_alt_inj");    *//* SEV alternate injection */
-/*	  ftcprint (features2, 14, "sev_es_dbg_swap");*//* SEV-ES debug state swap */
+	  ftcprint (features2, 14, "debug_swap");   /* SEV-ES full debug state swap */
 /*	  ftcprint (features2, 15, "no_host_ibs");    *//* host IBS unsupported */
 /*	  ftcprint (features2, 16, "vte");    *//* virtual transparent encryption */
 	}
-- 
2.39.0

