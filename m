Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E39C14BC895A; Mon, 26 Jan 2026 11:13:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E39C14BC895A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769426027;
	bh=noTLUTEyCJoZF7TQz4ZRNw00rh2wio6lcySABtJ93I0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G1A5+61z8OmL2s7o75/jrcXi1bsZFwZaVAjKLH90y5ThKM21IO8fB+hZLUiFjbahB
	 W6EV6x+h67ap7W0x/OcdGij3c7kTYqUjzTYDhHDB55NDsM2lADARJjsoiPGwSvvMV3
	 hj6B0tEZmWC2JpjxWeaI/TI1gxsgjSzRPKds8rJ4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1371DA81D17; Mon, 26 Jan 2026 12:13:46 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: improve PCA workaround
Date: Mon, 26 Jan 2026 12:13:45 +0100
Message-ID: <20260126111345.386303-4-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The check is now subsumed into setup_user_rlimits().

Perform the check only if we're the root process of a Cygwin process
tree.  If we start mintty from Cygwin, the PCA trigger doesn't occur.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/dcrt0.cc                    |  2 +-
 winsup/cygwin/fork.cc                     | 13 ++++++-
 winsup/cygwin/globals.cc                  |  1 +
 winsup/cygwin/local_includes/child_info.h |  2 +-
 winsup/cygwin/resource.cc                 | 41 +++++++++++++++++++----
 winsup/cygwin/spawn.cc                    | 40 ++++++----------------
 6 files changed, 59 insertions(+), 40 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 1d5a452b4fbc..e080aa41bca2 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -894,7 +894,7 @@ dll_crt0_1 (void *)
 
   uinfo_init ();	/* initialize user info */
 
-  setup_user_rlimits ();
+  enforce_breakaway_from_job = setup_user_rlimits (!child_proc_info);
   if (child_proc_info)
     child_proc_info->inherit_process_rlimits ();
 
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index eeed7155ee63..3e5d81fe46e8 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -152,7 +152,7 @@ frok::child (volatile char * volatile here)
   clear_procimptoken ();
   cygheap->user.reimpersonate ();
 
-  setup_user_rlimits ();
+  setup_user_rlimits (false);
   ch.inherit_process_rlimits ();
 
 #ifdef DEBUGGING
@@ -253,6 +253,17 @@ frok::parent (volatile char * volatile stack_here)
      systems. */
   c_flags |= CREATE_UNICODE_ENVIRONMENT;
 
+  /* Despite all our executables having a valid manifest, "mintty" still
+     triggers the "Program Compatibility Assistant (PCA) Service" for
+     some reason, maybe due to some heuristics in PCA.
+     We use job objects for rlimits extensively, so we still have to let
+     child processes breakaway from job.  Otherwise we can't add processes
+     running in different terminals to an already existing per-user job.
+     The check for this situation is now done in setup_user_rlimits()
+     called from dll_crt0_1(). */
+  if (enforce_breakaway_from_job)
+    c_flags |= CREATE_BREAKAWAY_FROM_JOB;
+
   errmsg = NULL;
   hchild = NULL;
 
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 86b0c2718a87..f73c35f88e7f 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -28,6 +28,7 @@ PWCHAR windows_directory = windows_directory_buf + 4;
 UINT windows_directory_length;
 UNICODE_STRING windows_directory_path;
 WCHAR global_progname[NT_MAX_PATH];
+bool NO_COPY enforce_breakaway_from_job;
 
 /* program exit the program */
 
diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
index f2e4fb165862..e10aa777610c 100644
--- a/winsup/cygwin/local_includes/child_info.h
+++ b/winsup/cygwin/local_includes/child_info.h
@@ -203,7 +203,7 @@ extern child_info_spawn ch_spawn;
 #define have_execed_cygwin ch_spawn.has_execed_cygwin ()
 
 /* resource.cc */
-extern void setup_user_rlimits ();
+extern bool setup_user_rlimits (bool);
 
 extern "C" {
 extern child_info *child_proc_info;
diff --git a/winsup/cygwin/resource.cc b/winsup/cygwin/resource.cc
index 83ae9add4cdb..12705eb36f78 100644
--- a/winsup/cygwin/resource.cc
+++ b/winsup/cygwin/resource.cc
@@ -376,8 +376,8 @@ child_info::inherit_process_rlimits ()
 		rlimit_as.rlim_max, rlimit_as.rlim_cur);
 }
 
-static void
-__setup_user_rlimits_single (int flags)
+static bool
+__setup_user_rlimits_single (int flags, bool root_process)
 {
   JOBOBJECT_EXTENDED_LIMIT_INFORMATION jobinfo = { 0 };
   NTSTATUS status = STATUS_SUCCESS;
@@ -385,6 +385,7 @@ __setup_user_rlimits_single (int flags)
   UNICODE_STRING uname;
   WCHAR jobname[32];
   HANDLE job = NULL;
+  bool ret = false;
 
   RtlInitUnicodeString (&uname, job_shared_name (jobname, PER_USER | flags));
   InitializeObjectAttributes (&attr, &uname, OBJ_OPENIF,
@@ -393,7 +394,7 @@ __setup_user_rlimits_single (int flags)
   if (!NT_SUCCESS (status))
     {
       debug_printf ("NtCreateJobObject (%S): status %y", &uname, status);
-      return;
+      return false;
     }
   /* Did we just create the job? */
   if (status != STATUS_OBJECT_NAME_EXISTS)
@@ -404,6 +405,28 @@ __setup_user_rlimits_single (int flags)
 					  &jobinfo, sizeof jobinfo);
     }
   NTSTATUS in_job = NtIsProcessInJob (NtCurrentProcess (), job);
