Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BEDA13858426; Wed, 10 Jan 2024 15:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BEDA13858426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1704900616;
	bh=AXvUDspR20YxGM+d8U5MYsoF+u2adZ9ywijLk/F/gng=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=hrFNxaoZ4YOAGqY41QhA9FBLnLHVrzQzV0DphnC4vD3gIavm0rp3VoVI0+A64vijy
	 D+rbaw7BM1j3QoG0sxHxWn4M9tdnocQX/g5oRkQDBFgbQRgzdSia8wNAYA6LFiCvxw
	 G3GPMEjWTDLdQYrsE1BaY7+pKmFF4UXYWU7/SdSo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 83523A80871; Wed, 10 Jan 2024 16:30:14 +0100 (CET)
Date: Wed, 10 Jan 2024 16:30:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: Make 'ulimit -c' control writing a coredump
Message-ID: <ZZ64BtnmZtmyRZYi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
 <20240110135705.557-2-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110135705.557-2-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 13:57, Jon Turney wrote:
> Factor out pre-formatting a command to be executed on a fatal signal,
> and use that for both error_start (if present in the CYGWIN env var) and
> for 'dumper'.
> 
> Factor out executing that command, so we can use it from try_to_debug()
> and when a fatal signal occurs.
> 
> On a fatal signal, invoke dumper to write a core dump, if the core file
> size limit is greater than 1MB. Otherwise, if that limit is greater than
> 0, write a .stackdump file, as previously.
> 
> Adjust and clarify the associated documentation.
> 
> Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
> write a .stackdump file, even when ulimit -c is zero. (Note that
> cygwin_dumpstack() is still idempotent, which is perhaps odd)

Given it's deprecated and not exposed in the headers, and given
we only still need the symbol for backward compat, how about making
this function a no-op instead?

> Also: Fix so that the error_start JIT debugger is now invoked, even when
> ulimit -c is zero.
> 
> Also: Fix uses of console_printf() inside exec_debugger(). It's output
> is written via the Windows console device, so needs to use Windows-style
> line endings.
> 
> Future work: Perhaps we should use the absolute path to dumper, rather
> than assuming it is in PATH, although circumstances in which cygwin1.dll
> can be loaded, but dumper isn't in the PATH are probably rare.

I'm not so sure about that.  It's pretty simple to get an absolute
path from the DLL path, so I would really make sure that the right
dumper is called.  Otherwise this sounds a little bit like a security
problem, if the current PATH may decide over the actual dumper.exe,
isn't it?

> Future work: truncate or remove the file written, if it exceeds the
> maximum size set by the ulimit.

Can't this be done by adding the max size as parameter to dumper?

> Future work: the language around using the words "fatal error" could
> probably be improved.  These are the "certain signals whose default
> action is to cause the process to terminate and produce a core dump
> file".
> ---
>  winsup/cygwin/environ.cc              |   1 +
>  winsup/cygwin/exceptions.cc           | 100 ++++++++++++++++++--------
>  winsup/cygwin/local_includes/winsup.h |   1 +
>  winsup/doc/cygwinenv.xml              |  25 +++++--
>  winsup/doc/new-features.xml           |   6 ++
>  winsup/doc/utils.xml                  |  43 +++++++----
>  6 files changed, 125 insertions(+), 51 deletions(-)
> 
> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> index 008854a07..dca5c5db0 100644
> --- a/winsup/cygwin/environ.cc
> +++ b/winsup/cygwin/environ.cc
> @@ -832,6 +832,7 @@ environ_init (char **envp, int envc)
>      out:
>        findenv_func = (char * (*)(const char*, int*)) my_findenv;
>        environ = envp;
> +      dumper_init ();

Sorry, but I don't quite understand why dumper_init is called so early
and unconditionally.  Why not create the command on the fly?

