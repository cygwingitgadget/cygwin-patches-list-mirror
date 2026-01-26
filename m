Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 18EC04BC896C; Mon, 26 Jan 2026 11:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18EC04BC896C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769426028;
	bh=qQJHG8arrDPEeLRz/wh3iAnEJWm1x6i6LrV130NRO44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vk163BOFO7y6KV/axJI49rY9nhTjjdJOjXqlE6mYiv6ow0iWBq9OZr4pzQtlgC9HW
	 7YF1HodMgi19KoERCHQYX9MvOQZmdOpPbdflSIeE3LpzwBcJqU8CY/jZPPVWYhuXyg
	 6cnnzFidkGXwmAUr8rRYw4xARwueZ4IrVikfUMzo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 07B06A80525; Mon, 26 Jan 2026 12:13:46 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Cygwin: getrlimit/setrlimit: generalize setting rlimits
Date: Mon, 26 Jan 2026 12:13:43 +0100
Message-ID: <20260126111345.386303-2-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Rewrite setting rlimits which are backed by Windows job objects.
That's namely RLIMIT_AS for now, a per-process limit.  Prepare for
per-user limits like RLIMIT_NPROC, but don't implement them yet.

Basically store hard and soft limits in two adjacent job objects.
Create a new per-process job object for each new process.

Two new functions, __get_os_limits() and __set_os_limits() read and
create/write the Windows job object and assign the current process to
the job.

Two new child_info methods, collect_process_rlimits() and
inherit_process_rlimits() are used in fork/exec to hand down
the process limits to the child process.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/dcrt0.cc                    |   3 +
 winsup/cygwin/fork.cc                     |   4 +
 winsup/cygwin/local_includes/child_info.h |   7 +-
 winsup/cygwin/local_includes/cygheap.h    |   1 -
 winsup/cygwin/local_includes/ntdll.h      |   1 +
 winsup/cygwin/resource.cc                 | 177 +++++++++++++++-------
 winsup/cygwin/spawn.cc                    |   2 +
 7 files changed, 141 insertions(+), 54 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 69c233c24759..c9fdcb4b3c72 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -894,6 +894,9 @@ dll_crt0_1 (void *)
 
   uinfo_init ();	/* initialize user info */
 
+  if (child_proc_info)
+    child_proc_info->inherit_process_rlimits ();
+
   /* Connect to tty. */
   tty::init_session ();
 
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 7156fc31de5f..463fa54d0beb 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -152,6 +152,8 @@ frok::child (volatile char * volatile here)
   clear_procimptoken ();
   cygheap->user.reimpersonate ();
 
+  ch.inherit_process_rlimits ();
+
 #ifdef DEBUGGING
   if (GetEnvironmentVariableA ("FORKDEBUG", NULL, 0))
     try_to_debug ();
@@ -317,6 +319,8 @@ frok::parent (volatile char * volatile stack_here)
   debug_printf ("stack - bottom %p, top %p, addr %p, guardsize %ly",
 		ch.stackbase, ch.stacklimit, ch.stackaddr, ch.guardsize);
 
+  ch.collect_process_rlimits ();
+
   PROCESS_INFORMATION pi;
   STARTUPINFOW si;
 
diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index dc0b75dee694..aaa3e936f229 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -33,7 +33,7 @@ enum child_status
 #define EXEC_MAGIC_SIZE sizeof(child_info)
 
 /* Change this value if you get a message indicating that it is out-of-sync. */
-#define CURR_CHILD_INFO_MAGIC 0x3c5c4429U
+#define CURR_CHILD_INFO_MAGIC 0x1052d96bU
 
 #include "pinfo.h"
 struct cchildren
@@ -68,6 +68,7 @@ public:
   DWORD exit_code;	// process exit code
   static int retry_count;// retry count;
   sigset_t sigmask;
+  struct rlimit rlimit_as;
 
   child_info (unsigned, child_info_types, bool);
   child_info (): subproc_ready (NULL), parent (NULL) {}
@@ -96,6 +97,10 @@ public:
     else
       flag &= ~_CI_SILENTFAIL;
   }
+
+  /* resource.cc */
+  void collect_process_rlimits ();
+  void inherit_process_rlimits ();
 };
 
 class mount_info;
diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
index d9e936c1e469..74cfff65262a 100644
--- a/winsup/cygwin/local_includes/cygheap.h
+++ b/winsup/cygwin/local_includes/cygheap.h
@@ -517,7 +517,6 @@ public:
   user_heap_info user_heap;
   shared_region_info shared_regions;
   mode_t umask;
-  LONG rlim_as_id;
   unsigned long rlim_core;
   HANDLE console_h;
   cwdstuff cwd;
diff --git a/winsup/cygwin/local_includes/ntdll.h b/winsup/cygwin/local_includes/ntdll.h
index e7afeb564afd..7c9fa2a8add5 100644
--- a/winsup/cygwin/local_includes/ntdll.h
+++ b/winsup/cygwin/local_includes/ntdll.h
@@ -1460,6 +1460,7 @@ extern "C"
 			    PIO_STATUS_BLOCK, ULONG, PVOID, ULONG, PVOID,
 			    ULONG);
   NTSTATUS NtFlushBuffersFile (HANDLE, PIO_STATUS_BLOCK);
+  NTSTATUS NtIsProcessInJob (HANDLE, HANDLE);
   NTSTATUS NtLockFile (HANDLE, HANDLE, PIO_APC_ROUTINE, PVOID, PIO_STATUS_BLOCK,
 		       PLARGE_INTEGER, PLARGE_INTEGER, ULONG, BOOLEAN, BOOLEAN);
   NTSTATUS NtLockVirtualMemory (HANDLE, PVOID *, PSIZE_T, ULONG);
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 1e9e91810c8d..2286fe85052b 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -20,6 +20,7 @@ details. */
 #include "pinfo.h"
 #include "dtable.h"
 #include "cygheap.h"
+#include "child_info.h"
 #include "shared_info.h"
 #include "ntdll.h"
 
@@ -165,66 +166,63 @@ get_rlimit_stack (void)
   return (size_t) rl.rlim_cur;
 }
 
-static LONG job_serial_number __attribute__((section (".cygwin_dll_common"), shared));
+enum limit_flags_t
+{
+  PER_PROCESS = 1,
+  PER_USER = 2,
+
+  SOFT_LIMIT = 4,
+  HARD_LIMIT = 8
+};
 
 static PWCHAR
-job_shared_name (PWCHAR buf, LONG num)
+job_shared_name (PWCHAR buf, int flags)
 {
-  __small_swprintf (buf, L"rlimit.%d", num);
+  __small_swprintf (buf, L"rlimit.%C.%W.%u",
+			 (flags & HARD_LIMIT) ? L'H' : L'S',
+			 (flags & PER_USER) ? L"uid" : L"pid",
+			 (flags & PER_USER) ? getuid () : getpid ());
   return buf;
 }
 
-static void
-__get_rlimit_as (struct rlimit *rlp)
+static PJOBOBJECT_EXTENDED_LIMIT_INFORMATION
+__get_os_limits (JOBOBJECT_EXTENDED_LIMIT_INFORMATION &jobinfo, int flags)
 {
+  OBJECT_ATTRIBUTES attr;
   UNICODE_STRING uname;
   WCHAR jobname[32];
-  OBJECT_ATTRIBUTES attr;
   HANDLE job = NULL;
   NTSTATUS status;
-  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo;
 
-  if (cygheap->rlim_as_id)
-    {
-      RtlInitUnicodeString (&uname,
-			    job_shared_name (jobname,
-					     cygheap->rlim_as_id));
-      InitializeObjectAttributes (&attr, &uname, 0,
-				  get_session_parent_dir (), NULL);
-      /* May fail, just check NULL job in that case. */
-      NtOpenJobObject (&job, JOB_OBJECT_QUERY, &attr);
-    }
+  RtlInitUnicodeString (&uname, job_shared_name (jobname, flags));
+  InitializeObjectAttributes (&attr, &uname, 0,
+			      flags & PER_USER ? get_shared_parent_dir ()
+					       : get_session_parent_dir (),
+			      NULL);
+  /* May fail, just check NULL job in that case. */
+  NtOpenJobObject (&job, JOB_OBJECT_QUERY, &attr);
   status = NtQueryInformationJobObject (job,
-			      JobObjectExtendedLimitInformation,
-			      &jobinfo, sizeof jobinfo, NULL);
-  if (NT_SUCCESS (status)
-      && (jobinfo.BasicLimitInformation.LimitFlags
-	  & JOB_OBJECT_LIMIT_PROCESS_MEMORY))
-    rlp->rlim_cur = rlp->rlim_max = jobinfo.ProcessMemoryLimit;
+					JobObjectExtendedLimitInformation,
+					&jobinfo, sizeof jobinfo, NULL);
   if (job)
     NtClose (job);
