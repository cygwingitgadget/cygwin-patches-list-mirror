Return-Path: <cygwin-patches-return-8723-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10299 invoked by alias); 21 Mar 2017 13:44:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10231 invoked by uid 89); 21 Mar 2017 13:44:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=sk:obcasei, Prototype, HX-Junkmail-Premium-Raw:NO_URI_HTTPS, 4299
X-HELO: rgout0705.bt.lon5.cpcloud.co.uk
Received: from rgout0705.bt.lon5.cpcloud.co.uk (HELO rgout0705.bt.lon5.cpcloud.co.uk) (65.20.0.145) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 21 Mar 2017 13:43:58 +0000
X-OWM-Source-IP: 86.141.128.75 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2017.3.21.131215:17:7.944,ip=,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __URI_NO_WWW, __STOCK_PHRASE_7, __NO_HTML_TAG_RAW, BODY_SIZE_10000_PLUS, __MIME_TEXT_P1, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, IN_REP_TO, MSG_THREAD, __FROM_DOMAIN_IN_RCPT, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, __MIME_TEXT_P, REFERENCES, NO_URI_HTTPS
Received: from localhost.localdomain (86.141.128.75) by rgout07.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58BFF27E016838D7; Tue, 21 Mar 2017 13:43:55 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Implement getloadavg() [v2]
Date: Tue, 21 Mar 2017 13:44:00 -0000
Message-Id: <20170321134341.132464-1-jon.turney@dronecode.org.uk>
In-Reply-To: <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk>
References: <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00064.txt.bz2

v2:
autoload PerfDataHelper functions
Keep loadavg in shared memory
Guard loadavg access by a mutex
Initialize loadavg to the current load

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/Makefile.in              |   1 +
 winsup/cygwin/autoload.cc              |   6 ++
 winsup/cygwin/common.din               |   1 +
 winsup/cygwin/fhandler_proc.cc         |  10 +-
 winsup/cygwin/include/cygwin/stdlib.h  |   4 +
 winsup/cygwin/include/cygwin/version.h |   5 +-
 winsup/cygwin/loadavg.cc               | 192 +++++++++++++++++++++++++++++++++
 winsup/cygwin/loadavg.h                |  24 +++++
 winsup/cygwin/shared.cc                |   1 +
 winsup/cygwin/shared_info.h            |   2 +
 winsup/doc/posix.xml                   |   1 +
 11 files changed, 242 insertions(+), 5 deletions(-)
 create mode 100644 winsup/cygwin/loadavg.cc
 create mode 100644 winsup/cygwin/loadavg.h

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index c8652b0..10e6b1f 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -323,6 +323,7 @@ DLL_OFILES:= \
 	kernel32.o \
 	ldap.o \
 	libstdcxx_wrapper.o \
+	loadavg.o \
 	localtime.o \
 	lsearch.o \
 	malloc_wrapper.o \
diff --git a/winsup/cygwin/autoload.cc b/winsup/cygwin/autoload.cc
index df06013..785c0b7 100644
--- a/winsup/cygwin/autoload.cc
+++ b/winsup/cygwin/autoload.cc
@@ -730,4 +730,10 @@ LoadDLLfunc (WSASetLastError, 4, ws2_32)
 LoadDLLfunc (WSASocketW, 24, ws2_32)
 // LoadDLLfunc (WSAStartup, 8, ws2_32)
 LoadDLLfunc (WSAWaitForMultipleEvents, 20, ws2_32)
+
+LoadDLLfunc (PdhAddCounterA, 16, pdh)
+LoadDLLfunc (PdhAddEnglishCounterA, 16, pdh)
+LoadDLLfunc (PdhCollectQueryData, 4, pdh)
+LoadDLLfunc (PdhGetFormattedCounterValue, 16, pdh)
+LoadDLLfunc (PdhOpenQueryA, 12, pdh)
 }
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
index 6ca3079..b6e176b 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -473,18 +473,19 @@ details. */
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
    memory region *or* to any named shared mutexes, semaphores, etc. */
 
