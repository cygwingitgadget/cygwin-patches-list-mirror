Return-Path: <cygwin-patches-return-9452-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103078 invoked by alias); 23 Jun 2019 21:51:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103067 invoked by uid 89); 23 Jun 2019 21:51:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=1205, fake, numerous, H*Ad:U*mark
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 23 Jun 2019 21:51:36 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id x5NLpZHI047662;	Sun, 23 Jun 2019 14:51:35 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdU4X7sx; Sun Jun 23 14:51:33 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3] Cygwin: Implement sched_[gs]etaffinity()
Date: Sun, 23 Jun 2019 21:51:00 -0000
Message-Id: <20190623215106.4847-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00159.txt.bz2

This patch set implements the Linux syscalls sched_getaffinity,
sched_setaffinity, pthread_getaffinity_np, and pthread_setaffinity_np.
Linux has a straightforward view of the cpu sets used in affinity masks.
They are simply long (1024-bit) bit masks.  This code emulates that view
while internally dealing with Windows' distribution of available CPUs among
processor groups.
---
 newlib/libc/include/sched.h            |  23 ++
 winsup/cygwin/common.din               |   4 +
 winsup/cygwin/include/cygwin/version.h |   4 +-
 winsup/cygwin/include/pthread.h        |   2 +
 winsup/cygwin/miscfuncs.cc             |  20 +-
 winsup/cygwin/miscfuncs.h              |   1 +
 winsup/cygwin/release/3.1.0            |   3 +
 winsup/cygwin/sched.cc                 | 308 +++++++++++++++++++++++++
 winsup/cygwin/thread.cc                |  19 ++
 winsup/doc/new-features.xml            |   6 +
 winsup/doc/posix.xml                   |   4 +
 11 files changed, 389 insertions(+), 5 deletions(-)

diff --git a/newlib/libc/include/sched.h b/newlib/libc/include/sched.h
index 1016235bb..fc44209d6 100644
--- a/newlib/libc/include/sched.h
+++ b/newlib/libc/include/sched.h
@@ -92,6 +92,29 @@ int sched_yield( void );
 
 #if __GNU_VISIBLE
 int sched_getcpu(void);
+
+/* Affinity-related definitions, here until numerous enough to separate out */
+#ifdef __x86_64__
+typedef uint64_t __cpu_mask;
+#else
+typedef uint32_t __cpu_mask;
+#endif
+#define __CPU_SETSIZE 1024  // maximum number of logical processors tracked
+#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
+#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
+
+#define __CPUELT(cpu)	((cpu) / __NCPUBITS)
+#define __CPUMASK(cpu)	((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
+
+typedef struct
+{
+  __cpu_mask __bits[__CPU_GROUPMAX];
+} cpu_set_t;
+
+int sched_getaffinity (pid_t, size_t, cpu_set_t *);
+int sched_get_thread_affinity (void *, size_t, cpu_set_t *);
+int sched_setaffinity (pid_t, size_t, const cpu_set_t *);
+int sched_set_thread_affinity (void *, size_t, const cpu_set_t *);
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
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index bb4ffe771..b70b9e281 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -509,12 +509,14 @@ details. */
   336: New Cygwin PID algorithm (yeah, not really an API change)
   337: MOUNT_BINARY -> MOUNT_TEXT
   338: Export secure_getenv.
+  339: Export sched_getaffinity, sched_setaffinity, pthread_getaffinity_np,
+       pthread_setaffinity_np.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 338
+#define CYGWIN_VERSION_API_MINOR 339
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
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
diff --git a/winsup/cygwin/miscfuncs.cc b/winsup/cygwin/miscfuncs.cc
index b5dfffc7d..e02bc9c1f 100644
--- a/winsup/cygwin/miscfuncs.cc
+++ b/winsup/cygwin/miscfuncs.cc
@@ -963,17 +963,19 @@ SetThreadName(DWORD dwThreadID, const char* threadName)
 
 #define add_size(p,s) ((p) = ((__typeof__(p))((PBYTE)(p)+(s))))
 
+static WORD num_cpu_per_group = 0;
+static WORD group_count = 0;
+
 WORD
 __get_cpus_per_group (void)
 {
-  static WORD num_cpu_per_group = 0;
-
   tmp_pathbuf tp;
 
   if (num_cpu_per_group)
     return num_cpu_per_group;
 
   num_cpu_per_group = 64;
+  group_count = 1;
 
   PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX lpi =
             (PSYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX) tp.c_get ();
@@ -1005,10 +1007,20 @@ __get_cpus_per_group (void)
 	   actually available CPUs.  The ActiveProcessorCount is correct
 	   though.  So we just use ActiveProcessorCount for now, hoping for
 	   the best. */
-        num_cpu_per_group
-                = plpi->Group.GroupInfo[0].ActiveProcessorCount;
+        num_cpu_per_group = plpi->Group.GroupInfo[0].ActiveProcessorCount;
+
+	/* Follow that lead to get the group count. */
+	group_count = plpi->Group.ActiveGroupCount;
         break;
       }
 
   return num_cpu_per_group;
 }
