Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta10-sa.btinternet.com
 [213.120.69.16])
 by sourceware.org (Postfix) with ESMTPS id 477F03844038
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 21:27:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 477F03844038
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20200701212756.CNDT4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 1 Jul 2020 22:27:56 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdduieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevieefveegieduteekvdejheegteeffefhffefgfdtffevteeugfejhfetkeelveenucffohhmrghinhepmhhoughulhgvrdhnrghmvgenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E04BC606F; Wed, 1 Jul 2020 22:27:56 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 8/8] Cygwin: Consider DLL rebasing when computing dumper
 exclusions
Date: Wed,  1 Jul 2020 22:25:29 +0100
Message-Id: <20200701212529.13998-9-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Wed, 01 Jul 2020 21:27:58 -0000

I think this would always have been neeeded, but is essential on x86_64,
as kernel32.dll has an ImageBase of 00000001:80000000 (but is always
rebased when loaded), which is identical to the cygwin DLL, causing
duplicate or overlapping exclusions.
---
 winsup/utils/dumper.cc   |  2 +-
 winsup/utils/dumper.h    |  2 +-
 winsup/utils/parse_pe.cc | 28 ++++++++++++++++++++--------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index c0b3fd8ff..fa3fe1fbc 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -284,7 +284,7 @@ dumper::add_module (LPVOID base_address)
   new_entity->u.module.base_address = base_address;
   new_entity->u.module.name = module_name;
 
-  parse_pe (module_name, excl_list);
+  parse_pe (module_name, excl_list, base_address);
 
   deb_printf ("added module %p %s\n", base_address, module_name);
   return 1;
diff --git a/winsup/utils/dumper.h b/winsup/utils/dumper.h
index 9367587bf..9c4b1f092 100644
--- a/winsup/utils/dumper.h
+++ b/winsup/utils/dumper.h
@@ -133,7 +133,7 @@ extern int deb_printf ( const char* format, ... );
 
 extern char* psapi_get_module_name ( HANDLE hProcess, LPVOID BaseAddress );
 
-extern int parse_pe ( const char* file_name, exclusion* excl_list );
+extern int parse_pe ( const char* file_name, exclusion* excl_list, LPVOID base_address );
 
 extern BOOL verbose;
 
diff --git a/winsup/utils/parse_pe.cc b/winsup/utils/parse_pe.cc
index 653c46dfe..0256ada53 100644
--- a/winsup/utils/parse_pe.cc
+++ b/winsup/utils/parse_pe.cc
@@ -70,21 +70,21 @@ exclusion::sort_and_check ()
 }
 
 static void
-select_data_section (bfd * abfd, asection * sect, PTR obj)
+select_data_section (bfd * abfd, asection * sect, exclusion *excl_list,
+		     SSIZE_T adj)
 {
-  exclusion *excl_list = (exclusion *) obj;
-
   if ((sect->flags & (SEC_CODE | SEC_DEBUGGING)) &&
       sect->vma && bfd_get_section_size (sect))
     {
-      excl_list->add ((LPBYTE) sect->vma, (SIZE_T) bfd_get_section_size (sect));
-      deb_printf ("excluding section: %20s %08lx\n", sect->name,
-		  bfd_get_section_size (sect));
+      bfd_vma vma = sect->vma + adj;
+      excl_list->add ((LPBYTE) vma, (SIZE_T) bfd_get_section_size (sect));
+      deb_printf ("excluding section: %20s %016lx %016lx %08lx\n", sect->name,
+		  sect->vma, vma, bfd_get_section_size (sect));
     }
 }
 
 int
-parse_pe (const char *file_name, exclusion * excl_list)
+parse_pe (const char *file_name, exclusion * excl_list, LPVOID base_address)
 {
   if (file_name == NULL || excl_list == NULL)
     return 0;
@@ -104,7 +104,19 @@ parse_pe (const char *file_name, exclusion * excl_list)
     }
 
   bfd_check_format (abfd, bfd_object);
-  bfd_map_over_sections (abfd, &select_data_section, (PTR) excl_list);
+
+  /* Compute the relocation offset for this DLL.  Unfortunately, we have to
+     guess at ImageBase (one page before vma of first section), since bfd
+     doesn't let us get at backend-private data */
+  bfd_vma imagebase = abfd->sections->vma - 0x1000;
+  SSIZE_T adj = (bfd_vma)base_address - imagebase;
+  deb_printf("imagebase relocated from %016lx to %016lx (%016lx)\n",
+	     imagebase, base_address, adj);
+
+  asection *p;
+  for (p = abfd->sections; p != NULL; p = p->next)
+    select_data_section(abfd, p, excl_list, adj);
+
   excl_list->sort_and_check ();
 
   bfd_close (abfd);
-- 
2.27.0

