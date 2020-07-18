Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta30-sa.btinternet.com
 [213.120.69.36])
 by sourceware.org (Postfix) with ESMTPS id A20B53893669
 for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2020 15:01:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A20B53893669
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20200718150059.LZAQ2233.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sat, 18 Jul 2020 16:00:59 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE076FE48A; Sat, 18 Jul 2020 16:00:59 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/5] Cygwin: Drop excluded regions list from dumper
Date: Sat, 18 Jul 2020 16:00:26 +0100
Message-Id: <20200718150028.1709-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
References: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Sat, 18 Jul 2020 15:01:02 -0000

Drop excluded regions, now it's always empty
---
 winsup/utils/dumper.cc | 48 ++++--------------------------------------
 winsup/utils/dumper.h  | 17 ---------------
 2 files changed, 4 insertions(+), 61 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 4577d2a3f..2a0c66002 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -83,7 +83,6 @@ dumper::dumper (DWORD pid, DWORD tid, const char *file_name)
   this->pid = pid;
   this->tid = tid;
   core_bfd = NULL;
-  excl_list = new exclusion (20);
 
   list = last = NULL;
 
@@ -125,19 +124,16 @@ dumper::close ()
 {
   if (core_bfd)
     bfd_close (core_bfd);
-  if (excl_list)
-    delete excl_list;
   if (hProcess)
     CloseHandle (hProcess);
   core_bfd = NULL;
   hProcess = NULL;
-  excl_list = NULL;
 }
 
 int
 dumper::sane ()
 {
-  if (hProcess == NULL || core_bfd == NULL || excl_list == NULL)
+  if (hProcess == NULL || core_bfd == NULL)
     return 0;
   return 1;
 }
@@ -226,42 +222,6 @@ dumper::add_mem_region (LPBYTE base, SIZE_T size)
   return 1;
 }
 
-/* split_add_mem_region scans list of regions to be excluded from dumping process
-   (excl_list) and removes all "excluded" parts from given region. */
-int
-dumper::split_add_mem_region (LPBYTE base, SIZE_T size)
-{
-  if (!sane ())
-    return 0;
-
-  if (base == NULL || size == 0)
-    return 1;			// just ignore empty regions
-
-  LPBYTE last_base = base;
-
-  for (process_mem_region * p = excl_list->region;
-       p < excl_list->region + excl_list->last;
-       p++)
-    {
-      if (p->base >= base + size || p->base + p->size <= base)
-	continue;
-
-      if (p->base <= base)
-	{
-	  last_base = p->base + p->size;
-	  continue;
-	}
-
-      add_mem_region (last_base, p->base - last_base);
-      last_base = p->base + p->size;
-    }
-
-  if (last_base < base + size)
-    add_mem_region (last_base, base + size - last_base);
-
-  return 1;
-}
-
 int
 dumper::add_module (LPVOID base_address)
 {
@@ -413,14 +373,14 @@ dumper::collect_memory_sections ()
 	    last_size += mbi.RegionSize;
 	  else
 	    {
-	      split_add_mem_region (last_base, last_size);
+	      add_mem_region (last_base, last_size);
 	      last_base = (LPBYTE) mbi.BaseAddress;
 	      last_size = mbi.RegionSize;
 	    }
 	}
       else
 	{
-	  split_add_mem_region (last_base, last_size);
+	  add_mem_region (last_base, last_size);
 	  last_base = NULL;
 	  last_size = 0;
 	}
@@ -429,7 +389,7 @@ dumper::collect_memory_sections ()
     }
 
   /* dump last sections, if any */
-  split_add_mem_region (last_base, last_size);
+  add_mem_region (last_base, last_size);
   return 1;
 };
 
diff --git a/winsup/utils/dumper.h b/winsup/utils/dumper.h
index 78592b61e..6e624a983 100644
--- a/winsup/utils/dumper.h
+++ b/winsup/utils/dumper.h
@@ -62,22 +62,6 @@ typedef struct _process_entity
   struct _process_entity* next;
 } process_entity;
 
-class exclusion
-{
-public:
-  size_t last;
-  size_t size;
-  size_t step;
-  process_mem_region* region;
-
-  exclusion ( size_t step ) { last = size = 0;
-			      this->step = step;
-			      region = NULL; }
-  ~exclusion () { free ( region ); }
-  int add ( LPBYTE mem_base, SIZE_T mem_size );
-  int sort_and_check ();
-};
-
 #define PAGE_BUFFER_SIZE 4096
 
 class dumper
@@ -87,7 +71,6 @@ class dumper
   HANDLE hProcess;
   process_entity* list;
   process_entity* last;
-  exclusion* excl_list;
 
   char* file_name;
   bfd* core_bfd;
-- 
2.27.0

