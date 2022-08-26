Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta23-re.btinternet.com [213.120.69.116])
	by sourceware.org (Postfix) with ESMTPS id E6F4B385277A
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 13:00:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E6F4B385277A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20220826130007.EKOE3222.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 14:00:07 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC2ADD08BF
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD08BF; Fri, 26 Aug 2022 14:00:07 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/6] Cygwin: testsuite: Fix TEST_RETURN for 64-bit
Date: Fri, 26 Aug 2022 13:59:39 +0100
Message-Id: <20220826125943.49-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The result of a function call won't fit in an int if it's e.g. a pointer.
---
 winsup/testsuite/libltp/include/usctest.h | 6 +++---
 winsup/testsuite/libltp/lib/parse_opts.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/testsuite/libltp/include/usctest.h b/winsup/testsuite/libltp/include/usctest.h
index 6a095db1c..fef349d04 100644
--- a/winsup/testsuite/libltp/include/usctest.h
+++ b/winsup/testsuite/libltp/include/usctest.h
@@ -159,7 +159,7 @@ struct usc_errno_t {
  **********************************************************************/
 #ifdef  _USC_LIB_
 
-extern int TEST_RETURN;
+extern long TEST_RETURN;
 extern int TEST_ERRNO;
 
 #else
@@ -173,7 +173,7 @@ extern struct usc_errno_t TEST_VALID_ENO[USC_MAX_ERRNO];
  * Globals for returning the return code and errno from the system call
  * test macros.
  ***********************************************************************/
-extern int TEST_RETURN;
+extern long TEST_RETURN;
 extern int TEST_ERRNO;
 
 /***********************************************************************
@@ -210,7 +210,7 @@ extern void STD_opts_help();
  *	SCALL = system call and parameters to execute
  *
  ***********************************************************************/
-#define TEST(SCALL) TEST_RETURN = (unsigned) SCALL;  TEST_ERRNO=errno;
+#define TEST(SCALL) TEST_RETURN = SCALL;  TEST_ERRNO=errno;
 
 /***********************************************************************
  * TEST_VOID: calls a system call
diff --git a/winsup/testsuite/libltp/lib/parse_opts.c b/winsup/testsuite/libltp/lib/parse_opts.c
index 0282a0976..1f41bfdd2 100644
--- a/winsup/testsuite/libltp/lib/parse_opts.c
+++ b/winsup/testsuite/libltp/lib/parse_opts.c
@@ -110,7 +110,7 @@ struct usc_errno_t TEST_VALID_ENO[USC_MAX_ERRNO];
    * Globals for returning the return code and errno from the system call
    * test macros.
    ***********************************************************************/
-int TEST_RETURN;
+long TEST_RETURN;
 int TEST_ERRNO;
 
   /***********************************************************************
-- 
2.37.2

