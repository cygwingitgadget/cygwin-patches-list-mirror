Return-Path: <cygwin-patches-return-9324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56870 invoked by alias); 11 Apr 2019 04:06:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56860 invoked by uid 89); 11 Apr 2019 04:06:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=H*Ad:U*mark
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 11 Apr 2019 04:06:33 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x3B46Wqv082913;	Wed, 10 Apr 2019 21:06:32 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdWdk5vF; Wed Apr 10 21:06:25 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Implement sched_[gs]etaffinity()
Date: Thu, 11 Apr 2019 04:06:00 -0000
Message-Id: <20190411040601.1222-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00031.txt.bz2

---
 newlib/libc/include/sched.h |  4 +++
 winsup/cygwin/sched.cc      | 68 +++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
index 1016235bb..e3a5b97e5 100644
--- a/newlib/libc/include/sched.h
+++ b/newlib/libc/include/sched.h
@@ -92,6 +92,10 @@ int sched_yield( void );
 
 #if __GNU_VISIBLE
 int sched_getcpu(void);
+
+typedef uint64_t cpu_set_t; /* ...until cpuset(7) exists */
+int sched_getaffinity(pid_t, size_t, cpu_set_t *);
+int sched_setaffinity(pid_t, size_t, const cpu_set_t *);
 #endif
 
 #ifdef __cplusplus
diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index 10168e641..496e08857 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -424,4 +424,72 @@ sched_getcpu ()
   return pnum.Group * __get_cpus_per_group () + pnum.Number;
 }
 
+int
+sched_getaffinity (pid_t pid, size_t cpusetsize, cpu_set_t *mask)
+{
+  int status = 0;
+  HANDLE process = pid ? OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, pid)
+                       : GetCurrentProcess ();
+  if (process)
+    {
+      DWORD_PTR process_affinity; /* 4 (8) bytes on 32- (64-) bit Windows */
+      DWORD_PTR system_affinity;  /* ditto */
+
+      if (!GetProcessAffinityMask (process,&process_affinity, &system_affinity))
+	{
+	  status = geterrno_from_win_error (GetLastError (), EPERM);
+	  goto done;
+	}
+      memset (mask, 0, cpusetsize);
+      memcpy (mask, &process_affinity,
+	      min(cpusetsize, sizeof (process_affinity)));
+    }
+  else
+    status = ESRCH;
+
+done:
+  if (process && (process != GetCurrentProcess ()))
+    CloseHandle (process);
+
+  if (status)
+    {
+      set_errno (status);
+      status = -1;
+    }
+  return status;
+}
+
+int
+sched_setaffinity (pid_t pid, size_t cpusetsize, const cpu_set_t *mask)
+{
+  int status = 0;
+  HANDLE process = pid ? OpenProcess (PROCESS_SET_INFORMATION, FALSE, pid)
+                       : GetCurrentProcess ();
+  if (process)
+    {
+      DWORD_PTR process_affinity = 0; /* 4 (8) bytes on 32- (64-) bit Windows */
+
+      memcpy (&process_affinity, mask,
+	      min(cpusetsize, sizeof (process_affinity)));
+      if (!SetProcessAffinityMask (process, process_affinity))
+	{
+	  status = geterrno_from_win_error (GetLastError (), EPERM);
+	  goto done;
+	}
+    }
+  else
+    status = ESRCH;
+
+done:
+  if (process && (process != GetCurrentProcess ()))
+    CloseHandle (process);
+
+  if (status)
+    {
+      set_errno (status);
+      status = -1;
+    }
+  return status;
+}
+
 } /* extern C */
-- 
2.17.0
