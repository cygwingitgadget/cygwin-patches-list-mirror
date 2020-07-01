Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta6-sa.btinternet.com
 [213.120.69.12])
 by sourceware.org (Postfix) with ESMTPS id DCC3F3844041
 for <cygwin-patches@cygwin.com>; Wed,  1 Jul 2020 21:26:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DCC3F3844041
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20200701212628.WYRW4114.sa-prd-fep-046.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Wed, 1 Jul 2020 22:26:28 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.51.206.31]
X-OWM-Source-IP: 31.51.206.31 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrtddvgdduieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepfedurdehuddrvddtiedrfedunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirdefuddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.31) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AA6E04BC5336; Wed, 1 Jul 2020 22:26:28 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/8] Cygwin: Add a new win32_pstatus data type for modules on
 x86_64
Date: Wed,  1 Jul 2020 22:25:24 +0100
Message-Id: <20200701212529.13998-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 01 Jul 2020 21:26:31 -0000

Take a bit more care with sizes in other data types to ensure they are
the same on x86 and x86_64.

Add some explanatory comments.
---
 winsup/cygwin/include/cygwin/core_dump.h | 16 ++++++++++++----
 winsup/utils/dumper.cc                   |  4 ++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/cygwin/core_dump.h b/winsup/cygwin/include/cygwin/core_dump.h
index 92ecae7ab..cd218ac45 100644
--- a/winsup/cygwin/include/cygwin/core_dump.h
+++ b/winsup/cygwin/include/cygwin/core_dump.h
@@ -11,17 +11,23 @@ details. */
 #ifndef _CYGWIN_CORE_DUMP_H
 #define _CYGWIN_CORE_DUMP_H
 
+/*
+  Note that elfcore_grok_win32pstatus() in libbfd relies on the precise layout
+  of these structures.
+*/
+
 #include <windows.h>
 
 #define	NOTE_INFO_PROCESS	1
 #define	NOTE_INFO_THREAD	2
 #define	NOTE_INFO_MODULE	3
+#define	NOTE_INFO_MODULE64	4
 
 struct win32_core_process_info
 {
   DWORD pid;
-  int signal;
-  int command_line_size;
+  DWORD signal;
+  DWORD command_line_size;
   char command_line[1];
 }
 #ifdef __GNUC__
@@ -40,10 +46,12 @@ struct win32_core_thread_info
 #endif
 ;
 
+/* Used with data_type NOTE_INFO_MODULE or NOTE_INFO_MODULE64, depending on
+   arch */
 struct win32_core_module_info
 {
   void* base_address;
-  int module_name_size;
+  DWORD module_name_size;
   char module_name[1];
 }
 #ifdef __GNUC__
@@ -53,7 +61,7 @@ struct win32_core_module_info
 
 struct win32_pstatus
 {
-  unsigned long data_type;
+  DWORD data_type;
   union
     {
       struct win32_core_process_info process_info;
diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index e16d80a36..dcf01e800 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -502,7 +502,11 @@ dumper::dump_module (asection * to, process_module * module)
   strncpy (header.elf_note_header.name, "win32module", NOTE_NAME_SIZE);
 #pragma GCC diagnostic pop
 
+#ifdef __x86_64__
+  module_pstatus_ptr->data_type = NOTE_INFO_MODULE64;
+#else
   module_pstatus_ptr->data_type = NOTE_INFO_MODULE;
+#endif
   module_pstatus_ptr->data.module_info.base_address = module->base_address;
   module_pstatus_ptr->data.module_info.module_name_size = strlen (module->name) + 1;
   strcpy (module_pstatus_ptr->data.module_info.module_name, module->name);
-- 
2.27.0

