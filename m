Return-Path: <cygwin-patches-return-6941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9481 invoked by alias); 2 Feb 2010 01:06:46 -0000
Received: (qmail 9468 invoked by uid 22791); 2 Feb 2010 01:06:43 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-vw0-f43.google.com (HELO mail-vw0-f43.google.com) (209.85.212.43)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Feb 2010 01:06:38 +0000
Received: by vws18 with SMTP id 18so109183vws.2         for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2010 17:06:36 -0800 (PST)
Received: by 10.220.128.1 with SMTP id i1mr6827333vcs.23.1265072796142;         Mon, 01 Feb 2010 17:06:36 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 26sm64276757vws.4.2010.02.01.17.06.34         (version=SSLv3 cipher=RC4-MD5);         Mon, 01 Feb 2010 17:06:35 -0800 (PST)
Message-ID: <4B677EAA.9050304@gmail.com>
Date: Tue, 02 Feb 2010 01:06:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add some notes about process startup/shutdown.
Content-Type: multipart/mixed;  boundary="------------080602080705040807070905"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00057.txt.bz2

This is a multi-part message in MIME format.
--------------080602080705040807070905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 431



  Here's some notes I've been making; reckon they might come in handy for
anyone who wants to untangle some of this stuff in the future.  Attached the
whole file rather than gratuitously prefixing every line with a '+' to no
great effect! :)  There'll be another later, to explain how the cxx abi
interacts with all this.

winsup/cygwin/ChangeLog:

	* how-crt-and-initfini.txt: Add new document.

  OK?

    cheers,
      DaveK


--------------080602080705040807070905
Content-Type: text/plain;
 name="how-crt-and-initfini.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="how-crt-and-initfini.txt"
Content-length: 8060

Copyright 2010 Red Hat Inc., contributed by Dave Korn.


    How the C runtime handles startup and termination.
    --------------------------------------------------

This file documents the processes involved in starting up and shutting down
a Cygwin executable.  The responsibility is divided between code that is
statically linked into each Cygwin-based DLL or executable as part of the
C runtime, and code in the Cygwin DLL itself that co-operates with it.  The
runtime library code lives in the winsup/cygwin/lib directory, and a little
of it is in winsup/cygwin/include/cygwin/cygwin_dll.h



  Process overall startup sequence.
  =================================

Overall process startup (and indeed termination) is under the control of the
underlying Windows OS.  The details of the Win32 CreateProcess API and the
underlying NT Native API ZwCreateProcess calls are far more complex (and
unknown, since proprietary) than we need go into here; the important details
are that the process address space is first created, then an initial thread
is spawned that performs DLL initialisation, calling the DllMain functions of
all statically-linked DLLs in load order.  This thread is also serialised under
the Windows OS global loader lock, and DllMain functions are very limited in
what they can do as a consequence; to help deal with this, cygwin wraps the
user's DllMain function and defers calling it until runtime.  Once the DLLs
have been initialised, the initial thread then performs C runtime setup and
calls into the executable's main() function.


  Entry sequence for Cygwin-based DLLs.
  =====================================

In the compiler's LINK_SPEC, a -e option sets the entry point (what Windows
regards as DllMain) to __cygwin_dll_entry@12.  This is defined in
include/cygwin/cygwin_dll.h.  The user's DllMain function, if any, is called
from within this function - directly in the case of thread attach/detach
notifications and process detach, but indirectly at process attach time via
cygwin_attach_dll in lib/cygwin_attach_dll.c, which calls the CRT common code
_cygwin_crt0_common and then hands off to the Cygwin DLL at dll_dllcrt0.  The
CRT common code doesn't call the user DllMain at once; it caches a pointer to
it in the 'main' member of the DLL's per_process struct.


  __cygwin_dll_entry@12 -> cygwin_attach_dll -> (_cygwin_crt0_common) 
	-> dll_dllcrt0 -> (DllMain?maybe?)

dll_dllcrt0 is in dll_init.cc sets up exception handler, ensures cygwin DLL is
at least partially initialised, allocates a new entry for the DLL chain, and
either calls the 'main' function (via dll::init) before returning to the OS
loader, or defers doing so until dll_crt0_1 runs dlls.dll_list::init() during
the application's startup sequence, depending on whether Cygwin DLL was fully
initialised yet or not.  In general statically linked DLLs will defer, while
dlopen'd DLLs will run at once.  The Cygwin DLL runs the dependent DLL's ctors
immediately prior to making the call, whether immediate or deferred.


  Entry sequence for Cygwin-based executables.
  ============================================

