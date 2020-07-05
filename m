Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-049.btinternet.com (mailomta31-sa.btinternet.com
 [213.120.69.37])
 by sourceware.org (Postfix) with ESMTPS id 51585385700E
 for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2020 16:46:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 51585385700E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-049.btinternet.com with ESMTP id
 <20200705164603.QLOO4195.sa-prd-fep-049.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sun, 5 Jul 2020 17:46:03 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddugddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED99EC905523C07; Sun, 5 Jul 2020 17:46:03 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 9/8] Add all memory regions details to dumper debug output
Date: Sun,  5 Jul 2020 17:45:28 +0100
Message-Id: <20200705164531.31995-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sun, 05 Jul 2020 16:46:05 -0000

---
 winsup/utils/dumper.cc | 101 ++++++++++++++++++++++++++++++++---------
 1 file changed, 80 insertions(+), 21 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index fa3fe1fbc..04b7aa638 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -292,6 +292,25 @@ dumper::add_module (LPVOID base_address)
 
 #define PAGE_BUFFER_SIZE 4096
 
+void protect_dump(DWORD protect, char *buf)
+{
+  const char *pt[10];
+  pt[0] = (protect & PAGE_READONLY) ? "RO " : "";
+  pt[1] = (protect & PAGE_READWRITE) ? "RW " : "";
+  pt[2] = (protect & PAGE_WRITECOPY) ? "WC " : "";
+  pt[3] = (protect & PAGE_EXECUTE) ? "EX " : "";
+  pt[4] = (protect & PAGE_EXECUTE_READ) ? "EXRO " : "";
+  pt[5] = (protect & PAGE_EXECUTE_READWRITE) ? "EXRW " : "";
+  pt[6] = (protect & PAGE_EXECUTE_WRITECOPY) ? "EXWC " : "";
+  pt[7] = (protect & PAGE_GUARD) ? "GRD " : "";
+  pt[8] = (protect & PAGE_NOACCESS) ? "NA " : "";
+  pt[9] = (protect & PAGE_NOCACHE) ? "NC " : "";
+
+  buf[0] = '\0';
+  for (int i = 0; i < 10; i++)
+    strcat (buf, pt[i]);
+}
+
 int
 dumper::collect_memory_sections ()
 {
@@ -316,10 +335,65 @@ dumper::collect_memory_sections ()
 	break;
 
       int skip_region_p = 0;
+      const char *disposition = "dumped";
 
-      if (mbi.Protect & (PAGE_NOACCESS | PAGE_GUARD) ||
-	  mbi.State != MEM_COMMIT)
-	skip_region_p = 1;
+      if (mbi.Protect & PAGE_NOACCESS)
+	{
+	  skip_region_p = 1;
+	  disposition = "skipped due to noaccess";
+	}
+
+      if (mbi.Protect & PAGE_GUARD)
+	{
+	  skip_region_p = 1;
+	  disposition = "skipped due to guardpage";
+	}
+
+      if (mbi.State != MEM_COMMIT)
+	{
+	  skip_region_p = 1;
+	  disposition = "skipped due to uncommited";
+	}
+
+      {
+	char buf[10 * 6];
+	protect_dump(mbi.Protect, buf);
+
+	const char *state = "";
+	const char *type = "";
+
+	if (mbi.State & MEM_COMMIT)
+	  {
+	    state = "COMMIT";
+	  }
+	else if (mbi.State & MEM_FREE)
+	  {
+	    state = "FREE";
+	    type = "FREE";
+	  }
+	else if (mbi.State & MEM_RESERVE)
+	  {
+	    state = "RESERVE";
+	  }
+
+	if (mbi.Type & MEM_IMAGE)
+	  {
+	    type = "IMAGE";
+	  }
+	else if (mbi.Type & MEM_MAPPED)
+	  {
+	    type = "MAPPED";
+	  }
+	else if (mbi.Type & MEM_PRIVATE)
+	  {
+	    type = "PRIVATE";
+	  }
+
+	deb_printf ("region 0x%016lx-0x%016lx (protect = %-8s, state = %-7s, type = %-7s, %s)\n",
+		    current_page_address,
+		    current_page_address + mbi.RegionSize,
+		    buf, state, type, disposition);
+      }
 
       if (!skip_region_p)
 	{
@@ -329,26 +403,11 @@ dumper::collect_memory_sections ()
 	  if (!ReadProcessMemory (hProcess, current_page_address, mem_buf, sizeof (mem_buf), &done))
 	    {
 	      DWORD err = GetLastError ();
-	      const char *pt[10];
-	      pt[0] = (mbi.Protect & PAGE_READONLY) ? "RO " : "";
-	      pt[1] = (mbi.Protect & PAGE_READWRITE) ? "RW " : "";
-	      pt[2] = (mbi.Protect & PAGE_WRITECOPY) ? "WC " : "";
-	      pt[3] = (mbi.Protect & PAGE_EXECUTE) ? "EX " : "";
-	      pt[4] = (mbi.Protect & PAGE_EXECUTE_READ) ? "EXRO " : "";
-	      pt[5] = (mbi.Protect & PAGE_EXECUTE_READWRITE) ? "EXRW " : "";
-	      pt[6] = (mbi.Protect & PAGE_EXECUTE_WRITECOPY) ? "EXWC " : "";
-	      pt[7] = (mbi.Protect & PAGE_GUARD) ? "GRD " : "";
-	      pt[8] = (mbi.Protect & PAGE_NOACCESS) ? "NA " : "";
-	      pt[9] = (mbi.Protect & PAGE_NOCACHE) ? "NC " : "";
-	      char buf[10 * 6];
-	      buf[0] = '\0';
-	      for (int i = 0; i < 10; i++)
-		strcat (buf, pt[i]);
-
-	      deb_printf ("warning: failed to read memory at %p-%p (protect = %s), error %ld.\n",
+
+	      deb_printf ("warning: failed to read memory at %p-%p, error %ld.\n",
 			  current_page_address,
 			  current_page_address + mbi.RegionSize,
-			  buf, err);
+			  err);
 	      skip_region_p = 1;
 	    }
 	}
-- 
2.27.0

