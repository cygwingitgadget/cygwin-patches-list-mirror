Return-Path: <SRS0=FkOy=IU=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-042.btinternet.com (mailomta5-sa.btinternet.com [213.120.69.11])
	by sourceware.org (Postfix) with ESMTPS id 1B5193858C52
	for <cygwin-patches@cygwin.com>; Wed, 10 Jan 2024 13:57:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1B5193858C52
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1B5193858C52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1704895052; cv=none;
	b=BqNhdqUmW7yc48H+7K4qmbVO1o1JqPq2N0iXNybNVQzYeErvxcKkRmoqyu6adHLNHtRXNoJq7ZBp2xSt29YmHx12KiXDy1pXwdh+F6dckjjH1R6PJ70WfnMPFUSbFTgRHrXIfjq/oVuOwvk7Y1YA6RA+mI/H1AWFMj0a8zuUgXM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1704895052; c=relaxed/simple;
	bh=lk23pxfZLDuqaD6VB7D/9KScH9xI7CFORYkDNlLI4No=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rubeRMxDMl+xtABc+CXI/dF1QKXoe/3zQGHEHn645uO2UdvrE7wsj5eVmpV4/6vidwFblbs00tA7JrZVJ380yMWli4a0lpNOFV4A2Q2sbwnBxtiWwX8mC7N+xyDcCxGKfNitZRT6DkTeoSs1TWGzwJq2kqY+v9Vf8fiBofoks+A=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20240110135727.ECNR20040.sa-prd-fep-042.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 10 Jan 2024 13:57:27 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6567D008058195FB
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtgho
	mhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D008058195FB; Wed, 10 Jan 2024 13:57:27 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: Make 'ulimit -c' control writing a coredump
Date: Wed, 10 Jan 2024 13:57:03 +0000
Message-ID: <20240110135705.557-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240110135705.557-1-jon.turney@dronecode.org.uk>
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Factor out pre-formatting a command to be executed on a fatal signal,
and use that for both error_start (if present in the CYGWIN env var) and
for 'dumper'.

Factor out executing that command, so we can use it from try_to_debug()
and when a fatal signal occurs.

On a fatal signal, invoke dumper to write a core dump, if the core file
size limit is greater than 1MB. Otherwise, if that limit is greater than
0, write a .stackdump file, as previously.

Adjust and clarify the associated documentation.

Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
write a .stackdump file, even when ulimit -c is zero. (Note that
cygwin_dumpstack() is still idempotent, which is perhaps odd)

Also: Fix so that the error_start JIT debugger is now invoked, even when
ulimit -c is zero.

Also: Fix uses of console_printf() inside exec_debugger(). It's output
is written via the Windows console device, so needs to use Windows-style
line endings.

Future work: Perhaps we should use the absolute path to dumper, rather
than assuming it is in PATH, although circumstances in which cygwin1.dll
can be loaded, but dumper isn't in the PATH are probably rare.

Future work: truncate or remove the file written, if it exceeds the
maximum size set by the ulimit.

Future work: the language around using the words "fatal error" could
probably be improved.  These are the "certain signals whose default
action is to cause the process to terminate and produce a core dump
file".
---
 winsup/cygwin/environ.cc              |   1 +
 winsup/cygwin/exceptions.cc           | 100 ++++++++++++++++++--------
 winsup/cygwin/local_includes/winsup.h |   1 +
 winsup/doc/cygwinenv.xml              |  25 +++++--
 winsup/doc/new-features.xml           |   6 ++
 winsup/doc/utils.xml                  |  43 +++++++----
 6 files changed, 125 insertions(+), 51 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index 008854a07..dca5c5db0 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -832,6 +832,7 @@ environ_init (char **envp, int envc)
     out:
       findenv_func = (char * (*)(const char*, int*)) my_findenv;
       environ = envp;
