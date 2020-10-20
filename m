Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta11-sa.btinternet.com
 [213.120.69.17])
 by sourceware.org (Postfix) with ESMTPS id EDEF939450F4
 for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2020 13:43:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EDEF939450F4
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201020134341.MMK4272.sa-prd-fep-046.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 20 Oct 2020 14:43:41 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE16F22D1B; Tue, 20 Oct 2020 14:43:41 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/6] Drop do-nothing install_target target
Date: Tue, 20 Oct 2020 14:43:04 +0100
Message-Id: <20201020134304.11281-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1201.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Tue, 20 Oct 2020 13:43:43 -0000

---
 winsup/cygwin/Makefile.in    | 7 ++-----
 winsup/testsuite/Makefile.in | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 33ee17d1e..19dea4661 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -569,7 +569,7 @@ exec_CFLAGS:=-fno-builtin-execve
 fhandler_proc_CFLAGS+=-DUSERNAME="\"$(USER)\"" -DHOSTNAME="\"$(HOSTNAME)\""
 fhandler_proc_CFLAGS+=-DGCC_VERSION="\"`$(CC) -v 2>&1 | tail -n 1`\""
 
-.PHONY: all force dll_ofiles install all_target install_target all_host \
+.PHONY: all force dll_ofiles install all_target all_host \
 	install install-libs install-headers \
 	clean distclean realclean maintainer-clean
 
@@ -583,8 +583,7 @@ all_host: $(TEST_LIB_NAME)
 
 force:
 
-install: install-libs install-headers install-man install-ldif install_target \
-	$(install_target)
+install: install-libs install-headers install-man install-ldif
 
 uninstall: uninstall-libs uninstall-headers uninstall-man
 
@@ -625,8 +624,6 @@ install-ldif:
 	@$(MKDIRP) $(DESTDIR)$(datarootdir)/cygwin
 	$(INSTALL_DATA) $(srcdir)/cygwin.ldif $(DESTDIR)$(datarootdir)/cygwin
 
-install_target:
-
 uninstall-libs: $(TARGET_LIBS)
 	rm -f $(bindir)/$(DLL_NAME); \
 	for i in $^; do \
diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index 050d5b164..1b0d0de59 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -82,7 +82,7 @@ override COMPILE_CC:=${filter-out -O%,$(COMPILE_CC)}
 override CFLAGS:=${filter-out -O%,$(CFLAGS)}
 export CFLAGS
 
-.PHONY: all force dll_ofiles install all_target install_target
+.PHONY: all force dll_ofiles install all_target
 
 .SUFFIXES:
 .SUFFIXES: .c .cc .def .a .o .d
-- 
2.28.0

