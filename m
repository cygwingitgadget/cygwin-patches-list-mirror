Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-040.btinternet.com (mailomta17-sa.btinternet.com
 [213.120.69.23])
 by sourceware.org (Postfix) with ESMTPS id 9BA233860C2D
 for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2020 15:01:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9BA233860C2D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-040.btinternet.com with ESMTP id
 <20200718150106.YFII5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sat, 18 Jul 2020 16:01:06 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE076FE575; Sat, 18 Jul 2020 16:01:06 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/5] Cygwin: Use MEMORY_WORKING_SET_EX_INFORMATION in dumper
Date: Sat, 18 Jul 2020 16:00:28 +0100
Message-Id: <20200718150028.1709-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
References: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 18 Jul 2020 15:01:09 -0000

Use the (undocumented) MEMORY_WORKING_SET_EX_INFORMATION in dumper to
determine if a MEM_IMAGE region is unsharable, and hence has been
modified.
---
 winsup/doc/utils.xml     |  8 ++---
 winsup/utils/Makefile.in |  2 +-
 winsup/utils/dumper.cc   | 63 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 5f266bcb1..8b92bfdf1 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -524,11 +524,11 @@ error_start=x:\path\to\dumper.exe
       <command>dumper</command> exits, the target process is terminated too. </para>
 
     <para> To save space in the core dump, <command>dumper</command> doesn't
-      write those portions of target process' memory space that are loaded from
-      executable and dll files and are unchangeable, such as program code and
-      debug info. Instead, <command>dumper</command> saves paths to files which
+      write those portions of the target process's memory space that are loaded
+      from executable and dll files and are unchanged (e.g. program code).
+      Instead, <command>dumper</command> saves paths to the files which
       contain that data. When a core dump is loaded into gdb, it uses these
-      paths to load appropriate files. That means that if you create a core
+      paths to load the appropriate files. That means that if you create a core
       dump on one machine and try to debug it on another, you'll need to place
       identical copies of the executable and dlls in the same directories as on
       the machine where the core dump was created. </para>
diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index f9892fa1d..6bf4454c5 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -116,7 +116,7 @@ CYGWIN_BINS += dumper.exe
 dumper.o module_info.o: CXXFLAGS += -I$(top_srcdir)/include
 dumper.o: dumper.h
 dumper.exe: module_info.o
-dumper.exe: CYGWIN_LDFLAGS += -lpsapi -lbfd -lintl -liconv -liberty ${ZLIB}
+dumper.exe: CYGWIN_LDFLAGS += -lpsapi -lbfd -lintl -liconv -liberty ${ZLIB} -lntdll
 else
 all: warn_dumper
 endif
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index b96ee54cc..3af138b9e 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -266,6 +266,46 @@ void protect_dump(DWORD protect, char *buf)
     strcat (buf, pt[i]);
 }
 
+typedef enum _MEMORY_INFORMATION_CLASS
+{
+ MemoryWorkingSetExInformation = 4, // MEMORY_WORKING_SET_EX_INFORMATION
+} MEMORY_INFORMATION_CLASS;
+
+extern "C"
+NTSTATUS
+NtQueryVirtualMemory(HANDLE ProcessHandle,
+		     LPVOID BaseAddress,
+		     MEMORY_INFORMATION_CLASS MemoryInformationClass,
+		     LPVOID MemoryInformation,
+		     SIZE_T MemoryInformationLength,
+		     SIZE_T *ReturnLength);
+
+typedef struct _MEMORY_WORKING_SET_EX_INFORMATION
+{
+  LPVOID VirtualAddress;
+  ULONG_PTR Long;
+} MEMORY_WORKING_SET_EX_INFORMATION;
+
+#define MWSEI_ATTRIB_SHARED (0x1 << 15)
+
+static BOOL
+getRegionAttributes(HANDLE hProcess, LPVOID address, DWORD &attribs)
+{
+  MEMORY_WORKING_SET_EX_INFORMATION mwsei = { address };
+  NTSTATUS status = NtQueryVirtualMemory(hProcess, 0,
+					 MemoryWorkingSetExInformation,
+					 &mwsei, sizeof(mwsei), 0);
+
+  if (!status)
+    {
+      attribs = mwsei.Long;
+      return TRUE;
+    }
+
+  deb_printf("MemoryWorkingSetExInformation failed status %08x\n", status);
+  return FALSE;
+}
+
 int
 dumper::collect_memory_sections ()
 {
@@ -292,10 +332,27 @@ dumper::collect_memory_sections ()
       int skip_region_p = 0;
       const char *disposition = "dumped";
 
-      if ((mbi.Type & MEM_IMAGE) && !(mbi.Protect & (PAGE_EXECUTE_READWRITE | PAGE_READWRITE)))
+      if (mbi.Type & MEM_IMAGE)
 	{
-	  skip_region_p = 1;
-	  disposition = "skipped due to non-writeable MEM_IMAGE";
+	  DWORD attribs = 0;
+	  if (getRegionAttributes(hProcess, current_page_address, attribs))
+	    {
+	      if (attribs & MWSEI_ATTRIB_SHARED)
+		{
+		  skip_region_p = 1;
+		  disposition = "skipped due to shared MEM_IMAGE";
+		}
+	    }
+	  /*
+	    The undocumented MemoryWorkingSetExInformation is allegedly
+	    supported since XP, so should always succeed, but if it fails,
+	    fallback to looking at region protection.
+	   */
+	  else if (!(mbi.Protect & (PAGE_EXECUTE_READWRITE | PAGE_READWRITE)))
+	    {
+	      skip_region_p = 1;
+	      disposition = "skipped due to non-writeable MEM_IMAGE";
+	    }
 	}
 
       if (mbi.Protect & PAGE_NOACCESS)
-- 
2.27.0

