Return-Path: <SRS0=Si3O=C3=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 70EA93858D28
	for <cygwin-patches@cygwin.com>; Sun,  9 Jul 2023 07:59:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 70EA93858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 36980oqA027950;
	Sun, 9 Jul 2023 01:00:50 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdr0VMPT; Sun Jul  9 01:00:44 2023
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: Make gcc-specific code in <sys/cpuset.h> compiler-agnostic
Date: Sun,  9 Jul 2023 00:59:22 -0700
Message-Id: <20230709075922.8599-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The current version of <sys/cpuset.h> cannot be compiled by Clang due to
the use of builtin versions of malloc, free, and memset.  Their presence
here was a dubious optimization anyway, so their usage has been
converted to standard library functions.

The use of __builtin_popcountl remains because Clang implements it just
like gcc does.  If/when some other compiler (Rust? Go?) runs into this
issue we can deal with specialized handling then.

The "#include <sys/cdefs>" here to define __inline can be removed since
both of the new includes sub-include it.

Addresses: https://cygwin.com/pipermail/cygwin/2023-July/253927.html
Fixes: 9cc910dd33a5 (Cygwin: Make <sys/cpuset.h> safe for c89 compilations)
Signed-off-by: Mark Geisert <mark@maxrnd.com>

---
 winsup/cygwin/include/sys/cpuset.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
index 0c95134ff..95c777cfb 100644
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
@@ -44,14 +45,14 @@ __cpuset_alloc_size (int num)
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
@@ -59,7 +60,7 @@ __cpuset_free (cpu_set_t *set)
 static __inline void
 __cpuset_zero_s (size_t siz, cpu_set_t *set)
 {
-  (void) __builtin_memset (set, 0, siz);
+  (void) memset (set, 0, siz);
 }
 
 #define CPU_SET_S(cpu, siz, set) __cpuset_set_s (cpu, siz, set)
-- 
2.39.0

