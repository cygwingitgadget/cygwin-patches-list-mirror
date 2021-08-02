Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id CE9453853C07
 for <cygwin-patches@cygwin.com>; Mon,  2 Aug 2021 09:26:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CE9453853C07
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 1729QB7p065820;
 Mon, 2 Aug 2021 02:26:11 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdg8lMe9; Mon Aug  2 02:26:05 2021
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Make gmondump conform to its doc + adjust doc
Date: Mon,  2 Aug 2021 02:25:53 -0700
Message-Id: <20210802092553.1268-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.32.0
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
X-List-Received-Date: Mon, 02 Aug 2021 09:26:16 -0000

The doc for gmondump says 1 or more FILENAME are expected, but 0 is
handled. That's an oversight. Make invocation with 0 FILENAMEs print a
one-line help message.

Reword the beginning of profiler's description doc to clarify target's
child processes are run but only optionally profiled.

---
 winsup/doc/utils.xml    |  7 ++++---
 winsup/utils/gmondump.c | 12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 659541f00..0b9e38549 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -2240,9 +2240,10 @@ specifying an empty password.
 
     <refsect1 id="profiler-desc">
       <title>Description</title>
-    <para>The <command>profiler</command> utility executes a given program, and
-      optionally the children of that program, collecting the location of the
-      CPU instruction pointer (IP) many times per second. This gives a profile
+    <para>The <command>profiler</command> utility executes a given program and
+      any children of that program, collecting the location of the CPU
+      instruction pointer (IP) many times per second. (It is optional to
+      collect this info from child processes.) This info gives a profile
       of the program's execution, showing where the most time is being spent.
       This profiling technique is called "IP sampling".</para>
 
diff --git a/winsup/utils/gmondump.c b/winsup/utils/gmondump.c
index e469f01f1..ec9db0598 100644
--- a/winsup/utils/gmondump.c
+++ b/winsup/utils/gmondump.c
@@ -46,6 +46,14 @@ OPTIONS are:\n\
   exit (where == stderr ? 1 : 0 );
 }
 
+void __attribute__ ((__noreturn__))
+usage1 (FILE *where)
+{
+  fprintf (where, "Usage: %s [OPTIONS] FILENAME...\n", pgm);
+
+  exit (where == stderr ? 1 : 0 );
+}
+
 void
 note (const char *fmt, ...)
 {
@@ -248,6 +256,10 @@ main(int argc, char **argv)
         ;
       }
 
+  if (optind >= argc)
+    /* Print one-line help and exit. */
+    usage1 (ofile);
+
   for (int i = optind; i < argc; i++)
     gmondump1 (argv[i]);
 
-- 
2.32.0

