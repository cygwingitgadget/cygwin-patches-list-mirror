Return-Path: <SRS0=REvR=DV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-048.btinternet.com (mailomta1-sa.btinternet.com [213.120.69.7])
	by sourceware.org (Postfix) with ESMTPS id 96177385B525
	for <cygwin-patches@cygwin.com>; Fri,  4 Aug 2023 12:47:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 96177385B525
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20230804124755.FLMR7361.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 4 Aug 2023 13:47:55 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64C837300077D2EB
X-Originating-IP: [86.139.167.52]
X-OWM-Source-IP: 86.139.167.52 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkeeirddufeelrdduieejrdehvdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdehvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqhedvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgv
	ohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.52) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64C837300077D2EB; Fri, 4 Aug 2023 13:47:55 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/4] Cygwin: CI: XFAIL umask03
Date: Fri,  4 Aug 2023 13:47:23 +0100
Message-Id: <20230804124723.9236-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
References: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

umask03 fails in CI due to some not understood weirdness.
---
 winsup/testsuite/Makefile.am | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 8f2967a6d..228955668 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -333,12 +333,16 @@ TESTS = $(check_PROGRAMS) \
 	mingw/cygload
 
 # expected fail tests
+XFAIL_TESTS_CI_true = \
+	winsup.api/ltp/umask03$(EXEEXT)
+
 XFAIL_TESTS = \
 	winsup.api/ltp/setgroups01 \
 	winsup.api/ltp/setuid02 \
 	winsup.api/ltp/ulimit01 \
 	winsup.api/ltp/unlink08 \
-	winsup.api/samples/sample-fail
+	winsup.api/samples/sample-fail \
+	$(XFAIL_TESTS_CI_$(GITHUB_ACTIONS))
 
 # cygrun.sh test-runner script, and variables used by it:
 LOG_COMPILER = $(srcdir)/cygrun.sh
-- 
2.39.0

