Return-Path: <cygwin-patches-return-4105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28416 invoked by alias); 19 Aug 2003 00:18:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28395 invoked from network); 19 Aug 2003 00:18:22 -0000
Message-Id: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 19 Aug 2003 00:18:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Signal handling tune up.
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1061266656==_"
X-SW-Source: 2003-q3/txt/msg00121.txt.bz2

--=====================_1061266656==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 4929

During my work on using the multimedia timer for setitimer I noticed
that Cygwin was not optimized to handle 1000 signals per second.
It starts trashing under heavy load. Attached is a tune up patch.
It also modestly improves performances at light load and fixes a
race condition.
   
Some explanations are in order, here they are.

************
1)
Note the pattern of frames on the stack
  220 1565622 [sig] a 34108167 interruptible: pc 0x6100FCFB, h 0x61000000,
interruptible 0, testvalid 0
  227 1565849 [sig] a 34108167 interruptible: pc 0x61010700, h 0x61000000,
interruptible 0, testvalid 0
  222 1566071 [sig] a 34108167 interruptible: pc 0x610105E6, h 0x61000000,
interruptible 0, testvalid 0

<snip> <snip>   

  226 1576965 [sig] a 34108167 interruptible: pc 0x610105E6, h 0x61000000,
interruptible 0, testvalid 0
  221 1577186 [sig] a 34108167 interruptible: pc 0x6101070E, h 0x61000000,
interruptible 0, testvalid 0
 1840 1579026 [sig] a 34108167 interrupt_on_return: couldn't find a stack
frame, i 32

~: addr2line -e /bin/cygwin1.dll  -f 0x610105E6
call_signal_handler_now
/eroot/obj/i586-pc-cygwin/winsup/cygwin/../../../../src/winsup/cygwin/except
ions.cc:1188
~: addr2line -e /bin/cygwin1.dll  -f 0x6101070e
unused_sig_wrapper
/eroot/obj/i586-pc-cygwin/winsup/cygwin/../../../../src/winsup/cygwin/except
ions.cc:1221

What's happening is that when a signal handler terminates and another signal 
is pending (which is often the case in heavy load), Cygwin immediately
starts a 
new one, expanding the stack in the process. Scanning the stack takes time,
and
when the limit of 32 is reached drastic actions are taken.
Fixed with minor assembly changes  

*********************************************************************
2)
        movl    $0,%0                   # zero the signal number as a   \n\
                                        # flag to the signal handler thread\n\
                                        # that it is ok to set up sigsave\n\
                                                                        \n\
       call    _set_process_mask@4
There is a race where the sigthread can start a handler for a signal that
should be blocked.
Simply interchanging the order still allows the sigthread to try to launch 
a handler (before the mask is set), discovers that sigsave is busy and takes 
cumbersome actions (e.g. Sleep).
The patch moves set_process_mask all the way up to interrupt_setup(), so
it is set in the sigthread itself.

*********************************************************************
3)
Posix says "If a subsequent occurrence of a pending signal is generated,
it is implementation-defined as to whether the signal is delivered or 
accepted more than once [RTS]   in circumstances other than those in 
which queuing is required under the Realtime Signals Extension option".

Cygwin takes the "more than once" path and increments sigtodo without
bound. That's fine, except in the case of periodic exceptions that occur
faster than they can be processed. There they should better be ignored.
FWIW, that's a Posix requirement for timer_settime().

So, my (to come) implementation of setitimer examines sigtodo before 
generating an exception. To make this work I had to modify somewhat 
InterlockedDecrement/Decrement (myself->getsigtodo (sig)) to make sure
that it always has the correct value.

**********************************************************************
4) 
What to do when an interrupt cannot be delivered has been modified to
minimize delays. This went together with fixing (?) FIXMEs in 
setup_handler () and wait_sig(). See the saw_failed_interrupt stuff.


There are also some minor and more obvious changes. 

**********************************************************************
5) 
This is just an observation, about sig_handle (int sig, bool thisproc)
The thisproc argument is set to "rc != 2" in the sigthread. However
it is possible for several signals to occur simultaneously and a
signal can be processed with rc == 2 even when generated by the 
current process (or conversely). This could cause a SIGINT to be 
ignored (or not) when it shouldn't (something like that was discussed
on the list recently).
I don't fully understand the use of thisproc and have no suggestion. 

 
Fortunately the ChangeLog is much shorter than the explanations above.


2003-08-18  Pierre Humblet <pierre.humblet@ieee.org>

	* exceptions.cc (interrupt_setup): Decrement sigtodo and set the mask.
	(set_process_mask): Don't signal sigthread if old mask is more permissive.
	(sig_handle): Return -1 when no handler function is called.
	(unused_sig_wrapper): In sigreturn, handle the eventual new signal 
	without growing the stack. In sigdelayed, do not call set_process_mask.
	* sigproc.cc (sig_send): Set pending_signals.
	(sig_set_pending): Delete.
	(wait_sig): Change the way of changing sigtodo and of handling failed
	interrupts. Modify some sigproc_printf().
