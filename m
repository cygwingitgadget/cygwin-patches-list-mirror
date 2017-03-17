Return-Path: <cygwin-patches-return-8714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120318 invoked by alias); 17 Mar 2017 17:50:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119416 invoked by uid 89); 17 Mar 2017 17:50:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:D*org.uk, Jon, HX-Junkmail-Premium-Raw:score, H*r:9.0.019
X-HELO: rgout05.bt.lon5.cpcloud.co.uk
Received: from rgout0507.bt.lon5.cpcloud.co.uk (HELO rgout05.bt.lon5.cpcloud.co.uk) (65.20.0.228) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Mar 2017 17:50:47 +0000
X-OWM-Source-IP: 86.141.128.75 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2016.12.19.183017:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, TO_MALFORMED, NO_URI_HTTPS
Received: from localhost.localdomain (86.141.128.75) by rgout05.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58482E590A1070B2; Fri, 17 Mar 2017 17:50:45 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Implement getloadavg()
Date: Fri, 17 Mar 2017 17:50:00 -0000
Message-Id: <20170317175032.26780-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00055.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/Makefile.in              |   5 +-
 winsup/cygwin/common.din               |   1 +
 winsup/cygwin/fhandler_proc.cc         |  10 ++-
 winsup/cygwin/include/cygwin/stdlib.h  |   4 +
 winsup/cygwin/include/cygwin/version.h |   3 +-
 winsup/cygwin/loadavg.cc               | 135 +++++++++++++++++++++++++++++++++
 winsup/doc/posix.xml                   |   1 +
 7 files changed, 154 insertions(+), 5 deletions(-)
 create mode 100644 winsup/cygwin/loadavg.cc

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index c8652b0..5e719a6 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -147,7 +147,9 @@ EXTRA_OFILES:=
 
 MALLOC_OFILES:=malloc.o
 
-DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} ${shell $(CC) -print-file-name=w32api/libntdll.a}
+DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} \
+	${shell $(CC) -print-file-name=w32api/libntdll.a} \
+	${shell $(CC) -print-file-name=w32api/libpdh.a}
 
 MT_SAFE_OBJECTS:=
 #
@@ -323,6 +325,7 @@ DLL_OFILES:= \
 	kernel32.o \
 	ldap.o \
 	libstdcxx_wrapper.o \
+	loadavg.o \
 	localtime.o \
 	lsearch.o \
 	malloc_wrapper.o \
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index f236813..8e54a7d 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -624,6 +624,7 @@ gethostname = cygwin_gethostname SIGFE
 getifaddrs SIGFE
 getitimer SIGFE
 getline = __getline SIGFE
+getloadavg SIGFE
 getlogin NOSIGFE
 getlogin_r NOSIGFE
 getmntent SIGFE
diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 2a8cf14..a7e816f 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -418,7 +418,7 @@ static off_t
 format_proc_loadavg (void *, char *&destbuf)
 {
   extern int get_process_state (DWORD dwProcessId);
-  unsigned running = 0;
+  unsigned int running = 0;
   winpids pids ((DWORD) 0);
 
   for (unsigned i = 0; i < pids.npids; i++)
@@ -429,9 +429,13 @@ format_proc_loadavg (void *, char *&destbuf)
 	break;
     }
 
+  double loadavg[3] = { 0.0, 0.0, 0.0 };
+  getloadavg (loadavg, 3);
+
   destbuf = (char *) crealloc_abort (destbuf, 48);
-  return __small_sprintf (destbuf, "%u.%02u %u.%02u %u.%02u %u/%u\n",
-				    0, 0, 0, 0, 0, 0, running, pids.npids);
+  return sprintf (destbuf, "%.2f %.2f %.2f %u/%u\n",
+		  loadavg[0], loadavg[1], loadavg[2], running,
+		  (unsigned int)pids.npids);
 }
 
 static off_t
diff --git a/winsup/cygwin/include/cygwin/stdlib.h b/winsup/cygwin/include/cygwin/stdlib.h
index 744a08d..a8eb4de 100644
--- a/winsup/cygwin/include/cygwin/stdlib.h
+++ b/winsup/cygwin/include/cygwin/stdlib.h
@@ -77,6 +77,10 @@ extern _PTR valloc _PARAMS ((size_t));
 #undef _mstats_r
 #define _mstats_r(r, p) mstats (p)
 
+#if __BSD_VISIBLE
+int getloadavg(double loadavg[], int nelem);
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 6ca3079..298741a 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -473,12 +473,13 @@ details. */
   306: Export getentropy, getrandom.
   307: Export timingsafe_bcmp, timingsafe_memcmp.
   308: Export dladdr.
