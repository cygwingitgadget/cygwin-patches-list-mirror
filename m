Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta26-re.btinternet.com [213.120.69.119])
	by sourceware.org (Postfix) with ESMTPS id 7E2753851A96
	for <cygwin-patches@cygwin.com>; Fri, 26 Aug 2022 13:00:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7E2753851A96
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20220826130002.WKJT3291.re-prd-fep-042.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 26 Aug 2022 14:00:02 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC2ADD0816
X-Originating-IP: [86.139.158.127]
X-OWM-Source-IP: 86.139.158.127 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrdduvdejpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.127) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC2ADD0816; Fri, 26 Aug 2022 14:00:02 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/6] Cygwin: testsuite: Don't write coredump in a child which is expected to segfault
Date: Fri, 26 Aug 2022 13:59:37 +0100
Message-Id: <20220826125943.49-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826125943.49-1-jon.turney@dronecode.org.uk>
References: <20220826125943.49-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/testsuite/winsup.api/resethand.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/testsuite/winsup.api/resethand.c b/winsup/testsuite/winsup.api/resethand.c
index 7d58dcd2c..4bd0fa072 100644
--- a/winsup/testsuite/winsup.api/resethand.c
+++ b/winsup/testsuite/winsup.api/resethand.c
@@ -15,6 +15,9 @@ ouch (int sig)
 int
 main (int argc, char **argv)
 {
+  static struct rlimit nocore = { 0,0 };
+  setrlimit(RLIMIT_CORE, &nocore);
+
   static struct sigaction act;
   if (argc == 1)
     act.sa_flags = SA_RESETHAND;
@@ -31,6 +34,6 @@ main (int argc, char **argv)
       exit (0x42);
     }
   status &= ~0x80;	// remove core dump flag
-  printf ("pid %d exited with status %p\n", pid, (void *) status);
+  printf ("pid %d exited with status %x\n", pid, status);
   exit (argc == 1 ? !(status == SIGSEGV) : !(status == SIGTERM));
 }
-- 
2.37.2