>        if (envp_passed_in)
>  	{
>  	  p = getenv ("CYGWIN");
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 642afb788..a71fd4fb0 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -52,6 +52,7 @@ details. */
>  #define DUMPSTACK_FRAME_LIMIT    32
>  
>  PWCHAR debugger_command;
> +PWCHAR dumper_command;
>  extern uint8_t _sigbe;
>  extern uint8_t _sigdelayed_end;
>  
> @@ -113,18 +114,16 @@ init_console_handler (bool install_handler)
>      system_printf ("SetConsoleCtrlHandler failed, %E");
>  }
>  
> -extern "C" void
> -error_start_init (const char *buf)
> +static void
> +command_prep (const char *buf, PWCHAR *command)
>  {
> -  if (!buf || !*buf)
> -    return;
> -  if (!debugger_command &&
> -      !(debugger_command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
> -					    * sizeof (WCHAR))))
> +  if (!*command &&
> +      !(*command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
> +				    * sizeof (WCHAR))))

Not your fault, but the length of this string must not exceed 32767 wide
chars, incuding the trailing \0 per
https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw
The only reason I can see for using these large arrays is to avoid
length checks.

We could get away with two static 64K pages for debugger_command and
dumper_command.  Or even with one if we just copy the required stuff
into the single debugger_command array when required.  That would also
drop the requirement for the extra allocation in initial_env().

> +extern "C" void
> +dumper_init(void)
             ^^^
             space
