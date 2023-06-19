Return-Path: <SRS0=lA2L=CH=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 7AEE43858D1E
	for <cygwin-patches@cygwin.com>; Mon, 19 Jun 2023 18:18:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7AEE43858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id BDPsq3xDf6NwhBJSJq6jlv; Mon, 19 Jun 2023 18:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1687198703; bh=M4+PkkkjQ952eb8zmOPqxlmO44drUDbJ5hBBRx6o0jQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=etZPRV0gGc23f5we/0EHpSTAWDl5gjRgzEwCSSFCEPpOG+T1HsWwtCAZC3TX5FlEy
	 jwvinFN6hkwTD9CaC/Dstj+/q1bFS54vUPjnSv3qtbRS8IdJ0b8zYeaBGe7BqouBok
	 BO1rp8AEuwmHri6UYTaUnGGVsG8aO6x3Xje+a11xt+sqtiTkcbAPFUYuMIYS0OjsW8
	 F2omXvuUmvvmb37udWR+r+IwBicWpoSk/+i+ZpSPU0VLtYXIzWENvXxnLcP3ZHFm0N
	 kbBmjqDYHsQEOtTcCkrb/Mk2fVxTsxDhPrblb6Hd32EtGRiguBX58767ifpo0AUqZ4
	 ZUdx9GA/NBXSg==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id BJSIq6fiDHFsOBJSJquWjM; Mon, 19 Jun 2023 18:18:23 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=64909bef
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=SFGEnkTAR_NGIzSk_2gA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v4 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Date: Mon, 19 Jun 2023 12:15:19 -0600
Message-Id: <c2c1deee00e7e0aa8587148295219bad02c26031.1687198150.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMOt2UuODmyUT21qOwlfJ0xwOZlkVZtRYla7GAwHJh4ZK/94KJ+szeGU+oMdpRZ9OoQZCeD04bI7xTSR3o4n4HRfBFxf1v/xzYHKbQEOcuIpsgtenZko
 OFKaLCogZ3mIk4MHUZzWr7deoWOCB3RMz36V5Dk4j7TaZAWqCfAZm0hxzRD2uO4ZYY/7UdhQ5dPwMlnecROjSh5CnES+2tM9e9nnEWqESPGrLqoSGvzPZrsA
 kEZKnPCbi++0FOrBl0ly3+wjZ0rio9NANOHrjdu/byc=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
---
 winsup/cygwin/fhandler/proc.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index 3c79762e0fbd..cbc49a12a417 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1486,12 +1486,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
 
-      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
-      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
-					 && wincap.build_number () >= 19041)
+      /* Windows [20]20H1/[20]2004/19041 user shadow stack */
+      if (maxf >= 0x00000007 && wincap.has_user_shstk ())
         {
+	  /* cpuid 0x00000007 ecx CET shadow stack */
 	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
-	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
+	  ftcprint (features1,  7, "user_shstk");	/* user shadow stack */
 	}
 
       /* cpuid 0x00000007:1 eax */
-- 
2.39.0

