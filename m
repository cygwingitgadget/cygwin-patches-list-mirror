Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-044.btinternet.com (mailomta4-re.btinternet.com [213.120.69.97])
	by sourceware.org (Postfix) with ESMTPS id 39096385086C
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 13:00:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 39096385086C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20220826130012.GNT3224.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 14:00:12 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC2ADD0952
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD0952; Fri, 26 Aug 2022 14:00:12 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/6] Cygwin: testsuite: In pathconf01 use the temporary directory instead of "/tmp"
Date: Fri, 26 Aug 2022 13:59:41 +0100
Message-Id: <20220826125943.49-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In pathconf01 use the temporary directory, instead of "/tmp" (which may not exist).
---
 winsup/testsuite/winsup.api/ltp/pathconf01.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/winsup/testsuite/winsup.api/ltp/pathconf01.c b/winsup/testsuite/winsup.api/ltp/pathconf01.c
index 466875f21..990e6defe 100644
--- a/winsup/testsuite/winsup.api/ltp/pathconf01.c
+++ b/winsup/testsuite/winsup.api/ltp/pathconf01.c
@@ -117,6 +117,7 @@
 
 extern void setup();
 extern void cleanup();
+extern char *TESTDIR;
 
 
 
@@ -127,7 +128,7 @@ extern int Tst_count;		/* Test Case counter for tst_* routines */
 int exp_enos[]={0, 0};
 
 int i;
-const char *path = "/tmp";
+const char *path;
 
 struct pathconf_args
 {
@@ -157,6 +158,9 @@ main(int ac, char **av)
     if ( (msg=parse_opts(ac, av, (option_t *) NULL, NULL)) != (char *) NULL )
 	tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
 
+    tst_tmpdir();
+    path = TESTDIR;
+
     /***************************************************************
      * perform global setup for test
      ***************************************************************/
@@ -208,6 +212,8 @@ main(int ac, char **av)
     /***************************************************************
      * cleanup and exit
      ***************************************************************/
+    tst_rmdir();
+
     cleanup();
 
     return 0;
-- 
2.37.2

