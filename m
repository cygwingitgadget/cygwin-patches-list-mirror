Return-Path: <cygwin-patches-return-4593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32682 invoked by alias); 11 Mar 2004 04:27:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32669 invoked from network); 11 Mar 2004 04:27:40 -0000
Message-Id: <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 11 Mar 2004 04:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch] Signal mask handling
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q1/txt/msg00083.txt.bz2

I had a look at the signal handling code and noticed that the race 
discussed last summer in
<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00132.html>
is basically still there, as far as I can tell.

It was described at the time as:
"Handler is running with current mask M1, old mask M0
 New signal occurs, sigthread prepares sigsave with new mask M2, old mask M1
  but is preempted before setting sigsave.sig
 Handler terminates, restores M0
 sigthread resumes and starts new handler. It runs with M2 and restores
 M1 (instead of M0) at end."

This can cause interrupts masked in M1 to never be processed, but I have
no indication that it's happening with any frequency, or not.
At any rate here is a quick fix. It guarantees that a signal handler will
always restore the mask that existed when it started, because the handler
itself reads the old mask and not the sig thread.
If it's accepted I'll do some more cleanup.

Pierre

2004-02-11  Pierre Humblet <pierre.humblet@ieee.org>
	
	* gendef (_sigdelayed): Replace the call to 
	set_process_mask by a call to set_process_mask_delta.
	* exceptions.cc (_cygtls::interrupt_setup): Set oldmask
	to the delta and don't set newmask.
	(set_process_mask_delta): New function.
	(_cygtls::call_signal_handler): Replace the first call to 
	set_process_mask by a call to set_process_mask_delta.



Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.210
diff -u -p -r1.210 exceptions.cc
--- exceptions.cc       9 Mar 2004 01:24:08 -0000       1.210
+++ exceptions.cc       11 Mar 2004 03:45:32 -0000
@@ -696,8 +696,9 @@ _cygtls::interrupt_setup (int sig, void 
                              struct sigaction& siga)
 {
   push ((__stack_t) sigdelayed, false);
-  oldmask = myself->getsigmask ();
-  newmask = oldmask | siga.sa_mask | SIGTOMASK (sig);
+//  oldmask = myself->getsigmask ();
+  oldmask = siga.sa_mask | SIGTOMASK (sig);
+//  newmask = oldmask | siga.sa_mask | SIGTOMASK (sig);
   sa_flags = siga.sa_flags;
   func = (void (*) (int)) handler;
   saved_errno = -1;            // Flag: no errno to save
@@ -926,6 +927,22 @@ sighold (int sig)
   return 0;
 }
 
+/* Update the signal mask for this process
+   and return the old mask.
+   Called from sigdelayed */
+extern "C" sigset_t __stdcall
+set_process_mask_delta (sigset_t deltamask)
+{
+  mask_sync->acquire (INFINITE);
+  sigset_t newmask, oldmask = myself->getsigmask ();
+  newmask = (oldmask | deltamask) & ~SIG_NONMASKABLE;
+  sigproc_printf ("oldmask %p, newmask %p, deltamask %p", oldmask, newmask,
+                 deltamask);
+  myself->setsigmask (newmask);
+  mask_sync->release ();
+  return oldmask;
+}
+
 /* Set the signal mask for this process.
    Note that some signals are unmaskable, as in UNIX.  */
 extern "C" void __stdcall
@@ -1178,9 +1195,10 @@ _cygtls::call_signal_handler ()
 
       (void) pop ();
       reset_signal_arrived ();
-      sigset_t this_oldmask = oldmask;
+//      sigset_t this_oldmask = oldmask;
+      sigset_t this_oldmask = set_process_mask_delta (oldmask); /*
deltamask */
       int this_errno = saved_errno;
-      set_process_mask (newmask);
+//      set_process_mask (newmask);
       incyg--;
       sig = 0;
       sigfunc (thissig);
Index: gendef
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/gendef,v
retrieving revision 1.15
diff -u -p -r1.15 gendef
--- gendef      9 Mar 2004 01:24:08 -0000       1.15
+++ gendef      11 Mar 2004 03:50:58 -0000
@@ -190,15 +190,17 @@ _sigdelayed:
        movl    %fs:4,%ebx
        incl    $tls::incyg(%ebx)
        pushl   $tls::saved_errno(%ebx) # saved errno
-3:     pushl   $tls::oldmask(%ebx)     # oldmask
+3:     pushl   $tls::oldmask(%ebx)     # oldmask (deltamask)
+        call    _set_process_mask_delta\@4
+        pushl   %eax                    # oldmask 
        pushl   $tls::sig(%ebx)         # signal argument
        pushl   \$_sigreturn
 
        call    _reset_signal_arrived\@0
        pushl   $tls::func(%ebx)        # signal func
-       pushl   $tls::newmask(%ebx)     # newmask - eaten by set_process_mask
+#      pushl   $tls::newmask(%ebx)     # newmask - eaten by set_process_mask
 
-       call    _set_process_mask\@4
+#      call    _set_process_mask\@4
        cmpl    \$0,$tls::threadkill(%ebx)#pthread_kill signal?
        jnz     4f                      #yes.  Callee clears signal number
        movl    \$0,$tls::sig(%ebx)     # zero the signal number as a