-#define CYGWIN_VERSION_SHARED_DATA 5
+#define CYGWIN_VERSION_SHARED_DATA 6
 
 /* An identifier used in the names used to create shared objects.  The full
    names include the CYGWIN_VERSION_SHARED_DATA version as well as this
diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
new file mode 100644
index 0000000..cfcba40
--- /dev/null
+++ b/winsup/cygwin/loadavg.cc
@@ -0,0 +1,192 @@
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
+  A global load average estimate is maintained in shared memory.  Access to that
+  is guarded by a mutex.  This estimate is only updated at most every 5 seconds.
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
+  attempt to estimate load will fail and 0.0 will be returned.
+
+  We also assume that '% Processor Time' averaged over the interval since the
+  last time getloadavg() was called is a good approximation of the instantaneous
+  '% Processor Time'.
+*/
+
+#include "winsup.h"
+#include "shared_info.h"
+#include "loadavg.h"
+
+#include <math.h>
+#include <time.h>
+#include <sys/strace.h>
+
+/* Prototype for PdhAddEnglishCounterA in pdh.h under _WIN32_WINNT >= 0x0600 is
+   missing WINAPI */
+#undef	_WIN32_WINNT
+#include <pdh.h>
+extern "C"
+PDH_FUNCTION PdhAddEnglishCounterA(PDH_HQUERY hQuery, LPCSTR szFullCounterPath,
+				   DWORD_PTR dwUserData, PDH_HCOUNTER *phCounter);
+
+static PDH_HQUERY query;
+static PDH_HCOUNTER counter1;
+static PDH_HCOUNTER counter2;
+static HANDLE mutex;
+
+static bool load_init (void)
+{
+  static bool tried = false;
+  static bool initialized = false;
+
+  if (!tried) {
+    tried = true;
+
+    if (!((PdhOpenQueryA (NULL, 0, &query) == ERROR_SUCCESS) &&
+	  (PdhAddEnglishCounterA (query, "\\Processor(_Total)\\% Processor Time",
+				  0, &counter1) == ERROR_SUCCESS) &&
+	  (PdhAddEnglishCounterA (query, "\\System\\Processor Queue Length",
+				  0, &counter2) == ERROR_SUCCESS))) {
+      debug_printf("loadavg PDH initialization failed\n");
+      return false;
+    }
+
+    mutex = CreateMutex(&sec_all_nih, FALSE, "cyg.loadavg.mutex");
+    if (!mutex) {
+      debug_printf("opening loadavg mutexfailed\n");
+      return false;
+    }
+
+    initialized = true;
+  }
+
+  return initialized;
+}
+
+/* estimate the current load */
+static bool get_load (double *load)
+{
+  *load = 0.0;
+
+  PDH_STATUS ret = PdhCollectQueryData (query);
+  if (ret != ERROR_SUCCESS)
+    return false;
+
+  /* Estimate the number of running processes as (NumberOfProcessors) * (%
+     Processor Time) */
+  PDH_FMT_COUNTERVALUE fmtvalue1;
+  ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
+  if (ret != ERROR_SUCCESS)
+    return false;
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
+    return false;
+
+  LONG rql = fmtvalue2.longValue;
+
+  *load = rql + running;
+  return true;
+}
+
+/*
+  loadavginfo shared-memory object
+*/
+
+void loadavginfo::initialize ()
+{
+  for (int i = 0; i < 3; i++)
+    loadavg[i] = 0.0;
+
+  last_time = 0;
+}
+
+void loadavginfo::calc_load (int index, int delta_time, int decay_time, double n)
+{
+  double df = 1.0 / exp ((double)delta_time/decay_time);
+  loadavg[index] = (loadavg[index] * df) + (n * (1.0 - df));
+}
+
+void loadavginfo::update_loadavg ()
+{
+  double active_tasks;
+
+  if (!get_load (&active_tasks))
+    return;
+
+  /* Don't recalculate the load average if less than 5 seconds has elapsed since
+     the last time it was calculated */
+  time_t curr_time = time (NULL);
+  int delta_time = curr_time - last_time;
+  if (delta_time < 5) {
+    return;
+  }
+
+  if (last_time == 0) {
+    /* Initialize the load average to the current load */
+    for (int i = 0; i < 3; i++) {
+      loadavg[i] = active_tasks;
+    }
+  } else {
+    /* Compute the exponentially weighted moving average over ... */
+    calc_load (0, delta_time, 60,  active_tasks); /* ... 1 min */
+    calc_load (1, delta_time, 300, active_tasks); /* ... 5 min */
+    calc_load (2, delta_time, 900, active_tasks); /* ... 15 min */
+  }
+
+  last_time = curr_time;
+}
+
+int loadavginfo::fetch (double _loadavg[], int nelem)
+{
+  if (!load_init ())
+    return 0;
+
+  WaitForSingleObject(mutex, INFINITE);
+
+  update_loadavg ();
+
+  memcpy (_loadavg, loadavg, nelem * sizeof(double));
+
+  ReleaseMutex(mutex);
+
+  return nelem;
+}
+
+/* getloadavg: BSD */
+extern "C" int
+getloadavg (double loadavg[], int nelem)
+{
+  /* The maximum number of samples is 3 */
+  if (nelem > 3)
+    nelem = 3;
+
+  /* Return the samples and number of samples retrieved */
+  return cygwin_shared->loadavg.fetch(loadavg, nelem);
+}
diff --git a/winsup/cygwin/loadavg.h b/winsup/cygwin/loadavg.h
new file mode 100644
index 0000000..e6fb594
--- /dev/null
+++ b/winsup/cygwin/loadavg.h
@@ -0,0 +1,24 @@
+/* loadavg.h: load average support.
+
+  This file is part of Cygwin.
+
+  This software is a copyrighted work licensed under the terms of the
+  Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+  details. */
+
+#ifndef LOADAVG_H
+#define LOADAVG_H
+
+class loadavginfo
+{
+  double loadavg[3];
+  time_t last_time;
+
+ public:
+  void initialize ();
+  int fetch (double _loadavg[], int nelem);
+  void update_loadavg ();
+  void calc_load (int index, int delta_time, int decay_time, double n);
+};
+
+#endif /* LOADAVG_H */
diff --git a/winsup/cygwin/shared.cc b/winsup/cygwin/shared.cc
index 4ed4c11..dd16f14 100644
--- a/winsup/cygwin/shared.cc
+++ b/winsup/cygwin/shared.cc
@@ -328,6 +328,7 @@ shared_info::initialize ()
       init_obcaseinsensitive ();	/* Initialize obcaseinsensitive */
       tty.init ();			/* Initialize tty table  */
       mt.initialize ();			/* Initialize shared tape information */
+      loadavg.initialize ();		/* Initialize loadavg information */
       /* Defer debug output printing the installation root and installation key
 	 up to this point.  Debug output except for system_printf requires
 	 the global shared memory to exist. */
diff --git a/winsup/cygwin/shared_info.h b/winsup/cygwin/shared_info.h
index ce17c15..d03844d 100644
--- a/winsup/cygwin/shared_info.h
+++ b/winsup/cygwin/shared_info.h
@@ -11,6 +11,7 @@ details. */
 #include "mtinfo.h"
 #include "limits.h"
 #include "mount.h"
+#include "loadavg.h"
 
 #define CURR_USER_MAGIC 0xab1fcce8U
 
@@ -48,6 +49,7 @@ class shared_info
   LONG last_used_bindresvport;
   DWORD obcaseinsensitive;
   mtinfo mt;
+  loadavginfo loadavg;
 
   void initialize ();
   void init_obcaseinsensitive ();
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
