Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta29-sa.btinternet.com
 [213.120.69.35])
 by sourceware.org (Postfix) with ESMTPS id 9605C3851C2F
 for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2020 19:48:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9605C3851C2F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20201105194808.GIKZ29142.sa-prd-fep-041.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 5 Nov 2020 19:48:08 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B66119336D0F
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B66119336D0F; Thu, 5 Nov 2020 19:48:08 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 02/11] Always configure in testsuite subdirectory
Date: Thu,  5 Nov 2020 19:47:39 +0000
Message-Id: <20201105194748.31282-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Thu, 05 Nov 2020 19:48:11 -0000

Doing this properly using AC_CONFIG_SUBDIRS is necessary to get the
correct paths in flags given to the compiler specified in CC/CXX.
---
 winsup/Makefile.in  | 16 +---------------
 winsup/configure.ac |  2 +-
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/winsup/Makefile.in b/winsup/Makefile.in
index f1c1ce771..ba6ed092c 100644
--- a/winsup/Makefile.in
+++ b/winsup/Makefile.in
@@ -94,22 +94,8 @@ Makefile: Makefile.in $(srcdir)/configure config.status
 config.status: configure
 	$(SHELL) config.status --recheck
 
-# The below rule is intended to run configure only when "make check" is
-# actually specified, i.e., not in a cross-compilation environment.  The
-# cygwin configuration is copied and modified to ensure that the same configuration
-# parameters are passed when the testsuite is configured as when cygwin was configured.
 check: cygwin
-	@if [ -f testsuite/config.status ]; then \
-	    cd testsuite; \
-	else \
-	    (mkdir testsuite 2>/dev/null || exit 0); \
-	    cd testsuite; \
-	    sed -e 's%winsup/cygwin\>%winsup/testsuite%g' ../cygwin/config.status > config.status; \
-	    chmod a+x config.status; \
-	    sh ./config.status --recheck; \
-	    sh ./config.status; \
-	fi; \
-	$(MAKE) check
+	$(MAKE) -C testsuite check
 
 utils: cygwin
 
diff --git a/winsup/configure.ac b/winsup/configure.ac
index 65369ae7f..5b420396d 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -29,7 +29,7 @@ AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
-AC_CONFIG_SUBDIRS(cygwin cygserver doc)
+AC_CONFIG_SUBDIRS(cygwin cygserver doc testsuite)
 if test "x$with_cross_bootstrap" != "xyes"; then
     AC_CONFIG_SUBDIRS([utils])
 fi
-- 
2.29.0