+  309: Export getloadavg.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 308
+#define CYGWIN_VERSION_API_MINOR 309
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
new file mode 100644
index 0000000..63d8b3e
--- /dev/null
+++ b/winsup/cygwin/loadavg.cc
@@ -0,0 +1,135 @@
+/* loadavg.cc: load average support.
+
+  This file is part of Cygwin.
+
+  This software is a copyrighted work licensed under the terms of the
+  Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+  details. */
+
+/*
+  Emulate load average
+
+  There's a fair amount of approximation done here, so don't try to use this to
+  actually measure anything, but it should be good enough for programs to
+  throttle their activity based on load.
+
+  A per-process load average estimate is maintained.  This estimate is only
+  updated at most every 5 seconds.
+
+  We attempt to count running and runnable processes, but unlike linux we don't
+  count processes in uninterruptible sleep (blocked on I/O).
+
+  The number of running processes is estimated as (NumberOfProcessors) * (%
+  Processor Time).  The number of runnable processes is estimated as
+  ProcessorQueueLength.
+
+  Note that PDH will only return data for '% Processor Time' afer the second
+  call to PdhCollectQueryData(), as it's computed over an interval, so the first
+  load estimate will always be 0.
+*/
+
+#include <math.h>
+#include <time.h>
+#include <sys/strace.h>
+
+#define _WIN32_WINNT 0x0600
+#include <pdh.h>
+
+static double _loadavg[3] = { 0.0, 0.0, 0.0 };
+static PDH_HQUERY query;
+static PDH_HCOUNTER counter1;
+static PDH_HCOUNTER counter2;
+
+static bool load_init (void)
+{
+  static bool tried = false;
+  static bool initialized = false;
+
+  if (!tried) {
+    tried = true;
+
+    if ((PdhOpenQueryA (NULL, 0, &query) == ERROR_SUCCESS) &&
+	(PdhAddEnglishCounterA (query, "\\Processor(_Total)\\% Processor Time",
+				0, &counter1) == ERROR_SUCCESS) &&
+	(PdhAddEnglishCounterA (query, "\\System\\Processor Queue Length",
+				0, &counter2) == ERROR_SUCCESS)) {
+      initialized = true;
+    } else {
+      debug_printf("loadavg PDH initialization failed\n");
+    }
+  }
+
+  return initialized;
+}
+
+/* estimate the current load */
+static double load (void)
+{
+  PDH_STATUS ret = PdhCollectQueryData (query);
+  if (ret != ERROR_SUCCESS)
+    return 0.0;
+
+  /* Estimate the number of running processes as (NumberOfProcessors) * (%
+     Processor Time) */
+  PDH_FMT_COUNTERVALUE fmtvalue1;
+  ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
+  if (ret != ERROR_SUCCESS)
+    return 0.0;
+
+  SYSTEM_INFO sysinfo;
+  GetSystemInfo (&sysinfo);
+
+  double running = fmtvalue1.doubleValue * sysinfo.dwNumberOfProcessors / 100;
+
+  /* Estimate the number of runnable processes using ProcessorQueueLength */
+  PDH_FMT_COUNTERVALUE fmtvalue2;
+  ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
+  if (ret != ERROR_SUCCESS)
+    return 0.0;
+
+  LONG rql = fmtvalue2.longValue;
+
+  return rql + running;
+}
+
+static void calc_load (int index, int delta_time, int decay_time, double n)
+{
+  double df = 1.0 / exp ((double)delta_time/decay_time);
+  _loadavg[index] = (_loadavg[index] * df) + (n * (1.0 - df));
+}
+
+static void update_loadavg (int delta_time)
+{
+  if (!load_init ())
+    return;
+
+  double active_tasks = load ();
+
+  /* Compute the exponentially weighted moving average over ... */
+  calc_load (0, delta_time, 60,  active_tasks); /* ... 1 min */
+  calc_load (1, delta_time, 300, active_tasks); /* ... 5 min */
+  calc_load (2, delta_time, 900, active_tasks); /* ... 15 min */
+}
+
+/* getloadavg: BSD */
+extern "C" int
+getloadavg (double loadavg[], int nelem)
+{
+  /* Don't recalculate the load average if less than 5 seconds has elapsed since
+     the last time it was calculated */
+  static time_t last_time = 0;
+  time_t curr_time = time (NULL);
+  int delta_time = curr_time - last_time;
+  if (delta_time >= 5) {
+    last_time = curr_time;
+    update_loadavg (delta_time);
+  }
+
+  /* The maximum number of samples is 3 */
+  if (nelem > 3)
+    nelem = 3;
+
+  /* Return the samples and number of samples retrieved */
+  memcpy (loadavg, _loadavg, nelem * sizeof(double));
+  return nelem;
+}
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 03d168d..a3b2e9f 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1173,6 +1173,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     getdtablesize
     getgrouplist
     getifaddrs
+    getloadavg
     getpagesize
     getpeereid
     getprogname
-- 
2.8.3
