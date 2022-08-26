Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta1-re.btinternet.com [213.120.69.94])
	by sourceware.org (Postfix) with ESMTPS id 1A1643851163
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 13:00:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1A1643851163
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20220826130010.VXWG3219.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 14:00:10 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC2ADD08F2
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD08F2; Fri, 26 Aug 2022 14:00:10 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/6] Cygwin: testsuite: Fix size of write to temporary file to be mmap()ed
Date: Fri, 26 Aug 2022 13:59:40 +0100
Message-Id: <20220826125943.49-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

See ltp commit 91361378
---
 winsup/testsuite/winsup.api/ltp/mmap02.c | 2 +-
 winsup/testsuite/winsup.api/ltp/mmap03.c | 2 +-
 winsup/testsuite/winsup.api/ltp/mmap04.c | 2 +-
 winsup/testsuite/winsup.api/ltp/mmap05.c | 3 +--
 winsup/testsuite/winsup.api/ltp/mmap06.c | 2 +-
 winsup/testsuite/winsup.api/ltp/mmap07.c | 2 +-
 6 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/winsup/testsuite/winsup.api/ltp/mmap02.c b/winsup/testsuite/winsup.api/ltp/mmap02.c
index 33a12738c..b96bdb452 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap02.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap02.c
@@ -225,7 +225,7 @@ setup()
 	}
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, sizeof(tst_buff)) < (int)sizeof(tst_buff)) {
+	if (write(fildes, tst_buff, page_sz) < page_sz) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
diff --git a/winsup/testsuite/winsup.api/ltp/mmap03.c b/winsup/testsuite/winsup.api/ltp/mmap03.c
index 9302d335d..fba512c28 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap03.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap03.c
@@ -225,7 +225,7 @@ setup()
 	}
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
+	if (write(fildes, tst_buff, page_sz) < page_sz) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
diff --git a/winsup/testsuite/winsup.api/ltp/mmap04.c b/winsup/testsuite/winsup.api/ltp/mmap04.c
index 64d3a8ebe..dbe25aefd 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap04.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap04.c
@@ -225,7 +225,7 @@ setup()
 	}
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
+	if (write(fildes, tst_buff, page_sz) < page_sz) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
diff --git a/winsup/testsuite/winsup.api/ltp/mmap05.c b/winsup/testsuite/winsup.api/ltp/mmap05.c
index bcdfd0cd8..6e75ee222 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap05.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap05.c
@@ -228,8 +228,7 @@ setup()
 	}
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff))
-	    != (int)strlen(tst_buff)) {
+	if (write(fildes, tst_buff, page_sz) != page_sz) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
diff --git a/winsup/testsuite/winsup.api/ltp/mmap06.c b/winsup/testsuite/winsup.api/ltp/mmap06.c
index ec113c077..c099f8c33 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap06.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap06.c
@@ -197,7 +197,7 @@ setup()
 	}
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
+	if (write(fildes, tst_buff, page_sz) < page_sz) {
 		tst_brkm(TFAIL, NULL,
 			 "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
diff --git a/winsup/testsuite/winsup.api/ltp/mmap07.c b/winsup/testsuite/winsup.api/ltp/mmap07.c
index ab989f443..6e3bb5112 100644
--- a/winsup/testsuite/winsup.api/ltp/mmap07.c
+++ b/winsup/testsuite/winsup.api/ltp/mmap07.c
@@ -198,7 +198,7 @@ setup()
 	}
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, strlen(tst_buff)) < (int)strlen(tst_buff)) {
+	if (write(fildes, tst_buff, page_sz) < page_sz) {
 		tst_brkm(TFAIL, NULL, "write() on %s Failed, errno=%d : %s",
 			 TEMPFILE, errno, strerror(errno));
 		free(tst_buff);
-- 
2.37.2

