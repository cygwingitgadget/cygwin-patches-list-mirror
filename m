Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta26-re.btinternet.com [213.120.69.119])
	by sourceware.org (Postfix) with ESMTPS id 7C05F3858428
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 13:00:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7C05F3858428
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20220826130004.LENA3069.re-prd-fep-049.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 14:00:04 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC2ADD085B
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD085B; Fri, 26 Aug 2022 14:00:04 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/6] Cygwin: testsuite: Remove passing tests from XFAIL list
Date: Fri, 26 Aug 2022 13:59:38 +0100
Message-Id: <20220826125943.49-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Remove ltp/fcntl05.c from XFAIL list, since it now PASSes.
Remove ltp/dup03.c from XFAIL list, since it now PASSes.
---
 winsup/testsuite/winsup.api/known_bugs.tcl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/testsuite/winsup.api/known_bugs.tcl b/winsup/testsuite/winsup.api/known_bugs.tcl
index e063ee6bb..4f13c90e0 100644
--- a/winsup/testsuite/winsup.api/known_bugs.tcl
+++ b/winsup/testsuite/winsup.api/known_bugs.tcl
@@ -1,4 +1,4 @@
-set xfail_list [list dup03 \
-    fcntl05 setgroups01 setuid02 \
+set xfail_list [list \
+    setgroups01 setuid02 \
     ulimit01 unlink08 \
     sample-fail sample-miscompile]
-- 
2.37.2