> +{
> +  command_prep("dumper", &dumper_command);
                ^^^
                space

> +}
> +
> +extern "C" void
> +error_start_init (const char *buf)
> +{
> +  if (!buf || !*buf)
> +    return;
> +
> +  command_prep(buf, &debugger_command);
                ^^^
                space
> +}
> +
>  void
>  cygwin_exception::open_stackdumpfile ()
>  {
> @@ -361,7 +375,7 @@ cygwin_exception::dumpstack ()
>  
>    __try
>      {
> -      if (already_dumped || cygheap->rlim_core == 0Ul)
> +      if (already_dumped)
>  	return;
>        already_dumped = true;
>        open_stackdumpfile ();
> @@ -454,20 +468,14 @@ cygwin_stackdump ()
>    exc.dumpstack ();
>  }
>  
> -extern "C" int
> -try_to_debug ()
> +static
> +int exec_prepared_command(PWCHAR command)
                           ^^^
                           space
>  {
> -  if (!debugger_command)
> +  if (!command)
>      return 0;
> -  debug_printf ("debugger_command '%W'", debugger_command);
> -  if (being_debugged ())
> -    {
> -      extern void break_here ();
> -      break_here ();
> -      return 0;
> -    }
> +  debug_printf ("debugger_command '%W'", command);
>  
> -  PWCHAR dbg_end = wcschr (debugger_command, L'\0');
> +  PWCHAR dbg_end = wcschr (command, L'\0');
>    __small_swprintf (dbg_end, L" %u", GetCurrentProcessId ());
>  
>    LONG prio = GetThreadPriority (GetCurrentThread ());
> @@ -509,11 +517,12 @@ try_to_debug ()
>      }
>    FreeEnvironmentStringsW (rawenv);
>  
> -  console_printf ("*** starting debugger for pid %u, tid %u\n",
> +  console_printf ("*** starting '%W' for pid %u, tid %u\r\n",
> +		  command,
>  		  cygwin_pid (GetCurrentProcessId ()), GetCurrentThreadId ());
>    BOOL dbg;
>    dbg = CreateProcessW (NULL,
> -			debugger_command,
> +			command,
>  			NULL,
>  			NULL,
>  			FALSE,
> @@ -527,11 +536,15 @@ try_to_debug ()
>       we can't wait here for the error_start process to exit, as if it's a
>       debugger, it might want to continue this thread.  So we busy wait until a
>       debugger attaches, which stops this process, after which it can decide if
> -     we continue or not. */
> +     we continue or not.
> +
> +     Note that this is still racy: if the error_start process does it's work too
> +     fast, we don't notice that it attached and get stuck here.
> +  */
>  
>    *dbg_end = L'\0';
>    if (!dbg)
> -    system_printf ("Failed to start debugger, %E");
> +    system_printf ("Failed to start, %E");
>    else
>      {
>        SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
> @@ -540,13 +553,29 @@ try_to_debug ()
>        Sleep (2000);
>      }
>  
> -  console_printf ("*** continuing pid %u from debugger call (%d)\n",
> -		  cygwin_pid (GetCurrentProcessId ()), dbg);
> +  console_printf ("*** continuing pid %u\r\n",
> +		  cygwin_pid (GetCurrentProcessId ()));
>  
>    SetThreadPriority (GetCurrentThread (), prio);
>    return dbg;
>  }
>  
> +extern "C" int
> +try_to_debug ()
> +{
> +  /* If already being debugged, break into the debugger (Note that this function
> +     can be called from places other than an exception) */
> +  if (being_debugged ())
> +    {
> +      extern void break_here ();
> +      break_here ();
> +      return 0;
> +    }
> +
> +  /* Otherwise, invoke the JIT debugger, if set */
> +  return exec_prepared_command(debugger_command);
                                ^^^
                                space
> +}
> +
>  /* myfault exception handler. */
>  EXCEPTION_DISPOSITION
>  exception::myfault (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
> @@ -1264,7 +1293,6 @@ signal_exit (int sig, siginfo_t *si, void *)
>    debug_printf ("exiting due to signal %d", sig);
>    exit_state = ES_SIGNAL_EXIT;
>  
> -  if (cygheap->rlim_core > 0UL)
>      switch (sig)
>        {
>        case SIGABRT:
> @@ -1277,9 +1305,23 @@ signal_exit (int sig, siginfo_t *si, void *)
>        case SIGTRAP:
>        case SIGXCPU:
>        case SIGXFSZ:
> -	sig |= 0x80;		/* Flag that we've "dumped core" */
>  	if (try_to_debug ())
>  	  break;
> +
> +	if (cygheap->rlim_core == 0Ul)
> +	  break;
> +
> +	sig |= 0x80; /* Set WCOREDUMP flag in exit code to show that we've "dumped core" */

While at it, we could introduce `#define __WCOREFLAG 0x80' to sys/wait.h
as on linux.  But that would be an extra patch.

> +
> +	/* If core dump size is >1MB, try to invoke dumper to write a
> +	   .core file */
> +	if (cygheap->rlim_core > 1024*1024)
> +	  {
> +	    if (exec_prepared_command(dumper_command))
                                    ^^^
                                    space
> +	      break;
> +	  }
> +
> +	/* Otherwise write a .stackdump */
>  	if (si->si_code != SI_USER && si->si_cyg)
>  	  {
>  	    cygwin_exception *exc = (cygwin_exception *) si->si_cyg;
> diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
> index bf0a0bcc3..5713155de 100644
> --- a/winsup/cygwin/local_includes/winsup.h
> +++ b/winsup/cygwin/local_includes/winsup.h
> @@ -179,6 +179,7 @@ void close_all_files (bool = false);
>  
>  /* debug_on_trap support. see exceptions.cc:try_to_debug() */
>  extern "C" void error_start_init (const char*);
> +extern "C" void dumper_init(void);
                             ^^^
                             space
>  extern "C" int try_to_debug ();
>  
>  void ld_preload ();
> diff --git a/winsup/doc/cygwinenv.xml b/winsup/doc/cygwinenv.xml
> index 5e17404a7..d97f2b77d 100644
> --- a/winsup/doc/cygwinenv.xml
> +++ b/winsup/doc/cygwinenv.xml
> @@ -23,18 +23,29 @@ Defaults to off.</para>
>  
>  <listitem>
>  <para>
> -<envar>error_start:Win32filepath</envar> - if set, runs 
> -<filename>Win32filepath</filename> when cygwin encounters a fatal error,
> -which is useful for debugging.  <filename>Win32filepath</filename> is
> -usually set to the path to <command>gdb</command> or
> -<command>dumper</command>, for example
> -<filename>C:\cygwin\bin\gdb.exe</filename>.
> -There is no default set.
> +<envar>error_start:Win32filepath</envar> - if set, runs
> +<filename>Win32filepath</filename> when cygwin encounters a fatal error, which
> +can be useful for debugging. Defaults to not set.
> +</para>
> +<para>
> +<filename>Win32filepath</filename> is typically set to <command>gdb</command> or
> +<command>dumper</command>.  If giving a path in
> +<filename>Win32filepath</filename>, note that it is a Windows-style path and not
> +a Cygwin path.
>  </para>
>  <para>
>  The filename of the executing program and it's Windows process id are appended
>  to the command as arguments.
>  </para>
> +<para>
> +  Note: This takes priority over writing core dump or .stackdump files, if
> +  enabled by <function>setrlimit(RLIMIT_CORE)</function> (e.g. via
> +  <command>ulimit -c</command>).
> +</para>
> +<para>
> +  Note: This has no effect if a debugger is already attached when the fatal
> +  error occurs.
> +</para>
>  </listitem>
>  
>  <listitem>
> diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
> index bd856525e..b6daadc2b 100644
> --- a/winsup/doc/new-features.xml
> +++ b/winsup/doc/new-features.xml
> @@ -93,6 +93,12 @@ Enable automatic sparsifying of files on SSDs, independent of the
>  "sparse" mount mode.
>  </para></listitem>
>  
> +<listitem><para>
> +When RLIMIT_CORE is more than 1MB, a core dump file which can be loaded by gdb
> +is now written on a fatal error. Otherwise, if it's greater than zero, a text
> +format .stackdump file is written, as previously.
> +</para></listitem>
> +
>  </itemizedlist>
>  
>  </sect2>
> diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
> index f79a928df..8261e7ebd 100644
> --- a/winsup/doc/utils.xml
> +++ b/winsup/doc/utils.xml
> @@ -721,17 +721,17 @@ explorer $XPATH &
>      <refsect1 id="dumper-desc">
>        <title>Description</title>
>      <para>The <command>dumper</command> utility can be used to create a core
> -      dump of running Windows process. This core dump can be later loaded to
> -      <command>gdb</command> and analyzed. One common way to use
> -      <command>dumper</command> is to plug it into cygwin's Just-In-Time
> -      debugging facility by adding
> -      <screen>
> -error_start=x:\path\to\dumper.exe
> -</screen> to the
> -      <emphasis>CYGWIN</emphasis> environment variable. Please note that
> -      <literal>x:\path\to\dumper.exe</literal> is Windows-style and not cygwin
> -      path. If <literal>error_start</literal> is set this way, then dumper will
> -      be started whenever some program encounters a fatal error. </para>
> +      dump of running Windows process. This core dump can be later loaded into
> +      <command>gdb</command> and analyzed.
> +    </para>
> +
> +    <para>
> +      If the core file size limit is set to unlimited (e.g. <command>ulimit -c
> +      unlimited</command>) and an <literal>error_start</literal> executable
> +      hasn't been configured in the <literal>CYGWIN</literal> environment
> +      variable, Cygwin will automatically run <command>dumper</command> when a
> +      fatal error occurs.
> +    </para>
>  
>      <para> <command>dumper</command> can be also be started from the command
>        line to create a core dump of any running process.</para>
> @@ -742,14 +742,25 @@ error_start=x:\path\to\dumper.exe
>      terminated.</para>
>  
>      <para> To save space in the core dump, <command>dumper</command> doesn't
> -      write those portions of the target process's memory space that are loaded
> +      write those portions of the target process's memory space that were loaded
>        from executable and dll files and are unchanged (e.g. program code).
>        Instead, <command>dumper</command> saves paths to the files which
>        contain that data. When a core dump is loaded into gdb, it uses these
>        paths to load the appropriate files. That means that if you create a core
>        dump on one machine and try to debug it on another, you'll need to place
>        identical copies of the executable and dlls in the same directories as on
> -      the machine where the core dump was created. </para>
> +      the machine where the core dump was created.
> +    </para>
> +  </refsect1>
> +
> +  <refsect1 id="dumper-notes">
> +    <title>Notes</title>
> +    <para>
> +      A Cygwin "core dump file" is an ELF file containing the mutable parts of
> +      the process memory and special note sections which capture the process,
> +      thread and loaded module context needed to recreate the process image in a
> +      debugger.
> +    </para>
>      </refsect1>
>    </refentry>
>  
> @@ -1497,8 +1508,10 @@ bash$ locale noexpr
>  
>    <para>
>      <command>minidumper</command> can be used with cygwin's Just-In-Time
> -    debugging facility in exactly the same way as <command>dumper</command>
> -    (See <xref linkend="dumper"></xref>).
> +    debugging facility by adding <code>error_start=minidumper</code> to the
> +    <literal>CYGWIN</literal> environment variable. If <literal>CYGWIN</literal>
> +    is set this way, then <command>minidumper</command> will be started whenever
> +    a program encounters a fatal exception.
>    </para>
>  
>    <para>
> -- 
> 2.42.1
