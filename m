Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta27-sa.btinternet.com
 [213.120.69.33])
 by sourceware.org (Postfix) with ESMTPS id 715FC39F501E
 for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2020 19:48:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 715FC39F501E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20201105194828.YFQI28522.sa-prd-fep-047.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 5 Nov 2020 19:48:28 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B66119336ECB
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B66119336ECB; Thu, 5 Nov 2020 19:48:28 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 10/11] Set PATH for tests to pick up cygwin0.dll
Date: Thu,  5 Nov 2020 19:47:47 +0000
Message-Id: <20201105194748.31282-11-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 05 Nov 2020 19:48:30 -0000

Set the PATH so that tests can pick up cygwin0.dll.  Looks like this was
dropped by accident in 2e488e95 ("Don't rely on in-build tools"), so
restore it as it was prior to 9d89f634.
---
 winsup/testsuite/Makefile.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index a9388ef6a..b77961878 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -162,6 +162,8 @@ testsuite/site.exp: site.exp
 # Note: we set the PATH so that we can pick up cygwin0.dll
 
 check: $(TESTSUP_LIB_NAME) $(RUNTIME) cygrun.exe testsuite/site.exp
+	rootme=`pwd` ;\
+	PATH=$$rootme/../cygwin:$${PATH} ;\
 	cd testsuite; runtest --tool winsup $(RUNTESTFLAGS)
 
 cygrun.o: cygrun.c
-- 
2.29.0

