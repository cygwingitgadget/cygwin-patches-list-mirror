Return-Path: <cygwin-patches-return-9543-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 69909 invoked by alias); 4 Aug 2019 22:46:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 69888 invoked by uid 89); 4 Aug 2019 22:46:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=tot, supplies, operate, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 04 Aug 2019 22:46:05 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x74Mk4r5080184;	Sun, 4 Aug 2019 15:46:04 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpd7Csz0D; Sun Aug  4 15:45:58 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: Implement CPU_SET(3) macros
Date: Sun, 04 Aug 2019 22:46:00 -0000
Message-Id: <20190804224546.59957-1-mark@maxrnd.com>
In-Reply-To: <20190730121212.GV11632@calimero.vinschen.de>
References: <20190730121212.GV11632@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00063.txt.bz2

This patch supplies an implementation of the CPU_SET(3) processor
affinity macros as documented on the relevant Linux man page.

There is a different implementation of cpusets under libc/sys/RTEMS that
has FreeBSD compatibility and is built on top of FreeBSD bitsets.  This
implementation can be combined with that one if necessary in the future.

---
 winsup/cygwin/include/sys/cpuset.h | 64 +++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 4857b879d..2056f6af7 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -18,8 +18,8 @@ typedef __SIZE_TYPE__ __cpu_mask;
 #define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
 #define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
 
-#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
-#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
+#define __CPUELT(cpu)  ((cpu) / __NCPUBITS)
+#define __CPUMASK(cpu) ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
 
 typedef struct
 {
@@ -28,6 +28,66 @@ typedef struct
 
 int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 
+/* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
+   Allocations are padded such that full-word operations can be done easily. */
+#define CPU_ALLOC_SIZE(num) ((num+__NCPUBITS-1) / __NCPUBITS) * sizeof (__cpu_mask)
+#define CPU_ALLOC(num)      __builtin_malloc (CPU_ALLOC_SIZE(num))
+#define CPU_FREE(set)       __builtin_free (set)
+
+/* These _S macros operate on dynamically-sized cpu sets of size 'siz' bytes */
+#define CPU_ZERO_S(siz, set)    __builtin_memset (set, 0, siz)
+
+#define CPU_SET_S(cpu,siz,set) \
+	if (cpu < 8 * siz) \
+	  (set)->__bits[__CPUELT(cpu)] |= __CPUMASK(cpu);
+
+#define CPU_CLR_S(cpu,siz,set) \
+	if (cpu < 8 * siz) \
+	  (set)->__bits[__CPUELT(cpu)] &= ~(__CPUMASK(cpu));
+
+#define CPU_ISSET_S(cpu,siz,set) \
+      ({int res = 0; \
+	if (cpu < 8 * siz) \
+	  res = !!((set)->__bits[__CPUELT(cpu)] & __CPUMASK(cpu)); \
+	res;})
+
+#define CPU_COUNT_S(siz, set) \
+      ({int tot = 0;\
+	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
+	  tot += __builtin_popcountl ((set)->__bits[i]); \
+	tot;})
+
+#define CPU_AND_S(siz, dst, src1, src2) \
+	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
+	  (dst)->__bits[i] = (src1)->__bits[i] & (src2)->__bits[i];
+
+#define CPU_OR_S(siz, dst, src1, src2) \
+	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
+	  (dst)->__bits[i] = (src1)->__bits[i] | (src2)->__bits[i];
+
+#define CPU_XOR_S(siz, dst, src1, src2) \
+	for (int i = 0; i < siz / sizeof (__cpu_mask); i++) \
+	  (dst)->__bits[i] = (src1)->__bits[i] ^ (src2)->__bits[i];
+
+#define CPU_EQUAL_S(siz, src1, src2) \
+      ({int res = 1; \
+	for (int i = 0; res && i < siz / sizeof (__cpu_mask); i++) \
+	  res &= (src1)->__bits[i] == (src2)->__bits[i]; \
+	res;})
+
+/* These macros operate on fixed-size cpu sets of size __CPU_SETSIZE cpus */
+#define CPU_ZERO(set)             CPU_ZERO_S(sizeof (cpu_set_t), set)
+
+#define CPU_SET(cpu, set)         CPU_SET_S(cpu, sizeof (cpu_set_t), set)
+#define CPU_CLR(cpu, set)         CPU_CLR_S(cpu, sizeof (cpu_set_t), set)
+#define CPU_ISSET(cpu, set)       CPU_ISSET_S(cpu, sizeof (cpu_set_t), set)
+
+#define CPU_COUNT(set)            CPU_COUNT_S(sizeof (cpu_set_t), set)
+#define CPU_AND(dst, src1, src2)  CPU_AND_S(sizeof (cpu_set_t), dst, src1, src2)
+#define CPU_OR(dst, src1, src2)   CPU_OR_S(sizeof (cpu_set_t), dst, src1, src2)
+#define CPU_XOR(dst, src1, src2)  CPU_XOR_S(sizeof (cpu_set_t), dst, src1, src2)
+#define CPU_EQUAL(src1, src2)     CPU_EQUAL_S(sizeof (cpu_set_t), src1, src2)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.21.0