+      dumper_init ();
       if (envp_passed_in)
 	{
 	  p = getenv ("CYGWIN");
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 642afb788..a71fd4fb0 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -52,6 +52,7 @@ details. */
 #define DUMPSTACK_FRAME_LIMIT    32
 
 PWCHAR debugger_command;
+PWCHAR dumper_command;
 extern uint8_t _sigbe;
 extern uint8_t _sigdelayed_end;
 
@@ -113,18 +114,16 @@ init_console_handler (bool install_handler)
     system_printf ("SetConsoleCtrlHandler failed, %E");
 }
 
-extern "C" void
-error_start_init (const char *buf)
+static void
+command_prep (const char *buf, PWCHAR *command)
 {
-  if (!buf || !*buf)
-    return;
-  if (!debugger_command &&
-      !(debugger_command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
-					    * sizeof (WCHAR))))
+  if (!*command &&
+      !(*command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
+				    * sizeof (WCHAR))))
     return;
 
-  PWCHAR cp = debugger_command
-	      + sys_mbstowcs (debugger_command, NT_MAX_PATH, buf) - 1;
+  PWCHAR cp = *command
+	      + sys_mbstowcs (*command, NT_MAX_PATH, buf) - 1;
   cp = wcpcpy (cp, L" \"");
   wcpcpy (cp, global_progname);
   for (PWCHAR p = wcschr (cp, L'\\'); p; p = wcschr (p, L'\\'))
@@ -132,6 +131,21 @@ error_start_init (const char *buf)
   wcscat (cp, L"\"");
 }
 
