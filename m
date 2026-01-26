Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0AAC44BC8959; Mon, 26 Jan 2026 11:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0AAC44BC8959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769426028;
	bh=IcAFTe4baVHssg+F16XFVeNCJIZF01HuNZAqIYzWnUI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n7piA+VjcpgtRe6lnR/azV7mmfnwg+i8XyS7Kx8V0pTua8m1Oc2OZ9y8CZ+C3Ak6f
	 as9zZ4DiLziFHYjaHvP7jQOAwO54BUxhS+rgPZ9hH51wRsaeynFo7V9b4Ja4VDmDor
	 xw82ujy4Zs56JdwEU5+tIgG3meNYpKueboHUWGDw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0CC41A81D16; Mon, 26 Jan 2026 12:13:46 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: getrlimit/setrlimit: implement RLIMIT_NPROC
Date: Mon, 26 Jan 2026 12:13:44 +0100
Message-ID: <20260126111345.386303-3-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Implement RLIMIT_NPROC by creating per-user job objects.  Those
are not auto-breakaway.  Only breakaway explicitely from per-user jobs
if we change the user context in child_info_spawn::worker().  Only
then the real uid changes and the new child has to be assigned to
the per-user job objects for the new real uid.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/dcrt0.cc                    |  1 +
 winsup/cygwin/fork.cc                     |  1 +
 winsup/cygwin/include/cygwin/version.h    |  3 +-
 winsup/cygwin/include/sys/resource.h      |  3 +-
 winsup/cygwin/local_includes/child_info.h |  3 +
 winsup/cygwin/resource.cc                 | 99 +++++++++++++++++++++++
 winsup/cygwin/spawn.cc                    |  2 +
 7 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index c9fdcb4b3c72..1d5a452b4fbc 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -894,6 +894,7 @@ dll_crt0_1 (void *)
 
   uinfo_init ();	/* initialize user info */
 
+  setup_user_rlimits ();
   if (child_proc_info)
     child_proc_info->inherit_process_rlimits ();
 
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 463fa54d0beb..eeed7155ee63 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -152,6 +152,7 @@ frok::child (volatile char * volatile here)
   clear_procimptoken ();
   cygheap->user.reimpersonate ();
 
+  setup_user_rlimits ();
   ch.inherit_process_rlimits ();
 
 #ifdef DEBUGGING
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 00eedeb27ab4..ef552ffcba9c 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -499,12 +499,13 @@ details. */
   358: Export acl_get_fd_np, acl_get_link_np, acl_get_perm_np,
        acl_is_trivial_np, acl_set_fd_np, acl_set_link_np, acl_strip_np.
   359: Export wrappers for C++14 and C++17 new and delete overloads.
+  360: Add RLIMIT_NPROC.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 359
+#define CYGWIN_VERSION_API_MINOR 360
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/include/sys/resource.h b/winsup/cygwin/include/sys/resource.h
index 16dcdcd0a2d3..56fb4a897426 100644
--- a/winsup/cygwin/include/sys/resource.h
+++ b/winsup/cygwin/include/sys/resource.h
@@ -28,8 +28,9 @@ extern "C" {
 #define RLIMIT_NOFILE	5		/* max number of open files */
 #define RLIMIT_OFILE	RLIMIT_NOFILE	/* BSD name */
 #define RLIMIT_AS	6		/* address space (virt. memory) limit */
+#define RLIMIT_NPROC	7		/* max processes for this user */
 
-#define RLIMIT_NLIMITS  7		/* upper bound of RLIMIT_* defines */
+#define RLIMIT_NLIMITS  8		/* upper bound of RLIMIT_* defines */
 #define RLIM_NLIMITS    RLIMIT_NLIMITS
 
 #define RLIM_INFINITY	(~0UL)
diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index aaa3e936f229..f2e4fb165862 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -202,6 +202,9 @@ extern child_info_spawn ch_spawn;
 #define have_execed ch_spawn.has_execed ()
 #define have_execed_cygwin ch_spawn.has_execed_cygwin ()
 
+/* resource.cc */
+extern void setup_user_rlimits ();
+
 extern "C" {
 extern child_info *child_proc_info;
 extern child_info_spawn *spawn_info asm (_SYMSTR (child_proc_info));
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 2286fe85052b..83ae9add4cdb 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -308,6 +308,54 @@ __set_rlimit_as (const struct rlimit *rlp)
   return ret;
 }
 
+static int
+__set_rlimit_nproc_single (rlim_t val, int flags)
+{
+  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo = { 0 };
+
+  __get_os_limits (jobinfo, PER_USER | flags);
+  /* ActiveProcessLimit is a DWORD */
+  if (val == RLIM_INFINITY || val > UINT_MAX)
+    {
+      jobinfo.BasicLimitInformation.LimitFlags
+	&= ~JOB_OBJECT_LIMIT_ACTIVE_PROCESS;
+      jobinfo.BasicLimitInformation.ActiveProcessLimit = 0;
+    }
+  else /* Per Linux man page, round down to system pagesize. */
+    {
+      jobinfo.BasicLimitInformation.LimitFlags
+	|= JOB_OBJECT_LIMIT_ACTIVE_PROCESS;
+      jobinfo.BasicLimitInformation.ActiveProcessLimit = val;
+    }
+  return __set_os_limits (jobinfo, PER_USER | flags);
+}
+
+int
+__set_rlimit_nproc (const struct rlimit *rlp)
+{
+  int ret = __set_rlimit_nproc_single (rlp->rlim_max, HARD_LIMIT);
+  if (ret == 0)
+    ret = __set_rlimit_nproc_single (rlp->rlim_cur, SOFT_LIMIT);
+  return ret;
+}
+
+void
+__get_rlimit_nproc (struct rlimit *rlp)
+{
+  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo;
+
+  rlp->rlim_cur = RLIM_INFINITY;
+  rlp->rlim_max = RLIM_INFINITY;
+  if (__get_os_limits (jobinfo, PER_USER | HARD_LIMIT)
+      && (jobinfo.BasicLimitInformation.LimitFlags
+	  & JOB_OBJECT_LIMIT_ACTIVE_PROCESS))
+    rlp->rlim_max = jobinfo.BasicLimitInformation.ActiveProcessLimit;
+  if (__get_os_limits (jobinfo, PER_USER | SOFT_LIMIT)
+      && (jobinfo.BasicLimitInformation.LimitFlags
+	  & JOB_OBJECT_LIMIT_ACTIVE_PROCESS))
+    rlp->rlim_cur = jobinfo.BasicLimitInformation.ActiveProcessLimit;
+}
+
 /* Called during fork/exec in the parent to collect the per-process rlimits. */
 void
 child_info::collect_process_rlimits ()
@@ -328,6 +376,51 @@ child_info::inherit_process_rlimits ()
 		rlimit_as.rlim_max, rlimit_as.rlim_cur);
 }
 
