Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta1-sa.btinternet.com
 [213.120.69.7])
 by sourceware.org (Postfix) with ESMTPS id 771DC385801D
 for <cygwin-patches@cygwin.com>; Sat, 26 Feb 2022 16:42:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 771DC385801D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20220226164208.LLDZ16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Sat, 26 Feb 2022 16:42:08 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6139417C17222FA0
X-Originating-IP: [86.139.167.74]
X-OWM-Source-IP: 86.139.167.74 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrleeigdeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudeijedrjeegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrjeegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.74) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139417C17222FA0; Sat, 26 Feb 2022 16:42:08 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: Drop use of loadlib.h in regtool
Date: Sat, 26 Feb 2022 16:40:54 +0000
Message-Id: <20220226164054.26698-3-jon.turney@dronecode.org.uk>
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
X-List-Received-Date: Sat, 26 Feb 2022 16:42:10 -0000

Link directly with RegDeleteKeyExW(), available since Vista.

(It's unclear the LoadLibrary wrapper was ever doing anything useful
here, as (i) DLL lookup in PATH was avoided as advapi32 is already
loaded into the process, and (ii) advapi32 is a 'known DLL' which is
only ever loaded from system directory)
---
 winsup/utils/regtool.cc | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/winsup/utils/regtool.cc b/winsup/utils/regtool.cc
index fd2dd0590..e919185ae 100644
--- a/winsup/utils/regtool.cc
+++ b/winsup/utils/regtool.cc
@@ -16,7 +16,6 @@ details. */
 #include <windows.h>
 #include <sys/cygwin.h>
 #include <cygwin/version.h>
-#include "loadlib.h"
 
 #define DEFAULT_KEY_SEPARATOR '\\'
 
@@ -589,10 +588,6 @@ cmd_add ()
   return 0;
 }
 
-extern "C" {
-  LONG WINAPI (*regDeleteKeyEx)(HKEY, LPCWSTR, REGSAM, DWORD);
-}
-
 int
 cmd_remove ()
 {
@@ -600,13 +595,7 @@ cmd_remove ()
 
   find_key (2, KEY_ALL_ACCESS);
   if (wow64)
-    {
-      HMODULE mod = LoadLibrary ("advapi32.dll");
-      if (mod)
-	regDeleteKeyEx = (LONG WINAPI (*)(HKEY, LPCWSTR, REGSAM, DWORD)) GetProcAddress (mod, "RegDeleteKeyExW");
-    }
-  if (regDeleteKeyEx)
-    rv = (*regDeleteKeyEx) (key, value, wow64, 0);
+    rv = RegDeleteKeyExW (key, value, wow64, 0);
   else
     rv = RegDeleteKeyW (key, value);
   if (rv != ERROR_SUCCESS)
-- 
2.35.1

