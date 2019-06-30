Return-Path: <cygwin-patches-return-9479-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34923 invoked by alias); 30 Jun 2019 22:59:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 34914 invoked by uid 89); 30 Jun 2019 22:59:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=sk:GetCurr, sk:getcurr, tracked, documented
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 30 Jun 2019 22:59:23 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5UMxL9C054531;	Sun, 30 Jun 2019 15:59:21 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdlfymxZ; Sun Jun 30 15:59:16 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Implement CPU_SET(3) macros
Date: Sun, 30 Jun 2019 22:59:00 -0000
Message-Id: <20190630225904.812-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00186.txt.bz2

This patch supplies an implementation of the CPU_SET(3) processor
affinity macros as documented on the relevant Linux man page.
---
 winsup/cygwin/include/sys/cpuset.h | 62 +++++++++++++++++++++++++++---
 winsup/cygwin/sched.cc             |  8 ++--
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 4857b879d..9c8417b73 100644
--- a/winsup/cygwin/include/sys/cpuset.h
+++ b/winsup/cygwin/include/sys/cpuset.h
@@ -14,20 +14,70 @@ extern "C" {
 #endif
 
 typedef __SIZE_TYPE__ __cpu_mask;
-#define __CPU_SETSIZE 1024  // maximum number of logical processors tracked
-#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
-#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
+#define CPU_SETSIZE  1024  // maximum number of logical processors tracked
+#define NCPUBITS     (8 * sizeof (__cpu_mask))  // max size of processor group
+#define CPU_GROUPMAX (CPU_SETSIZE / NCPUBITS)  // maximum group number
 
-#define __CPUELT(cpu)   ((cpu) / __NCPUBITS)
-#define __CPUMASK(cpu)  ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
+#define CPU_WORD(cpu) ((cpu) / NCPUBITS)
+#define CPU_MASK(cpu) ((__cpu_mask) 1 << ((cpu) % NCPUBITS))
 
 typedef struct
 {
-  __cpu_mask __bits[__CPU_GROUPMAX];
+  __cpu_mask __bits[CPU_GROUPMAX];
 } cpu_set_t;
 
 int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
 
+/* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
+   Allocations are padded such that full-word operations can be done easily. */
+#define CPU_ALLOC_SIZE(num) ((num+NCPUBITS-1) / NCPUBITS) * sizeof (__cpu_mask)
+#define CPU_ALLOC(num)	    __builtin_malloc (CPU_ALLOC_SIZE(num))
+#define CPU_FREE(set)	    __builtin_free (set)
+
+/* These _S macros operate on dynamically-sized cpu sets of size 'siz' bytes */
+#define CPU_ZERO_S(siz, set)	__builtin_memset (set, 0, siz)
+
+#define CPU_SET_S(cpu,siz,set) (set)->__bits[CPU_WORD(cpu)] |= CPU_MASK(cpu)
+#define CPU_CLR_S(cpu,siz,set) (set)->__bits[CPU_WORD(cpu)] &= ~(CPU_MASK(cpu))
+#define CPU_ISSET_S(cpu,siz,set) (set)->__bits[CPU_WORD(cpu)] & CPU_MASK(cpu)
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
+/* These macros operate on fixed-size cpu sets of size CPU_SETSIZE cpus */
+#define CPU_ZERO(set)		  CPU_ZERO_S(sizeof (cpu_set_t), set)
+
+#define CPU_SET(cpu, set)	  CPU_SET_S(cpu, sizeof (cpu_set_t), set)
+#define CPU_CLR(cpu, set)	  CPU_CLR_S(cpu, sizeof (cpu_set_t), set)
+#define CPU_ISSET(cpu, set)	  CPU_ISSET_S(cpu, sizeof (cpu_set_t), set)
+
+#define CPU_COUNT(set)		  CPU_COUNT_S(sizeof (cpu_set_t), set)
+#define CPU_AND(dst, src1, src2)  CPU_AND_S(sizeof (cpu_set_t), dst, src1, src2)
+#define CPU_OR(dst, src1, src2)   CPU_OR_S(sizeof (cpu_set_t), dst, src1, src2)
+#define CPU_XOR(dst, src1, src2)  CPU_XOR_S(sizeof (cpu_set_t), dst, src1, src2)
+#define CPU_EQUAL(src1, src2)	  CPU_EQUAL_S(sizeof (cpu_set_t), src1, src2)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index fdb8ba738..73c861df9 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -578,8 +578,8 @@ __sched_getaffinity_sys (pid_t pid, size_t sizeof_set, cpu_set_t *set)
       memset (set, 0, sizeof_set);
       if (wincap.has_processor_groups () && __get_group_count () > 1)
         {
-          USHORT groupcount = __CPU_GROUPMAX;
-          USHORT grouparray[__CPU_GROUPMAX];
+          USHORT groupcount = CPU_GROUPMAX;
+          USHORT grouparray[CPU_GROUPMAX];
 
           if (!GetProcessGroupAffinity (process, &groupcount, grouparray))
             {
@@ -683,8 +683,8 @@ sched_setaffinity (pid_t pid, size_t sizeof_set, const cpu_set_t *set)
 			     p->dwProcessId) : GetCurrentProcess ();
       if (wincap.has_processor_groups () && __get_group_count () > 1)
 	{
-	  USHORT groupcount = __CPU_GROUPMAX;
-	  USHORT grouparray[__CPU_GROUPMAX];
+	  USHORT groupcount = CPU_GROUPMAX;
+	  USHORT grouparray[CPU_GROUPMAX];
 
 	  if (!GetProcessGroupAffinity (process, &groupcount, grouparray))
 	    {
-- 
2.21.0