--=====================_1061266656==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="signal.diff"
Content-length: 8197

Index: exceptions.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.151
diff -u -p -r1.151 exceptions.cc
--- exceptions.cc	26 Jul 2003 04:53:59 -0000	1.151
+++ exceptions.cc	18 Aug 2003 23:56:49 -0000
@@ -703,6 +703,8 @@ interrupt_setup (int sig, void *handler,
     }
   /* Clear any waiting threads prior to dispatching to handler function */
   proc_subproc (PROC_CLEARWAIT, 1);
+  set_process_mask (sigsave.newmask);
+  InterlockedDecrement (myself->getsigtodo (sig));
   int res =3D SetEvent (signal_arrived);	// For an EINTR case
   sigproc_printf ("armed signal_arrived %p, res %d", signal_arrived, res);
 }
@@ -903,10 +905,6 @@ setup_handler (int sig, void *handler, s
     }
   else
     {
-      pending_signals =3D 1;	/* FIXME: Probably need to be more tricky her=
e */
-      sig_set_pending (sig);
-      sig_dispatch_pending (1);
-      low_priority_sleep (SLEEP_0_STAY_LOW);	/* Hopefully, other process w=
ill be waking up soon. */
       sigproc_printf ("couldn't send signal %d", sig);
     }

@@ -990,7 +988,7 @@ set_process_mask (sigset_t newmask)
   sigproc_printf ("old mask =3D %x, new mask =3D %x", myself->getsigmask (=
), newmask);
   myself->setsigmask (newmask);	// Set a new mask
   mask_sync->release ();
