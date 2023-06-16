Return-Path: <SRS0=2n0R=CE=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 5F3CD3858D35
	for <cygwin-patches@cygwin.com>; Fri, 16 Jun 2023 17:20:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5F3CD3858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id A96vqzKrc6NwhAD7PqzCnw; Fri, 16 Jun 2023 17:20:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1686936015; bh=E6Fd10+IzM0mVNzJgfMGz/Jv3SsVS3YhDehNX6oVjd4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=jChA7BO/ehp+uZ/tREAvmWu4wFsy4FX9KqbOAHyEOR/jdNfP2Gf5++UmuFVq9AKLR
	 6GJ5zudDcGt+to/DMchxWW8dbnbXNE/AGZxXBXM/e5WoaZyz0SMOYTepOzpwgAgoir
	 jFxcTim1kcvfM7DRco8otA7VRstDESQKLSwm20+FQVPiGJUt7FoebuYWmxI/8AKfsd
	 JEE2sjmysC5f43XpPW/1xoXv8ngQCYiBeVI+Ke/MmoRv+7+52AGNXQxyoYMNcrqh2d
	 oqzCrcp96WP8X0yuEYxAt66w7w7wjK/VCN7Xs6nL1BQM7VtBA6wEqkyYaJ5oUqu1Z/
	 iTPoTb8YK2CRg==
Received: from BWINGLISD.cg.shawcable.net. ([184.64.102.149])
	by cmsmtp with ESMTP
	id AD7OqnqXXHFsOAD7OqoQ6m; Fri, 16 Jun 2023 17:20:15 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=648c99cf
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17 a=_Dj-zB-qAAAA:8
 a=SFGEnkTAR_NGIzSk_2gA:9
From: Brian Inglis <Brian.Inglis@Shaw.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 3/3] fhandler/proc.cc: use wincap.has_user_shstk
Date: Fri, 16 Jun 2023 11:17:10 -0600
Message-Id: <336c97a31de9e273e5ace0badeb6312d10da4ebb.1686934097.git.Brian.Inglis@Shaw.ca>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
References: <cover.1686934096.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPPBGCuC/N+42x7ylbEF24oktk6tBm/DlbcapoW3CRUPudninWEYFqDpO5lbp9jYkUraZqTMIM5fOvBpQbT58yT+6PSYb/ynm6x3/myT0b+OdZ4v0Jz9
 oPvvX4lqpYzKIB2qQbLThOCJkUANnXHQOoSG7AlLb0j9TYH4GCTEk7QeR1EJPpDbboOi3b88Hu3mm2Mg1cGptTp8iC+SEahwik2DT33TI1R1CxHrrG+gauLY
 SFYwY4MRGzKD5mJqalW1arH/BAmD+ghaK2qs6LYc82w=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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