+  return NT_SUCCESS (status) ? &jobinfo : NULL;
 }
 
 static int
-__set_rlimit_as (unsigned long new_as_limit)
+__set_os_limits (JOBOBJECT_EXTENDED_LIMIT_INFORMATION &jobinfo, int flags)
 {
-  LONG new_as_id = 0;
+  NTSTATUS status = STATUS_SUCCESS;
+  OBJECT_ATTRIBUTES attr;
   UNICODE_STRING uname;
   WCHAR jobname[32];
-  OBJECT_ATTRIBUTES attr;
-  NTSTATUS status = STATUS_SUCCESS;
   HANDLE job = NULL;
-  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo = { 0 };
 
-  /* If we already have a limit, we must not change it because that
-     would potentially influence already running child processes.
-     Just try to create another, nested job. */
-  while (new_as_id == 0)
-    new_as_id = InterlockedIncrement (&job_serial_number);
-  RtlInitUnicodeString (&uname,
-			job_shared_name (jobname, new_as_id));
-  InitializeObjectAttributes (&attr, &uname, 0,
-			      get_session_parent_dir (), NULL);
+  RtlInitUnicodeString (&uname, job_shared_name (jobname, flags));
+  InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF,
+			      flags & PER_USER ? get_shared_parent_dir ()
+					       : get_session_parent_dir (),
+			      NULL);
   status = NtCreateJobObject (&job, JOB_OBJECT_ALL_ACCESS, &attr);
   if (!NT_SUCCESS (status))
     {
@@ -232,28 +230,104 @@ __set_rlimit_as (unsigned long new_as_limit)
       return -1;
     }
   jobinfo.BasicLimitInformation.LimitFlags
-    = JOB_OBJECT_LIMIT_PROCESS_MEMORY;
-  /* Per Linux man page, round down to system pagesize. */
-  jobinfo.ProcessMemoryLimit
-    = rounddown (new_as_limit, wincap.allocation_granularity ());
+    |= JOB_OBJECT_LIMIT_BREAKAWAY_OK;
+  /* Every process gets its own per-process jobs, so always breakaway
+     silently from per-process jobs. */
+  if (flags & PER_PROCESS)
+    jobinfo.BasicLimitInformation.LimitFlags
+      |= JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK;
   status = NtSetInformationJobObject (job,
-				JobObjectExtendedLimitInformation,
-				&jobinfo, sizeof jobinfo);
-  /* If creating the job and setting up the job limits succeeded,
-     try to add the process to the job.  This must be the last step,
-     otherwise we couldn't remove the job if anything failed. */
-  if (NT_SUCCESS (status))
-    status = NtAssignProcessToJobObject (job, NtCurrentProcess ());
-  NtClose (job);
+				      JobObjectExtendedLimitInformation,
+				      &jobinfo, sizeof jobinfo);
+  /* Assign the process to the job if it's not already assigned. */
+  NTSTATUS in_job = NtIsProcessInJob (NtCurrentProcess (), job);
+  if (NT_SUCCESS (status) && in_job == STATUS_PROCESS_NOT_IN_JOB)
+    {
+      status = NtAssignProcessToJobObject (job, NtCurrentProcess ());
+      if (!NT_SUCCESS (status))
+	debug_printf ("NtAssignProcessToJobObject: %y\r", status);
+    }
+
+  /* Keep the handle ONLY if we just assigned the process to the job */
+  if (!NT_SUCCESS (status) || in_job == STATUS_PROCESS_IN_JOB)
+    NtClose (job);
+
   if (!NT_SUCCESS (status))
     {
       __seterrno_from_nt_status (status);
       return -1;
     }
