Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta29-re.btinternet.com
 [213.120.69.122])
 by sourceware.org (Postfix) with ESMTPS id 14554385B83F
 for <cygwin-patches@cygwin.com>; Sun, 20 Jun 2021 13:38:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 14554385B83F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20210620133808.ESC16557.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sun, 20 Jun 2021 14:38:08 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9C2FD3858108E
X-Originating-IP: [86.139.156.26]
X-OWM-Source-IP: 86.139.156.26 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrfeefjedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddufeelrdduheeirddvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheeirddviedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.156.26) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C2FD3858108E; Sun, 20 Jun 2021 14:38:08 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Define PSAPI_VERSION as 1 before including psapi.h
Date: Sun, 20 Jun 2021 14:37:27 +0100
Message-Id: <20210620133727.63966-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <96d77c6b-0b46-527e-40bb-40adca640aff@dronecode.org.uk>
References: <96d77c6b-0b46-527e-40bb-40adca640aff@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sun, 20 Jun 2021 13:38:14 -0000

The default PSAPI_VERSION is controlled by WIN32_WINNT, which we set to
0x0a00 when building utils since 48a76190 (and is the default in w32api
>= 9.0.0)

In order for the built executables to run on Windows Vista, we must also
define PSAPI_VERSION as 1 (otherwise '#define GetModuleFileNameExA
K32GetModuleFileNameExA' causes a 'The procedure entry point
K32GetModuleFilenameExA could not be located in the dynamic link library
kernel32.dll' error at run time).

Also drop uneeded psapi.h from dlfcn.cc (31ddf45d), resource.cc
(34a6eeab) and ps.cc (1def2148).
---
 winsup/cygwin/dlfcn.cc      | 1 -
 winsup/cygwin/resource.cc   | 1 -
 winsup/utils/dumper.cc      | 1 +
 winsup/utils/ldd.cc         | 2 +-
 winsup/utils/mingw/bloda.cc | 1 +
 winsup/utils/module_info.cc | 1 +
 winsup/utils/pldd.c         | 1 +
 winsup/utils/ps.cc          | 1 -
 8 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index c675a5785..9a7472850 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -7,7 +7,6 @@ Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
 #include "winsup.h"
-#include <psapi.h>
 #include <stdlib.h>
 #include <dlfcn.h>
 #include <ctype.h>
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 97777e9d2..1664bca0f 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -14,7 +14,6 @@ details. */
 #include <unistd.h>
 #include <sys/param.h>
 #include "pinfo.h"
-#include "psapi.h"
 #include "cygtls.h"
 #include "path.h"
 #include "fhandler.h"
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index f21c93bf7..bc6c68a53 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <sys/param.h>
 #include <windows.h>
+#define PSAPI_VERSION 1
 #include <psapi.h>
 
 #include "dumper.h"
diff --git a/winsup/utils/ldd.cc b/winsup/utils/ldd.cc
index f9b04ed10..0d073c298 100644
--- a/winsup/utils/ldd.cc
+++ b/winsup/utils/ldd.cc
@@ -37,10 +37,10 @@
 #include <unistd.h>
 #include <libgen.h>
 
-#define PSAPI_VERSION 1
 #include <windows.h>
 #include <winternl.h>
 #include <imagehlp.h>
+#define PSAPI_VERSION 1
 #include <psapi.h>
 
 struct option longopts[] =
diff --git a/winsup/utils/mingw/bloda.cc b/winsup/utils/mingw/bloda.cc
index ffaee5229..330ac556f 100644
--- a/winsup/utils/mingw/bloda.cc
+++ b/winsup/utils/mingw/bloda.cc
@@ -13,6 +13,7 @@
 			   ntstatus.h for extended status codes below. */
 #include <windows.h>
 #undef WIN32_NO_STATUS
+#define PSAPI_VERSION 1
 #include <psapi.h>
 #include <winternl.h>
 #include <ntstatus.h>
diff --git a/winsup/utils/module_info.cc b/winsup/utils/module_info.cc
index bf3a18bf3..e0bd4b71a 100644
--- a/winsup/utils/module_info.cc
+++ b/winsup/utils/module_info.cc
@@ -10,6 +10,7 @@ details. */
 
 #include <stdlib.h>
 #include <windows.h>
+#define PSAPI_VERSION 1
 #include <psapi.h>
 #include "loadlib.h"
 
diff --git a/winsup/utils/pldd.c b/winsup/utils/pldd.c
index f077e63ab..2c085eaa2 100644
--- a/winsup/utils/pldd.c
+++ b/winsup/utils/pldd.c
@@ -16,6 +16,7 @@ details. */
 #include <sys/cygwin.h>
 #include <cygwin/version.h>
 #include <windows.h>
+#define PSAPI_VERSION 1
 #include <psapi.h>
 
 struct option longopts[] =
diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
index 478ed8efd..b51657535 100644
--- a/winsup/utils/ps.cc
+++ b/winsup/utils/ps.cc
@@ -19,7 +19,6 @@ details. */
 #include <limits.h>
 #include <sys/cygwin.h>
 #include <cygwin/version.h>
-#include <psapi.h>
 #include <ntdef.h>
 #include <ntdll.h>
 #include "loadlib.h"
-- 
2.31.1

