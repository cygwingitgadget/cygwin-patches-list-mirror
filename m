Return-Path: <SRS0=xEb7=4T=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-043.btinternet.com (mailomta20-re.btinternet.com [213.120.69.113])
	by sourceware.org (Postfix) with ESMTPS id AE27A3858D1E
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 15:58:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AE27A3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20221221155836.WLYR21016.re-prd-fep-043.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 21 Dec 2022 15:58:36 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613A912447EB8535
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrgeekgdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613A912447EB8535; Wed, 21 Dec 2022 15:58:36 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Makefile: Also make 'cygwin0.dll'
Date: Wed, 21 Dec 2022 15:58:16 +0000
Message-Id: <20221221155816.42959-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221134907.40359-1-jon.turney@dronecode.org.uk>
References: <20221221134907.40359-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hard-link the new DLL with the name 'cygwin0.dll', as that's what the
testsuite expects. (Must be a hardlink as the Windows loader needs to be
able to traverse the link).

Fixes: 90236c3a2cf6 ("Cygwin: Makefile: build new-cygwin1.dll in a single step")
---
 winsup/cygwin/Makefile.am | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 0200f6e2a..5ea962ccd 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -41,6 +41,7 @@ toolincludedir=$(tooldir)/include
 
 DLL_NAME=cygwin1.dll
 NEW_DLL_NAME=new-cygwin1.dll
+TEST_DLL_NAME=cygwin0.dll
 DEF_FILE=cygwin.def
 LIB_NAME=libcygwin.a
 TEST_LIB_NAME=libcygwin0.a
@@ -622,6 +623,9 @@ $(LIB_NAME): $(DEF_FILE) $(LIBCOS) | $(NEW_DLL_NAME)
 $(TEST_LIB_NAME): $(LIB_NAME)
 	$(AM_V_GEN)perl -p -e 'BEGIN{binmode(STDIN); binmode(STDOUT);}; s/cygwin1/cygwin0/g' < $? > $@
 
+$(TEST_DLL_NAME): $(NEW_DLL_NAME)
+	$(AM_V_GEN)ln -f $(NEW_DLL_NAME) $(TEST_DLL_NAME)
+
 # sublibs
 # import libraries for some subset of symbols indicated by given objects
 speclib=\
@@ -664,7 +668,7 @@ libssp.a: $(LIB_NAME) $(wildcard $(newlib_build)/libc/ssp/*.o)
 # all
 #
 
-all-local: $(LIB_NAME) $(TEST_LIB_NAME) $(SUBLIBS)
+all-local: $(LIB_NAME) $(TEST_LIB_NAME) $(TEST_DLL_NAME) $(SUBLIBS)
 
 #
 # clean
-- 
2.39.0

