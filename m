Return-Path: <cygwin-patches-return-4599-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7392 invoked by alias); 12 Mar 2004 02:05:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7383 invoked from network); 12 Mar 2004 02:05:26 -0000
Message-Id: <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 12 Mar 2004 02:05:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Signal mask handling
In-Reply-To: <20040312014310.GB5945@redhat.com>
References: <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net>
 <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
 <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
 <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1079075045==_"
X-SW-Source: 2004-q1/txt/msg00089.txt.bz2

--=====================_1079075045==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 2262

At 08:43 PM 3/11/2004 -0500, you wrote:
>On Thu, Mar 11, 2004 at 07:36:41PM -0500, Pierre A. Humblet wrote:
>>There was a problem: pause() calls handle_sigsuspend(), which overwrites
>>the oldmask set by _cygtls::interrupt_setup. It's all fixed, and I have
>>renamed newmask to deltamask in cygtls.h. I can send you a fresh patch 
>>(everything, against cvs) now, or wait until you apply yours.
>
>Go ahead and send the patch.
>
>Btw, I removed the setting of oldmask in _cygtls::fixup_after_fork after
>I searched for oldmask last night after seeing your patch.

OK, I had set oldmask again just for the fixup. I have just deleted
that line without retesting.

>>BTW I noticed that Posix and Cygwin diverge on sigpause.
>>
>>Posix:
>>int sigpause(int sig);
>>The sigpause() function removes sig from the calling process' signal
>>mask and suspends the calling process until a signal is received.  The
>>sigpause() function restores the process' signal mask to its original
>>state before returning.
>>
>>Cygwin
>>sigpause (int signal_mask)
>>{
>>  return handle_sigsuspend ((sigset_t) signal_mask);
>>}
>
>Sorry, but I don't see any divergence.  A reading of the above might
>seem to indicate that sigpause should return on the receipt of any
>signal but I notice that on linux (and one other UNIX that I tested this
>on) sigpause only returns on the receipt of a signal that has a handler
>associated with it.  This makes sigpause equivalent to sigsuspend,
>AFAICT.

What I find strange is that usually sig is an integer (1-32), not a mask.
Compare the two following lines are from the same Posix page
void (*sigset(int sig, void (*disp)(int)))(int);   <= clearly an integer
int sigpause(int sig);  <= a mask???

2004-02-11  Pierre Humblet <pierre.humblet@ieee.org>
	
	* cygtls.h (_cygtls::newmask): Delete member.
	(_cygtls::newmask): New member.
	* gendef (_sigdelayed): Replace the call to 
	set_process_mask by a call to set_process_mask_delta.
	* exceptions.cc (handle_sigsuspend): Do not filter tempmask.
	Or SIG_NONMASKABLE in deltamask as a flag.
	(_cygtls::interrupt_setup): Set deltamask only.
	(set_process_mask_delta): New function.
	(_cygtls::call_signal_handler): Replace the first call to 
	set_process_mask by a call to set_process_mask_delta.

--=====================_1079075045==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="signal.diff"
Content-length: 4474

Index: cygtls.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/cygtls.h,v
retrieving revision 1.19
diff -u -p -r1.19 cygtls.h
--- cygtls.h	9 Mar 2004 01:24:08 -0000	1.19
+++ cygtls.h	12 Mar 2004 01:48:21 -0000
@@ -96,7 +96,7 @@ struct _cygtls
   int saved_errno;
   int sa_flags;
   sigset_t oldmask;
-  sigset_t newmask;
+  sigset_t deltamask;
   HANDLE event;
   int *errno_addr;
   unsigned initialized;
Index: gendef
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/gendef,v
retrieving revision 1.15
diff -u -p -r1.15 gendef
--- gendef	9 Mar 2004 01:24:08 -0000	1.15
+++ gendef	12 Mar 2004 01:48:22 -0000
@@ -190,15 +190,13 @@ _sigdelayed:
 	movl	%fs:4,%ebx
 	incl	$tls::incyg(%ebx)
 	pushl	$tls::saved_errno(%ebx)	# saved errno
