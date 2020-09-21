Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-047.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id 48157398580A
 for <cygwin-patches@cygwin.com>; Mon, 21 Sep 2020 19:25:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 48157398580A
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
 by re-prd-fep-047.btinternet.com with ESMTP id
 <20200921192557.BCWG4599.re-prd-fep-047.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
 Mon, 21 Sep 2020 20:25:57 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.176.137.240]
X-OWM-Source-IP: 86.176.137.240 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddvgddugedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeefieduveehgfffffeuueehleefgeevfedvffeljeefheduteelteelvdettefhvdenucfkphepkeeirddujeeirddufeejrddvgedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudejiedrudefjedrvdegtddpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.176.137.240) by
 re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C506120E528B; Mon, 21 Sep 2020 20:25:57 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/3] Cygwin: avoid GCC 10 error with -Werror=narrowing
Date: Mon, 21 Sep 2020 20:25:26 +0100
Message-Id: <20200921192526.36773-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
References: <20200921192526.36773-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 21 Sep 2020 19:25:59 -0000

../../../../src/winsup/cygwin/pinfo.cc: In member function 'DWORD pinfo::status_exit(DWORD)':
../../../../src/winsup/cygwin/ntdll.h:21:68: error: narrowing conversion of '-536870295' from 'NTSTATUS' {aka 'int'} to 'unsigned int' [-Wnarrowing]
../../../../src/winsup/cygwin/pinfo.cc:136:10: note: in expansion of macro 'STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION'

../../../../src/winsup/cygwin/sigproc.cc: In member function 'DWORD child_info::proc_retry(HANDLE)':
../../../../src/winsup/cygwin/ntdll.h:21:68: error: narrowing conversion of '-536870295' from 'NTSTATUS' {aka 'int'} to 'unsigned int' [-Wnarrowing]
../../../../src/winsup/cygwin/sigproc.cc:1120:10: note: in expansion of macro 'STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION'

NT error statuses seem to be variously DWORD (unsigned) or NTSTATUS
(signed)?  So use the one which doesn't cause problems here.
---
 winsup/cygwin/ntdll.h         | 2 +-
 winsup/cygwin/pseudo-reloc.cc | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index 0c6ad13dc..113798e29 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -18,7 +18,7 @@ extern GUID __cygwin_socket_guid;
 /* Custom Cygwin-only status codes. */
 #define STATUS_THREAD_SIGNALED	((NTSTATUS)0xe0000001)
 #define STATUS_THREAD_CANCELED	((NTSTATUS)0xe0000002)
-#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((NTSTATUS) 0xe0000269)
+#define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((DWORD) 0xe0000269)
 
 /* Simplify checking for a transactional error code. */
 #define NT_TRANSACTIONAL_ERROR(s)	\
diff --git a/winsup/cygwin/pseudo-reloc.cc b/winsup/cygwin/pseudo-reloc.cc
index c250fdc01..d015cc5e7 100644
--- a/winsup/cygwin/pseudo-reloc.cc
+++ b/winsup/cygwin/pseudo-reloc.cc
@@ -21,8 +21,6 @@
 #else
 # include "winsup.h"
 # include <sys/cygwin.h>
-/* custom status code: */
-# define STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION ((NTSTATUS) 0xe0000269)
 #endif
 
 #include <stdio.h>
-- 
2.28.0

