Return-Path: <cygwin-patches-return-10130-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107260 invoked by alias); 26 Feb 2020 20:07:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107249 invoked by uid 89); 26 Feb 2020 20:07:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.4 required=5.0 tests=AWL,BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.1 spammy=3920, exclusion, HContent-Transfer-Encoding:8bit
X-HELO: sa-prd-fep-047.btinternet.com
Received: from mailomta19-sa.btinternet.com (HELO sa-prd-fep-047.btinternet.com) (213.120.69.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Feb 2020 20:07:25 +0000
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])          by sa-prd-fep-047.btinternet.com with ESMTP          id <20200226200718.KRCO7408.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;          Wed, 26 Feb 2020 20:07:18 +0000
Authentication-Results: btinternet.com;    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-OWM-Source-IP: 31.51.207.12 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from localhost.localdomain (31.51.207.12) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as jonturney@btinternet.com)        id 5E3A254B03647F48; Wed, 26 Feb 2020 20:07:18 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Update dumper for bfd API changes
Date: Wed, 26 Feb 2020 20:07:00 -0000
Message-Id: <20200226200704.34424-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2020-q1/txt/msg00236.txt

Update dumper for bfd API changes in binutils 2.34

libbfd doesn't guarantee API stability, so we've just been lucky this
hasn't broken more often.

See binutils commit fd361982.
---
 winsup/utils/dumper.cc   | 30 ++++++++++++++++++++++--------
 winsup/utils/parse_pe.cc |  4 ++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index f71bdda8b..226c2283d 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -39,6 +39,20 @@
 
 #define NOTE_NAME_SIZE 16
 
+#ifdef bfd_get_section_size
+/* for bfd < 2.34 */
+#define get_section_name(abfd, sect) bfd_get_section_name (abfd, sect)
+#define get_section_size(sect) bfd_get_section_size(sect)
+#define set_section_size(abfd, sect, size) bfd_set_section_size(abfd, sect, size)
+#define set_section_flags(abfd, sect, flags) bfd_set_section_flags(abfd, sect, flags)
+#else
+/* otherwise bfd >= 2.34 */
+#define get_section_name(afbd, sect) bfd_section_name (sect)
+#define get_section_size(sect) bfd_section_size(sect)
+#define set_section_size(abfd, sect, size) bfd_set_section_size(sect, size)
+#define set_section_flags(abfd, sect, flags) bfd_set_section_flags(sect, flags)
+#endif
+
 typedef struct _note_header
   {
     Elf_External_Note elf_note_header;
@@ -131,7 +145,7 @@ dumper::sane ()
 void
 print_section_name (bfd* abfd, asection* sect, PTR obj)
 {
-  deb_printf (" %s", bfd_get_section_name (abfd, sect));
+  deb_printf (" %s", get_section_name (abfd, sect));
 }
 
 void
@@ -712,10 +726,10 @@ dumper::prepare_core_dump ()
 
       if (p->type == pr_ent_module && status_section != NULL)
 	{
-	  if (!bfd_set_section_size (core_bfd,
-				     status_section,
-				     (bfd_get_section_size (status_section)
-				      + sect_size)))
+	  if (!set_section_size (core_bfd,
+				 status_section,
+				 (get_section_size (status_section)
+				  + sect_size)))
 	    {
 	      bfd_perror ("resizing status section");
 	      goto failed;
@@ -738,8 +752,8 @@ dumper::prepare_core_dump ()
 	  goto failed;
 	}
 
-      if (!bfd_set_section_flags (core_bfd, new_section, sect_flags) ||
-	  !bfd_set_section_size (core_bfd, new_section, sect_size))
+      if (!set_section_flags (core_bfd, new_section, sect_flags) ||
+	  !set_section_size (core_bfd, new_section, sect_size))
 	{
 	  bfd_perror ("setting section attributes");
 	  goto failed;
@@ -823,7 +837,7 @@ dumper::write_core_dump ()
       deb_printf ("writing section type=%u base=%p size=%p flags=%08x\n",
 		  p->type,
 		  p->section->vma,
-		  bfd_get_section_size (p->section),
+		  get_section_size (p->section),
 		  p->section->flags);
 
       switch (p->type)
diff --git a/winsup/utils/parse_pe.cc b/winsup/utils/parse_pe.cc
index 2a388638c..90b5c0b0d 100644
--- a/winsup/utils/parse_pe.cc
+++ b/winsup/utils/parse_pe.cc
@@ -25,6 +25,10 @@
 
 #include "dumper.h"
 
+#ifndef bfd_get_section_size
+#define bfd_get_section_size(sect) bfd_section_size(sect)
+#endif
+
 int
 exclusion::add (LPBYTE mem_base, SIZE_T mem_size)
 {
-- 
2.21.0
