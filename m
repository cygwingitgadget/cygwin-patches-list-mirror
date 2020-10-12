Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id 2698F3857C5B
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:30:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2698F3857C5B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20201012193023.CBHK4080.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:30:23 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC1588939E; Mon, 12 Oct 2020 20:30:23 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/8] Remove AC_ARG_PROGRAM/program_transform_name
Date: Mon, 12 Oct 2020 20:29:39 +0100
Message-Id: <20201012192943.15732-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
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
X-List-Received-Date: Mon, 12 Oct 2020 19:30:25 -0000

Not done consistently, and probably never used.
---
 winsup/cygwin/configure.ac  | 15 ---------------
 winsup/lsaauth/configure.ac |  2 --
 winsup/utils/Makefile.in    |  4 +---
 winsup/utils/configure.ac   |  2 --
 4 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index ac019c94e..757ebcfb0 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -67,21 +67,6 @@ no)	 ;;
 esac
 ])
 
-dnl The only time we might want to transform the install names
-dnl is for unix x cygwin.  Otherwise we don't.  For now we don't
-dnl transform names.
-
-dnl if test "x$cross_compiling" = "xno" -a ; then
-dnl   if test "x$program_transform_name" = "xs,x,x,"; then
-dnl     program_transform_name=""
-dnl   fi
-dnl   if test "x$program_transform_name" = "x"; then
-dnl     program_transform_name="s,^,$target_alias-,"
-dnl   else
-dnl     program_transform_name="$program_transform_name -e s,^,$target_alias-,"
-dnl   fi
-dnl fi
-
 case "$target_cpu" in
    i?86)
 		DLL_NAME="cygwin1.dll"
diff --git a/winsup/lsaauth/configure.ac b/winsup/lsaauth/configure.ac
index 995a0991d..f2b2c6329 100644
--- a/winsup/lsaauth/configure.ac
+++ b/winsup/lsaauth/configure.ac
@@ -32,8 +32,6 @@ esac
 AC_CHECK_PROGS(MINGW64_CC, x86_64-w64-mingw32-gcc)
 test -z "$MINGW64_CC" && AC_MSG_ERROR([no acceptable mingw64 cc found in \$PATH])
 
-AC_ARG_PROGRAM
-
 AC_PROG_INSTALL
 
 AC_CONFIG_FILES([Makefile cyglsa.def:cyglsa.din])
diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index 248939645..c3297c6c1 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -37,7 +37,6 @@ prefix:=@prefix@
 exec_prefix:=@exec_prefix@
 
 bindir:=@bindir@
-program_transform_name:=@program_transform_name@
 
 override INSTALL:=@INSTALL@
 override INSTALL_PROGRAM:=@INSTALL_PROGRAM@
@@ -176,8 +175,7 @@ realclean: clean
 install: all
 	/bin/mkdir -p ${DESTDIR}${bindir}
 	for i in $(CYGWIN_BINS) ${filter-out testsuite.exe,$(MINGW_BINS)} ; do \
-	  n=`echo $$i | sed '$(program_transform_name)'`; \
-	  $(INSTALL_PROGRAM) $$i $(DESTDIR)$(bindir)/$$n; \
+	  $(INSTALL_PROGRAM) $$i $(DESTDIR)$(bindir)/$$i; \
 	done
 
 $(cygwin_build)/libcygwin.a: $(cygwin_build)/Makefile
diff --git a/winsup/utils/configure.ac b/winsup/utils/configure.ac
index 63fc55e56..ce35f9c7b 100644
--- a/winsup/utils/configure.ac
+++ b/winsup/utils/configure.ac
@@ -28,8 +28,6 @@ AC_PROG_CXX
 
 AC_CYGWIN_INCLUDES
 
-AC_ARG_PROGRAM
-
 AC_PROG_INSTALL
 
 AC_CHECK_PROGS(MINGW_CXX, ${target_cpu}-w64-mingw32-g++)
-- 
2.28.0

