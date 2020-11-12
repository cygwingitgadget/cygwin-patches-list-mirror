Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-040.btinternet.com (mailomta17-sa.btinternet.com
 [213.120.69.23])
 by sourceware.org (Postfix) with ESMTPS id C1C9A39FF072
 for <cygwin-patches@cygwin.com>; Thu, 12 Nov 2020 19:46:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C1C9A39FF072
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-040.btinternet.com with ESMTP id
 <20201112194653.DXQS29410.sa-prd-fep-040.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 12 Nov 2020 19:46:53 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B6611A29D1D4
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvfedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B6611A29D1D4; Thu, 12 Nov 2020 19:46:53 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/4] Testsuite Makefile cleanup
Date: Thu, 12 Nov 2020 19:46:28 +0000
Message-Id: <20201112194629.13493-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
References: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Thu, 12 Nov 2020 19:46:56 -0000

Drop unused variables CC_FOR_TARGET, GCC_INCLUDE, ALL_CFLAGS
Stop exporting CC, CFLAGS
Drop unused, empty targets force, dll_ofiles, all_target
---
 winsup/testsuite/Makefile.in | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index 4948a0bc7..d29112491 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -46,8 +46,6 @@ TESTSUP_INCLUDES:=-I$(libltp_srcdir)/include
 #
 
 CC:=@CC@
-# FIXME: Which is it, CC or CC_FOR_TARGET?
-CC_FOR_TARGET:=$(CC)
 ifneq (,$(CFLAGS))
   override CFLAGS+= -MD $(TESTSUP_INCLUDES)
 else
@@ -66,9 +64,6 @@ include $(srcdir)/../Makefile.common
 
 VPATH+=$(libltp_srcdir)/lib
 
-override CC:=$(CC) $(GCC_INCLUDE)
-export CC
-
 RUNTESTFLAGS =
 
 ifdef VERBOSE
@@ -80,20 +75,16 @@ RUNTIME=$(cygwin_build)/cygwin0.dll $(cygwin_build)/libcygwin0.a
 TESTSUP_LIB_NAME:=libltp.a
 TESTSUP_OFILES:=${sort ${addsuffix .o,${basename ${notdir ${wildcard $(libltp_srcdir)/lib/*.c}}}}}
 
-override ALL_CFLAGS:=${filter-out -O%,$(ALL_CFLAGS)}
 override COMPILE_CC:=${filter-out -O%,$(COMPILE_CC)}
 override CFLAGS:=${filter-out -O%,$(CFLAGS)}
-export CFLAGS
 
-.PHONY: all force dll_ofiles install all_target
+.PHONY: all install
 
 .SUFFIXES:
 .SUFFIXES: .c .cc .def .a .o .d
 
 all: $(TESTSUP_LIB_NAME)
 
-force:
-
 install:
 
 clean:
@@ -114,8 +105,6 @@ $(TESTSUP_LIB_NAME): $(TESTSUP_OFILES)
 $(RUNTIME) : $(cygwin_build)/Makefile
 	@$(MAKE) --no-print-dir -C $(@D) $(@F)
 
-# Rule to make stub library used by "make check"
-
 #
 
 # These targets are for the dejagnu testsuites. The file site.exp
@@ -147,7 +136,7 @@ site.exp: ./config.status Makefile
 	@echo "set target_alias $(target_alias)" >> ./tmp0
 	@echo "set CC \"$(CC)\"" >> ./tmp0
 # CFLAGS is set even though it's empty to show we reserve the right to set it.
-	@echo "set CFLAGS \"$(ALL_CFLAGS)\"" >> ./tmp0
+	@echo "set CFLAGS \"\"" >> ./tmp0
 	@echo "set MINGW_CXX \"$(MINGW_CXX)\"" >> ./tmp0
 	@echo "set tmpdir $(tmpdir)" >> ./tmp0
 	@echo "set testdll_tmpdir $(testdll_tmpdir)" >> ./tmp0
-- 
2.29.2