-  if (oldmask !=3D newmask && GetCurrentThreadId () !=3D sigtid)
+  if (((oldmask ^ newmask) & oldmask) && GetCurrentThreadId () !=3D sigtid)
     sig_dispatch_pending ();
   else
     sigproc_printf ("not calling sig_dispatch_pending.  sigtid %p current =
%p",
@@ -1001,7 +999,7 @@ set_process_mask (sigset_t newmask)
 int __stdcall
 sig_handle (int sig, bool thisproc)
 {
-  int rc =3D 0;
+  int rc =3D -1;

   sigproc_printf ("signal %d", sig);

@@ -1221,7 +1219,8 @@ unused_sig_wrapper ()
 {
 /* Signal cleanup stuff.  Cleans up stack (too bad that we didn't
    prototype signal handlers as __stdcall), calls _set_process_mask
-   to restore any mask, restores any potentially clobbered registers
+   to restore any mask. If a new signal occurs after mask restoral,
+   handles it. Otherwise restores any potentially clobbered registers
    and returns to original caller. */
 __asm__ volatile ("\n\
 	.text								\n\
@@ -1233,8 +1232,11 @@ _sigreturn:								\n\
 									\n\
 	cmpl	$0,%4		# Did a signal come in?			\n\
 	jz	1f		# No, if zero				\n\
-	call	_call_signal_handler_now@0 # yes handle the signal	\n\
-									\n\
+	movl    %2,%%eax						\n\
+	movl	%%eax,4(%%ebp)	# Restore return address		\n\
+	subl	$32,%%ebp						\n\
+	movl	%%ebp,%%esp						\n\
+	jmp	3f							\n\
 1:	popl	%%eax		# saved errno				\n\
 	testl	%%eax,%%eax	# Is it < 0				\n\
 	jl	2f		# yup.  ignore it			\n\
@@ -1264,24 +1266,22 @@ _sigdelayed0:								\n\
 	pushl	%%ebx							\n\
 	pushl	%%eax							\n\
 	pushl	%6			# saved errno			\n\
+3:									\n\
 	pushl	%3			# oldmask			\n\
 	pushl	%4			# signal argument		\n\
 	pushl	$_sigreturn						\n\
 									\n\
 	call	_reset_signal_arrived@0					\n\
-	pushl	%5			# signal number			\n\
-	pushl	%7			# newmask			\n\
+	pushl	%5			# signal handler		\n\
 	movl	$0,%0			# zero the signal number as a	\n\
 					# flag to the signal handler thread\n\
 					# that it is ok to set up sigsave\n\
-									\n\
-	call	_set_process_mask@4					\n\
 	popl	%%eax							\n\
 	jmp	*%%eax							\n\
 __no_sig_end:								\n\
 " : "=3Dm" (sigsave.sig):  "X" ((char *) &_impure_ptr->_errno),
   "g" (sigsave.retaddr), "g" (sigsave.oldmask), "g" (sigsave.sig),
-    "g" (sigsave.func), "g" (sigsave.saved_errno), "g" (sigsave.newmask)
+    "g" (sigsave.func), "g" (sigsave.saved_errno)
 );
 }
 }
Index: sigproc.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.137
diff -u -p -r1.137 sigproc.cc
--- sigproc.cc	16 Jun 2003 03:24:12 -0000	1.137
+++ sigproc.cc	18 Aug 2003 23:56:51 -0000
@@ -706,6 +706,11 @@ sig_send (_pinfo *p, int sig, DWORD ebp,
    */
   (void) InterlockedIncrement (p->getsigtodo (sig));

+  /* Force other threads to serialize in sig_dispatch_pending.
+   */
+  if (its_me)
+    pending_signals =3D 1;
+
   /* Notify the process that a signal has arrived.
    */
   SetLastError (0);
@@ -786,15 +791,6 @@ out:
   return rc;
 }

-/* Set pending signal from the sigtodo array
- */
-void __stdcall
-sig_set_pending (int sig)
-{
-  (void) InterlockedIncrement (myself->getsigtodo (sig));
-  return;
-}
-
 /* Initialize the wait_subproc thread.
  * Called from fork() or spawn() to initialize the handling of subprocesse=
s.
  */
@@ -1102,12 +1098,23 @@ wait_sig (VOID *self)
   sigtid =3D GetCurrentThreadId ();

   HANDLE catchem[] =3D {sigcatch_main, sigcatch_nonmain, sigcatch_nosync};
+  bool saw_failed_interrupt =3D false;
   sigproc_printf ("Ready.  dwProcessid %d", myself->dwProcessId);
   for (;;)
     {
       DWORD rc =3D WaitForMultipleObjects (3, catchem, FALSE, sig_loop_wai=
t);
-      (void) SetThreadPriority (GetCurrentThread (), WAIT_SIG_PRIORITY);

+      if (saw_failed_interrupt)
+        {
+	  /* Give a chance and retry.
+	     If rc is from sigcatch_main the main thread is probably running */
+	  if (rc > WAIT_OBJECT_0 && rc < WAIT_OBJECT_0 + MAXIMUM_WAIT_OBJECTS)=09=
=20
+	    low_priority_sleep (SLEEP_0_STAY_LOW); /* Hopefully, other process wi=
ll be waking up soon. */
+	  saw_failed_interrupt =3D false;
+	}
+
+      (void) SetThreadPriority (GetCurrentThread (), WAIT_SIG_PRIORITY);
+
       /* sigproc_terminate sets sig_loop_wait to zero to indicate that
        * this thread should terminate.
        */
@@ -1127,16 +1134,17 @@ wait_sig (VOID *self)
 	}

       rc -=3D WAIT_OBJECT_0;
-      sigproc_printf ("awake");
+      sigproc_printf ("awake %d", rc);
       /* A sigcatch semaphore has been signaled.  Scan the sigtodo
        * array looking for any unprocessed signals.
        */
       pending_signals =3D -1;
       int saw_pending_signals =3D 0;
       int saw_sigchld =3D 0;
+
       for (int sig =3D -__SIGOFFSET; sig < NSIG; sig++)
 	{
-	  while (InterlockedDecrement (myself->getsigtodo (sig)) >=3D 0)
+          while (*myself->getsigtodo (sig) > 0) /* No interlock needed */
 	    {
 	      if (sig =3D=3D SIGCHLD)
 		saw_sigchld =3D 1;
@@ -1146,12 +1154,13 @@ wait_sig (VOID *self)
 		   main_vfork->pid ||
 		   (sig !=3D SIGCONT && ISSTATE (myself, PID_STOPPED))))
 		{
+		  saw_pending_signals =3D 1;
 		  sigproc_printf ("signal %d blocked", sig);
 		  break;
 		}

 	      /* Found a signal to process */
-	      sigproc_printf ("processing signal %d", sig);
+	      sigproc_printf ("processing signal %d %d", sig, *myself->getsigtodo=
 (sig));
 	      switch (sig)
 		{
 		case __SIGFLUSH:
@@ -1170,23 +1179,26 @@ wait_sig (VOID *self)
 		/* A normal UNIX signal */
 		default:
 		  sigproc_printf ("Got signal %d", sig);
-		  sig_handle (sig, rc !=3D 2);
-		  /* Need to decrement again to offset increment below since
-		     we really do want to decrement in this case. */
-		  InterlockedDecrement (myself->getsigtodo (sig));
-		  goto nextsig;		/* FIXME: shouldn't this allow the loop to continue? */
+		  int res =3D sig_handle (sig, rc !=3D 2);
+		  if (res > 0) /* Success with handler. Decrement done. */
+		    continue;
+		  else if (res =3D=3D 0) /* Cannot launch handler */
+		    {
+		      /* Signal sigcatch_nosync to insure that we loop */
+		      ReleaseSemaphore (sigcatch_nosync, 1, NULL);
+		      saw_failed_interrupt =3D true;
+		      goto quit_loop;
+		    }
+		  /* else SIG_IGN, SIG_DFL, ... */
 		}
+	      InterlockedDecrement (myself->getsigtodo (sig));
 	    }
-
-	nextsig:
-	  /* Decremented too far. */
-	  if (InterlockedIncrement (myself->getsigtodo (sig)) > 0)
-	    saw_pending_signals =3D 1;
 	}

       if (pending_signals < 0 && !saw_pending_signals)
 	pending_signals =3D 0;

+    quit_loop:
       if (saw_sigchld)
 	proc_subproc (PROC_CLEARWAIT, 0);


--=====================_1061266656==_--
