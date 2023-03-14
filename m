Return-Path: <SRS0=TS+g=7G=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id C43ED3858D32
	for <cygwin-patches@cygwin.com>; Tue, 14 Mar 2023 08:56:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C43ED3858D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 32E8uJKM004324;
	Tue, 14 Mar 2023 01:56:19 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 76-217-4-51.lightspeed.irvnca.sbcglobal.net(76.217.4.51), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdBe4qXz; Tue Mar 14 00:56:12 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: Fix type mismatch on sys/cpuset.h
Date: Tue, 14 Mar 2023 01:56:01 -0700
Message-Id: <20230314085601.18635-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html

Take the opportunity to follow FreeBSD's and Linux's lead in recasting
macro inline code as calls to static inline functions.  This allows the
macros to be type-safe.  In addition, added a lower bound check to the
functions that use a cpu number to avoid a potential buffer underrun on
a bad argument.  h/t to Corinna for the advice on recasting.

Fixes: 362b98b49af5 ("Cygwin: Implement CPU_SET(3) macros")

---
 winsup/cygwin/include/sys/cpuset.h | 138 ++++++++++++++++++++---------
 winsup/cygwin/release/3.4.7        |   5 ++
 2 files changed, 101 insertions(+), 42 deletions(-)
 create mode 100644 winsup/cygwin/release/3.4.7

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 572565165..d83359fdf 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -31,50 +31,104 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 
 /* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
    Allocations are padded such that full-word operations can be done easily. */
-#define CPU_ALLOC_SIZE(num) ((num+__NCPUBITS-1) / __NCPUBITS) * sizeof (__cpu_mask)
-#define CPU_ALLOC(num)      __builtin_malloc (CPU_ALLOC_SIZE(num))
-#define CPU_FREE(set)       __builtin_free (set)
+#define CPU_ALLOC_SIZE(num) __cpuset_alloc_size (num)
+static inline size_t
+__cpuset_alloc_size (int num)
+{
+  return (size_t) (((num + __NCPUBITS - 1) / __NCPUBITS) * sizeof (__cpu_mask));
+}
+
+#define CPU_ALLOC(num) __cpuset_alloc (num)
+static inline cpu_set_t *
+__cpuset_alloc (int num)
+{
+  return (cpu_set_t *) __builtin_malloc (CPU_ALLOC_SIZE(num));
+}
+
+#define CPU_FREE(set) __cpuset_free (set)
+static inline void
+__cpuset_free (cpu_set_t *set)
+{
+  __builtin_free (set);
+}
 
 /* These _S macros operate on dynamically-sized cpu sets of size 'siz' bytes */
