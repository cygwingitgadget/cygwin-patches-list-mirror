Return-Path: <cygwin-patches-return-7268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16930 invoked by alias); 4 Apr 2011 16:45:18 -0000
Received: (qmail 16913 invoked by uid 22791); 4 Apr 2011 16:45:15 -0000
X-SWARE-Spam-Status: No, hits=1.1 required=5.0	tests=AWL,BAYES_00,TW_HW,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from anoid.noid.net (HELO anoid.noid.net) (74.95.194.161)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 16:45:09 +0000
Received: from 192.168.127.127	by mx.noid.net (GNU) id p34Gj9hI024160; Mon, 4 Apr 2011 09:45:09 -0700 (PDT)
X-Mini-Diatribe: To fix America:	1. Cut government in half	2. Wait thirty years	3. Repeat as necessary
Received: by scythe.noid.net (Postfix, from userid 0)	id 706E51ED78AF; Mon,  4 Apr 2011 09:45:09 -0700 (PDT)
From: Tor Perkins <cygwin@noid.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] tcsetpgrp fails unexpectedly
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
Message-Id: <20110404164509.706E51ED78AF@scythe.noid.net>
Date: Mon, 04 Apr 2011 16:45:00 -0000
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
X-SW-Source: 2011-q2/txt/msg00034.txt.bz2


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 4235



I think I've found two problems in fhandler_termios::bg_check():

  * Cygwin's tcsetpgrp function will return EIO when the process
    group for the calling process has no leader.

  * This appears to be caused by a leaderless process group being
    interpreted as an orphaned process group.

Please find a plain text file attachment that includes a changelog
entry and a patch.

Please find a plain text file attachment that includes a small Perl
script that can be used as a test case.

Rationale:
----------

When the first process in a pipeline exits but a second process
keeps running, the process group for this pipeline will no longer
have a leader.  This is what happens when my test script is run like
so:

  cat </dev/null | /usr/bin/perl /tmp/test_bg_check.pl

The leader ('cat') has exited by the time the test script invokes
tcsetpgrp.  The following snippet in fhandler_termios::bg_check gets
triggered when this happens:

  /* If the process group is no more ... */
  int pgid_gone = !pid_exists (myself->pgid);

  if (pgid_gone)
    goto setEIO;

Here we see that fhandler_termios::bg_check will not tolerate a
leaderless process group.

The comment indicates that the test is looking for a process group
that is "no more", however, the process group still exists and has a
process in it (the calling process); it just happens to not have a
leader at this time.

I've not been able to find any documentation that says a leaderless
process group is problematic in some way.  Also, the script runs
fine in pipeline mode on both Linux and OpenBSD.

POSIX does talk about returning EIO for tcsetattr when:

  The process group of the writing process is orphaned, and the
  writing process is not ignoring or blocking SIGTTOU.

But SIGTTOU is ignored in my test script, so the above should not
apply (and I'm not even calling tcsetattr).  Parenthetically, SunOS
will return EIO for tcsetpgrp under the circumstance described
above, so I think EIO as a possible return value for tcsetpgrp is
not a problem per se...

Also, a leaderless process group is not the same thing as an
orphaned process group, the latter being defined by POSIX as:

  A process group in which the parent of every member is either
  itself a member of the group or is not a member of the group's
  session.

Out of curiosity, I researched how the EIO test is handled in both
Linux and OpenBSD.  The approaches are quite different.  In Linux,
we see code that loops through the relevant pids to see if the
process group is orphaned (edited for readability):

  vi /usr/src/linux-2.6.32/drivers/char/tty_io.c +/is_current_pgrp_orphaned
  vi /usr/src/linux-2.6.32/kernel/exit.c         +/will_become_orphaned_pgrp

    static int
    will_become_orphaned_pgrp (struct pid *pgrp, struct task_struct *ignored_task)
    {
      struct task_struct *p;
      do_each_pid_task(pgrp, PIDTYPE_PGID, p) {
        if (task_pgrp(p->real_parent) != pgrp &&
            task_session(p->real_parent) == task_session(p))
          return 0;
      } while_each_pid_task(pgrp, PIDTYPE_PGID, p);
      return 1;
    }

In OpenBSD we see that it maintains a count of "qualified" jobs per
process group.  A qualified job is one with a parent in a different
process group of the same session.  The EIO test then becomes a
matter of looking for a zero qualified jobs count (also edited):

  vi /usr/src/sys/kern/kern_proc.c +/fixjobc
  vi /usr/src/sys/kern/tty.c       +/isbackground

    while (isbackground(pr, tp) &&
        (p->p_flag & P_PPWAIT) == 0 &&
        (p->p_sigignore & sigmask(SIGTTOU)) == 0 &&
        (p->p_sigmask & sigmask(SIGTTOU)) == 0) {
      if (pr->ps_pgrp->pg_jobc == 0)                  // <-- here
        return (EIO);
      pgsignal(pr->ps_pgrp, SIGTTOU, 1);
    } // continue on - allow the ioctl

Neither approach cares if a process group has a leader or not...

My patch adds a new function to test for orphaned process groups.
It also modifies the decision tree to take advantage of the new
function.  I think it will cause fhandler_termios::bg_check to be
more correct and hopefully not introduce any regressions.  It is, at
least, a fix for my test case...

Thanks for your consideration and thanks for such a wonderful system!

- Tor


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cygwin_bg_eio.diff"
Content-length: 3934


2011-03-28  Tor Perkins
  
  * fhandler_termios.cc (fhandler_termios::bg_check): Do not return EIO
  when a process group has no leader as this is allowed and does not imply
  an orphaned process group.  Add a test for orphaned process groups.

Index: cygwin/fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.78
diff -u -p -r1.78 fhandler_termios.cc
--- cygwin/fhandler_termios.cc	23 Oct 2010 18:07:08 -0000	1.78
+++ cygwin/fhandler_termios.cc	2 Apr 2011 23:20:49 -0000
@@ -111,6 +111,26 @@ fhandler_pty_master::tcgetpgrp ()
   return tc->pgid;
 }
 
