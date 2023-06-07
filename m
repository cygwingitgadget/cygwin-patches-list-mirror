Return-Path: <SRS0=d4VT=B3=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id E0A623858C54
	for <cygwin-patches@cygwin.com>; Wed,  7 Jun 2023 16:40:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0A623858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id 6vSfqsSLSLAoI6wDLqgyR4; Wed, 07 Jun 2023 16:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686156051; bh=8iVsVzym9RnMsI6PEgH5zZfL+o/FAW3ZDnzbjCSLrtI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=wRHJSglCwKF3MnKZYGmggdX51CTHk/y/IHJCze/m9/7cDcLoTTF7S9EHkvaU4NaQ6
	 5N3AwDks3A1U75ya9XV8MkcVS5zM20RKrmoFO5SjlB1fqmI49by6dDyo/lOfVOJpH1
	 RuV5nk+5P5Ujs5L0JWwH1GFFeSc/McFT85x9Cisl+cZwCrJd/pG8V0iIeeuheOkVGA
	 FAy6sjAG3BIBdC+sEFEUGZY8RfXgX/N4S8JCrBsd0kci3gx1XWRMQC3EBENFuW9i6I
	 6z85us4HNnvv7Y3SQOsNz2t6xGJT06uVioBfknx/WeSJgpQpPXu6K3mmlb3dmJAcX+
	 ZednSHSEjJzQw==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id 6wDLqh7oxcyvu6wDLq41xC; Wed, 07 Jun 2023 16:40:51 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=6480b313
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=SFGEnkTAR_NGIzSk_2gA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Date: Wed,  7 Jun 2023 10:37:47 -0600
Message-Id: <0afbace57b9ee469eb12fba773ef1347f24a8802.1686095734.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
References: <cover.1686095734.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBThRinYSGFdNiLn+S2YGaBlR7yaXFGuhFtoNTRjGyILDlmLcC+uwcE27wuv8FwpaeuiUYDINPBE1VpEah/UNnxwu5KWozYLln/2L6756iny9dl4I0bk
 JYHMyZkI3KWI3/uClIpsb1OprcOADVRzRiddYNngwv9+4hTXX2TS6L1P71LYL0NNpNjAqOKnIpfqAG1Y2vtPXGxnb8ALoSPmd9UZxYO/NNrKNJVtU+/gkfgj
 1ymEMrcgmHVM6Z0W6yf8XKMskKoJvYBLoSRCoOz+LHc=
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/cygwin/fhandler/proc.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index 3c79762e0fbd..2eaf436dc122 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1486,12 +1486,12 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /*	  ftcprint (features1,  6, "split_lock_detect");*//* MSR_TEST_CTRL split lock */
 
-      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
-      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
-					 && wincap.build_number () >= 19041)
+      /* Windows [20]20H1/[20]2004/19041 user shadow stack */
+      if (maxf >= 0x00000007 && wincap.has_user_shstk)
         {
+	  /* cpuid 0x00000007 ecx CET shadow stack */
 	  cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
-	  ftcprint (features1,  7, "user_shstk");	/* "user shadow stack" */
+	  ftcprint (features1,  7, "user_shstk");	/* user shadow stack */
 	}
 
       /* cpuid 0x00000007:1 eax */
-- 
2.39.0