+static void
+__setup_user_rlimits_single (int flags)
+{
+  JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo = { 0 };
+  NTSTATUS status = STATUS_SUCCESS;
+  OBJECT_ATTRIBUTES attr;
+  UNICODE_STRING uname;
+  WCHAR jobname[32];
+  HANDLE job = NULL;
+
+  RtlInitUnicodeString (&uname, job_shared_name (jobname, PER_USER | flags));
+  InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF,
+			      get_shared_parent_dir (), NULL);
+  status = NtCreateJobObject (&job, JOB_OBJECT_ALL_ACCESS, &attr);
+  if (!NT_SUCCESS (status))
+    {
+      debug_printf ("NtCreateJobObject (%S): status %y", &uname, status);
+      return;
+    }
+  /* Did we just create the job? */
+  if (status != STATUS_OBJECT_NAME_EXISTS)
+    {
+      jobinfo.BasicLimitInformation.LimitFlags |= JOB_OBJECT_LIMIT_BREAKAWAY_OK;
+      status = NtSetInformationJobObject (job,
+					  JobObjectExtendedLimitInformation,
+					  &jobinfo, sizeof jobinfo);
+    }
+  NTSTATUS in_job = NtIsProcessInJob (NtCurrentProcess (), job);
+  /* Assign the process to the job if it's not already assigned. */
+  if (NT_SUCCESS (status) && in_job == STATUS_PROCESS_NOT_IN_JOB)
+    {
+      status = NtAssignProcessToJobObject (job, NtCurrentProcess ());
+      if (!NT_SUCCESS (status))
+	debug_printf ("NtAssignProcessToJobObject: %y\r", status);
+    }
+  /* Never close the handle. */
+}
+
+void
+setup_user_rlimits ()
+{
+  __setup_user_rlimits_single (HARD_LIMIT);
+  __setup_user_rlimits_single (SOFT_LIMIT);
+}
+
 extern "C" int
 getrlimit (int resource, struct rlimit *rlp)
 {
@@ -345,6 +438,9 @@ getrlimit (int resource, struct rlimit *rlp)
 	case RLIMIT_AS:
 	  __get_rlimit_as (rlp);
 	  break;
+	case RLIMIT_NPROC:
+	  __get_rlimit_nproc (rlp);
+	  break;
 	case RLIMIT_STACK:
 	  __get_rlimit_stack (rlp);
 	  break;
@@ -401,6 +497,9 @@ setrlimit (int resource, const struct rlimit *rlp)
 	case RLIMIT_AS:
 	  return __set_rlimit_as (rlp);
 	  break;
+	case RLIMIT_NPROC:
+	  return __set_rlimit_nproc (rlp);
+	  break;
 	case RLIMIT_CORE:
 	  cygheap->rlim_core = rlp->rlim_cur;
 	  break;
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index f7ed9cf4f70b..b1f7f571b36c 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -676,6 +676,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 		}
 	    }
 
+	  c_flags |= CREATE_BREAKAWAY_FROM_JOB;
+
 	  rc = CreateProcessAsUserW (::cygheap->user.primary_token (),
 			       runpath,		/* image name w/ full path */
 			       cmd.wcs (wcmd),	/* what was passed to exec */
-- 
2.52.0