The entry point is the windows standard entrypoint, WinMainCRTStartup, aliased
to mainCRTStartup, defined in crt0.c.  It aligns the stack, sets the x87 fpu
cw, and hands off to cygwin_crt0 in lib/cygwin_crt0.c, which calls the CRT
common init code in _cygwin_crt0_common and heads off into the DLL, never to
return from _dll_crt0.

  mainCRTStartup -> cygwin_crt0 -> (_cygwin_crt0_common) -> _dll_crt0
	-> dll_crt0_1 -> (n*DllMain?maybe?) -> main -> (__main) -> cygwin_exit

This is a wrapper that does some fork-related stack sorting out then hands off
to dll_crt0_1, which completes all Cygwin DLL initialisation, runs any
deferred DllMain calls, and jumps into the application, returning via the
termination routines.


  Post-entry construction.
  ========================

The compiler automatically inserts a hidden call to __main at the start of the
user's main() function.  During startup, DLL constructors are run in dll:init()
immediately prior to calling that DLL's DllMain function (not in a forkee,
though; once is enough).  In __main, all statically-loaded DLL ctors are now
complete, so we queue an atexit call to dll_global_dtors, then run the
application's ctors and queue an atexit call to do_global_dtors.



  Process overall termination sequence.
  =====================================

The program termination sequence can begin in one of the following ways:

- by returning from main()
- by calling exit(), _Exit() or _exit()
- by calling abort()
  (this can be implicit, such as when an unhandled C++ exception is thrown,
  or when an SEH exception is raised and not trapped, or an unhandled signal
  terminates the program).


  Unload sequence for Cygwin-based DLLS.
  ======================================

  _cygwin_dll_entry@12 -> (DllMain) -> cygwin_detach_dll -> dll_list::detach
	-> (remove_dll_atexit) -> (dll::run_dtors)

When a DLL is unloaded, whether as a result of dlclose() calling FreeLibrary(),
or when then entire process is terminating, the OS arranges to call the DLL's
DllMain function with a DLL_PROCESS_DETACH notification.  As during the entry
sequence, this is also wrapped by _cygwin_dll_entry(), although there is in
this case no need to defer calling the user's DllMain hook; it is called at
once.  If no error is indicated, the dll is then detached from Cygwin's
internal tracking list, and any atexit functions it has registered are run and
cancelled from the atexit list.  Finally any static destructors are run.


  Exit sequence for Cygwin-based executables.
  ============================================

This diagram illustrates the code paths, listed above, by which the main
executable can terminate:

   +-------------->-- exception handling --->----------------------------+
   |                                                                     |
   +-------------->--------- abort --------->--- stdio cleanup ----------+
   |                                                                     |
   +-------------->-- direct or via _Exit -->-------------------+        |
   |                                                            |        |
   +-------------->----------+                                  |        |
   |                         V                stdio cleanup,    V        V
 main -> dll_crt0_1 -> cygwin_exit -> exit -> atexit funcs -> _exit -> do_exit 
	-> pinfo::exit -> ExitProcess -> END.

Returning from main() transfers control back to dll_crt0_1(), which passes the
return value to cygwin_exit(); this is the same as calling exit(), which is
an export name alias for cygwin_exit() anyway.  cygwin_exit() calls the real
exit() function in newlib, which runs the atexit functions and shuts down
stdio before exiting via _exit(), which immediately passes the exit status
through to do_exit().  If exiting via abort(), stdio is cleaned up, but no
atexit functions are run.

All the termination sequences end up in do_exit(), which takes care of POSIXy
stuff like process group and child signalling, tty disconnection, etc.  This
finally passes control to pinfo::exit(), which takes care of indicating the
correct overall exit status and then gives control to the OS process shutdown
routine, ExitProcess().

During ExitProcess(), all the statically-linked DLLs in the application are
terminated, by calling their DllMain functions with the DLL_PROCESS_DETACH
notification.


  Static object destruction.
  ==========================

Static object destruction for any statically-linked DLLs, or any dlopen()ed
DLLs that have still not been dlclose()d by termination time, is handled in
dll_global_dtors().  As the description above makes clear, this relies on the
atexit functions being run, and so only takes place during a graceful exit,
and not in the case of termination via _exit(), _Exit(), abort() or through an
unhandled signal or exception.  The destructors are run before stdio has been
terminated, and in reverse of DLL load order.


--------------080602080705040807070905--
