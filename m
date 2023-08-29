Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 12D5C3858D28; Tue, 29 Aug 2023 09:57:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 12D5C3858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1693303057;
	bh=woT7zqOOtLx/yFe/2K8AhsVml+P0Vaz8SDB/FckNexs=;
	h=From:To:Subject:Date:From;
	b=yD7JseC5XcNsSjErsGSg2bcreaYtPM9dCajwKpEvt9lp8+U34kRKAJS7rPxKGreIj
	 uookSMP1Nf35C0CzhBHBPXl/NERj7AL0jYGvSSNhb5jGOZY6qAJ46ftyFREhF65lII
	 Sfr6lrQXE8Sq3N3jxFkdQQOhz/2df6h17ZDBYL88=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6EE9EA80C7B; Tue, 29 Aug 2023 11:57:26 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com,
	Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: execve: drop argument size limit
Date: Tue, 29 Aug 2023 11:57:26 +0200
Message-ID: <20230829095726.207922-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

Before commit 44f73c5a6206 ("Cygwin: Fix segfalt when too many command
line args are specified.") we had no actual argument size limit, except
for the fact that the child process created another copy of the argv
array on the stack, which could result in a stack overflow and a
subsequent SEGV.  Commit 44f73c5a6206 changed that by allocating the
additional argv array via malloc, and it introduced a new SC_ARG_MAX
limit along the lines of the typical Linux limit.

However, this new limit is artificial. Cygwin allocates all argument
and environment data on the cygheap.  We only run out of ARG_MAX space
if we're out of memory resources.

Change argument size handling accordingly:
- Drop the args size check from  child_info_spawn::worker.
- Return -1 from sysconf (SC_ARG_MAX), i. e., the argument size limit
  is undefined.
- Change argv handling in class av, so that a failing cmalloc is not
  fatal.  This allows the parent process to return E2BIG if it's out
  of cygheap resources.
- In the child, add a check around the new malloc call, so that it
  doesn't result in a SEGV if the child process gets unexpectedly into
  an ENOMEM situation at this point. In this (unlikely) case, proceed
  with the original __argv array instead.  Add comment to explain why.

Fixes: 44f73c5a6206 ("Cygwin: Fix segfalt when too many command line args are specified.")
Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/dcrt0.cc                | 18 +++++++++++++++---
 winsup/cygwin/kernel32.cc             |  7 +++++--
 winsup/cygwin/local_includes/winf.h   | 13 +++++++++----
 winsup/cygwin/local_includes/winsup.h |  4 ----
 winsup/cygwin/spawn.cc                | 18 ++++++++----------
 winsup/cygwin/sysconf.cc              |  2 +-
 6 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 1d8810546314..130d652aac6e 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -976,10 +976,22 @@ dll_crt0_1 (void *)
     {
       /* Create a copy of Cygwin's version of __argv so that, if the user makes
 	 a change to an element of argv[] it does not affect Cygwin's argv.
-	 Changing the the contents of what argv[n] points to will still
-	 affect Cygwin.  This is similar (but not exactly like) Linux. */
+	 Changing the contents of what argv[n] points to will still affect
+	 Cygwin.  This is similar (but not exactly like) Linux.
+
+	 We used to allocate newargv on the stack, but all the rest of the
+	 argument and environment handling does not depend on the stack,
+	 as it does on Linux.  In fact, everything is stored by the parent
+	 in the cygheap, so the only reason this may fail is if we're out
+	 of resources in a big way.  If this malloc fails, we could either
+	 fail the entire process execution, or we could proceed with the
+	 original argv and potentially affect output of /proc/self/cmdline.
+	 We opt for the latter here because it's the lesser evil. */
       char **newargv = (char **) malloc ((__argc + 1) * sizeof (char *));
-      memcpy (newargv, __argv, (__argc + 1) * sizeof (char *));
+      if (newargv)
+	memcpy (newargv, __argv, (__argc + 1) * sizeof (char *));
+      else
+	newargv = __argv;
       /* Handle any signals which may have arrived */
       sig_dispatch_pending (false);
       _my_tls.call_signal_handler ();
diff --git a/winsup/cygwin/kernel32.cc b/winsup/cygwin/kernel32.cc
index 6248aefd5183..36951f6a87be 100644
--- a/winsup/cygwin/kernel32.cc
+++ b/winsup/cygwin/kernel32.cc
@@ -424,8 +424,11 @@ ucmd ()
       linebuf cmd;
       path_conv real_path (__argv[0]);
       av newargv (__argc, __argv);
-      cmd.fromargv (newargv, real_path.get_win32 (), true);
-      RtlInitUnicodeString (&wcmd, cmd);
+      if (newargv.argc)
+	{
+	  cmd.fromargv (newargv, real_path.get_win32 (), true);
+	  RtlInitUnicodeString (&wcmd, cmd);
+	}
     }
   return &wcmd;
 }
