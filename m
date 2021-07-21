Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 8DA95389102C
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 08:01:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8DA95389102C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 16L80xED061287;
 Wed, 21 Jul 2021 01:00:59 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpddjf9hb; Wed Jul 21 01:00:52 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fix format warnings in profiler.cc
Date: Wed, 21 Jul 2021 01:00:40 -0700
Message-Id: <20210721080040.55316-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <5acddcda-7fa9-e854-911c-27af2f13a22c@dronecode.org.uk>
References: <5acddcda-7fa9-e854-911c-27af2f13a22c@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Wed, 21 Jul 2021 08:01:03 -0000

Use new typedef to normalize pids for printing on both 32- and 64-bit Cygwin.

---
 winsup/utils/profiler.cc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/winsup/utils/profiler.cc b/winsup/utils/profiler.cc
index d1a01c3a2..152bf1cca 100644
--- a/winsup/utils/profiler.cc
+++ b/winsup/utils/profiler.cc
@@ -29,6 +29,7 @@
 #include "cygwin/version.h"
 #include "cygtls_padsize.h"
 #include "gcc_seh.h"
+typedef unsigned long ulong;
 typedef unsigned short ushort;
 typedef uint16_t u_int16_t; // Non-standard sized type needed by ancient gmon.h
 #define NO_GLOBALS_H
@@ -312,10 +313,10 @@ dump_profile_data (child *c)
       if (s->name)
         {
           WCHAR *name = 1 + wcsrchr (s->name, L'\\');
-          sprintf (filename, "%s.%u.%ls", prefix, c->pid, name);
+          sprintf (filename, "%s.%lu.%ls", prefix, (ulong) c->pid, name);
         }
       else
-        sprintf (filename, "%s.%u", prefix, c->pid);
+        sprintf (filename, "%s.%lu", prefix, (ulong) c->pid);
 
       fd = open (filename, O_CREAT | O_TRUNC | O_WRONLY | O_BINARY);
       if (fd < 0)
@@ -804,9 +805,9 @@ cygwin_pid (DWORD winpid)
   cygpid = (DWORD) cygwin_internal (CW_WINPID_TO_CYGWIN_PID, winpid);
 
   if (cygpid >= max_cygpid)
-    snprintf (buf, sizeof buf, "%u", winpid);
+    snprintf (buf, sizeof buf, "%lu", (ulong) winpid);
   else
-    snprintf (buf, sizeof buf, "%u (pid: %u)", winpid, cygpid);
+    snprintf (buf, sizeof buf, "%lu (pid: %lu)", (ulong) winpid, (ulong) cygpid);
   return buf;
 }
 
-- 
2.32.0