-3:	pushl	$tls::oldmask(%ebx)	# oldmask
+        call    _set_process_mask_delta
+        pushl   %eax                    # oldmask
 	pushl	$tls::sig(%ebx)		# signal argument
 	pushl	\$_sigreturn

 	call	_reset_signal_arrived\@0
 	pushl	$tls::func(%ebx)	# signal func
-	pushl	$tls::newmask(%ebx)	# newmask - eaten by set_process_mask
-
-	call	_set_process_mask\@4
 	cmpl	\$0,$tls::threadkill(%ebx)#pthread_kill signal?
 	jnz	4f			#yes.  Callee clears signal number
 	movl	\$0,$tls::sig(%ebx)	# zero the signal number as a
Index: exceptions.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.210
diff -u -p -r1.210 exceptions.cc
--- exceptions.cc	9 Mar 2004 01:24:08 -0000	1.210
+++ exceptions.cc	12 Mar 2004 01:48:24 -0000
@@ -594,8 +594,7 @@ handle_sigsuspend (sigset_t tempmask)
 {
   sigset_t oldmask =3D myself->getsigmask ();	// Remember for restoration

-  // Let signals we're interested in through.
-  set_signal_mask (tempmask &=3D ~SIG_NONMASKABLE, oldmask);
+  set_signal_mask (tempmask, oldmask);
   sigproc_printf ("oldmask %p, newmask %p", oldmask, tempmask);

   pthread_testcancel ();
@@ -605,8 +604,9 @@ handle_sigsuspend (sigset_t tempmask)

   /* A signal dispatch function will have been added to our stack and will
      be hit eventually.  Set the old mask to be restored when the signal
-     handler returns. */
+     handler returns and indicate its presence by modifying deltamask. */

+  _my_tls.deltamask |=3D SIG_NONMASKABLE;
   _my_tls.oldmask =3D oldmask;	// Will be restored by signal handler
   return -1;
 }
@@ -696,8 +696,7 @@ _cygtls::interrupt_setup (int sig, void
 			      struct sigaction& siga)
 {
   push ((__stack_t) sigdelayed, false);
-  oldmask =3D myself->getsigmask ();
-  newmask =3D oldmask | siga.sa_mask | SIGTOMASK (sig);
+  deltamask =3D (siga.sa_mask | SIGTOMASK (sig)) & ~SIG_NONMASKABLE;
   sa_flags =3D siga.sa_flags;
   func =3D (void (*) (int)) handler;
   saved_errno =3D -1;		// Flag: no errno to save
@@ -926,6 +925,27 @@ sighold (int sig)
   return 0;
 }

+/* Update the signal mask for this process
+   and return the old mask.
+   Called from sigdelayed */
+extern "C" sigset_t
+set_process_mask_delta ()
+{
+  mask_sync->acquire (INFINITE);
+  sigset_t newmask, oldmask;
+
+  if (_my_tls.deltamask & SIG_NONMASKABLE)
+    oldmask =3D _my_tls.oldmask; /* from handle_sigsuspend */
+  else
+    oldmask =3D myself->getsigmask ();
+  newmask =3D (oldmask | _my_tls.deltamask) & ~SIG_NONMASKABLE;
+  sigproc_printf ("oldmask %p, newmask %p, deltamask %p", oldmask, newmask,
+		  _my_tls.deltamask);
+  myself->setsigmask (newmask);
+  mask_sync->release ();
+  return oldmask;
+}
+
 /* Set the signal mask for this process.
    Note that some signals are unmaskable, as in UNIX.  */
 extern "C" void __stdcall
@@ -1178,9 +1198,8 @@ _cygtls::call_signal_handler ()

       (void) pop ();
       reset_signal_arrived ();
-      sigset_t this_oldmask =3D oldmask;
+      sigset_t this_oldmask =3D set_process_mask_delta ();
       int this_errno =3D saved_errno;
-      set_process_mask (newmask);
       incyg--;
       sig =3D 0;
       sigfunc (thissig);

--=====================_1079075045==_--