-#define CPU_ZERO_S(siz, set)    __builtin_memset (set, 0, siz)
-
-#define CPU_SET_S(cpu,siz,set) \
-	if (cpu < 8 * siz) \
-	  (set)->__bits[__CPUELT(cpu)] |= __CPUMASK(cpu);
-
-#define CPU_CLR_S(cpu,siz,set) \
-	if (cpu < 8 * siz) \
-	  (set)->__bits[__CPUELT(cpu)] &= ~(__CPUMASK(cpu));
-
-#define CPU_ISSET_S(cpu,siz,set) \
-      ({int res = 0; \
-	if (cpu < 8 * siz) \
-	  res = !!((set)->__bits[__CPUELT(cpu)] & __CPUMASK(cpu)); \
-	res;})
-
-#define CPU_COUNT_S(siz, set) \
-      ({int tot = 0;\
-	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
-	  tot += __builtin_popcountl ((set)->__bits[i]); \
-	tot;})
-
-#define CPU_AND_S(siz, dst, src1, src2) \
-	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
-	  (dst)->__bits[i] = (src1)->__bits[i] & (src2)->__bits[i];
-
-#define CPU_OR_S(siz, dst, src1, src2) \
-	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
-	  (dst)->__bits[i] = (src1)->__bits[i] | (src2)->__bits[i];
-
-#define CPU_XOR_S(siz, dst, src1, src2) \
-	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
-	  (dst)->__bits[i] = (src1)->__bits[i] ^ (src2)->__bits[i];
-
-#define CPU_EQUAL_S(siz, src1, src2) \
-      ({int res = 1; \
-	for (int i = 0; res && i < siz / sizeof (__cpu_mask); i++) \
-	  res &= (src1)->__bits[i] == (src2)->__bits[i]; \
-	res;})
+#define CPU_ZERO_S(siz, set) __cpuset_zero_s (siz, set)
+static inline void
+__cpuset_zero_s (size_t siz, cpu_set_t *set)
+{
+  (void) __builtin_memset (set, 0, siz);
+}
+
+#define CPU_SET_S(cpu, siz, set) __cpuset_set_s (cpu, siz, set)
+static inline void
+__cpuset_set_s (int cpu, size_t siz, cpu_set_t *set)
+{
+  if (cpu >= 0 && cpu < 8 * siz)
+    (set)->__bits[__CPUELT(cpu)] |= __CPUMASK(cpu);
+}
+
+#define CPU_CLR_S(cpu, siz, set) __cpuset_clr_s (cpu, siz, set)
+static inline void
+__cpuset_clr_s (int cpu, size_t siz, cpu_set_t *set)
+{
+  if (cpu >= 0 && cpu < 8 * siz)
+    (set)->__bits[__CPUELT(cpu)] &= ~(__CPUMASK(cpu));
+}
+
+#define CPU_ISSET_S(cpu, siz, set) __cpuset_isset_s (cpu, siz, set)
+static inline int
+__cpuset_isset_s (int cpu, size_t siz, cpu_set_t *set)
+{
+  int res = 0;
+  if (cpu >= 0 && cpu < 8 * siz)
+    res = !!((set)->__bits[__CPUELT(cpu)] & __CPUMASK(cpu));
+  return res;
+}
+
+#define CPU_COUNT_S(siz, set) __cpuset_count_s (siz, set)
+static inline int
+__cpuset_count_s (size_t siz, cpu_set_t *set)
+{
+  int res = 0;
+  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+    res += __builtin_popcountl ((set)->__bits[i]);
+  return res;
+}
+
+#define CPU_AND_S(siz, dst, src1, src2) __cpuset_and_s (siz, dst, src1, src2)
+static inline void
+__cpuset_and_s (size_t siz, cpu_set_t *dst, cpu_set_t *src1, cpu_set_t *src2)
+{
+  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+    (dst)->__bits[i] = (src1)->__bits[i] & (src2)->__bits[i];
+}
+
+#define CPU_OR_S(siz, dst, src1, src2) __cpuset_or_s (siz, dst, src1, src2)
+static inline void
+__cpuset_or_s (size_t siz, cpu_set_t *dst, cpu_set_t *src1, cpu_set_t *src2)
+{
+  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+    (dst)->__bits[i] = (src1)->__bits[i] | (src2)->__bits[i];
+}
+
+#define CPU_XOR_S(siz, dst, src1, src2) __cpuset_xor_s (siz, dst, src1, src2)
+static inline void
+__cpuset_xor_s (size_t siz, cpu_set_t *dst, cpu_set_t *src1, cpu_set_t *src2)
+{
+  for (int i = 0; i < siz / sizeof (__cpu_mask); i++)
+    (dst)->__bits[i] = (src1)->__bits[i] ^ (src2)->__bits[i];
+}
+
+#define CPU_EQUAL_S(siz, src1, src2) __cpuset_equal_s (siz, src1, src2)
+static inline int
+__cpuset_equal_s (size_t siz, cpu_set_t *src1, cpu_set_t *src2)
+{
+  int res = 1;
+  for (int i = 0; res && i < siz / sizeof (__cpu_mask); i++)
+    res &= (src1)->__bits[i] == (src2)->__bits[i];
+  return res;
+}
 
 /* These macros operate on fixed-size cpu sets of size __CPU_SETSIZE cpus */
 #define CPU_ZERO(set)             CPU_ZERO_S(sizeof (cpu_set_t), set)
diff --git a/winsup/cygwin/release/3.4.7 b/winsup/cygwin/release/3.4.7
new file mode 100644
index 000000000..eba5de473
--- /dev/null
+++ b/winsup/cygwin/release/3.4.7
@@ -0,0 +1,5 @@
+Bug Fixes
+---------
+
+Fix CPU_SET(3) macro type mismatch by making the macros type-safe.
+Addresses https://cygwin.com/pipermail/cygwin/2023-March/253220.html
-- 
2.39.0

