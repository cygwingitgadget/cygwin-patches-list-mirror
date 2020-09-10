Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta26-sa.btinternet.com
 [213.120.69.32])
 by sourceware.org (Postfix) with ESMTPS id EE1953972028
 for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2020 12:27:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EE1953972028
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20200910122751.QEAO4114.sa-prd-fep-046.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Thu, 10 Sep 2020 13:27:51 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.141.128.138]
X-OWM-Source-IP: 86.141.128.138 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrudehjedggeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkeeirddugedurdduvdekrddufeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudeguddruddvkedrudefkedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.128.138) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE103B04B5; Thu, 10 Sep 2020 13:27:51 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: ldd: Also look for not found DLLs when exit status is
 non-zero
Date: Thu, 10 Sep 2020 13:27:40 +0100
Message-Id: <20200910122740.8534-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 10 Sep 2020 12:27:55 -0000

If the process exited with e.g. STATUS_DLL_NOT_FOUND, also process the
file to look for not found DLLs.

(We currently only do this when a STATUS_DLL_NOT_FOUND exception occurs,
which I haven't managed to observe)

This still isn't 100% correct, as it only examines the specified file
for missing DLLs, not recursively on the DLLs it depends upon.
---
 winsup/utils/ldd.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/utils/ldd.cc b/winsup/utils/ldd.cc
index e1af99e12..1e1863c1c 100644
--- a/winsup/utils/ldd.cc
+++ b/winsup/utils/ldd.cc
@@ -407,6 +407,8 @@ report (const char *in_fn, bool multiple)
 	  }
 	  break;
 	case EXIT_PROCESS_DEBUG_EVENT:
+	  if (ev.u.ExitProcess.dwExitCode != 0)
+	    process_fn = fn_win;
 print_and_exit:
 	  print_dlls (&dll_list, isdll ? fn_win : NULL, process_fn);
 	  exitnow = true;
-- 
2.28.0

