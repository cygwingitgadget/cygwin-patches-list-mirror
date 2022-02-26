Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-049.btinternet.com (mailomta27-sa.btinternet.com
 [213.120.69.33])
 by sourceware.org (Postfix) with ESMTPS id 0A93D3858D1E
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 16:42:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0A93D3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-049.btinternet.com with ESMTP id
 <20220226164203.PDNN30507.sa-prd-fep-049.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sat, 26 Feb 2022 16:42:03 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C17222EE3
X-Originating-IP: [86.139.167.74]
X-OWM-Source-IP: 86.139.167.74 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrleeigdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudeijedrjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrjeegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.74) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139417C17222EE3; Sat, 26 Feb 2022 16:42:02 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: Drop pointless loadlib.h includes in utilities
Date: Sat, 26 Feb 2022 16:40:53 +0000
Message-Id: <20220226164054.26698-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226164054.26698-1-jon.turney@dronecode.org.uk>
References: <20220226164054.26698-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sat, 26 Feb 2022 16:42:05 -0000

These utilities used to LoadLibrary()/GetProcAddress(), but don't
anymore.
---
 winsup/utils/cygpath.cc     | 1 -
 winsup/utils/module_info.cc | 1 -
 winsup/utils/path.cc        | 1 -
 winsup/utils/ps.cc          | 1 -
 4 files changed, 4 deletions(-)

diff --git a/winsup/utils/cygpath.cc b/winsup/utils/cygpath.cc
index 701c34998..9873e7b16 100644
--- a/winsup/utils/cygpath.cc
+++ b/winsup/utils/cygpath.cc
@@ -29,7 +29,6 @@ details. */
 #include <ntdll.h>
 
 #include "wide_path.h"
-#include "loadlib.h"
 
 static char *prog_name;
 static char *file_arg, *output_arg;
diff --git a/winsup/utils/module_info.cc b/winsup/utils/module_info.cc
index e0bd4b71a..3e2fc28e2 100644
--- a/winsup/utils/module_info.cc
+++ b/winsup/utils/module_info.cc
@@ -12,7 +12,6 @@ details. */
 #include <windows.h>
 #define PSAPI_VERSION 1
 #include <psapi.h>
-#include "loadlib.h"
 
 /* Returns full name of Dll, which is loaded by hProcess at BaseAddress.
    Uses psapi.dll. */
diff --git a/winsup/utils/path.cc b/winsup/utils/path.cc
index df0037c15..fe55a646d 100644
--- a/winsup/utils/path.cc
+++ b/winsup/utils/path.cc
@@ -28,7 +28,6 @@ details. */
 #ifdef FSTAB_ONLY
 #include <sys/cygwin.h>
 #endif
-#include "loadlib.h"
 
 #ifndef FSTAB_ONLY
 /* Used when treating / and \ as equivalent. */
diff --git a/winsup/utils/ps.cc b/winsup/utils/ps.cc
index b51657535..dbcacbab4 100644
--- a/winsup/utils/ps.cc
+++ b/winsup/utils/ps.cc
@@ -21,7 +21,6 @@ details. */
 #include <cygwin/version.h>
 #include <ntdef.h>
 #include <ntdll.h>
-#include "loadlib.h"
 
 /* Maximum possible path length under NT.  There's no official define
    for that value.  Note that PATH_MAX is only 4K. */
-- 
2.35.1

