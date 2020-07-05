Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-045.btinternet.com (mailomta29-sa.btinternet.com
 [213.120.69.35])
 by sourceware.org (Postfix) with ESMTPS id 1BDCA3858D38
 for <cygwin-patches@cygwin.com>; Sun,  5 Jul 2020 16:46:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1BDCA3858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-045.btinternet.com with ESMTP id
 <20200705164608.QLOW4112.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sun, 5 Jul 2020 17:46:08 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddugddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevieefveegieduteekvdejheegteeffefhffefgfdtffevteeugfejhfetkeelveenucffohhmrghinhepmhhoughulhgvrdhnrghmvgenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED99EC905523CB1; Sun, 5 Jul 2020 17:46:08 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 10/8] Remove PE reading for section flags from dumper
Date: Sun,  5 Jul 2020 17:45:29 +0100
Message-Id: <20200705164531.31995-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200705164531.31995-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <20200705164531.31995-1-jon.turney@dronecode.org.uk>
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
X-List-Received-Date: Sun, 05 Jul 2020 16:46:11 -0000

---
 winsup/utils/Makefile.in |   6 +-
 winsup/utils/dumper.cc   |   2 -
 winsup/utils/dumper.h    |   2 -
 winsup/utils/parse_pe.cc | 124 ---------------------------------------
 4 files changed, 3 insertions(+), 131 deletions(-)
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
index 04b7aa638..d9d07c055 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -284,8 +284,6 @@ dumper::add_module (LPVOID base_address)
   new_entity->u.module.base_address = base_address;
   new_entity->u.module.name = module_name;
 
-  parse_pe (module_name, excl_list, base_address);
-
   deb_printf ("added module %p %s\n", base_address, module_name);
   return 1;
 }
diff --git a/winsup/utils/dumper.h b/winsup/utils/dumper.h
index 9c4b1f092..78592b61e 100644
--- a/winsup/utils/dumper.h
+++ b/winsup/utils/dumper.h
@@ -133,8 +133,6 @@ extern int deb_printf ( const char* format, ... );
 
 extern char* psapi_get_module_name ( HANDLE hProcess, LPVOID BaseAddress );
 
-extern int parse_pe ( const char* file_name, exclusion* excl_list, LPVOID base_address );
-
 extern BOOL verbose;
 
 #endif
diff --git a/winsup/utils/parse_pe.cc b/winsup/utils/parse_pe.cc
deleted file mode 100644
index 0256ada53..000000000
--- a/winsup/utils/parse_pe.cc
+++ /dev/null
@@ -1,124 +0,0 @@
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
-      if (p->base + p->size > q->base)
-	{
-	  fprintf (stderr, "region error @ (%p + 0x%0llx) > %p\n", p->base, p->size, q->base);
-	  return 0;
-	}
-    }
-  return 1;
-}
-
-static void
-select_data_section (bfd * abfd, asection * sect, exclusion *excl_list,
-		     SSIZE_T adj)
-{
-  if ((sect->flags & (SEC_CODE | SEC_DEBUGGING)) &&
-      sect->vma && bfd_get_section_size (sect))
-    {
-      bfd_vma vma = sect->vma + adj;
-      excl_list->add ((LPBYTE) vma, (SIZE_T) bfd_get_section_size (sect));
-      deb_printf ("excluding section: %20s %016lx %016lx %08lx\n", sect->name,
-		  sect->vma, vma, bfd_get_section_size (sect));
-    }
-}
-
-int
-parse_pe (const char *file_name, exclusion * excl_list, LPVOID base_address)
-{
-  if (file_name == NULL || excl_list == NULL)
-    return 0;
-
-#ifdef __x86_64__
-  const char *target = "pei-x86-64";
-#else
-  const char *target = "pei-i386";
-#endif
-
-  bfd *abfd = bfd_openr (file_name, target);
-
-  if (abfd == NULL)
-    {
-      bfd_perror ("failed to open file");
-      return 0;
-    }
-
-  bfd_check_format (abfd, bfd_object);
-
-  /* Compute the relocation offset for this DLL.  Unfortunately, we have to
-     guess at ImageBase (one page before vma of first section), since bfd
-     doesn't let us get at backend-private data */
-  bfd_vma imagebase = abfd->sections->vma - 0x1000;
-  SSIZE_T adj = (bfd_vma)base_address - imagebase;
-  deb_printf("imagebase relocated from %016lx to %016lx (%016lx)\n",
-	     imagebase, base_address, adj);
-
-  asection *p;
-  for (p = abfd->sections; p != NULL; p = p->next)
-    select_data_section(abfd, p, excl_list, adj);
-
-  excl_list->sort_and_check ();
-
-  bfd_close (abfd);
-  return 1;
-}
-- 
2.27.0

