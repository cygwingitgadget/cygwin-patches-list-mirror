Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta2-re.btinternet.com
 [213.120.69.95])
 by sourceware.org (Postfix) with ESMTPS id 4FE6038618A2
 for <cygwin-patches@cygwin.com>; Fri, 31 Jul 2020 13:07:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4FE6038618A2
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20200731130736.VEPH4080.re-prd-fep-045.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Fri, 31 Jul 2020 14:07:36 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrieekgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD009A4F18B; Fri, 31 Jul 2020 14:07:36 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Use documented QueryWorkingSetEx() in dumper
Date: Fri, 31 Jul 2020 14:07:24 +0100
Message-Id: <20200731130724.51334-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Fri, 31 Jul 2020 13:07:39 -0000

In dumper, use the documented QueryWorkingSetEx(), rather than the
undocumented NtQueryVirtualMemory() with MemoryWorkingSetExInformation.
---

Notes:
    As it's been pointed out to me that there is a documented interface to
    get this information, so use that, rather than relying an undocmented one.

 winsup/utils/dumper.cc | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 5f8121aa3..19a279662 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <sys/param.h>
 #include <windows.h>
+#include <psapi.h>
 
 #include "dumper.h"
 
@@ -267,43 +268,20 @@ void protect_dump(DWORD protect, char *buf)
     strcat (buf, pt[i]);
 }
 
-typedef enum _MEMORY_INFORMATION_CLASS
-{
- MemoryWorkingSetExInformation = 4, // MEMORY_WORKING_SET_EX_INFORMATION
-} MEMORY_INFORMATION_CLASS;
-
-extern "C"
-NTSTATUS NTAPI
-NtQueryVirtualMemory(HANDLE ProcessHandle,
-		     LPVOID BaseAddress,
-		     MEMORY_INFORMATION_CLASS MemoryInformationClass,
-		     LPVOID MemoryInformation,
-		     SIZE_T MemoryInformationLength,
-		     SIZE_T *ReturnLength);
-
-typedef struct _MEMORY_WORKING_SET_EX_INFORMATION
-{
-  LPVOID VirtualAddress;
-  ULONG_PTR Long;
-} MEMORY_WORKING_SET_EX_INFORMATION;
-
-#define MWSEI_ATTRIB_SHARED (0x1 << 15)
+#define PSWSEI_ATTRIB_SHARED (0x1 << 15)
 
 static BOOL
 getRegionAttributes(HANDLE hProcess, LPVOID address, DWORD &attribs)
 {
-  MEMORY_WORKING_SET_EX_INFORMATION mwsei = { address };
-  NTSTATUS status = NtQueryVirtualMemory(hProcess, 0,
-					 MemoryWorkingSetExInformation,
-					 &mwsei, sizeof(mwsei), 0);
+  PSAPI_WORKING_SET_EX_INFORMATION pswsei = { address };
 
-  if (!status)
+  if (QueryWorkingSetEx(hProcess, &pswsei, sizeof(pswsei)))
     {
-      attribs = mwsei.Long;
+      attribs = pswsei.VirtualAttributes.Flags;
       return TRUE;
     }
 
-  deb_printf("MemoryWorkingSetExInformation failed status %08x\n", status);
+  deb_printf("QueryWorkingSetEx failed status %08x\n", GetLastError());
   return FALSE;
 }
 
@@ -338,7 +316,7 @@ dumper::collect_memory_sections ()
 	  DWORD attribs = 0;
 	  if (getRegionAttributes(hProcess, current_page_address, attribs))
 	    {
-	      if (attribs & MWSEI_ATTRIB_SHARED)
+	      if (attribs & PSWSEI_ATTRIB_SHARED)
 		{
 		  skip_region_p = 1;
 		  disposition = "skipped due to shared MEM_IMAGE";
-- 
2.27.0

