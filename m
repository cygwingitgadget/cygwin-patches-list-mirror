Return-Path: <cygwin-patches-return-5655-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25075 invoked by alias); 26 Sep 2005 04:27:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25005 invoked by uid 22791); 26 Sep 2005 04:26:52 -0000
Received: from zipcon.net (HELO zipcon.net) (209.221.136.5)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Mon, 26 Sep 2005 04:26:52 +0000
Received: (qmail 8470 invoked from network); 25 Sep 2005 21:28:31 -0700
Received: from unknown (HELO efn.org) (209.221.136.30)
  by mail.zipcon.net with SMTP; 25 Sep 2005 21:28:31 -0700
Received: by efn.org (sSMTP sendmail emulation); Sun, 25 Sep 2005 21:26:54 -0700
Date: Mon, 26 Sep 2005 04:27:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: use 3-arg signal handlers when SA_SIGINFO flag is set
Message-ID: <20050926042653.GA6080@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q3/txt/msg00110.txt.bz2

I've done some but not a lot of testing with this patch.  In
particular, I'm not sure that the tls field infodata always is set for
all kinds of signals.

Given that cygwin doesn't even have a ucontext.h header,
I don't think sending the third parameter to signal handlers as
NULL is a bad thing; presumably any code that actually uses it
would fail to compile on cygwin.

In exceptions.cc handle_exceptions, si_sigval is being set to
various things that should be put in si_code instead (and
si_code is set to SI_KERNEL).  I haven't changed this yet, and
would appreciate someone else confirming that it should change
(or explaining why it shouldn't).

2005-08-01  Yitzchak Scott-Thoennes  <sthoenna@efn.org>

	* exceptions.cc (_cygtls::call_signal_handler): Call
	signal handler with extra siginfo_t * and void * parameters
	when SA_SIGINFO flag is set.
	* signal.cc (signal): Clear SA_SIGINFO flag.
	(sigqueue): Set SI_QUEUE code in siginfo_t struct.
	* sigproc.cc (signal_fixup_after_exec): Clear SA_SIGINFO
	flag when setting handler to SIG_DFL.

--- exceptions.cc.orig	2005-09-25 02:07:39.346110000 -0700
+++ exceptions.cc	2005-09-25 18:23:48.975100800 -0700
@@ -1245,6 +1245,7 @@ _cygtls::call_signal_handler ()
       this_sa_flags = sa_flags;
       int thissig = sig;
       void (*sigfunc) (int) = func;
+      siginfo_t thissi = infodata;
 
       pop ();
       reset_signal_arrived ();
@@ -1252,7 +1253,13 @@ _cygtls::call_signal_handler ()
       int this_errno = saved_errno;
       incyg--;
       sig = 0;
-      sigfunc (thissig);
+      if (this_sa_flags & SA_SIGINFO == 0) sigfunc (thissig);
+      else
+        {
+          void (*sigact) (int, siginfo_t *, void *) = (void (*) (int, siginfo_t *, void *)) func;
+          /* no ucontext_t information provided yet */
+          sigact (thissig, &thissi, NULL);
+        }
       incyg++;
       set_signal_mask (this_oldmask, myself->getsigmask ());
       if (this_errno >= 0)
--- signal.cc.orig	2005-09-25 02:09:35.673380000 -0700
+++ signal.cc	2005-09-25 21:02:55.582448000 -0700
@@ -63,6 +63,7 @@ signal (int sig, _sig_func_ptr func)
   /* SA_RESTART is set to maintain BSD compatible signal behaviour by default.
      This is also compatible with the behaviour of signal(2) in Linux. */
   global_sigs[sig].sa_flags |= SA_RESTART;
+  global_sigs[sig].sa_flags &= ~ SA_SIGINFO;
   set_sigcatchers (prev, func);
 
   syscall_printf ("%p = signal (%d, %p)", prev, sig, func);
@@ -535,7 +536,7 @@ sigqueue (pid_t pid, int sig, const unio
       return -1;
     }
   si.si_signo = sig;
-  si.si_code = SI_USER;
+  si.si_code = SI_QUEUE;
   si.si_pid = si.si_uid = si.si_errno = 0;
   si.si_value = value;
   return sig_send (dest, si);
--- sigproc.cc.orig	2005-09-25 02:09:39.739227000 -0700
+++ sigproc.cc	2005-09-25 18:07:23.888616000 -0700
@@ -120,7 +120,10 @@ signal_fixup_after_exec ()
     {
       global_sigs[i].sa_mask = 0;
       if (global_sigs[i].sa_handler != SIG_IGN)
-	global_sigs[i].sa_handler = SIG_DFL;
+	{
+	  global_sigs[i].sa_handler = SIG_DFL;
+	  global_sigs[i].sa_flags &= ~ SA_SIGINFO;
+	}
     }
 }
 