+
+WORD
+__get_group_count (void)
+{
+  if (group_count == 0)
+    (void) __get_cpus_per_group (); // caller should have called this first
+  return group_count;
+}
diff --git a/winsup/cygwin/miscfuncs.h b/winsup/cygwin/miscfuncs.h
index b983e6d81..d1e519fa6 100644
--- a/winsup/cygwin/miscfuncs.h
+++ b/winsup/cygwin/miscfuncs.h
@@ -120,5 +120,6 @@ extern "C" HANDLE WINAPI CygwinCreateThread (LPTHREAD_START_ROUTINE thread_func,
 void SetThreadName (DWORD dwThreadID, const char* threadName);
 
 WORD __get_cpus_per_group (void);
+WORD __get_group_count (void);
 
 #endif /*_MISCFUNCS_H*/
diff --git a/winsup/cygwin/release/3.1.0 b/winsup/cygwin/release/3.1.0
index bdbbf092d..a2bdc8f3c 100644
--- a/winsup/cygwin/release/3.1.0
+++ b/winsup/cygwin/release/3.1.0
@@ -5,6 +5,9 @@ What's new:
   1703 or later.  Add fake 24 bit color support for legacy console,
   which uses the nearest color from 16 system colors.
 
+- New APIs: sched_getaffinity, sched_setaffinity, pthread_getaffinity_np,
+  pthread_setaffinity_np.
+
 
 What changed:
 -------------
diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index 10168e641..a0a2d6250 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -424,4 +424,312 @@ sched_getcpu ()
   return pnum.Group * __get_cpus_per_group () + pnum.Number;
 }
 