+int
+tty_min::is_orphaned_process_group (int pgid)
+{
+  /* An orphaned process group is a process group in which the parent
+     of every member is either itself a member of the group or is not
+     a member of the group's session. */
+  winpids pids ((DWORD) PID_MAP_RW);
+  for (unsigned i = 0; i < pids.npids; i++)
+    {
+      _pinfo *p = pids[i];
+      if (!p->exists () || p->pgid != pgid)
+        continue;
+      pinfo ppid (p->ppid);
+      if (ppid->pgid != pgid &&
+          ppid->sid == myself->sid)
+        return 0;
+    }
+  return 1;
+}
+
 void
 tty_min::kill_pgrp (int sig)
 {
@@ -157,36 +177,41 @@ fhandler_termios::bg_check (int sig)
       return bg_eof;
     }
 
-  /* If the process group is no more or if process is ignoring or blocks 'sig',
-     return with error */
-  int pgid_gone = !pid_exists (myself->pgid);
+  /* Determine if process ignores or blocks 'sig' */
   int sigs_ignored =
     ((void *) global_sigs[sig].sa_handler == (void *) SIG_IGN) ||
     (_main_tls->sigmask & SIGTOMASK (sig));
 
-  if (pgid_gone)
-    goto setEIO;
-  else if (!sigs_ignored)
-    /* nothing */;
-  else if (sig == SIGTTOU)
-    return bg_ok;		/* Just allow the output */
-  else
-    goto setEIO;	/* This is an output error */
-
-  /* Don't raise a SIGTT* signal if we have already been interrupted
-     by another signal. */
-  if (WaitForSingleObject (signal_arrived, 0) != WAIT_OBJECT_0)
-    {
-      siginfo_t si = {0};
-      si.si_signo = sig;
-      si.si_code = SI_KERNEL;
-      kill_pgrp (myself->pgid, si);
-    }
-  return bg_signalled;
-
-setEIO:
-  set_errno (EIO);
-  return bg_error;
+  /* If the process is ignoring SIGTT*, then background IO is OK.  If
+     the process is not ignoring SIGTT*, then the sig is to be sent to
+     all processes in the process group (unless the process group of the
+     process is orphaned, in which case we return EIO). */
+  if ( sigs_ignored )
+    { 
+      return bg_ok;   /* Just allow the IO */
+    } 
+  else 
+    { 
+      if ( tc->is_orphaned_process_group (myself->pgid) )
+        {
+          termios_printf ("process group is orphaned");
+          set_errno (EIO);   /* This is an IO error */
+          return bg_error;
+        }
+      else
+        {
+          /* Don't raise a SIGTT* signal if we have already been
+             interrupted by another signal. */
+          if (WaitForSingleObject (signal_arrived, 0) != WAIT_OBJECT_0)
+            {
+              siginfo_t si = {0};
+              si.si_signo = sig;
+              si.si_code = SI_KERNEL;
+              kill_pgrp (myself->pgid, si);
+            }
+          return bg_signalled;
+        } 
+    } 
 }
 
 #define set_input_done(x) input_done = input_done || (x)
Index: cygwin/tty.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tty.h,v
retrieving revision 1.26
diff -u -p -r1.26 tty.h
--- cygwin/tty.h	19 Apr 2010 19:52:43 -0000	1.26
+++ cygwin/tty.h	2 Apr 2011 23:20:49 -0000
@@ -76,6 +76,7 @@ public:
   int getsid () {return sid;}
   void setsid (pid_t tsid) {sid = tsid;}
   void kill_pgrp (int sig);
+  int is_orphaned_process_group (int pgid);
   HWND gethwnd () {return hwnd;}
   void sethwnd (HWND wnd) {hwnd = wnd;}
 };

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test_bg_check.pl"
Content-length: 947

#!/usr/bin/perl
#
# Usage note:
#
#                    /usr/bin/perl /tmp/test_bg_check.pl # <-- no error
#   cat </dev/null | /usr/bin/perl /tmp/test_bg_check.pl # <--    error
#

$SIG{'TTOU'} = 'IGNORE';          # ignore SIGTTOU for tcsetpgrp

use POSIX qw(tcsetpgrp);          # bring in that system function

unless ( -t STDIN ) {             # if pipe, read input
  my @junk = <STDIN>;             # then close/redirect
  open(STDIN, "</dev/tty");       # 'cat' exits cleanly
}

unless ( $pid = fork ) {                 # child leads new pgrp
  setpgrp();                             # (does: setpgid(0,0))
  tcsetpgrp(fileno(*STDIN), getpgrp());  # then forwards itself
  exit;
}

waitpid($pid, 0);                 # parent waits, then forwards itself
tcsetpgrp(fileno(*STDIN), getpgrp()) || die "tcsetpgrp: EIO: $!";

$|++;                             # autoflush STDOUT
while ( sleep 1 ) { print "." }   # test job control (ctrl-z / fg)


--wac7ysb48OaltWcw--