+extern "C" void
+dumper_init(void)
+{
+  command_prep("dumper", &dumper_command);
+}
+
+extern "C" void
+error_start_init (const char *buf)
+{
+  if (!buf || !*buf)
+    return;
+
+  command_prep(buf, &debugger_command);
+}
+
 void
 cygwin_exception::open_stackdumpfile ()
 {
@@ -361,7 +375,7 @@ cygwin_exception::dumpstack ()
 
   __try
     {
-      if (already_dumped || cygheap->rlim_core == 0Ul)
+      if (already_dumped)
 	return;
       already_dumped = true;
       open_stackdumpfile ();
@@ -454,20 +468,14 @@ cygwin_stackdump ()
   exc.dumpstack ();
 }
 
-extern "C" int
-try_to_debug ()
+static
+int exec_prepared_command(PWCHAR command)
 {
-  if (!debugger_command)
+  if (!command)
     return 0;
-  debug_printf ("debugger_command '%W'", debugger_command);
-  if (being_debugged ())
-    {
-      extern void break_here ();
-      break_here ();
-      return 0;
-    }
+  debug_printf ("debugger_command '%W'", command);
 
-  PWCHAR dbg_end = wcschr (debugger_command, L'\0');
+  PWCHAR dbg_end = wcschr (command, L'\0');
   __small_swprintf (dbg_end, L" %u", GetCurrentProcessId ());
 
   LONG prio = GetThreadPriority (GetCurrentThread ());
@@ -509,11 +517,12 @@ try_to_debug ()
     }
   FreeEnvironmentStringsW (rawenv);
 
-  console_printf ("*** starting debugger for pid %u, tid %u\n",
+  console_printf ("*** starting '%W' for pid %u, tid %u\r\n",
+		  command,
 		  cygwin_pid (GetCurrentProcessId ()), GetCurrentThreadId ());
   BOOL dbg;
   dbg = CreateProcessW (NULL,
-			debugger_command,
+			command,
 			NULL,
 			NULL,
 			FALSE,
@@ -527,11 +536,15 @@ try_to_debug ()
      we can't wait here for the error_start process to exit, as if it's a
      debugger, it might want to continue this thread.  So we busy wait until a
      debugger attaches, which stops this process, after which it can decide if
-     we continue or not. */
+     we continue or not.
+
+     Note that this is still racy: if the error_start process does it's work too
+     fast, we don't notice that it attached and get stuck here.
+  */
 
   *dbg_end = L'\0';
   if (!dbg)
-    system_printf ("Failed to start debugger, %E");
+    system_printf ("Failed to start, %E");
   else
     {
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
@@ -540,13 +553,29 @@ try_to_debug ()
       Sleep (2000);
     }
 
-  console_printf ("*** continuing pid %u from debugger call (%d)\n",
-		  cygwin_pid (GetCurrentProcessId ()), dbg);
+  console_printf ("*** continuing pid %u\r\n",
+		  cygwin_pid (GetCurrentProcessId ()));
 
   SetThreadPriority (GetCurrentThread (), prio);
   return dbg;
 }
 
+extern "C" int
+try_to_debug ()
+{
+  /* If already being debugged, break into the debugger (Note that this function
+     can be called from places other than an exception) */
+  if (being_debugged ())
+    {
+      extern void break_here ();
+      break_here ();
+      return 0;
+    }
+
+  /* Otherwise, invoke the JIT debugger, if set */
+  return exec_prepared_command(debugger_command);
+}
+
 /* myfault exception handler. */
 EXCEPTION_DISPOSITION
 exception::myfault (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
@@ -1264,7 +1293,6 @@ signal_exit (int sig, siginfo_t *si, void *)
   debug_printf ("exiting due to signal %d", sig);
   exit_state = ES_SIGNAL_EXIT;
 
-  if (cygheap->rlim_core > 0UL)
     switch (sig)
       {
       case SIGABRT:
@@ -1277,9 +1305,23 @@ signal_exit (int sig, siginfo_t *si, void *)
       case SIGTRAP:
       case SIGXCPU:
       case SIGXFSZ:
-	sig |= 0x80;		/* Flag that we've "dumped core" */
 	if (try_to_debug ())
 	  break;
+
+	if (cygheap->rlim_core == 0Ul)
+	  break;
+
+	sig |= 0x80; /* Set WCOREDUMP flag in exit code to show that we've "dumped core" */
+
+	/* If core dump size is >1MB, try to invoke dumper to write a
+	   .core file */
+	if (cygheap->rlim_core > 1024*1024)
+	  {
+	    if (exec_prepared_command(dumper_command))
+	      break;
+	  }
+
+	/* Otherwise write a .stackdump */
 	if (si->si_code != SI_USER && si->si_cyg)
 	  {
 	    cygwin_exception *exc = (cygwin_exception *) si->si_cyg;
diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
index bf0a0bcc3..5713155de 100644
--- a/winsup/cygwin/local_includes/winsup.h
+++ b/winsup/cygwin/local_includes/winsup.h
@@ -179,6 +179,7 @@ void close_all_files (bool = false);
 
 /* debug_on_trap support. see exceptions.cc:try_to_debug() */
 extern "C" void error_start_init (const char*);
+extern "C" void dumper_init(void);
 extern "C" int try_to_debug ();
 
 void ld_preload ();
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index 5e17404a7..d97f2b77d 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -23,18 +23,29 @@ Defaults to off.</para>
 
 <listitem>
 <para>
-<envar>error_start:Win32filepath</envar> - if set, runs 
-<filename>Win32filepath</filename> when cygwin encounters a fatal error,
-which is useful for debugging.  <filename>Win32filepath</filename> is
-usually set to the path to <command>gdb</command> or
-<command>dumper</command>, for example
-<filename>C:\cygwin\bin\gdb.exe</filename>.
-There is no default set.
+<envar>error_start:Win32filepath</envar> - if set, runs
+<filename>Win32filepath</filename> when cygwin encounters a fatal error, which
+can be useful for debugging. Defaults to not set.
+</para>
+<para>
+<filename>Win32filepath</filename> is typically set to <command>gdb</command> or
+<command>dumper</command>.  If giving a path in
+<filename>Win32filepath</filename>, note that it is a Windows-style path and not
+a Cygwin path.
 </para>
 <para>
 The filename of the executing program and it's Windows process id are appended
 to the command as arguments.
 </para>
+<para>
+  Note: This takes priority over writing core dump or .stackdump files, if
+  enabled by <function>setrlimit(RLIMIT_CORE)</function> (e.g. via
+  <command>ulimit -c</command>).
+</para>
+<para>
+  Note: This has no effect if a debugger is already attached when the fatal
+  error occurs.
+</para>
 </listitem>
 
 <listitem>
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index bd856525e..b6daadc2b 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -93,6 +93,12 @@ Enable automatic sparsifying of files on SSDs, independent of the
 "sparse" mount mode.
 </para></listitem>
 
+<listitem><para>
+When RLIMIT_CORE is more than 1MB, a core dump file which can be loaded by gdb
+is now written on a fatal error. Otherwise, if it's greater than zero, a text
+format .stackdump file is written, as previously.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index f79a928df..8261e7ebd 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -721,17 +721,17 @@ explorer $XPATH &
     <refsect1 id="dumper-desc">
       <title>Description</title>
     <para>The <command>dumper</command> utility can be used to create a core
-      dump of running Windows process. This core dump can be later loaded to
-      <command>gdb</command> and analyzed. One common way to use
-      <command>dumper</command> is to plug it into cygwin's Just-In-Time
-      debugging facility by adding
-      <screen>
-error_start=x:\path\to\dumper.exe
-</screen> to the
-      <emphasis>CYGWIN</emphasis> environment variable. Please note that
-      <literal>x:\path\to\dumper.exe</literal> is Windows-style and not cygwin
-      path. If <literal>error_start</literal> is set this way, then dumper will
-      be started whenever some program encounters a fatal error. </para>
+      dump of running Windows process. This core dump can be later loaded into
+      <command>gdb</command> and analyzed.
+    </para>
+
+    <para>
+      If the core file size limit is set to unlimited (e.g. <command>ulimit -c
+      unlimited</command>) and an <literal>error_start</literal> executable
+      hasn't been configured in the <literal>CYGWIN</literal> environment
+      variable, Cygwin will automatically run <command>dumper</command> when a
+      fatal error occurs.
+    </para>
 
     <para> <command>dumper</command> can be also be started from the command
       line to create a core dump of any running process.</para>
@@ -742,14 +742,25 @@ error_start=x:\path\to\dumper.exe
     terminated.</para>
 
     <para> To save space in the core dump, <command>dumper</command> doesn't
-      write those portions of the target process's memory space that are loaded
+      write those portions of the target process's memory space that were loaded
       from executable and dll files and are unchanged (e.g. program code).
       Instead, <command>dumper</command> saves paths to the files which
       contain that data. When a core dump is loaded into gdb, it uses these
       paths to load the appropriate files. That means that if you create a core
       dump on one machine and try to debug it on another, you'll need to place
       identical copies of the executable and dlls in the same directories as on
-      the machine where the core dump was created. </para>
+      the machine where the core dump was created.
+    </para>
+  </refsect1>
+
+  <refsect1 id="dumper-notes">
+    <title>Notes</title>
+    <para>
+      A Cygwin "core dump file" is an ELF file containing the mutable parts of
+      the process memory and special note sections which capture the process,
+      thread and loaded module context needed to recreate the process image in a
+      debugger.
+    </para>
     </refsect1>
   </refentry>
 
@@ -1497,8 +1508,10 @@ bash$ locale noexpr
 
   <para>
     <command>minidumper</command> can be used with cygwin's Just-In-Time
-    debugging facility in exactly the same way as <command>dumper</command>
-    (See <xref linkend="dumper"></xref>).
+    debugging facility by adding <code>error_start=minidumper</code> to the
+    <literal>CYGWIN</literal> environment variable. If <literal>CYGWIN</literal>
+    is set this way, then <command>minidumper</command> will be started whenever
+    a program encounters a fatal exception.
   </para>
 
   <para>
-- 
2.42.1

