Return-Path: <SRS0=gc88=CV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 7AA343858D28
	for <cygwin-patches@cygwin.com>; Mon,  3 Jul 2023 06:17:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7AA343858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 3636J5hL046347;
	Sun, 2 Jul 2023 23:19:05 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpds0IYQk; Sun Jul  2 23:18:57 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
Date: Sun,  2 Jul 2023 23:17:30 -0700
Message-Id: <20230703061730.5147-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Three modifications to include/sys/cpuset.h:
* Change C++-style comments to C-style also supported by C++
* Change "inline" to "__inline" on code lines
* Don't declare loop variables on for-loop init clauses

Tested by first reproducing the reported issue with home-grown test
programs by compiling with gcc option "-std=c89", then compiling again
using the modified <sys/cpuset.h>. Other "-std=" options tested too.

Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")

---
 winsup/cygwin/include/sys/cpuset.h | 47 ++++++++++++++++--------------
 winsup/cygwin/release/3.4.7        |  3 ++
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index d83359fdf..01576b041 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -14,9 +14,9 @@ extern "C" {
 #endif
 
 typedef __SIZE_TYPE__ __cpu_mask;
-#define __CPU_SETSIZE 1024  // maximum number of logical processors tracked
-#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
-#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
+#define __CPU_SETSIZE 1024  /* maximum number of logical processors tracked */
+#define __NCPUBITS (8 * sizeof (__cpu_mask))  /* max size of processor group */
+#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  /* maximum group number */
 
 #define __CPUELT(cpu)  ((cpu) / __NCPUBITS)
 #define __CPUMASK(cpu) ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
@@ -32,21 +32,21 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 /* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
    Allocations are padded such that full-word operations can be done easily. */
 #define CPU_ALLOC_SIZE(num) __cpuset_alloc_size (num)
-static inline size_t
+static __inline size_t
 __cpuset_alloc_size (int num)
 {
   return (size_t) (((num + __NCPUBITS - 1) / __NCPUBITS) * sizeof (__cpu_mask));
 }
 
 #define CPU_ALLOC(num) __cpuset_alloc (num)
-static inline cpu_set_t *
+static __inline cpu_set_t *
 __cpuset_alloc (int num)
 {
   return (cpu_set_t *) __builtin_malloc (CPU_ALLOC_SIZE(num));
 }
 
 #define CPU_FREE(set) __cpuset_free (set)
-static inline void
+static __inline void
 __cpuset_free (cpu_set_t *set)
 {
   __builtin_free (set);
@@ -54,14 +54,14 @@ __cpuset_free (cpu_set_t *set)
 
 /* These _S macros operate on dynamically-sized cpu sets of size 'siz' bytes */
 #define CPU_ZERO_S(siz, set) __cpuset_zero_s (siz, set)
-static inline void
+static __inline void
 __cpuset_zero_s (size_t siz, cpu_set_t *set)
 {
   (void) __builtin_memset (set, 0, siz);
 }
 
 #define CPU_SET_S(cpu, siz, set) __cpuset_set_s (cpu, siz, set)
-static inline void
+static __inline void
 __cpuset_set_s (int cpu, size_t siz, cpu_set_t *set)
 {
   if (cpu >= 0 && cpu < 8 * siz)
@@ -69,7 +69,7 @@ __cpuset_set_s (int cpu, size_t siz, cpu_set_t *set)
 }
 
 #define CPU_CLR_S(cpu, siz, set) __cpuset_clr_s (cpu, siz, set)
-static inline void
+static __inline void
 __cpuset_clr_s (int cpu, size_t siz, cpu_set_t *set)
 {
   if (cpu >= 0 && cpu < 8 * siz)
@@ -77,7 +77,7 @@ __cpuset_clr_s (int cpu, size_t siz, cpu_set_t *set)
 }
 
 #define CPU_ISSET_S(cpu, siz, set) __cpuset_isset_s (cpu, siz, set)
-static inline int
+static __inline int
 __cpuset_isset_s (int cpu, size_t siz, cpu_set_t *set)
 {
   int res = 0;
@@ -87,45 +87,48 @@ __cpuset_isset_s (int cpu, size_t siz, cpu_set_t *set)
 }
 
 #define CPU_COUNT_S(siz, set) __cpuset_count_s (siz, set)
-static inline int
+static __inline int
 __cpuset_count_s (size_t siz, cpu_set_t *set)
 {
-  int res = 0;
-  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+  int i, res = 0;
+  for (i = 0; i < siz / sizeof (__cpu_mask); i++)
     res += __builtin_popcountl ((set)->__bits[i]);
   return res;
 }
 
 #define CPU_AND_S(siz, dst, src1, src2) __cpuset_and_s (siz, dst, src1, src2)
-static inline void
+static __inline void
 __cpuset_and_s (size_t siz, cpu_set_t *dst, cpu_set_t *src1, cpu_set_t *src2)
 {
-  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+  int i;
+  for (i = 0; i < siz / sizeof (__cpu_mask); i++)
     (dst)->__bits[i] = (src1)->__bits[i] & (src2)->__bits[i];
 }
 
 #define CPU_OR_S(siz, dst, src1, src2) __cpuset_or_s (siz, dst, src1, src2)
-static inline void
+static __inline void
 __cpuset_or_s (size_t siz, cpu_set_t *dst, cpu_set_t *src1, cpu_set_t *src2)
 {
-  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+  int i;
+  for (i = 0; i < siz / sizeof (__cpu_mask); i++)
     (dst)->__bits[i] = (src1)->__bits[i] | (src2)->__bits[i];
 }
 
 #define CPU_XOR_S(siz, dst, src1, src2) __cpuset_xor_s (siz, dst, src1, src2)
-static inline void
+static __inline void
 __cpuset_xor_s (size_t siz, cpu_set_t *dst, cpu_set_t *src1, cpu_set_t *src2)
 {
-  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+  int i;
+  for (i = 0; i < siz / sizeof (__cpu_mask); i++)
     (dst)->__bits[i] = (src1)->__bits[i] ^ (src2)->__bits[i];
 }
 
 #define CPU_EQUAL_S(siz, src1, src2) __cpuset_equal_s (siz, src1, src2)
-static inline int
+static __inline int
 __cpuset_equal_s (size_t siz, cpu_set_t *src1, cpu_set_t *src2)
 {
-  int res = 1;
-  for (int i = 0; res && i < siz / sizeof (__cpu_mask); i++)
+  int i, res = 1;
+  for (i = 0; res && i < siz / sizeof (__cpu_mask); i++)
     res &= (src1)->__bits[i] == (src2)->__bits[i];
   return res;
 }
diff --git a/winsup/cygwin/release/3.4.7 b/winsup/cygwin/release/3.4.7
index 0e6922163..923408ec2 100644
--- a/winsup/cygwin/release/3.4.7
+++ b/winsup/cygwin/release/3.4.7
@@ -25,3 +25,6 @@ Bug Fixes
 - Fix return code and errno set by renameat2, if oldfile and newfile
   refer to the same file, and the RENAME_NOREPLACE flag is set.
   Addresses: https://cygwin.com/pipermail/cygwin/2023-April/253514.html
+
+- Make <sys/cpuset.h> safe for c89 compilations.
+  Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
-- 
2.39.0