+
+  /* Check if we're already running in a job, even though we're not
+     running in one of our own user-specific jobs.  If so, this process
+     is doomed, but we can try to create child processes with
+     CREATE_BREAKAWAY_FROM_JOB, so at least the next process in the
+     process tree will be happy.
+     We're only checking processes which have been started from non-Cygwin
+     processes (root processes of a Cygwin process tree).
+     Given that breaking away also requires that the foreign job allows
+     JOB_OBJECT_LIMIT_BREAKAWAY_OK, we're testing this right here, too. */
+  if ((flags & HARD_LIMIT) && root_process
+      && in_job == STATUS_PROCESS_NOT_IN_JOB)
+    {
+      status = NtQueryInformationJobObject (NULL,
+					    JobObjectExtendedLimitInformation,
+					    &jobinfo, sizeof jobinfo, NULL);
+      if (NT_SUCCESS (status)
+	  && (jobinfo.BasicLimitInformation.LimitFlags
+	      & JOB_OBJECT_LIMIT_BREAKAWAY_OK))
+	ret = true;
+    }
+
   /* Assign the process to the job if it's not already assigned. */
   if (NT_SUCCESS (status) && in_job == STATUS_PROCESS_NOT_IN_JOB)
     {
@@ -412,13 +435,17 @@ __setup_user_rlimits_single (int flags)
 	debug_printf ("NtAssignProcessToJobObject: %y\r", status);
     }
   /* Never close the handle. */
+  return ret;
 }
 
-void
-setup_user_rlimits ()
+bool
+setup_user_rlimits (bool root_process)
 {
-  __setup_user_rlimits_single (HARD_LIMIT);
-  __setup_user_rlimits_single (SOFT_LIMIT);
+  bool in_a_foreign_job;
+
+  in_a_foreign_job = __setup_user_rlimits_single (HARD_LIMIT, root_process);
+  __setup_user_rlimits_single (SOFT_LIMIT, false);
+  return in_a_foreign_job;
 }
 
 extern "C" int
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index b1f7f571b36c..65f2084354a0 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -414,36 +414,16 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       if (winjitdebug && !real_path.iscygexec ())
 	c_flags |= CREATE_DEFAULT_ERROR_MODE;
 
-      /* We're adding the CREATE_BREAKAWAY_FROM_JOB flag here to workaround
-	 issues with the "Program Compatibility Assistant (PCA) Service".
-	 For some reason, when starting long running sessions from mintty(*),
-	 the affected svchost.exe process takes more and more memory and at one
-	 point takes over the CPU.  At this point the machine becomes
-	 unresponsive.  The only way to get back to normal is to stop the
-	 entire mintty session, or to stop the PCA service.  However, a process
-	 which is controlled by PCA is part of a compatibility job, which
-	 allows child processes to break away from the job.  This helps to
-	 avoid this issue.
-
-	 First we call IsProcessInJob.  It fetches the information whether or
-	 not we're part of a job 20 times faster than QueryInformationJobObject.
-
-	 (*) Note that this is not mintty's fault.  It has just been observed
-	 with mintty in the first place.  See the archives for more info:
-	 http://cygwin.com/ml/cygwin-developers/2012-02/msg00018.html */
-      JOBOBJECT_BASIC_LIMIT_INFORMATION jobinfo;
-      BOOL is_in_job;
-
-      if (IsProcessInJob (GetCurrentProcess (), NULL, &is_in_job)
-	  && is_in_job
-	  && QueryInformationJobObject (NULL, JobObjectBasicLimitInformation,
-				     &jobinfo, sizeof jobinfo, NULL)
-	  && (jobinfo.LimitFlags & (JOB_OBJECT_LIMIT_BREAKAWAY_OK
-				    | JOB_OBJECT_LIMIT_SILENT_BREAKAWAY_OK)))
-	{
-	  debug_printf ("Add CREATE_BREAKAWAY_FROM_JOB");
-	  c_flags |= CREATE_BREAKAWAY_FROM_JOB;
-	}
+      /* Despite all our executables having a valid manifest, "mintty" still
+	 triggers the "Program Compatibility Assistant (PCA) Service" for
+	 some reason, maybe due to some heuristics in PCA.
+	 We use job objects for rlimits extensively, so we still have to let
+	 child processes breakaway from job.  Otherwise we can't add processes
+	 running in different terminals to an already existing per-user job.
+	 The check for this situation is now done in setup_user_rlimits()
+	 called from dll_crt0_1(). */
+      if (enforce_breakaway_from_job)
+	c_flags |= CREATE_BREAKAWAY_FROM_JOB;
 
       if (mode == _P_DETACH)
 	c_flags |= DETACHED_PROCESS;
-- 
2.52.0

