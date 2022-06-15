Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta13-sa.btinternet.com
 [213.120.69.19])
 by sourceware.org (Postfix) with ESMTPS id 5E0CD3857371
 for <cygwin-patches@cygwin.com>; Wed, 15 Jun 2022 11:21:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5E0CD3857371
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20220615112130.NMRC3230.sa-prd-fep-044.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Wed, 15 Jun 2022 12:21:30 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 613006A92AE0D44B
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedruddvuddgfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613006A92AE0D44B; Wed, 15 Jun 2022 12:21:30 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Make 'ulimit -c' control writing a coredump
Date: Wed, 15 Jun 2022 12:21:15 +0100
Message-Id: <20220615112115.21040-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 SPF_HELO_PASS, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 15 Jun 2022 11:21:34 -0000

Factor out pre-formatting a command to be executed on fatal signal, and
use that for both error_start (if present in the CYGWIN env var) and for
'dumper'.

Factor out executing that command, so we can use it from try_to_debug()
and when a fatal signal occurs.

Because we can't control the size of the core dump written by that, only
invoke dumper if the core file size limit is unlimited.

Otherwise, if that limit is greater than 0, we will write a .stackdump
file, as previously.

Change the default limit from unlimited to 1 MB, to preserve that
existing behaviour.

Adjust and clarify the associated documentation.

Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
write a .stackdump file, even when ulimit -c is zero.

(Note that cygwin_dumpstack() is still idempotent, which is perhaps odd)

Also: Fix so that the error_start JIT debugger is now invoked, even when
ulimit -c is zero.

Also: Fix uses of console_printf() inside exec_debugger(). It's output
is written via the Windows console device, so needs to use Windows-style
line endings.

Future work: Perhaps we should use the absolute path to dumper, rather
than assuming it is in PATH, although circumstances in which cygwin1.dll
can be loaded, but dumper isn't in the PATH are probably rare.
---
 winsup/cygwin/cygheap.cc    |   2 +-
 winsup/cygwin/environ.cc    |   1 +
 winsup/cygwin/exceptions.cc | 100 +++++++++++++++++++++++++-----------
 winsup/cygwin/winsup.h      |   1 +
 winsup/doc/cygwinenv.xml    |  22 +++++---
 winsup/doc/utils.xml        |  31 ++++++-----
 6 files changed, 107 insertions(+), 50 deletions(-)

diff --git a/winsup/cygwin/cygheap.cc b/winsup/cygwin/cygheap.cc
index e05bfbc48..bf560bccc 100644
--- a/winsup/cygwin/cygheap.cc
+++ b/winsup/cygwin/cygheap.cc
@@ -264,7 +264,7 @@ cygheap_init ()
       cygheap->locale.mbtowc = __utf8_mbtowc;
       /* Set umask to a sane default. */
       cygheap->umask = 022;
-      cygheap->rlim_core = RLIM_INFINITY;
+      cygheap->rlim_core = 1024 * 1024;
     }
   if (!cygheap->fdtab)
     cygheap->fdtab.init ();
diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index ab593ab64..2da9eadc3 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -843,6 +843,7 @@ environ_init (char **envp, int envc)
     out:
       findenv_func = (char * (*)(const char*, int*)) my_findenv;
       __cygwin_environ = envp;
