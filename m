Return-Path: <SRS0=7Azx=CZ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id EE8E13858C60
	for <cygwin-patches@cygwin.com>; Fri,  7 Jul 2023 07:41:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EE8E13858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3677gq2e063058;
	Fri, 7 Jul 2023 00:42:52 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdOvyRrk; Fri Jul  7 00:42:46 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Make gcc-specific code in <sys/cpuset.h> compiler-agnostic
Date: Fri,  7 Jul 2023 00:41:21 -0700
Message-Id: <20230707074121.7880-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The current version of <sys/cpuset.h> cannot be compiled by Clang due to
the use of __builtin* functions.  Their presence here was a dubious
optimization anyway, so their usage has been converted to standard
library functions.  A popcnt (population count of 1 bits in a word)
function is provided here because there isn't one in the standard library
or elsewhere in the Cygwin DLL.

The "#include <sys/cdefs>" here to define __inline can be removed since
both of the new includes sub-include it.

Addresses: https://cygwin.com/pipermail/cygwin/2023-July/253927.html
Fixes: 9cc910dd33a5 (Cygwin: Make <sys/cpuset.h> safe for c89 compilations)
Signed-off-by: Mark Geisert <mark@maxrnd.com>

---
 winsup/cygwin/include/sys/cpuset.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 0c95134ff..f76e788d5 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -9,7 +9,8 @@ details. */
 #ifndef _SYS_CPUSET_H_
 #define _SYS_CPUSET_H_
 
-#include <sys/cdefs.h>
+#include <stdlib.h>
+#include <string.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -31,6 +32,23 @@ typedef struct
 #if __GNU_VISIBLE
 int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 
+/* Modern CPUs have popcnt* instructions but the need here is not worth
+ * worrying about builtins or inline assembler for different compilers. */ 
+static inline int
+__maskpopcnt (__cpu_mask mask)
+{
+  int res = 0;
+  unsigned long ulmask = (unsigned long) mask;
+
+  while (ulmask != 0)
+    {
+      if (ulmask & 1)
+        ++res;
+      ulmask >>= 1;
+    }
+  return res;
+}
+
 /* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
    Allocations are padded such that full-word operations can be done easily. */
 #define CPU_ALLOC_SIZE(num) __cpuset_alloc_size (num)
@@ -44,14 +62,14 @@ __cpuset_alloc_size (int num)
 static __inline cpu_set_t *
 __cpuset_alloc (int num)
 {
-  return (cpu_set_t *) __builtin_malloc (CPU_ALLOC_SIZE(num));
+  return (cpu_set_t *) malloc (CPU_ALLOC_SIZE(num));
 }
 
 #define CPU_FREE(set) __cpuset_free (set)
 static __inline void
 __cpuset_free (cpu_set_t *set)
 {
-  __builtin_free (set);
+  free (set);
 }
 
 /* These _S macros operate on dynamically-sized cpu sets of size 'siz' bytes */
@@ -59,7 +77,7 @@ __cpuset_free (cpu_set_t *set)
 static __inline void
 __cpuset_zero_s (size_t siz, cpu_set_t *set)
 {
-  (void) __builtin_memset (set, 0, siz);
+  (void) memset (set, 0, siz);
 }
 
 #define CPU_SET_S(cpu, siz, set) __cpuset_set_s (cpu, siz, set)
@@ -94,7 +112,7 @@ __cpuset_count_s (size_t siz, cpu_set_t *set)
 {
   int i, res = 0;
   for (i = 0; i < siz / sizeof (__cpu_mask); i++)
-    res += __builtin_popcountl ((set)->__bits[i]);
+    res += __maskpopcnt ((set)->__bits[i]);
   return res;
 }
 
-- 
2.39.0

