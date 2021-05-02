Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta20-re.btinternet.com
 [213.120.69.113])
 by sourceware.org (Postfix) with ESMTPS id AC6733894C2E
 for <cygwin-patches@cygwin.com>; Sun,  2 May 2021 15:27:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org AC6733894C2E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20210502152702.CUOM21941.re-prd-fep-046.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sun, 2 May 2021 16:27:02 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C0CC313CE5E9
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdefuddgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC313CE5E9; Sun, 2 May 2021 16:27:02 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Move source files used in utils/mingw/ into that
 subdirectory
Date: Sun,  2 May 2021 16:25:36 +0100
Message-Id: <20210502152537.32312-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sun, 02 May 2021 15:27:05 -0000

Move all the source files used in utils/mingw/ into that subdirectory,
so the built objects are in the expected place.

(path.cc requires some more unpicking, and even then there is genuinely
some shared code, so use a trivial file which includes the real path.cc
so the object file is generated where expected)
---
 winsup/utils/mingw/Makefile.am                | 23 +++++++++++--------
 winsup/utils/{ => mingw}/bloda.cc             |  0
 winsup/utils/{ => mingw}/cygcheck.cc          |  0
 .../{ => mingw}/cygwin-console-helper.cc      |  0
 winsup/utils/{ => mingw}/dump_setup.cc        |  0
 winsup/utils/{ => mingw}/ldh.cc               |  0
 winsup/utils/mingw/path.cc                    |  1 +
 winsup/utils/{ => mingw}/strace.cc            | 10 ++++----
 winsup/utils/{ => mingw}/testsuite.cc         |  0
 winsup/utils/{ => mingw}/testsuite.h          |  0
 10 files changed, 19 insertions(+), 15 deletions(-)
 rename winsup/utils/{ => mingw}/bloda.cc (100%)
 rename winsup/utils/{ => mingw}/cygcheck.cc (100%)
 rename winsup/utils/{ => mingw}/cygwin-console-helper.cc (100%)
 rename winsup/utils/{ => mingw}/dump_setup.cc (100%)
 rename winsup/utils/{ => mingw}/ldh.cc (100%)
 create mode 100644 winsup/utils/mingw/path.cc
 rename winsup/utils/{ => mingw}/strace.cc (99%)
 rename winsup/utils/{ => mingw}/testsuite.cc (100%)
 rename winsup/utils/{ => mingw}/testsuite.h (100%)

diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
index a14725902..73abc4264 100644
--- a/winsup/utils/mingw/Makefile.am
+++ b/winsup/utils/mingw/Makefile.am
@@ -25,26 +25,29 @@ bin_PROGRAMS = \
 	strace
 
 cygcheck_SOURCES = \
-	../bloda.cc \
-	../cygcheck.cc \
-	../dump_setup.cc \
-	../path.cc
+	bloda.cc \
+	cygcheck.cc \
+	dump_setup.cc \
+	path.cc
+cygcheck_CPPFLAGS=-I$(srcdir)/..
 cygcheck_LDADD = -lz -lwininet -lpsapi -lntdll
 
-cygwin_console_helper_SOURCES = ../cygwin-console-helper.cc
+cygwin_console_helper_SOURCES = cygwin-console-helper.cc
 
-ldh_SOURCES = ../ldh.cc
+ldh_SOURCES = ldh.cc
 
 strace_SOURCES = \
-	../path.cc \
-	../strace.cc
+	path.cc \
+	strace.cc
+strace_CPPFLAGS=-I$(srcdir)/..
 strace_LDADD = -lntdll
 
 noinst_PROGRAMS = path-testsuite
 
 path_testsuite_SOURCES = \
-	../path.cc \
-	../testsuite.cc
+	path.cc \
+	testsuite.cc
+path_testsuite_CPPFLAGS=-I$(srcdir)/..
 path_testsuite_CXXFLAGS = -DTESTSUITE
 
 TESTS = path-testsuite
diff --git a/winsup/utils/bloda.cc b/winsup/utils/mingw/bloda.cc
similarity index 100%
rename from winsup/utils/bloda.cc
rename to winsup/utils/mingw/bloda.cc
diff --git a/winsup/utils/cygcheck.cc b/winsup/utils/mingw/cygcheck.cc
similarity index 100%
rename from winsup/utils/cygcheck.cc
rename to winsup/utils/mingw/cygcheck.cc
diff --git a/winsup/utils/cygwin-console-helper.cc b/winsup/utils/mingw/cygwin-console-helper.cc
similarity index 100%
rename from winsup/utils/cygwin-console-helper.cc
rename to winsup/utils/mingw/cygwin-console-helper.cc
diff --git a/winsup/utils/dump_setup.cc b/winsup/utils/mingw/dump_setup.cc
similarity index 100%
rename from winsup/utils/dump_setup.cc
rename to winsup/utils/mingw/dump_setup.cc
diff --git a/winsup/utils/ldh.cc b/winsup/utils/mingw/ldh.cc
similarity index 100%
rename from winsup/utils/ldh.cc
rename to winsup/utils/mingw/ldh.cc
diff --git a/winsup/utils/mingw/path.cc b/winsup/utils/mingw/path.cc
new file mode 100644
index 000000000..dd275b61d
--- /dev/null
+++ b/winsup/utils/mingw/path.cc
@@ -0,0 +1 @@
+#include "../path.cc"
diff --git a/winsup/utils/strace.cc b/winsup/utils/mingw/strace.cc
similarity index 99%
rename from winsup/utils/strace.cc
rename to winsup/utils/mingw/strace.cc
index b96ad40c1..a7797600c 100644
--- a/winsup/utils/strace.cc
+++ b/winsup/utils/mingw/strace.cc
@@ -21,11 +21,11 @@ details. */
 #include <time.h>
 #include <signal.h>
 #include <errno.h>
-#include "../cygwin/include/sys/strace.h"
-#include "../cygwin/include/sys/cygwin.h"
-#include "../cygwin/include/cygwin/version.h"
-#include "../cygwin/cygtls_padsize.h"
-#include "../cygwin/gcc_seh.h"
+#include "../../cygwin/include/sys/strace.h"
+#include "../../cygwin/include/sys/cygwin.h"
+#include "../../cygwin/include/cygwin/version.h"
+#include "../../cygwin/cygtls_padsize.h"
+#include "../../cygwin/gcc_seh.h"
 #include "path.h"
 #undef cygwin_internal
 #include "loadlib.h"
diff --git a/winsup/utils/testsuite.cc b/winsup/utils/mingw/testsuite.cc
similarity index 100%
rename from winsup/utils/testsuite.cc
rename to winsup/utils/mingw/testsuite.cc
diff --git a/winsup/utils/testsuite.h b/winsup/utils/mingw/testsuite.h
similarity index 100%
rename from winsup/utils/testsuite.h
rename to winsup/utils/mingw/testsuite.h
-- 
2.31.1