+/* construct an affinity mask with just the 'count' lower-order bits set */
+static __cpu_mask
+groupmask (int count)
+{
+  if (count >= (int) (NBBY * sizeof (__cpu_mask)))
+    return ~(__cpu_mask) 0;
+  else
+    return ((__cpu_mask) 1 << count) - 1;
+}
+
+/* return the affinity mask of the indicated group from the given cpu set */
+static __cpu_mask
+getgroup (size_t sizeof_set, const cpu_set_t *set, int groupnum)
+{
+  int groupsize = __get_cpus_per_group ();
+  int bitindex = groupnum * groupsize;
+
+  int setsize = NBBY * sizeof_set; // bit size of whole cpu set
+  if (bitindex + groupsize > setsize)
+    return (__cpu_mask) 0;
+
+  int wordsize = NBBY * sizeof (cpu_set_t);
+  int wordindex = bitindex / wordsize;
+
+  __cpu_mask result = set->__bits[wordindex];
+  int offset = bitindex % wordsize;
+  if (offset)
+    {
+      result >>= offset;
+      offset = wordsize - offset;
+    }
+  else
+    offset = wordsize;
+
+  if (offset < groupsize)
+    result |= (set->__bits[wordindex + 1] << offset);
+  if (groupsize < wordsize)
+    result &= groupmask (groupsize);
+
+  return result;
+}
+
+/* set the given affinity mask for indicated group within the given cpu set */
+static __cpu_mask
+setgroup (size_t sizeof_set, cpu_set_t *set, int groupnum, __cpu_mask aff)
+{
+  int groupsize = __get_cpus_per_group ();
+  int bitindex = groupnum * groupsize;
+
+  int setsize = NBBY * sizeof_set; // bit size of whole cpu set
+  if (bitindex + groupsize > setsize)
+    return (__cpu_mask) 0;
+
+  int wordsize = NBBY * sizeof (cpu_set_t);
+  int wordindex = bitindex / wordsize;
+  int offset = bitindex % wordsize;
+  __cpu_mask mask = groupmask (groupsize);
+  aff &= mask;
+
+  set->__bits[wordindex] &= ~(mask << offset);
+  set->__bits[wordindex] |= aff << offset;
+
+  if ((bitindex + groupsize - 1) / wordsize != wordindex)
+    {
+      offset = wordsize - offset;
+      set->__bits[wordindex + 1] &= ~(mask >> offset);
+      set->__bits[wordindex + 1] |= aff >> offset;
+    }
+
+  return aff;
+}
+
+/* figure out which processor group the set bits indicate; can only be one */
+static int
+whichgroup (size_t sizeof_set, const cpu_set_t *set)
+{
+  int res = -1;
+  int maxgroup = min (__get_group_count (),
+                      (NBBY * sizeof_set) / __get_cpus_per_group ());
+
+  for (int i = 0; i < maxgroup; ++i)
+    if (getgroup (sizeof_set, set, i))
+      {
+	if (res >= 0)
+	  return -1; // error return if more than one group indicated
+	else
+	  res = i; // remember first group found
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
+  if (thread)
+    {
+      memset (set, 0, sizeof_set);
+      if (wincap.has_processor_groups () && __get_group_count () > 1)
+	{
+	  GROUP_AFFINITY ga;
+
+	  if (!GetThreadGroupAffinity (thread, &ga))
+	    {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+	  setgroup (sizeof_set, set, ga.Group, ga.Mask);
+	}
+      else
+	{
+	  THREAD_BASIC_INFORMATION tbi;
+
+	  status = NtQueryInformationThread (thread, ThreadBasicInformation,
+					     &tbi, sizeof (tbi), NULL);
+	  if (NT_SUCCESS (status))
+	    setgroup (sizeof_set, set, 0, tbi.AffinityMask);
+	  else
+	    status = geterrno_from_nt_status (status);
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
+          status = geterrno_from_win_error (GetLastError (), EPERM);
+          goto done;
+        }
+      memset (set, 0, sizeof_set);
+      if (wincap.has_processor_groups () && __get_group_count () > 1)
+        {
+          USHORT groupcount = __CPU_GROUPMAX;
+          USHORT grouparray[__CPU_GROUPMAX];
+
+          if (!GetProcessGroupAffinity (process, &groupcount, grouparray))
+            {
+	      status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+
+	  KAFFINITY miscmask = groupmask (__get_cpus_per_group ());
+	  for (int i = 0; i < groupcount; i++)
+	    setgroup (sizeof_set, set, grouparray[i], miscmask);
+        }
+      else
+        setgroup (sizeof_set, set, 0, procmask);
+    }
+  else
+    status = ESRCH;
+
+done:
+  if (process && process != GetCurrentProcess ())
+    CloseHandle (process);
+
+  if (status)
+    {
+      set_errno (status);
+      status = -1;
+    }
+  else
+    {
+      /* Emulate documented Linux kernel behavior on successful return */
+      status = wincap.cpu_count ();
+    }
+  return status;
+}
+
+int
+sched_set_thread_affinity (HANDLE thread, size_t sizeof_set, const cpu_set_t *set)
+{
+  int group = whichgroup (sizeof_set, set);
+  int status = 0;
+
+  if (thread)
+    {
+      if (wincap.has_processor_groups () && __get_group_count () > 1)
+	{
+	  GROUP_AFFINITY ga;
+
+	  if (group < 0)
+	    {
+	      status = EINVAL;
+	      goto done;
+	    }
+	  memset (&ga, 0, sizeof (ga));
+	  ga.Mask = getgroup (sizeof_set, set, group);
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
+	  if (!SetThreadAffinityMask (thread, getgroup (sizeof_set, set, 0)))
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
+  pinfo p (pid ? pid : getpid ());
+  if (p)
+    {
+      process = pid && pid != myself->pid ?
+		OpenProcess (PROCESS_SET_INFORMATION, FALSE,
+			     p->dwProcessId) : GetCurrentProcess ();
+      if (wincap.has_processor_groups () && __get_group_count () > 1)
+	{
+	  USHORT groupcount = __CPU_GROUPMAX;
+	  USHORT grouparray[__CPU_GROUPMAX];
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
+	      if (!SetProcessAffinityMask (process, getgroup (sizeof_set, set, group)))
+		status = geterrno_from_win_error (GetLastError (), EPERM);
+	      goto done;
+	    }
+
+	  /* If we get here, the user is trying to add the process to another
+             group or move it from current group to another group.  These ops
+             are not allowed by Windows.  One has to move one or more of the
+             process' threads to the new group(s) one by one.  Here, we bail.
+          */
+	  status = EINVAL;
+	  goto done;
+	}
+      else
+	{
+	  if (group != 0)
+	    {
+	      status = EINVAL;
+	      goto done;
+	    }
+	  if (!SetProcessAffinityMask (process, getgroup (sizeof_set, set, 0)))
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
+  if (status)
+    {
+      set_errno (status);
+      status = -1;
+    }
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
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index 49aa5da74..43ca11fef 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -29,6 +29,12 @@ If a SA_SIGINFO signal handler changes the ucontext_t pointed to by the
 third parameter, follow it after returning from the handler.
 </para></listitem>
 
+<listitem><para>
+Support for getting and setting process and thread affinities.  New APIs:
+sched_getaffinity, sched_setaffinity, pthread_getaffinity_np,
+pthread_setaffinity_np.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index d49cf5591..8e88245ac 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1359,8 +1359,10 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     pow10f
     pow10l
     ppoll
+    pthread_getaffinity_np
     pthread_getattr_np
     pthread_getname_np
+    pthread_setaffinity_np
     pthread_setname_np
     pthread_sigqueue
     pthread_timedjoin_np
@@ -1374,7 +1376,9 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     rawmemchr
     removexattr
     scandirat
+    sched_getaffinity
     sched_getcpu
+    sched_setaffinity
     secure_getenv
     setxattr
     signalfd
-- 
2.21.0
