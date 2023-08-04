Return-Path: <SRS0=REvR=DV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-041.btinternet.com (mailomta1-sa.btinternet.com [213.120.69.7])
	by sourceware.org (Postfix) with ESMTPS id 69A123857020
	for <cygwin-patches@cygwin.com>; Fri,  4 Aug 2023 12:47:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 69A123857020
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-041.btinternet.com with ESMTP
          id <20230804124747.KQEZ7232.sa-prd-fep-041.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 4 Aug 2023 13:47:47 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64C837300077D227
X-Originating-IP: [86.139.167.52]
X-OWM-Source-IP: 86.139.167.52 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkeeirddufeelrdduieejrdehvdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdehvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqhedvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgv
	ohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.52) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64C837300077D227; Fri, 4 Aug 2023 13:47:47 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/4] Cygwin: testsuite: Update README
Date: Fri,  4 Aug 2023 13:47:21 +0100
Message-Id: <20230804124723.9236-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
References: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v2:
Polish instructions on adding a test

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/testsuite/README | 82 +++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/winsup/testsuite/README b/winsup/testsuite/README
index ff2df4119..511133e4d 100644
--- a/winsup/testsuite/README
+++ b/winsup/testsuite/README
@@ -1,35 +1,69 @@
-Here are some notes about adding and using this testsuite.
+Here are some notes about adding to and using this testsuite.
 
-The testsuite adds a directory containing the just built cygwin1.dll to the PATH
-(during the run step) so that it can be found by the Windows loader during
-testing.
+The testsuite adds a directory containing the just-built cygwin1.dll to the PATH
+so that it can be found by the Windows loader during testing.
 
-Because we'll probably run into complaints about using two DLLs, we
-run cygrun.exe for each test.  All this does is run the test with
-CreateProcess() so that we don't attempt to do the special code for
-when a cygwin program calls another cygwin program, as this might be a
-"multiple cygwins" problem.
+Because we'll probably run into complaints about using two DLLs, we use
+cygrun.exe to run each test.  All this does is run the test with CreateProcess()
+so that we don't attempt to do the special code for when a cygwin program calls
+another cygwin program, as this might be a "multiple cygwins" problem.
 
-Any test that needs to test command line args or redirection needs to
-run such a child program itself, as the testsuite will not do any
-arguments or redirection for it.  Same for fork, signals, etc.
+The testsuite/winsup.api subdirectory is for testing the API to cygwin1.dll
+ONLY.  Create other subdirs under testsuite/ for other classes of testing.
 
-The testsuite/winsup.api subdirectory is for testing the API to
-cygwin1.dll ONLY.  Create other subdirs under testsuite/ for other
-classes of testing.
+Tests in testsuite/winsup.api/pthread/ are derived from the pthread-win32
+testsuite.
 
-Tests under winsup.api/ either run successfully and exit(0), exit(77) to
-indicate a skipped test, or any other exit status to indicate a failure.
+Tests in testsuite/winsup.api/ltp/ are derived from (a very old version of) the
+ltp testsuite.
 
 Don't print anything to the screen if you can avoid it (except for failure
-reasons, of course).  One .c file per test, no compile options are allowed
-(we're testing the api, not the compiler).
+reasons, of course).
 
-Tests whose filename is mentioned in XFAIL_TESTS are expected to fail,
-effectively reversing the result of those.
+"make check" will only work if you run it *on* an NT machine.  Cross-checking is
+not supported.
 
-"make check" will only work if you run it *on* an NT machine.
-Cross-checking is not supported.
+Tests whose name is mentioned in XFAIL_TESTS are expected to fail, effectively
+reversing the result of those.
+
+Adding a test
+=============
+
+Add the source for the test under testsuite/winsup.api/.
+
+Add the additional tests program to check_PROGRAMS in testsuite/Makefile.am.
+
+(Note that if the test 'foo' has a single source file, foo.c, there's no need to
+write a foo_SOURCES as that's the default Automake assumes.)
+
+Tests can use libltp, but's that not required.
+
+The Cygwin 'installation' that the tests are run in is minimal, so don't assume
+anything is present.
+
+Any test that needs to test command line args or redirection needs to run such a
+child program itself, as the testsuite will not do any arguments or redirection
+for it.  Same for fork, signals, etc.
+
+Tests should either run successfully and exit(0), exit(77) to indicate a skipped
+test, or any other exit status to indicate a failure.
+
+Tips
+====
+
+* To run selected tests, use e.g:
 
-To run selected tests, use e.g:
 $ make check TESTS="winsup.api/ltp/umask03 winsup.api/ltp/stat06"
+
+* To build the tests without running them, use the check_programs target, e.g:
+
+$ make -C winsup/testsuite/ check_programs
+
+* To run an individual test program directly (against the installed, rather than
+  just built DLL), e.g.:
+
+$ winsup/testsuite/winsup.api/pthread/cancel1
+
+* To run an individual test program against the test DLL under gdb, e.g.:
+
+$ PATH="<build_tooldir>/winsup/testsuite/testinst/bin/:$PATH" cygrun -notimeout "gdb winsup.api/systemcall"
-- 
2.39.0

