Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta29-sa.btinternet.com
 [213.120.69.35])
 by sourceware.org (Postfix) with ESMTPS id 4D6923857C62
 for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2020 13:43:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4D6923857C62
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201020134338.MMC4272.sa-prd-fep-046.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 20 Oct 2020 14:43:38 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE16F22C98; Tue, 20 Oct 2020 14:43:38 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/6] Drop do-nothing install_host target
Date: Tue, 20 Oct 2020 14:43:03 +0100
Message-Id: <20201020134304.11281-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Tue, 20 Oct 2020 13:43:41 -0000

Drop do-nothing install_host target, which is only used when not
cross-compiling.
---
 winsup/cygserver/configure.ac | 3 ---
 winsup/cygwin/Makefile.in     | 7 ++-----
 winsup/cygwin/configure.ac    | 3 ---
 winsup/testsuite/Makefile.in  | 4 +---
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index 9a6baceb7..4ff784e47 100644
--- a/winsup/cygserver/configure.ac
+++ b/winsup/cygserver/configure.ac
@@ -30,16 +30,13 @@ AC_CYGWIN_INCLUDES
 case "$with_cross_host" in
   ""|*cygwin*)
     all_host="all_host"
-    install_host="install_host"
     ;;
   *)
     all_host=
-    install_host=
     ;;
 esac
 
 AC_SUBST(all_host)
-AC_SUBST(install_host)
 
 AC_CHECK_TOOL(AR, ar, ar)
 AC_CHECK_TOOL(AS, as, as)
diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 0dca13fab..33ee17d1e 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -570,11 +570,10 @@ fhandler_proc_CFLAGS+=-DUSERNAME="\"$(USER)\"" -DHOSTNAME="\"$(HOSTNAME)\""
 fhandler_proc_CFLAGS+=-DGCC_VERSION="\"`$(CC) -v 2>&1 | tail -n 1`\""
 
 .PHONY: all force dll_ofiles install all_target install_target all_host \
-	install_host install install-libs install-headers \
+	install install-libs install-headers \
 	clean distclean realclean maintainer-clean
 
 all_host=@all_host@
-install_host=@install_host@
 
 all: all_target $(all_host)
 
@@ -585,7 +584,7 @@ all_host: $(TEST_LIB_NAME)
 force:
 
 install: install-libs install-headers install-man install-ldif install_target \
-	$(install_host) $(install_target)
+	$(install_target)
 
 uninstall: uninstall-libs uninstall-headers uninstall-man
 
@@ -628,8 +627,6 @@ install-ldif:
 
 install_target:
 
-install_host:
-
 uninstall-libs: $(TARGET_LIBS)
 	rm -f $(bindir)/$(DLL_NAME); \
 	for i in $^; do \
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index 0e9df29bb..aafc4d925 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -32,16 +32,13 @@ AC_CYGWIN_INCLUDES
 case "$with_cross_host" in
   ""|*cygwin*)
     all_host="all_host"
-    install_host="install_host"
     ;;
   *)
     all_host=
-    install_host=
     ;;
 esac
 
 AC_SUBST(all_host)
-AC_SUBST(install_host)
 
 AC_CHECK_TOOL(AR, ar, ar)
 AC_CHECK_TOOL(AS, as, as)
diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index a86a35b88..050d5b164 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -82,7 +82,7 @@ override COMPILE_CC:=${filter-out -O%,$(COMPILE_CC)}
 override CFLAGS:=${filter-out -O%,$(CFLAGS)}
 export CFLAGS
 
-.PHONY: all force dll_ofiles install all_target install_target install_host
+.PHONY: all force dll_ofiles install all_target install_target
 
 .SUFFIXES:
 .SUFFIXES: .c .cc .def .a .o .d
@@ -93,8 +93,6 @@ force:
 
 install:
 
-install_host:
-
 clean:
 	-rm -f *.o *.dll *.a *.exp junk *.bak *.base *.exe testsuite/* *.d *.dat
 
-- 
2.28.0

