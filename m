Return-Path: <cygwin-patches-return-9383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28558 invoked by alias); 29 Apr 2019 05:38:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28549 invoked by uid 89); 29 Apr 2019 05:38:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-16.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=measure, assemble, newlib, Non
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 29 Apr 2019 05:38:35 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x3T5cXw5005675;	Sun, 28 Apr 2019 22:38:33 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdZMQzfT; Sun Apr 28 22:38:25 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: Implement sched_[gs]etaffinity()
Date: Mon, 29 Apr 2019 05:38:00 -0000
Message-Id: <20190429053809.1095-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00090.txt.bz2

There are a couple of multi-group affinity operations that cannot be done
without heroic measures.  Those are marked with XXX in the code.  Further
discussion would be helpful to me.

---
 newlib/libc/include/sched.h     |  13 ++
 winsup/cygwin/common.din        |   4 +
 winsup/cygwin/include/pthread.h |   2 +
 winsup/cygwin/sched.cc          | 237 ++++++++++++++++++++++++++++++++
 winsup/cygwin/thread.cc         |  19 +++
 5 files changed, 275 insertions(+)

diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
index 1016235bb..a4d3fea6a 100644
--- a/newlib/libc/include/sched.h
+++ b/newlib/libc/include/sched.h
@@ -92,6 +92,19 @@ int sched_yield( void );
 
 #if __GNU_VISIBLE
 int sched_getcpu(void);
+
+#ifdef __CYGWIN__
+/* Affinity-related definitions, here until numerous enough to separate out */
+typedef uint64_t cpu_set_t;
+#define CPU_SETSIZE 1024
+#define CPU_GROUPSIZE 64
+#define CPU_GROUPMAX (CPU_SETSIZE / CPU_GROUPSIZE)
+
+int sched_getaffinity (pid_t, size_t, cpu_set_t *);
+int sched_get_thread_affinity (void *, size_t, cpu_set_t *);
+int sched_setaffinity (pid_t, size_t, const cpu_set_t *);
+int sched_set_thread_affinity (void *, size_t, const cpu_set_t *);
+#endif
 #endif
 
 #ifdef __cplusplus
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 68b95d470..81292ab7b 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1084,6 +1084,7 @@ pthread_create SIGFE
 pthread_detach SIGFE
 pthread_equal SIGFE
 pthread_exit SIGFE
+pthread_getaffinity_np SIGFE
 pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
 pthread_getcpuclockid SIGFE
@@ -1128,6 +1129,7 @@ pthread_rwlockattr_getpshared SIGFE
 pthread_rwlockattr_init SIGFE
 pthread_rwlockattr_setpshared SIGFE
 pthread_self SIGFE
+pthread_setaffinity_np SIGFE
 pthread_setcancelstate SIGFE
 pthread_setcanceltype SIGFE
 pthread_setconcurrency SIGFE
@@ -1248,10 +1250,12 @@ scandirat SIGFE
 scanf SIGFE
 sched_get_priority_max SIGFE
 sched_get_priority_min SIGFE
+sched_getaffinity SIGFE
 sched_getcpu SIGFE
 sched_getparam SIGFE
 sched_getscheduler NOSIGFE
 sched_rr_get_interval SIGFE
+sched_setaffinity SIGFE
 sched_setparam SIGFE
 sched_setscheduler SIGFE
 sched_yield SIGFE
diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 2ccf1cf8b..4ef3aeab7 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -226,8 +226,10 @@ void pthread_testcancel (void);
 /* Non posix calls */
 
 #if __GNU_VISIBLE
+int pthread_getaffinity_np (pthread_t, size_t, cpu_set_t *);
 int pthread_getattr_np (pthread_t, pthread_attr_t *);
 int pthread_getname_np (pthread_t, char *, size_t) __attribute__((__nonnull__(2)));
+int pthread_setaffinity_np (pthread_t, size_t, const cpu_set_t *);
 int pthread_setname_np (pthread_t, const char *) __attribute__((__nonnull__(2)));
 int pthread_sigqueue (pthread_t *, int, const union sigval);
 int pthread_timedjoin_np (pthread_t, void **, const struct timespec *);
diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index 10168e641..2d527da69 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -424,4 +424,241 @@ sched_getcpu ()
   return pnum.Group * __get_cpus_per_group () + pnum.Number;
 }
 
+/* figure out which processor group the set bits indicate; can only be one */
+static int
+whichgroup (size_t sizeof_set, const cpu_set_t *set)
+{
+  //XXX code assumes __get_cpus_per_group() is fixed at 64
+  int res = -1;
+
+  for (unsigned int i = 0; i < sizeof_set / sizeof (cpu_set_t); ++i)
+    if (set[i])
+      {
+	if (res >= 0)
+	  return -1; // error return if more than one group indicated
+	else
+	  res = (int) i; // remember first group found
+      }
+
+  return res;
+}
+
+int
+sched_get_thread_affinity (HANDLE thread, size_t sizeof_set, cpu_set_t *set)
+{
+  int status = 0;
+
+  //XXX code assumes __get_cpus_per_group() is fixed at 64
+  if (thread)
+    {
+      memset (set, 0, sizeof_set);
+      if (wincap.has_processor_groups ())
+	{
+	  GROUP_AFFINITY ga;
+
+	  if (!GetThreadGroupAffinity (thread, &ga))
+	    {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	  set[ga.Group] = ga.Mask;
+	}
+      else
+	{
+	  // There is no GetThreadAffinityMask() function, so simulate one by
+	  // iterating through CPUs trying to set affinity, which returns the
+	  // previous affinity.  On success, restore original affinity.
+	  // This strategy is due to Damon on StackOverflow.
+	  KAFFINITY cpumask = 1;
+	  KAFFINITY oldmask = 0;
+
+	  // Iterate through CPUs until success setting thread affinity to it
+	  while (cpumask)
+	    {
+	      oldmask = SetThreadAffinityMask (thread, cpumask);
+	      if (oldmask)
+		{ // that one worked, so restore original mask
+		  SetThreadAffinityMask (thread, oldmask);
+		  set[0] = oldmask;
+		  goto done;
+		}
+	      if (GetLastError () != ERROR_INVALID_PARAMETER)
+		{ // that one failed in an unexpected way
+		  status = geterrno_from_win_error (GetLastError (), EPERM);
+		  goto done;
+		}
+	      cpumask <<= 1;
+	    }
+	  status = ENOSYS; //XXX strategy failed.. figure out a new one
+	}
+    }
+  else
+    status = ESRCH;
+
+done:
+  return status;
+}
+
+int
+sched_getaffinity (pid_t pid, size_t sizeof_set, cpu_set_t *set)
+{
+  HANDLE process = 0;
+  int status = 0;
+
+  //XXX code assumes __get_cpus_per_group() is fixed at 64
+  pinfo p (pid ? pid : getpid ());
+  if (p)
+    {
+      process = pid && pid != myself->pid ?
+                OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE,
+                             p->dwProcessId) : GetCurrentProcess ();
+      KAFFINITY procmask;
+      KAFFINITY sysmask;
+
+      if (!GetProcessAffinityMask (process, &procmask, &sysmask))
+        {
+oops:
+          status = geterrno_from_win_error (GetLastError (), EPERM);
+          goto done;
+        }
+      memset (set, 0, sizeof_set);
+      if (wincap.has_processor_groups ())
+        {
+          USHORT groupcount = CPU_GROUPMAX;
+          USHORT grouparray[CPU_GROUPMAX];
+
+          if (!GetProcessGroupAffinity (process, &groupcount, grouparray))
+            goto oops;
+          if (groupcount == 1)
+	    set[grouparray[0]] = procmask;
+	  else
+            status = ENOSYS;//XXX multi-group code TBD...
+	    // There is no way to assemble the complete process affinity mask
+	    // without querying at least one thread per group in grouparray,
+	    // and we don't know which group a thread is in without querying
+	    // it, so must query all threads.  I'd call that a heroic measure.
+        }
+      else
+        set[0] = procmask;
+    }
+  else
+    status = ESRCH;
+
+done:
+  if (process && process != GetCurrentProcess ())
+    CloseHandle (process);
+
+  return status;
+}
+
+int
+sched_set_thread_affinity (HANDLE thread, size_t sizeof_set, const cpu_set_t *set)
+{
+  int group = whichgroup (sizeof_set, set);
+  int status = 0;
+
+  //XXX code assumes __get_cpus_per_group() is fixed at 64
+  if (thread)
+    {
+      if (wincap.has_processor_groups ())
+	{
+	  GROUP_AFFINITY ga;
+
+	  if (group < 0)
+	    {
+	      status = EINVAL;
+	      goto done;
+	    }
+	  memset (&ga, 0, sizeof (ga));
+	  ga.Mask = set[group];
+	  ga.Group = group;
+	  if (!SetThreadGroupAffinity (thread, &ga, NULL))
+	    {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	}
+      else
+	{
+	  if (group != 0)
+	    {
+	      status = EINVAL;
+	      goto done;
+	    }
+	  if (!SetThreadAffinityMask (thread, set[0]))
+	    {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	}
+    }
+  else
+    status = ESRCH;
+
+done:
+  return status;
+}
+
+int
+sched_setaffinity (pid_t pid, size_t sizeof_set, const cpu_set_t *set)
+{
+  int group = whichgroup (sizeof_set, set);
+  HANDLE process = 0;
+  int status = 0;
+
+  //XXX code assumes __get_cpus_per_group() is fixed at 64
+  pinfo p (pid ? pid : getpid ());
+  if (p)
+    {
+      process = pid && pid != myself->pid ?
+		OpenProcess (PROCESS_SET_INFORMATION, FALSE,
+			     p->dwProcessId) : GetCurrentProcess ();
+      if (wincap.has_processor_groups ())
+	{
+	  USHORT groupcount = CPU_GROUPMAX;
+	  USHORT grouparray[CPU_GROUPMAX];
+
+	  if (!GetProcessGroupAffinity (process, &groupcount, grouparray))
+	    {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	  if (group < 0)
+	    {
+	      status = EINVAL;
+	      goto done;
+	    }
+	  if (groupcount == 1 && grouparray[0] == group)
+	    {
+	      if (!SetProcessAffinityMask (process, set[group]))
+		status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	  status = ENOSYS; //XXX can't do it without heroic measures
+	  goto done;
+	}
+      else
+	{
+	  if (group != 0)
+	    {
+	      status = EINVAL;
+	      goto done;
+	    }
+	  if (!SetProcessAffinityMask (process, set[0]))
+	    {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	}
+    }
+  else
+    status = ESRCH;
+
+done:
+  if (process && process != GetCurrentProcess ())
+    CloseHandle (process);
+
+  return status;
+}
+
 } /* extern C */
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index f353dd497..43a6c88b3 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -23,6 +23,7 @@ details. */
 #include "winsup.h"
 #include "miscfuncs.h"
 #include "path.h"
+#include <sched.h>
 #include <stdlib.h>
 #include "sigproc.h"
 #include "fhandler.h"
@@ -2606,6 +2607,24 @@ pthread_timedjoin_np (pthread_t thread, void **return_val,
   return pthread::join (&thread, (void **) return_val, &timeout);
 }
 
+extern "C" int
+pthread_getaffinity_np (pthread_t thread, size_t sizeof_set, cpu_set_t *set)
+{
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  return sched_get_thread_affinity (thread->win32_obj_id, sizeof_set, set);
+}
+
+extern "C" int
+pthread_setaffinity_np (pthread_t thread, size_t sizeof_set, const cpu_set_t *set)
+{
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  return sched_set_thread_affinity (thread->win32_obj_id, sizeof_set, set);
+}
+
 extern "C" int
 pthread_getattr_np (pthread_t thread, pthread_attr_t *attr)
 {
-- 
2.17.0