-  cygheap->rlim_as_id = new_as_id;
   return 0;
 }
 
+static void
+__get_rlimit_as (struct rlimit *rlp)
+{
+  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo;
+
+  rlp->rlim_cur = RLIM_INFINITY;
+  rlp->rlim_max = RLIM_INFINITY;
+  if (__get_os_limits (jobinfo, PER_PROCESS | HARD_LIMIT)
+      && (jobinfo.BasicLimitInformation.LimitFlags
+	  & JOB_OBJECT_LIMIT_PROCESS_MEMORY))
+    rlp->rlim_max = jobinfo.ProcessMemoryLimit;
+  if (__get_os_limits (jobinfo, PER_PROCESS | SOFT_LIMIT)
+      && (jobinfo.BasicLimitInformation.LimitFlags
+	  & JOB_OBJECT_LIMIT_PROCESS_MEMORY))
+    rlp->rlim_cur = jobinfo.ProcessMemoryLimit;
+}
+
+static int
+__set_rlimit_as_single (rlim_t val, int flags)
+{
+  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo = { 0 };
+
+  __get_os_limits (jobinfo, PER_PROCESS | flags);
+  if (val == RLIM_INFINITY)
+    {
+      jobinfo.BasicLimitInformation.LimitFlags
+	&= ~JOB_OBJECT_LIMIT_PROCESS_MEMORY;
+      jobinfo.ProcessMemoryLimit = 0;
+    }
+  else /* Per Linux man page, round down to system pagesize. */
+    {
+      jobinfo.BasicLimitInformation.LimitFlags
+	|= JOB_OBJECT_LIMIT_PROCESS_MEMORY;
+      jobinfo.ProcessMemoryLimit
+	= rounddown (val, wincap.allocation_granularity ());
+    }
+  return __set_os_limits (jobinfo, PER_PROCESS | flags);
+}
+
+static int
+__set_rlimit_as (const struct rlimit *rlp)
+{
+  int ret = __set_rlimit_as_single (rlp->rlim_max, HARD_LIMIT);
+  if (ret == 0)
+    ret = __set_rlimit_as_single (rlp->rlim_cur, SOFT_LIMIT);
+  return ret;
+}
+
+/* Called during fork/exec in the parent to collect the per-process rlimits. */
+void
+child_info::collect_process_rlimits ()
+{
+  __get_rlimit_as (&rlimit_as);
+  debug_printf ("parent rlimit AS: max %U cur %U",
+		rlimit_as.rlim_max, rlimit_as.rlim_cur);
+}
+
+/* Called during fork/exec in the child to duplicate the per-process rlimits. */
+void
+child_info::inherit_process_rlimits ()
+{
+  if (rlimit_as.rlim_max != RLIM_INFINITY
+      || rlimit_as.rlim_cur != RLIM_INFINITY)
+    __set_rlimit_as (&rlimit_as);
+  debug_printf ("child rlimit AS: max %U cur %U",
+		rlimit_as.rlim_max, rlimit_as.rlim_cur);
+}
+
 extern "C" int
 getrlimit (int resource, struct rlimit *rlp)
 {
@@ -325,8 +399,7 @@ setrlimit (int resource, const struct rlimit *rlp)
       switch (resource)
 	{
 	case RLIMIT_AS:
-	  if (rlp->rlim_cur != RLIM_INFINITY)
-	    return __set_rlimit_as (rlp->rlim_cur);
+	  return __set_rlimit_as (rlp);
 	  break;
 	case RLIMIT_CORE:
 	  cygheap->rlim_core = rlp->rlim_cur;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 04e4a4028b8a..f7ed9cf4f70b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -571,6 +571,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	SetHandleInformation (my_wr_proc_pipe, HANDLE_FLAG_INHERIT, 0);
       parent_winpid = GetCurrentProcessId ();
 
+      collect_process_rlimits ();
+
       PSECURITY_ATTRIBUTES sa = (PSECURITY_ATTRIBUTES) alloca (1024);
       if (!sec_user_nih (sa, cygheap->user.sid (),
 			 well_known_authenticated_users_sid,
-- 
2.52.0

