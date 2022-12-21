Return-Path: <SRS0=xEb7=4T=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-046.btinternet.com (mailomta7-re.btinternet.com [213.120.69.100])
	by sourceware.org (Postfix) with ESMTPS id 1834F385802F
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 16:18:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1834F385802F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20221221161856.MBMU7994.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Wed, 21 Dec 2022 16:18:56 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A8CC347ECE37D
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A8CC347ECE37D; Wed, 21 Dec 2022 16:18:55 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Makefile: Drop all the "test dll" considerations
Date: Wed, 21 Dec 2022 16:18:34 +0000
Message-Id: <20221221161834.45553-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221134907.40359-1-jon.turney@dronecode.org.uk>
References: <20221221134907.40359-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After 90236c3a2cf6, the testsuite is failing, as the cygwin0.dll that
the implib testsuite programs are linked with references doesn't exist
anymore.

We don't need to make and link with a specially named DLL, as the cygwin
DLL (for a long time now) takes into consideration the path it's
executing from to define separate "cygwin installations", which don't
interact.

Fixes: 90236c3a2cf6 ("Cygwin: Makefile: build new-cygwin1.dll in a single step")
---
 winsup/cygwin/Makefile.am              | 9 ++-------
 winsup/testsuite/winsup.api/winsup.exp | 2 +-
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 0200f6e2a..2faa867f9 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -43,7 +43,6 @@ DLL_NAME=cygwin1.dll
 NEW_DLL_NAME=new-cygwin1.dll
 DEF_FILE=cygwin.def
 LIB_NAME=libcygwin.a
-TEST_LIB_NAME=libcygwin0.a
 
 #
 # sources
@@ -618,10 +617,6 @@ LIBCOS=$(addsuffix .o,$(basename $(LIB_FILES)))
 $(LIB_NAME): $(DEF_FILE) $(LIBCOS) | $(NEW_DLL_NAME)
 	$(AM_V_GEN)$(srcdir)/scripts/mkimport $(toolopts) $(NEW_FUNCTIONS) $@ cygdll.a $(wordlist 2,99,$^)
 
-# cygwin import library used by testsuite
-$(TEST_LIB_NAME): $(LIB_NAME)
-	$(AM_V_GEN)perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g' < $? > $@
-
 # sublibs
 # import libraries for some subset of symbols indicated by given objects
 speclib=\
@@ -664,7 +659,7 @@ libssp.a: $(LIB_NAME) $(wildcard $(newlib_build)/libc/ssp/*.o)
 # all
 #
 
-all-local: $(LIB_NAME) $(TEST_LIB_NAME) $(SUBLIBS)
+all-local: $(LIB_NAME) $(SUBLIBS)
 
 #
 # clean
@@ -675,7 +670,7 @@ clean-local:
 	-rm -f $(DEF_FILE) sigfe.s
 	-rm -f cygwin.sc cygdll.a cygwin.map
 	-rm -f $(NEW_DLL_NAME)
-	-rm -f $(LIB_NAME) $(TEST_LIB_NAME) $(SUBLIBS)
+	-rm -f $(LIB_NAME) $(SUBLIBS)
 	-rm -f version.cc
 	-rm -f tlsoffsets
 
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index 584aa5755..f755c82d9 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -61,7 +61,7 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
     if [ file exists "$srcdir/$subdir/$basename.exp" ] then {
 	source "$srcdir/$subdir/$basename.exp"
     } else {
-	ws_spawn "$CC -nodefaultlibs -mwin32 $CFLAGS $src $add_includes $add_libs $runtime_root/binmode.o -lgcc $runtime_root/libcygwin0.a -lkernel32 -luser32 -o $base.exe"
+	ws_spawn "$CC -nodefaultlibs -mwin32 $CFLAGS $src $add_includes $add_libs $runtime_root/binmode.o -lgcc $runtime_root/libcygwin.a -lkernel32 -luser32 -o $base.exe"
 	if { $rv } {
 	    fail "$testcase (compile)"
 	} else {
-- 
2.39.0

