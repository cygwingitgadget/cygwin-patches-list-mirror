Return-Path: <SRS0=cvqp=EQ=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 593F63858D20
	for <cygwin-patches@cygwin.com>; Thu, 31 Aug 2023 04:10:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 593F63858D20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTP
	id bOeNqDzaz6NwhbZ0Vq9HkU; Thu, 31 Aug 2023 04:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1693455011; bh=SHoxWQvnxCipQWPK0OK2vaYX7Fkha/7h46uI0+p5ELA=;
	h=From:To:Subject:Date;
	b=KBNpWA0lc1qWVMVZiJNd76CPSr2x6GnNuIcRICvvP7GdzeXTVzNQnUW14EtGx1/70
	 Gdoyaq09g+uwrhgDZN6p2dtEDqUuEJlmvrscadsYT9R7m5scC0Ha2xNWWXENFmMqrQ
	 OttHZcnb+k9Nvcie2bCL6Mg6zS4/AgVSbRTvaugcy+u/D/ua+NmngUTDVLaIrR5EF+
	 PRBW3bwJweJhTblzd4T5T91yO5uMusRRncFObdWft224DTJUVkwh34Uj08dnOvEFmG
	 2c5YS+HVjk0Oe5SX6cfQGlZ3Q7hg+W+LR29thtqktzh4Ew76lali3lVEpryrGMIdPa
	 JG1KxMUnxxRhg==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id bZ0UqYUad3fOSbZ0VqV7DE; Thu, 31 Aug 2023 04:10:11 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=64f012a3
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=8fN2b68Rhf3RMR3bsjMA:9 a=ZXulRonScM0A:10
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: cpuinfo: Linux 6.5: add AMD 0x8000001f EAX 14 debug_swap SEV-ES full debug state swap
Date: Wed, 30 Aug 2023 22:10:09 -0600
Message-Id: <55a6a662221998fa93a01eeb0832e39e510b9cd2.1693454909.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHg67FbojSg4o2BebrLngvQw+nP8V8mj9f+xeN/4HGiuKmarLsiriPs1l2HZZ9WYRpLMQDJY9hRkVvLOaFFQ4dPpxkVzPJVImzWqQubSucbPRZO6v7A3
 G2an3EwAb7PwbZJV0sWWaaXGKbsDHVnsydpdjB1OVLPHAWhd6lkQraZmqIaVHVTO1wq2pBG1X9K7jDiAPsUfxin/mIQqFaLHaW99twDSgxxZKNYqG7thu+fC
 W5oWzH8sKL1c4RW0CVpUksFeTKOPESWy1tb3PelfYG0=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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

