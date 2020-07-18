Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-043.btinternet.com (mailomta11-sa.btinternet.com
 [213.120.69.17])
 by sourceware.org (Postfix) with ESMTPS id 093DA3860C2D
 for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2020 15:00:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 093DA3860C2D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-043.btinternet.com with ESMTP id
 <20200718150056.HEDU26847.sa-prd-fep-043.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sat, 18 Jul 2020 16:00:56 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepveeifeevgeeiudetkedvjeehgeetfeefhffffefgtdffveetuefgjefhteekleevnecuffhomhgrihhnpehmohguuhhlvgdrnhgrmhgvnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE076FE42B; Sat, 18 Jul 2020 16:00:56 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/5] Cygwin: Remove reading of PE for section flags from dumper
Date: Sat, 18 Jul 2020 16:00:25 +0100
Message-Id: <20200718150028.1709-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
References: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sat, 18 Jul 2020 15:00:59 -0000

---
 winsup/utils/Makefile.in |   6 +--
 winsup/utils/dumper.cc   |   2 -
 winsup/utils/dumper.h    |   2 -
 winsup/utils/parse_pe.cc | 107 ---------------------------------------
 4 files changed, 3 insertions(+), 114 deletions(-)
 delete mode 100644 winsup/utils/parse_pe.cc

diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index 5bb62bc6f..f9892fa1d 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -113,9 +113,9 @@ build_dumper := $(shell test -r "$(libbfd)" && echo 1)
 
 ifdef build_dumper
 CYGWIN_BINS += dumper.exe
-dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(top_srcdir)/include
-dumper.o parse_pe.o: dumper.h
-dumper.exe: module_info.o parse_pe.o
+dumper.o module_info.o: CXXFLAGS += -I$(top_srcdir)/include
+dumper.o: dumper.h
+dumper.exe: module_info.o
 dumper.exe: CYGWIN_LDFLAGS += -lpsapi -lbfd -lintl -liconv -liberty ${ZLIB}
 else
 all: warn_dumper
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 46e4b0692..4577d2a3f 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -281,8 +281,6 @@ dumper::add_module (LPVOID base_address)
   new_entity->u.module.base_address = base_address;
   new_entity->u.module.name = module_name;
 
-  parse_pe (module_name, excl_list);
-
   deb_printf ("added module %p %s\n", base_address, module_name);
   return 1;
 }
diff --git a/winsup/utils/dumper.h b/winsup/utils/dumper.h
index 9367587bf..78592b61e 100644
--- a/winsup/utils/dumper.h
+++ b/winsup/utils/dumper.h
@@ -133,8 +133,6 @@ extern int deb_printf ( const char* format, ... );
 
 extern char* psapi_get_module_name ( HANDLE hProcess, LPVOID BaseAddress );
 
-extern int parse_pe ( const char* file_name, exclusion* excl_list );
-
 extern BOOL verbose;
 
 #endif
diff --git a/winsup/utils/parse_pe.cc b/winsup/utils/parse_pe.cc
deleted file mode 100644
index 90b5c0b0d..000000000
--- a/winsup/utils/parse_pe.cc
+++ /dev/null
@@ -1,107 +0,0 @@
-/* parse_pe.cc
-
-   Written by Egor Duda <deo@logos-m.ru>
-
-   This file is part of Cygwin.
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 3 of the License, or
-   (at your option) any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License (file COPYING.dumper) for more details.
-
-   You should have received a copy of the GNU General Public License
-   along with this program; if not, write to the Free Software
-   Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1301, USA.  */
-
-#define PACKAGE
-#include <bfd.h>
-#include <stdio.h>
-#include <stdlib.h>
-
-#include "dumper.h"
-
-#ifndef bfd_get_section_size
-#define bfd_get_section_size(sect) bfd_section_size(sect)
-#endif
-
-int
-exclusion::add (LPBYTE mem_base, SIZE_T mem_size)
-{
-  while (last >= size)
-    size += step;
-  region = (process_mem_region *) realloc (region, size * sizeof (process_mem_region));
-  if (region == NULL)
-    return 0;
-  region[last].base = mem_base;
-  region[last].size = mem_size;
-  last++;
-  return 1;
-};
-
-int
-cmp_regions (const void *r1, const void *r2)
-{
-  if (((process_mem_region *) r1)->base < ((process_mem_region *) r2)->base)
-    return -1;
-  if (((process_mem_region *) r1)->base > ((process_mem_region *) r2)->base)
-    return 1;
-  return 0;
-}
-
-int
-exclusion::sort_and_check ()
-{
-  qsort (region, last, sizeof (process_mem_region), &cmp_regions);
-  for (process_mem_region * p = region; p < region + last - 1; p++)
-    {
-      process_mem_region *q = p + 1;
-      if (q == p + 1)
-	continue;
-      if (p->base + size > q->base)
-	{
-	  fprintf (stderr, "region error @ (%p + %zd) > %p\n", p->base, size, q->base);
-	  return 0;
-	}
-    }
-  return 1;
-}
-
-static void
-select_data_section (bfd * abfd, asection * sect, PTR obj)
-{
-  exclusion *excl_list = (exclusion *) obj;
-
-  if ((sect->flags & (SEC_CODE | SEC_DEBUGGING)) &&
-      sect->vma && bfd_get_section_size (sect))
-    {
-      excl_list->add ((LPBYTE) sect->vma, (SIZE_T) bfd_get_section_size (sect));
-      deb_printf ("excluding section: %20s %08lx\n", sect->name,
-		  bfd_get_section_size (sect));
-    }
-}
-
-int
-parse_pe (const char *file_name, exclusion * excl_list)
-{
-  if (file_name == NULL || excl_list == NULL)
-    return 0;
-
-  bfd *abfd = bfd_openr (file_name, "pei-i386");
-  if (abfd == NULL)
-    {
-      bfd_perror ("failed to open file");
-      return 0;
-    }
-
-  bfd_check_format (abfd, bfd_object);
-  bfd_map_over_sections (abfd, &select_data_section, (PTR) excl_list);
-  excl_list->sort_and_check ();
-
-  bfd_close (abfd);
-  return 1;
-}
-- 
2.27.0

