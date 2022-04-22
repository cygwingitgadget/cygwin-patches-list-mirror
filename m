Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id AD2223858D37
 for <cygwin-patches@cygwin.com>; Fri, 22 Apr 2022 05:36:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AD2223858D37
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 23M5aqD7085190;
 Thu, 21 Apr 2022 22:36:52 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdaewNc9; Thu Apr 21 22:36:44 2022
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Fix "0x0x" in gmondump and ssp man pages
Date: Thu, 21 Apr 2022 22:36:33 -0700
Message-Id: <20220422053633.6128-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Fri, 22 Apr 2022 05:36:56 -0000

A recent patch fixed gmondump to stop printing "0x0x" as an address
prefix.  It turns out the Cygwin User's Guide and the gmondump and
ssp man pages (all from utils.xml) have examples of the same error.

---
 winsup/cygwin/release/3.3.5 | 2 +-
 winsup/doc/utils.xml        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/release/3.3.5 b/winsup/cygwin/release/3.3.5
index f0a834039..049d19b8c 100644
--- a/winsup/cygwin/release/3.3.5
+++ b/winsup/cygwin/release/3.3.5
@@ -42,7 +42,7 @@ Bug Fixes
   Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251022.html
 
 - Fix a formatting problem in gmondump where all displayed addresses are
-  mistakenly prefixed with "0x0x".
+  mistakenly prefixed with "0x0x". Fix man pages for gmondump and ssp.
 
 - Fix crash on pty master close in Windows 7.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-March/251162.html
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 0b9e38549..895988037 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -846,7 +846,7 @@ line separates the ACLs for each file.
 <screen>
 $ gmondump gmon.out.21900.zstd.exe
 file gmon.out.21900.zstd.exe, gmon version 0x51879, sample rate 100
-  address range 0x0x100401000..0x0x1004cc668
+  address range 0x100401000..0x1004cc668
   numbuckets 208282, hitbuckets 1199, hitcount 12124, numrawarcs 0
 </screen>
     </refsect1>
@@ -2951,7 +2951,7 @@ Idx Name          Size      VMA       LMA       File off  Algn
       section and the VMA of the section after it (sections are usually
       contiguous; you can also add the Size to the VMA to get the end address).
       In this case, the VMA is 0x61001000 and the ending address is either
-      0x61080000 (start of .data method) or 0x0x6107fa00 (VMA+Size method). </para>
+      0x61080000 (start of .data method) or 0x6107fa00 (VMA+Size method). </para>
 
     <para> There are two basic ways to use SSP - either profiling a whole
       program, or selectively profiling parts of the program. </para>
-- 
2.36.0