diff --git a/winsup/cygwin/local_includes/winf.h b/winsup/cygwin/local_includes/winf.h
index 651f78ba2824..b58693441095 100644
--- a/winsup/cygwin/local_includes/winf.h
+++ b/winsup/cygwin/local_includes/winf.h
@@ -23,11 +23,16 @@ class av
  public:
   int argc;
   bool win16_exe;
-  av (): argv (NULL) {}
-  av (int ac_in, const char * const *av_in) : calloced (0), argc (ac_in), win16_exe (false)
+  av () : argv (NULL), argc (0) {}
+  av (int ac_in, const char * const *av_in)
+  : calloced (0), win16_exe (false)
   {
-    argv = (char **) cmalloc_abort (HEAP_1_ARGV, (argc + 5) * sizeof (char *));
-    memcpy (argv, av_in, (argc + 1) * sizeof (char *));
+    argv = (char **) cmalloc (HEAP_1_ARGV, (ac_in + 5) * sizeof (char *));
+    if (argv)
+      {
+	argc = ac_in;
+	memcpy (argv, av_in, (argc + 1) * sizeof (char *));
+      }
   }
   void *operator new (size_t, void *p) __attribute__ ((nothrow)) {return p;}
   ~av ()
diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
index 57bd38c9fffd..c9788de8f012 100644
--- a/winsup/cygwin/local_includes/winsup.h
+++ b/winsup/cygwin/local_includes/winsup.h
@@ -73,10 +73,6 @@ uint32_t cygwin_inet_addr (const char *cp);
    application provided path strings we handle. */
 #define NT_MAX_PATH 32768
 
-/* CYG_ARG_MAX is the maximum total length of command line args.
-   The value 2097152 is the default ARG_MAX value in Linux. */
-#define CYG_ARG_MAX 2097152
-
 /* This definition allows to define wide char strings using macros as
    parameters.  See the definition of __CONCAT in newlib's sys/cdefs.h
    and accompanying comment. */
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index c4f1167284be..dc1c4ac17c80 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -351,9 +351,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 We need to quote any argument that has whitespace or embedded "'s.  */
 
       int ac;
-      size_t arg_len = 0;
       for (ac = 0; argv[ac]; ac++)
-	arg_len += strlen (argv[ac]) + 1;
+	;
 
       int err;
       const char *ext;
@@ -522,12 +521,6 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  __leave;
 	}
       set (chtype, real_path.iscygexec ());
-      if (iscygwin () && arg_len > (size_t) sysconf (_SC_ARG_MAX))
-	{
-	  set_errno (E2BIG);
-	  res = -1;
-	  __leave;
-	}
       __stdin = in__stdin;
       __stdout = in__stdout;
       record_children ();
@@ -1130,11 +1123,16 @@ spawnvpe (int mode, const char *file, const char * const *argv,
 
 int
 av::setup (const char *prog_arg, path_conv& real_path, const char *ext,
-	   int argc, const char *const *argv, bool p_type_exec)
+	   int ac_in, const char *const *av_in, bool p_type_exec)
 {
   const char *p;
   bool exeext = ascii_strcasematch (ext, ".exe");
-  new (this) av (argc, argv);
+  new (this) av (ac_in, av_in);
+  if (!argc)
+    {
+      set_errno (E2BIG);
+      return -1;
+    }
   if ((exeext && real_path.iscygexec ()) || ascii_strcasematch (ext, ".bat")
       || (!*ext && ((p = ext - 4) > real_path.get_win32 ())
 	  && (ascii_strcasematch (p, ".bat") || ascii_strcasematch (p, ".cmd")
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 7cdfbdb9d403..6529731a51c1 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -485,7 +485,7 @@ static struct
     };
 } sca[] =
 {
-  {cons, {c:CYG_ARG_MAX}},		/*   0, _SC_ARG_MAX */
+  {cons, {c:-1L}},			/*   0, _SC_ARG_MAX */
   {cons, {c:CHILD_MAX}},		/*   1, _SC_CHILD_MAX */
   {cons, {c:CLOCKS_PER_SEC}},		/*   2, _SC_CLK_TCK */
   {cons, {c:NGROUPS_MAX}},		/*   3, _SC_NGROUPS_MAX */
-- 
2.41.0

