Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta21-sa.btinternet.com [213.120.69.27])
	by sourceware.org (Postfix) with ESMTPS id 4AA903858D35
	for <cygwin-patches@cygwin.com>; Thu,  3 Nov 2022 17:04:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4AA903858D35
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20221103170445.NKAO3231.sa-prd-fep-042.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Thu, 3 Nov 2022 17:04:45 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6139417C419FD868
X-Originating-IP: [81.153.98.206]
X-OWM-Source-IP: 81.153.98.206 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeegjeeuuddtvefhgeefkefhheejgefhieduieeltdejieefveeljeekgedvgefggeenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdgthihgfihinhdrtghomhenucfkphepkedurdduheefrdelkedrvddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvddtiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.206) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 6139417C419FD868; Thu, 3 Nov 2022 17:04:45 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Date: Thu,  3 Nov 2022 17:04:30 +0000
Message-Id: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1196.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

gdb supports 'set disable-randomization off' on Windows since [1]
(included in gdb 13).

https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=bcb9251f029da8dcf360a4f5acfa3b4211c87bb0;hp=8fea1a81c7d9279a6f91e49ebacfb61e0f8ce008
---
 winsup/doc/faq-programming.xml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 7945b6b88..41cd5e423 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -844,6 +844,12 @@ Guide here: <ulink url="https://cygwin.com/cygwin-ug-net/dll.html"/>.
   Note that the DllMain entrypoints for linked DLLs will have been executed
   before this breakpoint is hit.
 </para>
+
+<para>
+  (It may be necessary to use the <command>gdb</command> command <command>set
+  disable-randomization off</command> to turn off ASLR for the debugee to
+  prevent the base address getting randomized.)
+</para>
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.debug">
-- 
2.38.1

