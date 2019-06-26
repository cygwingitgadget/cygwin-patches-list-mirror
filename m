Return-Path: <cygwin-patches-return-9470-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19867 invoked by alias); 26 Jun 2019 09:45:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19752 invoked by uid 89); 26 Jun 2019 09:45:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 26 Jun 2019 09:45:18 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5Q9jHxu017928;	Wed, 26 Jun 2019 02:45:17 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpd1JvFdx; Wed Jun 26 02:45:08 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3] Cygwin: Fix return value of sched_getaffinity
Date: Wed, 26 Jun 2019 09:45:00 -0000
Message-Id: <20190626094456.57224-1-mark@maxrnd.com>
In-Reply-To: <20190626091641.GS5738@calimero.vinschen.de>
References: <20190626091641.GS5738@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00177.txt.bz2

Have sched_getaffinity() interface like glibc's, and provide an
undocumented internal interface __sched_getaffinity_sys() like the Linux
kernel's sched_getaffinity() for benefit of taskset(1).

---
 newlib/libc/include/sched.h            |  3 +++
 winsup/cygwin/common.din               |  1 +
 winsup/cygwin/include/cygwin/version.h |  2 +-
 winsup/cygwin/sched.cc                 | 29 +++++++++++++++++---------
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
index fc44209d6..b6425320e 100644
--- a/newlib/libc/include/sched.h
+++ b/newlib/libc/include/sched.h
@@ -116,6 +116,9 @@ int sched_get_thread_affinity (void *, size_t, cpu_set_t *);
 int sched_setaffinity (pid_t, size_t, const cpu_set_t *);
 int sched_set_thread_affinity (void *, size_t, const cpu_set_t *);
 #endif
+#ifdef __CYGWIN__
+int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
+#endif
 
 #ifdef __cplusplus
 }
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 81292ab7b..9cb67992b 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -98,6 +98,7 @@ __res_querydomain SIGFE
 __res_search SIGFE
 __res_send SIGFE
 __res_state SIGFE
+__sched_getaffinity_sys SIGFE
 __signbitd NOSIGFE
 __signbitf NOSIGFE
 __signgam NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index b70b9e281..f47055d84 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -510,7 +510,7 @@ details. */
   337: MOUNT_BINARY -> MOUNT_TEXT
   338: Export secure_getenv.
   339: Export sched_getaffinity, sched_setaffinity, pthread_getaffinity_np,
-       pthread_setaffinity_np.
+       pthread_setaffinity_np, __sched_getaffinity_sys.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index e7b44d319..fdb8ba738 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -555,8 +555,9 @@ done:
 }
 
 int
-sched_getaffinity (pid_t pid, size_t sizeof_set, cpu_set_t *set)
+__sched_getaffinity_sys (pid_t pid, size_t sizeof_set, cpu_set_t *set)
 {
+  /* Emulate Linux raw sched_getaffinity syscall for benefit of taskset(1) */
   HANDLE process = 0;
   int status = 0;
 
@@ -603,14 +604,21 @@ done:
   if (status)
     {
       set_errno (status);
-      status = -1;
-    }
-  else
-    {
-      /* Emulate documented Linux kernel behavior on successful return */
-      status = wincap.cpu_count ();
+      return -1;
     }
-  return status;
+
+  /* On successful return, we would ordinarily return 0, but instead we
+     emulate the behavior of the raw sched_getaffinity syscall on Linux. */
+  return min (sizeof_set, sizeof (cpu_set_t));
+}
+
+int
+sched_getaffinity (pid_t pid, size_t sizeof_set, cpu_set_t *set)
+{
+  /* Emulate the Linux glibc interface of sched_getaffinity() by calling
+     the raw syscall emulation and mapping positive results to 0. */
+  int status = __sched_getaffinity_sys (pid, sizeof_set, set);
+  return status > 0 ? 0 : status;
 }
 
 int
@@ -727,9 +735,10 @@ done:
   if (status)
     {
       set_errno (status);
-      status = -1;
+      return -1;
     }
-  return status;
+
+  return 0;
 }
 
 } /* extern C */
-- 
2.21.0