+      dumper_init ();
       if (envp_passed_in)
 	{
 	  p = getenv ("CYGWIN");
diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index b8d46504d..b5df509b3 100644
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
+command_init (const char *buf, PWCHAR *command)
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
+  command_init("dumper", &dumper_command);
+}
+
+extern "C" void
+error_start_init (const char *buf)
+{
+  if (!buf || !*buf)
+    return;
+
+  command_init(buf, &debugger_command);
+}
+
 void
 cygwin_exception::open_stackdumpfile ()
 {
@@ -331,7 +345,7 @@ cygwin_exception::dumpstack ()
 
   __try
     {
-      if (already_dumped || cygheap->rlim_core == 0Ul)
+      if (already_dumped)
 	return;
       already_dumped = true;
       open_stackdumpfile ();
@@ -414,20 +428,14 @@ cygwin_stackdump ()
   exc.dumpstack ();
 }
 
-extern "C" int
-try_to_debug ()
+static
+int exec_debugger(PWCHAR command)
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
@@ -469,11 +477,12 @@ try_to_debug ()
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
@@ -487,11 +496,15 @@ try_to_debug ()
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
@@ -500,13 +513,29 @@ try_to_debug ()
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
+  return exec_debugger(debugger_command);
+}
+
 /* myfault exception handler. */
 EXCEPTION_DISPOSITION
 exception::myfault (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
@@ -1224,7 +1253,6 @@ signal_exit (int sig, siginfo_t *si, void *)
   debug_printf ("exiting due to signal %d", sig);
   exit_state = ES_SIGNAL_EXIT;
 
-  if (cygheap->rlim_core > 0UL)
     switch (sig)
       {
       case SIGABRT:
@@ -1237,9 +1265,23 @@ signal_exit (int sig, siginfo_t *si, void *)
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
+	sig |= 0x80; /* Set WCOREDUMP flag to show that we've "dumped core" */
+
+	/* If core dumper size is unlimited, try to invoke dumper to write a
+	   .core */
+	if (cygheap->rlim_core == RLIM_INFINITY)
+	  {
+	    if (exec_debugger(dumper_command))
+	      break;
+	  }
+
+	/* Otherwise write a .stackdump */
 	if (si->si_code != SI_USER && si->si_cyg)
 	  {
 	    cygwin_exception *exc = (cygwin_exception *) si->si_cyg;
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index 4147dcebf..24954f6cf 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -174,6 +174,7 @@ void close_all_files (bool = false);
 
 /* debug_on_trap support. see exceptions.cc:try_to_debug() */
 extern "C" void error_start_init (const char*);
+extern "C" void dumper_init(void);
 extern "C" int try_to_debug ();
 
 void ld_preload ();
diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
index 5e17404a7..21d945978 100644
--- a/winsup/doc/cygwinenv.xml
+++ b/winsup/doc/cygwinenv.xml
@@ -23,18 +23,26 @@ Defaults to off.</para>
 
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
+can be useful for debugging.  <filename>Win32filepath</filename> is typically set
+to <command>gdb</command> or <command>dumper</command>.  If giving a path in
+<filename>Win32filepath</filename>, note that it is a Windows-style path and not
+a Cygwin path.  There is no default set.
 </para>
 <para>
 The filename of the executing program and it's Windows process id are appended
 to the command as arguments.
 </para>
+<para>
+  Note: This takes priority over writing core dumps or .stackdump files, if
+  enabled by <function>setrlimit(RLIMIT_CORE)</function> (e.g. via
+  <command>ulimit -c</command>).
+</para>
+<para>
+  Note: This has no effect if a debugger is already attached when the fatal
+  error occurs.
+</para>
 </listitem>
 
 <listitem>
diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
index 895988037..d3923a83d 100644
--- a/winsup/doc/utils.xml
+++ b/winsup/doc/utils.xml
@@ -607,16 +607,16 @@ explorer $XPATH &
       <title>Description</title>
     <para>The <command>dumper</command> utility can be used to create a core
       dump of running Windows process. This core dump can be later loaded to
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
+      <command>gdb</command> and analyzed.
+    </para>
+
+    <para>
+      If the core file size limit is set to unlimited (e.g. <command>ulimit -c
+      unlimited</command>) and an <literal>error_start</literal> executable
+      hasn't been configured in the <literal>CYGWIN</literal> environment
+      variable, Cygwin will automatically run <command>dumper</command> when a
+      fatal exception occurs.
+    </para>
 
     <para> <command>dumper</command> can be also be started from the command
       line to create a core dump of any running process.</para>
@@ -1376,9 +1376,14 @@ bash$ locale noexpr
 
   <para>
     <command>minidumper</command> can be used with cygwin's Just-In-Time
-    debugging facility in exactly the same way as <command>dumper</command>
-    (See <xref linkend="dumper"></xref>).
-  </para>
+    debugging facility by adding
+      <screen>
+error_start=minidumper
+</screen>
+      to the <literal>CYGWIN</literal> environment variable. If
+      <literal>CYGWIN</literal> is set this way, then
+      <command>minidumper</command> will be started whenever a program
+      encounters a fatal exception.</para>
 
   <para>
     <command>minidumper</command> can also be started from the command line to
-- 
2.36.1

