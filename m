Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta22-re.btinternet.com
 [213.120.69.115])
 by sourceware.org (Postfix) with ESMTPS id 94EF93857830
 for <cygwin-patches@cygwin.com>; Sun,  9 May 2021 15:11:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 94EF93857830
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20210509151104.MNEN13681.re-prd-fep-046.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
 Sun, 9 May 2021 16:11:04 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C506323B80E3
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrvdegiedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C506323B80E3; Sun, 9 May 2021 16:11:04 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/2] Get rid of relative include paths in strace.cc
Date: Sun,  9 May 2021 16:09:39 +0100
Message-Id: <20210509150939.64863-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
References: <20210502152537.32312-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sun, 09 May 2021 15:11:07 -0000

---
 winsup/utils/mingw/Makefile.am |  2 +-
 winsup/utils/mingw/strace.cc   | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/winsup/utils/mingw/Makefile.am b/winsup/utils/mingw/Makefile.am
index 73abc4264..874dce512 100644
--- a/winsup/utils/mingw/Makefile.am
+++ b/winsup/utils/mingw/Makefile.am
@@ -39,7 +39,7 @@ ldh_SOURCES = ldh.cc
 strace_SOURCES = \
 	path.cc \
 	strace.cc
-strace_CPPFLAGS=-I$(srcdir)/..
+strace_CPPFLAGS=-I$(srcdir)/.. -idirafter ${top_srcdir}/cygwin -idirafter ${top_srcdir}/cygwin/include
 strace_LDADD = -lntdll
 
 noinst_PROGRAMS = path-testsuite
diff --git a/winsup/utils/mingw/strace.cc b/winsup/utils/mingw/strace.cc
index a7797600c..d8a095fb6 100644
--- a/winsup/utils/mingw/strace.cc
+++ b/winsup/utils/mingw/strace.cc
@@ -21,11 +21,11 @@ details. */
 #include <time.h>
 #include <signal.h>
 #include <errno.h>
-#include "../../cygwin/include/sys/strace.h"
-#include "../../cygwin/include/sys/cygwin.h"
-#include "../../cygwin/include/cygwin/version.h"
-#include "../../cygwin/cygtls_padsize.h"
-#include "../../cygwin/gcc_seh.h"
+#include "sys/strace.h"
+#include "sys/cygwin.h"
+#include "cygwin/version.h"
+#include "cygtls_padsize.h"
+#include "gcc_seh.h"
 #include "path.h"
 #undef cygwin_internal
 #include "loadlib.h"
-- 
2.31.1

