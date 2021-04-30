Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-043.btinternet.com (mailomta22-re.btinternet.com
 [213.120.69.115])
 by sourceware.org (Postfix) with ESMTPS id 10D4A385741B
 for <cygwin-patches@cygwin.com>; Fri, 30 Apr 2021 17:16:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 10D4A385741B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-043.btinternet.com with ESMTP id
 <20210430171610.NHJR3798.re-prd-fep-043.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Fri, 30 Apr 2021 18:16:10 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD030FE5306
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD030FE5306; Fri, 30 Apr 2021 18:16:10 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Ensure toollibdir exists before installing a link
 there
Date: Fri, 30 Apr 2021 18:14:55 +0100
Message-Id: <20210430171455.26156-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Fri, 30 Apr 2021 17:16:14 -0000

This helps 'make install -j2' work.
---
 winsup/cygwin/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index a2e673c13..8cde3f452 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -733,6 +733,7 @@ install-data-local: install-headers install-ldif
 install-libs:
 	@$(MKDIR_P) $(DESTDIR)$(bindir)
 	$(INSTALL_PROGRAM) $(TEST_DLL_NAME) $(DESTDIR)$(bindir)/$(DLL_NAME)
+	@$(MKDIR_P) $(DESTDIR)$(toollibdir)
 	(cd $(DESTDIR)$(toollibdir) && ln -sf $(LIB_NAME) libg.a)
 
 install-headers:
-- 
2.31.1

