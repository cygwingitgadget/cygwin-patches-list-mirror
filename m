Return-Path: <SRS0=xEb7=4T=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-049.btinternet.com (mailomta18-sa.btinternet.com [213.120.69.24])
	by sourceware.org (Postfix) with ESMTPS id 4DE5E3858D1E
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 13:49:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4DE5E3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20221221134923.YFJR6602.sa-prd-fep-049.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 21 Dec 2022 13:49:23 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 62E573CC16121320
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 62E573CC16121320; Wed, 21 Dec 2022 13:49:23 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Makefile: Build new DLL with the name 'cygwin0.dll'
Date: Wed, 21 Dec 2022 13:49:07 +0000
Message-Id: <20221221134907.40359-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Build the new DLL with the name 'cygwin0.dll', rather than
'new-cygwin1.dll', as that's what the testsuite expects.

It still gets installed with the name 'cygwin1.dll'.

Fixes: 90236c3a2cf6 ("Cygwin: Makefile: build new-cygwin1.dll in a single step")
---
 winsup/cygwin/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 0200f6e2a..96c1dc491 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -40,7 +40,7 @@ toolincludedir=$(tooldir)/include
 # Parameters used in building the cygwin.dll.
 
 DLL_NAME=cygwin1.dll
-NEW_DLL_NAME=new-cygwin1.dll
+NEW_DLL_NAME=cygwin0.dll
 DEF_FILE=cygwin.def
 LIB_NAME=libcygwin.a
 TEST_LIB_NAME=libcygwin0.a
-- 
2.39.0

